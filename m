Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC0BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC1E218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhZcd/rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfAHHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:55:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45828 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:55:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so2193962lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 23:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ne2U2GWi5WzJT3JmRNQS2Xkk/gbB7lkRB4jSF24eexU=;
        b=PhZcd/rrfWI4mEXCmPWA3PxqevitWg8aCpxgwumILrWtrr92BNrrz14FrqZ6bZ/wfu
         cLPVYys8lE+viljsAYTxq4wYmeLNLMNXFCZlqY3Cyw9c+qRgyKmOO7AR6LLBLhNE0Zhb
         n8E2ohaEIbcsXs3cNblsx/pB2DL4GfxlpVwEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ne2U2GWi5WzJT3JmRNQS2Xkk/gbB7lkRB4jSF24eexU=;
        b=nLxVtwngqi00AEbdIJBufSqnwBvG8TxKhj1P3zakVyeJ/bmLha857K7uibGW7DpqG/
         1LSvLlwlY7WRS8aizMVvUKfKC0fVJrFQNizfcXRJUJCgKeMz+1kuEUiLVYJE86LjrJGH
         KvWi+1bzsaZxOZaLsLIAHUZ4otcHAxZSTU5toF9kffTELmzg+CWZszn1X6vOJui3zuAt
         pg2F8mAgrPoJewz8Zttc03byPdHtcXsFqPMcTtZafxSC6E9hE9wJ03cTas0a7UTiqtXc
         rvjeEndV/HlllnDvXpHBlKPZqBuEj2KFwMCJhagcTRq1tsTp26+ZeDPJ+w4olAA+K5gv
         JhiQ==
X-Gm-Message-State: AJcUukcXDcuV8zh+qHWpNUEKIx2vZRZnHZ+J1AWFhbSxUKICLD7oBjC1
        E1yBsQdQ0+2nlNN23oAt5hLLdXI9hDzWfKArMWe/g68N3g3G5g==
X-Google-Smtp-Source: ALg8bN5VIjG93g0Cu0BPUWY5LGnrfpyhVKUBuY2Dqh0Fv6kW5ODo7EMlEoIicwh9f1uVVYFfPrV9NHI+FAEVhn7yTTQ=
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr408806lfe.152.1546934131298;
 Mon, 07 Jan 2019 23:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.280153213@linuxfoundation.org> <20190107155328.GA26514@kroah.com>
In-Reply-To: <20190107155328.GA26514@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Jan 2019 13:25:19 +0530
Message-ID: <CA+G9fYuVdpS0Xv1X6vekA4EHCtRQBwN5chvrksr56K8QS7c9jg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
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

On Mon, 7 Jan 2019 at 21:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 07, 2019 at 01:32:29PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.149 release.
> > There are 71 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Jan  9 10:53:04 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.149-rc1.gz
>
> Ok, hopefully this is better, at least it builds on x86-64 properly
> now, -rc3:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.149-rc3.gz

Test results report of 4.9.149-rc3,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.149-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: d1d800b1ed7ab74a26df74ce1f95d5f49f36d717
git describe: v4.9.148-69-gd1d800b1ed7a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.148-69-gd1d800b1ed7a


No regressions (compared to build v4.9.148)


No fixes (compared to build v4.9.148)

Ran 19740 total tests in the following environments and test suites.

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
