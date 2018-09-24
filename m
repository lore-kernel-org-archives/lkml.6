Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE66C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1220833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfZQ2cWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD1220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeIYEaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:30:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54605 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIYEaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:30:14 -0400
Received: by mail-it1-f193.google.com with SMTP id f14-v6so12863847ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oycnvDiRyLGQBbueGxSF8qSD6NUFFDTjApeqPyM/dY0=;
        b=OfZQ2cWC7+3rrTOEfdVpJVKGXmWDW0577Kw/HOBpjdbUZn/lEI1ARYDU8vJItXs14s
         UYBEo2gy+Pt/rPcr89ar3cjWVt4L2QtNtvDFTOGbLsv6zTUeIFmOzW7yFZH7mqT6GZAi
         vLVetEuQuh7vHcJyL0qnay88qPPKtI2HrlAVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oycnvDiRyLGQBbueGxSF8qSD6NUFFDTjApeqPyM/dY0=;
        b=AxVh0ImBX5HBCiPPcAA4D8/q8BUL95IRc6AAbayV6Nho47YzSf+XRK9HD2lLvChKos
         htPsVfPTiwax7zJQV/4FpRHyBTtDr0VHupjt5ORIy9kM1b0CN1xZgmKN76XQPijXeCFD
         LjdtyO7vF3GKyGeu4brocJor8zoJR9v25c36h9YVVJU0WyRmgTOCzaC7zpZTmv3sHz9F
         iIv6Wt+wHAoAiweMukXjrN/haKMcHaG8t8l8XRUWQzQuw+vthg6DrLiIJS0aCjbYAaV/
         oEEA/eluTFdob1R8NxD3z1u5pbXHIAJNFlHD8I4U1t71Xc7op+s4/KUaub9vMKPVyGCG
         P7Fg==
X-Gm-Message-State: ABuFfoiHP/dfNe2UXiQgsQI9SGG/ukspEzIFuyAqyAyvVKagXCSSRud4
        01s34fG2ESlqwta1OfvazUnGrw==
X-Google-Smtp-Source: ACcGV63v6uV+gAizCixIFQnqJRIYFdGDKk6BQEpEdKAquHJLvVTWarcvLJ2AJlp9T5DjXeofdNGytA==
X-Received: by 2002:a24:9588:: with SMTP id m130-v6mr487778itd.48.1537827948744;
        Mon, 24 Sep 2018 15:25:48 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id v3-v6sm175516ita.6.2018.09.24.15.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 15:25:47 -0700 (PDT)
Date:   Mon, 24 Sep 2018 17:25:47 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/111] 4.9.129-stable review
Message-ID: <20180924222547.bs4ffjbo5trglzmz@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180924113103.337261320@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:51:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.129 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:16 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.129-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: fa7826f765a24004014c272daf1a64462966c5ed
git describe: v4.9.128-112-gfa7826f765a2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.128-112-gfa7826f765a2


No regressions (compared to build v4.9.128)


Ran 20268 total tests in the following environments and test suites.

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
