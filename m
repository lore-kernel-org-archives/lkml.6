Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335CFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E166F25DEA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dA5oq/eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E166F25DEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeGBNrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:47:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32932 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGBNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:47:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id t21-v6so12608257lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k5XnfehcZzzQmurNzVebqeGem/PP9HePp/RddC628qU=;
        b=dA5oq/eM3xYahISuWRWSjeiQlE871cADGyx0EAfi4Ws8jIcq3rsiHWA7hNe6ga8B4T
         JHPil2woxB2Dyv+IvrB8o4q6a0ztSsrnrBAPSn9Grsqgabmj0dyRZJ3OJy6hVW8JKDrW
         DW4P8N7ULQnDwXT9qbWhVPTrC0jvc07gtNBS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k5XnfehcZzzQmurNzVebqeGem/PP9HePp/RddC628qU=;
        b=EJAcU2s+Le77tNrSBe2gwVuUlPFj9RW9tkwqivOpB0Rh2JxIFwyzUtzxph2TuPDHth
         HNSPBMKqt9CAZYQjJHuSyb99mdgnVBiLLv4R7dtJbkdu9Q2MFjynKPP1AFmZsiWZINrZ
         WWyoBgdfwZTuSmz1EzGoNt+YdBKv7kqC62T4SDzZztBjSpTgWY7PMfBF7Tlf7AGfuY7p
         bJHYocnuuWAOd9qYX/WbkhLWSwnIOgTtZpnAE2RZBQ1IW6VO8uwv3C4inYpqClbPX/O0
         SXJu2Osk68NnagbX/1W0TSqCScE3EoLrsg/qV6HTYVY07UUDAf1LAvW/P2RxfBvL+dtd
         eq8A==
X-Gm-Message-State: APt69E2gMhkouJRcbMmqcK9Da7WlMkDcFMvNb2lZW2K+vEzhdmA4OLCb
        WZxDCCYOF76O90xlYNRnOi9yPkbnO40RJA47q7vAWg==
X-Google-Smtp-Source: AAOMgpftUZQv9HHM0iwBgbyzFmEmVKbwy2vzVjYuqWlwKyaSRWccMHGSmwhdpexDxIih5DDvOU3eej2pLuuWMPWJxq4=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr4423419ljj.142.1530539221489;
 Mon, 02 Jul 2018 06:47:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:47:00 -0700 (PDT)
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 Jul 2018 19:17:00 +0530
Message-ID: <CA+G9fYt0qqmETZ81-Z+ZQ=5scjEQ0THhvE154LVV4yv8vomTkA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/101] 4.9.111-stable review
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

On 1 July 2018 at 21:50, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.9.111 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jul  3 16:07:40 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.111-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.111-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 1e77d8b070f992ef9b838eda83754b4a6390b510
git describe: v4.9.110-102-g1e77d8b070f9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe\
/build/v4.9.110-102-g1e77d8b070f9
^ please join url

No regressions (compared to build v4.9.110-103-g83d1f31eb384)

Ran 11429 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
