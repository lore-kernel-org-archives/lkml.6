Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD12DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78402147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHfs6HeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfBZIpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:45:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36801 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZIpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:45:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id v10so10019049lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6gAOmGRHH0mLiuUYvi7vWH1dzWgOReWXOTBDlq8k/j4=;
        b=IHfs6HePs+TMOUemxo794ib57//eWZZmovwVxliMmIzeVd62RRzl/x2iDQ4+Z19EdJ
         OQ8r+1arLIU3XYVPKUd09jtaoKyHoalurmp6F99x5zpyLazKWsCv3jQO6yGPch/gZItP
         wKULVA1skmC+fQscap2JeVNzK4Rb6n/WrzTk7KbsXhChH1Uh8/fHaiEML2HutiVVbdGM
         ucmCS1wMyDip6ILNzdVnKS7w+WnlcCoVMiS0l+MGEnTvKI5MtJCFmHgjZuY+7Z2j//Pk
         kSox35vqQCAfUNLmfjYcPk+kGDzJccb/E7VOLZTCwlit0ZyBobPbFGrz0j2yzyiG7rRi
         npcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6gAOmGRHH0mLiuUYvi7vWH1dzWgOReWXOTBDlq8k/j4=;
        b=DCOXN5l921tAkMS/Huw8KEqoS9Uj/hALTzx4JOP4bUvSx0lEAzHfmj0yLmj4sfHKUb
         62c85fzv0bqGC6Netams0EjTZcyYsUjeUng50vBhmT+mRagqdogRkK+OUdNejQg3gUTf
         jGH0O674NEY+kCgma2N6RfeCqUbp5JLvl4Z6HxB0AO5QyyorfG1lLDFRgx3Oo7Fg2FgG
         JxrnMOkGpD3dljJxLhXJhlJCQLN5JYhdr62wzKQLcWsoFu90OSQjhe3yJjJiBFI98Zdk
         1tWi5U2JnBkRZGW6vSVLZ6T4Y2a+ao9ZySSYMwSqDpTNVHgU2BOPFdGUz7Inn9quSN0C
         JvEw==
X-Gm-Message-State: AHQUAuYj0RM+vuum5PI0L5JYOb6Gc88oRETkSaeXEfAPF6wSpJZs+cRz
        ISCKI3pN3dey/ktN9V8RF4wzbocYUl1A9Wa1Yk2al6L3K0U=
X-Google-Smtp-Source: AHgI3IaqjiGPZzI8fr5ge6mjfhx+UDpHCA6qo2yZYcsX7TcAPJssTlD2FC4fGmYeL2KjCRAMiR102tYiMNvTEOdPK3E=
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr13359996ljj.136.1551170708608;
 Tue, 26 Feb 2019 00:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20190225195034.555044862@linuxfoundation.org>
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Feb 2019 14:14:57 +0530
Message-ID: <CA+G9fYst4+-HndG89AB=Ad9eC=7PtF+o3ZXgZahrnWoz=NmaEg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/71] 4.14.104-stable review
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

On Tue, 26 Feb 2019 at 02:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.104 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 27 19:50:01 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.104-rc1.gz
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

kernel: 4.14.104-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 470aad464377e6a50dcafe2ad2fe510166d1c4c0
git describe: v4.14.103-72-g470aad464377
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.103-72-g470aad464377

No regressions (compared to build v4.14.103)

No fixes (compared to build v4.14.103)

Ran 22568 total tests in the following environments and test suites.

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
* ltp-dio-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
