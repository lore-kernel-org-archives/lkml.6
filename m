Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBABC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7D82070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dB3TaBEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBVPF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:05:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35930 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfBVPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:05:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id q11so1964248lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 07:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QP78/l1BzDS2VwujQMBZCU4dCdHxLvfx71aaQ5GKHr8=;
        b=dB3TaBEqJk41QcOGT9uR+2vpqtU+6Idsn5yy99xTYe79cXhywVpWe6dJRM+HGLyBXo
         L03/eMWr+xflYD4uSDIik1stjUul+n5PP4daPIlOGcEFgWFkz8WeCNKORXQNw5IkbXBn
         4P6NJpQ8oN+FHUzWUitAa1VxNepFeNfYmbHVnKdqJ8OIT/aegSCrElq8cwoJ71sYY6z1
         yuJ5BnIE4pzszW8keOV1wCoRhQe2ua5cse9mYwoskU3bJkmiK/vbfg1pyOU9JxpqiGBZ
         dEm9rDu82yyhKvX2fJofQD/6bLjS4ibOPSaS0YaOH3aFGNI8nLjtnib0fehOC2AjJK1R
         M8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QP78/l1BzDS2VwujQMBZCU4dCdHxLvfx71aaQ5GKHr8=;
        b=DXfr9+z1JO4aB87o26XfySAVnlW+bbgCwGmSKKp4JqVYphwodIJq0auXEd609SHlnk
         gRk/gsr8W6e5BvrQDfS+45bMUqwk8pdH8gjk/zLQLsyStUN7der0SBI7f4wBWL0ZBgeQ
         b2gHR+i6GzsIC0unoX7NupDf219rftcIl5+2QJKMI8/TrX8gDHvFCNI3jj1sJO3AT73v
         vjCvHfinvIx2nKCVwkgshElapW4OimBiIH6kg++irx5PK30shcegf6S4fV27RrpMhjOE
         k+eq5mnNEvuj/5VEkIhTQkFft9m/ZtYmDEBVi74PammIM9MdlqzCjiOWoo+AObByLOsq
         80WA==
X-Gm-Message-State: AHQUAuaWsg2mDmF0VAm/yU2PtRSi3tbZw+0emchnmL16uTBMsVrAyJ4T
        Dyg6GKJNGkEyOYEDlK5cjB8LYUTDlwF6xTtqWnnECg==
X-Google-Smtp-Source: AHgI3IadjHnQEDUGZpJqwxeoBJIHziJe/+CBPAavFbMo50ShDkG52Q5vdavPZE09es6b03fk8j9RJ/FsjqnuMxUjR3w=
X-Received: by 2002:a19:f619:: with SMTP id x25mr2683629lfe.57.1550847953912;
 Fri, 22 Feb 2019 07:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20190221125250.855065214@linuxfoundation.org>
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Feb 2019 20:35:41 +0530
Message-ID: <CA+G9fYtCDnfwNkqma0yhVOh+eOtasNZ2PQ=6cgdCi4dZF2ZyTw@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/32] 4.20.12-stable review
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

On Thu, 21 Feb 2019 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.12 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Feb 23 12:52:26 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.20.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: 65abe32122e4b1f1c564eb24b9846a6838549243
git describe: v4.20.11-33-g65abe32122e4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.11-33-g65abe32122e4

No regressions (compared to build v4.20.11)


No fixes (compared to build v4.20.11)


Ran 21471 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
