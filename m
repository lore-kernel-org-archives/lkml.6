Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B1C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495B8216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ezd6sghA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495B8216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbeHCIX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:23:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbeHCIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:23:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so3242229lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 23:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uA/ewkZ+A/3zv8IVjQs69lkuDh2O9yTwQwAqnBWF2qE=;
        b=Ezd6sghALEStHNuXuncc7ohVKCUlmNndJ1HoBaevJ7zC8pOf+ughpmS2XoO1h+7gmG
         RKXnmQMOZwa9xreH5ocSdhXKAX4Wr++lnCjQoY0sCioZUSCuJux3RqTp4XKokV2BfVjC
         z//aW5S02ZpZlWRZgKSQWvqOW1LdqLIT7hbYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uA/ewkZ+A/3zv8IVjQs69lkuDh2O9yTwQwAqnBWF2qE=;
        b=MlwqadkVr3yJuEViw7udqJ8qo2QoY5CnOzvQPlP940KMn5eFoyd2wr3IUC2uIHsUYK
         MPyfUYBv5ims66LlNgiCdENH1vWHURfqLFPAgVOyrGofr4zGPA7cV3JOv1BNM5xF9V9m
         9u9ZLPnDJSrORpbu4/KfdiYbjbIM2tb9u7FtTUvliHcz76KGqUQB3typNdDvt9tnDMc3
         ifLzkbJPlLnwW+sm4r56IgLZdceCk8L0FoGxYD0OBcA/8YZQLTiJpGYNqreX1Guj9Gm8
         VvriXbm5Jy4xGSzK1U1sVyHeir4gZ1HOlwOsewqH6qDXw1aS7ri5zR+7+NTCnYczHlDX
         D4aw==
X-Gm-Message-State: AOUpUlFaKTuIDiqbcoyFH4WzluO3gqBtACaAfAbFy4kmv2vPQcmmtHJu
        lcLHqzUfQ2VzgKUAhCZ/HmjIhts53LzhSeN5b6v32Q==
X-Google-Smtp-Source: AAOMgpcG/EYleTxN0bHddOalgqjNaee1ntXzSriRC+cj2/yxQLE5AOfYlnqksoJLaoomafHbJJvQtICB9x7cuRPdWyg=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr3526491lfg.142.1533277720792;
 Thu, 02 Aug 2018 23:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 23:28:40 -0700 (PDT)
In-Reply-To: <CA+G9fYs_Rto2f0qZbcYcsFM4_VKWU8+wy0pL_dPDid22=OPTPg@mail.gmail.com>
References: <20180801164949.023217860@linuxfoundation.org> <CA+G9fYs_Rto2f0qZbcYcsFM4_VKWU8+wy0pL_dPDid22=OPTPg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Aug 2018 11:58:40 +0530
Message-ID: <CA+G9fYtSkA4JrCSmvBqcEXZjR5MAoDTOtAn6_A5_WZvt8z0DtQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/144] 4.9.117-stable review
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

On 2 August 2018 at 12:29, Naresh Kamboju <naresh.kamboju@linaro.org> wrote=
:
> On 1 August 2018 at 22:20, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> This is the start of the stable review cycle for the 4.9.117 release.
>> There are 144 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri Aug  3 16:49:15 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch=
-4.9.117-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git linux-4.9.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h

4.9.117-rc2 report,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.117-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d82f3fca686951f6939f269effe825f8f235a078
git describe: v4.9.116-144-gd82f3fca6869
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.116-144-gd82f3fca6869


No regressions (compared to build v4.9.116-145-g7931028e6a56)


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
