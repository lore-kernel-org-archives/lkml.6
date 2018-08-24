Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED7DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBCC21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skD0hSN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBCC21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeHYDHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:07:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43889 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeHYDHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:07:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so5188649pfi.10;
        Fri, 24 Aug 2018 16:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xzisnbfc26vkGabzdj2vUCHH8y+m++S7Mn1QAoBjw/4=;
        b=skD0hSN1sBG0vhXC3rnpRD3RFP1VV5s7B3FxvnRZWuo8XPDtOhSds0Jiayrhz0pZKS
         CNKX7+A8gMICKWaTDdPAZxwLqnu4hyAGX+c5fY+NJ9UOO2gMAl0ZBbBxIrfWkXEJKG2h
         a57rH+D7vIfwkFiJwHl2qH7GMcguyJfibk9iQxM9gjXZqNcmCWEK2ekzDaI+O+mAswjE
         dftZ1rYWOGemeREdEq/niySuOYB6x2M492sK6aCrVtz7LIUQBM95R4CG5JG0z5bD1UpZ
         F93weBS9Miur/Kn/pzGxp8yvbyZ/sGp1hGgl4lRJ/y7gT2b44jzy7LFLPar0kdhseyZu
         Dh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xzisnbfc26vkGabzdj2vUCHH8y+m++S7Mn1QAoBjw/4=;
        b=tVHXznJI2cDv87NVDqHyGp95U+8qLJsCLVA2oCiVpTgZso4j6hI9NxP2xlDLwZy93h
         87PKpwaokPrKJl5TsUxPvc/+631JEo4HFv96ZIQu1hIToGdo04UIPV3J9v6Hh2nPJLBw
         FC2uJJYWF5Vw3geQjArKpbOhTigZm+OQYoRnw4x6NYT6KR5kjNT9F0rtnAIRkqyAhc7v
         SJFvdKFhMFNObVQb6bPA7Nfb+lavYiOkWc5ngYnIdNGeCcxtIlj1FWdGI0RpN0XNRse9
         EZyrYViYBtcsv6TieUeyRybEbgfkWo8wOEBoy3WaYmodCjAF5pLP0+1OPnRLtfg3teBb
         7cEQ==
X-Gm-Message-State: APzg51A0ozt4IBuPNBp8xnqczSC7HMOkg7UUrIjy+yp5NdUP6t3nWOkY
        B3s6ZjSM7KUQphSpx0xDNdo=
X-Google-Smtp-Source: ANB0VdZV6h/wHP0DKEVN7ZVer69XQZ6Et6Xbp1aVKug4wKFWiSMBK5KXOfrSM5kAulDV+5CYrHkg/Q==
X-Received: by 2002:a62:d8c7:: with SMTP id e190-v6mr3948351pfg.88.1535153446836;
        Fri, 24 Aug 2018 16:30:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id t17-v6sm16589783pfm.138.2018.08.24.16.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:30:46 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:30:41 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 07/10] thermal: tsens: Check if the IP is correctly
 enabled by firmware
Message-ID: <20180824233039.GF25163@localhost.localdomain>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <985ed415774fdac9ac21afad4b4b74f30f6c5068.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985ed415774fdac9ac21afad4b4b74f30f6c5068.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:39PM +0530, Amit Kucheria wrote:
> The SROT registers are initialised by the secure firmware at boot. We
> don't have write access to the registers. Check if the block is enabled
> before continuing.
> 

Should this be merged to patch 6?

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 0b8a793f15f4..d250b757d1f0 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -12,6 +12,11 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> +/* SROT */
> +#define CTRL_OFFSET		0x4
> +#define TSENS_EN		BIT(0)
> +
> +/* TM */
>  #define STATUS_OFFSET		0x30
>  #define SN_ADDR_OFFSET		0x4
>  #define SN_ST_TEMP_MASK		0x3ff
> @@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
>  {
>  	void __iomem *tm_base, *srot_base;
>  	struct resource *res;
> +	u32 code;
> +	int ret;
>  	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
>  	if (!op)
> @@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
>  	if (IS_ERR(tmdev->tm_map))
>  		return PTR_ERR(tmdev->tm_map);
>  
> +	if (tmdev->srot_map) {
> +		ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
> +		if (ret)
> +			return ret;
> +		if (!(code & TSENS_EN)) {
> +			dev_err(tmdev->dev, "tsens device is not enabled\n");
> +			return -ENODEV;
> +		}
> +	}
> +
>  	return 0;
>  }
> -- 
> 2.17.1
> 
