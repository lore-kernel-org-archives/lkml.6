Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B95D25459
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWl7Ur4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B95D25459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeFYFGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:06:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32782 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeFYFGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:06:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id b7-v6so2496195lfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 22:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+xamVzowMINqWQQbg7vy1YFCSYZPL+ZP45UPL3babms=;
        b=MWl7Ur4EXS6lrMwdOkuuZYfL4yc/8T0C7gQwodXnCjuNcVqs0HZGUPf58AED2JZ6uq
         L3NKlfgmFKVs40+dv5r/f3asVjsIVlPdyTOQquXA829cX5E8rTeLymW7djC1XBM6OnVD
         CcHAv7qWGO9G1hPYY+SAFCNG/5L3Y3Ghat+zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+xamVzowMINqWQQbg7vy1YFCSYZPL+ZP45UPL3babms=;
        b=ofg/QM2XqyrMY1xqVtwlgY0F6ztCMA1Iuu2g6eIasJjKq3nFr9W2cT7SOn2RNKLAhq
         ez3w9HgJkMFeQ+aUwDO62ip+X0MCy0L1sMWSOXiiEXlt2ecD+5YcBlOXFq9K1aXDKFVx
         lOGLqBti/HceExNboubzhndEUbdqP6h/isSICTYJpXxEqLcHDgp+ZTssTyRR8D2+5rwj
         IYUFB+MF5HwEczJ8xoecprWUzlIbhtZm8aiXqrVB7bXwI0yAdgxswF7h7X5oZmvYZy3H
         esTcqcV3cIBdvGH89fVfeVUiEl4+fvMe0P9bJzv8UxPxxFHjElSQW1b29d4vR+P8Mybs
         tL0w==
X-Gm-Message-State: APt69E0rCm0fm/VumDOCDZB7ykbIADcH3XoPAr6ggKPSHt1b8x9s6J2+
        K4kIdyH9xf4gTrjHDtKgtRvIxIFyr7Br+P4C/Z0Ncg==
X-Google-Smtp-Source: ADUXVKIul4bJrjItsVIN31nvm/hnjZPNSIHLsLJRqabgnV37OD0Vm40SfWWN0LtHvcVocwKjpS3zZyXTZKV/FS17keo=
X-Received: by 2002:a19:c1c4:: with SMTP id r187-v6mr4821126lff.90.1529903208463;
 Sun, 24 Jun 2018 22:06:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 22:06:47
 -0700 (PDT)
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
References: <20180624152352.038950449@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Jun 2018 10:36:47 +0530
Message-ID: <CA+G9fYvEfPc09E9oBEd4fB2Ya1jdXB9cmfAy_x2-u_bPgPdA5Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/39] 4.9.110-stable review
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

On 24 June 2018 at 20:53, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.9.110 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Jun 26 15:23:25 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.110-rc1.gz
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

kernel: 4.9.110-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: fe540a7de55792b4b7ef577aec632e14ad337480
git describe: v4.9.109-40-gfe540a7de557
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.109-40-gfe540a7de557


No regressions (compared to build v4.9.109-40-g7accec442c1b)


Ran 11448 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
