Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE41C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024AE2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcY1zBxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBEGjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:39:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42568 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBEGju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:39:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so1913520lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i1WOc94WXGofs1tPO9sUopj3outK4OTvreL8I6QMjLY=;
        b=FcY1zBxwyczGcduG+I9CBENqTI9lI4JDI3pYgTyBaHgmBvk9RrzmSvRKt3+Fd46XBx
         OMTRv1GzfZCnLzJ3apfv1Yg2eO2vB8e3h7aVd3GaiJnTe8PHXbqzYpjrgXCsjcXpFFZ2
         XIVw1zIy59Q6UgRY0cobSw/PBIZWTcLI0ZmCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i1WOc94WXGofs1tPO9sUopj3outK4OTvreL8I6QMjLY=;
        b=U5Vrt4zZwaCGzBOoaXbo41ltGe3+0euI6EdDFv/fC3o6poZnMzeE9XSj12o6tcpA9l
         n4LmruKFkOPggI+e5NvRSegPwW/ZVhHxuSA/3yNKZKBXiTa//KPXUMSZ4MWpx3hTkkDV
         F3TYCZsiSpzvvegwRC37G+ufEXWSwj7m0FSGvt/u23ZrFpmpsK2X6prj9Uhnzr1giGPj
         sD8nCj1W5X+51eoJbFWyN/zIPQiYHgWdaOC/05VDXmypR6+AnY6q2Ct8zHqCaRtpI/nE
         cPTX/aFIDvpP8LjhSi4DQzFzo0K7aotKKJ8YOiwQQHCNt2Z923M6RGXdrAGczfH5Z3uW
         GOMw==
X-Gm-Message-State: AHQUAuY7eBLW5+6O1LSchO/drc4dkzBfqM/TETC3cl1fJ22XopsUMF31
        I72xAmrQx3ltYy0SDRngthep5fhWV1SF+V4sJPVJig==
X-Google-Smtp-Source: AHgI3IZuZ5S9aivJXugpo9z/qOu0YBQXdNoI4pDTzPqpqSCb83MQ9F/RasSp3Kr0/XnnS9B3ply9IrkZpG+hdVSeqyE=
X-Received: by 2002:a2e:9595:: with SMTP id w21-v6mr1859751ljh.194.1549348787991;
 Mon, 04 Feb 2019 22:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20190204103605.271746870@linuxfoundation.org>
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Feb 2019 12:09:36 +0530
Message-ID: <CA+G9fYtvBc+gsY1PhW-2Z0-qE-p7mawtitEyUH7HPuCKiK4x2g@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/30] 4.9.155-stable review
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

On Mon, 4 Feb 2019 at 16:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.155 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb  6 10:35:37 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.155-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.155-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 09c6f7d1841f28f385a0082252c5c041dad35ec1
git describe: v4.9.154-31-g09c6f7d1841f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.154-31-g09c6f7d1841f

No regressions (compared to build v4.9.153-46-gac8774c5cafe)

No fixes (compared to build v4.9.153-46-gac8774c5cafe)

Ran 22030 total tests in the following environments and test suites.

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
