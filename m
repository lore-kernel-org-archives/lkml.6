Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E47C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2FB21725
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PH8sNjWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2FB21725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeHHHka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:40:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34735 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeHHHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:40:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id n96-v6so675203lfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 22:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sFtoYo6T+B/vIhMqevif7hpyI5R10eENAwNyD81AgHc=;
        b=PH8sNjWyqhjzZ3z3pXmBuzGbdJQbGxYpr4pm4kLSvbcKGzddEg3c4vALnz1p0KhfIy
         pUb2wEOi5Vsn15AQq7gijBh/lGQZcrjj5QUpkae4e4vEhymCVCr6x4HbqRMwm0WR2zsD
         xYR+LSxfl8CNZWPbkHao6X8SR1+b+ukiZFHTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sFtoYo6T+B/vIhMqevif7hpyI5R10eENAwNyD81AgHc=;
        b=KiY4ISFEcd73OcyoZtoShf+uq3104E8Gahb5rsG7VDpg7e1BAXDVTluecSgVxnU8Sh
         aSlbtRDxVA+cQH4MyBALtYwYyOYEuVcRlRr7NNNkIBGJIWIyGY5RIr1dTnzMRJyr45A+
         PAXuMM/3Sg3JqWTi1koZCSvA9JcXM8T5di8NsFPAjRjyKSAQ8aj4S3hZfzO79SeIiPb5
         kpiwTcJqcVQvuUdl6whrA5X9DGZl+IMrFXUBgoyVdsd+KWrKOOl7Jep3Xtg7EXnbbdyM
         M0XyKLFt+7gc7WYJswDliCBOei3GvGTZaaXZThPPb4c8278QzNXjVKdpm16ZGU/R/hyf
         K72w==
X-Gm-Message-State: AOUpUlEPYvtoS4rFp5XSmp3gpSsuSXJiykuMlAzFmV3k7tl358/YP5w8
        YPIBVCVOW2GyYN4OG+Gm/aNIQqpvd7/A7V7H7+UFww==
X-Google-Smtp-Source: AA+uWPxsdreG+Q7mCZc2ZWUI0ujVfYEy1J1AjF9qmryRUM5LBtKrHQimHej3Ov9Asz76EY7xv/IMJXNiQI0jri6U6JE=
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr723595lfg.142.1533705757402;
 Tue, 07 Aug 2018 22:22:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 22:22:36 -0700 (PDT)
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Aug 2018 10:52:36 +0530
Message-ID: <CA+G9fYvxO9LJVBhEEvDU5gxdheVEKzqxCg62E_ptp8PjSFgoxA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/21] 4.14.62-stable review
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

On 8 August 2018 at 00:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.62 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug  9 17:23:22 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.62-rc1.gz
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

kernel: 4.14.62-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 5a43290b0403cc685cb30f8b65843e03980e9499
git describe: v4.14.61-22-g5a43290b0403
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.61-22-g5a43290b0403

No regressions (compared to build v4.14.61-21-g24cbd55fcf52)


Ran 16631 total tests in the following environments and test suites.

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
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-securebits-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
