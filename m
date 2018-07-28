Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D913C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B66B20897
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFMzsL85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B66B20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeG1IUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:20:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41621 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeG1IUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:20:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so4945906lfe.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=++AmAs0FVz0Xwwqd36SYuBvpmG6BHo8Akr7XX+Jy/P8=;
        b=DFMzsL85GmB34dRZYjQa7PzvcNdKCV6z+u58WTjNp5pcP/z+Gp1Je0Msj6KuP+0Fjr
         F9YWzHIYMgin3ZALM+TQSKrc2ZBUloCtJ96T6k2DPIyecfbSi/KEM7QKori5fvTfWr2S
         6qSjmO2nFJnO7NMH8zp4rZlWyb2HtFhj2aDlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=++AmAs0FVz0Xwwqd36SYuBvpmG6BHo8Akr7XX+Jy/P8=;
        b=LpbHO623SMLVyry7dBmDgndQnQxNhKSec2Q7qepYg1dL2TL3NdMCyDZClqqi7wdHYw
         R6LyxXwVQTIy1nEyeALlBYDiuiWPDv+VkYym8Qq/b+Lvqo9wR60LYyohgC0yzTZFsrZ+
         JTIZ/n7rbYjZeOXLIBLSTNqaNTEcmYXpjg9+ugwW1z9ZS6qW7HBcafAzoWpN07ZR5PBT
         2xoud9CH4A0u7ZORaeZuV9YL+ooz1iC33r2ezn8h9FhptN3iNbwPalz2MNKcb3eDW/pK
         BxV676va4EImkfde/jjSneWob3m3mSUx83CJ5t9rvPK1raUZyqBdFoJdL0VoN2GvSuyF
         JBXw==
X-Gm-Message-State: AOUpUlH6APD4Dnd152Mc/OhiZ+uunxYzMnrIJAM2CvZnFMQkPbt/TrvP
        QvbmnPJmyXaAt3SBduv1ZzL8qHY9rGvBJwDU3fVitg==
X-Google-Smtp-Source: AAOMgpenX+5ETqxJow8Gti2Npp/AYIMhHkfUFfzhetdcACnfb4HmcqoXqL/LUrH4EluCcQVarDDW5Y03vJ4Nj1YSnG0=
X-Received: by 2002:a19:6d0f:: with SMTP id i15-v6mr5855918lfc.95.1532760915760;
 Fri, 27 Jul 2018 23:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 23:55:15
 -0700 (PDT)
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 28 Jul 2018 12:25:15 +0530
Message-ID: <CA+G9fYtz+A+3cAKu_y4hhuGqR14v6YZZCbh6swALwb22fV6vWA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/33] 4.9.116-stable review
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

On 27 July 2018 at 15:38, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.9.116 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 29 10:08:17 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.116-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.116-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 91355182b00639864b0312b2406735b3c0d9d879
git describe: v4.9.115-34-g91355182b006
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.115-34-g91355182b006

No regressions (compared to build v4.9.115)


Ran 16484 total tests in the following environments and test suites.

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
