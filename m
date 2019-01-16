Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF7AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CE320578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRESLH+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392746AbfAPLzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:55:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34276 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392734AbfAPLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:55:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so4683680lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jwcmr7tsbGyOY4a7KiqVysSFN0z4UVQU8iYX8cx12Uo=;
        b=bRESLH+b+YAabd4a3ccLhbGpFk10+g5ODRd2wgKCpuel+UXB49anjNR1emgFw5tlow
         Z76fHDctSvvp30heMXE9IfLljTru+xnIIZo9zBxRPTUp7/xgjOdJrYWeUBkcFuc0VQTU
         H52kcY8O631Dgl64asg4tBIprs3pHe0t4DZ/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jwcmr7tsbGyOY4a7KiqVysSFN0z4UVQU8iYX8cx12Uo=;
        b=CgHkRYB40pl5lSgpsWkGQL1vCKJkR7SU8qqbiiEEkAy8VekiS7L8Um0NPRNnP+Pa8U
         9B+NjPzr9Op/K8m0huHVT4WE3muIfpu3IkeKJ2ygHDO6+20v8VVWyFi69RnwYGdTjMgy
         /0ZvOBSyTfhgbDN0PKUHcad+1giKiS0OfKkXtBK7iHCnwJx9eTTNOhrFoTX7/+nZOpKz
         8q6PrJCk1m2mZUlhoEL+tuE0qe/dFlqbMRyL5lMOtaBVYuWtbCB3c8PDHXGH6kbvISpR
         OPgSvyCZWIxtzZD3QnK9tIZaJQeOjmgDkShuHW1B0OXF7oM284gTD7oyZG4oKgqRYz3H
         uL0Q==
X-Gm-Message-State: AJcUukcBOrQtJ6KEsnXRuKqPIATPMAOAnUjRv9ZqVPwKRwdOnCL6K3hV
        J1D0JdX8Gk2rsRUgL+1qn5U0MAvTHoHK1hBc/yofFg==
X-Google-Smtp-Source: ALg8bN49BWPaD2dREcgtP6/zLnc9QTwYFIAV/PLz7AFd4MSOiRM4iIfGsFEz0sfcBS5/Gme1Pmx9ZwyyZ0mo6tmK0hY=
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr6415331lfe.152.1547639719412;
 Wed, 16 Jan 2019 03:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20190115154846.928796000@linuxfoundation.org>
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Jan 2019 17:25:09 +0530
Message-ID: <CA+G9fYtsYMt0R8XL3MazYzgmwYYhReRJHfqtXHgY96jHzFrPvA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/51] 4.4.171-stable review
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

On Tue, 15 Jan 2019 at 22:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.171 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 17 15:48:21 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.171-rc1.gz
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

kernel: 4.4.171-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: cc14a9e207362757ecd2254de04a816657b58904
git describe: v4.4.170-52-gcc14a9e20736
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.170-52-gcc14a9e20736

No regressions (compared to build v4.4.170)

No fixes (compared to build v4.4.170)

Ran 17023 total tests in the following environments and test suites.

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
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.171-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.171-rc1-hikey-20190115-352
git commit: 82b93f4bdd350fa372bb7104304aeb5c977bb31f
git describe: 4.4.171-rc1-hikey-20190115-352
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.171-rc1-hikey-20190115-352

No regressions (compared to build 4.4.170-rc2-hikey-20190111-350)

No fixes (compared to build 4.4.170-rc2-hikey-20190111-350)

Ran 2756 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
