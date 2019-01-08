Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0E2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E46F2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2cRQc8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfAHJUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:20:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44826 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfAHJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:20:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so2363919lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=au5AbbB5uiT9MPi30OZKcBGLwh9bhvJ/N7JeFYr+2WE=;
        b=i2cRQc8pSL+lkcWHkutvvftRLLYLjJ7XH3rwrFP1wAgGtVgQi+h5rlGUWkUx5fh21Z
         6LHrxGJEFvMSinJ3rXvyv4pZ7VLm9D/lt22Wqea6Ta2vQw3H77F1quhVINP3SmggjJA6
         zy/Owe63eo2vcfGMXERePlZHIx6jA/6KOvAtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=au5AbbB5uiT9MPi30OZKcBGLwh9bhvJ/N7JeFYr+2WE=;
        b=BBygrb/Nb9XguF9cinfs/hIJU2CNsDuq7OUEgVTUvbHJbY0uUG8bS2dyGxLnYbS1G9
         /VJb7pT9OJhBvRthPFs3TZ3x7xP0h3qOpEgiUzZykf5sn0roxNBqtN4qROpU8i+bMGxg
         fBNK2ueCKyPBh5+6rTwrPf/AbBO8PtnQYJ9udALcxePvoQU++/NeWqt5zvwQXrjQ7r29
         VFCWlsXzwo8W2NxhRVKHDM4wGdGABOkVq4lxY8PiRvIswu7DQbCfu1FNVHZ3ASyxsKwP
         gSKK5CxDKJTEc58mpy1Ml8VImk861yViAJy1dpX+02u0WIuqZQ8ucv1elA3+bKQtofVc
         NOlQ==
X-Gm-Message-State: AJcUukf/hGDesMBSRPTuIi/OB5eanaJTlOr/9N6YRQWa5QOyfmOQlVSY
        7Hnz7SE7kdZIss9BeARN7RXKpWEeR/agQ+7pIuwgJQ==
X-Google-Smtp-Source: ALg8bN7dEsbUajUt1MPp0JtEu6vdVKMWeoNB3IhALNaF4/Sp0qi9GC8SMNeADv/8ALlR20qHQ/jm9jIO1S9vNl43ylA=
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr561212lfd.74.1546939219951;
 Tue, 08 Jan 2019 01:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.372621917@linuxfoundation.org> <20190107145203.GB27768@kroah.com>
In-Reply-To: <20190107145203.GB27768@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Jan 2019 14:50:08 +0530
Message-ID: <CA+G9fYs3=ygmDSpr3ZqfXPXiC+TLAJbCWd6-oKcKdoPaZ6nyqA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
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

On Mon, 7 Jan 2019 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 07, 2019 at 01:31:48PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.92 release.
> > There are 101 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.92-rc1.gz
>
> -rc2 is out to fix a build issue that I somehow missed:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.92-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.92-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 31e3578310df91929c04f756c7829b6c551604c3
git describe: v4.14.91-100-g31e3578310df
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.91-100-g31e3578310df

No regressions (compared to build v4.14.91)

No fixes (compared to build v4.14.91)

Ran 21584 total tests in the following environments and test suites.

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
* ltp-hugetlb-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
