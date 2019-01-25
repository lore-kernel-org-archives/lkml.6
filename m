Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D6DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17121218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9A1RKxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAYQdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:33:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39648 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfAYQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:33:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so8869917ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 08:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5NiT2/8khtvHglm1IJGKDNXqaxzjpLs7Wp9YeSAR5yU=;
        b=U9A1RKxa8nXSRtGvakpgZVfOf4bEvRxBVRF3sQ0pHjZCxS1DBC5WesgkNZ8xSu98iM
         tXhF5/uA7V+GWaHcFLvSW4hDPbcd5a95S93BgnAdOjRdJTU4obKVwd2JuXadvwxlAwjY
         aRasCAeOtvkehg6Sr0Wrj7lF9tFq/jtEJ406A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5NiT2/8khtvHglm1IJGKDNXqaxzjpLs7Wp9YeSAR5yU=;
        b=cOFUds4ZXz4Byx0tcxteSu6NUj1mB41Y1dzH22kRJSBl+KiWHx+OZC/qVI2UYrELcd
         oVtlR/8sJxXfTJxkUJ6YoxUGw5atia1VrYnE3payyTn8SSxWf2BUMLBDn8DwWFOzqjks
         7d7XwlygsB5ldc6gI+FGME26qE/X1olpkNKiFxud2kBY13OtIrGAup9/LFY2U9JlKzpV
         df26SQ3I07fDvgska7C+10tuDcv7DUOf+HXVVl14Ccu304FV/BZpm4scXgAN+gF01BIi
         1WBSQLqlWfzCeJrCD18dyN+ZzqTZZPW/JYIdo4dk3teu2u0QG+62oiUQsreKTF6imdCl
         ijPQ==
X-Gm-Message-State: AJcUukfrx8aq4OZTC4h3JFysnAcncsVHtKeZzHPNPoA7XnvjrwwGw3lQ
        5zIwJAgtkM+oSrXuEQu1/9w7c3JOr28vq1r4CuLXfQ==
X-Google-Smtp-Source: ALg8bN6FELzpxItTrY6deUSxcGWH8u23yKpAZfhthB5D8dGiJyvnz5QuPnuaTua7eqlQeuECSl999Zn1lP1l3HtR8FY=
X-Received: by 2002:a2e:9655:: with SMTP id z21-v6mr9922753ljh.136.1548433989685;
 Fri, 25 Jan 2019 08:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20190124190154.968308875@linuxfoundation.org>
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Jan 2019 22:02:57 +0530
Message-ID: <CA+G9fYs47+iqxnV7mZxi87c=-jPd=K+tdu7P_haoLoyVB6+8og@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/104] 4.4.172-stable review
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

On Fri, 25 Jan 2019 at 00:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.172 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jan 26 19:01:09 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.172-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE: Kselftest source have been updated to version 4.20

Summary
------------------------------------------------------------------------
kernel: 4.4.172-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: d1bc58cd527575fc76a81364495a796ffbea5f4d
git describe: v4.4.171-105-gd1bc58cd5275
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.171-105-gd1bc58cd5275

No regressions (compared to build v4.4.171)
------------------------------------------------------------------------


Fixes (compared to build v4.4.171)
------------------------------------------------------------------------
The test case fixes coming from kselftest version 4.20
  kselftest:
    * net_tls


Ran 17336 total tests in the following environments and test suites.

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

kernel: 4.4.172-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.172-rc1-hikey-20190124-358
git commit: 2d32e8ca1050f34cf7437c2f9bc72ee4f01881f4
git describe: 4.4.172-rc1-hikey-20190124-358
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.172-rc1-hikey-20190124-358


No regressions (compared to build 4.4.172-rc1-hikey-20190124-357)


No fixes (compared to build 4.4.172-rc1-hikey-20190124-357)

Ran 2813 total tests in the following environments and test suites.

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
* ltp-cpuhotplug-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-fs-tests

--=20
Linaro LKFT
https://lkft.linaro.org
