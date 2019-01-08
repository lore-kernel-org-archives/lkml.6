Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A731CC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7749E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXUjZfLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAHLRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:17:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38419 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfAHLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:17:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so3066652lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oox/dDwYR/GgmXprvJ6EDJvGjz5tx05lpj4AxrG3wCA=;
        b=TXUjZfLP0ypME1ojlUbUBwB0pZ2JRJxG4C1hoYggf4/KMCaB0anue/zmaYSxOHXv3Z
         TYP/Aj/y/hwGgP8nosr3x9VEkoGWGcpg+mFaV4EinodN4sTNwadaKD4K3uA7eH2dFphl
         Ghh8LaI0QlmIhdGwEQ2viKf1bM3R4YX+ts754=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oox/dDwYR/GgmXprvJ6EDJvGjz5tx05lpj4AxrG3wCA=;
        b=JNKdVQpaatLlLb1ZuVoz3DBllo4YdvpH/Gi9yomEfWRL8OAFfncJTOYDq5JqfNuNHm
         fTDrZQp9RthidAUL1/4l8VQk0M/3JWcaYuOpwbIxqhQvGrg/LRnrcVNDQ4nzFCyYoUWZ
         /PABTahIJ5KI61/VTbhDkNezE4cJ8GivigexmQ5zBJ6EBWUNfNE+6NN9L2BnpeN4SS5x
         BONKW5U4C1EKORBzN9Ukr5c6imODvsIDRRWogg/KHgwF+j7s031qwWE69N8EGkop5mKN
         qUQqSVY+qrfPp31Ny9xqcrieB+2AxCbegRAimhacLjOIvVluRx2rQa9G4XmDk7ghOlHE
         k6Uw==
X-Gm-Message-State: AJcUukfGKZNvq4j7818tVK8AUD11b7GUHphBP/aD6SZPOO38NnpLv1Sn
        lpNOCv15sHwE00T9sTL2dz/fGEAxFqvYKPpfjllUfQ==
X-Google-Smtp-Source: ALg8bN5M4C+LhUNHz2K/3mD4Bg5WoxmMxufH9hLctY4mBx3XCYvxQmgkWoKILqd2eiENMMI547G43OVwNI4LYbKQwGc=
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr708380lje.88.1546946264271;
 Tue, 08 Jan 2019 03:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20190107104452.953560660@linuxfoundation.org>
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Jan 2019 16:47:33 +0530
Message-ID: <CA+G9fYuqXywuKA3u_G_T53Km90Z4fCf41CTtMoPaJPPm_2FHLg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
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

On Mon, 7 Jan 2019 at 18:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.14 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jan  9 10:43:54 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.14-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: d7e734716c5ab8dbe6b25dc7200c54f9e82f54a6
git describe: v4.19.13-171-gd7e734716c5a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.13-171-gd7e734716c5a

No regressions (compared to build v4.19.13)

No fixes (compared to build v4.19.13)

Ran 20546 total tests in the following environments and test suites.

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
