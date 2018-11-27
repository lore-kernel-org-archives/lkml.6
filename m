Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236E72145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4q4YcWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236E72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeK1AHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:07:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39500 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeK1AHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:07:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so16365028lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FaAu+KofVcHKESvdpetmtg0jbNwlC+49NONox9Uu1Q8=;
        b=U4q4YcWKyeMaxuB5gIH/zq/GQwJTV99xSRXAB7lajGy6W3C9RIGU/y2vafteM8nGWq
         feIjBNLHrld5Hah+kWSFjxIkfar1nsTjCeK93y/A0V+MhSujT0XtMqSSZz8iZPpdzVhC
         orf7rqAYUbSBg6Gsoc8l9kxdSN/EWwqQZ8mVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FaAu+KofVcHKESvdpetmtg0jbNwlC+49NONox9Uu1Q8=;
        b=uBdNYIa6ZkyW7jondbK0RHeGFoHs9IDzlz9eFSCSQrcp08Wagqsk8W0oyg6mY7TbnA
         XjaS//CW3zkJDQ4HiEx1bpVnzdOaCt8CULst/JwpV7TvDxAk7BWyMrKompouP/DvNhbP
         DUDY0mTZ/MTq2j/IQewK81vDcgT4aJzTuPrSXvpB3lR6TH/ZIB74LsBgWSJgoDbS/4nG
         S5cPMyHHBlRadTt0/jtiRlHXmJ+vITXEgmvHi98CKHXRg1N3vOPPb4gFQ/slWCssHQW9
         RYTvZ0tKAYIFkd61rDUlkp7Qh6Nt14O2fCP+uA3BIWcaYhX8NcINkFLpYlJcXKVtoZK3
         wThg==
X-Gm-Message-State: AGRZ1gI34FWh6vXiqGuGChBDm/mGdmMi9ccM361b59MsiSiYZhUAE5y6
        ng3UK61WDz8WswMvUNzjmY8gGjdv1KdcD6KEUfcCug==
X-Google-Smtp-Source: AJdET5cauBeeE4b/bEQA/m1FFrGDOz7pTZfhAbws+BV7b52yIy2IrOc4OV3D8L+Ezr3M50PVxF/HMBfeQCfVU7Yvhlo=
X-Received: by 2002:a19:750a:: with SMTP id y10mr18339918lfe.43.1543324194863;
 Tue, 27 Nov 2018 05:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20181126105046.722096341@linuxfoundation.org>
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Nov 2018 18:39:43 +0530
Message-ID: <CA+G9fYsxS1jvAdLz7g_FUKZrpiri+j9eDerYaVuYkBxCgUn8fA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/70] 4.4.165-stable review
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

On Mon, 26 Nov 2018 at 16:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.165 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 28 10:50:16 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.165-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------
kernel: 4.4.165-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 4209bc7270f7d3a9daba39179d100aed0e025ef0
git describe: v4.4.164-71-g4209bc7270f7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.164-71-g4209bc7270f7

No regressions (compared to build v4.4.164-71-gb01da71bcd07)

No fixes (compared to build v4.4.164-71-gb01da71bcd07)

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
