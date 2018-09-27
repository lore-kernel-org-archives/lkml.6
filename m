Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4631DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045D62170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNnaxPPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045D62170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeI1CLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:11:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39590 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1CLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:11:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id b19-v6so2409356qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VwTC6nzvlwrk1sYBue0O+CwbRF3QMnzIO2sRJJ7p/+0=;
        b=SNnaxPPRbdrpjNQve/DW19zerGRnbRACV5jmviGOtRWIE0q5oQWbGntCG+qMt8/zqM
         BXG7/7O4/0aTTxhp5+Hic7Q/p/2hrMzBVMsnRUPus3wkyIm09sRwjUsK0lzn/zH4c1Q/
         klXCOqsupiUpdm9+SoxL5Es37GW+mHi7n+UR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VwTC6nzvlwrk1sYBue0O+CwbRF3QMnzIO2sRJJ7p/+0=;
        b=DqxYMaWX9M6VpOA8/oFFrCtoXYDhhYUosr9nzMIgWKycanC+fIWlLOh4X/U9y+sWji
         T9VYHGl19cMzy9CD44NqyYL+7r0Rmy1OwwkjCAFMoQnWIr/KkBVymuEY2TxUlFn4B89F
         MJxltcg46g4e8/gWqCzhyHF4UjlozWY03v1ptuGWacEjWok641jqMhrX4gRPI/N6/O6G
         wlwp4qszVyVJptQi3/DNs+NYlKeIGBywNNJa3KlqVXEyEJnSeiSJb6vEVP47qeR+kUBs
         CVG1D+PlHL7S46IPgs7lTK7Q78AX1RgHU/EAbbqrusct9lfl+celVyNeKeNYhtWQ89D+
         Mtrw==
X-Gm-Message-State: ABuFfoiZvf5F6/ZS8qkHfLr/O8m9kJSgmz2UGg16nNI4IpoGZ9ktlZIl
        gwVjOVxW91y8nqjAkOoIb67b6A==
X-Google-Smtp-Source: ACcGV61MyPjpzzA6v5yLRkHfcWrdzbqHq6NxJ6mHLEM7ENv9G8HAkJvYTT3ptyLxtqOZpsm3AQO7Uw==
X-Received: by 2002:a37:6d44:: with SMTP id i65-v6mr9278695qkc.142.1538077915667;
        Thu, 27 Sep 2018 12:51:55 -0700 (PDT)
Received: from [192.168.48.13] ([168.194.163.66])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1663904qku.46.2018.09.27.12.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:51:54 -0700 (PDT)
Reply-To: rafael.tinoco@linaro.org
Subject: Re: [PATCH 4.9 00/44] 4.9.130-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180927090117.997362691@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <31f2899e-609e-9027-6b9b-2f9fa9c1d477@linaro.org>
Date:   Thu, 27 Sep 2018 16:51:50 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 6:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.130 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:00:54 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.130-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.130-rc1
git repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: e633007977505b13dcf86601b4f41ee941035089
git describe: v4.9.129-45-ge63300797750
Test details: 
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.129-45-ge63300797750


No regressions (compared to build v4.9.128-108-g6ceccdf5ca9e)


Ran 21276 total tests in the following environments and test suites.

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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
