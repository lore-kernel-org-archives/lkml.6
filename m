Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA618C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE1A20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpXdmAqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE1A20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbeGKNJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:09:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43715 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbeGKNJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:09:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so19321210ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S87UHEYg3rpaM6Q0OfiX+QZjdgB+sYU/NdxuLbYDHQo=;
        b=GpXdmAqRpuyczkFfgpXIdtY2TzCe2xarX8O52zoU2NVLTxzMwpRzTA6i5as+WiMErF
         V0aF44xYbcoqzQ20zFMYBSE/hHFp5rjZN/S0zG12Omz15lnBxs1RxD3Vv0cPrMRhuYkR
         IjiQjUwVGdseFcfu032kKso+KvYKPsQeCDbt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S87UHEYg3rpaM6Q0OfiX+QZjdgB+sYU/NdxuLbYDHQo=;
        b=IZZXbI1JT2HCt3JDSAGP6O/oySRnEswKQJ05ZMJ7WQW/u4IOaOC+dhelRavlUjWzRd
         e5KvT/YeIduSovnkXUu/2L9HaQlSMjLQvRTAN9YrqidJIqABrDHksuzOom9/XASHXIHx
         QGLEty+aMgXuNYkiTJc4PgCY3iUlxMPy2zQWXPUwDNLftOU1o181j3zk6dUM6jI0hHIW
         QGrVZ277cwCsgLKg6VTmgYXWtENRFd6Tvqu4H9yBOrGIg4dfDw7aafEYpclTeSQO9AVT
         dtOgXcBLMsydCfbrOKDCtBXpp2weN7GVeBXB0caMD4q7oRA7sgWdA2m7KFdsLrVJSlC6
         Fc0g==
X-Gm-Message-State: APt69E3FNm790rl4qFamh0s/Af2T/9fUo+KKmqlg0eogR7vxZ16+lhah
        4XswAqhlcjMQSSu5tXAperM7L37jG3aadsbuw8HtcQ==
X-Google-Smtp-Source: AAOMgpd0TIA9isDotgYEID0rF0jmjhkNFo1FXXCGwpCg70ZIcC4630IynEwsmt6rxzt0TScAz8+JSMtlsr6X5txjTFU=
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr17320181ljf.36.1531314340829;
 Wed, 11 Jul 2018 06:05:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 06:05:40
 -0700 (PDT)
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Jul 2018 18:35:40 +0530
Message-ID: <CA+G9fYt6nvGyynWRpXEQJnB7+Cu36EgdvLOKtNKezgWYnz3u8w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/53] 4.14.55-stable review
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

On 10 July 2018 at 23:54, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.55 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jul 12 18:24:36 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.55-rc1.gz
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

kernel: 4.14.55-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 5c888f221d45895399fe36b2e0c0015a676320eb
git describe: v4.14.54-54-g5c888f221d45
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.54-54-g5c888f221d45

No regressions (compared to build v4.14.54-51-g0a7132162c00)


Ran 16542 total tests in the following environments and test suites.

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
