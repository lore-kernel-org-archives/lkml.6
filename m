Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C924BC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE27213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeGUS8Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE27213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeKTSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:39:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45610 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeKTSje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:39:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so668086lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=92OdRUHqBk0lw/gRMvbXx6EtORLqUStrpFH3ienDBdE=;
        b=eeGUS8Pb1haLyus+q1Me9J9cXppj2wl9d9xMWV+c5v0bxUJoDz8arlLDhFRECkICCb
         6zPhx5CNfe8RAqkoyFr8s+dTcN7AJwSmxwv7xYw4WIBNEOg/rv5sSAEbyrE8fl4Cjv1N
         tGt5yOESFhIJuDf+v/KfAfJHODvIeI9mrTMkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=92OdRUHqBk0lw/gRMvbXx6EtORLqUStrpFH3ienDBdE=;
        b=T0ahabie931gdJ3K9fVW/ZCfmdhWEsNfRRWuUldqACMTTMoH5g2UBY64V+txQkKepX
         TTugdsMDjAY9WB5zO3X6m9mFB4Jz6JN7KT0IMs5b714iCZqlOGHssyX+Reey1648OTfu
         qDoZr/xZFaR/nahvwVRwN7EdhMzd9M+bvoRrGq9fjilbQCQQ5qus0bttbl74IiigI0fd
         OQCHOW3xLbcTAQWcxC9hp0fohuoXIYmPL0fQ1JmHEHKA/ZbRZol7IQZA/4/0sRlnmrh2
         oQ2u5PcmD156N085AMZ+Q5k72/LMD7CLYYXGfqDmyDZ1DE/IOwM8y9K/XWIMuuzB1ejy
         LRkw==
X-Gm-Message-State: AGRZ1gK9ebJYAiZs33s+NpB7Uc3caccDLN0idon3AQ22iktEp0uK13EG
        PTIrkpgaeGkXCR7cpTZxasPFuBi5ES+dZONFKLrd0Q==
X-Google-Smtp-Source: AJdET5dVOGZ8vt+RRRWsf10NiFKuNGVNjFuwXK/FHfcSEZJu9Usb5NJ/FqzwhQzfJ4rNwwy4GBWVdYQIicCjypZgcHg=
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr534196lfe.152.1542701503201;
 Tue, 20 Nov 2018 00:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20181119162612.046511542@linuxfoundation.org>
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Nov 2018 13:41:31 +0530
Message-ID: <CA+G9fYsunFYiSB4eCLczcLJoH4tHd4w69XyPbNdwdr+cw5S7CQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/83] 4.9.138-stable review
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

On Mon, 19 Nov 2018 at 22:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.138 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 21 16:25:13 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.138-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.138-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 4ca3f6d71162e660e35f62700d1dd2486feb5e4c
git describe: v4.9.137-83-g4ca3f6d71162
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.137-83-g4ca3f6d71162


No regressions (compared to build v4.9.137)


No fixes (compared to build v4.9.137)

Ran 21057 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
