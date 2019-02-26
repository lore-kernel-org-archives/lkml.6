Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235872087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8XypNQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfBZNCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:02:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40883 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBZNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:02:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id a8so3766958lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 05:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fwKoFQ+dUUJqS7eB3EpFTOR0QtPk9z9S+bdlrS/CXXU=;
        b=g8XypNQlnL/KcBGVor7bmpVEdUzvfcQyJyEgrrb77YPV/rVQTZOZHUOGM8fO7+fkhl
         td0dL9lH+wo71SsU4KBbgH/kLgTuJ6QFALXC2sq59hjSdNr450RsmvzjGXwlERP4AQNI
         4lt/e0XKXENUkhpxrXd7leHRczr98uEo0P84QWFFOslxqBoqK81IwFgLs+DjGE39TqkH
         I90F9OLrf+O03ymfh4UIpApdS4j9r4pWdEEOz/HjZO8aRYsx7iMbbAy+AGWo4NtAMxNG
         KPx3cnBWBG+IKUgxOwIsXOrMgkDj3NybqeUUNbTZ5ljpSgtVc7+PWTOTrQAhu/1YkCsB
         KR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fwKoFQ+dUUJqS7eB3EpFTOR0QtPk9z9S+bdlrS/CXXU=;
        b=BwCRHkq/VZfSIQ1ydPgPIqZ5zHvX5+rGX+moL95P52qXVnKagi2ceUDBNA8dICk/cC
         oSTS0qSOY9ZADtC9FnbBVGCPdLpKm3ZtTVhPCRd1kVjDFWadtQBJ9KQ98fsZ07NZhT3c
         +ea4joTiDV7GfGL1ocz9DYCBgjQs55tAxJTFOwZ960NitTqoECIqoLmuACh+tF3TyWD8
         4bEl5deQpnyLXASqezcSOUxGYACN9FUlj5QWofbfhBN+pc8D9S4ms6iK0f2+aSNCU+JU
         q2U7u9PxRSK4l9Ka9Aiggu+VVybhPrWMBvVR7Vfg+0JLsoJGLR9PsKgargU7LvId/YzA
         XoWw==
X-Gm-Message-State: AHQUAubxJiZLQk5wDLH55o8UG7ZaEWccn3M5+PG0VusH9hIu6vzRLQgL
        hBknX5NjLXCwbJ3lr4CmC6ppWeyOCvShKrsSBK1RYgPoHsY=
X-Google-Smtp-Source: AHgI3IYUbnex17276E9fIZZrLcXFCOBE/zTSGhLMuRuOUIZGrnt06ZjNuiEeBFFEngodPn3zZSn6s0nBzruf3K+5aE0=
X-Received: by 2002:ac2:4432:: with SMTP id w18mr556992lfl.94.1551186156314;
 Tue, 26 Feb 2019 05:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20190225195043.645958524@linuxfoundation.org>
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Feb 2019 18:32:24 +0530
Message-ID: <CA+G9fYtj4BbVBw9BFymTqfcndUj=qamjuNui2_pe_3-CDip1nw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/152] 4.19.26-stable review
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

On Tue, 26 Feb 2019 at 02:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.26 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 27 19:49:57 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.26-rc1.gz
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

kernel: 4.19.26-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 19150dd19094c29a4df049941da4f077776b8e81
git describe: v4.19.25-153-g19150dd19094
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.25-153-g19150dd19094

No regressions (compared to build v4.19.25)

No fixes (compared to build v4.19.25)

Ran 13671 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm

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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-dio-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
