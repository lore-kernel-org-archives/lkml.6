Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C10C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA412173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1P4oTAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfBZIdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:33:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41628 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZIdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:33:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id e27so8983698lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rrQ4E4/ve0v/GuWmBNS/PuqjRJk8HGKJC8F4vYXM4F0=;
        b=V1P4oTALfEGEZ6IcFjqHiDwv7mDgFjxYFmUsUqEm+PPHTQ+6zrLtB13K6WZY0440DD
         YFb65aSaaenbgzkaad3PB7s7rvxCVmhoz8JZyFiuKRyO7FZY4LP2HmZ06okUGFsW/c0J
         xnCgyFN1l6kf0LtWCRnKknRJ325dtcE9TbYkFpNgbkHXCcVSg1tFV7cBdPUtEKug4IrZ
         Ks1b5dOpxUrb4rGP96GH3lW7QD0HDnOHCdE9MxKv+/IzN3VI1MvKBJrcOhaqQaIFSX/3
         8CDYj9JgY2D79f7tH7fNYuWEQ3yPUgRBGeoo8nbUKU+cojLl6bvLUWSgoDbNNGRuL/EZ
         lT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rrQ4E4/ve0v/GuWmBNS/PuqjRJk8HGKJC8F4vYXM4F0=;
        b=Q8+FlFGj8+AT7+KhdaSRZoSg8VAIDhtGQFf43bCm0Ty+l+ZJSZ5kOMZlCwZ9+ny/fu
         tkPacP+yxv5znkGFbt+t2u6NpM+aJH7FN+kOd0blyrcuk86Z4M3qUntwiDJTUD2Hl3iQ
         GnQTfHqTN81YmdOrJODfRfbneLzdsmKiLb7pGoZ3T5YSwMcL91bNJqGv1yA6f19cR3MN
         lW9rSVj9TTnkF/lXX0FxAQXn6Pr5qeU4FDoVk5V6xcqveS8b/0oPoshvuudN+Rf+bikA
         dfCqTwg7y2bt5g08E30caJbtMVpuVBE1QGKyglB1T0x5sDGt/pR/WGQ5q0lzYa8wj5NA
         OPJA==
X-Gm-Message-State: AHQUAuasvcxWIv2e1roBLTg8oZODFq4hfDBr+2IWS1LRV54DBG+aOXF/
        F6WPee/BUTQ0wV7wQN72TWH17rB+Ea7Vg8Agc2mtfA==
X-Google-Smtp-Source: AHgI3IbFfUvrD3lD3kg693fRAf8zfR9Spe+qehw79vOeLCv0mvj3j+OsHY+L301faAvo4AwwlJ/NTcDLityAM/uS5lo=
X-Received: by 2002:a19:c510:: with SMTP id w16mr13956095lfe.0.1551170016272;
 Tue, 26 Feb 2019 00:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20190225195035.713274200@linuxfoundation.org>
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Feb 2019 14:03:25 +0530
Message-ID: <CA+G9fYvke_nRmNXCjx-RTERu+rZVPqq+6giBOb8cYvk5jehNKA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/63] 4.9.161-stable review
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

On Tue, 26 Feb 2019 at 02:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.161 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 27 19:50:06 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.161-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.9.161-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 0c0f9f653c9f49d59a856ae2c38b0bb115c16282
git describe: v4.9.160-64-g0c0f9f653c9f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.160-64-g0c0f9f653c9f

No regressions (compared to build v4.9.160)

No fixes (compared to build v4.9.160)

Ran 22394 total tests in the following environments and test suites.

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
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* spectre-meltdown-checker-test
* ltp-dio-tests
* ltp-timers-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
