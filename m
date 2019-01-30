Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E81C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7782520989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcrBtipu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfA3Nex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:34:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37960 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA3New (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:34:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so17397417lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PPFUVs23F3IQMY0otjl/q4H1tIl5qPJJIi3mOpn5sOg=;
        b=AcrBtipus1RR9IxL2qr4FVp1IbGiUPJyu5OYGSoKGlJP63e4Sahwvq/eFdg8g+yKxn
         mLThrV6h3gA5c1YtMTBez0j61WmVlnE/CSUZub+gh/YRybm4ik1tmqIZbohPDCGI5XYK
         m75vqOdyHYHJoGB6QCOTRSnPLoFF/9yBNB9mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PPFUVs23F3IQMY0otjl/q4H1tIl5qPJJIi3mOpn5sOg=;
        b=q5sftcddzXoYkDyfgymTxPpb3d25bbyarFPz9DqwiWSZVFssceKRDWd6U/Tgnlbt7N
         SacJoQQzohahc3hrCWSykBnGwuULtUK73CdjZKadQGfTlVctr7dkyq1RT3HZRAHsSUaw
         /CsrvxxwaUk1V4qH1IN4oTeLUHjMc0Wd2/JdS0p2WDApPXt+8/fH3FGaHVdJl9QQ5EGq
         53x2k6JWMqbQAnGwVy/laEUdbbuDBHttfVazTtktdsuG/jCpfvzlwjY3yb4kvQE6lCH+
         x1h42K3esvoRs6r+VoslULe5G9LF7Vdcy4ibxEKMdiDN1iWXNLqNTr74oWS/okW8tN/7
         dl6g==
X-Gm-Message-State: AJcUukfeBj0xviwbf+SI0W1pUGdsXZ1N/espAnYokDjaJEbs915chl6u
        gzMe8rr6N+etR0A2lyi6TuyP5sziyx4tcVB4JHiY2A==
X-Google-Smtp-Source: ALg8bN6WRr+mMpWp3Vxu5s1mzRRuqjl2cjzdralzAC390vNJh3KN+F71g08xMCtsCCF1g1BwTzQ2DuLBnMR49WZUaMg=
X-Received: by 2002:a19:2755:: with SMTP id n82mr23634276lfn.94.1548855290693;
 Wed, 30 Jan 2019 05:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20190129113207.477505932@linuxfoundation.org>
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Jan 2019 19:04:39 +0530
Message-ID: <CA+G9fYsUa=upA5=juDqNtU1tEEXoPzQbXRoajjSLyyaiOw9BSw@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/117] 4.20.6-stable review
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

On Tue, 29 Jan 2019 at 17:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.6 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 31 11:31:34 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.20.6-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: ef18d4260339bf79aa387199f912d366aa7e4b93
git describe: v4.20.5-119-gef18d4260339
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.5-119-gef18d4260339

No regressions (compared to build v4.20.5)


Fixes (compared to build v4.20.5)
------------------------------------------------------------------------
LTP syscalls test case "keyctl05" fixed and getting pass on all devices.

Ran 21254 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
