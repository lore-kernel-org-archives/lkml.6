Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0CFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0782086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpwW1Q0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfALIVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:21:43 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33510 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:21:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so14931787ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 00:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cRozR35C1zmIZFUnH3kaZyXdadFspDZhdrFSIuJZ01g=;
        b=WpwW1Q0lABg5DYpSeKUKmEZ1olG3njeYgis6kovGK5nnKUGEfD3m9aujTkpvLaXh4v
         36gHC4CSAjLaLiV9/GBi4tLCT73LKzvgTZhwUEAo44pwGwOkOeJWT2ntTGytzmMMaq2d
         xBLxjAGVNjFFRssNLJlGwsmEmOxCFOuA3qAT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cRozR35C1zmIZFUnH3kaZyXdadFspDZhdrFSIuJZ01g=;
        b=Sbu4ERPx897qhIUaccdnvhKw5m0BueyFhHdcnbQWoxIeYXZ8y2Gpz9L3Zykk8hLqXC
         VlJ6PhJx4iJ7p8onS8QU26Swpvq608iRDer0UQbnoFD/NPT2aYepAYpwqj8NQa3HPg2O
         Cfka34J1oyiOtZa7NeW+0/7p8xMzmoVH2TI5/DOCflGB5UTXHyclK6+yC4u2jghj1IMY
         RATEZzzHXPIliJ40uN/9/LSrhpTkHC8YzRvDzgjRYSS7mJ1GHiO6yhYHuc/MlTE5OJLG
         qqP2TraELsHzAgLB6dy/mitcSSrWCy39VqHmCK5kF8MJER5Io3iY9IryrnJ6YEr9RTEd
         niTA==
X-Gm-Message-State: AJcUukcnXCrxS4Zv2Qg2jOK00uWMYfY9XNExS7GiGl/PRj9BKWWn2+Md
        IJx/bs9Un4SCfrnI03v8Dueb0+zQz/zAVQbqT5vNpA==
X-Google-Smtp-Source: ALg8bN6J6XCuc/bUYyKm2ttvibiXiLnOYvPvLfJcgJh51JoFDnGxpGiaQh7io2V+KyB1KGSJ3GhXF/6TlT8II9YHEeQ=
X-Received: by 2002:a2e:6595:: with SMTP id e21-v6mr11242885ljf.123.1547281300145;
 Sat, 12 Jan 2019 00:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20190111131102.899065735@linuxfoundation.org>
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 12 Jan 2019 13:51:28 +0530
Message-ID: <CA+G9fYtNMqER0RuAqbAHE=74SkBv8P7GHVewAfDRipE=c1aZfg@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/105] 4.14.93-stable review
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

On Fri, 11 Jan 2019 at 20:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.93 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jan 13 13:10:07 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.93-rc1.gz
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

kernel: 4.14.93-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 8d67d2bf2fc76d64fdff2d95f6a98bf4cea01e95
git describe: v4.14.92-106-g8d67d2bf2fc7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.92-106-g8d67d2bf2fc7

No regressions (compared to build v4.14.92)

No fixes (compared to build v4.14.92)

Ran 21633 total tests in the following environments and test suites.

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
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-hugetlb-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
