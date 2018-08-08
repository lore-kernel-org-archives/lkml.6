Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CDCC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734B22171F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AqHPsqmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734B22171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeHHHiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:38:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46809 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeHHHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:38:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id l16-v6so629061lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 22:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0xttizLKs0wtWmEnfTGUR3uY1+NCy3x43RVDppWKndU=;
        b=AqHPsqmvdnLF3NVNnPZuOEifVEt50dnoWRLPVkm2mRuwq9+VEig81HwGji3ORK3HcE
         1mghMyAj4SHvLHoPrrTDRtqy2BZux40U/BEc5fq64ekN1hJWJ5/Tou8KpY4/FJqAoito
         n3diCo1Q58ZWDEPI0zsfyuu03dqiLuyGak7Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0xttizLKs0wtWmEnfTGUR3uY1+NCy3x43RVDppWKndU=;
        b=Najd3FQ/V9TFAxdqnfPIWjE5q9aDt75heinOc7BV5yNyY7ITUoX9B+LDxjHLf7Mosc
         VcLRk7b0VqoZAk6xYmXrSTyqK3p4/XOdehzLRKes+F3Qb+y0omEtnQb+Et7Pwfcea8W1
         c3EP5RH4HWU7ssETp8JLN+BDdAtNaitA7z0PzJgeMyuekFvtxIwLQRqzzSHJuglRmetf
         7PX6fPYRn2mU3Cc+UXzVUEW2wPj7OYQYO9EThnBHFZ2sxFGW+PVurArcMrB/xsJJrPXM
         W7dmPEhd4Y1XbTwTCBM862UkY1L+HexCHIvuNf0+l2OKwxMzVMbyLqJz6f1auqDM69kj
         Y4xw==
X-Gm-Message-State: AOUpUlGruBPtygn2tHWU6Iic4CTJFtXdRTiJoalE/6lojC2Lq/Yuu0Zr
        iwuMzh5WPLgqdfFOLQVvIaEyX+d7+WL//9Dw3F6aog==
X-Google-Smtp-Source: AA+uWPxnXf4vc5mcJEsi8fhSS8+D3uE/TgHAYdqDAuzMfbr/QSbltoXl631mGrhGGS+PTopluKouA4HwYMVOHX6caOw=
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr791271lfq.113.1533705621355;
 Tue, 07 Aug 2018 22:20:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 22:20:20 -0700 (PDT)
In-Reply-To: <20180807172312.964272530@linuxfoundation.org>
References: <20180807172312.964272530@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Aug 2018 10:50:20 +0530
Message-ID: <CA+G9fYs9xDrM-V5=TqU7dYKTtNDwORjr50L5K5cAmJjf8YpHCQ@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/18] 4.17.14-stable review
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
> This is the start of the stable review cycle for the 4.17.14 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug  9 17:23:05 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.


Summary
------------------------------------------------------------------------

kernel: 4.17.14-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: 53b91e019709af31eaf31b16123585f05c00a411
git describe: v4.17.13-19-g53b91e019709
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.13-19-g53b91e019709

No regressions (compared to build v4.17.13)


Ran 13918 total tests in the following environments and test suites.

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
