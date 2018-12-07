Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED397C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D7D20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hd5/quhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D7D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGI25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:28:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43131 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLGI25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:28:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id 83-v6so2791648ljf.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 00:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7WR+2gG+XFWUPIoM8fbvk2xN0o2zFeFyew6uhSn9pqY=;
        b=Hd5/quhPSECZ6BM2OPlLVKRcanrDLhgDc0tEG2eVHasKru/HnuuRV8BAiaMJYs+DZ9
         pVGc3WxfgTCJ/YCJtuaTbgW+y4LzmN/mfmWN/ptnSmuzc0GoIPZ+DbY5xCr4fmx000Pj
         rMwH4FFlImvK2tcWn5tFKrnIzqMPyYqVMc39A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7WR+2gG+XFWUPIoM8fbvk2xN0o2zFeFyew6uhSn9pqY=;
        b=k/5NJGnUuGupbdb5+ZJTZxddAWa0pVRFXbe9bPpn6Q8pVUDcFgalmRKniB/LfdnDhb
         rC8pRN7CEGh1HbSFl7z4kYaI2uXnDJtakKRsP+4NlYgduTYBAcPVPTFLw8t6MIx3evSg
         cQWVKORnySzTVEuSA9iIcDtAREKP8YvXpwVYz2fb9k9f9O4Bp5PowLZbCUmj5ecgVCz0
         DMY9rKDkFScHK21MPJBakQWpLoPE6JK47PbvhgFd3iDUl5QUkJRzR9v7ySSTirble99b
         y/95MDmzUUfx2dcxYwqsR2OjNyEzeUzH/WbG8Tju48hYf5/700WHjUYE/MrVQdNhkXvZ
         dOxA==
X-Gm-Message-State: AA+aEWYvwc+yIwJMtmwqzahvW3JjOeB1y7wgDByFlfIakKnepPG0DCNq
        HBCFUtVYhOYp6qZuwKozWF3akgMejYcUr902rN+9UQ==
X-Google-Smtp-Source: AFSGD/UncD38twP8Hc+6QHgtV+ksKT23euv00RLjP03zI9dupsbDs0fr2afp33LVSSFgqpvr9hG98RmG5Rzyyxv2npw=
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr770945lje.110.1544171335139;
 Fri, 07 Dec 2018 00:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20181206142949.757402551@linuxfoundation.org>
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 7 Dec 2018 13:58:42 +0530
Message-ID: <CA+G9fYvUayPN7CrfXZkf2-ooL8ztAP2x2iMffFRCCUDizY=7EA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/41] 4.19.8-stable review
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

On Thu, 6 Dec 2018 at 20:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.8 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec  8 14:29:30 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.8-rc1.gz
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

kernel: 4.19.8-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 62b84b3cf313e064c6ad249e95a5fb8feb22c77e
git describe: v4.19.7-42-g62b84b3cf313
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.7-42-g62b84b3cf313


No regressions (compared to build v4.19.7)

No fixes (compared to build v4.19.7)

Ran 20209 total tests in the following environments and test suites.

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
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
