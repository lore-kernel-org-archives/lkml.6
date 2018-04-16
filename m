Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDPRUN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:20:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPRUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:20:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Apr 2018 22:50:10 +0530
From: saiprakash.ranjan@codeaurora.org
To: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, tsoni@codeaurora.org, kyan@codeaurora.org,
        ckadabi@codeaurora.org, stanimir.varbanov@linaro.org,
        evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm@lists.infradead.org, evgreen@chromium.org
Subject: Re: [PATCH v4 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <1523390893-10904-3-git-send-email-rishabhb@codeaurora.org>
References: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org>
 <1523390893-10904-3-git-send-email-rishabhb@codeaurora.org>
Message-ID: <2ca31c0ffd699d0aea13d09a3b2be0a8@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

> +MODULE_DESCRIPTION("QTI sdm845 LLCC driver");

I think it should be QCOM or Qualcomm and not QTI

> +
> +	desc = devm_kzalloc(dev, sizeof(struct llcc_slice_desc), GFP_KERNEL);

Can use *desc instead

> +struct llcc_slice_desc *llcc_slice_getd(struct device *dev, const char 
> *name)
> +{
> +	struct device_node *np = dev->of_node;
> +	int index = 0;
> +	const char *slice_name;
> +	struct property *prop;
> +
> +	if (!np)
> +		return ERR_PTR(-ENOENT);

Is this check required?

> diff --git a/include/linux/soc/qcom/llcc-qcom.h
> b/include/linux/soc/qcom/llcc-qcom.h
> new file mode 100644
> index 0000000..3e97569
> --- /dev/null
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0

Should be within /* */ for headers as per kernel licensing rules.

Regards,
Sai Prakash
