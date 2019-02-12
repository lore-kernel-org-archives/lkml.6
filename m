Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F23C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A89217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0H33+R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfBLGbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:31:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35344 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfBLGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:31:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id j13-v6so1224402ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 22:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aVP5XYAS7tHykRSOBhbLFEQxPSUg4oRdQaj9g1wwC/I=;
        b=c0H33+R4OQphPg+Q0eLrVdyJW1XGiZ6+WAP+jl0xY/qhCakt7pwV3a9f5t5tK9buD4
         L5Vb9QpYWK0SzfQ1GfEY4XpFDWbilAVeBCIf0E+ZcmiqbWyOHUhBUoWwwlgfZ79d7fLi
         ZVh6qp+tSVWjiLyCvFtoP8gYrMYR45/d+pVA3RA0ATjE+x5RoTGbKMQ6y2X/qNRJvNLq
         OwR0+TXZyseTrPwyUH5TtLjlxjrlz1uki5HAX848T4saPu9oEhEEA96VXp3Ud8Gqmn2O
         pJ5Ji3q/DtaTYkWCGTuBRFH2YsCX+AXcS7PsUKhqimA3NSlyyGLGvJOXI3eZIXUcigNo
         dI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aVP5XYAS7tHykRSOBhbLFEQxPSUg4oRdQaj9g1wwC/I=;
        b=QQ3sasnZLjDkZPUNYush30JMfPjYMBIrsujCxGPd/n2s0UkclsgcqpwVOj+rLsZcVs
         ADADpzPjr79bfxRnnRkoZe8xwRM+VkcSeuIy0hLbRoIgjxsdu7+oKTTCzdwY/hB7tcBe
         O3XNei1BcHAviR2grsQwoPyYQD+iF+gCdn7aog9i1NHtZvQ1/qXQMW4mm20e6P5VDqVm
         QsxIJDK8L9tN6PUBsRnWoItHp35x4TLdhtRgxfOP0slGHRYqVSGR/xKaqhFN2zYPqHgj
         9Pepyx9ti5GpdeyE3VY/jlinzVAHTIrUtMqdyn86iqLglClzIyQ8dZIXku0fI9dqyZyn
         6khw==
X-Gm-Message-State: AHQUAuYQlMPS+OaFMDcJMehEPk0l5slJejP49AkZFed5UeNnTPtUEwOV
        2+VwWSEHgqtY+UcjXBZ1n+XFImvcAmluUBt5yI5gqA==
X-Google-Smtp-Source: AHgI3IYv5/vbWTIwxhhnOX+kApsDr4XXCuBM2h2tvLBSLHAL03hG9H5/xgKIuWi+gwERnp04zHbtYRWyebJH5KnmM8k=
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr1333273ljj.136.1549953088894;
 Mon, 11 Feb 2019 22:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20190211141811.964925535@linuxfoundation.org>
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Feb 2019 12:01:17 +0530
Message-ID: <CA+G9fYsO4TinFg5u1SR9BDpSmCADvXvmKacJT-9_i8GCNr=L8Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/137] 4.9.156-stable review
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

On Mon, 11 Feb 2019 at 20:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.156 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 13 14:17:22 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.156-rc1.gz
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

kernel: 4.9.156-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 850a7fe2357647de8e0edd435525ac5a19e99cbf
git describe: v4.9.155-138-g850a7fe23576
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.155-138-g850a7fe23576


No regressions (compared to build v4.9.155)

No fixes (compared to build v4.9.155)

Ran 22129 total tests in the following environments and test suites.

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
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
