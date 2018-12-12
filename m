Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A648C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F36E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6BWpgn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F36E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLLHGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:06:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42102 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLHGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:06:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so12695753lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 23:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d8R8hK09omrGskR9yXDWRHSVvKlR/7wELMDlfN7azDk=;
        b=L6BWpgn1QldoJR98LHNq/O1mpYbLMS7PVL4N66jwuwJd40EN+tSmDPG0PevFFQHcsb
         r1LSohcMhTgtYWg1zeqmNnDLPQFc5/HyBe+8HVoLKUDQANB8/dbTZOl1rHJbasmBPXSY
         VUG6pGhMBvQleHMvVszvonPnNZ2/n64rB5wVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d8R8hK09omrGskR9yXDWRHSVvKlR/7wELMDlfN7azDk=;
        b=ZFu+giLmj0B04+qO9ZtuC4onGjSaSDiD1nuPvsymSCLmZL1p8fMbP3K2JhIe62AaYm
         Y08cQNqzusCQeYviYpMJjBwTY+Q0qilmF41ICNqk5SP/t63loYdo9VE3T9NEWqRmzZ6Q
         EfElaq5RshNs81K0MYnIldqPfwYPt582q0Be+CZ+ihb6x+TtZX5YhGV41c5gsQtTfVyw
         4JjBEyOr2iqb+AOVUVDiy8qpzO/riCMLM+5tlJ+IT7FnYwlhzHzCdDtGSSvZIoUVcg8R
         8SZxkRGP4NGrru1bnFDPSn8EB5rreck0bKftxXDNyFHjEv/ZcgLP0dUyD1IuGpD49C1L
         3mZg==
X-Gm-Message-State: AA+aEWbEqKa2YyDNpbplMssnWnR49UIIwX/rybDMEOp0WaPLrxDlNg/v
        TdX4MmWU1Gp6vA9VWpNrPsXzfj84/HbTOWYcDF6dm2ePAwo=
X-Google-Smtp-Source: AFSGD/WZ5CjrrsCGrcHNNvSkR6aPdrI3lm+X0xE7GXQsmvkHm0OkZv09I0N8JM9TQoE/8FxTLTiLtY7jbJgtBmM4Pd8=
X-Received: by 2002:a19:d58e:: with SMTP id m136mr11880951lfg.70.1544598359012;
 Tue, 11 Dec 2018 23:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20181211151606.026852373@linuxfoundation.org>
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Dec 2018 12:35:47 +0530
Message-ID: <CA+G9fYvJHZ3ry7t-==geYkGWvYRTi_LkPD=HD=3pOuGB6PWDzg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
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

On Tue, 11 Dec 2018 at 21:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.167 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Dec 13 15:15:44 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.167-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

> Simon Guo <wei.guo.simon@gmail.com>
>     mm: mlock: avoid increase mm->locked_vm on mlock() when already mlock=
2(,MLOCK_ONFAULT)

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
LTP syscalls: mlock203 is been fixed on all devices.

Summary
------------------------------------------------------------------------

kernel: 4.4.167-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 216a0be637b7dbf8db4aaad9810aba4ab15bb09c
git describe: v4.4.166-92-g216a0be637b7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.166-92-g216a0be637b7

No regressions (compared to build v4.4.166)

Fixes (compared to build v4.4.166)
-----------------------------------------------------------------------
LTP syscalls: mlock203 is been fixed on all devices.

Ran 16912 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_i386
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.167-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.167-rc1-hikey-20181211-336
git commit: 904b62a2cb83665c4b38251201582a4f55649b7f
git describe: 4.4.167-rc1-hikey-20181211-336
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.167-rc1-hikey-20181211-336


No regressions (compared to build 4.4.167-rc1-hikey-20181209-335)

No fixes (compared to build 4.4.167-rc1-hikey-20181209-335)

Ran 2748 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
