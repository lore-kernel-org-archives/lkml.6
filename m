Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA12C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D47520861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fh1PLVWM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TK/ZsOgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfAVGoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:44:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfAVGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:44:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88AB760712; Tue, 22 Jan 2019 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548139492;
        bh=9RN9B49dVdQkWGbcRiqVvwvTnwKxwVfo1rr+uxKSqpY=;
        h=Date:From:To:Cc:Subject:From;
        b=fh1PLVWMyv4ZD7BsazQFLAoXLNlJwnJgbZOGzXByfkR12v0od099PscRNZ3JLZDu1
         z7dyMdRyOGEHLAGmpVkjDW29kPgcTWnaFwkBpXeJU8Fk43mlK8tNJeCqfj+nt8uSef
         6NFzFTYq48WIff4bYQAt6kyVjnSX96YuhdpFh9/U=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7A345607CA;
        Tue, 22 Jan 2019 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548139490;
        bh=9RN9B49dVdQkWGbcRiqVvwvTnwKxwVfo1rr+uxKSqpY=;
        h=Date:From:To:Cc:Subject:From;
        b=TK/ZsOgXqOccoKZuVCcoxYBM/ytvAeaiUczkavps42S+IKOYQ2JqCYDDpvXBhoilH
         FNgWsVgMGWIdsce78Btdi6B/N19LRXsg+n8AUFT7g6i1gKTOxvA4NK4lAo49Qw71Op
         kAIDtDYKLryeFoW5W5dvGN2/cT7r61VOEEmIuhEY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jan 2019 12:14:50 +0530
From:   alokc@codeaurora.org
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     georgi.djakov@linaro.org
Subject: Re: [PATCH 2/6] soc: qcom: Add wrapper to support for Interconnect
 path
Message-ID: <bb96a82e7f8ecf646959d05de8913900@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't review this patch. I've resend patches after adding all the 
mailing list.
Sorry for inconvenience.

On 2019-01-21 16:51, Alok Chauhan wrote:
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
>  drivers/soc/qcom/qcom-geni-se.c | 129 
> ++++++++++++++++++++++++++++++++++++++++
>  include/linux/qcom-geni-se.h    |  11 ++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c 
> b/drivers/soc/qcom/qcom-geni-se.c
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
> + * geni_icc_update_bw() - Request to update bw vote on an interconnect 
> path
> + * @se:			Pointer to the concerned serial engine.
> + * @update:		Flag to update bw vote.
> + *
> + * This function is used to request set bw vote on interconnect path 
> handle.
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
>   * geni_se_resources_off() - Turn off resources associated with the 
> serial
>   *                           engine
>   * @se:	Pointer to the concerned serial engine.
> @@ -707,6 +783,47 @@ void geni_se_rx_dma_unprep(struct geni_se *se,
> dma_addr_t iova, size_t len)
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
>  static int geni_se_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -737,6 +854,17 @@ static int geni_se_probe(struct platform_device 
> *pdev)
>  	return devm_of_platform_populate(dev);
>  }
> 
> +static int geni_se_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct geni_wrapper *wrapper = dev_get_drvdata(dev);
> +
> +	icc_put(wrapper->icc_path[0]);
> +	icc_put(wrapper->icc_path[1]);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id geni_se_dt_match[] = {
>  	{ .compatible = "qcom,geni-se-qup", },
>  	{}
> @@ -749,6 +877,7 @@ static int geni_se_probe(struct platform_device 
> *pdev)
>  		.of_match_table = geni_se_dt_match,
>  	},
>  	.probe = geni_se_probe,
> +	.remove = geni_se_remove,
>  };
>  module_platform_driver(geni_se_driver);
> 
> diff --git a/include/linux/qcom-geni-se.h 
> b/include/linux/qcom-geni-se.h
> index 3bcd67f..9bf03e9 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -33,6 +33,10 @@ enum geni_se_protocol_type {
>   * @clk:		Handle to the core serial engine clock
>   * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
>   * @clk_perf_tbl:	Table of clock frequency input to serial engine 
> clock
> + * @avg_bw:		Average bus bandwidth value for Serial Engine device
> + * @peak_bw:		Peak bus bandwidth value for Serial Engine device
> + * @peak_bw_list:	List Head of peak bus banwidth list for Serial 
> Engine
> + *			device
>   */
>  struct geni_se {
>  	void __iomem *base;
> @@ -41,6 +45,9 @@ struct geni_se {
>  	struct clk *clk;
>  	unsigned int num_clk_levels;
>  	unsigned long *clk_perf_tbl;
> +	u32 avg_bw;
> +	u32 peak_bw;
> +	struct list_head peak_bw_list;
>  };
> 
>  /* Common SE registers */
> @@ -416,5 +423,9 @@ int geni_se_rx_dma_prep(struct geni_se *se, void
> *buf, size_t len,
>  void geni_se_tx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t 
> len);
> 
>  void geni_se_rx_dma_unprep(struct geni_se *se, dma_addr_t iova, size_t 
> len);
> +
> +int geni_interconnect_init(struct geni_se *se);
> +
> +void geni_icc_update_bw(struct geni_se *se, bool update);
>  #endif
>  #endif

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
