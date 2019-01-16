Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB11C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B1620578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIPPh6fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392729AbfAPLxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:53:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45403 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392547AbfAPLxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:53:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so4627664lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ylw4H3vyx7OZgsmrhwYMd3vw3hmhRAYze/vY/g2C4HU=;
        b=ZIPPh6fQMU7RJBTPoCefKNHYVxBrvE8Xq2OZ/DejHkjebJ0XNhO3knuAUQJ+2mdN98
         Ge7+d6dqVnDssoHsM9XgMpu9yKObjhu/rCGkwUP/CkybtXkvAfDF2gNiyhUPfsk6L5Zd
         4Hrpk2yExG/oxFVDDoWSt5oIOrBH0HMCw6HEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ylw4H3vyx7OZgsmrhwYMd3vw3hmhRAYze/vY/g2C4HU=;
        b=DZ5P/f1i9O4s+IBKpxyCGRlx88gpN1TOANeGGryeLf1sFRicQad5XvuVlPv+rVgV2d
         Ztav7HTP5NGyocLiPgHj/0IYhRpMUmFoCVc9kc7vBpyoxDrq1y6Os8jG+AnaumFKgyy8
         CLYXF4njamLjCyENMziAt02XQrXmze7JfvnIQwG/ZDhIizK/ejHzqTwy7P67WKHvUqHG
         R1s2YdR2/F71Xj/qDGPvZDtKKlWtwrtYJyuAQsFNO519ePMeNaxhF7GcKC3l7hUfQeWJ
         cSsVrkZr/cd5GbIoNHYZKAIIssLzi2+B92JDfiDrlF+kpPqXnf2+6B6mdAktyIqitlKi
         i9Mg==
X-Gm-Message-State: AJcUukcj4qKn8iQkzPQbsYxva0ESfp9hRkfEobV5VrtqIby3I4p6e2tS
        6iayZSJeNMARJcgDNr4+gtjJpRA0GNbsNzuwKolrsQ==
X-Google-Smtp-Source: ALg8bN7JqfL6LP3kwOLJ6xJJOAw+/vAKdQFm4frKranB0bnOKiB6VPa2PO7yJYLQjKuRWEoRmHGbBtwcP6+XBXhhDmQ=
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr6408819lfe.152.1547639588827;
 Wed, 16 Jan 2019 03:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20190115154848.164648613@linuxfoundation.org>
In-Reply-To: <20190115154848.164648613@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Jan 2019 17:22:58 +0530
Message-ID: <CA+G9fYsqMULav8hpM-SQEGP=HjOMssVZ8+AJOC-i+L5KSiFf2w@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/16] 4.9.151-stable review
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

On Tue, 15 Jan 2019 at 22:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.151 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 17 15:48:25 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.151-rc1.gz
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

kernel: 4.9.151-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 1f10ba88db84ee7d1585f99f83bd887f790b4357
git describe: v4.9.150-17-g1f10ba88db84
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.150-17-g1f10ba88db84

No regressions (compared to build v4.9.150)

No fixes (compared to build v4.9.150)

Ran 21406 total tests in the following environments and test suites.

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
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-io-tests
* ltp-ipc-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
