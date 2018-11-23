Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E284220820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A37n5UG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E284220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408315AbeKWSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:00:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37419 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390344AbeKWSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:00:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so9811909lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 23:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b1aRLZlEwJSXS3Ka1Uw5klku6tzokb6rI6jOothkjTE=;
        b=A37n5UG9eWb1f3z6pUm0U2/J13UQ7zxJMsQbMYWi+JIMcsYei1FkFmZS2UQjP16SCE
         u1snfIx3zxLsNdnmSVGd8h2P2ZT8ug3NdYNPTpOWigSRueWGNH9Iwjys7jTVTGXHsw9e
         1YHwFaWh5n53xHU4hpKRmklIYRzB9ml94WrVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b1aRLZlEwJSXS3Ka1Uw5klku6tzokb6rI6jOothkjTE=;
        b=OamlOX6n7sNTVvlaC5vvMdmYCJTINs8afz7b72HvTOvy2dhD7VkvobPEE6fBh22YDT
         B5MEOssTXV9f6F9ylO2XWT3dE5cAjvm3TlQIWRxOu0OZ2QbSqn/ML4lROfqlMCCGpIRz
         UM5znELZq8zhuQsYQdwemYxXj2vithbJend69fklievAD4KQ7b0rh82zL+89HBC+5Q7Z
         sfCAajPh+puqIVsd5T5YYLvby5qwJn0mre4ltT0IteubhIQwWKt4IIMNyw9EjckMzVWw
         902o2rNEPhYrgWzSOib+jXq/WSJ90kcGvJXqBZRTRXceep4BQ/pkucGKLsF/5616DeI0
         QJuw==
X-Gm-Message-State: AA+aEWYuF2LyKccgygtl3zJtk8WtTDCu2JaPxzWnhRfFojnIXAFmpWTm
        MYa/h9JZkoSIBWGpduEc2iWsy4U77lYMkugyCE1V3QTnYtE=
X-Google-Smtp-Source: AFSGD/WHtbHq+5yAd8eDqK1MgCnh5m3h4uu6n3odjdo+6huoCqW9PGUxLnopzIieZLGe5R8UItNeJU6/T0pERB6t8y4=
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr9715360lji.130.1542957423217;
 Thu, 22 Nov 2018 23:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20181121183508.262873520@linuxfoundation.org>
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Nov 2018 12:46:51 +0530
Message-ID: <CA+G9fYvnQc57St_DaLMU7aaL98iBVinOWzzku5aCeA2kxaBaqg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/59] 4.9.139-stable review
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

On Thu, 22 Nov 2018 at 00:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.139 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Nov 23 18:34:55 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.139-rc1.gz
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

kernel: 4.9.139-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 70b13958eeae24843ed944e4f3d4a25a0cdec0dc
git describe: v4.9.138-60-g70b13958eeae
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.138-60-g70b13958eeae

No regressions (compared to build v4.9.138)

No fixes (compared to build v4.9.138)

Ran 21044 total tests in the following environments and test suites.

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
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-sched-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
