Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00323C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A922503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqbrIIGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A922503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeKLXyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:54:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39332 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeKLXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:54:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so6244175lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LgYCx7eWwbtUiOZrP1xd0VBhi0UqMMuAb+1bsmMuPfg=;
        b=gqbrIIGqYIvNUuzvwdHa/yxQz8bm926g0rmBUEfpB6FvtQAKOgvOSFuUysXV21P30g
         kdEAHmQZppD/lXSNPs23VbUwUClqeBU6s/b7dcrytoW6irp0mPaKMO4ECY6oJA6c5N8v
         Z3Tj/JpuEvDizoXVj7iczvhf+cDa+JZc75S9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LgYCx7eWwbtUiOZrP1xd0VBhi0UqMMuAb+1bsmMuPfg=;
        b=G8dlzPyLsi6HFDmHHDFUVvps+y+njpUjmsn8k+lEm4SNlqdN4h/kjfpeyLKf2U5B8R
         QToVGgTHjVFp8brY+/CBoLRvyap1Y+1TxBvoTlR6hzLiiomkRdEkLAh7vOk8f9+5yCWQ
         ijnURg3G6JIOrHvbwn24dC24ZKyvTGuBaoPHdHj+6BhHGdQQRAnJ6FXJsxuoFW5dQMgL
         jNKQr9A7hwWFmI+kmXLQORgZcea9d/SV1Kzksw3a8sAxGyFfGvxg4p2iVRYxohjPqAPT
         hN7aVNHeK/FFr4VE1BopzMiNT3WXPUsgaWisQqoGPjtILckzQYPJai6Xa4h9372R9vJK
         zhjw==
X-Gm-Message-State: AGRZ1gLizAUGM0tmI/EqqrcPGapXyVrvbVrhe688VYWHBPA2vc458Kmi
        4Wnxpq+7ehND/tjmBT870oMNwSq/ZnHMjmvBX23KG6w8GR8=
X-Google-Smtp-Source: AJdET5dQKgIxUNGZwvyAg3Cr05dvWgE2qysNllH4oUb73UPRrHDN7tqgfKpyF+v0I1tpsL7/otRZ8h8dYto1nMVx8mc=
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr666325lfe.152.1542031270271;
 Mon, 12 Nov 2018 06:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20181111221619.915519183@linuxfoundation.org>
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 12 Nov 2018 19:30:59 +0530
Message-ID: <CA+G9fYu3EHLe+_wkpU+oJVJ1FgPJVNrqVxYEK=Pd45met=Y-pQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/361] 4.19.2-stable review
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

On Mon, 12 Nov 2018 at 03:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.2 release.
> There are 361 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Nov 13 22:14:55 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 9ac3c2d4889c84e1fa030dc61ca5aeb6951f8776
git describe: v4.19.1-362-g9ac3c2d4889c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.1-362-g9ac3c2d4889c

No regressions (compared to build v4.19.1)

Ran 19028 total tests in the following environments and test suites.

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
* ltp-securebits-tests
* ltp-fs-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-timers-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
