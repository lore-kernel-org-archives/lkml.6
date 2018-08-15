Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258B3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E312C21530
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lejhggjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E312C21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHOXq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:46:28 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46433 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeHOXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:46:28 -0400
Received: by mail-io0-f194.google.com with SMTP id x5-v6so2088785iop.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XaRbJjlz4Er4JWLnVRq+qOj2TNhFl34rbneeSG0docs=;
        b=LejhggjmQqYNYybH+1Nyb/SV9aDNXMaQpWCdDzpMWFLpPNMK+vgbqOpXpLg7X6E61j
         ayJeqtbflBkBL8o/s/9/3EdG9vJks5jjK6CnqPA0fM9yVNJp3RXQfFxbHt+y+7rHnruh
         iSVpxLFQOAyFHJ1As49Yn2O4ZlUH77NxWKEnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XaRbJjlz4Er4JWLnVRq+qOj2TNhFl34rbneeSG0docs=;
        b=VMQOEIGiglFD1G0FuXAgj1f9ZNBw2dIARer0HR/qZS5LXtPU5HblbhO+y15vK5HH4g
         SWLLdsbfRMnWaDZLMveLQqZp+4PXnpiaSyuOUSLRrv/huq0jVeXKNwXs1y57JNa6zRkh
         h1A17k7ckcJoGCfBZt7RvEqljfxocEeNMv5Xgz9QW5Axk5Ok0eLg4Mr27u0if/Uj4Zph
         MOZ3tb4qF7/15Xjv/UEthYXYIr+yfdUA99of0sLrb0KnT02Prqfd1iYnZd7rBq+lqUf8
         LYDAjchxV2untnQhpgEcM3MK6dLdlpqqBcA00o4rCrkCGGco620siELDjXto8p584VgK
         t7cg==
X-Gm-Message-State: AOUpUlHJBphLNX0Wn9v++Vb1qg1TZECk7XXhxFldEhK5JsnRKNYJqnvL
        i00acezyd+EeI3S36ztCs9Dn0A==
X-Google-Smtp-Source: AA+uWPwZDxLGeATR+7DUugiWJ55NlLsXlaVE35NNhqw9/hDOv8flLVhalyrBGvD1qRgz4Iezh06ypw==
X-Received: by 2002:a5e:890c:: with SMTP id k12-v6mr22565619ioj.182.1534366360033;
        Wed, 15 Aug 2018 13:52:40 -0700 (PDT)
Received: from localhost (c-68-47-89-210.hsd1.mn.comcast.net. [68.47.89.210])
        by smtp.gmail.com with ESMTPSA id x15-v6sm1832726itb.9.2018.08.15.13.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:52:39 -0700 (PDT)
Date:   Wed, 15 Aug 2018 15:52:38 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.148-stable review
Message-ID: <20180815205238.52g7lq5cywu2tboo@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180814171517.014285600@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:17:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.148 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 16 17:14:59 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.148-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 41fa2bf55dc979a622e7cb367c6f815d6a508a1a
git describe: v4.4.147-46-g41fa2bf55dc9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.147-46-g41fa2bf55dc9


No regressions (compared to build v4.4.147)


Ran 9270 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
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

Summary
------------------------------------------------------------------------

kernel: 4.4.148-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.148-rc2-hikey-20180815-258
git commit: f76c67628ea73cd7814850723fd3cf4ec681c404
git describe: 4.4.148-rc2-hikey-20180815-258
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.148-rc2-hikey-20180815-258


No regressions (compared to build 4.4.148-rc1-hikey-20180814-257)


Ran 2723 total tests in the following environments and test suites.

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
