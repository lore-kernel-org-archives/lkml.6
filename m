Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25534C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7E920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQF+8lYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfAVNdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:33:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35520 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfAVNdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:33:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so18085543lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s/bavXojHDUtomwRUL9R87NB2iPK1uK7VySnEspdP2c=;
        b=IQF+8lYjGm/C3l3/kuF1cPKQznEgBivpwXqmhlNUq9ljWKaohAdb/vqRV/edayB7IG
         f5ugTLOZY3xHX/44/Nc3ad/XIvEbgI5INCwJwRMVPGoaPgwFnSbOY2s9RbVMJPZYXWek
         RRgxludiSn8xtzzZQEfgOpVe7fOaXW/iRUZzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s/bavXojHDUtomwRUL9R87NB2iPK1uK7VySnEspdP2c=;
        b=UlvggPQOnB6vGHj1NAkIOYH48fsVRgfRdj1SwWhRwMIKMUVD/94M44jl19+DTWtKUF
         bHnulm8sX5IkmwYVxx0uDIQ5Q/68FOQpN1BsheOC1VAUnL/TrMZibdt8h6hJaU5XGcZS
         8gn5AIg1op8Pl8McWTfkYRZ/gWeBJlwDS38Iov/8zpOaQ3Caoh6gUdaM8lfiz1R0dLde
         FCC5+LOS2ui7x7ugWQQvbhtkD7o04Cc4o3YvjsY/9/OdznrbvEfI3Ky5n52dpkSQEOT1
         T5kW1aCr8QG9dVRc9OBXJPxXE7KP3D0F97lIB7RbDueOs3SKDinu2LuP0ySpADmmX2GS
         TLrg==
X-Gm-Message-State: AJcUukcCVHOAgNpdLiNrE4Q9c48YAaX2hgY+qq/N27qHXOm4ajFn8Ikx
        4L51OxylyKabuDcBIuhRwt//0ye9OoWjtIMzTB7SDw==
X-Google-Smtp-Source: ALg8bN4aj5ipwr+wmomd5yL76phV5rUgewhWrACicDQqX7VVumqdnqVMCdivuSc94APIMVkC0Qmdg7qhPOkhopAC58U=
X-Received: by 2002:a19:280f:: with SMTP id o15mr20257201lfo.0.1548164019488;
 Tue, 22 Jan 2019 05:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20190121122455.819406896@linuxfoundation.org>
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Jan 2019 19:03:28 +0530
Message-ID: <CA+G9fYvnXwTyD4+O10vr-26rX2eW2RWB=8v2W2N7nBCFozm+Fg@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 19:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.4 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jan 23 12:23:56 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.20.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.20.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: 67648eb553fb944194c327026f4be4632dce710d
git describe: v4.20.3-114-g67648eb553fb
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.3-114-g67648eb553fb

No regressions (compared to build v4.20.3)

No fixes (compared to build v4.20.3)


Ran 20503 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
