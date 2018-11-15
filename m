Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TrGiXYfJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXvxtQOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A7D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbeKPJTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:19:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54087 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbeKPJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:19:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D1008D05;
        Thu, 15 Nov 2018 18:09:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Nov 2018 18:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=xM9V38rM53e/sS1SPQJUdHkYid/
        XpLoGdNnXC3WB8Sc=; b=TrGiXYfJURBVNCVrjrbyNKMZ+CsbD729QWWcejQwxS3
        J9g1vV8OiGPq2XzGSUGtMyVrelEO+1I1YmjVJkHcaZp0JuGRTx5uutLY7sq0V7jF
        iLa63zKPFLoSFng8BGcJIZvj+jHIY7sIyKpTBlu7O+y/JG+ETvg4Ww7THJExPAvc
        59+6sMp4GFyhxqU+EhMpXYIoxPdwU/Ag2JjlE/8dt5dYNfo1+YsWMjdu2BlXEFvp
        w1WBcWk6bN7TXlKx+wsDXjyo9TY9LjgHJ1v26EwLXmrSUXhAH2O2pvW6kMh8f2S6
        NH9XBrTqPgJommMCz/7Ga5DFuNUxzWCGb1YjVnhdR5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xM9V38
        rM53e/sS1SPQJUdHkYid/XpLoGdNnXC3WB8Sc=; b=EXvxtQOlQ/O4gcOftzIH9V
        4kjIUeOsibrhzlxgonRhUaTHvT6cpdtHUd6IkoDEVFfgdy6QEbk4YUr/PrZ8RRGB
        zVcfSq20tzermedQnQmHFNE+0j+jKTThMXb/6dEvBpc7/peju3qkC+L8Y7n3SlNK
        AjiZoGjPK+xaaPxc7v60oGMxtfjEQ5E1E7r2zBNmF85zzh3Fw9cI18JJt/evgVCo
        kjoqXj2fA8Adh//Z3QOHi5121uQ6awhZJ0SxbQ1mI+cJOJRMrCIR97ZsGb0EEqtq
        bFczHmfWqT5wh69yDQv+3r/VONyi1nH7fqN3SRm/8xu/BdFKJwRDrpgVSrO4gH4A
        ==
X-ME-Sender: <xms:wPztWzTNWa4exXyqM9FpPNMvUfVTXM5jUIzBl2unWVaAIJJ1tmYqow>
X-ME-Proxy: <xmx:wPztW71Kmogl8jN9yA8O-BN0QYnoPbZ_BPSx9VsBMZiWHa2JZjU2mw>
    <xmx:wPztW5bOPLZriUCvozpIN_Csvdk-MVKgDr3TrsPX6VISxiPARccJVg>
    <xmx:wPztWy10D_SCTD2f2yaMmptgdse-pdqz1mfK40xo9wmngMtupuCxfQ>
    <xmx:wPztW8KqFQzFpPGIqEyXtXBYhm7ijhy6IO-B6WXxxQbtc5JIxiRrhg>
    <xmx:wPztW_KxstKmiqX4A9RdP2Bo0StrSv82D7SvkNmbqVYhjUaW1eUB_w>
    <xmx:wPztW0Onm79lrUw3Z519gsicHCv24Sj_LTBJ0KlkSkAyeUb6i8mKrQ>
Received: from localhost (unknown [64.114.255.97])
        by mail.messagingengine.com (Postfix) with ESMTPA id C1135102DD;
        Thu, 15 Nov 2018 18:09:51 -0500 (EST)
Date:   Thu, 15 Nov 2018 15:09:47 -0800
From:   Greg KH <greg@kroah.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: Re: [PATCH v3 2/2] Embedded USB Debugger (EUD) driver
Message-ID: <20181115230947.GC26568@kroah.com>
References: <1542310374-18474-1-git-send-email-pheragu@codeaurora.org>
 <1542310374-18474-3-git-send-email-pheragu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542310374-18474-3-git-send-email-pheragu@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:32:54AM -0800, Prakruthi Deepak Heragu wrote:
> +struct device_attribute eud_attribute = {
> +	.attr.name = "enable",
> +	.attr.mode = 0644,
> +	.show = eud_enable_show,
> +	.store = eud_enable_store,
> +};

Please use:
	static DEVICE_ATTR_RW(enable);
instead of open-coding all of that mess.

Also it makes it static, this should not be a global symbol.

> +
> +static void eud_event_notifier(struct work_struct *eud_work)
> +{
> +	struct eud_chip *chip = container_of(eud_work, struct eud_chip,
> +					eud_work);
> +	int ret;
> +
> +	if (chip->int_status == EUD_INT_VBUS) {
> +		ret = extcon_set_state_sync(chip->extcon, chip->extcon_id,
> +					chip->usb_attach);
> +		if (ret)
> +			return;
> +	} else if (chip->int_status == EUD_INT_CHGR) {
> +		ret = extcon_set_state_sync(chip->extcon, chip->extcon_id,
> +					chip->chgr_enable);
> +		if (ret)
> +			return;
> +	}
> +}
> +
> +static void usb_attach_detach(struct eud_chip *chip)
> +{
> +	u32 reg;
> +
> +	chip->extcon_id = EXTCON_USB;
> +	/* read ctl_out_1[4] to find USB attach or detach event */
> +	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_CTL_OUT_1);
> +	if (reg & BIT(4))
> +		chip->usb_attach = true;
> +	else
> +		chip->usb_attach = false;
> +
> +	schedule_work(&chip->eud_work);
> +
> +	/* set and clear vbus_int_clr[0] to clear interrupt */
> +	writel_relaxed(BIT(0), chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
> +	/* Ensure Register Writes Complete */
> +	wmb();
> +	writel_relaxed(0, chip->eud_reg_base + EUD_REG_VBUS_INT_CLR);
> +}
> +
> +static void chgr_enable_disable(struct eud_chip *chip)
> +{
> +	u32 reg;
> +
> +	chip->extcon_id = EXTCON_CHG_USB_SDP;
> +	/* read ctl_out_1[6] to find charger enable or disable event */
> +	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_CTL_OUT_1);
> +	if (reg & BIT(6))
> +		chip->chgr_enable = true;
> +	else
> +		chip->chgr_enable = false;
> +
> +	schedule_work(&chip->eud_work);
> +
> +	/* set and clear chgr_int_clr[0] to clear interrupt */
> +	writel_relaxed(BIT(0), chip->eud_reg_base + EUD_REG_CHGR_INT_CLR);
> +	/* Ensure Register Writes Complete */
> +	wmb();
> +	writel_relaxed(0, chip->eud_reg_base + EUD_REG_CHGR_INT_CLR);
> +}
> +
> +static void pet_eud(struct eud_chip *chip)
> +{
> +	u32 reg;
> +
> +	/* read sw_attach_det[0] to find attach/detach event */
> +	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_SW_ATTACH_DET);
> +	if (reg & BIT(0)) {
> +		/* Detach & Attach pet for EUD */
> +		writel_relaxed(0, chip->eud_reg_base + EUD_REG_SW_ATTACH_DET);
> +		/* Ensure Register Writes Complete */
> +		wmb();
> +		/* Delay to make sure detach pet is done before attach pet */
> +		udelay(100);
> +		writel_relaxed(BIT(0), chip->eud_reg_base +
> +					EUD_REG_SW_ATTACH_DET);
> +		/* Ensure Register Writes Complete */
> +		wmb();
> +	} else {
> +		/* Attach pet for EUD */
> +		writel_relaxed(BIT(0), chip->eud_reg_base +
> +					EUD_REG_SW_ATTACH_DET);
> +		/* Ensure Register Writes Complete */
> +		wmb();
> +	}
> +}
> +
> +static irqreturn_t handle_eud_irq(int irq, void *data)
> +{
> +	struct eud_chip *chip = data;
> +	u32 reg;
> +
> +	/* read status register and find out which interrupt triggered */
> +	reg = readl_relaxed(chip->eud_reg_base + EUD_REG_INT_STATUS_1);
> +	switch (reg & EUD_INT_ALL) {
> +	case EUD_INT_VBUS:
> +		chip->int_status = EUD_INT_VBUS;
> +		usb_attach_detach(chip);
> +		break;
> +	case EUD_INT_CHGR:
> +		chip->int_status = EUD_INT_CHGR;
> +		chgr_enable_disable(chip);
> +		break;
> +	case EUD_INT_SAFE_MODE:
> +		pet_eud(chip);
> +		break;
> +	default:
> +		return IRQ_NONE;
> +	}
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
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, chip);
> +
> +	ret = device_create_file(&pdev->dev, &eud_attribute);
> +	if (ret)
> +		return ret;

You just raced with userspace and lost :(

Isn't there a way to add the attribute to the platform device as a group
to have it correctly added by the driver core?

Also, you are adding an attribute to a structure that you do not
control/own, are you _sure_ you want to do that?  It's a bit odd and you
don't really control the lifetime of that device.


> +
> +	chip->extcon = devm_extcon_dev_allocate(&pdev->dev, eud_extcon_cable);
> +	if (IS_ERR(chip->extcon))
> +		return PTR_ERR(chip->extcon);

As an example of this problem, the sysfs file is now there if this was
an error.  Yet that sysfs file now means nothing and if userspace
touches it bad things will happen.

So please at the very least, properly clean up your error paths.  And
look into doing this correctly.

thanks,

greg k-h
