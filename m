Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F6C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06225217BF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBw8FFLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06225217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeHENzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:55:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44433 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeHENzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:55:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id g6-v6so7072467lfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t+p0WNJb8GdPF3nM1CF8QLPe93fBpvsUOapMQXq6BKY=;
        b=eBw8FFLC8tY7kid73e9wjDiROgKpVx504btKBIaxj4GCCIZ4hMBW/i4UHWQAi5PYjY
         5kQikxVBUIDKUrMD36VKA+lPifGq9yGIJfLfaOkuKLEKZqRJZmdeTXqDojT5aYkZ5/31
         mgLdYTITGi+PMGXPacvMXvqPA20neggLivMQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t+p0WNJb8GdPF3nM1CF8QLPe93fBpvsUOapMQXq6BKY=;
        b=o9pwkpgHh40GzBlhPmPaq6Qka+xH2g2FAePwGK3XnP37+ux5xlf3Pg8Qtioy19/jBx
         grCbmkRTgNW+8z8db7WfL264Tz2Pqu5a/vYsMvqS98WYXyvzfptHoQCCTxTztgWtn/w9
         5CXrJXabZTA1DUTm2+gA2nX5wgbIQG39xIx1pFJ0QO80B/X4K+TjxrszRI/+GNoEsGiJ
         Zz0pqvOxz4lxt48X28uk7G5IPPLWI9VpFQAKjoiCDmZN9jPo2BZy08wLHz83pPgopGMY
         hCu+7dVlgnd8Qp/uOUTYR6sWvu2vCaFjTF2Bq2fScpTjg0e62Du+Z6+3CfQ8G0cSNBzN
         Db0g==
X-Gm-Message-State: AOUpUlEPZTu0zbs/v2hd+xHRKbKQCaHVyqOOZfVd8HSc49gJkVSRRiLj
        n2s3C0mF9MiD/AMpe8JnKJ8g9Cnhlx/kbg9/3w5FAA==
X-Google-Smtp-Source: AAOMgpddD1CWk6tL63BWFrP8n+9m32bZwC18AxiBaIgjkqGCVNe3k2JBa1u+gJbWjyfHfRIQBSnpnjep0TDz3YRR3DY=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr8511915lfg.142.1533469894305;
 Sun, 05 Aug 2018 04:51:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 04:51:33 -0700 (PDT)
In-Reply-To: <20180804082643.641435547@linuxfoundation.org>
References: <20180804082643.641435547@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 5 Aug 2018 17:21:33 +0530
Message-ID: <CA+G9fYvXiqUMY1iSSZbz=LZeLwhQD_5n63QWkMPGJXxcMRBwnA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/23] 4.14.61-stable review
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
> This is the start of the stable review cycle for the 4.14.61 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Aug  6 08:26:30 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.61-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.61-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: f345ad471fe555c7fe8f8e75ec5fdb9a54d7ffba
git describe: v4.14.60-24-gf345ad471fe5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.60-24-gf345ad471fe5


No regressions (compared to build v4.14.60)


Ran 16336 total tests in the following environments and test suites.

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
* ltp-cve-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
