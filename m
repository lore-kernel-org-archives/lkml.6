Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E4020C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXRU8gOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E4020C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbeGKQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:42:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33645 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbeGKQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:42:25 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so9397475plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5QQdlwZ3HXGVjRH2NE3/TOnB2m3mlq1cly8orSYcxDM=;
        b=dXRU8gOH9M4yF0NzRsTm+eaBenuYlHyASPIcNzwIdVcByjXw3M+NG336E6fAIyOZvC
         9J5ybVeAUA90NPFkKn3SvdVUKPs/vBWFaTW9xfnokbe2pgflkrfDLrbnWy3l5Q5GR/IU
         oqKzl+OSWapOfQXyrNC72z1LYiJxAjMLp2XKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5QQdlwZ3HXGVjRH2NE3/TOnB2m3mlq1cly8orSYcxDM=;
        b=jQVYjtCox/Q8oiIwhV+oVx4yRYy2c/Rh/XrVCXMdNW6P7vlUKfofJG0y6ug1Ou0qV9
         piewu3PjrihFrN1OLAhq0TTvoUFUaV5wMf4a1xNm47MZ6iFIvp8tGcItvUp/j1PHxz6N
         WuW8/njvEF/5oVkZx4Yq/2g0Z8VyhJoZaQnbX1SdA/wkrnGD+Q4oSwZqum32gHbrK6+j
         rXgsu9SV+C4xiS+5JIL4irRL65hwjYzPFT0Is4TTJ3AYnDTLmLO32v1dAhORgryCaCjc
         ko6S3hJ0kKCwv3A8VhstvSTdPWr7SJciEcLNTNo1go0CM/6rCyF+qybK50ib4EjZUBc5
         ApKw==
X-Gm-Message-State: APt69E2LMaC08kAAHqffEHXfdsND+Y0IwkYenLEJ/w/PUDeQE3BacJJG
        98vPM49jy/rzXJm9X51teFzpmg==
X-Google-Smtp-Source: AAOMgpeEefTTWFLM0Mw87E0ya1dT+cynXDn5zPEPg+dMfKSoksoMkp3ANsxWzn0REcn+LjtBxiHf7A==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr29545365plp.143.1531327036485;
        Wed, 11 Jul 2018 09:37:16 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j23-v6sm31827569pfi.137.2018.07.11.09.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:37:15 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:39:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/7] thermal: tsens: Rename tsens-8996 to tsens-v2 for
 reuse
Message-ID: <20180711163957.GC545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <910ed3e440a5612f4113318c66ae2395f53abaae.1531135999.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910ed3e440a5612f4113318c66ae2395f53abaae.1531135999.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> The TSENS block inside the 8996 is internally classified as version 2 of
> the IP. Several other SoC families use this block and can share this code.
> 
> We rename get_temp() to reflect that it can be used across the v2 family.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/Makefile                     |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 26 ++++++++---------------
>  2 files changed, 10 insertions(+), 18 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)
> 
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 2cc2193..a821929 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
> -qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
> +qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
> diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-v2.c
> similarity index 66%
> rename from drivers/thermal/qcom/tsens-8996.c
> rename to drivers/thermal/qcom/tsens-v2.c
> index 60765b1..34ba6c7 100644
> --- a/drivers/thermal/qcom/tsens-8996.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -1,27 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> + * Copyright (c) 2018, Linaro Limited
>   */
>  
> -#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> -#define STATUS_OFFSET	0x10a0
> -#define LAST_TEMP_MASK	0xfff
> +#define STATUS_OFFSET		0xa0
> +#define LAST_TEMP_MASK		0xfff
>  #define STATUS_VALID_BIT	BIT(21)
>  #define CODE_SIGN_BIT		BIT(11)
>  
> -static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
> +static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>  {
>  	struct tsens_sensor *s = &tmdev->sensor[id];
>  	u32 code;
> @@ -73,12 +64,13 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
>  	return 0;
>  }
>  
> -static const struct tsens_ops ops_8996 = {
> +static const struct tsens_ops ops_generic_v2 = {
>  	.init		= init_common,
> -	.get_temp	= get_temp_8996,
> +	.get_temp	= get_temp_tsens_v2,
>  };
>  
>  const struct tsens_data data_8996 = {
>  	.num_sensors	= 13,
> -	.ops		= &ops_8996,
> +	.ops		= &ops_generic_v2,
>  };
> +
> -- 
> 2.7.4
> 
