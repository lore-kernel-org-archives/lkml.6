Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FC6C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7F02186B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrAWtQN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7F02186B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeHEN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:58:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39051 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHEN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:58:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id a134-v6so7108747lfe.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G5LxSVii0q+O9YHu8rbz3Uh5nqCRExJZ0PW9g7uWWFc=;
        b=FrAWtQN+v0CIKouGQ2nQhIoRSogH+pJ2He0AwWIbTzlvs2D0wh+D2DgvwHrBMiZX7i
         2b5xn4MCwB8IwPnnyR3wdoMXM8ZHVQ3H6WC/S5asLEB0OATpdl/DYDBe9l4QeAivlA0a
         vUoZPw6OnplWUMso1DrH5wTaaX0SSx2jL4ZwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G5LxSVii0q+O9YHu8rbz3Uh5nqCRExJZ0PW9g7uWWFc=;
        b=WpbpTLxEStX3H1wdwrFLlT2q430J2/2dcaWiNX++eTQzsuq2XNANXW/QI/Lz+6hSf7
         eqX1F/PHxV4JYquuz1eU8V6U/YNpaLh3BOCfviVmVxci/vzFhUHZcPQa7plNGlM4De2b
         X8q1befH1TP6QQLAsQ1yV5GtvJOgqeTZ9pePB/xiV1RE7VlGNmw5K0v4hCUKBPBcLVyX
         qpTRG660qFbGvjhFdxavWrsPXJdXC6D65yvfz/elcy5kTEn2lpw532ViLAaBgZl2z2No
         vqF2OxOCNksXwcH9XGA6SlxAr7PTJzHoFaOoAdX1mIrpP2HvclUs8ARXVyDLT5l/jbYh
         rKnA==
X-Gm-Message-State: AOUpUlG2g1b4D4xgaI/N+LLKkElLTwnXKQAYYYV0JB143xdaLTBOIFCw
        3GlzUi271pg6iLvm8zUC8ztVT0rl73iwlfDhc/oa3g==
X-Google-Smtp-Source: AAOMgpflTN4Kb4Dog/PmfuYflZLvK+Y/dEO70RHdERlFuh9v/JjXTp5QMBjYREDE/+LYypeAeCUqwBWskN6wMQpV6Ls=
X-Received: by 2002:a19:8f8f:: with SMTP id s15-v6mr9161311lfk.96.1533470061985;
 Sun, 05 Aug 2018 04:54:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 04:54:21 -0700 (PDT)
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 5 Aug 2018 17:24:21 +0530
Message-ID: <CA+G9fYsZtw-OHh2cKC0VG5zwdKOMvnOx-cAVfp2qfY_drFQ4_Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/124] 4.4.146-stable review
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

On 4 August 2018 at 14:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.146 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.146-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.146-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 34b42c7deffc0d7a1d7c8a321733f113957a744a
git describe: v4.4.145-125-g34b42c7deffc
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.145-125-g34b42c7deffc


No regressions (compared to build v4.4.145-114-g55fd2aefff69)


Ran 12206 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.146-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.146-rc1-hikey-20180804-251
git commit: 386cc87244b183476efdaeed31dc1819b85a3eb9
git describe: 4.4.146-rc1-hikey-20180804-251
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.146-rc1-hikey-20180804-251


No regressions (compared to build 4.4.146-rc1-hikey-20180804-250)


Ran 2673 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

--=20
Linaro LKFT
https://lkft.linaro.org
