Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2E720852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2E720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbeGWSPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:15:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42167 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeGWSPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:15:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so1594739edp.9;
        Mon, 23 Jul 2018 10:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Mjb6ikMM5MVM8OxLnDmfMmSlMrlhYjFshfNKsB5g+A=;
        b=dcrFWYg0iOy4U12bWVWf4Z7BaouuW6ZsqqrXmib466kq+IQEc5JNeJWAxpgcZijWA7
         G2RpAfmrykt0PEoIsDqfdYy9KhJ0qgd7wZnMecIxnw/Re7Rh8/K4ppWuiqtiDOeMy1EV
         o99zGBRVKq65TgmZ9qyBZZabiqcfk1xtitbq6zOz80CTZSLZfmRAiXVonJUauBcGRYF8
         +dKLpQ8Jv+7sODHpv286mmR2QSwaimOXMIMkoZJVjdhkwVK3M3jnYy65FBVMUEaqUOfv
         ZLd9c6u7L89NyaE0RhJ+8e7ddHaXZc0/J596G9Bw/kgt2tenvMmYUeXfGDihxnmDNf1D
         jg0Q==
X-Gm-Message-State: AOUpUlGqINQGup0gPSMPgkvD3nguS/RPfGoQU+Zgdyiq6pLO9UMC/aYx
        Z5jYa7M4B2x6FNAODEEmxIc=
X-Google-Smtp-Source: AAOMgpcvhhH47NnbtVHcHPZ5FllnWkJMOhSuNoXgYnNl3Sfv0dApV7nb8jJPZ9Ml9v0xSKxsDuKgRQ==
X-Received: by 2002:a50:9226:: with SMTP id i35-v6mr14762708eda.27.1532366002411;
        Mon, 23 Jul 2018 10:13:22 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id g8-v6sm5155942edh.87.2018.07.23.10.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:13:21 -0700 (PDT)
Date:   Mon, 23 Jul 2018 19:13:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Simon Shields <simon@lineageos.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: dts: exynos: configure midas SD card CD pin
Message-ID: <20180723171320.zkutp24l5xva6ghh@kozik-lap>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-6-simon@lineageos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180721125128.31498-6-simon@lineageos.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 10:50:53PM +1000, Simon Shields wrote:
> This pin is externally pulled up, so we need to disable the SoC's
> internal pull down resistor to allow it to function properly.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

