Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB510C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8911020883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8911020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeKQHRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:17:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41106 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQHRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:17:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAGL0bQi022582;
        Fri, 16 Nov 2018 15:00:37 -0600
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAGL0bWO119436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 15:00:37 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 16
 Nov 2018 15:00:37 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 16 Nov 2018 15:00:37 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAGL0bSO005663;
        Fri, 16 Nov 2018 15:00:37 -0600
Subject: Re: [PATCH v2 3/5] phy: ocelot-serdes: convert to use eth phy mode
 and submode
To:     Quentin Schulz <quentin.schulz@bootlin.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-4-grygorii.strashko@ti.com>
 <20181116111530.iqqcchtcnmlssvdp@qschulz>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <1470a95d-7923-737f-6fcd-80e97a5c05f9@ti.com>
Date:   Fri, 16 Nov 2018 15:00:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116111530.iqqcchtcnmlssvdp@qschulz>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/18 5:15 AM, Quentin Schulz wrote:
> Hi Grygorii,
> 
> On Fri, Nov 09, 2018 at 05:47:53PM -0600, Grygorii Strashko wrote:
>> Convert ocelot-serdes PHY driver to use recently introduced
>> PHY_MODE_ETHERNET and phy_set_mode_ext().
>>
> 
> Thanks for the patch, it's annoying to have to map PHY_MODE_SGMII and
> PHY_INTERFACE_MODE_SGMII :)
> 
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/net/ethernet/mscc/ocelot.c   |  9 ++-------
>>   drivers/phy/mscc/phy-ocelot-serdes.c | 14 ++++++++++----
>>   2 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
>> index 3238b9e..3edb608 100644
>> --- a/drivers/net/ethernet/mscc/ocelot.c
>> +++ b/drivers/net/ethernet/mscc/ocelot.c
>> @@ -472,7 +472,6 @@ static int ocelot_port_open(struct net_device *dev)
>>   {
>>   	struct ocelot_port *port = netdev_priv(dev);
>>   	struct ocelot *ocelot = port->ocelot;
>> -	enum phy_mode phy_mode;
>>   	int err;
>>   
>>   	/* Enable receiving frames on the port, and activate auto-learning of
>> @@ -484,12 +483,8 @@ static int ocelot_port_open(struct net_device *dev)
>>   			 ANA_PORT_PORT_CFG, port->chip_port);
>>   
>>   	if (port->serdes) {
>> -		if (port->phy_mode == PHY_INTERFACE_MODE_SGMII)
>> -			phy_mode = PHY_MODE_SGMII;
>> -		else
>> -			phy_mode = PHY_MODE_QSGMII;
>> -
>> -		err = phy_set_mode(port->serdes, phy_mode);
>> +		err = phy_set_mode_ext(port->serdes, PHY_MODE_ETHERNET,
>> +				       port->phy_mode);
>>   		if (err) {
>>   			netdev_err(dev, "Could not set mode of SerDes\n");
>>   			return err;
>> diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
>> index c61a9890..f525a21 100644
>> --- a/drivers/phy/mscc/phy-ocelot-serdes.c
>> +++ b/drivers/phy/mscc/phy-ocelot-serdes.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/phy.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>> @@ -116,8 +117,10 @@ struct serdes_mux {
>>   	.mux = _mux,						\
>>   }
>>   
>> -#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m, c)
>> -#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, m, c)
>> +#define SERDES_MUX_SGMII(i, p, m, c) \
>> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_SGMII, m, c)
>> +#define SERDES_MUX_QSGMII(i, p, m, c) \
>> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_QSGMII, m, c)
>>   
>>   static const struct serdes_mux ocelot_serdes_muxes[] = {
>>   	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
>> @@ -164,12 +167,15 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>>   	unsigned int i;
>>   	int ret;
>>   
>> +	if (mode != PHY_MODE_ETHERNET)
>> +		return -EINVAL;
>> +
> 
> This works for now because we only support Ethernet muxes for now but
> this IP also supports PHY_MODE_PCIE.
> 
> It seems weird to me that the day we'll add support for PCIE muxing we
> will have in ocelot_serdes_muxes[i].mode either a PHY_INTERFACE_MODE_*
> or a PHY_MODE_PCIE. This is not an issue for now since you do the mode
> != PHY_MODE_ETHERNET just above but once we get rid of this, we only
> test for submode != ocelot_serdes_muxes[i].mode and both
> PHY_INTERFACE_MODE_1000BASEX and PHY_MODE_PCIE will have the same index
> thus might be confused.
> 
> Should we add a submode to the SERDES_MUX macro, move PHY_MODE_*MII to
> this submode and have PHY_MODE_ETHERNET/PCIE in the mode field?

Yeh. You are right. I'll update it this way.
I have no hw, so hope you will be able to help with review/testing.


-- 
regards,
-grygorii
