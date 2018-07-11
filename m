Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F2B20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OB82xCwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F2B20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbeGKLWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:22:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41490 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbeGKLWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:22:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so14297178ljy.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hclBxKcP6HhM6bHdNuMHBT6DYqD9VkL7gtkshld8R6o=;
        b=OB82xCwf544lf/nlMXXnkFDXtP/a3IRmBa2gufLmt1geA+AyORVqSZBb6qOgWh14js
         uHJKbhNAKdPXtsxMMWHfy6rYGhMKcZc4Ydf0YC2P+0M+Ukh+XvtSXrr9kww9goB7XMjr
         2fX8ixDsoZqHqSFowrWEtrTLTFExj27ANyNuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hclBxKcP6HhM6bHdNuMHBT6DYqD9VkL7gtkshld8R6o=;
        b=r0po7gXwSDrSeQo7z5bZZgqegWoZGt3flhzqVk9C46Yh/pgTYNCn7rSP+otPUA36sJ
         gQgJjHuneIyk09VvfrnXTx1BzzNAokoC5CSMjX4Vd85zq2dWDSop8oaFtU0H65hLr0sa
         z39KvpNJl1J4qVTKvCGxy/TI+4tOPQ3GRrUmJqsei7pbvWvYOQDXLlsMUiSZ4mKZ3zS0
         zIIjwj1W1BHYF39lxllwH1SjZXYDWsTzpNdym3bnz+Uo75hkI9ZINMEt1Mx5v+3lx8rS
         3XXWBl2OLcn7ggXbpEcoOggtDNjLkAQN5b5wGEBzq866gUacuGrMg2483VYfrsNInNg3
         5Qjg==
X-Gm-Message-State: APt69E1fD5tTcNjUyO21Rtlij09KzDb5DHSOWs/GmFeUyM2pLPYBTT0g
        XAFpM/XrsW6ew3iVqLpAle4ykC15ldd77P0RbCSemg==
X-Google-Smtp-Source: AAOMgpfLB1rAUNMn7Cop8Yg0XxdDUuF/ybvL9CL3hhR/IVq/bUTPDvLFkmZgCahEw9cLPE3GNeLjop/kuD3ldgEmyAY=
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr15951453lja.151.1531307889202;
 Wed, 11 Jul 2018 04:18:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 04:18:08
 -0700 (PDT)
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Jul 2018 16:48:08 +0530
Message-ID: <CA+G9fYtAkLjdXvbyM8u8BxEwnRBuD+FU-a6+w=J5OjQ6iDx-dA@mail.gmail.com>
Subject: Re: [PATCH 4.17 00/56] 4.17.6-stable review
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
> This is the start of the stable review cycle for the 4.17.6 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jul 12 18:24:40 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.6-rc1.gz
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

kernel: 4.17.6-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: f2ecef5f51032daf857ba27e7dbdb7d63917b025
git describe: v4.17.5-57-gf2ecef5f5103
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.5-57-gf2ecef5f5103


No regressions (compared to build v4.17.5-55-g20c391f52e00)


Ran 16496 total tests in the following environments and test suites.

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
