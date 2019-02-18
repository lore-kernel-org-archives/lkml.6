Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A221773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLrRvuOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfBRSim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:38:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43229 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfBRSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:38:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id j1so13026452lfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BpVgvZvgC3t8y6FU0MjADBH8OcZFIPMz59TjB6mrUBc=;
        b=pLrRvuOFI/51ww2Ahsm4hA3T2RS8UTjDujFm9Rz6jlhR56zC4kyKfOqim2+tFusMDV
         uDIE/C3/47HMcPytmBGCTcjmZqkpTBhxcElfy4DFbAlfpYqbFxBCdWpguaSAw/BApozW
         ZGIjeQo7MeaFErfJqKl6oGMpS72NqFSSVtfnx60x32E4DkCsygjPLo0ieh7Y+v177Wzc
         O9GFZzOmzDxHgMOe1CmtlXWgEZqRk9SkpB/1pTyuRQXDmu4LPdH0YlK26REo5xj8/Vvb
         kbLrGztv9AYjtEIrFfnhRu/gNqcoJbyyvI21iPtrG3wVseUrXhS44qLLswfhqLOfK1je
         Lrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BpVgvZvgC3t8y6FU0MjADBH8OcZFIPMz59TjB6mrUBc=;
        b=d4LVDKRYfbqVicflrF/DWyHk84KnEyPUTFgsZYuKi8ksRykpaiDxABBwc/oXpKH2OS
         tDCXsziKwKe+CenyjOC6X9C9I3Hz6X7tRgqfAKBXx/pL5hcDW25ZiUt2lHQphwt+gVi/
         VPO/ZoirwqjozLOxENb9+rU0RIS5OUTsQMnEmMi/d8JPRMdJtSwZ0T3pI9uc/2YglCk0
         PizflYzZjOk6zfxGLWGYhP0VEk7toAG0vUFXIckVJqLxkOoCDWs5gjnNr5QC2EzS69cq
         kdPSVMwp+jX8tYrZn65oQqszVg9qbRckgUpNKupErk9wYuCjIRWtPiSxHNnnNWH7ZiLY
         p63A==
X-Gm-Message-State: AHQUAuZdr+nJsQqYhHz6np/31qji/lOI0ZrY9AZaZ23xOCCihpqw3Oc7
        nTq6M+abhIWKfdB3NQmGLzATjnFxCTxnGMVMW1p5HA==
X-Google-Smtp-Source: AHgI3Ib3Ke9R+l19PNPKkpRGODTHMfmSssuJveeRNsf//BHXvKd3KOpFFlHx5X+OWv6e7pmZhEEXN66yKtc7tqjOE/Y=
X-Received: by 2002:a19:7613:: with SMTP id c19mr11273643lff.103.1550515118470;
 Mon, 18 Feb 2019 10:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20190218133529.099444112@linuxfoundation.org>
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Feb 2019 00:08:27 +0530
Message-ID: <CA+G9fYtU75eukah1PKvujt0z2i38PyH3qn8SPWfxSM9-yNpRUA@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/143] 4.4.175-stable review
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

On Mon, 18 Feb 2019 at 19:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.175 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 20 13:34:55 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.175-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.175-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: b21488342322bbf876a019f6638b4d5f142acc14
git describe: v4.4.174-144-gb21488342322
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.174-144-gb21488342322


No regressions (compared to build v4.4.174)


No fixes (compared to build v4.4.174)

Ran 17569 total tests in the following environments and test suites.

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
* ltp-mm-tests
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

kernel: 4.4.175-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.175-rc1-hikey-20190218-378
git commit: 0a63bf1d84ee6f63228b926c3d7d8457f9b6f437
git describe: 4.4.175-rc1-hikey-20190218-378
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.175-rc1-hikey-20190218-378


No regressions (compared to build 4.4.175-rc1-hikey-20190215-377)


No fixes (compared to build 4.4.175-rc1-hikey-20190215-377)

Ran 2849 total tests in the following environments and test suites.

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


--
Linaro LKFT
https://lkft.linaro.org
