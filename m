Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FDDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E8020C0A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4cfSN14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E8020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeHBItS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:49:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36639 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHBItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:49:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so974633lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lLcND5z6KiNCbk0ocue2K8scOHPZ2l7J0asmIoD6XLI=;
        b=F4cfSN14gPrkSFuCN0KJzDYGFx6FHmkT10BgDh3gKWdxkHlJfF5c7jLFVigHu4E9w0
         DYbvm8tRrUUw0IKFhOhEmId3Ou/JfJjVPH8zNYyN2Vzcj878+O6MMQQQTxcujo7cFJqe
         lFv7l7s2FftMP7G3lO7+21S54fNbOwbb4XfbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lLcND5z6KiNCbk0ocue2K8scOHPZ2l7J0asmIoD6XLI=;
        b=iBA+rJNt+CG4JfjTqnFW9iDkpX4GiHkLozqc2rc4uemtg0YWuDIQqQE1MP3pW6DMIp
         OniFeP1ZREo0HwnX+06SyAhTJShWUUW2SdC1NszlJ0EE65f6GYcAFeHCOkUVkgtp/xvS
         5MB4ILEEzCuRGw51iBMc9ql9G1/ABul+pjj+ychEAmjL7suaK1Ee1rOFdq9fmjdoTcDf
         4/c77Z5cozjxHLKK7gcIfdCKq855O9kih1SIz9aC0xLiPbd7tFCQ0kg4uhjjDw8+ahWp
         ezf3z/95zbc8kFLtPinLt7WNQJrHDeZuZYvQSNacba6EcuogOuBHkvqAWmLbH/RuaVz6
         tiJg==
X-Gm-Message-State: AOUpUlGhSC/oOtZWIyQ3GGosH1FXzxl9hfM2ONG8i5XfjTzX8hpcNf9+
        g/3ftNiv0MPOVfxqVSt0ZSH0CZz1ZtGJ8/O6d6XWNA==
X-Google-Smtp-Source: AAOMgpdhrHHBd5gwfxsiLLtZFYGByqh7kPObI3BDYbw8p7M0PE0ody23Ka4jkWZXI7tVydlzTTpB7KM1+vygWk8S5M0=
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr1163373ljk.116.1533193170998;
 Wed, 01 Aug 2018 23:59:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 23:59:30 -0700 (PDT)
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Aug 2018 12:29:30 +0530
Message-ID: <CA+G9fYs_Rto2f0qZbcYcsFM4_VKWU8+wy0pL_dPDid22=OPTPg@mail.gmail.com>
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

On 1 August 2018 at 22:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.117 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Aug  3 16:49:15 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.117-rc1.gz
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

kernel: 4.9.117-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 7931028e6a56be254c860cc094b84e3baae44850
git describe: v4.9.116-145-g7931028e6a56
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.116-145-g7931028e6a56

No regressions (compared to build v4.9.116)


Ran 16240 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
