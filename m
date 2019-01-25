Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9EC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA92218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L77Xvm0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfAYQ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:28:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34960 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:28:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so8888146ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 08:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iJNGL16vVQib1Ms9o0K0lhnMyKl3JopY+NzKEZ+CiiM=;
        b=L77Xvm0Dl1zH6hcuu24aC/Q9S+/h8PldDNZxH53pvZIKQtWBrehmhldc6GMZcGl9lR
         gEAH2vW/dPOUPzxio/4vmoVqCNVRnOjq0PwSVXCkazX7KkJ9LJDUKLBY8r/qgJylceS+
         96mFtiOttviCkwfgjRsG8M3L5UUDimnXofxLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iJNGL16vVQib1Ms9o0K0lhnMyKl3JopY+NzKEZ+CiiM=;
        b=Q2+gNqw3erBik/TqzlQIynnymNO6dwJ0Z6XwvhTLe54T68KzAWNVJ4Jo+nRBSur3VX
         cnCnkwfbs3Sabv8mcnRiJdZJt+GaCI/imTEbsSK5+KVr5JT+MCs5VL5STmoTh46Mr/8+
         UIa3c9OVkboBXxtRa6vGaXMOoUOCTC/p6sMDqRNA9BiQsfsoabwF9tt+E1S2rxj6AqBY
         uuBSrVTq2Tyy8TXlCAjFoaCApa2wswbT7JE0/ClJ4ilf6YS4+s993LNr2U272AL0bLoJ
         pYAzf8hwj6LPKfIZAS5t9CAw0L5LEZP49c3Kmop84w6g3SEA4zkKZd3qOOj1gLx4saNS
         H2kg==
X-Gm-Message-State: AJcUukf/I5muyp8M9us2jfQmuh3zmzV5NFWDOna9gh5uksCcOBsZAegH
        5YKv49kSYY1hYdL3nG48fNPTV8U9QnkAwfP+Pg1SOg==
X-Google-Smtp-Source: ALg8bN7X2Zqutd8MfuT0BvXs43LEXIbwNPaDHILC9mF6tXJn0GOH9TPB8/XUAs1DKeYk8EuPj59zw5g9RuTDAuZQHDY=
X-Received: by 2002:a2e:6595:: with SMTP id e21-v6mr9350781ljf.123.1548433724719;
 Fri, 25 Jan 2019 08:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20190124190448.232316246@linuxfoundation.org>
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Jan 2019 21:58:33 +0530
Message-ID: <CA+G9fYusO=cB7u3Lw4tXYiwfQzJj55o74wfg7EYORg3r+rDnHw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/39] 4.9.153-stable review
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

On Fri, 25 Jan 2019 at 01:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.153 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Jan 26 19:04:38 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.153-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE: Kselftest source have been updated to version 4.20

Summary
------------------------------------------------------------------------
kernel: 4.9.153-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: c5e65ad14d87e628cf078414e14b7e67f2432e70
git describe: v4.9.152-40-gc5e65ad14d87
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.152-40-gc5e65ad14d87

No regressions (compared to build v4.9.152)
------------------------------------------------------------------------


Fixes (compared to build v4.9.152)
------------------------------------------------------------------------
The test case fixes coming from kselftest version 4.20
  kselftest:
    * net_tls


Ran 21956 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-ipc-tests
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
