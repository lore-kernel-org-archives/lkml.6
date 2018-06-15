Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C95A2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68443208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUu87D1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68443208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965372AbeFOApx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:45:53 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41054 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965218AbeFOApv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:45:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so12143089lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 17:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8T/YC4klSM5yD7e5b1rhMfmiQw6zotEUR7FA/pQOTjA=;
        b=YUu87D1XwZ7uSuCXfFB23sajCIz3x3IMtfvohEEVR3gGYivS83LdGojBvpVISvY4Jv
         93M5yutboV8n1woSW3qu5QF3ZONhhkybXdNJ9FHrHbe+bGGoE1zVG9Xc95anaIbON4e5
         BgjO50FqwYV/49jl55XugnhGdiW4PBAmuJIyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8T/YC4klSM5yD7e5b1rhMfmiQw6zotEUR7FA/pQOTjA=;
        b=VaDnQWRihEF27QuWZbnqKtYzC10ka7lFkBtHdXH0+Q1U2Mwe8sKVdbq2cy7Td7qtWg
         0sA3ZM84qCRngrWMMgSuMy5+VoukkyFTyiCtpAjQoe6TVbDp9HnjFhp6DNkdTqUT+Yr2
         6f1IJ2u2AnjWOjaoPoUNIoeqfZixlyLMgUnRJrp2rnGuktlgFY57FNFnwjnpoGK2VqzK
         RBr2r9kbcvy8Q6fU9msobsWBbHBtk856i+VBa83MKkr1qOdke2fA1t3vGOx2zvCOusV/
         AJFsUar7iL8CTQaaPJkYniMWL9ApAPPsgARSot66Q/srmYFC0dM+LOJO77OPOXLqv39L
         AVuQ==
X-Gm-Message-State: APt69E2ZOs8c6V2KH+KFp23lA0D9gWD6IC2fowEOJWg6T01/WB/uhGkz
        viVcDPTSKL5zKieuROoo2WINnSazAofBhoFxWupzIw==
X-Google-Smtp-Source: ADUXVKIloEb1kSVL1rn2YoFIOxzONjhQoLGKye2sei5RwGnrlbFrQyHyvT6yBuWQdOdGxBxkZnd2UT+46vzjsHIumfA=
X-Received: by 2002:a19:944f:: with SMTP id w76-v6mr7547849lfd.90.1529023549222;
 Thu, 14 Jun 2018 17:45:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 17:45:48
 -0700 (PDT)
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Jun 2018 06:15:48 +0530
Message-ID: <CA+G9fYtLq0STwKXEnn5cHQGMOKxiaPfdnAuPhvpwhfMdsWJANw@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/45] 4.17.2-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 19:33, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.17.2 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jun 16 13:21:05 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.2-rc1.gz
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

NOTE:
fcntl36 is an intermittent failure on qemu arm32 for all branches.
fcntl36.c:205: FAIL: Unexpected data offset 12304 value 9
Old open bug to investigate, https://bugs.linaro.org/show_bug.cgi?id=3D3339

Summary
------------------------------------------------------------------------

kernel: 4.17.2-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.17.y
git commit: f11fc39630770031c4dd042acc5ad98adc5de301
git describe: v4.17.1-46-gf11fc3963077
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild\
/v4.17.1-46-gf11fc3963077
^ Please join URL

No regressions (compared to build v4.17.1)
------------------------------------------------------------------------

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 21,
* kselftest - skip: 28, pass: 46, fail: 6
* libhugetlbfs - skip: 1, pass: 89, fail: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 27,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 131, pass: 1018,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 21,
* kselftest - skip: 22, pass: 53, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 8, pass: 27,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 132, pass: 1017,
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 21,
* kselftest - skip: 24, pass: 51, fail: 5
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 9, pass: 26,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 131, pass: 1018,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 21,
* kselftest - skip: 32, pass: 45, fail: 8
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-cve-tests - skip: 12, pass: 23,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 7, pass: 7,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 94, pass: 1052, fail: 3
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 20, fail: 1
* kselftest - skip: 30, pass: 52, fail: 5
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 10, pass: 25,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 6, pass: 8,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 154, pass: 995,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 21,
* kselftest - skip: 30, pass: 67, fail: 3
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 4, pass: 31,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 60,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 152, pass: 997,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 21,
* kselftest - skip: 29, pass: 47, fail: 8
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-cve-tests - skip: 10, pass: 25,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 2, pass: 20,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 76, pass: 1073,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 23,
* kselftest - skip: 25, pass: 66, fail: 2
* kselftest-vsyscall-mode-native - skip: 25, pass: 67, fail: 3
* kselftest-vsyscall-mode-none - skip: 25, pass: 65, fail: 3
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-cve-tests - skip: 5, pass: 28, fail: 2
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 61,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 116, pass: 1033,
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
