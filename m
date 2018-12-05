Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B88C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6122620878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+UW16dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6122620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeLEFTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:19:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41071 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEFTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:19:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so17083294ljb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XW6kdcBAUoYE3uS1Vd6FCukQLwCbD9Vzze9IZ+QqcVQ=;
        b=C+UW16dxEaFRdxO9VQSFcuBustf2YQ8IK4SdPwxynmQ14oFF93AuCcPSuFcYIjNMwd
         lNRObEApFD+7fpyqCuqOfMjcF/O7C8c7wlHHccMIrgxrAVGh5SeRe4ONAC6XX7nhpWRQ
         sYTfhe0XK075Y8afxBCfrObRy/XJTbRsbtYN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XW6kdcBAUoYE3uS1Vd6FCukQLwCbD9Vzze9IZ+QqcVQ=;
        b=Cuz/8KkDOa4CLjtqsdaPlTLJ8mdK4IIe4ihjNLycf3A/CfzdJD4oKaQ/AhJT8xXfJp
         wvf16kIgCgsOJES1q3jsqZk/servpQ0UiAiI9mVgxxBxpWwsJhNIN5hi9jnaIMCJWlaE
         1NkbFEGc9eWbbpsatT7Zbj1VJPVqQX1IipJ0u1f441kMp3PfKqI/ZQKxsPaIF/e8Xekd
         sTzFAbdgSskwtt8Ajdpess6fWGGDqF2/NfTZc6ypa0orKTSpY/ScXvAikP9BEK/S2+5W
         zDLLqDKVvBcNvp8vOpAEwZPxDlCDYxap2bueo6VvsCBTo/pOa9zTRQQt74yqH4WCMIf7
         AXTw==
X-Gm-Message-State: AA+aEWYebUCaZW5mATY+jVAxHoLXUy1KONXYRfGCB6RLDlYaAvIAQe8V
        1Yx+2yRrpSrD6gYhzYHL0FPupoadeVaBLp10USgViQ==
X-Google-Smtp-Source: AFSGD/Ugwfcoupc61AY6YTfEgYkBnVL440ZirDbc2Lerq0Zja1jsQyMC0pTMox6X8kmmj31M0vTOvxYb93TwEDQlEoc=
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr12756167ljc.77.1543987150731;
 Tue, 04 Dec 2018 21:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20181204103726.750894136@linuxfoundation.org>
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Dec 2018 10:48:59 +0530
Message-ID: <CA+G9fYu=P1FQG86bct7=EfWiWLGqABpJr=Rgsn0bvZVU=K09Cw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/146] 4.14.86-stable review
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

On Tue, 4 Dec 2018 at 16:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.86 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Dec  6 10:36:52 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.86-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.86-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: a5c883b384be3a583f2875dc44c9ec3941803121
git describe: v4.14.85-149-ga5c883b384be
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.85-149-ga5c883b384be

No regressions (compared to build v4.14.85)

No fixes (compared to build v4.14.85)

Ran 21468 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
