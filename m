Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D045C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046FF217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rj5gmWJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfBEGOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:14:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45882 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBEGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:14:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so1713203lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bu6nkJkqnYIYOYMopGhU+aKbSQ7pjCI+U3hB9+bwb5E=;
        b=Rj5gmWJZKNRTv27PgjfVF9+fv75L65XBBTZmKeMRTjR0sz5Tv4ouMkhyOmmGLlX5YI
         cWSJuu9iLK8bGs4oUljBzBcVsxt7ifMUZXxA8+ArFoW5nRGGI1V+5cJkLnU/AGnPt7Ga
         eRcVQWkCeH6kMjVnJvriFRgHFCTTN9O9TuEn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bu6nkJkqnYIYOYMopGhU+aKbSQ7pjCI+U3hB9+bwb5E=;
        b=uPEmxwY+PSJAL8Xa1QuR7fbaUTHOGR3/5xO6M0JdUM63AT2n+hFTFGg6VaInIe7dTo
         hdnHuCTB3JcrMH8CvM+W+xxjUFhRRH7A9X61tEr8Ow1xKZOPY6H6UdEWyY7mvb/f3V7a
         anStwFfhK8cOMNwLl0HpVlqme/jvu1rsDzSrmlJivG1d3YyT1z6jCAOkAt6vK90ThN6G
         +/124I5nei1aZWbhc6y3rM87BdA0CgyURGFiTLfTAlADx7zivL+UTbXllKqXnClefHUi
         BlrecardnTQFZRLZ+qZCiTk57kAQJwHfzUm/PXNoRiTx5PEKW8Sm+YQtIcro0ZFCBn8m
         IqIg==
X-Gm-Message-State: AHQUAuZ9NPU5KoSmE6kBu4H1OUcdMWq8ZDhZPOjGJ9L3eTDB7uYwN/sw
        S91dTkOXlDlj6jKGV8eN6p9by/zhu02q99tinu1H/g==
X-Google-Smtp-Source: AHgI3IYRkFXugROqU4qOKoA1OEWF/W3XX4LwdWrtZygERInhvW8PEEax0p2wGx1yjEoeGSKjaeiComTbqw8YqUVYQvE=
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr1941020lfi.57.1549347289542;
 Mon, 04 Feb 2019 22:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20190204103619.714714157@linuxfoundation.org>
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Feb 2019 11:44:37 +0530
Message-ID: <CA+G9fYtN=fnXJY9aKG5Pkfkmuzm9TEpxxHHzpmqq4JXY9DHP3w@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/74] 4.19.20-stable review
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

On Mon, 4 Feb 2019 at 16:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.20 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb  6 10:35:34 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.20-rc1.gz
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

kernel: 4.19.20-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 690bd91d787289dc15b2f79fe32d1006c974cc92
git describe: v4.19.19-75-g690bd91d7872
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.19-75-g690bd91d7872


No regressions (compared to build v4.19.18-107-g0cbcaa92df11)

No fixes (compared to build v4.19.18-107-g0cbcaa92df11)

Ran 21250 total tests in the following environments and test suites.

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
* ltp-mm-tests
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
