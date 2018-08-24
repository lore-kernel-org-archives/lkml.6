Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99449C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3BF2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gt2rC8GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3BF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHXJba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 05:31:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37098 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeHXJb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 05:31:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so5968729ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 22:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uf5GObobVPiMiPg5mRSIf8U+yJAS/0A5s+UrOc/55Tk=;
        b=gt2rC8GSPtittOQoS/R7gg/pgChMog1Y5ryvPuQy+y0FrjCUPID1Vk9sQYwr48zWKK
         cTvAVZKgYfNU0QDbBSzBurZuqM6yUA8eS5wZUTnYm2UU+/ugpi/ktP2jgErEHy8HkAVd
         LQv6PNxFPohUVLeau+3A1B33TcZMZchDQzzas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uf5GObobVPiMiPg5mRSIf8U+yJAS/0A5s+UrOc/55Tk=;
        b=LgOspg4wM7ZktIkrZpKvnD4CQZmKqqkrHSGtXG6dbwvVhfIgtf7Otsenwcd1tk0iRU
         kZ4tPEYfiLC99YAdkd7NO8v2JSiH6HPZOx0ejgURjR6MW1YRjJVDzDFVxdEsYyQ1kWHt
         XtntNN3qvKJMLFsj6qvHIoXZww4issEHh1r9+ieAmndYbyefgXq2/SZdVYK5KtPvbdNp
         TjrYHaSfZ0R0OlE3bXgCE7py9W/x0ss0CropJl7f2EQZUkTTeQEQxu7TS5jq8BhCMP+j
         mjy7g/4Hh5ogDkzMVt7NB1tju0o8Ko9EqxeA5hjpDN0nZ2jLcVj4JBU9Rxtb7Fj56Hg0
         vIiw==
X-Gm-Message-State: APzg51BNJvZ5D7vLaVJGhVxLoBzs2an9lzc+VaUeXLledH/05ivVU3BP
        0kevSx8PBia9m1OjXIEElnEv2/uxUf/tvfORpcfAdg==
X-Google-Smtp-Source: ANB0Vdb11RaBjMPyaL/YZkz/qKI8z6+D1wjmXC2T2ANNST+QI6wq/N0jTS8ULQwNnQ0xRPjvI+NaxDTDEyeq7TSupoQ=
X-Received: by 2002:a2e:650e:: with SMTP id z14-v6mr202246ljb.62.1535090302873;
 Thu, 23 Aug 2018 22:58:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 22:58:22
 -0700 (PDT)
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Aug 2018 11:28:22 +0530
Message-ID: <CA+G9fYtf7kOguDkUovBmadLKSh1Xfpy+t4uJpJTxh6ucxWe=1g@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/79] 4.4.152-stable review
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

On 23 August 2018 at 13:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.152 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Aug 25 07:48:51 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.152-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.152-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: b0685275fcd9a52007eb89b86e3bf155300de986
git describe: v4.4.151-79-gb0685275fcd9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.151-79-gb0685275fcd9


No regressions (compared to build v4.4.150)


Ran 9361 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
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
* ltp-fs_bind-tests

Summary
------------------------------------------------------------------------

kernel: 4.4.152-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.152-rc1-hikey-20180823-268
git commit: 986fb599d866b6dd9ac53fa1db463d8e6c691e2c
git describe: 4.4.152-rc1-hikey-20180823-268
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.152-rc1-hikey-20180823-268

No regressions (compared to build 4.4.151-rc1-hikey-20180821-263)


Ran 1374 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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
