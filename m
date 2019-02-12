Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF9CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A6921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAcR6blk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfBLQZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:25:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42633 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfBLQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:25:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id l7-v6so2738572ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ru1wYpxfy0I2oQnPtcP2VHoeCQ+JKlUoohtDSUEzZo=;
        b=RAcR6blk5GSJxnU7qjyoxmAr31m0bRreR0wb1pDnjug3qQwZ+aIviGUCnd0n6xP2DD
         QPCIte6wKILeQ7LrnIoW85TQwVjrV+LzfmOLx1Fs5PVkeifNoSN3qvIg51GZqtDng47j
         v44Ov4DMM9XgoQmPv2XlW0M+etCoyB+sETprXboJZ+jfqrlYN4o/Us+W1NvTI9R3Wq0Y
         HcZew5y7/IgdoPiWY8Jm7NrZF8FmqA8sfJBjR7//2qGoUol/V+jIDuE4QF/nB7WvQ6aQ
         ZEzgA9JcZNOc1WgkRTVzrq2BmNCUxI8b9Na+hfwkazxcE31qlbukaE+JfTG0gNhsWLTF
         JI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ru1wYpxfy0I2oQnPtcP2VHoeCQ+JKlUoohtDSUEzZo=;
        b=AXnt8Amps3WhwsmPrIg35EIRNP/ZZCRKcIXHQBM4TqH+8GmpNHy39FhVp8KpDy41re
         9Js/CErOCdzrVWNriXdWWo2OvhxR4xwFaTCdVIhD2tk+rNRlRJnPhIvP+4qPFKCMcmcs
         3zONjtyxnOSaEks6l+H/bRn9Rj51mn9jfKyJc4a4vD+PjqmZelH8Qn7TPXhycbZnTh8f
         N0sO8svPd66/ZnhNRqKsMl9M94QGLGXWkeb1HebU/Tmj8JyRQBuXMRHUbIIOz+kbrpTL
         gx5OaA7mo6af30pewb5TaXffamR83wVOH+GtZhcNBwq+cJ0/EUvHez/hzkF5q7D61Rv5
         iahg==
X-Gm-Message-State: AHQUAuZXamvBKCCWVDDoRuuCyvIpo3s4ZuuOw4Hg57pQEPqOGXbMeAoe
        859jy55csTEn1IJEQfgJXDEw5SiszQbsrzBjOXSqOQ==
X-Google-Smtp-Source: AHgI3IaIdj9CyJtr0lufIILcE/XlSGD7sQ8RqD/ELkhSe9yFfvm3RZSub9caWJEoR+5jgLpUukELegP6lA/1d4ZhvWw=
X-Received: by 2002:a2e:8688:: with SMTP id l8-v6mr2717182lji.75.1549988723373;
 Tue, 12 Feb 2019 08:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20190211141846.543045703@linuxfoundation.org>
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Feb 2019 21:55:11 +0530
Message-ID: <CA+G9fYttjJkBob7Yngnt5uszy+m=qkrpKodx+e5_w+1Fin+4AQ@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/352] 4.20.8-stable review
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

On Mon, 11 Feb 2019 at 19:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.20.8 release.
> There are 352 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 13 14:17:03 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.20.8-rc1.gz
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

kernel: 4.20.8-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.20.y
git commit: 2a1c4a78ff2929597b3ae4347873168b976cbe90
git describe: v4.20.7-351-g2a1c4a78ff29
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/bu=
ild/v4.20.7-351-g2a1c4a78ff29


No regressions (compared to build v4.20.7)

No fixes (compared to build v4.20.7)


Ran 13246 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-io-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-timers-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
