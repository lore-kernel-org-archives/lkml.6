Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D840CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73B7218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmN9JAYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeLTPA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:00:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32886 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbeLTPA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:00:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so1614292lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iMl2hbIQ2G0NVk4jB6P2YvLkLP/KG6VzAEvkrHIhylM=;
        b=AmN9JAYK018rt6Zlqgd2BXXX4SgMFgB0mWKAURY1SEMkx6PUnAg2d/ETFhyXwEapQa
         lZMPHJtzSsR/bdLCDaHfRSIxcNke+36pu9U4eu9InxghdXcatN6MBJcPm0zFskibIeGD
         Sygrs3LDuoXDd5bhwoFepsO+lga/jFFQwDEXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iMl2hbIQ2G0NVk4jB6P2YvLkLP/KG6VzAEvkrHIhylM=;
        b=S12OORUGngFI9AZt41YLA/9TAT5EQCYM2facPQ0YNcpPvX4xl9D9FSngi4j7qhiXT6
         5rnbIiholK696N2UVh4AoqSEgF8YCIAGthKz/ukawR4d00jq4c6r+QKZ+p0TCUhKvIl3
         vE1o1JqzZilFzlfjr3zaS6KUAqz6btjA99DZLwt/fDGigO+2VsHYwep3hcK4WXRQP/+p
         1YkMiPkr9iEv4TOTEGzwwT3x1zWj7EaJFqJLDkxpp5NDJrzvkPl2iGONzf+zzS2OD7Q+
         ilCKE7VZUgfYQvXj0Hf9bYcjPkXZWCF+9yZFUqBm3iBbotzCs3UVigZh1cI8VztMGtAb
         EEdA==
X-Gm-Message-State: AA+aEWb5NKCsxzyBB//wbDHwd6v+PaiLkozOZVi2iegP8gGIUD2xOqrw
        hmC8hZVIdVCzI1bTo2VS+zt5iU9ubE4sXdvijC/tew==
X-Google-Smtp-Source: AFSGD/XozS4JVF+xjqDollqsK0DUFh+eWvf6HXpW+qi0q9BxmwLZEVYXuIP8wNgfyKSUJciADzXAnrvwGvyc5eMkRaQ=
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr14840547lfd.74.1545318024545;
 Thu, 20 Dec 2018 07:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20181220085843.743900603@linuxfoundation.org>
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Dec 2018 20:30:12 +0530
Message-ID: <CA+G9fYsmTOip2e=WyFVBZJ32eu5i-BV3QHeZe4wpvNK5CH9FJw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/61] 4.9.147-stable review
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

On Thu, 20 Dec 2018 at 14:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.147 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec 22 08:58:31 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.147-rc1.gz
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

kernel: 4.9.147-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 2758b137b9ed759bd1827db35c31571beab263be
git describe: v4.9.146-62-g2758b137b9ed
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.146-62-g2758b137b9ed

No regressions (compared to build v4.9.146)

No fixes (compared to build v4.9.146)

Ran 21452 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
