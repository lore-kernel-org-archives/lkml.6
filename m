Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61054C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311DF20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTn0T4LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392703AbfAPLv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:51:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44162 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392689AbfAPLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:51:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so4620692lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 03:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fhSHHYABljolfOthqLSVkjCp/eyt/46dlfwZuqWjsKg=;
        b=RTn0T4LYg0ZxA+ZQi2kUs9yKp7lsrN6NkscrNrXBj8BLwupPDL2jAaxRmFo1ZVa73T
         CYrAXHdrBYp7WlQN9L/MkvZqlUjMK2J5xJFhnpDi3jWpduQw4LVGRUNVHe7KdIJ7A0BL
         nUo8wSkQ1D8oeHRq5ma+e5mv+rXyL9QF03Kcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fhSHHYABljolfOthqLSVkjCp/eyt/46dlfwZuqWjsKg=;
        b=BpVmVUap+w9+qKw+uqXGLhxQ8fTI1AB+Hab+f1aPPNFE29Q/gc88PIsUSy2ocZdDIp
         ud96YwZTvZN48wAB2W+AjYo9IEqQHLx+aDf0ZkDax3jgi4JpVWmPvVg6fSJHBSg3OaZo
         2+2OrDtKn1xLqjiCdE7CLJGjq1R3DzN48u2cueGjF4N8/vJCha///5jPxCZnh64YY1RY
         XSd8Iuv6QDUp3L5mozaXWw7lh3Ya0yZxkznK4J55823GX8kFDIo+wbZIR3t3ObkP1elM
         0GaJI2/c3CJtc+cGu3M6Yz6uDAxrFEH4TYj43uwkpW+l4tO8bZQeV6bIHenB/LxLq2MU
         2xAw==
X-Gm-Message-State: AJcUukclufKgDHjDnl2+RxSp+R1LdawRB4yM15LAFcgVU0wjNsvyaKCE
        j40rVfHNxznojDTbTcAdnI6FMTDkTHNWS7HcnsDBnQ==
X-Google-Smtp-Source: ALg8bN4ImJnR44tgqjCJqh4UjBbitpzkDJLz6UZoGXHo91/8hNkuiGBzQ8zikAl654SiYlEEeDA7JfMErWRK2BTvDh4=
X-Received: by 2002:a19:750a:: with SMTP id y10mr6533014lfe.43.1547639482355;
 Wed, 16 Jan 2019 03:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20190115154901.189747728@linuxfoundation.org>
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Jan 2019 17:21:12 +0530
Message-ID: <CA+G9fYv_XD1r2i55qdVSHg3xsU-9cgVf2piTcxAJ--wfa+UVaA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/27] 4.14.94-stable review
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

On Tue, 15 Jan 2019 at 22:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.94 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 17 15:48:28 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.94-rc1.gz
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

kernel: 4.14.94-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: ec31b1a0fd7d9092bbfbef8aed2819dcb899ebac
git describe: v4.14.93-28-gec31b1a0fd7d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.93-28-gec31b1a0fd7d

No regressions (compared to build v4.14.93)

No fixes (compared to build v4.14.93)


Ran 21651 total tests in the following environments and test suites.

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
