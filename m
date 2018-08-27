Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067EFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C55921722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqIqe+t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C55921722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeH0Hpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:45:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44540 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0Hpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:45:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so11145088ljq.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gTv3mcUS9k98qN/8KD9IhyMd0VWQEieYnAiATfS8tgs=;
        b=KqIqe+t/htoMU9d/A2667ZAa5U6+yBeuQw4PEdRt6HfC3BmDu2x5nccwASUQtazgNG
         oVgwLcst1diVOz7bkbjKC6Bj6rRi9WptzMUMtD4psdn97r1rb4aVITTQ8qEBlk4s0Ar3
         YOdUy0P3wtr5Nwy9ixePMPdEVNxRcyPJmLetM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gTv3mcUS9k98qN/8KD9IhyMd0VWQEieYnAiATfS8tgs=;
        b=MlCenpkgrUqiXlpkgokJb2HsDsEaMT5lQBGOmex1t8FKXA1OwfO/+rTUXrZI/O4z+r
         NBC45o+acUxK6Fm6DOXk/yC/oJP1KLnvo9cIdjxCTKCJ/5CXzoCc7lyub4ag5/CTjnOW
         8NQ7P4EkiyYqgDjDQXtaPZG2o/0hfSLRnpDmd32o0TZKghro9e+X9WeyN6v8Nb51hWaD
         wJvprXT8Otubvidsqq75o0X8J9gUGtTkNfl1AcXQIgDRxkqDsLB9iokHfo+yVHHfKjkf
         Pe06crPMwix2VqoNH8X/FCG/1S5sr/I+sxbdrPHj+EdycPoQisbTp92NRztyddBdKKHM
         2wNA==
X-Gm-Message-State: APzg51Ch/XywfifLjmAS5sOQ88LmbMyGSD3zRlJ9uxGRFnRqa2usXcBh
        vdzLAwggyQKBiq8JwI6yGz8jjQQeweXVOvvMgipT0g==
X-Google-Smtp-Source: ANB0VdZB8Xz6P+yUhyfsLM8J145j/jp9WpBzSMpZRR4XbdmXkA3y4TotpOwnozV03b1wcbLi5MR4bRCDV3ePTjx/7xU=
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr7001019ljf.67.1535342445913;
 Sun, 26 Aug 2018 21:00:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 21:00:45
 -0700 (PDT)
In-Reply-To: <20180826064102.584749876@linuxfoundation.org>
References: <20180826064102.584749876@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Aug 2018 09:30:45 +0530
Message-ID: <CA+G9fYscn6rUO6XRnfnjxHJDLkvZwk3fgE1aPPs+AdScoBM5og@mail.gmail.com>
Subject: Re: [PATCH 4.4 0/5] 4.4.153-stable review
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

On 26 August 2018 at 12:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.153 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Aug 28 06:40:50 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.153-rc1.gz
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

kernel: 4.4.153-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 7994d02b246beb4349cf0ae547c0a6461320e6c7
git describe: v4.4.152-6-g7994d02b246b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.152-6-g7994d02b246b

No regressions (compared to build v4.4.152)


Ran 12246 total tests in the following environments and test suites.

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

kernel: 4.4.153-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.153-rc1-hikey-20180826-270
git commit: 1d9b202cd56188353c13a49bf48f3f97383984ee
git describe: 4.4.153-rc1-hikey-20180826-270
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.153-rc1-hikey-20180826-270


No regressions (compared to build 4.4.152-rc1-hikey-20180823-268)


Ran 2724 total tests in the following environments and test suites.

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
