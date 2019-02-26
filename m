Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E930217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWve58AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBZNyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:54:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46306 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfBZNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:54:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so10805212ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 05:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f/0ke6Dmr8xvHzyrBAo3qJhnibozPu1E9uMNubMefSg=;
        b=xWve58AJX4M1DQG99YUAkfayZGbgCgoOl9yj6TX5DLRyLzbkVN+FRMwYKqVNTgY/Am
         9BQTzttAUjMuwMdtE7QH7tGpF+Bz/eolmYJCPSDY3EzWfAwoOFljZhH0S8laL9zXTPKu
         YGlTd4pFwJxagJnBZ5wdmUlZCzKRe++FSNpuXqm5n4iiuoi/xwPe8jsgRQHPiZpP4yKe
         erdIfG4KW0fmzbrLb+5q6Iqez2sLKQCqN1kOWUdID+R94+APjbGjs25BxubK3vcEX2mi
         5An/q572C558UOYCvGCKL70CvBSqiSDbhLOq4+7PXaNcJqmtQUz3vcZP7647eMONt9/3
         Do4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f/0ke6Dmr8xvHzyrBAo3qJhnibozPu1E9uMNubMefSg=;
        b=biYoqs/h0lEtuHdMysdQUa30AJUnG3i/w7dzExQHBwOEkO9030mCc4N5dqlFjqYJRW
         E0FwQOtg7ekGUbidmrHHKgE2KK6OLFD0HHke4oDePq+tUTwfRA2PQJ6Udbjd6dKO1tQA
         8fIVJRoIvnwsTMjFS0Z33/Ecj+KBWMMTd7HkgH91FwrMbptVJNyQxngXiO23Q7PwRVRR
         PqtL+/9q3dy+mRPi7VNMHUxSDcEqRaPG1Px6G0W9kYfcCzM6JHOK1eRMSvQoc/7OYjRu
         i9tlbIKsEszdMT6h5Gk8S5hQcz+pz6tN6+BQBHUueJivrct4nDlrxUJnGFuZroamUc6C
         syOA==
X-Gm-Message-State: AHQUAub1n5H+Hp9KK4nlrQJ/L3JIIIC6ipi8dzRyatXLYFWmIoJhB3ux
        KXE4/ZnXF0PfAHjIS25Twcu/rnVND9Oaq8z2rYS8ZA==
X-Google-Smtp-Source: AHgI3IbOnSALe3KqwLJFExH0M3ThBRTrkHVVuhou4Mxa0YT+r5KzL28DQ6pHp0CLI9H4SXl79kSmQ9HPGJ8cZajxS1k=
X-Received: by 2002:a2e:6309:: with SMTP id x9mr13026760ljb.75.1551189245907;
 Tue, 26 Feb 2019 05:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20190225195054.748060397@linuxfoundation.org>
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Feb 2019 19:23:53 +0530
Message-ID: <CA+G9fYv7Nn9kz_ox6Kvge4pkH4OUEW_F2aZBtRE6eB+ELKXYwQ@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 at 02:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.13 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.13-rc1.gz
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

kernel: 4.20.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: 6d10f1d29969714a475c700b25eb8483c6d5f7cc
git describe: v4.20.12-184-g6d10f1d29969
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.12-184-g6d10f1d29969


No regressions (compared to build v4.20.12)

No fixes (compared to build v4.20.12)


Ran 13889 total tests in the following environments and test suites.

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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* spectre-meltdown-checker-test
* ltp-timers-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-open-posix-tests
* ltp-syscalls-tests

--=20
Linaro LKFT
https://lkft.linaro.org
