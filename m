Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34851C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE37E20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SaVB7Odo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE37E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:39:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33514 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:39:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so2875695ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 00:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mvFuAWejX4ERlIZKdGJoZvz0NF8VHV6FshqcLQwIZb8=;
        b=SaVB7OdoP0b4EJWUPZ+xhhZb2HyPcEHwqUZQadUL4Kgd86WrbNcl2mUcGrThatJq9I
         2KsJTjEwmLwthxld8UsnwDXtcAdr74V5L7VaEPGlpMj07AwdJ//+sRwsJooiO63iJGat
         XDfyO+ir6tnDe0/4sf/xpcr7Ktz+mWibZkciI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mvFuAWejX4ERlIZKdGJoZvz0NF8VHV6FshqcLQwIZb8=;
        b=qDFfTJk2yWHw7LSUE1DMOr8tHzPakpoYAbEhUVISbJi2ZvnaEJpxWpErSuYltxt3+P
         M9W/yXaI0RkuLHP+aqA+HWLh0lghoQKAmFaBGFdIi7v36JQyLJXxNgcS0T1Y+aLnU1Ia
         PavNrEgkDKYRPkfRQy/M5ZFOyPoJWC/rdsMg5hkPCM8jyPaRzIomEF73HiRPvgnrPm71
         lHS1XIuNjgG1aYirBUHxAZLoxrjIvEhK328t9x4ju5hCjoBvzVsNCthypg6DwbIykO1r
         fIDXCinMPrI/nGc0kY7vzWfjw0CQ3H3zDbHorA3DR2rVTVn4QYeHDw9A4Ts85lBSXSG8
         TDMg==
X-Gm-Message-State: AA+aEWbugjfmWUhFPhJc2nFZqVwn3Y4PJAG5f4xaJbkL52cxxcSvL2NC
        hR8L5eMo2GmHr5TxcM7uPxdIUu2EWG7VYaZ2QzLnUw==
X-Google-Smtp-Source: AFSGD/Ua27GtzEi5/+YjnvGBl8dNT9lG33o8WSYsRc3sIdzOV6wlBJDHOh8GAC/zLUtIwBAzwr0CS0+eOuUS0op3m4s=
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr858204lji.130.1544171972722;
 Fri, 07 Dec 2018 00:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20181206143001.749982936@linuxfoundation.org>
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 7 Dec 2018 14:09:20 +0530
Message-ID: <CA+G9fYvyyAc85C=Xz2WPak+YJsS4A-2LHq8bj_iv6XMF-Rz=NQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/55] 4.14.87-stable review
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

On Thu, 6 Dec 2018 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.87 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec  8 14:29:38 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.87-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.87-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 555f40d53ccac2c84734383d6d86dba512b5e033
git describe: v4.14.86-56-g555f40d53cca
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.86-56-g555f40d53cca

No regressions (compared to build v4.14.86)

No fixes (compared to build v4.14.86)

Ran 21416 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* libhugetlbfs
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
