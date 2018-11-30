Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BC7C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564E2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+0fCg4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2564E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeK3SQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:16:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41429 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK3SQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:16:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so4041669ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 23:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p/DFeBUBKgBKgQPP2gFzOZPrIHh+TucaNTJFmFmPZ+Y=;
        b=H+0fCg4gErEI/cLSxQ4lYjrVr95l8XiE58oox4+dKinB2rj7ATNEeOUgtl00Vor7oj
         ySlcNx3I1wd5FfLebbkCLMANJEzfremJYsS4HLhHiFpMdXg7O8ZxnuSS3+wmcBuDMjUr
         v1Ojq6/s53UMM0/aVzAqVtAokJ7Xcpx437/sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p/DFeBUBKgBKgQPP2gFzOZPrIHh+TucaNTJFmFmPZ+Y=;
        b=YFO6GUorl7SwfYowVIisJ19m8QAu2VSAQkaK1T2NCnex2SCHKIuw99biFwIWKKlfAk
         0ZrgEYdLT9UKUq07UP432U1QK6Rr0+3iIjNjVzHE4R4Wsc6Yd8JJazWCpJwWLNfFK6lO
         dEvmkZAdg0La9YjfUxNa/Be63GmAnwoYoMLo6KCFnEYyRNtH0gGmj7/+cQc2IZvR1+9p
         WDa0LJV8LeHuEODQB6trGChxwKZff+2bHJZDznhwbsofcSj+2yroYoWgl0Mpwt60bleY
         Zi/8QTxZ9EU5/dVeg0i1DMhF+aI9hnfB0E1/Xj5/YUgeUYZtdJAfxKlbvc5pq9HIBMAk
         gubw==
X-Gm-Message-State: AA+aEWbSJhJ7VRcukKV8v4vl6mTZUXYQDzeowo2csRhjG6+yykfa01/d
        s63GFL/IdKlqWU0Fnd8GE8wjU+la+qAUbXpbpj4mkQ==
X-Google-Smtp-Source: AFSGD/UvUW2NrvYIn5q0ahMEjoc/UZyV0ciBRcZ0VbpwPKEmjHZ/nQ7GLX2CwHbnMpu0u+JRIgslz+iTrorbeyyl9+Y=
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr2680624ljc.77.1543561716278;
 Thu, 29 Nov 2018 23:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20181129140106.520639693@linuxfoundation.org>
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 30 Nov 2018 12:38:24 +0530
Message-ID: <CA+G9fYvZR6idudzPSk5yDKUMHV5exUQdjTXSNi-CUWVmg2cNyw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/92] 4.9.142-stable review
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

On Thu, 29 Nov 2018 at 19:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.142 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec  1 14:00:37 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.142-rc1.gz
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

kernel: 4.9.142-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: f46aebe62697538df220b8708e266369ffd901c5
git describe: v4.9.141-93-gf46aebe62697
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.141-93-gf46aebe62697

No regressions (compared to build v4.9.141)

No fixes (compared to build v4.9.141)

Ran 21336 total tests in the following environments and test suites.

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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-pty-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
