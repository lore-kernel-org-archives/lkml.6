Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-755436-1524861448-2-7995125873189237067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524861447; b=c7JUMnGEK9TRbo5fMAD4P0+yzrhm+B+IRw1oVko9SGWF83w+Bf
    0EU1x/8tlQBiNsx9q7l1euC+UzqVn2ULHTCCwd1pLxO0evTJPFWrUZL/VkslXk/t
    jP98Tvv+cDS5xL1C4s9rgWT/iw/y5jTy78OR5AnUbzm6qy0Q1SsHeQ2oDp8Ic5fS
    gRjEoLpECMRqqJ5D+uMP2aZ1GiXRwxKK4IoY8x+WBWBgOTjRD0hlU3wx7tabNNUp
    2cJmPpIIu2/ObG82F+IAPvdbc2od1wm7jh9aoS+8MYbhEpSjgaqPEDc+Qej4PAwS
    l3l5HHKWpEfBG3EX+ENg8pMEn+zac3tTuU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524861447; bh=13jsDCSQ3ND
    NLkpBBiSq637FDGgVx6Y8QVpsJKoQS+Q=; b=Rxy+8Awy+ZfmpFygWcC7k81A7EX
    r8xwiCGg9kqc90KMWoy7EZh9yrvOWh6MXVDUkVeqvOqhMviXBpvfCfizyFKvHu2x
    EneJkmvZ+LWCcJkdAZYeq4CZncpyq3j+0/yvtN8GKKXymzmzaB/Fc/k2iBwOen3z
    USt3JwdVQmk+V26fBTy3FR3OOxkI47NqWZFBytdZlolliGtoiIwrwh8uWaksaPfR
    qQ7hXpRsYQExOQJUBZmdHnjnlgVrZl28/rXrhhx1PGfDOPMRDqASYSbOX5RbDm1D
    7SIejnyKtYxs2YkeMXGWWuUHXwpe1uh8AUjzMRus13eNhH8skB+tsGTppWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bE/JtAPU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B0+NNg/X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=bE/JtAPU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=B0+NNg/X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAEYTjWWd4Bo1sgs4qQZCT2dh5IKcEk3bYuFiYJxMeSYWavvDeWRxWCZGvth/itmuIe94IJeJIgkHmBBQoHb0A0J+znDkKHcy4Gs/hU++ewoFFOZQnab
    rvCjhZBn3YaBQiiG3DCmpvE3UNPVMsQ842atLKKFNkET2Qf67zA6vj3MIo3a+5yxlMwiVD7G+E30wFtVIPEBF5L+3EBm4cgvIi8GNdi8C5uBl2ipm1/AmQAS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=D2BsPUkyXeIA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=I2ubzBl4-jJS9KkLTAYA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759150AbeD0UhZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 16:37:25 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38454 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759077AbeD0UhZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 16:37:25 -0400
X-Google-Smtp-Source: AB8JxZrOvJSUnOFAC+eo/zqMjCULRMduemvYudnAhBwzyRx+nyG3Ue3a01bWKJhTcCe9SprKqBARLA==
Date: Fri, 27 Apr 2018 15:37:23 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.14 00/80] 4.14.38-stable review
Message-ID: <20180427203723.fb6wkjgajwf6hmhr@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180427135732.928644313@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:57:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.38 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:57:13 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.38-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: a0fef4b4352d42e1d747f8c9dc2af45ea0b6b977
git describe: v4.14.37-81-ga0fef4b4352d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.37-81-ga0fef4b4352d


No regressions (compared to build v4.14.37)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20,
* kselftest - skip: 27, pass: 41,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
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
* ltp-syscalls-tests - skip: 134, pass: 1016,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 23, pass: 44,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
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
* ltp-syscalls-tests - skip: 135, pass: 1015,
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 25, pass: 43,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
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
* ltp-syscalls-tests - skip: 134, pass: 1016,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 10, fail: 5
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 62, fail: 2
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,

qemu_arm64
* boot - pass: 19, fail: 1
* kselftest - skip: 29, pass: 41,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 156, pass: 992, fail: 2
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - skip: 30, pass: 50,
* kselftest-vsyscall-mode-native - skip: 30, pass: 50,
* kselftest-vsyscall-mode-none - skip: 30, pass: 50,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
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
* ltp-syscalls-tests - skip: 153, pass: 997,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 17,
* kselftest - skip: 26, pass: 37, fail: 2
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
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
* ltp-syscalls-tests - skip: 75, pass: 1075,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - skip: 22, pass: 54,
* kselftest-vsyscall-mode-native - skip: 25, pass: 53, fail: 1
* kselftest-vsyscall-mode-none - skip: 22, pass: 54,
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
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
* ltp-syscalls-tests - skip: 116, pass: 1034,
* ltp-timers-tests - pass: 13,

-- 
Linaro QA (BETA)
https://qa-reports.linaro.org
