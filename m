Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C77DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CD02170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEmzud5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CD02170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeI1CHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:07:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41022 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeI1CHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:07:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15-v6so4115744qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p37KdRw8pj5TTyzsWHZDn4k+UvUngSUFNiZ6wGxYyDQ=;
        b=LEmzud5dy6j9LFURa1778gRqByCyNQKK2jEtzNDaD5n4k6qa6WqmPeu7t3rmvpPUka
         WYWaN2eU5H3SppCqz6udF2DgwugffR+VmhVChwzrPn3uUtyLrtwc3L57S9qqXKJMcdxE
         al1YiVhZFBcBbyAoujlNjV7iCSoFLtJwVflaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p37KdRw8pj5TTyzsWHZDn4k+UvUngSUFNiZ6wGxYyDQ=;
        b=c6ygQMqjsXChNAVDSXHeB3aq0FBwNw1zVKvImtQZbnnGs/CY26lWQ+YcdV7K/M6zny
         Hwlki18W3o74TRTJ/lrBm2PRzJu/SeWR1xnl6bIMVPLPRfs3Iz73TEAjAROK4W12gQP1
         4o/ULRflY7ROsKf84VwTq+A3B7Y0JiuBbd2UNKwlxMUOzGPkE7bo8BWHie9Mudsq8BCh
         tcQ/eAF2PNpK6Igef1FODyuO3TTd5QoIxVh/DLCnHcM+sKzLC7orbEENQ5xor16g+7oW
         Ml5qww8cLCEDh4Vh5qmhEpicNbYuL0OCkuzchblUkO2gylIhUJBP2HuUselpUKbCvrX2
         N4CA==
X-Gm-Message-State: ABuFfohfP76whV9Tnl2dE7fSPT+D/R2PH8DPmKfDPWkAApBh3VuUfZrv
        nTiokVurJHkCm8ZTj3lpODyTqA==
X-Google-Smtp-Source: ACcGV625CHIUW2weJs8BTFpeBNfquBOZQUZIe+tHiHC0LZ+FbfQUPftLgrjMnFJiw6pEi32N3IdZ/w==
X-Received: by 2002:ac8:34ce:: with SMTP id x14-v6mr9890856qtb.115.1538077632377;
        Thu, 27 Sep 2018 12:47:12 -0700 (PDT)
Received: from [192.168.48.13] ([168.194.163.66])
        by smtp.gmail.com with ESMTPSA id b26-v6sm1428963qte.42.2018.09.27.12.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:47:11 -0700 (PDT)
Reply-To: rafael.tinoco@linaro.org
Subject: Re: [PATCH 4.4 00/28] 4.4.159-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180927090637.687829444@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <6dcc4c0b-9799-509e-339f-95c928ac7b17@linaro.org>
Date:   Thu, 27 Sep 2018 16:47:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 6:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.159 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:06:27 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.159-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.159-rc1
git repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 00c1733d7f0d0d2d6e7f3a2198d63a99ca8be540
git describe: v4.4.158-29-g00c1733d7f0d
Test details: 
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.158-29-g00c1733d7f0d


No regressions (compared to build v4.4.157-69-g9fbcdd1319b4)


Ran 16876 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.159-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.159-rc1-hikey-20180927-294
git commit: 7bb00ecae52c8ec133eaf805b246cbe44a5fb46d
git describe: 4.4.159-rc1-hikey-20180927-294
Test details: 
https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.159-rc1-hikey-20180927-294


No regressions (compared to build 4.4.159-rc1-hikey-20180926-293)


Ran 2725 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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

-- 
Linaro LKFT
https://lkft.linaro.org
