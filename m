Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA89C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB3520818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F63UKfcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfBVGfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:35:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41692 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfBVGfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:35:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id e27so881029lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 22:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=64zXYeniqW5AgQ62IBF0UDgBFQpBwV+0JSnwymBG1QU=;
        b=F63UKfcGQ76U8TPNGeETDHIBq3MHZLJlG8pD8djU4ldUcgqOCnTIj3hl14HPI2XLcn
         0YYXhWByPg4ev9z5Y69sIUG6R3vuwaZHA7mNjpKcsZlqOQtjqoSfbNa5znKmEKI7trin
         6XBuOmjPR2m5UE0nGSzLksvUAVgIFoh/ak8apifhflPTsgilMPxlNqzARjWAz1PwA8ia
         cbFWwf3kzLiWTQVTPk+OrCGSrqwtOqxnU1QFlIXhP6ofesi6zkCP6E0K1Cp9jyPeq6n+
         pdeqGAPsyYFlIefjwfPpzBvniDECAzXf0Rjh1o7y9AidPyyFEpoO4WrPx9zsewtCx96h
         gl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=64zXYeniqW5AgQ62IBF0UDgBFQpBwV+0JSnwymBG1QU=;
        b=Y5nOB0mVusxp0fuQK3X+oJEKivAUQOiMCZPnjIr08UX/qouhNSKd6XtgPClVGTK8Cr
         PfBH1EjoKifWynL8+tedKBHCFgQf1TOj+XelfF6e+eO9kRr2mR4XFycfEPa23JUa3Qaa
         8Vcsnn80XFVjMgfKA+itUNZT1MX0C9fnXJ+E5xBrqgQQGQCycvLZCRThg0mazsmceM6+
         jFH5eHc+pLtXc6tMq3HMWr1LAgQy516hz5XRtq8OC9WTGh76dDZqcS45JbYtlP0++JmQ
         pzljTDkdALglg7m3X0nzdbxHlWOIZ6EkZQqdJzkmgm7MKW7AikdnaJIvjh9/LGD6NRs7
         v5uw==
X-Gm-Message-State: AHQUAubWyt2dpoaskyvrGanHWMO3MlP3Qh1cvPGjBHII1ygBWfYNsUPr
        QCSBuZj7CZ1pHnMnqvEdoSHdIDQmclWiE7+KQERyvQ==
X-Google-Smtp-Source: AHgI3IYkcWdALpGNQ9ACbn9f/pAJZdw0eWuav33amRkDshQRwqtfumJT+V5NQpIOE0dsy8PwXf/DBFTlanfLAY97lmg=
X-Received: by 2002:a19:f619:: with SMTP id x25mr1333739lfe.57.1550817307974;
 Thu, 21 Feb 2019 22:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20190221125246.162644302@linuxfoundation.org>
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Feb 2019 12:04:56 +0530
Message-ID: <CA+G9fYtTi_WSeB=9wrp1xBi5tvtYwUx5LSz4SA1jFYiDgxe15Q@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/23] 4.14.103-stable review
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

On Thu, 21 Feb 2019 at 20:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.103 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Feb 23 12:52:22 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.103-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.103-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: af53455a989e57e0676f0bec9799a90b3b71b76a
git describe: v4.14.102-24-gaf53455a989e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.102-24-gaf53455a989e


No regressions (compared to build v4.14.102)


No fixes (compared to build v4.14.102)

Ran 22434 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
