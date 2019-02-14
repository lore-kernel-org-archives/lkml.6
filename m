Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F3AC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D967E21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv/UsaP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393278AbfBNQqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:46:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51183 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfBNQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:46:37 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so16656841iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RHB90P8GxBEM16EBiKpb74pYfRcsdjIxhR/TLrHjTi4=;
        b=Xv/UsaP621dXOhNKwZ/WGfJOZVFMZow8EGPLYhTOpspU6McKgISjVQGLwwzvj15gaq
         yReuX938G4MnlwvSelzYWFI8KvaB2iFhorC0s/stgahaTbA1UWvBOoNHgUZUcl/wP9q8
         NnIgIlJBvavxWsyLKfbJm8qtRay+2849Y3+2Et+GqnvcDPD+xzb6aUL2yK/sJO6VnTHG
         O0PZkZEwXn9Ec2bULdysA9kKbt42t0bBuXKewMayoFOhOrZ3jSuXh7OWQr140kfmDl+V
         T8Bu+s+1alZurqfzrCMQ1/0up2byeZ9Ckm6Je7YTIC7SMJCADMJIVT9rY3aaB57WIZOR
         +fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RHB90P8GxBEM16EBiKpb74pYfRcsdjIxhR/TLrHjTi4=;
        b=bYZFDrFL03MtdazexvE4WbYQ9jbwaARg4JPVjRPQBalAw6Rf81+1EojpPbtmOMkOIO
         8GNOLqfwqNtQ4f6iSGuVNZ61fA9SX/CqVWZhKY3rrTAlX5Fo/KZ9RkNhFIHrHuUWfMuQ
         S+U86kc0aLhMfW4cd91u+zt8xVWlnXjpPPUS7j2mocfeTK+90ZkXw/JDHVPkSv+NO8Np
         d++moYjCjtzshR/XCv42gHGKXRROQZjqknHsm5myx6f1+rJSdLGd0w/6RWnEl3/9CpQk
         Rm/TSubQ1WzWdf6P83CJu3WCB0CULC0MkkXNlH+tfSffqcGRhZrrLihUJ7DawoISsUg7
         LHFg==
X-Gm-Message-State: AHQUAuaDuRsa+fjcE7v8EWgxYW7NJ2dIUNk6a4zMSht99eGvsbnNBlyK
        9AM9/jmdpAcYh/Qfqgq4owtDOw==
X-Google-Smtp-Source: AHgI3IaXiQ2mSHTK+MH63KooF0FIRc3q657VpsklSitQXrvT3PCZBV9goo98TZOSGkg4ZnYyA1xNgw==
X-Received: by 2002:a5e:a611:: with SMTP id q17mr2586921ioi.17.1550162796315;
        Thu, 14 Feb 2019 08:46:36 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id h13sm1103197ioq.72.2019.02.14.08.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 08:46:35 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:46:34 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.19 00/44] 4.19.22-stable review
Message-ID: <20190214164634.aduckxct6qkgrop4@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20190213183651.648060257@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:38:01PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.22 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:28 UTC 2019.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.22-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: 6d76e59d5015e936ba1fc9a9d9369ed133475530
git describe: v4.19.21-45-g6d76e59d5015
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.21-45-g6d76e59d5015

No regressions (compared to build v4.19.21)

No fixes (compared to build v4.19.21)

Ran 21399 total tests in the following environments and test suites.

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

-- 
Linaro LKFT
https://lkft.linaro.org
