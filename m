Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E7C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1173920870
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ez5Oh5I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1173920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeIIJOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 05:14:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42288 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeIIJOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 05:14:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id z11-v6so14917018lff.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 21:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PHCV+c/xRfFSuG55gLzUMhnKPJeKE9NmQpSoCCRLpYs=;
        b=Ez5Oh5I7LhO5Xm3c8ywNYyXZcPbPy3N7Jp5xk9YGWk/j0Y78DaBRHi1Nh4QN9XPM3F
         gS/sXyzDryM79ohCVcx1okiBfBaL8B3Do5afH4ywZzVaHsSOSQBPooVS205E+qNagB/Z
         KbXOYXGZgvegX4jWJ8sm34ixg258+xm2OGYm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PHCV+c/xRfFSuG55gLzUMhnKPJeKE9NmQpSoCCRLpYs=;
        b=cs93Wnl5RJ3kg2viSDZsySU4fBUJB0x0T9p34WgVlJGizOameix7Xy4oSsOqACOrO7
         C1uNYO1RJUVnGDuztu+vhvFCEnq7weRfKQs+/encD0hHMP+k53qo6N668l+pksuT8pof
         lFyifORgtGX27bjoiV4CYP6UYMtpHcDI58/Qp/N/dafJ0PfKCfcJy+EnYTRPfFKOGIUc
         1uYL9RvP9Wd5ZjMt/oVoSsz3f2J4/Wr31/04UytBHvgXaixlYW0TatqOlmTErg/ORWFu
         nfgFZPchiUlEHq85zlajweLgAAJtmUiillbLoGeEE+kmZAUXoMkebjGyNjRYXkogS+1q
         C9IQ==
X-Gm-Message-State: APzg51AhhHvSv+/cWzyXkbyPCVmcRWY8kQIzZ6FKQKDpBPhvJgtpwGm1
        ysZOP6Tbbit94yOCUnXN2QxQLpww/zi+Cm9ZY8gHCg==
X-Google-Smtp-Source: ANB0VdYtTJRJW/yXPaVFwgsvcBRtjEoLm6abPik7/I+hcfTRj0QAgrRIpSwNovfOk4eURtJRZ3U0V7xyXituUmF0MKk=
X-Received: by 2002:a19:164a:: with SMTP id m71-v6mr8783502lfi.82.1536467183024;
 Sat, 08 Sep 2018 21:26:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a20c:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 21:26:22 -0700 (PDT)
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 9 Sep 2018 09:56:22 +0530
Message-ID: <CA+G9fYuLu7wz+mnkTaW-TSiH_avv+yQjWor8GUC-_DCCs6GWog@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/89] 4.14.69-stable review
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

On 8 September 2018 at 02:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.69 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Sep  9 21:08:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.69-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.


Summary
------------------------------------------------------------------------

kernel: 4.14.69-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c5a43c17e80b7b35788d3df112f959251d7be8fa
git describe: v4.14.67-257-gc5a43c17e80b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.67-257-gc5a43c17e80b

No regressions (compared to build v4.14.67-167-ge2d662d77f7a)



Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 17, fail: 4
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 26, skip: 9,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1014, skip: 135,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 21,
* kselftest - pass: 58, skip: 43, fail: 9
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 27, skip: 8,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1013, skip: 136,
* ltp-timers-tests - pass: 13,

i386
* boot - pass: 22,
* kselftest - pass: 75, skip: 45, fail: 12
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 28, skip: 4, fail: 3
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 59, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 10,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1686, skip: 43, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1087, skip: 59, fail: 2
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 22,
* kselftest - pass: 53, skip: 46, fail: 10
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1689, skip: 41, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1014, skip: 135,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 21,
* kselftest - pass: 48, skip: 54, fail: 6
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 79, skip: 2,
* ltp-cve-tests - pass: 23, skip: 12,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 8, skip: 6,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1050, skip: 99,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 21,
* kselftest - pass: 52, skip: 51, fail: 9
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 25, skip: 10,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 8, skip: 6,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 990, skip: 159,
* ltp-timers-tests - pass: 13,

qemu_i386
* boot - pass: 21,
* kselftest - pass: 73, skip: 49, fail: 11
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 29, skip: 4, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1058, skip: 91,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 21,
* kselftest - pass: 63, skip: 50, fail: 7
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 30, skip: 5,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 60, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-[ - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 994, skip: 155,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 22,
* kselftest - pass: 51, skip: 49, fail: 6
* libhugetlbfs - pass: 86, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 79, skip: 2,
* ltp-cve-tests - pass: 25, skip: 10,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1690, skip: 40, fail: 5
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1071, skip: 78,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 24,
* kselftest - pass: 71, skip: 47, fail: 7
* kselftest-vsyscall-mode-native - pass: 71, skip: 47, fail: 8
* kselftest-vsyscall-mode-none - pass: 72, skip: 48, fail: 7
* libhugetlbfs - pass: 89, skip: 1, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 80, skip: 1,
* ltp-cve-tests - pass: 30, skip: 5,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 5,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-open-posix-tests - pass: 1685, skip: 44, fail: 6
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 118,
* ltp-timers-tests - pass: 13,



--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
