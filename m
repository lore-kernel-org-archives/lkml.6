Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BB920657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G62KOMxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbfAPLsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:48:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41678 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389561AbfAPLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so5165612ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 03:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yVqgO0W+jbSw5NkoR40qxGoBEBCqM5H7yoohKDiLpZM=;
        b=G62KOMxfoZdgu5M5zl+TT8d+OKHrE3GgMitsbxM/043ueWBiGjhMSweSMGD0NQ9e30
         +GVzSgjUfEEClauB5xwTXjbqHtbDjmCTJAkcbrKYVooLUbf7bIqKHPKZTQ68hztY1kLU
         +YvJRYFLu6brKzetRc2M8qjExUgUZgLZ/+YQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yVqgO0W+jbSw5NkoR40qxGoBEBCqM5H7yoohKDiLpZM=;
        b=Cg7Zo8cyTWsBsJU80S4Y8AgvY2wkipFkv7kdiWFkgB/VrzyNGNkFIgppCIclNz9cu6
         b5uQIuZjfvty56UTKZ+U1BpbTJ7MpLCSyJDd6gbifPPIO5YIACpRBAlAIx0iJIr2tWxR
         i/cnY5yh90b8YQ+8RMJKVUWNfjYprnmx+78ptWYYUxLWLQCkmh3MsrK1337+O3T8bNgA
         fFDE3+SJhXsogdh2kNJQ33hmEE+ZAZxEz54rzjEwbGJWMyfcwOe/xWvVGB3OQHFqY+Vw
         N1l9sDKqkxFEx+TwRtNl0d2I6aZuSITs9wTd9jyvIllQ7B6tmZpcKzM8kT4/kWcRY7Lu
         No9Q==
X-Gm-Message-State: AJcUukfFLXMlbkVR4geSNSvpUtmmCTToqKbCUekU7qzTT9qmyjXydcll
        kq2QzgFqzd/PDPtO3k4X+PdNrg87mC54t7ImykPwBLmV15i3Hw==
X-Google-Smtp-Source: ALg8bN4c5mMSS11bCMKqFzf3sTul4ylCI/qW65usC967gJZ99azOzhyjta82Ds+2SEbU093qIf0NF0PFuRAizwUUYY4=
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr6279745ljh.63.1547639279900;
 Wed, 16 Jan 2019 03:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20190115154910.734892368@linuxfoundation.org>
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 16 Jan 2019 17:17:49 +0530
Message-ID: <CA+G9fYuk5XJswcM5-F66F4apYxSaDkKO8DRe67dYXKVMM-7buw@mail.gmail.com>
Subject: Re: [PATCH 4.20 00/57] 4.20.3-stable review
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

On Tue, 15 Jan 2019 at 22:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.3 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 17 15:48:32 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.3-rc1.gz
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

kernel: 4.20.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: b993fcf79d3f027340477d3a9382f559cd717591
git describe: v4.20.2-58-gb993fcf79d3f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.2-58-gb993fcf79d3f

No regressions (compared to build v4.20.2)

No fixes (compared to build v4.20.2)

Ran 20575 total tests in the following environments and test suites.

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
