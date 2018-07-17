Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B32ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A5621475
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+2VHDYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A5621475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeGQOso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:48:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39140 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbeGQOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:48:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id j8-v6so575402pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wrRP/YumPVwayGR2wg0VY+C20svbNqKFZKoDvTNgjAs=;
        b=O+2VHDYq8eldlpAFer9W+KHhsPxzIwNgFViWBhJRacTD0RZNvSkr6zF61omSQNc0/J
         O1t7uaMdV1CwLOrJE6kjdYMd6Mbpqu5ocmh7u0JbvGxxrW6ZIRoZ++ks+6YYe4kcXXt8
         Vk7+SZmAthRMnRPJl0wCIxu3jfrO29SvlQY4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wrRP/YumPVwayGR2wg0VY+C20svbNqKFZKoDvTNgjAs=;
        b=ryTQxsCm1R0wo9y86VDnqy+JsaEwUwsu/YL8mh+0hCySVoJ9CgClZRVtQ/ZLtdjE9p
         +TI85MndwTBKq0mJEgoqocwfmXhQb8X2QPOuE9IoYPiip2P/9UoIt5V7Hv2DnWJzJZrT
         WzWbojGB39UM3+KeURR7dzOu7SZGFBX/CZK8LTmzoB4OzEBE7NChflJ3aUp4kQuDLEOQ
         l4awgikrQyfiVZCV+Ko5zvqKUkzjLARZin3i5CTTTy6sLDEXEtxYQAvVQrQW9SpZRcuh
         37o5kIMrELPKnXlwvlXT7eoRvIXmfBYq7sVCWcSaChiwhtyZXy51dOcv/7+CmCDpP6NR
         obNw==
X-Gm-Message-State: AOUpUlGS/NMByeYHyj/0arak0YCm+ETzZvy/grS9hya6mg96MH6c2tlg
        3PrmtzMnNdrfArEpo+MfG93H
X-Google-Smtp-Source: AAOMgpe40mv08ABr9+k2HSc4Vj6JVVi2RJ6tTc1p8Z54YxFKg9i5P2iYRo80uoze/HSsXFZRnmIPZQ==
X-Received: by 2002:a63:4857:: with SMTP id x23-v6mr1845904pgk.30.1531836952863;
        Tue, 17 Jul 2018 07:15:52 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id p26-v6sm5737725pfi.183.2018.07.17.07.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:15:52 -0700 (PDT)
Date:   Tue, 17 Jul 2018 19:45:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v6 1/5] clk: actions: Add missing REGMAP_MMIO dependency
Message-ID: <20180717141542.GD19076@mani>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715203524.11948-2-sravanhome@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:35:20PM +0200, Saravanan Sekar wrote:
> Add REGMAP_MMIO as dependency to avoid undefined
> reference to regmap symbols.
> 
> Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/clk/actions/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
> index 8854adb37847..39491154abbf 100644
> --- a/drivers/clk/actions/Kconfig
> +++ b/drivers/clk/actions/Kconfig
> @@ -1,6 +1,7 @@
>  config CLK_ACTIONS
>  	bool "Clock driver for Actions Semi SoCs"
>  	depends on ARCH_ACTIONS || COMPILE_TEST
> +	select REGMAP_MMIO
>  	default ARCH_ACTIONS
>  
>  if CLK_ACTIONS
> -- 
> 2.18.0
> 
