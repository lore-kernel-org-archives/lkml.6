Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D96320866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bB418Edf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbeL1Ry0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:54:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34532 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbeL1Ry0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:54:26 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so30295778itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+L5mghNay0zgQMmifgSt2xM+U8WUyGWrEugaEBgM8+s=;
        b=bB418EdfR0L+Lkvmau6Yi9KRm41LZJaPZDCniDEG/xMdsXqTamVdzBKbm7GFgu3U+j
         HGksRUfNHLI57jorBrqbMLImD3OupOLU9P7/Lvk+Q7fWXwXTo412gqakcFoA3zZ16TBj
         2MX/gK2EyWmFCj+rTO0j6Al6m9c69JgbLvucM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+L5mghNay0zgQMmifgSt2xM+U8WUyGWrEugaEBgM8+s=;
        b=Ds+A7jCAQZzVIeu8xg+G8gE4Kb87ZHAOeQ7la6kcx0vaDchszrxQWmdkKw1NOZVZV2
         haanb53RozdUUxBqb5Fv9FDm9hLQASUrn7suTLb2RXuL4xsmEre69EWR7mUgUFGjGLam
         kGZPNT2O3iBmCIoM7FpimPkcfSzB8cJ/XHyRLxM1wXJzS3fg720eZvOXkzdPOzSJjzYV
         qpNDQ2w0GcQQjcjqhkOzEk7FMwiy+pJa/+UcQrUuyZhPoixhEbEEWPPMw78yC34zhURg
         WuxLId2bFAzVUV9v4WLZ/JIDjaIdYUVyhPlEGpI4oekBAU+zz20Hpd//kV+QM+frbAjQ
         Kd5g==
X-Gm-Message-State: AA+aEWYQSW1Il3rcji47SsSRNjSVEoaqm5d5qBFVQGQMb48IWbmCe0dK
        r722N5Qxkx2FAYNDd11Tcb5l0A==
X-Google-Smtp-Source: AFSGD/UapRxxONOBdMSPeQFdiBYbMEfPMq0KegAiVKRkeP64Lj/GFC5HrOgbINc9dw9XV2YXAuaHhg==
X-Received: by 2002:a02:104a:: with SMTP id 71mr17333870jay.103.1546019664518;
        Fri, 28 Dec 2018 09:54:24 -0800 (PST)
Received: from localhost (c-73-24-4-37.hsd1.mn.comcast.net. [73.24.4.37])
        by smtp.gmail.com with ESMTPSA id q76sm20058340iod.35.2018.12.28.09.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 09:54:23 -0800 (PST)
Date:   Fri, 28 Dec 2018 11:54:22 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.13-stable review
Message-ID: <20181228175422.iagcsu3y7tzpuxq6@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181228113124.971620049@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:51:54PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.13 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.13-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 08ae917b140b0fdd38906cfd569014b030a0f60e
git describe: v4.19.12-47-g08ae917b140b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.12-47-g08ae917b140b

No regressions (compared to build v4.19.11-68-g2a7cb228d29c)

No fixes (compared to build v4.19.11-68-g2a7cb228d29c)

Ran 20389 total tests in the following environments and test suites.

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

-- 
Linaro LKFT
https://lkft.linaro.org
