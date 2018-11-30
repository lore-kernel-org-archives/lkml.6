Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21756C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE12E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHpCKORB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE12E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeK3UCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:02:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45932 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeK3UCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:02:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so4265426ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0pqrb5XLzZp731hMkQQEzWLXyz3/ahyttN+fVpx9VCM=;
        b=bHpCKORBB5utrunUPwAHxu6Xc3LMyqzvcKqa/sX3K/6qONcYv2WKZFF1FpRT9UcJtV
         Bp8lGvQ1448BNHpFL5DfSkgRiqdqLGUhdFdMqlDTu5fPFqUEBebLKxC9lTGTD7QkoxA6
         YDpbL2sMr/q+RCkCIJNJRiEDswbMw0M7Q1q+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0pqrb5XLzZp731hMkQQEzWLXyz3/ahyttN+fVpx9VCM=;
        b=NWyoagS6plWmbme9GfmjhhWhvFhh/MmzJLn6UkdcAZZyjp83MrFNbW4rKPqNWMaxIi
         xpfPL1uksgzUjLD0t7XsNvZSwPGYirBopymvfRyNcteRjOCdOVM6VFqZNtmaVw6Xm8RI
         qLh6l2RCq1zQjyUqkS/YpcjgINdgDnZnF4enlM0F3IwEbiSlPiY152iSHZoLREO+614i
         MF2+4seYd4lsUy7vm7aiSggvKtssTMr+cNySIDnyzcqylnRFncD9Ub8OZ054CfnwZFe3
         S/fq7/p8+iSt8vGXfSIbI1n+2AVWo34C/A6eGXO+cPjxVXyQzYQbrTP61efHyzaydhD1
         BV/Q==
X-Gm-Message-State: AA+aEWZuQiPezpv8hi2QnORasNN+NwX4VVimnz7Vhs7PFlSo9Q+P02e+
        szCNoIyWiWFiyqPa6wVTYJBNUyRHvZV/NqFsCa3PwA==
X-Google-Smtp-Source: AFSGD/WmyiRqLVdyPtEZAwdU0HzYOUfeDv0By6RWThfRPFGHJLfXxpoX7EsgTUnh5OuZGIM7RcY5qkqjfTv2cKVtgSY=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr3276007lji.30.1543568013098;
 Fri, 30 Nov 2018 00:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20181129135921.231283053@linuxfoundation.org>
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 30 Nov 2018 14:22:59 +0530
Message-ID: <CA+G9fYvjmnpHEaSHvfibx1vdPjvGt7WyrUX=o2+fQEARg3N0Nw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
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

On Thu, 29 Nov 2018 at 20:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.6 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec  1 13:58:54 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.6-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: ac4af649901b05aa42f4ed3e153ce0150d67aa03
git describe: v4.19.5-111-gac4af649901b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.5-111-gac4af649901b

No regressions (compared to build v4.19.5)

No fixes (compared to build v4.19.5)

Ran 20180 total tests in the following environments and test suites.

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
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-hugetlb-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
