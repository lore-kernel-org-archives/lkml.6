Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524C9C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61C217BF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIvIjfr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF61C217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeHENzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:55:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41532 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeHENzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:55:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so7085011lfe.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fCrCMajiSpDrJx6yxxIM4scVj6JtaCQMiAVMq1Tv5GU=;
        b=XIvIjfr7XRLrAdBYsTFHrZ03J6b3u1F/AvrLJE99QmUhjmrkye+m8cuDy0RB15557l
         1t2Eh4BiDpi1gfDSbYn6hxJD77Xq/ljRo9O6nk79pmIdbRf38ZMagBM1ut4lcpwuAsOc
         VaNEtQKY64Jz5MgXQT7/m6hY+dyzQrVAjCyJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fCrCMajiSpDrJx6yxxIM4scVj6JtaCQMiAVMq1Tv5GU=;
        b=hT8w48vNQmvYhPMgZF8Syk6nEGqgloS18y0DW/MhADAWjDQHmvW+YHV+KTuio8fXqG
         OIesfmrlZ5Xt5PzRPCKJFoLnBT8c8S3WeD6YIOWzu01EVurh5RZtGS5kHvAHFipgwKeb
         VzsVCmGKX/8R3vdK3vsnYoMkYn45xTByio8i4RZT9XhdP6wkCIYXZM745scr2b4UJS+1
         lWzYpCquzuAHhZ76uigcdx3f/6nfe1eI23cHd1khUyFSkHvbxalCZ1xihOMkPeOwtJ4N
         MqZYYi7jhmo+PzTB1VwTQaDcBuAsOFZHR1jDxC7mI5fMARhGtW1UmpFIld+uWVxJSa1g
         ftjA==
X-Gm-Message-State: AOUpUlFekVecxdJkIlzG/ru5srvCU1YKTYNoZon5qiD10RtUztU/NfA6
        X4VFw2mlhe7i/QjXW2307NCmbo1qn8ry0ae83iLL3A==
X-Google-Smtp-Source: AAOMgpewQ7PMgT0PzWr2501DgRS/QPZ5KMK/Vf+6BUoI64fx1nQQo3Y9BF9fn+vbplp5ED9bgqiivitJqDu2AGVbypU=
X-Received: by 2002:a19:9646:: with SMTP id y67-v6mr8539636lfd.130.1533469851020;
 Sun, 05 Aug 2018 04:50:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 04:50:50 -0700 (PDT)
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 5 Aug 2018 17:20:50 +0530
Message-ID: <CA+G9fYvP0J9C7FZZ=TNb7iut8qd_Yiarn-9feg8UK9q8gzKQ6A@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/31] 4.17.13-stable review
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

On 4 August 2018 at 14:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.17.13 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Aug  6 08:26:21 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 53a78f5361967de09bc2ee060a68cac8f79ab4f1
git describe: v4.17.12-32-g53a78f536196
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.12-32-g53a78f536196

No regressions (compared to build v4.17.12)


Ran 16416 total tests in the following environments and test suites.

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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
