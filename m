Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6603CECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA5A208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS9+c5CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA5A208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIPCkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:40:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45508 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:40:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so5913469pge.12;
        Sat, 15 Sep 2018 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XMu2m1H2zMLgqsogqLhqyOEalEuiPCB/PZdIYHF7Xus=;
        b=DS9+c5CKDLp4MLEfFQGhEs3Bp8mJLH4x/b9at8pe/Bp7m2gV6Eyfe2X/g7JfpoeHqx
         yUVePNzN6+ehAnVIdR7B6XTyaHJSo79OACj+7D9ht7PwwcbbBcrX2vvBPEVU3PY4aLjw
         u2ZTukM2KA1NTNYCCrCqDC+BtZUCYNH5+dLgm3uoaFMVbUNhrQnZ8t7P6dP1eIMSb/H7
         6Ftxt7zparKm4t00lGN5OIJKKkiWIMMianD2BNBo4yw3s8kltUAJLmu02w+UL2YwNMA/
         03vLsTA5VGStsle7xibDXoADZISQ8ntf2ngv3srz1AjUG0FJDcnQLWSlzxRPBh/n6AAC
         Zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMu2m1H2zMLgqsogqLhqyOEalEuiPCB/PZdIYHF7Xus=;
        b=MtRDd+ANmEZiEOON4AF3ir9rXpmRS7sfJTCXARGUcaGb3tgWdTW6toUqHn0ioRgW5Y
         WOfOXWAB4+jih2jFlS2tbeIaEOT/2+1rjefomtaP2EGxNN/o2HAkefV+PpCjEU3D+lny
         qT3UCxcjq1a6wVsiolA9i1RIn5fav8QRPB3/jmC/e8pyML5lEC9DFT07S3Len7Acyatf
         R1/lUVzUNcwLF4u7jfh47hzi1TsCLVdg/3h2+dqmnEL5/pKyqcHbmG9d1/9R0WNi4UCL
         stllsL/veMxWPe0fch+24EFG55tPrL1ndWxIrIrjfwWuzKspDSVsSNDVYaVa3aUGr3vt
         aPzw==
X-Gm-Message-State: APzg51DDurZyplo+tT0bvgskKpujg2DgBKfVvxjqDexyIqaSLg76X3Z6
        mjqL8oy8mo5a+/q6JNzqf9U=
X-Google-Smtp-Source: ANB0Vdb6mCdNwTVXOExkHpBzUEJdjw9fa+bT979gWaFrS7cnkFy1xyFYGEZRkxMBsCAmEOYXyQCACw==
X-Received: by 2002:a63:f501:: with SMTP id w1-v6mr17385231pgh.446.1537046428821;
        Sat, 15 Sep 2018 14:20:28 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id g7-v6sm13664462pfi.175.2018.09.15.14.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:20:27 -0700 (PDT)
Subject: Re: [PATCH net-next v3 10/11] phy: add driver for Microsemi Ocelot
 SerDes muxing
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <cde4ccafdbd948db7ccbb263dd5b1a803e63a83e.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1dc66b5d-e60e-dad2-eed9-e283de260dc3@gmail.com>
Date:   Sat, 15 Sep 2018 14:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cde4ccafdbd948db7ccbb263dd5b1a803e63a83e.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> The Microsemi Ocelot can mux SerDes lanes (aka macros) to different
> switch ports or even make it act as a PCIe interface.
> 
> This adds support for the muxing of the SerDes.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

[snip]

> +
> +struct serdes_macro {
> +	u8			idx;
> +	/* Not used when in QSGMII or PCIe mode */
> +	int			port;

u8 port to be consistent with the mux table?

[snip]

> +#define SERDES_MUX(_idx, _port, _mode, _mask, _mux) {	\
> +	.idx = _idx,						\
> +	.port = _port,						\
> +	.mode = _mode,						\
> +	.mask = _mask,						\
> +	.mux = _mux,						\
> +}
> +
> +static const struct serdes_mux ocelot_serdes_muxes[] = {
> +	SERDES_MUX(SERDES1G_0, 0, PHY_MODE_SGMII, 0, 0),
> +	SERDES_MUX(SERDES1G_1, 1, PHY_MODE_SGMII, HSIO_HW_CFG_DEV1G_5_MODE, 0),
> +	SERDES_MUX(SERDES1G_1, 5, PHY_MODE_SGMII, HSIO_HW_CFG_QSGMII_ENA |
> +		   HSIO_HW_CFG_DEV1G_5_MODE, HSIO_HW_CFG_DEV1G_5_MODE),

Why not go one step further and define a SERDES_MUX_SGMII() macro which
automatically resolves the correct bit definitions to use?

The current macro does not make this particularly easy to read :/

> +	SERDES_MUX(SERDES1G_2, 2, PHY_MODE_SGMII, HSIO_HW_CFG_DEV1G_4_MODE, 0),
> +	SERDES_MUX(SERDES1G_2, 4, PHY_MODE_SGMII, HSIO_HW_CFG_QSGMII_ENA |
> +		   HSIO_HW_CFG_DEV1G_4_MODE, HSIO_HW_CFG_DEV1G_4_MODE),
> +	SERDES_MUX(SERDES1G_3, 3, PHY_MODE_SGMII, HSIO_HW_CFG_DEV1G_6_MODE, 0),
> +	SERDES_MUX(SERDES1G_3, 6, PHY_MODE_SGMII, HSIO_HW_CFG_QSGMII_ENA |
> +		   HSIO_HW_CFG_DEV1G_6_MODE, HSIO_HW_CFG_DEV1G_6_MODE),
> +	SERDES_MUX(SERDES1G_4, 4, PHY_MODE_SGMII, HSIO_HW_CFG_QSGMII_ENA |
> +		   HSIO_HW_CFG_DEV1G_4_MODE | HSIO_HW_CFG_DEV1G_9_MODE, 0),
> +	SERDES_MUX(SERDES1G_4, 9, PHY_MODE_SGMII, HSIO_HW_CFG_DEV1G_4_MODE |
> +		   HSIO_HW_CFG_DEV1G_9_MODE, HSIO_HW_CFG_DEV1G_4_MODE |
> +		   HSIO_HW_CFG_DEV1G_9_MODE),
> +	SERDES_MUX(SERDES1G_5, 5, PHY_MODE_SGMII, HSIO_HW_CFG_QSGMII_ENA |
> +		   HSIO_HW_CFG_DEV1G_5_MODE | HSIO_HW_CFG_DEV2G5_10_MODE, 0),
> +	SERDES_MUX(SERDES1G_5, 10, PHY_MODE_SGMII, HSIO_HW_CFG_PCIE_ENA |
> +		   HSIO_HW_CFG_DEV1G_5_MODE | HSIO_HW_CFG_DEV2G5_10_MODE,
> +		   HSIO_HW_CFG_DEV1G_5_MODE | HSIO_HW_CFG_DEV2G5_10_MODE),
> +	SERDES_MUX(SERDES6G_0, 4, PHY_MODE_QSGMII, HSIO_HW_CFG_QSGMII_ENA,
> +		   HSIO_HW_CFG_QSGMII_ENA),
> +	SERDES_MUX(SERDES6G_0, 5, PHY_MODE_QSGMII, HSIO_HW_CFG_QSGMII_ENA,
> +		   HSIO_HW_CFG_QSGMII_ENA),
> +	SERDES_MUX(SERDES6G_0, 6, PHY_MODE_QSGMII, HSIO_HW_CFG_QSGMII_ENA,
> +		   HSIO_HW_CFG_QSGMII_ENA),
> +	SERDES_MUX(SERDES6G_0, 7, PHY_MODE_SGMII, HSIO_HW_CFG_QSGMII_ENA, 0),
> +	SERDES_MUX(SERDES6G_0, 7, PHY_MODE_QSGMII, HSIO_HW_CFG_QSGMII_ENA,
> +		   HSIO_HW_CFG_QSGMII_ENA),
> +	SERDES_MUX(SERDES6G_1, 8, PHY_MODE_SGMII, 0, 0),
> +	SERDES_MUX(SERDES6G_2, 10, PHY_MODE_SGMII, HSIO_HW_CFG_PCIE_ENA |
> +		   HSIO_HW_CFG_DEV2G5_10_MODE, 0),
> +	SERDES_MUX(SERDES6G_2, 10, PHY_MODE_PCIE, HSIO_HW_CFG_PCIE_ENA,
> +		   HSIO_HW_CFG_PCIE_ENA),
> +};
> +
> +static int serdes_set_mode(struct phy *phy, enum phy_mode mode)
> +{
> +	struct serdes_macro *macro = phy_get_drvdata(phy);
> +	int ret, i;

unsigned int i;

> +
> +	for (i = 0; i < ARRAY_SIZE(ocelot_serdes_muxes); i++) {
> +		if (macro->idx != ocelot_serdes_muxes[i].idx ||
> +		    mode != ocelot_serdes_muxes[i].mode)
> +			continue;
> +
> +		if (mode != PHY_MODE_QSGMII &&
> +		    macro->port != ocelot_serdes_muxes[i].port)
> +			continue;
> +
> +		ret = regmap_update_bits(macro->ctrl->regs, HSIO_HW_CFG,
> +					 ocelot_serdes_muxes[i].mask,
> +					 ocelot_serdes_muxes[i].mux);
> +		if (ret)
> +			return ret;
> +
> +		if (macro->idx < SERDES1G_MAX)
> +			return serdes_init_s1g(macro->ctrl->regs, macro->idx);
> +
> +		/* SERDES6G and PCIe not supported yet */
> +		return 0;

Would not returning -EOPNOTSUPP be more helpful rather than leaving the
PHY unconfigured (or did the bootloader somehow configure it before for us)?

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct phy_ops serdes_ops = {
> +	.set_mode	= serdes_set_mode,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct phy *serdes_simple_xlate(struct device *dev,
> +				       struct of_phandle_args *args)
> +{
> +	struct serdes_ctrl *ctrl = dev_get_drvdata(dev);
> +	int port, idx, i;

unsigned int port, idx, i;

[snip]


> +
> +static int serdes_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *provider;
> +	struct serdes_ctrl *ctrl;
> +	int i, ret;

unsigned int i;

> +
> +	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	ctrl->dev = &pdev->dev;
> +	ctrl->regs = syscon_node_to_regmap(pdev->dev.parent->of_node);
> +	if (!ctrl->regs)
> +		return -ENODEV;
> +
> +	for (i = 0; i <= SERDES_MAX; i++) {

Every other loop you have is using <, is this one off-by-one?
-- 
Florian
