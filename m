Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD5621708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MmuM4lfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD5621708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeI1CRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:17:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43167 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1CRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:17:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id l16-v6so4134897qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtZQJOqM+W2T3J+LVSeGvQfcyDJ8NDDL0nTmK2gVpwg=;
        b=MmuM4lfa2fxDxmX5U4kG0UiiKjH6BE+5txAUccrCEKBU5mALXRK93ncTBA94tGpk3z
         Ymc+7u17oGd8Xr4faNfQKhBSeEqxKBubW6nSxExEJuv8o/HTGXgr89/ZrkFZAJIG9T3g
         3yD9ektIbgUM7kIA6pFTuoLrV1sFRGNSbJB4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xtZQJOqM+W2T3J+LVSeGvQfcyDJ8NDDL0nTmK2gVpwg=;
        b=AJMbDT7T6U0P3Y7iBWkJan8x/lkwvi0qCEJjVJvulUj6aRJHkgMZH/SkVXwgYBBJiz
         bqK2PMUuU/oQf6kpay7I6Ygrx6V6URER2blM3Idq2g1rp0Ep0bCafmcTnnmhVPwAMLEE
         yDk1SaK5Stk4fCRZPbFvGKpDnU1Z096qlyKcUpJ6yMlKZwF23KwEyDx30sHWHUNL07zm
         7V5rgwEa4718a3bHtMvU/CvUGv8SI39UmkRO3Nr+4ie0vtRurTq3ruRJyKBSzl8Gy7eP
         UIE+HybZr6caNL62ps4CfpGFsEHHtl49DUNHM48a/Zy7bNjeVSc0sICdi/DRn4RvMOOY
         etzQ==
X-Gm-Message-State: ABuFfohbHXHZKVNH3RqzU3LBwCfp9yFfwy4tf4BEq30VQsQA1QXsDFw9
        T2ULHrrWcZk9RIxVREAxmf76SA==
X-Google-Smtp-Source: ACcGV61r1iy1+Dx3YRbr9PDxtmBYRMH12aYWU0FeZdJLyqgW3HDz3ex9TmGRIGTXVqjenUtUqXaKrg==
X-Received: by 2002:a0c:e80e:: with SMTP id y14-v6mr9432549qvn.23.1538078263706;
        Thu, 27 Sep 2018 12:57:43 -0700 (PDT)
Received: from [192.168.48.13] ([168.194.163.66])
        by smtp.gmail.com with ESMTPSA id f184-v6sm1688521qkc.23.2018.09.27.12.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:57:42 -0700 (PDT)
Reply-To: rafael.tinoco@linaro.org
Subject: Re: [PATCH 4.14 00/64] 4.14.73-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180927090249.801943776@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <49f1cd08-917e-ed9a-4c32-c662ca8832cb@linaro.org>
Date:   Thu, 27 Sep 2018 16:57:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 6:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.73 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:02:21 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.73-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Note:

dragonboard-410c boot issues are now solved, after "rpmsg: core: add 
support to power domains for devices" commit was reverted. Thank you!

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.73-rc1
git repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
git commit: 1e2fd389792f6e2f7b7d9bc252c9010a2c1f97eb
git describe: v4.14.72-64-g1e2fd389792f
Test details: 
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/build/v4.14.72-64-g1e2fd389792f


No regressions (compared to build v4.14.71-170-g2cc4d365363b)


Ran 20209 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-cve-tests
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
* ltp-cap_bounds-tests
* ltp-fcntl-locktests-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
