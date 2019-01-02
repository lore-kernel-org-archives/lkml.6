Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0244C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3462075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+5gcIz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfABUiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:38:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39149 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfABUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:38:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so27244127edt.6;
        Wed, 02 Jan 2019 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ksNlgM86gDq6F6FlGm+NBT+PmvygF6GxCr3UTu+6ME4=;
        b=i+5gcIz9hL1WVvnjbO5n31cVWC3wltF53sKOm1rK6C4eXqpibvcrS84oO867+6dE16
         Wd479yRjsA2Z2x1KdiYq9TI/ZpcF7YJ7tjjHxCS/tcwYdQzBYHXlKPtIxiFmNd+PJr3N
         XlISZVEkcOhWn7sfkM3lOoZz8B1vloIr5NhZT0i96sfKoj8B35pqi/YhALpDMc0o0ioc
         udA3X2h/jVeGX3bDl/d1sG/9Q8OFaQvHet28SC/vTybb1DrvSxeA7b6Vj79HA5d/jAPZ
         BcCAJnJJnI3i3RmdZDNqXaBNb06ceMRAjkqBsXCREFVQgK1OmiyCnhIJ3HsqGZqQpeXt
         3cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ksNlgM86gDq6F6FlGm+NBT+PmvygF6GxCr3UTu+6ME4=;
        b=sdpz9DblIhz89QCx2cmQ9oPmvmjbmTwomQbMzFChWKpB5KzaF0ROBEZ21H/OePAkuo
         /hnCVgaySjIgjPub7grhlxjZgll6IMZ/eCl5cSjQ3DZ0w3wyBMAF2V1KfhVTr/a66OGv
         SzP92y2M20iYz/5i1ykk/ZolprMM1iV5utXEfWZuc0P5XghGpPoW96iPQDyO2cc8+478
         vVT8N2H6yU/r+H24swvIa1e1yjlH4amaqfq2qUSq+juIPG2IekOVEQZlmgwskD5byWwS
         FMbbt5ZJVuXfUKp95cShqDvMNO0uJRCeJtM1fsRB1j1bmHlrMsi52qmYQkxh2QW84Xba
         MYrw==
X-Gm-Message-State: AA+aEWb/rwUT4vvX3GjVekwnEgpm97fws2P1KupgYJaY2Cr+zQPQqU2h
        DlYShpWlpC3AISlsBAGRoig=
X-Google-Smtp-Source: AFSGD/W3f7/yPerEgBq1LOpUuTtCE7vlBInIxiDjkQpRR2vcSiexfF0TF3nNnh9AxdGus/R6BaOHwA==
X-Received: by 2002:a17:906:41cc:: with SMTP id g12-v6mr33956265ejl.219.1546461491744;
        Wed, 02 Jan 2019 12:38:11 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id w10-v6sm9022083ejn.67.2019.01.02.12.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 12:38:10 -0800 (PST)
Subject: Re: [PATCH 2/2] reset: Add Broadcom STB SW_INIT reset controller
 driver
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-3-f.fainelli@gmail.com>
 <1546425895.3457.1.camel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <7387643e-b22e-fe25-08e9-1f641f8b306a@gmail.com>
Date:   Wed, 2 Jan 2019 12:38:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546425895.3457.1.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 1/2/19 2:44 AM, Philipp Zabel wrote:
> Hi Florian,
> 
> On Thu, 2018-12-20 at 17:34 -0800, Florian Fainelli wrote:
>> Add support for resetting blocks through the Linux reset controller
>> subsystem when reset lines are provided through a SW_INIT-style reset
>> controller on Broadcom STB SoCs.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Thank you, this looks mostly good to me. I just have a few small
> nitpicks and I'm curious about the mdelays, see below.

Thanks, answers inline.

[snip]

>> +struct brcmstb_reset {
>> +	void __iomem *base;
> 
>> +	unsigned int n_words;
>> +	struct device *dev;
> 
> These two variables are not used anywhere.

Indeed, the first one should actually be added as a check to make sure
we have a correct resource size being passed, I will add that back in.

> 
>> +	struct reset_controller_dev rcdev;
>> +};
>> +
>> +#define SW_INIT_SET		0x00
>> +#define SW_INIT_CLEAR		0x04
>> +#define SW_INIT_STATUS		0x08
>> +
>> +#define SW_INIT_BIT(id)		BIT((id) & 0x1f)
>> +#define SW_INIT_BANK(id)	(id >> 5)
> 
> Checkpatch suggests to use ((id) >> 5) here.
> 
>> +
>> +#define SW_INIT_BANK_SIZE	0x18
>> +
>> +static inline
>> +struct brcmstb_reset *to_brcmstb(struct reset_controller_dev *rcdev)
>> +{
>> +	return container_of(rcdev, struct brcmstb_reset, rcdev);
>> +}
>> +
>> +static int brcmstb_reset_assert(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
>> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
>> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
>> +
>> +	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_SET);
>> +	msleep(10);
> 
> What is the purpose of the msleep(10)? Is it guaranteed that the writel
> takes effect before the msleep, or could it be lingering in some store
> buffer for (a part of) the duration? Also, checkpatch warns about this
> being < 20 ms. You could increase the delay or use usleep_range.

Good point, let me check what the real delay requirements are with the
design team, since I suspect they were just overly conservative in their
recommendations previously

> 
>> +	return 0;
>> +}
>> +
>> +static int brcmstb_reset_deassert(struct reset_controller_dev *rcdev,
>> +				  unsigned long id)
>> +{
>> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
>> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
>> +
>> +	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_CLEAR);
>> +	msleep(10);
> 
> Same as above, what has to be delayed for 10 ms after deasserting the
> reset? Is this the same for all reset lines handled by this controller?

AFAICT, all lines behave the same way, as per our SoCs reset architecture.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int brcmstb_reset_status(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
>> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
>> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
>> +
>> +	return readl_relaxed(priv->base + off + SW_INIT_STATUS);
> 
> Should this be
> 
> +	return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
> +	       SW_INIT_BANK(id);
> 
> i.e. do the SW_INIT_STATUS registers contain 32 status bits, one for
> each reset line?

Yes they do. The same bits are used for SET/CLEAR/STATUS so this should
be something along the lines of:

return readl_relaxed(priv->base + off + SW_INIT_STATUS) & BIT(id));

thanks for spotting that!

> 
>> +}
>> +
>> +static const struct reset_control_ops brcmstb_reset_ops = {
>> +	.assert	= brcmstb_reset_assert,
>> +	.deassert = brcmstb_reset_deassert,
>> +	.status = brcmstb_reset_status,
>> +};
>> +
>> +static int brcmstb_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct device *kdev = &pdev->dev;
>> +	struct brcmstb_reset *priv;
>> +	struct resource *res;
>> +
>> +	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	priv->base = devm_ioremap_resource(kdev, res);
>> +	if (IS_ERR(priv->base))
>> +		return PTR_ERR(priv->base);
>> +
>> +	dev_set_drvdata(kdev, priv);
>> +
>> +	priv->rcdev.owner = THIS_MODULE;
>> +	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
>> +	priv->rcdev.ops = &brcmstb_reset_ops;
>> +	priv->rcdev.of_node = kdev->of_node;
>> +	/* Use defaults: 1 cell and simple xlate function */
>> +	priv->dev = kdev;
> 
> priv->dev could be removed.

Indeed, I had sprinkled dev_*() messages during debug, which required
it, but this is no longer required indeed.
-- 
Florian
