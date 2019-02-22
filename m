Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A97C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA276207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsA6ivAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBVCiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:38:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36296 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfBVCiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:38:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id q11so613666lfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 18:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k6Fzqf5AnppvtQx02+SJ7R4/J5KqwsXHur63yb7VDhU=;
        b=rsA6ivAp8eKjDSj3TXpDBvSKuH+vDU61eUACaHu4F9dLJwPi9ab9rcdAaC3FHghsNt
         0J7GMol/Pr0ESOnbKzcYxwZMgnNM2Jzj8fpyf9ZpPvbqusawmebv87YR/IzQD8tdWEks
         iDYhDft5wTVaON4RPhQ3MRksGjJzaMeiKph0JS52EqjrWkCp62UH8iJBkmDRL9sS3toK
         BW1H4xHY7X5NLlnhc0qzOOnSl+IPYuYX+8vizDL0/rLH/NfqWAr/iOxKRrwkvy/1259C
         OHs5HzeRoBFDVAylfnvapluElCPGxGhLgs0Dd+iJgm+k9NMqSYWDGV4/hvUOSmdnBsUO
         +8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k6Fzqf5AnppvtQx02+SJ7R4/J5KqwsXHur63yb7VDhU=;
        b=WWiwSI+/YBmh8n8748+V5+wyfGm+uOTeOfrsbrOGgRUp9rTubsGZOx9jyniLZlYshJ
         mYDgfk7KXy3TuB8J8IFocchwurp21XX7Fu4pT9juK4In9aMCGFTsBg3apw439SbMlbLB
         qNelWI3cDxhZWdbniHG/2w3mbrxh3Ra1mrgTiY9Rd3KvjDUsqbqpzW89mMv3JXYbJchg
         hX9fXs5TNrkRxP5W98/eBRmsMNnEVJxbLSIogWJIddbG/Sv1iPf0A5UcGSaYqQKya4u3
         +m6HGPTOH4Pq7DPP0U0r6jIEh+Q4eatJRjM/jGTf42bkMnBPlzDhnUwyuLHDWbYilgeZ
         bcOw==
X-Gm-Message-State: AHQUAubZJzLhtfzuQ9vs1eAPWazAVE+Us1BR2OKVRMu+cMeenVriGMI2
        x52Xe/02mQfrE5IBbfshvBM8b4otPWFAT6qA8DXwTQ==
X-Google-Smtp-Source: AHgI3Ia18Je6zSqwqDezvw72J1L3IIWKEYmAvX0b+jSvDoRNpKvZTlM9TQ9nXfuaLVZw8KD11BQdtkhKDpqJYcKP3mU=
X-Received: by 2002:a19:c510:: with SMTP id w16mr993052lfe.0.1550803095884;
 Thu, 21 Feb 2019 18:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20190221141946.772985220@linuxfoundation.org>
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Feb 2019 08:08:04 +0530
Message-ID: <CA+G9fYtJv+XntjxXhF-THH68XUOf7Eri0DD-zzdY7H0yaNkBGQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/20] 4.4.176-stable review
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

On Thu, 21 Feb 2019 at 20:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.176 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Feb 23 14:19:37 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.176-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.4.176-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 451afda2764d401925c1c6f017e25694b07d61dc
git describe: v4.4.175-21-g451afda2764d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.175-21-g451afda2764d


No regressions (compared to build v4.4.175)

No fixes (compared to build v4.4.175)


Ran 17547 total tests in the following environments and test suites.

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

kernel: 4.4.176-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.176-rc1-hikey-20190221-382
git commit: 61b9d51b29b3a87a8df435a349694d37e66f138c
git describe: 4.4.176-rc1-hikey-20190221-382
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.176-rc1-hikey-20190221-382


No regressions (compared to build 4.4.176-rc1-hikey-20190221-381)


No fixes (compared to build 4.4.176-rc1-hikey-20190221-381)

Ran 2850 total tests in the following environments and test suites.

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
