Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3342520857
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="euw49qYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3342520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeGUI2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 04:28:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44624 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeGUI2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 04:28:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so12865763ljq.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TP0CxerH5hwI72av/0qydZQK6tZ+JmPUDVnvRT1pWmw=;
        b=euw49qYaAC9ebCATDm5SApPM0rnQf8EFBWpyptQdzgE4YUMsQHsiwY75uirXcBlvwe
         ZYzzOWfpn2r14XsREtAab7WnUUPG9vyuA+xr6sbqFUyZY4r1EPdNMZ3AtIHK7bUYGOHC
         DVQdY4hi0knX82b/CiK/OUadKs4VTKTdP+5bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TP0CxerH5hwI72av/0qydZQK6tZ+JmPUDVnvRT1pWmw=;
        b=Uzazi4ghyOJooQvCyqjpojGQ0zZKy5Ogsplff7BIHONVj3Dvr3daD7DdWiO5EGzvQB
         EGUPwrs4zls08iiiszQAR4xwv6hjIoC3Ryi1l8BKefS16kB4/1oq5Kl+/LNTeN+Qzng+
         c0DZdIrzCvHNFh1eQgIkgwvW5qdhTQepVLxxRwOgfbSju/7mKAnAAP3PffsU40YJiQdf
         15wjf/9H+hNNVfw4KAn05xEFTIhWdniSUM8z6QlV73Ur5KoXWDpEvcWYhoYCCvNoj4db
         CC82a/IG8Dsx43/g38u8/2QsUjX9bKBWEEGDZb56Y3XNZ+vQ1i8BDkll6M31KQB2jj+W
         X9sQ==
X-Gm-Message-State: AOUpUlE3cFhZhg8Fw13mUvoK/I93dqfuTZ7e3/ieMRHZiRPPQeZvomlM
        wivuhrmPtRUm408ojPm/UTv8WqlM7c5g9wdkZ/Cr1BfwBWSzjw==
X-Google-Smtp-Source: AAOMgpctyyfGAMoov4YikY1fmbjsuRocDEfxoPJEkL/m3a3I2N0oD5+zEABEHNRQtmrw4uqAJT9soPUNZ+AMfNBH/Xg=
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr3726901ljf.79.1532158589000;
 Sat, 21 Jul 2018 00:36:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 00:36:28
 -0700 (PDT)
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Jul 2018 13:06:28 +0530
Message-ID: <CA+G9fYts6wuFgVHL3TfON4WYporcuFtpYe0s3rSm6eJBuvukFA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.114-stable review
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

On 20 July 2018 at 17:43, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.9.114 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jul 22 12:13:47 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.114-rc1.gz
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

kernel: 4.9.114-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 97637db053bf8323a8b81dfbc2d32b9111c65377
git describe: v4.9.113-67-g97637db053bf
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.113-67-g97637db053bf


No regressions (compared to build v4.9.113-67-g8c66f4ccc9b1)


Ran 16396 total tests in the following environments and test suites.

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
