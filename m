Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC92C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73C52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="R9wK0CXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73C52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeLLWSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:18:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33731 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbeLLWQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so29529ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kccThfX5CLSTWdYtZnbv5QYn/EnfwbjiIG9EWgyHhOc=;
        b=R9wK0CXfIOMeMdj5eEUf05BsUNdL0feIGFCcyCrl+rCusYjr8+48FXxBbxSgiOrLhS
         cGvYd3zBUyEmHQbKaNWD9HSgQy95zsVK7hkbe9dnq90xgWo84sVtthyzOUdVoaIZpEBl
         HBiUI+9R4r7qUcbXS1rigtyhoxjV6BVy08f1o1V959RIPMIykLfx8odWwxjvzznstXRk
         x8FN2OLR31P+Qd0z6VFbns1uHfR63kF3Z02Hc4H6515kHJ8CznGHVPF1Vp375KKClUw/
         XNVKJFr7u68Jjav1PJogw4OCehUATf6n+EX6JMvhe/Os2PN01v+4k9zOpttRLPrqL41I
         idOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kccThfX5CLSTWdYtZnbv5QYn/EnfwbjiIG9EWgyHhOc=;
        b=QwHidRlglP0Wm+GG/CPVCxNR+9lGn+61WsV6V2SaXZMC6ptdbeCN95SXiBxouDNN5P
         6Vki1J7RCM+H6D7F2Mn96IzXbQ6iFZO7TJBJRCDxSqK4bym1yryVa1ncmc+/QQ3MDGqz
         xNoPXsOY/y66wOAdBUF8knIR/hncFC7XZJybrsGdUVVd9hZUisd+ungHaSsGzSfDVCu6
         yT/SG6gRInsD1G+l+fkSQU+Aoc8nkjxQY9mQQxv0kzY8cs7GXcw68GO5sQDF5QzqOzJ0
         BYrvoL1q22o8OLLoan2JHEq2CI6UyqtD7Ir/yqzFToAnhEENhAwdqIEQ1LgHFnmwqquw
         s5Uw==
X-Gm-Message-State: AA+aEWYYTenENuKKv+qmZUdDvGak9fU5dZIhzpm9zOP+CIgNuYQ+AlbZ
        aRVLBuI7yxMt8fWCywjlWJw3WA==
X-Google-Smtp-Source: AFSGD/U3xivvWD8mzw3FAzb4A2hF+KZp9Z6MXVMeAyc0KHK6ChfBYjcaVtK/+mPOt4mfmPTgHtk2Jw==
X-Received: by 2002:a2e:20c3:: with SMTP id g64-v6mr14623938lji.101.1544653008634;
        Wed, 12 Dec 2018 14:16:48 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id a62sm3431lfa.37.2018.12.12.14.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:16:47 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:52:29 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 4/4] ARM: samsung: SoC/mach for 4.21
Message-ID: <20181212215229.6x5bpkdfhbtzafgp@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-5-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 12:49:11PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.21
> 
> for you to fetch changes up to cafbc79e327f44411b8bd8bdc101b9e6c65ab42a:
> 
>   ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus (2018-11-18 15:12:50 +0100)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.21
> 
> Just cleanups of: legacy way of setting external wakeup interrupts, old
> power management debugging functions and duplicated secondary startup
> initialization.
> 
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (2):
>       ARM: exynos: Remove no longer needed s3c_pm_check_*() calls
>       ARM: samsung: Limit SAMSUNG_PM_DEBUG config option to non-Exynos platforms
> 
> Krzysztof Kozlowski (2):
>       ARM: s5pv210: Remove legacy setting of external wakeup interrupts
>       ARM: exynos: Remove legacy setting of external wakeup interrupts
> 
> Pankaj Dubey (1):
>       ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus

Merged, thanks!


-Olof
