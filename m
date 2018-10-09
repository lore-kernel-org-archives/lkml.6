Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A907FC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69605214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AYwNFmZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69605214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJJDlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:41:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35756 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeJJDlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:41:10 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w99KMGck101255;
        Tue, 9 Oct 2018 15:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539116536;
        bh=n5GdI/ZU2dAF5LHi/tq5HWRsVJ2H1dIyFAdmv3aUU0Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AYwNFmZaG/aW9DvtS1fD7N03UaynmJ71QJKQ1tphAGb4cDkFeFI3zQm7YHgQpcrbk
         /Y1KYSLwRB/AHXDcGt5dFjXTFKjfpxTZUMlAjJ2mDayNoWwg6oxcRxQaIwUxQQ2GSi
         M4FnKQO5tRL5En9+TIE+2MG2+ew0LILAz3nRgno8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99KMGDV027213;
        Tue, 9 Oct 2018 15:22:16 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 15:22:15 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 15:22:15 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99KMFak024443;
        Tue, 9 Oct 2018 15:22:15 -0500
Subject: Re: [RFC PATCH 03/11] phy: ti: introduce phy-gmii-sel driver
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-4-grygorii.strashko@ti.com>
 <20181009003935.GA23588@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <cf3aba04-fad9-ad1d-1b51-1b6dbbd4ba5d@ti.com>
Date:   Tue, 9 Oct 2018 15:22:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009003935.GA23588@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 10/08/2018 07:39 PM, Andrew Lunn wrote:
> On Mon, Oct 08, 2018 at 06:49:41PM -0500, Grygorii Strashko wrote:
>> +static int phy_gmii_sel_mode(struct phy *phy, phy_interface_t intf_mode)
>> +{
>> +	struct phy_gmii_sel_phy_priv *if_phy = phy_get_drvdata(phy);
>> +	const struct phy_gmii_sel_soc_data *soc_data = if_phy->priv->soc_data;
>> +	struct device *dev = if_phy->priv->dev;
>> +	struct regmap_field *regfield;
>> +	int ret, rgmii_id = 0;
>> +	u32 mode = 0;
>> +
>> +	if_phy->phy_if_mode = intf_mode;
>> +
>> +	switch (if_phy->phy_if_mode) {
>> +	case PHY_INTERFACE_MODE_RMII:
>> +		mode = AM33XX_GMII_SEL_MODE_RMII;
>> +		break;
>> +
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +		mode = AM33XX_GMII_SEL_MODE_RGMII;
>> +		break;
>> +
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		mode = AM33XX_GMII_SEL_MODE_RGMII;
>> +		rgmii_id = 1;
>> +		break;
> 
> Hi Grygorii
> 
> It looks like the MAC can do AM33XX_GMII_SEL_MODE_RGMII and
> AM33XX_GMII_SEL_MODE_RGMII_ID. I don't think it can do
> AM33XX_GMII_SEL_MODE_RGMII_RXID or AM33XX_GMII_SEL_MODE_RGMII_TXID?

Sry, but would prefer not to thought this logic as part of this series as i moved it here
unchanged rom cpsw-phy-sel.c (except adding possibility to update only supported field)
and any changes here would require separate review (including all existing TI DT boards)
and testing.

  I
> would prefer it return -EINVAL when asked to do something it cannot
> do.

Just to clarify rgmii_id = 1 means *disable* CPSW Internal Delay Mode.
> 
>> +
>> +	default:
>> +		dev_warn(dev,
>> +			 "port%u: unsupported mode: \"%s\". Defaulting to MII.\n",
>> +			 if_phy->id, phy_modes(rgmii_id));
>> +		/* fall through */
> 
> Returning -EINVAL would be better. Otherwise the DT might never get
> fixed.

ok

> 
>> +	case PHY_INTERFACE_MODE_MII:
>> +		mode = AM33XX_GMII_SEL_MODE_MII;
>> +		break;
>> +	};
>> +
>> +	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
>> +		__func__, if_phy->id, mode, rgmii_id,
>> +		if_phy->rmii_clock_external);
>> +
>> +	regfield = if_phy->fields[PHY_GMII_SEL_PORT_MODE];
>> +	ret = regmap_field_write(regfield, mode);
>> +
>> +	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE) &&
>> +	    if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE]) {
>> +		regfield = if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE];
>> +		ret |= regmap_field_write(regfield, rgmii_id);
>> +	}
>> +
>> +	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
>> +	    if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN]) {
>> +		regfield = if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN];
>> +		ret |= regmap_field_write(regfield,
>> +					  if_phy->rmii_clock_external);
>> +	}
>> +
>> +	if (ret) {
>> +		dev_err(dev, "port%u: set mode fail %d", if_phy->id, ret);
>> +		return -EIO;
>> +	}
> 
> I would prefer each write had its own error check. The fact you don't
> return ret means you know ret could be -EINVAL|-EOIO, making
> -EMORECOFFEE.

:) right, sry.

-- 
regards,
-grygorii
