Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB55C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AAF206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="He9Gc0jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfAHK7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:59:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40161 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfAHK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:59:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so2587694lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=43ol8C+25gQidZaua2BLbSSjTjeQ0Ha0jeUYYqRcrmw=;
        b=He9Gc0jN7CP5lvFTA7JV+G0ZqecfPCCyVZ3O9Ulisp6HjWh2/rmmzEW1xmMbEgv98O
         z5HpnxaG1VsU46ZFi2lKBKuMsbc7W/GjyOnhb/jdifYgjf+TWnnDd66yQMjHkRSLga5r
         hCjNlO0Iuf12OpNlG8ATBuqp9qEfv1ta8y8nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=43ol8C+25gQidZaua2BLbSSjTjeQ0Ha0jeUYYqRcrmw=;
        b=pgOx3dwDnkdnoU90gfWwv+QRxtxdY1WqaI20/zeHp/HwxrMR+T+suAIMijGj2k/z9V
         gW2UbViFZ4MmFDUHoWWt1k/kx5i/myElmMHmc4rtDG6KSq6IjMvt51ZKUpHRVp/7T4ec
         /3n1xAUil3VKtPWcuyEYoe6mZzwO+ND+47m3QzuzCX8PZ7zZPkgIQW3HJHryvGw1OjYm
         ojc0blo52mqRJV681cgfoD4vxQlR66KTJbqGGKNXWoX1il8nxW+HClMIcwCA82ZHWyoW
         PimgtO9lNFCv3q2beQ8+2H9SyX4FUOHIYoIWuNh2RgcZruJimEuFTJkcLG1zczB6Hryu
         E6ng==
X-Gm-Message-State: AJcUukeIrnqjhX9HSJVq1Junxj+14yhjhT4nFGl93eO8kqXeV64EDFoO
        T0ToBDOLum2UxS3JXb9FyHWvUmSbMRDeNU+mESqWyg==
X-Google-Smtp-Source: ALg8bN7damIu424xCRh0odpnIgI/fyCLWb9IbIHDBKf0Vrrf4aDQ2slg3fGwgBMISdSE3elhRayvhCEJTFujd3kmUm4=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr724602lfj.126.1546945145264;
 Tue, 08 Jan 2019 02:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20190107104437.308206189@linuxfoundation.org>
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Jan 2019 16:28:53 +0530
Message-ID: <CA+G9fYsx=oUnq6V1JcQ4dvnPgLVwrBM_MjyXF7F1xV_CoGBOAQ@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
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

On Mon, 7 Jan 2019 at 18:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.1 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.1-rc1.gz
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

kernel: 4.20.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: b3b71d0e3c63a729d9d98c74e0a2db10b4133d9e
git describe: v4.20-146-gb3b71d0e3c63
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20-146-gb3b71d0e3c63

No regressions (compared to build v4.20-46-g6fb31b79ec72)

No fixes (compared to build v4.20-46-g6fb31b79ec72)

Ran 20523 total tests in the following environments and test suites.

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
