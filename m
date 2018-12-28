Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DBD20866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BX23HJz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbeL1RtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:49:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40113 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbeL1RtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:49:09 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so27781239ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EfOERoO/eFx7Z0ej4aPXW/oT1dLWky/TOzJGCf6crKA=;
        b=BX23HJz9uwwNH+fSSWonl3XDigGYg6n6O2N2cOHPeUchw+NDhwy/YswDll5QcUxcTA
         +4Sx2W3VbI0l5hqjGZFrdEdjD6663mroYhbJOS35pO3E9blCIKZQ25Ej19iFK72gfv5X
         Q+ozRvjSJlvnpUsBfn59zCoiLMFnBxA/n63xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EfOERoO/eFx7Z0ej4aPXW/oT1dLWky/TOzJGCf6crKA=;
        b=kVXRk6LAh73JkKBf4zZA37cbLsKIJ+xdIW3JnBTjLURQpth/QTWqu7lZy/HB58taNW
         nLZ20aiG5xFhzoOzktTKxnCZLJRO2ctEc566Wf7ZX92I9PnCQb5GnBIj14TX8Q8bDcje
         WE4AeBp9tOOt0oMY2a25LPGda288kZbqCvbIJMh6ur/9TnqufowcvkCbDsuovV/wU3wE
         PYxvQWpuJWOcxzPq7ZRsu2dWhFoF6gBe8tjHCgXrru2wbbmB1HD6XstkawwqRJmOHsEK
         jecuiUFxMsSK3VGBUhDk64ZePnNJGfiHSymT1x+GyQUuft2E8bETEvlPK0Y/MjBCpkmm
         Tw6g==
X-Gm-Message-State: AA+aEWbV3fS1GKvLX5qDn1F4yjiLWmfl5BQvngsMd5GsA7Tb2nb3e2/Y
        aULUIT+rj5RgxbYfLGSqR6/yGQ==
X-Google-Smtp-Source: AFSGD/VJb23B9ffq3Bk4zmbGfDGga9Xs+VxIFPsL6/PNMcgejncHRuRnxZdD/d0A5BwPqHhFBNOmQw==
X-Received: by 2002:a05:660c:11c6:: with SMTP id p6mr17903515itm.75.1546019347659;
        Fri, 28 Dec 2018 09:49:07 -0800 (PST)
Received: from localhost (c-73-24-4-37.hsd1.mn.comcast.net. [73.24.4.37])
        by smtp.gmail.com with ESMTPSA id d133sm14696148itd.1.2018.12.28.09.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 09:49:06 -0800 (PST)
Date:   Fri, 28 Dec 2018 11:49:05 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/36] 4.14.91-stable review
Message-ID: <20181228174905.cdv3g7rxol3ml6nt@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181228113126.526729877@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:52:16PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.91 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.91-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 4554bd6c9c0c321f2e9d6603b687afc95fb0253b
git describe: v4.14.90-37-g4554bd6c9c0c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.90-37-g4554bd6c9c0c

No regressions (compared to build v4.14.89-73-g592f5569e184)

No fixes (compared to build v4.14.89-73-g592f5569e184)

Ran 21636 total tests in the following environments and test suites.

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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-math-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
