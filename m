Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8668FECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3CF20857
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HU+eOGJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3CF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbeGRKjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:39:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33257 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeGRKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:39:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id u14-v6so3025023lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bFAV8H9jnYThiDbY6uD4VRh31dFmdzlRAza6swb07Kc=;
        b=HU+eOGJCZkqQQLEkIzr2mxxByggluVzPg/X2URgXndDvo0gczG0ucNZ9hI2VYGB1eW
         edLHDBdP+mliszA2SWwTS7GjAi2KjYrXSmvlfSXkSHPZgfpeBGvPvt+YRpzAbOzlY/JS
         RxkXlQ1ncevyA+0sFO1P5oqMUyqHLBeND00Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bFAV8H9jnYThiDbY6uD4VRh31dFmdzlRAza6swb07Kc=;
        b=CRceTC+eOzbnr9k7cJff3HshLQADrzuPj4cQC9yblYIwTjBB+PFXN7dlr+UvGVl1XB
         RZLj+tf+BsZV7NxHpfQnmKb5PrRLC4rcNAhK7OG1h+EUurcqXjvjR5L6IZjua55JJc+F
         9N3hVdawOhzpF3TuWYdkF538ptw8AjzEPKYTIducvstSFfV+7NvyQIWc6IISHyDdfcfD
         1UEAbVZEU4E6X+lwgdTKEBC5BpONIIIwsGMWZ7i9Wi/rwtlttQe5XGCy7HqAUn+Kgu+t
         QwlFu9GAkle2IMeiat6TWxO7VaGdDPq4aaZU0u+39ZtRI0oVn9ncreoVHJLtfQ5QQDsE
         IsUQ==
X-Gm-Message-State: AOUpUlHlQAwICgzTa421SVr0yOgltA2M/Yj823k6mxhb4MJF0dsVoaiW
        vcLIMFVzkRJ0K/dv2zWwN5KQ2FdwCk+CwOtCFrS0iVq2DhY=
X-Google-Smtp-Source: AAOMgpd8hsN1Se+nRXGHWmE6Tnv5B8/mFXVgsot3CLLNV4jr6pRDw1fTduG35zBiidkgqdWLstKFL5O1DUIwmccWcVo=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr3426955lfg.142.1531908110803;
 Wed, 18 Jul 2018 03:01:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:01:50
 -0700 (PDT)
In-Reply-To: <20180717114728.444937016@linuxfoundation.org>
References: <20180717114728.444937016@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Jul 2018 15:31:50 +0530
Message-ID: <CA+G9fYs1j-KooQher961b1Rw-hzX_gstgJPyyydQdecsrV5A0w@mail.gmail.com>
Subject: Re: [PATCH 4.17 0/1] 4.17.8-stable review
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

On 17 July 2018 at 17:17, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.17.8 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jul 19 11:47:15 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.8-rc1.gz
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

kernel: 4.17.8
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 5606f577a707aa4ccc391714dca815933aeba508
git describe: v4.17.8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.8


No regressions (compared to build v4.17.7-2-g5173c2ef2046)


Ran 13864 total tests in the following environments and test suites.

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
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native

--=20
Linaro LKFT
https://lkft.linaro.org
