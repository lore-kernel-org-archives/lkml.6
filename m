Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE2820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhGP006d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeLTPDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:03:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39877 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbeLTPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:03:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so1602813lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+yF+mRO5+t2Sy3Usy5wJ4cgDUSE/pLeF/x8VtN8/RQ=;
        b=dhGP006dKOm9o5PZTvEOsUvvgrFbptquk5utyl7hQi09Oyxado24C2GKzSQikZWnCw
         prTt83C9NVYv8y5qm7iL1sZSjAtg3hV/+eY9n18bVR8OFla+PBFwPwmxUfuiXjLzfx8H
         B/d3Z0GNy6vHiQ2/InW1vyFpkbHsZ5kFWDb54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+yF+mRO5+t2Sy3Usy5wJ4cgDUSE/pLeF/x8VtN8/RQ=;
        b=BWZNix64PGcVrToaSaccIItdq8M7iMB0/4WwUGe3b7/zcOesGQ26Uk9J1UFnpyrBag
         1heRvH1o+MNGnBQLRxVN31HiqAdeHQ1ZNPrFSlhUDLm40qsOFudmuYfJcf1/qDGczasj
         TmdgNbVE6ceY+oROrrNivpc5SpmG3ktsBuTIzlRQgQTMt00O+/KTfPFnCkv4EEecfc8o
         tcZfRdz5/QcVB73oON2Rb5CBzSVqh1yxgO8hFZTMHRd7mD5hiubLh8IJUeMKJDLQ5s78
         TOPeMevH7sXbnkOW/L97KNdMpZxzQA0CHxYdii2WcqjGTZwPDnOSdzZzOwubKgfeET45
         m6VQ==
X-Gm-Message-State: AA+aEWa3pa+jwZzshvpTiDTqXUCF5YYa9l5pNtmy46F2Qkp1FRTM8+Ab
        y3G9SU69X5eMAl1SmmhkB1gdvsP5BxoRUr8dkBmDw8IpIC8=
X-Google-Smtp-Source: AFSGD/XSjqy7THOgFgD0iFxVQUvJ4rdDE2b8GeXESeC5eXGd0YTG30jiQVOMVfLEsXDIQvFe8+zb8oak33sp13th0Jc=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr14560107lfj.126.1545318214972;
 Thu, 20 Dec 2018 07:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20181220085903.562090333@linuxfoundation.org>
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Dec 2018 20:33:23 +0530
Message-ID: <CA+G9fYv0brPeSuyQC06DTe=P4pxKijiaG-EAnP_2aMbcj7tqaQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/67] 4.19.12-stable review
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

On Thu, 20 Dec 2018 at 14:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.12 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec 22 08:58:49 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.12-rc1.gz
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

kernel: 4.19.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 5ef9b1a9d5aa83951b89a56de85e3a1fa01b2910
git describe: v4.19.11-68-g5ef9b1a9d5aa
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.11-68-g5ef9b1a9d5aa

No regressions (compared to build v4.19.11)

No fixes (compared to build v4.19.11)


Ran 20458 total tests in the following environments and test suites.

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
* ltp-hugetlb-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
