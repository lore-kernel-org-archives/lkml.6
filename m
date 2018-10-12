Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62312C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B3520645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CER8N97w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B3520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJLMDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:03:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJLMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:03:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so10204788lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 21:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oj2LeJ3/ezuZtuOCjtUKiE6cQ/XSlEInvdB4O3v1v/k=;
        b=CER8N97wKAdKJSXbk6aSs/BakfqI1G7FEQEWO60OaSwvglRTTA2acqZKLSPtndvcyv
         fAxc6D1omfuwWEvJwhqR9pgsuIAZVBqQWaaqij6cRZEYO9Ic44451rkzjFqqOQQfBtYF
         F6gMgG4E8TgjvAYUyzIsQKU0YTM+k3QlOkfjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oj2LeJ3/ezuZtuOCjtUKiE6cQ/XSlEInvdB4O3v1v/k=;
        b=ZBHbKS5cEV6EMWfEOXmdgQsEkKqcKjbf3i6CpVmOi/GQoC59bZLJMVy0Xaf74YvdLG
         Oay5C5nV6TByAa+xqMQ9KX1ZjD5ZgGbGD3YXxAvPQ+lLSfFhlaH7JnaN4SZrqppgo8g8
         E2xMDnh+A4WpCStO4GJ3sZQ50Z077WLrmNhocL2IXyybxj0mde97MCJ9uLe+qH3RnXAk
         8nM/Bl3XK2EM2MwHboXCrpFUyAYFlB67vuejnrWb8+rhI5cP25Bgk1OMm460ICuAi+PC
         ZEvq+8RQZ5cMSqE5pemRkFoROwGG98G9YvLl1cuoZe2XCOlMlQwpmDHspM8jYjyj+Z4A
         mPbA==
X-Gm-Message-State: ABuFfojNBqTmn3Y60w6mlPCtyQp+2093DJz48d+CKa0ejyQ+c3nrz8ek
        7qM2tdHtBpSXMe9GWeN33imZPn1k+Q0rGweQWq6vOA==
X-Google-Smtp-Source: ACcGV62Qyp+EH1zp92MPvlX4PoYlcgkgPdB68MMDoKM8eWuXZ2p4QDO6iNraxHetwZYnp1oB+y/du2W0evbXd6fOHmE=
X-Received: by 2002:a2e:2bd5:: with SMTP id r82-v6mr2844601ljr.63.1539318802473;
 Thu, 11 Oct 2018 21:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181011152520.174949126@linuxfoundation.org>
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 12 Oct 2018 10:03:11 +0530
Message-ID: <CA+G9fYvmB0tPea=x_zH1_0cZwbUG7NaCZE9M9-6hiDJJETBPHg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/35] 4.9.133-stable review
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

On Thu, 11 Oct 2018 at 21:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.133 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Oct 13 15:25:09 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.133-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.133-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: c26947f9eb18b1c3de2b4d76a981b0b468b390f2
git describe: v4.9.132-36-gc26947f9eb18
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.132-36-gc26947f9eb18


No regressions (compared to build v4.9.132)


Ran 20946 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
