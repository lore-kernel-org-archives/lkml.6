Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E93C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FA3206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T0zlXYwy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T0zlXYwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FA3206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeIEOA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:00:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55952 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeIEOAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:00:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E46CB607DC; Wed,  5 Sep 2018 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536139892;
        bh=eFNrOSeUo0wo/852DMGryY0pNnSxnlg6nSI0IkRuiuU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T0zlXYwy14hrzs872zZXDqE7YXTaPoS8JPkZAdSssGSBU12BpHQ0PDOh3hBXc9pjT
         pJab6/VBGI6QE39LZZWRiX5lh4nNZziWGIGjirDphrqYOjmlpb+fLm3o5Ox2P5r/9y
         iFEc12/vShsD79IIYa9tB7G4/nAIEA7sUxbjhdKw=
Received: from [10.206.25.155] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BD26605BD;
        Wed,  5 Sep 2018 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536139892;
        bh=eFNrOSeUo0wo/852DMGryY0pNnSxnlg6nSI0IkRuiuU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T0zlXYwy14hrzs872zZXDqE7YXTaPoS8JPkZAdSssGSBU12BpHQ0PDOh3hBXc9pjT
         pJab6/VBGI6QE39LZZWRiX5lh4nNZziWGIGjirDphrqYOjmlpb+fLm3o5Ox2P5r/9y
         iFEc12/vShsD79IIYa9tB7G4/nAIEA7sUxbjhdKw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BD26605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v2 2/2] Embedded USB Debugger (EUD) driver
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, rnayak@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
References: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
 <1536096853-30473-3-git-send-email-pheragu@codeaurora.org>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <c68c466a-576f-43d9-a7dd-7ee8e0ebba3f@codeaurora.org>
Date:   Wed, 5 Sep 2018 15:01:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536096853-30473-3-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 9/5/2018 3:04 AM, Prakruthi Deepak Heragu wrote:
> Add support for control peripheral of EUD (Embedded USB Debugger) to
> listen to events such as USB attach/detach, charger enable/disable, pet
> EUD to indicate software is functional.
>
> Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> ---
>  drivers/soc/qcom/Kconfig  |  12 ++
>  drivers/soc/qcom/Makefile |   1 +
>  drivers/soc/qcom/eud.c    | 338 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 351 insertions(+)
>  create mode 100644 drivers/soc/qcom/eud.c
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
[snip]
> +
> +#define EUD_ENABLE_CMD 1
> +#define EUD_DISABLE_CMD 0

Why not use module param as boolean? I mean zero to disable and non-zero to enable?
> +
> +#define EUD_REG_INT1_EN_MASK	0x0024
> +#define EUD_REG_INT_STATUS_1	0x0044
> +#define EUD_REG_CTL_OUT_1	0x0074
> +#define EUD_REG_VBUS_INT_CLR	0x0080
> +#define EUD_REG_CHGR_INT_CLR	0x0084
> +#define EUD_REG_CSR_EUD_EN	0x1014
> +#define EUD_REG_SW_ATTACH_DET	0x1018
> +
> +#define EUD_INT_VBUS		BIT(2)
> +#define EUD_INT_CHGR		BIT(3)
> +#define EUD_INT_SAFE_MODE	BIT(4)
> +
> +struct eud_chip {
> +	struct device			*dev;
> +	int				eud_irq;
> +	unsigned int			extcon_id;
> +	unsigned int			int_status;
> +	bool				usb_attach;
> +	bool				chgr_enable;
> +	void __iomem			*eud_reg_base;
> +	struct extcon_dev		*extcon;
> +	struct work_struct		eud_work;
> +};
> +
> +static const unsigned int eud_extcon_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_CHG_USB_SDP,
> +	EXTCON_NONE,
> +};
> +
> +/*
> + * On the kernel command line specify eud.enable=1 to enable EUD.
> + * EUD is disabled by default.
> + */
> +static int enable;
> +static bool eud_ready;
> +static struct eud_chip *eud_private;
> +
> +static void enable_eud(struct eud_chip *priv)
> +{
> +	struct power_supply *usb_psy = NULL;
> +	union power_supply_propval pval = {0};
> +	union power_supply_propval tval = {0};
> +	int ret;
> +
> +	usb_psy = power_supply_get_by_name("usb");
> +	if (!usb_psy)
> +		return;
> +
> +	ret = power_supply_get_property(usb_psy,
> +			POWER_SUPPLY_PROP_PRESENT, &pval);
> +	if (ret)
> +		return;
> +
> +	ret = power_supply_get_property(usb_psy,
> +			POWER_SUPPLY_PROP_REAL_TYPE, &tval);
> +	if (ret)
> +		return;
> +

	if(!pval.intval || (tval.intval != POWER_SUPPLY_TYPE_USB &&
	    tval.intval != POWER_SUPPLY_TYPE_USB_CDP))
 		return;

	/* following if-else can be removed */
 

> +	if (pval.intval && (tval.intval == POWER_SUPPLY_TYPE_USB ||
> +	    tval.intval == POWER_SUPPLY_TYPE_USB_CDP)) {
> +		/* write into CSR to enable EUD */
> +		writel_relaxed(BIT(0), priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
> +		/* Enable vbus, chgr & safe mode warning interrupts */
> +		writel_relaxed(EUD_INT_VBUS | EUD_INT_CHGR | EUD_INT_SAFE_MODE,
> +				priv->eud_reg_base + EUD_REG_INT1_EN_MASK);
> +
> +		/* Ensure Register Writes Complete */
> +		wmb();
> +
> +		/*
> +		 * Set the default cable state to usb connect and charger
> +		 * enable
> +		 */
> +		ret = extcon_set_state_sync(priv->extcon, EXTCON_USB, true);
> +		if (ret)
> +			return;
> +		ret = extcon_set_state_sync(priv->extcon,
> +				EXTCON_CHG_USB_SDP, true);
> +		if (ret)
> +			return;
> +	} else {
> +		return;
> +	}
> +
> +}
> +
> +static void disable_eud(struct eud_chip *priv)
> +{
> +	/* write into CSR to disable EUD */
> +	writel_relaxed(0, priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
> +}
> +
> +static int param_eud_set(const char *val, const struct kernel_param *kp)
> +{
> +	int enable = 0;
> +
> +	if (sscanf(val, "%du", &enable) != 1)
> +		return -EINVAL;
> +
> +	if (enable != EUD_ENABLE_CMD && enable != EUD_DISABLE_CMD)
> +		return -EINVAL;
Do we really need to worry about it? 'enable' could just be treated as bool

[snip]
> +
> +
> +static irqreturn_t handle_eud_irq(int irq, void *data)
> +{
> +	struct eud_chip *chip = data;
> +	u32 reg;
> +
> +	/* read status register and find out which interrupt triggered */
> +	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_INT_STATUS_1);
> +	if (reg & EUD_INT_VBUS) {
> +		chip->int_status = EUD_INT_VBUS;
> +		usb_attach_detach(chip);
> +	} else if (reg & EUD_INT_CHGR) {
> +		chip->int_status = EUD_INT_CHGR;
> +		chgr_enable_disable(chip);
> +	} else if (reg & EUD_INT_SAFE_MODE) {
> +		pet_eud(chip);
> +	} else {
> +		return IRQ_NONE;
> +	}

switch-case instead?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int msm_eud_probe(struct platform_device *pdev)
> +{
> +	struct eud_chip *chip;
> +	struct resource *res;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip) {
> +		ret = -ENOMEM;
> +		return ret;
return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	chip->extcon = devm_extcon_dev_allocate(&pdev->dev, eud_extcon_cable);
> +	if (IS_ERR(chip->extcon))
> +		return PTR_ERR(chip->extcon);
> +
> +	ret = devm_extcon_dev_register(&pdev->dev, chip->extcon);
> +	if (ret)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -ENOMEM;
> +		return ret;
same here
> +	}
> +
> +	chip->eud_reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(chip->eud_reg_base))
> +		return PTR_ERR(chip->eud_reg_base);
> +
> +	chip->eud_irq = platform_get_irq(pdev, 0);
> +
> +	ret = devm_request_irq(&pdev->dev, chip->eud_irq, handle_eud_irq,
> +				IRQF_TRIGGER_HIGH, NULL, chip);
> +	if (ret)
> +		return ret;
> +
> +	device_init_wakeup(&pdev->dev, true);
> +	enable_irq_wake(chip->eud_irq);
> +
> +	INIT_WORK(&chip->eud_work, eud_event_notifier);
> +
> +	eud_private = chip;
> +	eud_ready = true;
> +
> +	/* Enable EUD */
> +	if (enable)
> +		enable_eud(eud_private);
> +
> +	return 0;
> +}
> +
> +static int msm_eud_remove(struct platform_device *pdev)
> +{
> +	struct eud_chip *chip = platform_get_drvdata(pdev);
> +
> +	if (enable)
> +		disable_eud(eud_private);
> +	device_init_wakeup(&pdev->dev, false);
> +	disable_irq_wake(chip->eud_irq);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id msm_eud_dt_match[] = {
> +	{.compatible = "qcom,msm-eud"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, msm_eud_dt_match);
> +
> +static struct platform_driver msm_eud_driver = {
> +	.probe		= msm_eud_probe,
> +	.remove		= msm_eud_remove,
> +	.driver		= {
> +		.name		= "msm-eud",
> +		.of_match_table = msm_eud_dt_match,
> +	},
> +};
> +module_platform_driver(msm_eud_driver);
> +
> +MODULE_DESCRIPTION("QTI EUD driver");
> +MODULE_LICENSE("GPL v2");

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

