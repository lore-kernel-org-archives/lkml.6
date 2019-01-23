Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08551C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C828421019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/n0GR8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAWSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:14:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39665 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:14:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so1421320pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j0Lj02tZKtlnFGf9TzvKbZJSn99iCj8hVuxLcjr/FCI=;
        b=R/n0GR8bsjf8t5FQt2b0p+zH1GeUoPjABnVZf5j9a8OrO2TQK8jJr8PSBbAw6RZB36
         ZA++58ezrY2tlFlaXQc3wZ7zw6Z18dqd1oi2l1scna0xkAIhGhsL35kFzK9oHE2YKVYp
         g03MvW4hxY08qANtVRjCbfYDaBRxyTB4wMkXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0Lj02tZKtlnFGf9TzvKbZJSn99iCj8hVuxLcjr/FCI=;
        b=h2mAf22wS07C8LetwTwxqwwMe6WvLpZFLtkH32SIPDnBmJC59TES/kkuvUyoFCqnMJ
         03qx+5bdN12XeJX/uXF5+H0vEfdNuBCVpD9HAN0Cal2he0/t2ANrHRVa2o/y34DMqY6+
         M3c57lis/RaRm4S1+DFLiGwCrk3+w3runCeWZGav3NVaPsLxmC/R7r3gIJqbjmQ7UrhF
         eoiU7LoxvUOxq7ZJ3CQDVwda6QlRdQR3X9vKHYtGHrnaKL6O7xZZd6ctquitZzzsW11W
         /XzyYsDNbufiS8tV0mS3n80pNGYbVru4fsyqoUemX+er1/soo8jhTQjhsOiEgdExGRS1
         uOyA==
X-Gm-Message-State: AJcUukdbDR5B0lpt+/4p4DIhYocSYH16S0LQr/gTdHyx54GyTj+GncVa
        sU/44w24AouAMfnG/dzAPBCSsw==
X-Google-Smtp-Source: ALg8bN70LAwl3wv47xtT6usvendW0yzok+Q6uRRvKFJM6VNg/iSIpCsuCp06IozGWzKf2Y+o9P3gZA==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr3027965pfn.125.1548267281984;
        Wed, 23 Jan 2019 10:14:41 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p2sm26757425pfp.125.2019.01.23.10.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:14:40 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:14:38 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        georgi.djakov@linaro.org
Subject: Re: [PATCH 2/6] soc: qcom: Add wrapper to support for Interconnect
 path
Message-ID: <20190123181438.GM31919@minitux>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-3-git-send-email-alokc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548138816-1149-3-git-send-email-alokc@codeaurora.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:

> Add the wrapper to support for interconnect path voting
> from GENI QUP. This wrapper provides the functionalities
> to individual Serial Engine device to get the interconnect
> path and to vote for bandwidth based on their need.
> 
> This wrapper maintains bandwidth votes from each Serial Engine
> and send the aggregated vote from GENI QUP to interconnect
> framework.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 129 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/qcom-geni-se.h    |  11 ++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 6b8ef01..1d8dcb1 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -11,6 +11,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/qcom-geni-se.h>
> +#include <linux/interconnect.h>
>  
>  /**
>   * DOC: Overview
> @@ -84,11 +85,21 @@
>   * @dev:		Device pointer of the QUP wrapper core
>   * @base:		Base address of this instance of QUP wrapper core
>   * @ahb_clks:		Handle to the primary & secondary AHB clocks
> + * @icc_path:		Array of interconnect path handles
> + * @geni_wrapper_lock:	Lock to protect the bus bandwidth request
> + * @cur_avg_bw:		Current Bus Average BW request value from GENI QUP
> + * @cur_peak_bw:	Current Bus Peak BW request value from GENI QUP
> + * @peak_bw_list_head:	Sorted resource list based on peak bus BW
>   */
>  struct geni_wrapper {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct clk_bulk_data ahb_clks[NUM_AHB_CLKS];
> +	struct icc_path *icc_path[2];
> +	struct mutex geni_wrapper_lock;
> +	u32 cur_avg_bw;
> +	u32 cur_peak_bw;
> +	struct list_head peak_bw_list_head;
>  };
>  
>  #define QUP_HW_VER_REG			0x4
> @@ -440,6 +451,71 @@ static void geni_se_clks_off(struct geni_se *se)
>  }
>  
>  /**
> + * geni_icc_update_bw() - Request to update bw vote on an interconnect path
> + * @se:			Pointer to the concerned serial engine.
> + * @update:		Flag to update bw vote.

So update = false means "yes, do update, but subtract from the global
sum".


You track the bandwidth request for each "se", so I would recommend that
you turn this parameter into a "enabled" and track that as well for each
se. Then in this function you loop over all the wrapper's se and compute
the sum of the enabled ses.

> + *
> + * This function is used to request set bw vote on interconnect path handle.
> + */
> +void geni_icc_update_bw(struct geni_se *se, bool update)
> +{
> +	struct geni_se *temp = NULL;
> +	struct list_head *ins_list_head;
> +	struct geni_wrapper *wrapper;
> +
> +	mutex_lock(&se->wrapper->geni_wrapper_lock);
> +
> +	wrapper = se->wrapper;
> +
> +	if (update) {
> +		wrapper->cur_avg_bw += se->avg_bw;

I find this fragile, as you're relying on the se drivers always doing
the right thing.


That said, all you're doing here is sum up all the SEs bandwidth
requests and send them to the interconnect framework, which will sum
them up. Why don't you just call the interconnect framework from the SE
drivers directly?

You can still define the interconnects property in the wrapper DT node
and have the SEs do of_icc_get() from the parent DT node.

> +		ins_list_head = &wrapper->peak_bw_list_head;
> +		list_for_each_entry(temp, &wrapper->peak_bw_list_head,
> +				peak_bw_list) {
> +			if (temp->peak_bw < se->peak_bw)
> +				break;
> +			ins_list_head = &temp->peak_bw_list;
> +		}
> +
> +		list_add(&se->peak_bw_list, ins_list_head);
> +
> +		if (ins_list_head == &wrapper->peak_bw_list_head)
> +			wrapper->cur_peak_bw = se->peak_bw;
> +	} else {
> +		if (unlikely(list_empty(&se->peak_bw_list))) {
> +			mutex_unlock(&wrapper->geni_wrapper_lock);
> +			return;
> +		}
> +
> +		wrapper->cur_avg_bw -= se->avg_bw;
> +
> +		list_del_init(&se->peak_bw_list);
> +		temp = list_first_entry_or_null(&wrapper->peak_bw_list_head,
> +					struct geni_se, peak_bw_list);
> +		if (temp && temp->peak_bw != wrapper->cur_peak_bw)
> +			wrapper->cur_peak_bw = temp->peak_bw;
> +		else if (!temp && wrapper->cur_peak_bw)
> +			wrapper->cur_peak_bw = 0;
> +	}
> +
> +	/*
> +	 * This bw vote is to enable internal QUP core clock as well as to
> +	 * enable path towards memory.
> +	 */
> +	icc_set_bw(wrapper->icc_path[0], wrapper->cur_avg_bw,
> +		wrapper->cur_peak_bw);
> +
> +	/*
> +	 * This is just register configuration path so doesn't need avg bw.
> +	 * Set only peak bw to enable this path.
> +	 */
> +	icc_set_bw(wrapper->icc_path[1], 0, wrapper->cur_peak_bw);
> +
> +	mutex_unlock(&wrapper->geni_wrapper_lock);
> +}
> +EXPORT_SYMBOL(geni_icc_update_bw);
> +
> +/**
>   * geni_se_resources_off() - Turn off resources associated with the serial
>   *                           engine
>   * @se:	Pointer to the concerned serial engine.
> @@ -707,6 +783,47 @@ void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t len)
>  }
>  EXPORT_SYMBOL(geni_se_rx_dma_unprep);
>  
> +/**
> + * geni_interconnect_init() - Request to get interconnect path handle
> + * @se:			Pointer to the concerned serial engine.
> + *
> + * This function is used to get interconnect path handle.
> + */
> +int geni_interconnect_init(struct geni_se *se)
> +{
> +	struct geni_wrapper *wrapper_rsc;
> +
> +	if (unlikely(!se || !se->wrapper))
> +		return -EINVAL;
> +
> +	wrapper_rsc = se->wrapper;
> +
> +	if ((IS_ERR_OR_NULL(wrapper_rsc->icc_path[0]) ||
> +		IS_ERR_OR_NULL(wrapper_rsc->icc_path[1]))) {

You have a probe function for the wrapper, initialize the interconnects
from there instead. That way you don't have to do this.

> +
> +		wrapper_rsc->icc_path[0] = of_icc_get(wrapper_rsc->dev,
> +						"qup-memory");
> +		if (IS_ERR(wrapper_rsc->icc_path[0]))
> +			return PTR_ERR(wrapper_rsc->icc_path[0]);
> +
> +		wrapper_rsc->icc_path[1] = of_icc_get(wrapper_rsc->dev,
> +						"qup-config");
> +		if (IS_ERR(wrapper_rsc->icc_path[1])) {
> +			icc_put(wrapper_rsc->icc_path[0]);
> +			wrapper_rsc->icc_path[0] = NULL;
> +			return PTR_ERR(wrapper_rsc->icc_path[1]);
> +		}
> +
> +		INIT_LIST_HEAD(&wrapper_rsc->peak_bw_list_head);
> +		mutex_init(&wrapper_rsc->geni_wrapper_lock);
> +	}
> +
> +	INIT_LIST_HEAD(&se->peak_bw_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(geni_interconnect_init);
> +

Regards,
Bjorn
