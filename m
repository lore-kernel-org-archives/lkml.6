Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F819C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58AE20823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4+/JsTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfAVQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:08:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33021 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfAVQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:08:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so18513399lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0IWIn2BpFol7HVojciu/Tn7fhXYnqy5CUIvd8t5/B7o=;
        b=Y4+/JsTR/jJLGzza4eu21WjlcoNLXRHlxTPE6hYhPkz885YPLf/96H+osktkHyxfNM
         bk5oeazeRfI/qyxicM85TL51Pfy+SplET0JZxAb/SnKWoEmKk8xRNc22oNbKXvJGzxGY
         WR6MzlajvSGzoFoy+mDsEVpaS1sZSXkX+ehgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0IWIn2BpFol7HVojciu/Tn7fhXYnqy5CUIvd8t5/B7o=;
        b=GaFjc2RPPlhz51YOLyJUfqS2iUXYt68FgAUCSdM5B6d0KvnFo+PcbPQ+oklj3Z9iZ8
         krtgRIFn1j+uQo1ccDDf9dub/pYTbErNsIBsWL4oh3y1hGUEsv+8ZObVx6JRL+yQ25AE
         PGvEtJEswESHmH8rKBx/FsuxDxakUZ0xD9pJ3W8fh9LvKt9WW6mhkcp1e9AWhx+z3WXL
         hdFMXb+cgaLs1K7JNJGrIQRUHH6mSsYL6/SKNGVeaaviaP4GvCo05mKxkcGOGspx98DA
         83drtbjPGuXLaRLTOgl+ur2uk37cHG/y2o1Lfo1RH2ysUzSqAgb5qbItfsQqZRat2fLy
         SC6g==
X-Gm-Message-State: AJcUukfdddZt1aQzrEvMbnzwfByOu9+ryPZIZzYoLSt6LYbTRp+AKsHc
        5RkR91AXaGM0jOjVqDtY4g2Brf97hYRv9OyEO1/FPQ==
X-Google-Smtp-Source: ALg8bN5JH52yaGcgHQlTfFmdy6OLH99esugYzxfDfxId+Iz5tHhu2hnCgoBPM2c1gJ5pSdmAPhQWu/9TtfQvuAxXou0=
X-Received: by 2002:a19:2755:: with SMTP id n82mr19944596lfn.94.1548173294727;
 Tue, 22 Jan 2019 08:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20190121134913.924726465@linuxfoundation.org>
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Jan 2019 21:38:03 +0530
Message-ID: <CA+G9fYs0+ZYC-cXdNdKhhA6rN96pgKX0a-dFroKhw3Mwf3P96A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/99] 4.19.17-stable review
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

On Mon, 21 Jan 2019 at 19:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.17 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jan 23 13:48:56 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.17-rc1.gz
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

kernel: 4.19.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 23a84dfade5b350d25ab6afd6a96244a46572511
git describe: v4.19.16-102-g23a84dfade5b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.16-102-g23a84dfade5b


No regressions (compared to build v4.19.16)

No fixes (compared to build v4.19.16)

Ran 14175 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
