Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6531421904
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUUUUzFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbeLUBNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:13:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46594 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388486AbeLUBNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:13:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so2736416lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JxVwivTprc8XuSqlCidCM3qjlZZQQ+Ov3/aZmcXO+w8=;
        b=eUUUUzFT0s9jVKTXtij9O7o80KnoTqrqXyH9fnOz2pydZzLlSJkdA1xpD6sHPPKIoX
         a0WB9AUwjayWruT8eKSJPWsGLdDAP67NvpfthL639j5T65uOR8VC6n9NmmNscJeV7KZF
         Bnpx+KKx9/Io0GK49azo2bnZTg0yqxwUzXB1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JxVwivTprc8XuSqlCidCM3qjlZZQQ+Ov3/aZmcXO+w8=;
        b=q3DsjUPZVCwcq9RrogA/H9Hw86yifUT4Q5sltf2BmKPILcQQEIpvuHw0zmKxP75w8c
         mnxMxHH8xaFL6D0YMSiJos9ndzewlFAMDIq3z+b9RxL0PGCI60+bcM0pwJIiCuGQ85/5
         fMX3ixF4ghZNsos6J6yB74V5oYMFLW39MwjyULd5zaA8a2YxzcYj20OjmWNVs/roehp/
         p/XafOG9VVm2EgzgIavi0FuSrq+Zeb/IbX4Apbw+Xha5yUI9xy4X+N0vIi1c1PmJBYxZ
         5pihCOq3XIlQbpTGj9s87wkx2W9iL0rLozogpZUFDLTUlo1BgwJ6G1SJAvx4TvGDJAfF
         N4uQ==
X-Gm-Message-State: AA+aEWY/Hjx5B0/Xd1Cm8bS1nwuz4WWgqOzctbhTvX2ZuHx7QGdJYZZ5
        X3CtAyWjg4QBzTUUQHeh0Z8NHVRhjmLAEsvQkzfX6g==
X-Google-Smtp-Source: AFSGD/WxHNv5dYwxuaHG16Mn0uQTKljYfvD9PwxdX39thECk3bO5TUSefzGEq+2R0gy56egJP3PV/deZfJP6vjP0phw=
X-Received: by 2002:a19:d58e:: with SMTP id m136mr214958lfg.70.1545354825152;
 Thu, 20 Dec 2018 17:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20181220085922.332225035@linuxfoundation.org>
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Dec 2018 06:43:33 +0530
Message-ID: <CA+G9fYuWdqaEH6A-4jZ+HT1tJJJFNGURq0jEeTBJAiPSbZWBVg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/72] 4.14.90-stable review
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

On Thu, 20 Dec 2018 at 14:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.90 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec 22 08:59:06 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.90-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.90-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: dafc7cbbb79e3fa3743ebcb0e0014b95905752b9
git describe: v4.14.89-73-gdafc7cbbb79e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.89-73-gdafc7cbbb79e

No regressions (compared to build v4.14.89)

No fixes (compared to build v4.14.89)

Ran 21645 total tests in the following environments and test suites.

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
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-io-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
