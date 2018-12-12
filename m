Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9622FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADFE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hodiRD8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADFE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeLLGR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:17:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42036 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLLGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:17:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so12618602lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 22:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dnptEfIGZQNcEKnuGQQGrfxJLcTRt4F0e7CHdnM3RaI=;
        b=hodiRD8ZXlHAM2Mkok0wKmtvKJI/rweTgqf/dTzfkzki5VydjBj8rjrJm4+6Ldjli9
         4UfLvoSE3ajdE3UF9i70oZQYXCPPNbzmpxPgtKHIkmT2Kl4Zz2o3d107PRIzMTlsJ47W
         B+3swVLDVDs+VUrBg8HJ3DMnYLSvKr+iqj41I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dnptEfIGZQNcEKnuGQQGrfxJLcTRt4F0e7CHdnM3RaI=;
        b=oB7iLLds5av9Ubg3DfwZmTP+HipdH67/wRirRjC+QTmRvlUkHgAhQZ8sbveOUZJ7V4
         U9T0ahxnynRklyFei55ZJoJBu1rz6WclG1qD4wbu2zNsqPm046RmTzDI33ncSioFq4Hw
         /i3nCja8J+TkjaKljqcLG5OQEKAxcvfp9o2LjKooxi9ZeI3rO9f+JVmrHDq5zVkFqeKR
         PSu0elGxD+F1nZICTEIWuSbHyyJcGBmejFiM5rKxIa4ufO2yMm4atDFxVpN97ewGhxtY
         wlnWSBPWD+fAe9Fxc9WkyuHDS/IJR0FWNR6J+8hJHwXQhIYyCsIvcovzv2T9BFcNIxlw
         QpTQ==
X-Gm-Message-State: AA+aEWa9Fus+xEufvK33F9hqsBMZhmU/zOr7TPg7+lH74DMHtN14gFvO
        S3bUzO3Q8kZpQ6AYoyY2EPMGD8IyW9tpXHUZlVOAgA==
X-Google-Smtp-Source: AFSGD/XA+ramrXl5xUiF0ehG6ag+AW6TaPGSVVLzfhQyFeAxjqcOj3KrW/UKqC8DMsli4P3MekW4HBmHWAOZFlbH2LI=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr10262659lfj.126.1544595473431;
 Tue, 11 Dec 2018 22:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20181211151644.216668863@linuxfoundation.org>
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Dec 2018 11:47:42 +0530
Message-ID: <CA+G9fYsBUq54chCgdW2ByczJXB2zq7hL1+EGo0xZM5yE=jU2LA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/118] 4.19.9-stable review
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

On Tue, 11 Dec 2018 at 21:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.9 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Dec 13 15:16:10 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.9-rc1.gz
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

kernel: 4.19.9-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 6a09e212b52e5edf398ca6296a183187d7343863
git describe: v4.19.8-119-g6a09e212b52e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.8-119-g6a09e212b52e


No regressions (compared to build v4.19.8)

No fixes (compared to build v4.19.8)


Ran 20670 total tests in the following environments and test suites.

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
