Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B7EC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49E7217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjAdkHm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfBSFmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:42:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42926 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBSFmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:42:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so13954255lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CsTexNJ+0nszifNJ0CLUQEXYJMDa8ijraZXB55MIxq4=;
        b=tjAdkHm81bFcK6VhwQSOpcdfux+LhvwlcifjjiOGlczbGNKACZPdt+bSEIVesWj5Bd
         vr8ma/O8/v2W2bZxPzt5HvLaSIKVFf/S9XjUnGn/iHCa/VcznF5+ZjPkMamI4ETQjB6m
         GdqpbNoqjUh83asf9hbzuWsgtKLI7m9F9ZvGtPd4xb97Hr5BXXXjLvmSDwewG37cp2kB
         n9AU2bXS6bYtYuYd1DXCtU+rGdL7nO8cyilzKkMS3y74nE2eIjmsoYCQaNdvOmbfx4Uq
         hz6mLiKZqlUL1ECwvDsMG/tsLw9fusr55+3gXD3iDZL8kjVZXbKMDUc5oHAWjSnFSZui
         Y2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CsTexNJ+0nszifNJ0CLUQEXYJMDa8ijraZXB55MIxq4=;
        b=OvFqoZXoT7NP0dXw50qwvnyEpK8oqSeXt10QjHXwXKJ9H33kHmFsVsPE76LvTjEMZR
         bWbh5OhmLDLpDq5G8+3ppWSoawYX47TYXoySEcuiHKlbHOrQ2oX66spJXPtAc+ewqdCD
         yExQV8f3PMiPUtpABNHmV7H/CeVfBfnXNCYx1WamEiWgpGzwtPrZEY0O1dmKDRmkS+ud
         +/Maifn9dFzBuX/lef0rl7wDIKFCS8yVYAqKENkBUAIyJmx12VKT97UfUeRh5/yoIF2x
         NKskEqReklWVPFbZ+SfvbjF0BCOum/3+i0TRCjSwanA6qovZ5WMN7Giunx74KPQvDKMH
         hYIw==
X-Gm-Message-State: AHQUAubvmokj4EaP2NT6VGPqQfPcJFhYv11LrisS64gRITUzQXZWklEy
        1/X8EvZqVqP21drye7770Q3zSEDd0lMwUxQnRJIkNg==
X-Google-Smtp-Source: AHgI3IbVLgu5ktDQruSx/tdl4EhdI1+7Ft0I7Z7GUNGIS0XC2FRsuiT9qd6/gVMu/XlyP4VTDdXx0AumGwXZNYfONTc=
X-Received: by 2002:a19:c111:: with SMTP id r17mr7393263lff.60.1550554928230;
 Mon, 18 Feb 2019 21:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20190218133459.758004711@linuxfoundation.org>
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Feb 2019 11:11:55 +0530
Message-ID: <CA+G9fYtHBoQwt1=d_s=UcaYpaeUQMbZ-atzNxFPtV2K68cUWdQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/85] 4.19.24-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 at 19:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.24 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 20 13:34:30 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.24-rc1.gz
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

kernel: 4.19.24-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: e187e9146a190d89cf5c3e63a0792fdbad05f6c9
git describe: v4.19.23-86-ge187e9146a19
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.23-86-ge187e9146a19


No regressions (compared to build v4.19.23)

No fixes (compared to build v4.19.23)

Ran 21318 total tests in the following environments and test suites.

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
