Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2356A20C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyH5T3Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2356A20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeHBImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:42:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41253 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeHBImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:42:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so743137lfe.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dEcK5xz8dd10S2C8P6vXCJ58DLloSX6SwufC1edkmcU=;
        b=kyH5T3Mop3lpNdQbpLw/0L7V0xB+2sy9/iwFBm1GRt123h325BpSw5iVuY04h21LZm
         PzMAIBSHKOlT2cN1ikDwXtEdvvIFRtXTa54hT1cAg+YyuFP4IPohDT+ppuierB9X/cQC
         Xc5O9/zZwRq4ijly+QSGGmgOal1Tp6SXQS7K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dEcK5xz8dd10S2C8P6vXCJ58DLloSX6SwufC1edkmcU=;
        b=rqHZHMTLySpR2Y6fQOH+rgQWYFFMdFBPcvkhgmAyZNzhqvXW1eO3pd/7k+K3TKxVuL
         rT5LI4Z/gThTMKL4nezs1ovkaql+xulJQUaErVYq6qpLDZR3W/3qHh5SaBSuxU7jExxR
         hjb6WzRUcT5ebPICK2j1CPI5znctdXV5IlZPNC7LLQMmhuHMYvNt+l5VMg9bK75oeqac
         cyZCT0x3j0wD/P8DjzQVvqA+MuQ/z9d7a98H77kD8vkvGBeXhpzxIYxy1Wvwwv/RJgLD
         ID+G/tR3bW5MdC0BohC7ihC1GW7atR+EZKyErR30oxz8iYp+zKqcsKzagBpP5WE7SibA
         T4Jg==
X-Gm-Message-State: AOUpUlHf8AQNBm/hGCcOaSAG9uxoe7K3jrK3z7X3UCTkZr1gaVodWR4b
        aAYWlOhe0eUM5y36UlK+MDjP/yJHS5iNSe9TsevbnA==
X-Google-Smtp-Source: AAOMgpdCLscqSTXvcvAzT74S10mX95YumyiUA9Wx9tGMpr/387Ntjrci9oMyntPIztVcotTLQQTF4yUKzKbXRxTmS8E=
X-Received: by 2002:a19:8f8f:: with SMTP id s15-v6mr922093lfk.96.1533192757619;
 Wed, 01 Aug 2018 23:52:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 23:52:36 -0700 (PDT)
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Aug 2018 12:22:36 +0530
Message-ID: <CA+G9fYvJnDPPhX6UeA9HjcGE2Zs0N6LWu9aqA7HPhjuBOw_bGw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
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

On 1 August 2018 at 22:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.60 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Aug  3 16:49:18 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.60-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.60-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 68285958fc2aaa2d85f795151e1c302d7991f1b5
git describe: v4.14.59-247-g68285958fc2a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.59-247-g68285958fc2a


No regressions (compared to build v4.14.59-247-g654fc6e3ea92)


Ran 16388 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
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
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-fsx-tests
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
