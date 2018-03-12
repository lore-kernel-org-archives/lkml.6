Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3903807-1520838640-2-203593147514735804
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520838639; b=jAbG04MSumpJWn/Ld9zhxZBPzhxplfDS8jDkPhMDT30/On8
    emoLqZAKjfkhDwBSzzLNuDB0lXRAn6Bwit3TFq5nVsvrl9OvZxcTrqqQVF/RD1Hj
    ywH89zZz/VXSlvX6vqJOfE2VGMU41PIfjPIJYmCCyRsJYgvYvyp3BRm9tAqYyoHp
    8KwfXzGYnmVdHlNjM0xPb24ItC9aq2PLCQU2ktLPqgffNK4U4GpzUddpbtaR8xp5
    Z+cMVpDzKQQxqsjnKE3qg0Bj9N1rVPxGg4rCRQbcsKKitj38FOd3nEZGPrYXcgFL
    WCmPCwGsTd97s/E/LvnyLYhuGnXmftjqBpvz6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520838639; bh=tmFkperTT9W9iz/3dQV/hp1gnGQvfSiCCFnn3kRk8VQ=; b=w
    UeAEPr+e+H9u9+kiVRUzs5zRcybhBX64+wxuquGJwb6TK4qED6fF+wVXoCFuTQkO
    Z4BE/damNtC2HSbQVJPiShuIUhvFI6LWA3vxEbgjE7L/70neZ8kTJ8EpJNgEOsge
    +wYCvPdQiU9JWrXjiDci3bB10vjwXf1V7tsyw3l16Hs+NsIoH9Ebuyl8K5RTsH0d
    u9FNciE4S5MTS0UQtG+shv1FZEg4NWQHQ1KkW4BiwoyvY8INzbay3vLuV4u1ZEeh
    ZNO65I5A0SbpZwKZ50i1rck+cUw6mtZod4YKjOoOgFAlir5+/DcM2CYruYZBdsh4
    QDxak+OYjUGRFwGw5rKAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LEWUm5y9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gu7o6CTX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=LEWUm5y9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gu7o6CTX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeCLHK0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 03:10:26 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38485 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeCLHKZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 03:10:25 -0400
X-Google-Smtp-Source: AG47ELsl1BbpynLluYT1Zbqh7ZCEq5zJg2iE9IqS3OhP8oQknkQiYpNalQiwraKcdbEWuBW1MhpkcxRg9NwbgwN0w34=
MIME-Version: 1.0
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 12 Mar 2018 12:40:23 +0530
Message-ID: <CA+G9fYs9DOQ1T5DuSKHN7gM4qprcpiVt5u-U9gDoZdi6VbupiA@mail.gmail.com>
Subject: Re: [PATCH 4.15 00/11] 4.15.9-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10 March 2018 at 05:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.15.9 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Mar 12 00:18:21 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.15.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
Extra boot failures are due to infrastructure issues.

Summary
------------------------------------------------------------------------

kernel: 4.15.9
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le.git
git branch: linux-4.15.y
git commit: 3eae9e93d49241dfb30be1d706b68d056b1ad29c
git describe: v4.15.9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-4.15-oe/build=
/v4.15.9


No regressions (compared to build v4.15.8)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 48, skip: 17,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 999, skip: 151,
* ltp-timers-tests - pass: 12, skip: 1,

juno-r2 - arm64
* boot - pass: 21,
* kselftest - pass: 48, skip: 17,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1001, skip: 149,
* ltp-timers-tests - pass: 12, skip: 1,

qemu_x86_64
* boot - pass: 20,
* kselftest - pass: 61, skip: 21,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1001, skip: 149,
* ltp-timers-tests - pass: 12, skip: 1,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 41, skip: 21,
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1053, skip: 97,
* ltp-timers-tests - pass: 12, skip: 1,

x86_64
* boot - pass: 20,
* kselftest - pass: 61, skip: 19,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 62, skip: 1,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 119,
* ltp-timers-tests - pass: 12, skip: 1,

--
Linaro QA (beta)
https://qa-reports.linaro.org
