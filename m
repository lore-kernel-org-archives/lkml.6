Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28263C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1212184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfh6Rda5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfA3Mze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:55:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46134 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3Mze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:55:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so17263422lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 04:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FwVkjpm6K8TYr0q1Zr/S9BF3CeVOwiytI0plYau21cc=;
        b=kfh6Rda52GHgTb/TwWyStHlv4E2E2vAgct5jwJ11W1pFLFtO50ebidIqhCnwrJK/m/
         VpWBEZ72ug6AcsnM1XJOB3i62m3lAZpUS6tBw6c/Hmmt7xMP1xj5h1oOOT6OSSPrtIvY
         SNcG+Nk0ZlkrNO2xf2mqSRFCjae8EkYyLasCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FwVkjpm6K8TYr0q1Zr/S9BF3CeVOwiytI0plYau21cc=;
        b=KW/cLJ9Ojvn8RiRs8afgl2aPAk80mZJ8ACC9Zev26gK8AAovZsuDW7b8a7jhiUkIur
         JGZKA9YOOHrD7GC02iUggZ2qDQ+yGddYHna5BsAZMVHFQSTMTgMUWAxMHkNj7jQ/85Hp
         HazOA3utbgj4FRI6PLvnMusJYlJfupkrtHX9YSkIN1NHcfJO+dUnObl2hxxAf1c8xtM/
         2XY1DTgoCwRdpcvm8sPsTkaDPjwjvx3gts7/SqFIHjxVecFSzkSg92WoVN8VhZO2s8LW
         fKom3ivms1YnXCo7YR+/VTEm2LN7zCirCagcbLIT1T6jTjp4wbsiePbAAWggYjRRI210
         X33g==
X-Gm-Message-State: AJcUukfxgi0TZAFv5TgvZw3PYzzsAbBb8q4ingaWt6SLit+lHkPySn6C
        6bJqB/ChR/RS81fBuU+UQcNWDxB96kQ6jSb0nW+v+g==
X-Google-Smtp-Source: ALg8bN5fIuA3oZ7mhI9filfYSmy/82APKCwKWXHjtQeCmLOjzoIBI+NNEL00l43Wclo5mnneL9YbLcwUklxHo+zJ7p8=
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr24021217lfi.57.1548852931897;
 Wed, 30 Jan 2019 04:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20190129113131.751891514@linuxfoundation.org>
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Jan 2019 18:25:20 +0530
Message-ID: <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ltp@lists.linux.it
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        chrubis <chrubis@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 at 17:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.97 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.97-rc1.gz
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

NOTE:
-----
LTP upgrade to 20190115 and fanotify01, fanotify09 and readahead02 tests fa=
iled

fanotify01 failed on hikey and dragonboard410c arm64 boards all kernel vers=
ions
fanotify01.c:256: FAIL: got event: mask=3D2 (expected 20) pid=3D2756 fd=3D9
https://bugs.linaro.org/show_bug.cgi?id=3D4261

fanotify09 failed on arm64 devices running 4.14 version kernel
fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
https://bugs.linaro.org/show_bug.cgi?id=3D4271

readahead02 failed on arm32 x15 device.
Need to enable CONFIG_TASKSTATS and CONFIG_TASK_IO_ACCOUNTING on arm32 devi=
ce

Summary
------------------------------------------------------------------------

kernel: 4.14.97-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 958f665be23ee580aed7e445d3dc4700a0d31a48
git describe: v4.14.96-69-g958f665be23e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.96-69-g958f665be23e

No regressions (compared to build v4.14.96)

No fixes (compared to build v4.14.96)


Ran 22094 total tests in the following environments and test suites.

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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-math-tests
* ltp-open-posix-tests
* prep-tmp-disk
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
