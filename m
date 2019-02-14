Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9710DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6034721928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzATy0q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407500AbfBNQwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:52:45 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53911 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfBNQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:52:45 -0500
Received: by mail-it1-f196.google.com with SMTP id x131so15404017itc.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aHjMNS1bvaFnRhHtOm7LlQ6B7sDUBv+54qbrB8UCt7E=;
        b=MzATy0q8HjxExlF/MVx7NelibL0JLTwDuRcuMnwxsTmt5qyZkcmY9tjPbJnMWXIwI4
         NMHU6+mkPAI66TLkC3Zfa5UdteLfTWIvjdtK4RnUr9WIL6KuTgTnAbYNSZn2b7MRRods
         wbECwBuGC0ZVvdEqnb/z7sRk6471XZe9HaZ/544JCJ0I6zP3wyu6abaRRlSCba4zjvIU
         LOcVyd2z/mb5h+S3zcKOzEzzKHgntY07k/9BriIgaB5lRtx/eFaCXpSntb+Gerrbyw6h
         uxIMs11YNTYvjdZQzCJFovT3z9mGa5p08WSVbDwZHhCzoezY1BiYMIVFEbn3YCo87jNx
         XDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aHjMNS1bvaFnRhHtOm7LlQ6B7sDUBv+54qbrB8UCt7E=;
        b=SoQc+OgeNEoPl4m5OQ/UY8KXCc5kwq6ksKVgVs66DjKjcQ1KPkW6BL0G6m1vAS6QG3
         W8ErO9a9+X2MvdMrA4U25UAxg/Ar8j6QFA5+lA6Uf/+Lt2dZIzXH02Ejqbcw2u7k4Zbh
         o8EQriMw1Ru4pD8gLwHOlkrw8Aj3P8GIQibnxPLSwisggT1R+Tvu9kGXcrQxKN9YkkZU
         EXzqdtgtwLLgdE7y81NFaupOza4/NRidqgicIwONM+8hxhhCu4vH4gY6mu/kzJ6sBvA6
         xpAne2NlnDqfiTi0NhDPlztLbmsb4u01GbQEh1+GRGZjRnh2qB0vtcRx2aVdmC/xYjgS
         UerA==
X-Gm-Message-State: AHQUAub/thWyVpnvOHs4UfXK6GvLZmurheEOYHSFWW6SVuVX2lLVz0l0
        MhARCZekkAE33dvVYT3iag8/kw==
X-Google-Smtp-Source: AHgI3IaTCiUrkgeP+ddWfIvXsigZSOpZxq+pEI1ZhHbGbK2WTqS9zsaL6+eDr2Rv3mkLspzrhwsv9w==
X-Received: by 2002:a24:7284:: with SMTP id x126mr2662797itc.15.1550163163899;
        Thu, 14 Feb 2019 08:52:43 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id w189sm1616134itw.3.2019.02.14.08.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 08:52:43 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:52:42 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.20 00/50] 4.20.9-stable review
Message-ID: <20190214165242.34kewf65sdvfws6m@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20190213183655.747168774@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:38:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.9 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.20.9-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.20.y
git commit: f4a86d6d2a0bdead7cf98d552481367e6356ef28
git describe: v4.20.8-51-gf4a86d6d2a0b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/build/v4.20.8-51-gf4a86d6d2a0b

No regressions (compared to build v4.20.8)

No fixes (compared to build v4.20.8)

Ran 21515 total tests in the following environments and test suites.

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
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
