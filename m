Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1DD217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeC/0fhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfBRTnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:43:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34620 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBRTnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:43:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id l5so11967703lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FbvCiipaRbRjzalPnKvk4dw48TJHXFLDeWImMCo+MlA=;
        b=GeC/0fhEBUh3ZTbpfhsTGZ8wGrnoPCRTv5iSk8kjkNDFwl2LUEF7I9VYq6bZUKXqGS
         ED1LYhtFahUiSLC+iVmzOXcwE7uShd/o7jcBVvmJqf7pJDIOxd9jPpcI5aNkqNmRqR2A
         GrCBIxQjjxJoP7QeshTwqN5OS9W+IcjGwYKRyjDK1X61dTTIb6iOEv72iO6Mka0bQszo
         A15KLAZ1Ce48ouxgWgNQyKcf6JlJDPbq0SH5hB2Z46WToZVtlBItdG5hVZ+B8aKuJMLI
         JpJ6Vjo498aA9eI/Ds1WJm0tgmhgnqOiETm443MZg+bpOBQjNcMzHXyEPr3rHuD4SeaR
         zD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FbvCiipaRbRjzalPnKvk4dw48TJHXFLDeWImMCo+MlA=;
        b=HW2SsqKW6KAAv/F3KjCVWpjyCR4+BgXApDkF0sKGMohmQum7lI6p4ah21HeY8nX1Xa
         z7etTjhjqdiDBAVYGH3IyJA4pPS7dvvW6LB47PMsgUESl6L/Pumbb6mK8CNbPiT6H0yg
         AtUWq7p1CifHh4S69oMD6ooK+esphuJT5T4WJnVw63FFcXsvNau1mn7wGE6/wo7n6u2n
         3j9BumFhThQ2Vry0GieVKstG5bu/8+BLS1P8d0CxwS5bI1vZNwPi2GlFhsy3ixCEwEG2
         EwaLnw8e9HAktffmR6Uty+fnuShvrM9u5kfjfUt3UsSeVyMDzb4nHZBPOZqqr+QQulvC
         WwSA==
X-Gm-Message-State: AHQUAuYbQA8gK8VfcIaS9Do85tu5nOMZ5ZKQ7JsJu5xDekAYqXgvE6yZ
        LVSZt5lPybTK7r93OWIihzRRUaEA+BV97pxc6lVpwlSEajA=
X-Google-Smtp-Source: AHgI3Ib73eJt3/JpoL44VZnSPcKtPW3BREcz5hX0mbR8B21rspY5Yv4qnI0kWDvYv2KDRfYu85Wqp0ePGRPVstcuj3s=
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr16042285ljj.136.1550519029530;
 Mon, 18 Feb 2019 11:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20190218133508.567416115@linuxfoundation.org>
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Feb 2019 01:13:38 +0530
Message-ID: <CA+G9fYvk+g_M9+kdx-68Ruakq_tnZDSnDZ4g2e9us5jsWQ5wNQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/58] 4.9.159-stable review
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

On Mon, 18 Feb 2019 at 19:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.159 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 20 13:34:40 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.159-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.159-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: fe5f19afca3005a843e6b2c67f3592fa35fa612a
git describe: v4.9.158-59-gfe5f19afca30
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.158-59-gfe5f19afca30


No regressions (compared to build v4.9.158)


No fixes (compared to build v4.9.158)

Ran 22236 total tests in the following environments and test suites.

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
