Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287BCC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADD320811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6YqfL49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBHGOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:14:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46578 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfBHGOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:14:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so1655937lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 22:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JXDL/Y6YytEgtULw8Z6u/4VQQiamYi3V2xfLTh/omoQ=;
        b=J6YqfL49NaXohId7f9A4vn1J4cZ3v1ciKqXKQ/5otxZd7gQcpXKl1C2yoMBWtYcriG
         SyeJjlwvqzCp0Dk045Eq/STZ9dkEUleK59DxeCOwWZZOcFBUt/bHyQ7hhCQJdMWj/VFG
         Wi5KTviSBN7FBwwklEmvRGoVyGYOEIuGmguEjPBtjVXODPqaGlclrHMdN/nsRYdvF6tI
         BQo8kPMqeO8p9yL9yJwMOmQV2d/OKs8Y3YLAZrBWa16b0MSE9ew8o9f/gLWBEUIshveQ
         QJ0hE6xm0MqL4YtPHYn4c73TEvTxSKiaVin8h7Dc3IuNEPghU1zo6Fhr1tOHy9OR+nIc
         FoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JXDL/Y6YytEgtULw8Z6u/4VQQiamYi3V2xfLTh/omoQ=;
        b=DwKeYj3egprK7CGVgbgwh9hCxXaPaMGaHVauvpkfea6IBUn1UrXYX5IKFQa0XVOa0m
         5nSRmiEkIKbJd7VcSnYBIt9vOJT0vnKTBGxpc+5WbmQm3wuKsRq4yL42qbIWFpq7p/tY
         Y7uJkamCZqtRCYGUSh6cOOQX/gmQNG/R5u5ZzxLQvRdQUcljmTYZ+9JF9Fb+6FkGEXPn
         Vt4N/6YyWY67JdtXGoCoVS7Zo3Y42+IakMw9A6P1cRVfqb8vg/udCI+28Y1+7EfmvH14
         +f8D74V0TcBYj7Yt0hqE1KBaBlZpK5QVJLmDVpRxeucJjPmlUcslgdFZ7JFQtl/+Vqhb
         hE0Q==
X-Gm-Message-State: AHQUAuZ8V/wXbpSpovh/cu8qvMytBtYeNezPBKd9RnaRxmZj62ydMyMv
        rhvrXGgG3Cs5XLgLKq9MFTYUvBBSsecwNENJjteKQw==
X-Google-Smtp-Source: AHgI3Ia9PeBNA1Ptyr9317HpJZXm/MIr0d6D7XyDsJ1ge2I5fVDkSH4psi4iLSgFWyT/aOEPguBR3EbUifMWF6U0Gk8=
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr12437516lfi.57.1549606447271;
 Thu, 07 Feb 2019 22:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20190207113025.552605181@linuxfoundation.org>
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 8 Feb 2019 11:43:55 +0530
Message-ID: <CA+G9fYuO-xX94KZG165-9_9QEZ7_VypxckHgPmX6dTTsHrAzxg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
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

On Thu, 7 Feb 2019 at 17:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.174 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.174-rc1.gz
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

kernel: 4.4.174-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 968fa3bc933965940f7fb2a56789dac2bd12e4da
git describe: v4.4.173-35-g968fa3bc9339
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.173-35-g968fa3bc9339

No regressions (compared to build v4.4.173)

No fixes (compared to build v4.4.173)



Ran 17146 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.174-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.174-rc1-hikey-20190207-370
git commit: b7ab7cb3251d307982d559727fff755b29867bd2
git describe: 4.4.174-rc1-hikey-20190207-370
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.174-rc1-hikey-20190207-370


No regressions (compared to build 4.4.173-rc2-hikey-20190204-367)


No fixes (compared to build 4.4.173-rc2-hikey-20190204-367)

Ran 2562 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

Test Suites
-----------
* boot
* install-android-platform-tools-r2600
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
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
* libhugetlbfs
* ltp-containers-tests
* ltp-cve-tests
* ltp-fs-tests
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
