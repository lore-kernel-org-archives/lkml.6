Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDE621854
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZcitCiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDE621854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeHUVYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:24:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36816 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHUVYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:24:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id c21-v6so4459764lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rs/lO+SwystcTx/+tcoam+ENZo4fBcqVqRil9Yikzt0=;
        b=jZcitCiCecLa4bAOm4nSuAl6Q4UV3vhYD9kXzDp4YDeydRFjS5ljiofVYxAmt5eP6d
         e22mCogEEnxgUvWWs4yZ65U3uors9u/XdiN/J2aAb3yk6WMl5NyNUNKIsJEbkMmMclcq
         Tly3DtLhiJe4h/lkJEOkK+67Afmq2TLxfL8Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rs/lO+SwystcTx/+tcoam+ENZo4fBcqVqRil9Yikzt0=;
        b=jFcenxc96JBdac+juVFkcJ6w3HuNORM52PpuNWJlLUio6W4MwfNgmC+OjGP759RqNp
         SYDbWzmpeHVmMlVP49p5juB56FGUfi3thofNEJNPjXxHn0pueRB1+zqYuVKLw3/7CuBk
         60z4B25Yalo2w6gClqSBisNaDl36vs+LtQLlGP1BHtMoppMawmx0oy4aL5/Rn2ns3FhC
         ox1kUnZx0yZtQLk+rouuLL+S1prGfsLAwgSotnFWASJJI7ovdMhs3YjYi0gVYPbyMWhs
         Q3EQobs8iGNEZKuBJ//YS56G/NiMtnbCNK2Ks1A13eKrJAf8jMpC4YQ20TGZ04uBHCNz
         Rt5Q==
X-Gm-Message-State: AOUpUlGS+FqPPrTWOqYxosl6O1zHtX46sG9EXP3jBEM/EostpAO0OTlq
        tZOe1GS/SZue/G+pkmB2uoz6UAiUtAHibtTyP5e44YvfB4I=
X-Google-Smtp-Source: AA+uWPwhUrpJ25dQPDHepK41JcLNs9b5qqsm1AX627XZuC8qfOvyw3mYTaiAHAOCzLHH2R0B9UGGdIolt2k4zDR+4e8=
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr34827825lfd.17.1534874613387;
 Tue, 21 Aug 2018 11:03:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:16cd:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 11:03:32
 -0700 (PDT)
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Aug 2018 23:33:32 +0530
Message-ID: <CA+G9fYsOC47MDSUrJK7e8o6QHJVZPv_ZmonR12omg9c3kgGarg@mail.gmail.com>
Subject: Re: [PATCH 4.18 00/35] 4.18.4-stable review
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

On 21 August 2018 at 11:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.18.4 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Aug 23 05:50:07 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.18.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.18.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.18.y
git commit: 1b2dc862d5f32eded2e22e173a92771c81dbe5dd
git describe: v4.18.3-36-g1b2dc862d5f3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/bu=
ild/v4.18.3-36-g1b2dc862d5f3

No regressions (compared to build v4.18.3)


Ran 15693 total tests in the following environments and test suites.

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
