Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E180EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BA322504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7/BwACD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BA322504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeKLX4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:56:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44106 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbeKLX4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:56:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so7684004lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OXnwNhou4e/TUoh9Y3RJ8VGO9MLrCFLHzxHithok7n0=;
        b=P7/BwACDYvWcO8DtRb8np28PjRjuCzxPoo8xXOJNvPgXT/eTtnYvj0DuiNYOkbjlcM
         Q/zToLYCdL9PSwpVimFvgvXnVwPMMQgBQozGcryYP7Jxq+9t6WDjuLrnPSRsuxt1Z2yR
         Zw7cK0OvRnYpOlQ4Ee2MPot+aOC4YlPEkTTN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OXnwNhou4e/TUoh9Y3RJ8VGO9MLrCFLHzxHithok7n0=;
        b=T1cJdlNOEg99thlbevrM9wlnRQhbXNrRUggGa4c2jRbuRhqHnxJ47ir+avaEqIsW4T
         FrGIXwyxuqwukKuH/Z+yPFL4sACZmPurmMMFAlJ+MSQOtPf/MVszH5LFKXzwUk1YqHoX
         Vet2XVe/yOhpcuTB9zhy2lZawyNdi7s0FkfaI9jsk/OKej+wWRE0E8M/W4Po+lH1MFZL
         f4nFENoXzOCSJbiII9POusxG6Viop6RNLmLw9ItAXjrzCyYeCga6bwyTsizALBaL/7S5
         sc72OAR8X0HQuAphI6BsYSA+V/6xGfUSzwzekeT90PvkpVKsRwjhv2Hh/0MK4NyJnPCD
         FR0Q==
X-Gm-Message-State: AGRZ1gJpvBLSV4jOXefX+lB93J+RUwYe3Z6wXC1NOlyYboTZFc5o6ZLr
        jKWjHrJDou4o7fv39gDgMuLp798cchHyRH5UmVntFw==
X-Google-Smtp-Source: AJdET5eZnR7AIuQQIedNonUQzunQjHhV5rhbOtXtXgxa66rLOdXXaU8QMbdirkOptBPdzEGpUUt4aCOikFzkotH4Y+8=
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr837123lji.130.1542031366893;
 Mon, 12 Nov 2018 06:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20181111221707.043394111@linuxfoundation.org>
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 12 Nov 2018 19:32:35 +0530
Message-ID: <CA+G9fYu8swCAbJ5yFZoq3DM8QFPVjJtKrj2xgpwdr6YFoT5qNA@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/350] 4.18.19-stable review
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

On Mon, 12 Nov 2018 at 04:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.18.19 release.
> There are 350 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Nov 13 22:15:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.19-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.19-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: a77acf393de04dda4d98962043a030467400b27f
git describe: v4.18.18-351-ga77acf393de0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.18-351-ga77acf393de0

No regressions (compared to build v4.18.18)

Ran 21337 total tests in the following environments and test suites.

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
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--
Linaro LKFT
https://lkft.linaro.org
