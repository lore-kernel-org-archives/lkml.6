Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24360C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79002077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2nh67F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfBVJEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:04:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37587 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBVJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:04:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id z196so462692lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mywFBJr5aKb69/xZraapzGhX1EdsOzoYP3K1Hox6DqM=;
        b=X2nh67F7yHP25F6bD6jDmzGcZeh63Z+OTZoeYysHlll6nICmd7fy1TqAGMeNQ89N8L
         MwQQLUQ39z44twtr+w66KyQ53RyIc3kxbB6XKvFp6ub/CBrvbofduYDTMOCthZ/1XCHh
         atpFj3V2XUH2aobSanD6QlCRC0C03ZIijgN8ORHKY84VwK8is5oY8PunCpQoUf+CKJPY
         4Afp7bPV1s7/69wuphkPkvc2PT+06gWAmk4DzjDmPHkZjwggLtu0gmaRuz0Wc88XahAB
         e/bvNrBEPetZiWH+HSKzcMu22Ysr4qWQBGlriQfPNFxpQT7GDToRV+CfmVh4ojSfw4ma
         qVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mywFBJr5aKb69/xZraapzGhX1EdsOzoYP3K1Hox6DqM=;
        b=tzgAaN30OXF/oX5EZqItwy9VsQEIqeCa+7t2avlIdPIkz4qLwPJXaYl7744DvH0lT5
         AdeYLZftc6CyR078g6ek27LWWG3dbHxsI2hrLEoTHyUXkuPVTOoVkV+qpiwSbAwECswM
         JTd9r9+g/zGONlk4ly8WAn5b7mGWnulwCZY/FOqMoe15Fxs/y7Mj5qa/dZaOBQ06++6W
         Uu8Y5RgGAu/3tVEMHXxBFo8RSUQ39jdMACJhUMjJajkAH2zhcT6Aw3vCVAzvlIPoYoxD
         GVXbCtH4Fkp0mXJyCIvkD1o+9T4hSglOrmIaGy0EIApJI9+5KqGT6ZPOhXt4Z/EH8sdw
         LJtg==
X-Gm-Message-State: AHQUAuanQWPOis+0VUrfwaFNjezmmHqkho+0NiFzgpQHxHGZk6PcpSnR
        G3zisfAdhjP8GJSy0kFl2qUwFUWMOttktxI9jwh1kg==
X-Google-Smtp-Source: AHgI3IalvSaGTd+B/VSmVgabdAcZQXvzuLJw+7sUn2va+DDLiO+obtRdyTQ88Ip2irqC4/+Xhv4oJ82qqASSR6as0TQ=
X-Received: by 2002:a19:f619:: with SMTP id x25mr1698879lfe.57.1550826274286;
 Fri, 22 Feb 2019 01:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20190221125250.543158526@linuxfoundation.org>
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Feb 2019 14:34:22 +0530
Message-ID: <CA+G9fYu03rd4vBK+FGDkT1F2mApX9Z-2gjnZjZo_BPGS+M+weQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/30] 4.19.25-stable review
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

On Thu, 21 Feb 2019 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.25 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Feb 23 12:52:29 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.25-rc1.gz
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

kernel: 4.19.25-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 38e5064463736df66f9eba6e725329053a0404ef
git describe: v4.19.24-31-g38e506446373
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.24-31-g38e506446373


No regressions (compared to build v4.19.24)

No fixes (compared to build v4.19.24)

Ran 21366 total tests in the following environments and test suites.

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
* ltp-mm-tests
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
