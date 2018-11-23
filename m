Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA9020663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Af3Wl2jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA9020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503014AbeKWUjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:39:19 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57280 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeKWUjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:39:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAN9tfQC114490;
        Fri, 23 Nov 2018 03:55:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542966941;
        bh=BVnzX7UC6IcADme6gWZ6ezBadtXjrJdaHPVywRYx4Ns=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Af3Wl2jy8uqG249mRC6x2cHc7Pz4jGcWgr6VJwtOzk8RNtC3LyHjJ8juPWPzvsjZe
         vGkPm2tjII3/KVRAugCQg74mPOAlHMtA9Pd92OQDn4wjSLh/T5bUN3uvCaYQfv4JNe
         wmrWRySHbmmUTX2ks7jZeGDTE8YgBnpG9ax6a+B8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAN9tf1I124877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 03:55:41 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 03:55:41 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 03:55:41 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAN9tc7l009448;
        Fri, 23 Nov 2018 03:55:38 -0600
Subject: Re: [PATCH v4 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
To:     Shawn Guo <shawn.guo@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181119110812.15825-1-shawn.guo@linaro.org>
 <20181119110812.15825-3-shawn.guo@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <52433bdc-bc05-2ca0-0822-c9fb702b3231@ti.com>
Date:   Fri, 23 Nov 2018 15:25:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119110812.15825-3-shawn.guo@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/11/18 4:38 PM, Shawn Guo wrote:
> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/phy/qualcomm/Kconfig                  |  10 +
>  drivers/phy/qualcomm/Makefile                 |   1 +
>  .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 535 ++++++++++++++++++
>  3 files changed, 546 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 32f7d34eb784..c7b5ee82895d 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -82,3 +82,13 @@ config PHY_QCOM_USB_HSIC
>  	select GENERIC_PHY
>  	help
>  	  Support for the USB HSIC ULPI compliant PHY on QCOM chipsets.
> +
> +config PHY_QCOM_USB_HS_SNPS_28NM
> +	tristate "Qualcomm Synopsys 28nm USB HS PHY driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support the Synopsys 28nm Femto USB PHY on Qualcomm
> +	  chips. This driver supports the high-speed PHY which is usually
> +	  paired with either the ChipIdea or Synopsys DWC3 USB IPs on MSM SOCs.
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index c56efd3af205..dc238d95b18c 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_PHY_QCOM_UFS_14NM)		+= phy-qcom-ufs-qmp-14nm.o
>  obj-$(CONFIG_PHY_QCOM_UFS_20NM)		+= phy-qcom-ufs-qmp-20nm.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
>  obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
> +obj-$(CONFIG_PHY_QCOM_USB_HS_SNPS_28NM)	+= phy-qcom-usb-hs-snsp-28nm.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c b/drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c
> new file mode 100644
> index 000000000000..ee52bb6df6da
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c
> @@ -0,0 +1,535 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2009-2018, Linux Foundation. All rights reserved.
> + * Copyright (c) 2018, Linaro Limited
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/extcon.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
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
> +	void __iomem *base;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +	struct reset_control *phy_reset;
> +	struct reset_control *por_reset;
> +	struct regulator_bulk_data vregs[VREG_NUM];
> +	unsigned int voltages[VREG_NUM][VOL_NUM];
> +	const struct hsphy_data *data;
> +	bool cable_connected;
> +	struct extcon_dev *vbus_edev;
> +	struct notifier_block vbus_notify;
> +	enum phy_mode mode;
> +};
> +
> +static int qcom_snps_hsphy_config_regulators(struct hsphy_priv *priv, int high)
> +{
> +	int old_uV[VREG_NUM];
> +	int min, ret, i;
> +
> +	min = high ? 1 : 0; /* low or none? */
> +
> +	for (i = 0; i < VREG_NUM; i++) {
> +		old_uV[i] = regulator_get_voltage(priv->vregs[i].consumer);
> +		ret = regulator_set_voltage(priv->vregs[i].consumer,
> +					    priv->voltages[i][min],
> +					    priv->voltages[i][VOL_MAX]);
> +		if (ret)
> +			goto roll_back;
> +	}
> +
> +	return 0;
> +
> +roll_back:
> +	for (; i >= 0; i--)
> +		regulator_set_voltage(priv->vregs[i].consumer,
> +				      old_uV[i], old_uV[i]);
> +	return ret;
> +}
> +
> +static int qcom_snps_hsphy_enable_regulators(struct hsphy_priv *priv)
> +{
> +	int ret;
> +
> +	ret = qcom_snps_hsphy_config_regulators(priv, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_set_load(priv->vregs[VDDA_1P8].consumer, 19000);
> +	if (ret < 0)
> +		goto unconfig_regulators;
> +
> +	ret = regulator_set_load(priv->vregs[VDDA_3P3].consumer, 16000);
> +	if (ret < 0)
> +		goto unset_1p8_load;
> +
> +	ret = regulator_bulk_enable(VREG_NUM, priv->vregs);
> +	if (ret)
> +		goto unset_3p3_load;
> +
> +	return 0;
> +
> +unset_3p3_load:
> +	regulator_set_load(priv->vregs[VDDA_3P3].consumer, 0);
> +unset_1p8_load:
> +	regulator_set_load(priv->vregs[VDDA_1P8].consumer, 0);
> +unconfig_regulators:
> +	qcom_snps_hsphy_config_regulators(priv, 0);
> +	return ret;
> +}
> +
> +static void qcom_snps_hsphy_disable_regulators(struct hsphy_priv *priv)
> +{
> +	regulator_bulk_disable(VREG_NUM, priv->vregs);
> +	regulator_set_load(priv->vregs[VDDA_1P8].consumer, 0);
> +	regulator_set_load(priv->vregs[VDDA_3P3].consumer, 0);
> +	qcom_snps_hsphy_config_regulators(priv, 0);
> +}
> +
> +static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode)
> +{
> +	struct hsphy_priv *priv = phy_get_drvdata(phy);
> +
> +	priv->mode = mode;
> +
> +	return 0;
> +}
> +
> +static void qcom_snps_hsphy_enable_hv_interrupts(struct hsphy_priv *priv)
> +{
> +	u32 val;
> +
> +	/* Clear any existing interrupts before enabling the interrupts */
> +	val = readb(priv->base + PHY_INTR_CLEAR0);
> +	val |= DPDM_MASK;
> +	writeb(val, priv->base + PHY_INTR_CLEAR0);
> +
> +	writeb(0x0, priv->base + PHY_IRQ_CMD);
> +	usleep_range(200, 220);
> +	writeb(0x1, priv->base + PHY_IRQ_CMD);
> +
> +	/* Make sure the interrupts are cleared */
> +	usleep_range(200, 220);
> +
> +	val = readb(priv->base + PHY_INTR_MASK0);
> +	switch (priv->mode) {
> +	case PHY_MODE_USB_HOST_HS:
> +	case PHY_MODE_USB_HOST_FS:
> +	case PHY_MODE_USB_DEVICE_HS:
> +	case PHY_MODE_USB_DEVICE_FS:
> +		val |= DP_1_0 | DM_0_1;
> +		break;
> +	case PHY_MODE_USB_HOST_LS:
> +	case PHY_MODE_USB_DEVICE_LS:
> +		val |= DP_0_1 | DM_1_0;
> +		break;
> +	default:
> +		/* No device connected */
> +		val |= DP_0_1 | DM_0_1;
> +		break;
> +	}
> +	writeb(val, priv->base + PHY_INTR_MASK0);
> +}
> +
> +static void qcom_snps_hsphy_disable_hv_interrupts(struct hsphy_priv *priv)
> +{
> +	u32 val;
> +
> +	val = readb(priv->base + PHY_INTR_MASK0);
> +	val &= ~DPDM_MASK;
> +	writeb(val, priv->base + PHY_INTR_MASK0);
> +
> +	/* Clear any pending interrupts */
> +	val = readb(priv->base + PHY_INTR_CLEAR0);
> +	val |= DPDM_MASK;
> +	writeb(val, priv->base + PHY_INTR_CLEAR0);
> +
> +	writeb(0x0, priv->base + PHY_IRQ_CMD);
> +	usleep_range(200, 220);
> +
> +	writeb(0x1, priv->base + PHY_IRQ_CMD);
> +	usleep_range(200, 220);
> +}
> +
> +static void qcom_snps_hsphy_enter_retention(struct hsphy_priv *priv)
> +{
> +	u32 val;
> +
> +	val = readb(priv->base + PHY_CTRL_COMMON0);
> +	val |= SIDDQ;
> +	writeb(val, priv->base + PHY_CTRL_COMMON0);
> +}
> +
> +static void qcom_snps_hsphy_exit_retention(struct hsphy_priv *priv)
> +{
> +	u32 val;
> +
> +	val = readb(priv->base + PHY_CTRL_COMMON0);
> +	val &= ~SIDDQ;
> +	writeb(val, priv->base + PHY_CTRL_COMMON0);
> +}
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
> +{
> +	struct hsphy_priv *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	if (priv->cable_connected) {
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
> +static int qcom_snps_hsphy_reset(struct hsphy_priv *priv)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(priv->phy_reset);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(10, 15);
> +
> +	ret = reset_control_deassert(priv->phy_reset);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(80, 100);
> +
> +	return 0;
> +}
> +
> +static void qcom_snps_hsphy_init_sequence(struct hsphy_priv *priv)
> +{
> +	const struct hsphy_data *data = priv->data;
> +	const struct hsphy_init_seq *seq;
> +	int i;
> +
> +	/* Device match data is optional. */
> +	if (!data)
> +		return;
> +
> +	seq = data->init_seq;
> +
> +	for (i = 0; i < data->init_seq_num; i++, seq++) {
> +		writeb(seq->val, priv->base + seq->offset);
> +		if (seq->delay)
> +			usleep_range(seq->delay, seq->delay + 10);
> +	}
> +
> +	/* Ensure that the above parameter overrides is successful. */
> +	mb();
> +}
> +
> +static int qcom_snps_hsphy_por_reset(struct hsphy_priv *priv)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(priv->por_reset);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The Femto PHY is POR reset in the following scenarios.
> +	 *
> +	 * 1. After overriding the parameter registers.
> +	 * 2. Low power mode exit from PHY retention.
> +	 *
> +	 * Ensure that SIDDQ is cleared before bringing the PHY
> +	 * out of reset.
> +	 */
> +	qcom_snps_hsphy_exit_retention(priv);
> +
> +	/*
> +	 * As per databook, 10 usec delay is required between
> +	 * PHY POR assert and de-assert.
> +	 */
> +	usleep_range(10, 20);
> +	ret = reset_control_deassert(priv->por_reset);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * As per databook, it takes 75 usec for PHY to stabilize
> +	 * after the reset.
> +	 */
> +	usleep_range(80, 100);
> +
> +	/* Ensure that RESET operation is completed. */
> +	mb();

How will you ensure the reset operation is complete with a memory barrier? mb
usage here looks incorrect to me.

Thanks
Kishon
