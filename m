Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CDC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0824C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tu6ZHgEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfBLNMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:12:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40056 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfBLNMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:12:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25-v6so2153993ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vmfcQi3hYIsQNuo63PRv2Fz8KjnAfxRgVGsrKznFU8A=;
        b=Tu6ZHgEokTSTXOWgkwsx4EmGLklDozGy8LT8+SnJs2jRnUbHaacigfgjPzimqjHThD
         pyqNziAwyDYECm0KP91mAISDpP7APe6rk1TR9KADK5+2gMAteRbQnNTk57+nxkzfoQ1Q
         2kh2k6zykgH1yvgR8ZHA1/I0O3ULkxKdGI2xrkI13D1KzNjmUih/onF0ehrfW4rF4yf6
         mcamNeGObG2XdXtEqfG6Q+7P4kWOBSEQ7IW2S4SSCUnsoKB5d+HNalJ6qeQNVD7tReUH
         MwNOHRepYNtnfInpfWNwIbylyFKUNZWoE3zsJ1WgDcGXxYiZ0Sw8oTxvm1VPbYn+VBos
         QYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vmfcQi3hYIsQNuo63PRv2Fz8KjnAfxRgVGsrKznFU8A=;
        b=LfMzGP+5FJvTpiyKb38m7D9HRBF0N4zcCQhVMjMZ6hGz9S7p9e77Hpps7dz6I3h+1R
         xAaYV53bhdgKfSgqhTEp5q3v6CjitvaiNs4XxsKB95O78gVWIoZ7F1LruuDvdBqhfd/I
         69IjrH4/OJ5WDG9kRE5hh24KqAI9tbIrpT7lPK0pC3spb6wi9cKSgnqSoMhW4KYljwNU
         U2P+YyLujZL6A5g9nyO95KBTRbWkLgash4jE3nHpo0Y5ml+1EUCVY5B1130SMLFWn0Hl
         C7WK/GLntCgMg2gATFjpO5YgDCA/kgItK5VK7dZizOG3JggcUyf+fiqghnV6U4qK4yv8
         l+Mw==
X-Gm-Message-State: AHQUAuY3XdoCeTwJmwN1jU2nh11BARm7InR87/wvg5dECJ1W13qkA0/Y
        yFSyIUIDiNbCHFWmTOr76gYOqyiztnrgu0d5diqWJg==
X-Google-Smtp-Source: AHgI3IYvMe7AV4fyT+xFcfh21gtnidlO1pC0ZlhyEhjAZIfWiKt3d49s/X7BLd7Sv5+TJIZdbf+iENAKPIvCZqbVcE8=
X-Received: by 2002:a2e:9595:: with SMTP id w21-v6mr2246212ljh.194.1549977118392;
 Tue, 12 Feb 2019 05:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20190211141852.749630980@linuxfoundation.org>
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Feb 2019 18:41:47 +0530
Message-ID: <CA+G9fYszpuA5EmU_PY0AupCGZ+2pixKkMMgherwemMp+ALhVmA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/313] 4.19.21-stable review
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

On Mon, 11 Feb 2019 at 20:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.21 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 13 14:17:25 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.21-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 3ddcc8a209d38c7eb6eb5fd9b8bafd859a08fa1f
git describe: v4.19.20-313-g3ddcc8a209d3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.20-313-g3ddcc8a209d3


No regressions (compared to build v4.19.20)

No fixes (compared to build v4.19.20)


Ran 14561 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm

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
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
