Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED6ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D872082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZNYTV8Zv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ih76X+7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D872082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJYC6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:58:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeJYC6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:58:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45D0D60C64; Wed, 24 Oct 2018 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540405767;
        bh=UyEHKekQrl4/k22vJPUJNSCmlCfaywG35Kx01XmjW8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZNYTV8ZvsFxOY4oQNfdpUApUYKcjZB2wrYllidvy5rxmLsVExpEbUwfRvVOlIEyq6
         GDsTKmd/JwjFlB8phZx9ghRjj8Yfce4dS8foobufq/c0CaHJ7UqPP0U76QYTbzG3uu
         w6CkCMl56CsQYoftiMrWPNndufaUHuBp6qVq0PMg=
Received: from [192.168.43.100] (unknown [106.206.34.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8B4A60C64;
        Wed, 24 Oct 2018 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540405766;
        bh=UyEHKekQrl4/k22vJPUJNSCmlCfaywG35Kx01XmjW8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ih76X+7V4eoMRZtqKCS27CKIxSFatrjbnu7kWxPAnLKyr1cpyycy7VXVx0wj9NKTY
         A3GR+L8YjlQUCdyGIKHoV01/7nRBZRM2Jey63qkHguo52npRHEZjxNBg7z7HiP7547
         WA6OXgdUCCqeUCvPHKdZBpAPzQjuMEAfmVlpvtmw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8B4A60C64
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v4 2/5] phy: qcom-qmp: Utilize fully-specified DT
 registers
To:     Evan Green <evgreen@chromium.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
References: <20181024172735.154304-1-evgreen@chromium.org>
 <20181024172735.154304-3-evgreen@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <6b3edcc1-eaca-0fac-7ec4-a7390650b13b@codeaurora.org>
Date:   Wed, 24 Oct 2018 23:59:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024172735.154304-3-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,


On 10/24/2018 10:57 PM, Evan Green wrote:
> Utilize the newly fixed up DT bindings to get the tx2 and rx2 register
> regions for the second lane of dual-lane PHYs. Before this change,
> the driver was simply using lane one's register region and adding
> 0x400, which reached well beyond the DT-specified register
> allocation. This would have been a crash were it not for the page size
> on ARM64. Fix the driver not to rely on the magic of virtual memory by
> using the newly specified DT register regions for tx2 and rx2.
>
> In order to support existing device trees, this change also contains a
> fallback mode for when those new register regions don't exist, which
> reverts to the original behavior of overreaching and prints a complaint.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> As Doug mentioned, this should land before the dts patches land, otherwise
> the old driver code will use the tx2 register region as pcs_misc.
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>   drivers/phy/qualcomm/phy-qcom-qmp.c | 51 +++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index a83332411026..61d5fe115d9d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -72,6 +72,9 @@
>   
>   #define MAX_PROP_NAME				32
>   
> +/* Define the assumed distance between lanes for underspecified device trees. */
> +#define QMP_PHY_LEGACY_LANE_STRIDE		0x400
> +
>   struct qmp_phy_init_tbl {
>   	unsigned int offset;
>   	unsigned int val;
> @@ -733,9 +736,6 @@ struct qmp_phy_cfg {
>   	bool has_phy_dp_com_ctrl;
>   	/* true, if PHY has secondary tx/rx lanes to be configured */
>   	bool is_dual_lane_phy;
> -	/* Register offset of secondary tx/rx lanes for USB DP combo PHY */
> -	unsigned int tx_b_lane_offset;
> -	unsigned int rx_b_lane_offset;
>   
>   	/* true, if PCS block has no separate SW_RESET register */
>   	bool no_pcs_sw_reset;
> @@ -748,6 +748,8 @@ struct qmp_phy_cfg {
>    * @tx: iomapped memory space for lane's tx
>    * @rx: iomapped memory space for lane's rx
>    * @pcs: iomapped memory space for lane's pcs
> + * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
> + * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
>    * @pcs_misc: iomapped memory space for lane's pcs_misc
>    * @pipe_clk: pipe lock
>    * @index: lane index
> @@ -759,6 +761,8 @@ struct qmp_phy {
>   	void __iomem *tx;
>   	void __iomem *rx;
>   	void __iomem *pcs;
> +	void __iomem *tx2;
> +	void __iomem *rx2;
>   	void __iomem *pcs_misc;
>   	struct clk *pipe_clk;
>   	unsigned int index;
> @@ -975,8 +979,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
>   
>   	.has_phy_dp_com_ctrl	= true,
>   	.is_dual_lane_phy	= true,
> -	.tx_b_lane_offset	= 0x400,
> -	.rx_b_lane_offset	= 0x400,
>   };
>   
>   static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
> @@ -1031,9 +1033,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>   	.mask_pcs_ready		= PCS_READY,
>   
>   	.is_dual_lane_phy	= true,
> -	.tx_b_lane_offset	= 0x400,
> -	.rx_b_lane_offset	= 0x400,
> -
>   	.no_pcs_sw_reset	= true,
>   };
>   
> @@ -1238,12 +1237,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
>   	qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
>   	/* Configuration for other LANE for USB-DP combo PHY */
>   	if (cfg->is_dual_lane_phy)
> -		qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
> +		qcom_qmp_phy_configure(qphy->tx2, cfg->regs,
>   				       cfg->tx_tbl, cfg->tx_tbl_num);
>   
>   	qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
>   	if (cfg->is_dual_lane_phy)
> -		qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
> +		qcom_qmp_phy_configure(qphy->rx2, cfg->regs,
>   				       cfg->rx_tbl, cfg->rx_tbl_num);
>   
>   	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> @@ -1614,8 +1613,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>   
>   	/*
>   	 * Get memory resources for each phy lane:
> -	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2; and
> -	 * pcs_misc (optional) -> 3.
> +	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
> +	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
> +	 * For single lane PHYs: pcs_misc (optional) -> 3.
>   	 */
>   	qphy->tx = of_iomap(np, 0);
>   	if (!qphy->tx)
> @@ -1629,7 +1629,32 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>   	if (!qphy->pcs)
>   		return -ENOMEM;
>   
> -	qphy->pcs_misc = of_iomap(np, 3);
> +	/*
> +	 * If this is a dual-lane PHY, then there should be registers for the
> +	 * second lane. Some old device trees did not specify this, so fall
> +	 * back to old legacy behavior of assuming they can be reached at an
> +	 * offset from the first lane.
> +	 */
> +	if (qmp->cfg->is_dual_lane_phy) {
> +		qphy->tx2 = of_iomap(np, 3);
> +		qphy->rx2 = of_iomap(np, 4);
> +		if (!qphy->tx2 || !qphy->rx2) {
> +			dev_warn(dev,
> +				 "Underspecified device tree, falling back to legacy register regions\n");
> +
> +			/* In the old version, pcs_misc is at index 3. */
> +			qphy->pcs_misc = qphy->tx2;
> +			qphy->tx2 = qphy->tx + QMP_PHY_LEGACY_LANE_STRIDE;
> +			qphy->rx2 = qphy->rx + QMP_PHY_LEGACY_LANE_STRIDE;
> +
> +		} else {
> +			qphy->pcs_misc = of_iomap(np, 5);
> +		}
> +
> +	} else {
> +		qphy->pcs_misc = of_iomap(np, 3);
> +	}
Thanks for the patch.
I am starting to think that the driver is heavily relying on the 
resource indices to request
all these areas ioremapped. Is it a good way forward that driver and the 
dt bindings are
chained together?
Should we rather switch to requesting these resources by some names?

Rob can comment on this possibly.

In otherwise case, the change looks good to me. So, if we go ahead with 
this patch, you can use my review.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

> +
>   	if (!qphy->pcs_misc)
>   		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
>   


