Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466D4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27C221773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UgusZdKE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FH3IEsiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeLTEDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 23:03:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeLTEDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 23:03:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 488B6607CA; Thu, 20 Dec 2018 04:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545278624;
        bh=6wy6dkCowRS5htXWl0qOm0vaFR1/mK46y9nAOy+y44Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UgusZdKESW8sgqlcuYKFLiEXoAfgIrN99kb0iG05G9+YdNCmm7DCVgpjT2bcDNQ7V
         5eay5zGvXe+yg6aOxjisKBb7QpOS/ziRV/X6hhtH8VyE/YTov3W2IGeLeFIwDDLbLa
         7PU1Sf9P2V2HkkTLCbfYzPaMtJ+/UEsfRyZwlIYQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5958F6014B;
        Thu, 20 Dec 2018 04:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545278623;
        bh=6wy6dkCowRS5htXWl0qOm0vaFR1/mK46y9nAOy+y44Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FH3IEsiNrhoVfJMB5CeojYVymHsh68+EBKZ5/52MZ1AbqSJKvr8KBPv2u04IhiFiY
         06I4TLf/hWk8iUHw0l1Zis8E7zUJgkZ9A9TRIZWeks7rFlzOcAkO6SbVe61V1OR4D1
         HAzcDn6SMc1iiZ7V9YMsiQbCK/xwjQYBU5S3itMg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Dec 2018 09:33:43 +0530
From:   mgautam@codeaurora.org
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v6 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
In-Reply-To: <20181220010112.16824-3-shawn.guo@linaro.org>
References: <20181220010112.16824-1-shawn.guo@linaro.org>
 <20181220010112.16824-3-shawn.guo@linaro.org>
Message-ID: <f106782b6d8e26ebf851f00563c68948@codeaurora.org>
X-Sender: mgautam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 2018-12-20 06:31, Shawn Guo wrote:
> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
....

> +
> +/* PHY register and bit definitions */
> +#define PHY_CTRL_COMMON0		0x078
> +#define SIDDQ				BIT(2)
> +#define PHY_IRQ_CMD			0x0d0
> +#define PHY_INTR_MASK0			0x0d4
> +#define PHY_INTR_CLEAR0			0x0dc
> +#define DPDM_MASK			0x1e
> +#define DP_1_0				BIT(4)
> +#define DP_0_1				BIT(3)
> +#define DM_1_0				BIT(2)
> +#define DM_0_1				BIT(1)

Can we rename these to something more readable? e.g.:
#define DP_FALL_INT_EN    BIT(4)
#define DP_RISE_INT_EN    BIT(3)
...

> +
> +enum hsphy_voltage {
> +	VOL_NONE,
> +	VOL_MIN,
> +	VOL_MAX,
> +	VOL_NUM,
> +};
> +
> +enum hsphy_vreg {
> +	VDD,
> +	VDDA_1P8,
> +	VDDA_3P3,
> +	VREG_NUM,
> +};
> +
> +struct hsphy_init_seq {
> +	int offset;
> +	int val;
> +	int delay;
> +};
> +
> +struct hsphy_data {
> +	const struct hsphy_init_seq *init_seq;
> +	unsigned int init_seq_num;
> +};
> +
> +struct hsphy_priv {
nit-pick - indentation for following structure members?

> +	void __iomem *base;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	struct reset_control *phy_reset;
> +	struct reset_control *por_reset;
> +	struct regulator_bulk_data vregs[VREG_NUM];
> +	unsigned int voltages[VREG_NUM][VOL_NUM];
> +	const struct hsphy_data *data;
> +	bool cable_connected;

You can get cable-connected state from "enum phy_mode mode" which
is present in this driver.
E.g. cable_connected is false if mode is neither HOST nor DEVICE.


> +	struct extcon_dev *vbus_edev;
> +	struct notifier_block vbus_notify;

extcons not needed if you use "mode" for the same purpose.


> +	enum phy_mode mode;
> +};
> +


> +
> +static int qcom_snps_hsphy_vbus_notifier(struct notifier_block *nb,
> +					 unsigned long event, void *ptr)
> +{
> +	struct hsphy_priv *priv = container_of(nb, struct hsphy_priv,
> +						    vbus_notify);
> +	priv->cable_connected = !!event;
> +	return 0;
> +}
> +
> +static int qcom_snps_hsphy_power_on(struct phy *phy)

Can you instead merge this power_on function with phy_init?

> +{
> +	struct hsphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	if (priv->cable_connected) {

Why distinguish between cable connected vs not-connected?


> +		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> +		if (ret)
> +			return ret;
> +		qcom_snps_hsphy_disable_hv_interrupts(priv);
> +	} else {
> +		ret = qcom_snps_hsphy_enable_regulators(priv);
> +		if (ret)
> +			return ret;
> +		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
> +		if (ret)
> +			return ret;
> +		qcom_snps_hsphy_exit_retention(priv);
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_snps_hsphy_power_off(struct phy *phy)
> +{
> +	struct hsphy_priv *priv = phy_get_drvdata(phy);
> +
> +	if (priv->cable_connected) {
> +		qcom_snps_hsphy_enable_hv_interrupts(priv);
> +		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +	} else {
> +		qcom_snps_hsphy_enter_retention(priv);
> +		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
> +		qcom_snps_hsphy_disable_regulators(priv);
> +	}
> +
> +	return 0;
> +}
> +



..
> +static const struct phy_ops qcom_snps_hsphy_ops = {
> +	.init = qcom_snps_hsphy_init,
> +	.power_on = qcom_snps_hsphy_power_on,
> +	.power_off = qcom_snps_hsphy_power_off,
> +	.set_mode = qcom_snps_hsphy_set_mode,

.phy_exit()?
I believe that is needed as dwc3 core driver performs
phy_exit/phy_init across pm_suspend/resume.


> +	.owner = THIS_MODULE,
> +};
> +

