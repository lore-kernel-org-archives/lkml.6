Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFCDECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741C82150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV7Bd22m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741C82150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbeIRWaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:30:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39748 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRWaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:30:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so2416891lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tevfYTx90HgcFhmbMBjUvV94WwNdFZmyNBEL7mQjdaI=;
        b=YV7Bd22mj36+/BTntU5pcKds3x5Met4NXQ2NVsAa7uq0kPjbdc2Z7VvfD7CKWATbwV
         RFtUdV7ZntHtcRdDNr1JiBpQVIBJQZWD9GMuCeYUjbbebxC+/yAVau7wfHidaqGCDyOS
         6zh5QYJRtrcVj1d4wa3nxuYZ/z2zKX71bAlf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tevfYTx90HgcFhmbMBjUvV94WwNdFZmyNBEL7mQjdaI=;
        b=kukcQYXdvHm6/2fcqsGw+b+ZTuXiRYtZ3sRL9HYsvtZHy3a5KmM/kLUWNUkJaVwD9T
         aGdARjK904Xy9ADYIQtQQARFPbCnFqMEm2cTj8Hrj5Wd5O3SQzFJgUOUFW52HJYXkfEF
         UWoFDGUWJ48/KJL4QkFfNs3s5e6bDplunl0bTtKE+dZvaOKZBp3VSFpNrbluqUKAMuRw
         rNQ03C3BV1wX14fApYk0MG3XNMg71/gOiaRkRKrnkkUUHdFuxrLTZt3grYGwI0xfp2VJ
         xLxfPffzTW6WAeoXG/CKMkgMRDTiwToqEDMEyzhQTww/G1aBcxR4QpMPvMqvsJxwYruC
         04lQ==
X-Gm-Message-State: APzg51DLOusUtZHw0IRq2EzD5rgmS7ePLk5LrSOeKZIonAxmtVk064UM
        a1KR6myAilWC4uFejKdZnxsqy2kRB+SplVo/FxQxfEKPZXY=
X-Google-Smtp-Source: ANB0VdY9VMdFryhk6jZOg/WxGyxrA4dXhtQdjJY6g8/dpgNCOTIeIxC3RxXdTWTTtNggp3hSI6yj+eu3tMlr1Wj6Dk8=
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr19983434ljh.18.1537289800988;
 Tue, 18 Sep 2018 09:56:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 09:56:40
 -0700 (PDT)
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Sep 2018 22:26:40 +0530
Message-ID: <CA+G9fYtzuZD-C=PUP=MsbDYG5yE_Wes6vRQEETCi9c2TtXTFGw@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/56] 4.4.157-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 September 2018 at 04:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.157 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Sep 19 21:38:11 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.157-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.157-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: c6780d0efad79b62e1debac77f1caab39d097b6c
git describe: v4.4.156-57-gc6780d0efad7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.156-57-gc6780d0efad7

No regressions (compared to build v4.4.156)


Ran 16924 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.157-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.157-rc1-hikey-20180917-287
git commit: 11e5496fbd0464e4de19065ab8c388115fa8c20b
git describe: 4.4.157-rc1-hikey-20180917-287
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.157-rc1-hikey-20180917-287


No regressions (compared to build 4.4.157-rc1-hikey-20180917-286)


Ran 2725 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests

--=20
Linaro LKFT
https://lkft.linaro.org
