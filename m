Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FCBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AAA25DC1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmpVh/gW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AAA25DC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeGBOXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:23:02 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35817 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbeGBOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:22:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so12195637lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MSpoUNl9bI0A4Y/NNKOpQyaeykGpII5Kp2/XR5vnvuo=;
        b=AmpVh/gWhcI8M2ckNlwvnHTbGREVaJdDpQ3hmoC0uFvPls6tBVkvocuuEU4vwLCYvN
         QnlHWdQQ2uSpTaokLcuh6//sVBzQGReaXzSj2ivIDKkyiTXlefLyWb0J2MUMYeiK6x2N
         ZB9uf/DiFjZsbOhc1OQ/rkjgdIPAa8sCqsv5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MSpoUNl9bI0A4Y/NNKOpQyaeykGpII5Kp2/XR5vnvuo=;
        b=OSvEZwcrOCcRay1xKc/dlok/zEwr5UqIfOaaDzDnqEzAdHuBNck/AgL+A3Gaqh0Kth
         kyL7jlglkXtuJevMKNUEercRmptSCUt7IIcVfW8iHWiFHtYuLqd+oF0FnabqjHlFVtcu
         4zTxWN3JWHHjq2RCAbvcdDOm+8m2C+dIA4RiEwIeVsjog4P9CgTyNgaq8vH9CgWCSKcC
         hZ2NwBBVn9skEPUuOh4VQWFJWqeTpA9oRvoVpT5AdIUd/3sGzrJY21LR1ieKcpONRPwp
         Kbp2m90BehBPvKRX5NhWHtVwxwoBq+n09gLQMIoOlLnxQXVJIZQ5puS0cc/VSBz+41CL
         430A==
X-Gm-Message-State: APt69E3j08CMKGni5SySzFewvFNBlSWUa/X+Z8sqIvjUf/Lg2pXi7r7a
        k65h14FLF9hqeT0nbqnMRclGK40gUNV3oTOeFQmatkXM0oE=
X-Google-Smtp-Source: AAOMgped57QAbWq2mkjRwUA0z69GbiOpMcKRhdFPsch1xZlnL5/YY9dI6YrYoxALyG/44ti84hnOcUZz8uXVOSITqYQ=
X-Received: by 2002:a19:c1c4:: with SMTP id r187-v6mr17490069lff.90.1530541377101;
 Mon, 02 Jul 2018 07:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:22:56 -0700 (PDT)
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 Jul 2018 19:52:56 +0530
Message-ID: <CA+G9fYtqrq3YuhztjZm8NjdZVwwRMF4WSeJwhY5VSpKmx_01Ag@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/105] 4.4.139-stable review
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

On 1 July 2018 at 21:31, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.4.139 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jul  3 15:31:30 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.139-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.139-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: a2f8445cb8b24e35e0f3d8ebdcd70236ebb6acec
git describe: v4.4.138-106-ga2f8445cb8b2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.138-106-ga2f8445cb8b2


No regressions (compared to build v4.4.138-26-g2197a4466680)


Ran 7156 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
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

Summary
------------------------------------------------------------------------

kernel: 4.4.139-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.139-rc1-hikey-20180701-226
git commit: afc4165cf23e88d709720057aceb8cf040f62ee3
git describe: 4.4.139-rc1-hikey-20180701-226
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.139-rc1-hikey-20180701-226


No regressions (compared to build 4.4.139-rc1-hikey-20180624-224)


Ran 2587 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
