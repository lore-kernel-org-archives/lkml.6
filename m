Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685D7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE17206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e40gvLV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeLORBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 12:01:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44153 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeLORBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 12:01:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so8419563otl.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 09:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cTLXZSJFx3rR9P6nLtwpun3QYu9+2mzndzdnwEXU+uY=;
        b=e40gvLV7tJfGeiDwQBU9Qy7xMUcky5Z8ci4XkQM4/VQ8MNgnQjw7LhVxydR3mh8t61
         f5dLbahUGLo+kGHHCP8ibrUWopGa7GpOBJXL2qIDRXoc6D8RSuXEpXvTFAA8Lxu95fYG
         RrXCU6hKqgx0xHUPMT0HiT8t+B6m7dP6ucpt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cTLXZSJFx3rR9P6nLtwpun3QYu9+2mzndzdnwEXU+uY=;
        b=tOv8/QHwEYDQ5sIPZSNLln2R2FfKL2YP8ZyauljudchMDferG+bo2n7sijsHBns1Fu
         yMBp/KvT5K66jVDYEhk+nt174GzCM7lHHj+8OLuvRGO8y/UhZNGOL00r1zgn3VmhYRnQ
         eYrXSDYKZvFYpdM+5DYRV5zBDKU4Qz+H6xlVXlN2rVRDcfF5cQeo7Dp88w8ghMSLDMI5
         Ulc4+FYFY/EjPeOK5W40kjrSUE9k6D6QZi0tEmoNPYKBtwAZez4Vstig43PFpZjaW1cO
         LAy/GJfOowD79Lnf8Nv3/vwHa8mecgoDoll815TAIdWCI/YaQ0bsHcKtpwgFW/Ef5c8s
         tX5w==
X-Gm-Message-State: AA+aEWa2LEO1B2xD31kO1N8fNUxJRIgft+wlGLycpMkEZaDGhdJcoUQ/
        fTXBM5v8PTa0BU1pBJgI877DKw==
X-Google-Smtp-Source: AFSGD/V5NX+2hSnq52wu15PBAj7L51GuNVb1FOqmPm7F58/7PktWVhXCieVi1xXatpQQIprKY/Q6BQ==
X-Received: by 2002:a9d:3f34:: with SMTP id m49mr4974486otc.23.1544893264538;
        Sat, 15 Dec 2018 09:01:04 -0800 (PST)
Received: from localhost ([2603:3016:300:100::968a])
        by smtp.gmail.com with ESMTPSA id o16sm3837293otl.22.2018.12.15.09.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 09:01:03 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:01:02 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
Message-ID: <20181215170102.es7drxdtiz7gzaib@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20181214115747.053633987@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:58:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
Regressions detected.

Summary
------------------------------------------------------------------------

kernel: 4.19.10-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 4875bf1f86d7bdc8dbf3222ab4028239446fab3f
git describe: v4.19.9-143-g4875bf1f86d7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.9-143-g4875bf1f86d7

No regressions (compared to build v4.19.9)

No fixes (compared to build v4.19.9)

Ran 18346 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-timers-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
