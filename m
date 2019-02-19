Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E5C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527B9217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVhLeUly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfBSFsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:48:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43346 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:48:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id j1so13980601lfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C8Taos3NFSnz5nWgodsmKkELtojewQT3skv9NRKOlts=;
        b=mVhLeUly50UisIDfCz7+2kxSICYKaNhGeWvbw9L/fIR7U+lQhrLyogvscs2LGxr4hd
         hZu+KZj+rycOq7eHnpRXbt+FD19fKnSlyViDrEHe9yJABNxg5/2yEl9v99EHTDRcNzfn
         fCZ1RFhjDkm0ETTkEgMpZ5kIZLctbRLxHLNY6dyNvVkT7TCiWTJvgy8Mk53HG8oRe5ac
         XPQGJ4CjHq8ZD+UY7zcPyk03Fx0iP58NLUbJtJDUlC16kYbaqOW9J6nJG1hHPdWivtr/
         DzyFtp+H5tIDVd9sJged/HEU0bzKSDt5b5OtaOt8asAYimT5amHkcoqgjyOyVZzDpS25
         JSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C8Taos3NFSnz5nWgodsmKkELtojewQT3skv9NRKOlts=;
        b=bDD4kJ/Qpt+rjG8wS4oYDTO2hYp6wkM0fNHcABO7rWH2YcaOxp6Ejrk4B6w9O/JX3q
         G2dMq3Xh1DWRqBHbBmfvES7unxOLBAtryIdp5aX8xWah+GcVV5nTh68Gsl4+pMMLhslK
         gz8VHsE4jJqtTsbDJ/YCPseeQOQ3YWbEfgrTG9mF31+nrqNV2kyjydH+XjFEBuCKt/eS
         pTp+m+lVHdv2s5bOQDm83M8N+MejDJ4OPYY6HzeUgskVx998VkJNHUqBcdhQVtL53Uju
         kCKTZm6iEIE4bGXEMhf8pBRVmhkKRfcoKRQ2sB+9FNcuLClTA2a7xb7T+SFgNSuMhULN
         0cEw==
X-Gm-Message-State: AHQUAuZKYhs2XkSQqqRqooiGQXD0Ur5deWCrCY7BrNZc5I5zqcAQDuho
        afMaritj95xjfaOCNMGhAkk3BDGnfKUztjJEikzETA==
X-Google-Smtp-Source: AHgI3IYUZJr5KMvMvqp8+3AIiFXISGR2CQ4FAxDcqiNvTBcf7qME2vU882/xhpLzpwBEJ3gdD5NpXFBk0vqfcxEtqWE=
X-Received: by 2002:a19:e347:: with SMTP id c7mr6566988lfk.137.1550555279540;
 Mon, 18 Feb 2019 21:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20190218133505.801423074@linuxfoundation.org>
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Feb 2019 11:17:47 +0530
Message-ID: <CA+G9fYuQQ9a3Rv7deONDRQoqSBC+xmqfMSShiBJ7UM-yfxkVNg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/62] 4.14.102-stable review
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

On Mon, 18 Feb 2019 at 19:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.102 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 20 13:34:36 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.102-rc1.gz
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

kernel: 4.14.102-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: fea4e6b46436daf1982a367f638e3f5e0ae1bd3f
git describe: v4.14.101-63-gfea4e6b46436
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.101-63-gfea4e6b46436

No regressions (compared to build v4.14.101)

No fixes (compared to build v4.14.101)


Ran 22429 total tests in the following environments and test suites.

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
