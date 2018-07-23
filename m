Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EABECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C75A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PA7WA5+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C75A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeGWD4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:56:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36000 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731274AbeGWD4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:56:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so7710605pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZi1hgIOhqzvqJjtWeAsAnWiKY8V9AQjM/hnwopbNUc=;
        b=PA7WA5+P+cdaMz0qsmFKYs1l0VrbMHRA2kpNg9Zt/M2emlnxoi7NMMIY4TGp4TBQi4
         23/9FcLaDZ568rmRRSZrlpRLMaPvRHoVIcsgZSCR5SAvYt4UPCK+0aKQ3lmzsUqbFJl7
         THKAx1eTren3QIa1OKngsPoaUbYYtStXiOEkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZi1hgIOhqzvqJjtWeAsAnWiKY8V9AQjM/hnwopbNUc=;
        b=p7DG709tGBKLSgrBF6c9hQblNhhhwKNwgALqOvhQLuFbdXfS0ro3GXamRfBBmbnZ3R
         sdZTDhApUaOX64NkjK09Ma1xvFmwV8GTlpv8jGoAflP15Y3Um/xnvGp7rjR/eGjVPnx1
         yHIWYN4i8pD2dAczByJ3MGbA7cupuwLGLl4V4YVyeZTkX6rG+brk8IsrDSWJ6W8JGC6P
         59WewjZdw4yfLae2XpTPqdUPMnunsChzKoOq0mOpD8tuPy70KcUTY2PnuT79tLO4Oz04
         lrKBdfuMsJGDFHVTbHtlaZ5PoNWQ4MXEeXowMCV6TfsnmHpqVFnqwOotfManaF4BN8UE
         xMLQ==
X-Gm-Message-State: AOUpUlG8VKJQx2j6n7inv8wwvn+JopBCbO+LdEdTd82nhcXB2CGfJn9N
        8GeuDU0iEU0EOmB4KI8y3+CVgw==
X-Google-Smtp-Source: AAOMgpcLHZxAs17id3m4banBUcS0RvpNdBZUxa/nzxHB/l2m9B+yRXAm2hxQbjRiGgHQhkySg1VNkg==
X-Received: by 2002:a65:62cd:: with SMTP id m13-v6mr10437534pgv.280.1532314670283;
        Sun, 22 Jul 2018 19:57:50 -0700 (PDT)
Received: from localhost ([122.172.26.112])
        by smtp.gmail.com with ESMTPSA id r19-v6sm11400535pgo.68.2018.07.22.19.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 19:57:49 -0700 (PDT)
Date:   Mon, 23 Jul 2018 08:27:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH] ARM: dts: spear: fix stmpe811 interrupt properties
Message-ID: <20180723025747.ykxeqogyfn6wskvo@vireshk-i7>
References: <20180720075356.26156-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720075356.26156-1-marcel@ziswiler.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-18, 09:53, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> The property "irq-over-gpio" simply does not exist (this is nowadays
> actually auto detected) and the property "irq-gpios" is actually called
> "irq-gpios".

  "irq-gpio" ?

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm/boot/dts/spear320-hmi.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
> index 0d0da1f65f0e..d2d1fe944407 100644
> --- a/arch/arm/boot/dts/spear320-hmi.dts
> +++ b/arch/arm/boot/dts/spear320-hmi.dts
> @@ -241,8 +241,7 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					reg = <0x41>;
> -					irq-over-gpio;
> -					irq-gpios = <&gpiopinctrl 29 0x4>;
> +					irq-gpio = <&gpiopinctrl 29 0x4>;
>  					id = <0>;
>  					blocks = <0x5>;
>  					irq-trigger = <0x1>;

-- 
viresh
