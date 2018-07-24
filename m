Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8E520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zr6FkvKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8E520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGXIt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:49:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40954 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbeGXIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:49:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id y200-v6so2304389lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/hcQwLb+DqX81YSXoNjPfWN104l5MsoexyEy0JvzvmI=;
        b=Zr6FkvKTG7vbisrpnIGnOZqWKIfVyr0bSe0ViUgt4BiDiZ6pgNhcB5JpHYwKUygjKd
         ve0PFBBpP+zR0sUcgEvBIeAgdc6a0xs2Wmu4m+dCg87KM9JtOO+FFt7yedtmt3Toy3V+
         APumJP06iqNgydkOM3Dkc9F2fRCilMHXZRueM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/hcQwLb+DqX81YSXoNjPfWN104l5MsoexyEy0JvzvmI=;
        b=HFlWU0uqhn1zZE9alLzgyw0Yta33IflYzWzZi8aEo6jno74+JoNaDjPyRfVPqR+r8F
         he/70LpnZtI0EwTH2wFI7LKtW4gMgGv7uXQZI9Apc3zjzOJrVliVPbZFwoBpc4xJtRNU
         ONqb2ggiIOnKVq7rQ9xwUbEIv5wtUW1RdH0IyVnNHtEwjRIDW7Nl2ctdEsKZtcK8HRRT
         XpIVk2vVWUfK+UFKQIantTIBEkiSFRi8Y4TI9s6iPqKLm0uWXRsXCTk9+x8nq9+0EX3V
         62GeCT6cxmXQLCevtzA3uZ5zdG/+1Q6ArF2ASZtbke6IHs6v2f3X4q6YarrtaVWAWETl
         o4pg==
X-Gm-Message-State: AOUpUlGS28xAfaIyXphlYGvJHhX3/DVjt4oYmpKQLi9Gh6rhvgzSx+vN
        v9opx3Tvhok8jv9kUQ5plAzgFWAgAPWK4Q4LHul88w==
X-Google-Smtp-Source: AAOMgpdPBS+v2CEsyl38Qb5zK5KhvSh4zLoM5NUrZ8ZnY0hxxCuEN6dRzhG/oDDfRcOCQscf1IoVsXAYgFbw9XdDI3A=
X-Received: by 2002:a19:9345:: with SMTP id v66-v6mr9865989lfd.89.1532418286104;
 Tue, 24 Jul 2018 00:44:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 00:44:45
 -0700 (PDT)
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 24 Jul 2018 13:14:45 +0530
Message-ID: <CA+G9fYtBZ4fFmPK0WgsM6UJYOTQvxdeRm-dKvNPmtyNK1DY7_g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/44] 4.14.58-stable review
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

On 23 July 2018 at 17:54, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.58 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jul 25 12:24:22 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.58-rc1.gz
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

kernel: 4.14.58-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 07f27c4ed0e788c43a061c8aedff0ee003b51075
git describe: v4.14.57-45-g07f27c4ed0e7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.57-45-g07f27c4ed0e7

No regressions (compared to build v4.14.56-93-gec86d5e19e14)


Ran 16387 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
