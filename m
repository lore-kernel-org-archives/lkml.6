Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4199CC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115FC205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWgM8lsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfALIGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:06:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44207 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfALIGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:06:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so14873653lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S/uldjTaxMA7rcdjE54d+R3ZliQFRNndjeWTiAff45w=;
        b=fWgM8lsq7Dsyz3+S95/GG1UhSgA7lvRhm84ps8PAoFXc5R6jjIUlVYUSWz8tLkEi/6
         Shd0g0Nr1PayE8m+QmMsgFJoJK0DGKQkEm/1/2gkRHxWQN+dUNYoWJbwYFdhKv4fLKxL
         ftTUT/1JDivyXs/NurcsHWjrdmSkee34kztUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S/uldjTaxMA7rcdjE54d+R3ZliQFRNndjeWTiAff45w=;
        b=QOJcuuogBpRJbEaFNfdEbmj+p0Yu75afN2YjYp7k3pQpcK+NDm851N4y23Ki4HoI+b
         JDhr/IsKqXTOX75hks2DQwDN6Xr8BcMzNObsS+iatt4h8c0e8eT9i5sLDzasUnfhsy9X
         Mti6RBIadqfj3cHbKsU7+wBgfEgPknNe9m8FbygmCX3eIvGWMJ1gkMjhc5+SzoWXAlCD
         xoBglqlHDYf45D0G8c1XwOujqHTiIefz23glgkrADPlLpFBfFeP21FWbIUXFxXTwCJho
         BFkUMeVifhVd9NGNO4VH3I4aR5vqHF3k3K/J4Wm/Vt5uor5ZhOb+G9S4IDcG72r9A9hP
         bV1Q==
X-Gm-Message-State: AJcUukdTGb9b3wx0RjrVyEWlxJsLVAafKtzZ4eAPV4msqza7bQSrcf2i
        UpxIgbZL46CacL4KCJrQacYcB4wwj7aCGkBMoij4Yw==
X-Google-Smtp-Source: ALg8bN5Um7VhnC8MioY94DZJ1zNMrvXJ/r4f9CttTQej/f8l5S5AUi1x3/IiyeAc5eIQ93swLzoa7Ly4BnY5Ff1AOn4=
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr10233088lje.110.1547280407527;
 Sat, 12 Jan 2019 00:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20190111131045.137499039@linuxfoundation.org>
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 12 Jan 2019 13:36:36 +0530
Message-ID: <CA+G9fYvzHiEav4gac0MFKuc0_+SarW9AYjhwbipJWWaX4iKP1w@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/88] 4.4.170-stable review
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

On Fri, 11 Jan 2019 at 19:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.170 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jan 13 13:09:58 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.170-rc1.gz
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

kernel: 4.4.170-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 128af9be4733498f65f01b4eac6501cb09d412f5
git describe: v4.4.169-86-g128af9be4733
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.169-86-g128af9be4733

No regressions (compared to build v4.4.169)

No fixes (compared to build v4.4.169)


Ran 17041 total tests in the following environments and test suites.

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

kernel: 4.4.170-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.170-rc2-hikey-20190111-350
git commit: d76407a74575c9f6e23490bd259d81ecdac141c6
git describe: 4.4.170-rc2-hikey-20190111-350
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.170-rc2-hikey-20190111-350

No regressions (compared to build 4.4.170-rc1-hikey-20190111-349)

No fixes (compared to build 4.4.170-rc1-hikey-20190111-349)

Ran 2756 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
