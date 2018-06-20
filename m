Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3430AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F6C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F6C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932341AbeFTS76 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:59:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36695 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFTS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:59:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id v131-v6so1389809wma.1;
        Wed, 20 Jun 2018 11:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h14lM4lkl1QUzmLlUiJkxtXeNtySYyRhQhbJZEmDTU4=;
        b=RWO+GTyDpcecbCCqDNFBtFHtBenux+hc2HafeVwidWACGOIothncnji+MbEIqg0o8C
         FI4h17FxWUcwpbH/kdirQrWLGsZS+5FMX76rEzM/7p/bIwjsS5QU2kxboS3QVF6xkCSP
         QxcdAN9MJ0TIN3GVLRblt1Tl1/wnjcVlcQ7HhOPshddf5I74hKycRLo2UOn5deHrPn/d
         3a6ndGdTg+uDwKa6qoUop0PeMIFe/NYPvcAaOn5MopnOOhQ93bRsuNpe2cvCTpYYbQ2O
         KBIsiq6kWIoTQGz1AkYdw+h4sCVoNDLMQ9qsTK8hWN74Tk4TPY2HMiVFJmSQ88CcSkTb
         9VRA==
X-Gm-Message-State: APt69E2NLn9B1tdQN8oxhT470rv0BDGE9cqbOfRWhaD5yM99jcmkLH8t
        FHWqqUqEz2QOmeLthrXzKxGT1r6w
X-Google-Smtp-Source: ADUXVKJieURR/WQewth61KpadIeUJToUYPsrPGgD0nvjKPy3fleRMGdHWGGmoPtTirw87PsMxLTy7Q==
X-Received: by 2002:a50:9298:: with SMTP id k24-v6mr19161305eda.110.1529521195517;
        Wed, 20 Jun 2018 11:59:55 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id x7-v6sm1528758edm.14.2018.06.20.11.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:59:54 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:59:53 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     efremov@linux.com
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] ARM: S3C24XX: fix typo in guard macro for s3c2412.h
Message-ID: <20180620185953.cty5esnbfhawnbau@kozik-lap>
References: <20180617194617.15145-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180617194617.15145-1-efremov@linux.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 10:46:17PM +0300, efremov@linux.com wrote:
> The guard macro __ARCH_ARM_REGS_S3C24XX_S3C2412_H in header s3c2412.h
> doesn't match the #ifndef macro __ARCH_ARM_MACH_S3C24XX_S3C2412_H.
> This patch defines the guard correctly.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  arch/arm/mach-s3c24xx/include/mach/s3c2412.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.

Best regards,
Krzysztof

