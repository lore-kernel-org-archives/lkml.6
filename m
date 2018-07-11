Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC92208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqeXnM1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC92208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbeGKLZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:25:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38575 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeGKLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:25:42 -0400
Received: by mail-lf0-f65.google.com with SMTP id a4-v6so20973925lff.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6/RoF8yFiXrr9ZOj43uTFTqAvvy8Vmwp4TtmusUtwgA=;
        b=dqeXnM1fDn12QM2KQnuBVAERrjUiMCz0K8Wy0zeu6NFPA+S0iXxaNfdjghdm6UbfYY
         gmYTJ2PGWfM2DFE45WM1ps1quwRA9+jKbWRemb6GPeQYOHuijKGhJTGhJr1yxLrDIa0V
         1jlGRMjGY3lvdiEiG+aa1oQUlg2vkYbT6+HFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6/RoF8yFiXrr9ZOj43uTFTqAvvy8Vmwp4TtmusUtwgA=;
        b=emuYU7tYE5LFlHUlMxk0uJNxc2YiJucXHTqjdVdW3RdimQFagPVPFj66CDb+I+y5fG
         zWniTIcmBtI/k+nrAWEcRf+5NG2QHTpD8eaTIGIUglQI8o22m9+D1Gd7zb+k2fA/2ufa
         Y8iEJ8WJgW14AwGH0LUDECePU8xzQq0ofEMZiFEerz4v8k+ptP2g/Awq9ClQOm1ctuJb
         lTDm797rBlIzcV7VJhZ02ms1GTuTaE9aqlHrtD/19FesHh0w2w53OZMeWKDEBnG4EYdY
         +6NP6kMKYnsaPxs1SXbI6q+JdABJ6ScW+7NRMGIe4TDLodvFjJ1TOaWSgCMfSS+wwyH7
         yFqA==
X-Gm-Message-State: APt69E2n51W4nWj4mFZe+6ux3pOcRjha1enX/5cU7/LP6m4zLE4fbg65
        b7VQ6o84/GWHfNfq2pyeHJ5ZLcVe1CQP+jA7mBundA==
X-Google-Smtp-Source: AAOMgpczWOHDFaAe65XRSjh5fZkMG0Z6NbYz5sQunCDqrjddVCLzKubx/aYv667uZYehwfhCuR+/Lz7/fQ/kagjgj7g=
X-Received: by 2002:a19:8ecf:: with SMTP id a76-v6mr5973009lfl.52.1531308109957;
 Wed, 11 Jul 2018 04:21:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 04:21:49
 -0700 (PDT)
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Jul 2018 16:51:49 +0530
Message-ID: <CA+G9fYvEv6LFja_gDrSTszE7cV9zSBG2MPR54FwMXNage7g2nA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/47] 4.4.140-stable review
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
> This is the start of the stable review cycle for the 4.4.140 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jul 12 18:23:24 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.140-rc1.gz
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

kernel: 4.4.140-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: fdbfbe8ef6a39c654a86926ee65bb7607c14c36b
git describe: v4.4.139-48-gfdbfbe8ef6a3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.139-48-gfdbfbe8ef6a3


No regressions (compared to build v4.4.139-47-g67dd2dd30634)


Ran 12222 total tests in the following environments and test suites.

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

kernel: 4.4.140-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.140-rc1-hikey-20180710-231
git commit: 1691842f352f496212a1ccdc450cd48e1f0ccc75
git describe: 4.4.140-rc1-hikey-20180710-231
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.140-rc1-hikey-20180710-231


No regressions (compared to build 4.4.140-rc1-hikey-20180710-230)


Ran 2622 total tests in the following environments and test suites.

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
