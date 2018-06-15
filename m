Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7EAACC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E65208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VaRp47og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E65208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965361AbeFOAiM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:38:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38899 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965207AbeFOAiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:38:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id i83-v6so12136405lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iZfMqTESiax2wuO6Z74m/y27sBYZWvMofe+WeeH4ykk=;
        b=VaRp47ogZA4tcnXH9OwqPGkoFCkiHuNoWOoSYiUgYrpIKCQkUtob+1EKM2upsuB+uQ
         c8Hm1KphTib54LIrSYWExWqorv6aCx/f/lWM2xRzBc5noOXiSPGOeDarZhHc2aGSCOdv
         0pafcRzNUHJi4YRs2mzAU7Grkj15bV3v3UsXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZfMqTESiax2wuO6Z74m/y27sBYZWvMofe+WeeH4ykk=;
        b=XmEK/REbg59hEPr9V6bwcQ7WIttwpIs5H56ivgpIY8TQN6vTPvqkseMUU1BgYw+r6Q
         BxM8qIIocVZGjc3lmYLMD4Am54w+Ar4DZfCJAtzK6C6qJFfpxq3Zho0dAqfJTOttER1U
         x+jMgnhjXDxNygGJ4oNn0YAQidDfKRj/iA/0sPYxCZyByjR0Vs0i4BEiYWL9NNbPSiSU
         4YZa29yxgRL6AQrgmOIIwtYzAzc1ezVojoQSpRssvdDMnkoD9Qfo5is4kgzOArJ4EBtx
         O3wsQyxas5GNxtkJUMNG+lC2hUsT46jBVc6ClBWXQ92Rq8XjJKl/EV5gdHfNFIxgTuNg
         NX+g==
X-Gm-Message-State: APt69E3lC1bXJCaUw48Hx1P/hSaQT8vv3mDkwi1TiLEkv8THZT1NUDjp
        mpTWLBIHV/chLi7xNcmoKFAuaHGp08ZGD3yzBZBcbQ==
X-Google-Smtp-Source: ADUXVKIIE7A4bEN7ghhSJgCOy3AanBc7qVqzr5/Hb0kb/bGx986dNOTCOfGMtp8CHz/TnYmdMg38pp/rBIXvt2rDIrg=
X-Received: by 2002:a2e:60:: with SMTP id 93-v6mr3297835lja.96.1529023089036;
 Thu, 14 Jun 2018 17:38:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 17:38:08
 -0700 (PDT)
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 15 Jun 2018 06:08:08 +0530
Message-ID: <CA+G9fYu0b4gRUkBksHnjXJECM6dteiWX-74VmC4iWkujAzU8iw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/36] 4.14.50-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 June 2018 at 19:34, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.50 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jun 16 13:21:44 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.50-rc1.gz
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

NOTE:
fcntl36 is an intermittent failure on qemu arm32 for all stable branches.
fcntl36.c:205: FAIL: Unexpected data offset 12304 value 9
Old open bug to investigate, https://bugs.linaro.org/show_bug.cgi?id=3D3339

Summary
------------------------------------------------------------------------

kernel: 4.14.50-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 3fb86a556ae52204eac4b69373ce236510a9a91b
git describe: v4.14.49-37-g3fb86a556ae5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild \
/v4.14.49-37-g3fb86a556ae5
^ Please join URL

No regressions (compared to build v4.14.49)
------------------------------------------------------------------------

Ran 11475 total tests in the following environments and test suites.

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
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-sched-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
