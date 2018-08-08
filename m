Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D00D21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuXubfiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D00D21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeHHINo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:13:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47095 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHINo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:13:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so731614ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2wDXgJklwiDukWKQMK06X49nAvaucpveol5MloqhNiM=;
        b=KuXubfiu2pH8Q1c9i0Lf3GbX4y/EaGKQTqcRyyeouK5eo6/cL6/lRSrrHE9N5o6wLM
         i2JS2tJPFXRNkOt4fZz+UuHcjV5pczg1RXgsuiJfqDeuKeZbZY24sVT/wJyZI9lboQsb
         LsWIb6XwcKkUOVLTVKyKF+WnApOHeLd8xxuEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2wDXgJklwiDukWKQMK06X49nAvaucpveol5MloqhNiM=;
        b=kneBxfnJ8ZNXz982A7FaU44tsNLBLSTjzz88EDa7Sla4RZYhaEzHXnMkZSVaHQVMs7
         1uoCdu75iFaQJbmLZWJsUP6KYilp7lu0Pyn9I5KOvUxk8Q82nBQf12dMpuMoBA4IoR+z
         t0jkNNDmum0j+aGKJQFDprFgjwj81g31OHJnF1uVE0AVFJU6kc0Py8dEAoZvkJD93adC
         aoVwTmve5x3eWsAScvOc1O+u2nXkp0e1xmxPzbqTA8mkMlnJ+BB6RkWKa8T1sYjUy7Lc
         yB/ZMREb2K4ROxt1IEO29ioZL41vKgjQEmdirFai9rLic8hHPSo6P8IXLiZMwWih9mt/
         R7IA==
X-Gm-Message-State: AOUpUlG9Fg4EG+jkz4JYTeezT9iCpzbRHmMLCQ/dgkxuXWCBe86+jKmO
        lcWwIpvgKuLsbTeFn+SJsDyAMfPtG3gUk5CVcvqCLg==
X-Google-Smtp-Source: AA+uWPyh2iQwTugj1FssMkrUQC4PktYKo8yQckddduB4BqHvphF7wPy6OEqRVtZrULJDIZo+sXhGfeSAsxJPhNJGLKg=
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr809948ljj.153.1533707741340;
 Tue, 07 Aug 2018 22:55:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 22:55:40 -0700 (PDT)
In-Reply-To: <20180807172343.326201671@linuxfoundation.org>
References: <20180807172343.326201671@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Aug 2018 11:25:40 +0530
Message-ID: <CA+G9fYsuzw4NATppR6K7XBJwDdKRpVwnWUj9mtbcNtJ=5RprcA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/12] 4.4.147-stable review
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

On 8 August 2018 at 00:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.147 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug  9 17:23:34 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.147-rc1.gz
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

kernel: 4.4.147-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: ed5153769cba52b60a0c6210cb1ac41843f37200
git describe: v4.4.146-13-ged5153769cba
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.146-13-ged5153769cba


No regressions (compared to build v4.4.146-12-gdb3e08ea00d0)


Ran 12163 total tests in the following environments and test suites.

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

kernel: 4.4.147-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.147-rc1-hikey-20180807-254
git commit: a7af4a3cb7756f8a159f54cb757f30764f3d5166
git describe: 4.4.147-rc1-hikey-20180807-254
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.147-rc1-hikey-20180807-254


No regressions (compared to build 4.4.147-rc1-hikey-20180807-253)


Ran 2705 total tests in the following environments and test suites.

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
