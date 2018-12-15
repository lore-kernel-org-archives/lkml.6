Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF3EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F63C2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJkMEkDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeLOQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:44:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44638 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbeLOQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:44:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so7031783oig.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Za1Z6j7BOPL/wHXrKWRUJ6IlG92YsckpGixHIh/9NqY=;
        b=DJkMEkDfYXiyE3l1fW96FRSYH9YMyGHfU8UMzR9tt78q5luDZMwdjh/vgpMTArShtp
         JTi8Of2TcGkFhS9gAh50A8qJ7ZYZfkrC2lkVb+85DoWUF+/wdRnqpNUgGvtKEzVruMeZ
         rCdlxOCl5fsdtas+nkxci5GM4uCs7el9XWXcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Za1Z6j7BOPL/wHXrKWRUJ6IlG92YsckpGixHIh/9NqY=;
        b=LoJNqPGIZoLY2BH3TSu5CG9PUs1PaEyvBWC5229yXAT3X8a3vK1+lrGXP7iGaR9AQc
         b96wcX7JjiwgaH6Tb3UuajOcHdG41OfocDa3f+fiDcpIf+/25q7sWGp+ydYXPKWigvft
         YtsRnBgLlcfL0u1Gq4t6dCMdTw1HtypLMxlKHgQvOCL0yaprRi3GB/LDKp83s3ZkcBi7
         r631XZlOvPZfOrH7Pqh8Tra/VkBO2jQMMZk+QmUZYC4LYnoaECICC8pXfvnACcy55p08
         NWk2/EJPx4NiXx3aRfZvWAXJ0/ey0lz6uidCbxKwMirZgFOmNOJ2czz/cdATi1UTL6x6
         r1kQ==
X-Gm-Message-State: AA+aEWas9lnliRzn7CIzc2L4Lp3aoM8p4Pz62IxENUjV3MOnDQdoPXtM
        u4mMkHWVCft/OcDTw9v1UoHvpA==
X-Google-Smtp-Source: AFSGD/WMjBI+U6Hl1quzysl41U5Fyefelv5z8nUUJOM4zqrNmUoCQ+WVutWeqL/dExMqgcOwuonoXg==
X-Received: by 2002:aca:c501:: with SMTP id v1mr1604049oif.48.1544892249444;
        Sat, 15 Dec 2018 08:44:09 -0800 (PST)
Received: from localhost ([2603:3016:300:100::968a])
        by smtp.gmail.com with ESMTPSA id v141sm4184603oia.25.2018.12.15.08.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 08:44:08 -0800 (PST)
Date:   Sat, 15 Dec 2018 10:44:07 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
Message-ID: <20181215164407.qxit5j5ocmpxiu4a@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181214115702.151309521@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:59:34PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.168 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.168-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 9c558d7fe359a962e214e426ffeb338e012bba39
git describe: v4.4.167-89-g9c558d7fe359
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.167-89-g9c558d7fe359


No regressions (compared to build v4.4.167-40-g840a97100a76)


No fixes (compared to build v4.4.167-40-g840a97100a76)

Ran 17023 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_i386
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.168-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.168-rc1-hikey-20181214-340
git commit: adb4d07253946d647c9afde07d2002b28b3c0ec0
git describe: 4.4.168-rc1-hikey-20181214-340
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.168-rc1-hikey-20181214-340


No regressions (compared to build 4.4.167-rc1-hikey-20181211-336)


No fixes (compared to build 4.4.167-rc1-hikey-20181211-336)

Ran 2756 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

-- 
Linaro LKFT
https://lkft.linaro.org
