Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A3BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD960217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuK6+r1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeLRVK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:10:29 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37327 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLRVK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:10:29 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so6299740iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SMHczuTR9qs6zwDQ3QnZIQjg201ayR8vFN4DCqxYWGA=;
        b=UuK6+r1om113eFwKrXxIamwUhqDn1UcdodsSLx7IxAWU3CkkgwMBRtmQQZuC+MF6Ib
         OnDyvL2CSb5FAx1LnNItV78hJDzZ5nQSJtBUJ71HFW0xpjSoRs/aDxvYgoTaeGgWILMC
         ABzkUyW7HF85WtI+zTlFMQPgsTk5+sdyYwhhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SMHczuTR9qs6zwDQ3QnZIQjg201ayR8vFN4DCqxYWGA=;
        b=PnnpMY7g1FTsl144H06+F5WTBTiLOGVBlMUzHrYstoSAgNXHR4TPh8uO/eAeZqNJjw
         qT1bnKfh4Tp8J1PwlU/dUcoH7hvwNN/1e3b59GL8qlzihixMR55p/NQCtTFOHskDC1/m
         f4FmWT7VirPsRhM0nWHZsg1TvifYJ4MXiqltnu6mCPmsEFBSYOvZrpE1/Nog4aRMt93B
         mwj3C05jVD4a8vT8R/wyC4L/osnMtVIgxN0JRbxhcNHzWYuc9miuhMDhjozZZp10/tR7
         q1toFf28wjLWktrPzskr64KibMrtyrspUOBjMTVKasmCkyvILjSiyH8g/sa/uHyALOAO
         t3Qw==
X-Gm-Message-State: AA+aEWYpw6+RBCfnbfRXijHp3HKf2wp/JNAYWb0HTANW+UkC3u20zNf0
        kn5csfXHWiONS0N9WVT7CJTUJQ==
X-Google-Smtp-Source: AFSGD/XfO7XE1OiaCm3sO9PqXQYEjqLIL7boC5egfCeLyWPeJlavAGafZur/oVrO1GSdlJVqdJbapg==
X-Received: by 2002:a24:3dca:: with SMTP id n193mr4665617itn.48.1545167426946;
        Tue, 18 Dec 2018 13:10:26 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id c3sm7373420ioi.2.2018.12.18.13.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 13:10:26 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:10:25 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/44] 4.19.11-stable review
Message-ID: <20181218211025.cqn2djvu5n23o3mi@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20181218163927.119623235@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:39:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.11 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec 20 16:39:02 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 75803dcafdb3171314d8767b002143fc031611e9
git describe: v4.19.10-45-g75803dcafdb3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.10-45-g75803dcafdb3


No regressions (compared to build v4.19.10)

No fixes (compared to build v4.19.10)

Ran 20521 total tests in the following environments and test suites.

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
