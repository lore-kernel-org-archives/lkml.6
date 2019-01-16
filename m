Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18224C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD4620859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEe2ML+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392659AbfAPLt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:49:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36521 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbfAPLtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:49:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so5197737ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 03:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8tQIR09lHcRdqvgQPJVsL+S4/1wA/5PWRpwY3fGlOYI=;
        b=JEe2ML+am2qavY1u+/uCMG+Gl+I60d1P0lZqHHvSc5esZdOZbUu6aUSCR7P8fOWHE5
         DTEHAYzd3pK5GCUONijfWbaEhyRvV3QXfFAfQGQ7QzJJFwq0uTYg4ZstKuht1i5BoiC3
         /Sh+Vbjw5wiyHg4RBEAxVFLt8EcFUPxI4UO7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8tQIR09lHcRdqvgQPJVsL+S4/1wA/5PWRpwY3fGlOYI=;
        b=kpA8HW0ZKYfwuj6RpVDuF/mAcgLk5VqQxOl7oSqRXG4qQ13z6+CxHNf/x43Om5ll2T
         obWwEKMHHDAxyh2qrAewdWIOrKNSMEAAxWtC9NAWyVUM/dGPNhN6sJJziJXilwVMM3yV
         wfrKxVZG9qQwbAEUvbt5HrOiunIL2xBBmqwSzQW9MsoM/AjOb2oHwHxZALij7tqKJnUG
         9NvJFC0mlrmQcv1UtwhQL3dQ3htiawalGEKXvCCp4Vgql857PVMRBsqHGg8Ws2Vi0rVm
         akYybGAjXl8dJiRSRZOojFOJwQGeNc7EoTzuAwtQc7UQVjBGckQO4asdNZFV5r0qQoxH
         LpqQ==
X-Gm-Message-State: AJcUukfpIrU/oCt1vV6ScJaYTA+uyXuhM7i+Ywb+j/d6iu1Z8txh2FeF
        NVrMq2XjiEVLQwCa5Ts1euyiV3CiTfdJmRNSi8uGYg==
X-Google-Smtp-Source: ALg8bN4/H/kDopR7iYrIE/MwGJGLwfyaBHMNfM7eWiKTXKa9uKyhKm2WNw0hFHER1wgn7/GZvWEEsiqxly1w5YDBe/8=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr6213818lji.30.1547639359409;
 Wed, 16 Jan 2019 03:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20190115154909.933241945@linuxfoundation.org>
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Jan 2019 17:19:08 +0530
Message-ID: <CA+G9fYujxC+sGTjcuGgu3UznEVs8CHrQJRiWc29po1J+s4R6Xw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/50] 4.19.16-stable review
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

On Tue, 15 Jan 2019 at 22:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.16 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 17 15:48:36 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.16-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 3fd0fa89eb9f95b7989c649564ee07b6f36559cc
git describe: v4.19.15-51-g3fd0fa89eb9f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.15-51-g3fd0fa89eb9f

No regressions (compared to build v4.19.15)

No fixes (compared to build v4.19.15)

Ran 20640 total tests in the following environments and test suites.

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
