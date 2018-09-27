Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4938C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8628C216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IbuDU8LM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8628C216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeI1CUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:20:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41234 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1CUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:20:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15-v6so4164048qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ha2KKFcQ1Rhg9UKS6qS3GC3bMCFbWU6z7FjuCHpxCbM=;
        b=IbuDU8LMItlf5GOmr9cjkl70rtQO5aPEEOj3US/zYxh2nEEr2b3lrgluV1+pr3G4qh
         +rvTHI6A+tbMnYQUzZ8485VeXumxT4MvMYXMt7p2bIgC0Pz7qYc1J/IZfDO5hhypJpCb
         SZ8JjW8yTOO9DpcsIILXC83D2no0Cfx6G5pfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ha2KKFcQ1Rhg9UKS6qS3GC3bMCFbWU6z7FjuCHpxCbM=;
        b=C4WALDCmltd1XKNM5+c/YEiI05XGCZqPfynuwfwk/hdJTXFJrAHeP+WFsbW8FtrhYT
         IQKVbQbO5vRZMeHf3Nu0qjh6rWzVRfdFaUoyiTPQl64vE6t0nj+VxbKuYtxL/e5Bl89j
         eQ6pDtzW2KTOLRTT7atml74O0N7Xx7wfAa/fv0gFN+ELLaElt8nVNdZS6VpDwly2jcdJ
         wTntVdeCftrnUBp05U7rOGFXRRlpSxiVUetll8C17NUeL8XlQsw16yUdGTrble7Qo8tT
         aKBRxaW9wPqAh64u3C1sV/R5ot7fa0X5gppjYdToa31jalaznGagqxBRglSFPrh1iSKo
         DoCA==
X-Gm-Message-State: ABuFfojlEVisY1FuDO/LXpJu4hqKchxnaSQlvOxb5tz/0sKmt8Vyjk7F
        7fAYQsXrV/GsmwpfHIw/Pu+OAg==
X-Google-Smtp-Source: ACcGV63iwL8f+L2cSCCMJzK4YriP1ir34d3WlAmN3FC3jzwwaDkyY1kH6y30CFUO+3YsH9Vu4yCB+w==
X-Received: by 2002:a0c:8563:: with SMTP id n90-v6mr9380819qva.93.1538078436451;
        Thu, 27 Sep 2018 13:00:36 -0700 (PDT)
Received: from [192.168.48.13] ([168.194.163.66])
        by smtp.gmail.com with ESMTPSA id 62-v6sm1865961qkw.72.2018.09.27.13.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:00:35 -0700 (PDT)
Reply-To: rafael.tinoco@linaro.org
Subject: Re: [PATCH 4.18 00/88] 4.18.11-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180927090300.631426620@linuxfoundation.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <7285668d-1b00-7546-d928-f95cdbeceeb5@linaro.org>
Date:   Thu, 27 Sep 2018 17:00:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 6:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:02:26 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.18.11-rc1
git repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.18.y
git commit: 85de3234c3f2488b2191a10628720ff56fd65a11
git describe: v4.18.10-89-g85de3234c3f2
Test details: 
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.18-oe/build/v4.18.10-89-g85de3234c3f2


No regressions (compared to build v4.18.9-231-g183348489d36)


Ran 21068 total tests in the following environments and test suites.

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
