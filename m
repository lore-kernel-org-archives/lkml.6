Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13CDC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F7A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RotxR4Tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F7A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeKTSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:33:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42529 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeKTSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:33:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so666635lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VLM1dnE0u953VMSkIZPHqqQoArbZHCVkJnO7cDlBFlA=;
        b=RotxR4TujpVLjqW3ZVLDVz3/Q1Au57nNwgopL9GoHo8a9B89dOqfgZolU4Z9X4uYMK
         CrcFcZB/VJ20cRaFd+LOqKaeCrEJ0S9e9ZhICxJP/HzmkJJyA30VsOHy3FDe4RHTk2XE
         dPaa/BaBPNIrhaF8cBPAQWQdTJ0KiVGRkTTOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VLM1dnE0u953VMSkIZPHqqQoArbZHCVkJnO7cDlBFlA=;
        b=UNSXiPACZQfGEbW7x3mODB8UO4DoMCYP/E61X17jshSgxXb1P8x48qkjREeDUj+k6R
         OVof/nuauV3hkHeKxBlml99ptK4OWqzTjseSDnc2HDxKmzHJ5LBuWd25OWEvu7z3C0j8
         SAyVzpEdEA1jZljdaR4a/KvXBBg6SVtb2PyRR4j4dhjV52gEonkF6mpomRPR2/7X837M
         f4nSCpKQqcA7EQRtZn0BnSbtSRXDsGUOlGq1HLSf1QOtnjnvtoW5D7L9emUfWT0i+XT/
         ekifZw26n7UnxzmLavQrHkUY001PJ3/TVMtA8g8lpK1jxKAXTjJ2YTIEa/wvrQzgI0B5
         KSlg==
X-Gm-Message-State: AGRZ1gI6RL3ApsIa2CacMS/4N1SQ6Im3mik5fKBhCdemhDK07NAYhuI2
        sDUYinWCbBFlNFBc4yjiD334tGQN+8BXVEwLs4sajw==
X-Google-Smtp-Source: AJdET5fSKj6QnxPgxIn5dMRBoMJcCtbNzngZZHFV0wMFIr0sE/GGNqEphLW7KgnU2yX7YO+e8vIr1Io0kyHzEnTdC4A=
X-Received: by 2002:a19:d58e:: with SMTP id m136mr613873lfg.70.1542701151284;
 Tue, 20 Nov 2018 00:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20181119162616.586062722@linuxfoundation.org>
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Nov 2018 13:35:39 +0530
Message-ID: <CA+G9fYvn6UhEL+f2Cchxb+winFWEmkCzSpsAH33+dwdeF4H12w@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/205] 4.19.3-stable review
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

On Mon, 19 Nov 2018 at 22:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.3 release.
> There are 205 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 21 16:24:55 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.3-rc1.gz
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

kernel: 4.19.3-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 857962e4c7ee68cec7bbf720850c80d2ec7e5777
git describe: v4.19.2-206-g857962e4c7ee
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.2-206-g857962e4c7ee


No regressions (compared to build v4.19.2)


No fixes (compared to build v4.19.2)

Ran 19858 total tests in the following environments and test suites.

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
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
