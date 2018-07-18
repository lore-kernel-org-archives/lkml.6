Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC72ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1534A20857
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhBTMO0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1534A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeGRU2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:28:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35354 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbeGRU2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so5147911ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZWAzAJemFFC6u3w1jgLWHdh9Xojzfsjo1wQ4ZBgJq6I=;
        b=XhBTMO0n1BLJqHxNptaBzOKHffhEf1GlVIbo58vP2aQDpXGQ0IkXLHt5Jx6PRKzv17
         mi3X3gFC+K/afEaU4zqteJYHIBAYWY4G6SVmeY4RaNChAgrKfa13qTpm21rnYVdZmBYT
         NIAw0VMqre6CtkqIF1uzkzY3owbY3iJMnK1Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZWAzAJemFFC6u3w1jgLWHdh9Xojzfsjo1wQ4ZBgJq6I=;
        b=MhMGhl42Vx1wLCIY4rg5edG6RzdNBZKaHMqHg82SJXVwcfgYwArZQRh5Ry+FZS+8cU
         /aGigVC6tiKjio4R+eb3s9O3k/FV4acKZmFXQd9DRgvm7qPFuDB9O6ZJ1TkKJqUDsHYD
         OONsgO+8fz88y0VBPz4x2t4BBc+V3j6K8Ht19VT0YuYWWmPXSZ8FGz4Le2TJD/xWCYDR
         GJyOV1KwnnWp7Y99Kq8bs5x+a65f320Aqq75Z/VpivsW6LecfecKne0vpFWEJzTZ3Avo
         iKtrRVJ7ITryxMMiby4oBmZocPfGf7TygzxBiH9c+ni59b7UVblGJpDfCjq6wzLo9D1u
         3ybw==
X-Gm-Message-State: AOUpUlEo5l/YvlwDST+b/xay3PIKQ7uQR1Hzw5xfnc6yfFDI0Ds3vzL9
        BLhajTCvE65atzJDJ1oSeSW1UJA38XnKNyEavEJOyg==
X-Google-Smtp-Source: AAOMgpc9GPflVxowjsZLv7rjroGlQO+g+mlA9GI4R/6F2yNl+ha1liG9ELZU5I0tmeyk3/M7OQ8bi/BRgV7L8kp1K6g=
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr5427122ljd.67.1531943360625;
 Wed, 18 Jul 2018 12:49:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 12:49:19
 -0700 (PDT)
In-Reply-To: <20180718145156.152413234@linuxfoundation.org>
References: <20180718145156.152413234@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 19 Jul 2018 01:19:19 +0530
Message-ID: <CA+G9fYsgLMRhnh1KBfd0VnPq_7OBB__4PpCMH=JObd-zHnjiwQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 0/3] 4.4.142-stable review
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

On 18 July 2018 at 20:31, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.4.142 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Jul 20 14:51:50 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.142-rc1.gz
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

kernel: 4.4.142-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 2b2bbe24c1eb80041bb5a1a9bf0d3459a50b2b5d
git describe: v4.4.141-4-g2b2bbe24c1eb
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.141-4-g2b2bbe24c1eb


No regressions (compared to build v4.4.141)


Ran 12070 total tests in the following environments and test suites.

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

kernel: 4.4.142-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.142-rc1-hikey-20180718-235
git commit: 70607bf14095a0aabac2828351f3cec1ac1b1267
git describe: 4.4.142-rc1-hikey-20180718-235
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.142-rc1-hikey-20180718-235


No regressions (compared to build 4.4.141-rc1-hikey-20180716-233)


Ran 2616 total tests in the following environments and test suites.

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
* ltp-fs-tests

--=20
Linaro LKFT
https://lkft.linaro.org
