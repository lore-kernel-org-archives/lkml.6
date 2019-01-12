Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A8C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE43205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoPsd6XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfALIH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:07:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35052 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfALIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:07:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so12433872lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 00:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zid+x5QBthhvD74nBBL3kZWn1j3Xjyjfxrw6LXE++jM=;
        b=OoPsd6XL/twRscrTDVSWlWcoKVquE+OC2fYSocAtnJsvRwYgfC3Ele20zYdHBT6gck
         s5UC9P/31zSv3XKgYR/kgkfxzDGAkLawxElci65XYYZUGATxpqqcZ99F4HmGmAhpKOL9
         WxXsoXdmpDTSKP1oG964bepkMLV8z3lZQ397c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zid+x5QBthhvD74nBBL3kZWn1j3Xjyjfxrw6LXE++jM=;
        b=gAqAdknmO46mdFcaY3puS0BGx6VBsljUW8uS4lweuaa+m0DYTTiwYZSvnfMUHQXD0s
         Exib4JSVzne9U4YFjW6+5/CKEBJsOzwR01DuB2kYZUr+QATyn1nHCcUITYVAwumlPZ69
         hKc/U03wMqBhDwXvkj9jVVnb+NeveHrDHd7+h6Qnw7q59wg5KqlLGnm97AmEbCrEs29i
         qJul4AtmuzNvQuCrt5EfXu8PsGIq8QuXEIes/nZjOMuQlcY5h3DzY9A5F2wFjH7J0Crg
         xCBabzDlbmgTg4zbWZ/spIjoYbyGIBSiSWX2m8K96o2yY8VMmV9AIYEcZVxROWSFkOgy
         LPXA==
X-Gm-Message-State: AJcUukfr04/olOrA0zF9pgR8z16L39LNTeiRJIqM4VNVIhlwhpfNtYU4
        2NUMkCWZFkApT8nYSSTRGuR5HC4tZO7lAwp2nFJsRw==
X-Google-Smtp-Source: ALg8bN7GW8T69Ev7uYDd2En2LrQPhUrbEmuzIFk4PQEBR7AA2GBzaJvKimd8sLkIxrSbjlwdxEE5Fo0J/llgCCPPk/0=
X-Received: by 2002:a19:750a:: with SMTP id y10mr9408750lfe.43.1547280474291;
 Sat, 12 Jan 2019 00:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20190111131046.387528003@linuxfoundation.org>
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 12 Jan 2019 13:37:43 +0530
Message-ID: <CA+G9fYsyNC=e8LpH2F_ck7GPFkBokENoc0zDf9jib0cAgvyxSA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/63] 4.9.150-stable review
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

On Fri, 11 Jan 2019 at 19:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.150 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Jan 13 13:10:03 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.150-rc1.gz
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

kernel: 4.9.150-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: fb624570c0534e3bec22973b31ee9fb85e8af1ea
git describe: v4.9.149-64-gfb624570c053
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.149-64-gfb624570c053

No regressions (compared to build v4.9.149)

No fixes (compared to build v4.9.149)

Ran 21466 total tests in the following environments and test suites.

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
