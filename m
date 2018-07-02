Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5D4C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA034256B3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARB7IGr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA034256B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932138AbeGBSxC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:53:02 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38526 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbeGBSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:53:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id j17-v6so7915215pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DH9CSSbaxrEliXGeQErQjhAut0xk0sXB4F34YqfKmIM=;
        b=ARB7IGr78x/vqUO4x8Ba0DmeaFcygc5XbisBv3to32ivxhXogUgrfXaHmo/AMMNjNj
         XkzjJKJZQXVVG6qsSKNf8aKcfZEFHH4tVA5XL6baldsTM4q/mj/LV905McA84d1D1mnM
         Xj+cdMnlLzcsZRACYCnmg5wjNwP0O9mUbt34g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DH9CSSbaxrEliXGeQErQjhAut0xk0sXB4F34YqfKmIM=;
        b=EgfSRTQVoZjTf9wY7R31bFu9hYUzm2NH84uB+tweHiVXjzSmg5fOnuA5IasJnYHQDj
         QjII5JXyg4HdvRyCXcdrh/fqOg+Hs/cxtW341VVMlGpodCcD2pZEDBh382XPLDpxhfw1
         Gv9iRZuwY3NGMWsZJqph2eo4i+G1IELmqv5HIFJcXa6K2KfJ2xUtyePb87xjWLW2ksBS
         wY2gHBBAk5aXwEzLtkvnW09xSFQe3RxXfN2mqGQCDGZt4zGiWnUP15AJwF0w+2/LsqPy
         spmsyWifSW35I0lsGx+JJuVXNSh1tosKtC3KKcBFBSpBQzA761eVDwnWG+Xia71OguHI
         eSbA==
X-Gm-Message-State: APt69E25f/nz1PbY6K6UKIWRrm2BFb8jfsSSoqm+rt3NpGok2VLSeKKu
        YDyD8HKbQWH5J6qLevJiMMz5zA==
X-Google-Smtp-Source: ADUXVKKMTFhsjp4st8ofSeYPXjJ/G+6myXvS9Zyeeuatjn7nXgMIgLY2Foqh2mXwz9AA4X/Ie4a/Og==
X-Received: by 2002:a63:7b1b:: with SMTP id w27-v6mr21968037pgc.199.1530557579845;
        Mon, 02 Jul 2018 11:52:59 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g10-v6sm25093453pfi.148.2018.07.02.11.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 11:52:59 -0700 (PDT)
Date:   Mon, 2 Jul 2018 11:55:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/6] thermal: tsens: Rename tsens-8996 to tsens-v2 for
 reuse
Message-ID: <20180702185530.GD2050@tuxbook-pro>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <7e9beaa3218b1c46ea6a7399c5978c1538fce261.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e9beaa3218b1c46ea6a7399c5978c1538fce261.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:

> The TSENS block inside the 8996 is internally classified as version 2 of
> the IP. Several other SoC families use this block and can share this code.
> 
> We rename get_temp() to reflect that it can be used across the v2 family.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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
> index e1f7781..2eca7ff 100644
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

This is not backwards compatible with present day dts files, you need to
keep this effectively 0x10a0 when the memory region isn't split in two.

Perhaps you can just offset the ioremap by 4k when there's only one
region?


Apart from this I like the change!

Regards,
Bjorn

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
