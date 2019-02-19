Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F677C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196D1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1pbBp3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfBSFsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:48:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42019 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:48:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id d14so5172699ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zKUcE3V2Wy+q0Sb238AOws8BWlyLsp2hRhKg43w2CSs=;
        b=C1pbBp3QcgZEyghCp378J/9Cm08OqA2o/r7ggPDSQ/tWQAPaETCRxoiASPUrqrb1iX
         zo2hQKrioRidK76/qthsAKTNmEv4b+cSEu6BxNo30ppaGl5m66a61LGzc85qONW7iQsp
         HRinFOPjt09eaIoUV4ARJJBxRkScq+1ipiStU6vvPR/gX+vEZkmukcrwyx/F47j3gAyB
         FDwHoH5yB7CyG7ncQK0I2SkysAeW4hgQh+IFPMp4vWb883xXgUZcie7AwXo1jmCdpqi5
         ZYACIHbRgyGzpVPYXSZETvlCYD7yD1G79FFJNTWfBKR0O4BTX7pEX54WcnOHQBBiXTsf
         Ua+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zKUcE3V2Wy+q0Sb238AOws8BWlyLsp2hRhKg43w2CSs=;
        b=LyQuFy2FBM/uNSd15sQozxznJijoNOn4quLYlfvAcaLaMkI8okzPKnJAYyFtNnRdPS
         Y0YkkEeFOMMRRDUjLab7Wg9YlkBzwt1PpcP05vDN4Zl10/lY4TGi53rQ9a6p5VaGiVUc
         P3hUe7U5JUbcM/DC9tIBiZgXpDArVEcNLZLtw5ouAtcmo59SW6wpR8l8lDPw7M+fYgfo
         ZZawmGEXhkePuh0on7/K47MmxW8Q199aAX7tchPiOmOGUHVRC8RoU8v9zOpF10Tai6nT
         OR8149jCeCHK/d7FTLlE6j0/XqfWzi+eyebfva6m2MLhrtz4MJfG0gaIzSfh6p9Ro5e6
         0usQ==
X-Gm-Message-State: AHQUAuZnyOEM0wv8aErMZbfRDC+kwHH71bvTjMf8Kay7oSfnlhvsIyzH
        7/N/19z2lXCwTZQdVuextQo8nflFeRlick+Q9WLZ2g==
X-Google-Smtp-Source: AHgI3IbDXLkvRaPx9sfU2bxgGGmDvGxDaY63JApovhHxK7zlOhEdnMnG23KwZxL6Sxwcx03sveRq2bZay4t1FOw+swU=
X-Received: by 2002:a2e:6309:: with SMTP id x9mr6177893ljb.75.1550555322959;
 Mon, 18 Feb 2019 21:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20190218133454.668268457@linuxfoundation.org>
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Feb 2019 11:18:30 +0530
Message-ID: <CA+G9fYsELzsA7CN4CYoC0QNTsEnuORBBYmj5OUKD47Js6zjY=g@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/92] 4.20.11-stable review
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

On Mon, 18 Feb 2019 at 19:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.11 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 20 13:34:25 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
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

kernel: 4.20.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: d1ed2615d6401be6432cd67f6bd81d7d94af6af4
git describe: v4.20.10-93-gd1ed2615d640
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.10-93-gd1ed2615d640

No regressions (compared to build v4.20.10)

No fixes (compared to build v4.20.10)

Ran 21417 total tests in the following environments and test suites.

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
* ltp-mm-tests
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
