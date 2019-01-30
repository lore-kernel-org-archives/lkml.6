Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD86DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7348420882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KgRZEIjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfA3Ml1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:41:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42084 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Ml1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:41:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0UCfPgs080630;
        Wed, 30 Jan 2019 06:41:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548852085;
        bh=lofmm7jT+pKbOaadjt6uqp2rkSP7e2v8SR9Lc/9xdlA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=KgRZEIjFB1BKIOR+EDnai7ACl1RgbdulaSc8ti6m8yJq1dvPU8ChJZjp6lEMAZddN
         R/99lhaVyfv8ZHNShEGHgCv61H1qj3h5DU0N/QQBtRHiclAvarKv0bOPO3OaxdLSPn
         srm4dy1BjcqDVFzGPMugBouHyR9I2eLbvzKnSgsg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0UCfP4v051579
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 06:41:25 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 30
 Jan 2019 06:41:23 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 30 Jan 2019 06:41:23 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0UCfMm6011473;
        Wed, 30 Jan 2019 06:41:23 -0600
Subject: Re: [PATCH] phy: ti-pipe3: Add set_mode callback to configure usb3
 phy as pcie phy
To:     Kishon Vijay Abraham I <kishon@ti.com>
References: <20190124104822.22411-1-kishon@ti.com> <5C5180FF.1050409@ti.com>
 <ae4f41cd-dbc8-8172-a9e9-28166fc881eb@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C519B72.7080502@ti.com>
Date:   Wed, 30 Jan 2019 14:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <ae4f41cd-dbc8-8172-a9e9-28166fc881eb@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 30/01/19 12:59, Kishon Vijay Abraham I wrote:
> Hi Roger,
> 
> On 30/01/19 4:18 PM, Roger Quadros wrote:
>> Hi Kishon,
>>
>> On 24/01/19 12:48, Kishon Vijay Abraham I wrote:
>>> DRA72 platform has the second instance of PHY shared between USB3
>>> controller and PCIe controller with default as USB3 controller.
>>> Since it is used with USB3 controller by default, it uses the
>>> compatible specific to USB (ti,omap-usb3).
>>>
>>> Populate set_mode callback so that the USB3 PHY can be configured
>>> to be used with PCIe controller.
>>
>> What is the use case of this? At what point and who decides the
>> phy_set_mode() to be called with USB vs PCIe?
> 
> The PHY by default is configured to be used with USB controller (That's why it
> has a compatible of ti,omap-usb3). However there is a special case where this
> PHY has to be used PCIe controller. So the set_mode() will help the PHY driver
> to configure the USB PHY to be used with PCIe controller.
> 
> This is not a shared PHY, so the PHY as such can be used only with USB or PCIe
> and is determined at designtime.

If type is defined at design time then the design using the PHY for PCIe shouldn't be
using "ti,omap-usb3" compatible. Right?

Maybe we should fix the DT? Which board/PHY is this about?

cheers,
-roger

>>
>>
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/phy/ti/phy-ti-pipe3.c | 66 ++++++++++++++++++++++++++++-------
>>>  1 file changed, 54 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
>>> index 68ce4a082b9b..8c98f366416d 100644
>>> --- a/drivers/phy/ti/phy-ti-pipe3.c
>>> +++ b/drivers/phy/ti/phy-ti-pipe3.c
>>> @@ -56,6 +56,12 @@
>>>  
>>>  #define SATA_PLL_SOFT_RESET	BIT(18)
>>>  
>>> +#define PHY_RX_ANA_PRGRAMMABILITY_REG	0xC
>>> +#define MEM_EN_PLLBYP			BIT(7)
>>> +
>>> +#define PHY_TX_TEST_CONFIG		0x2C
>>> +#define MEM_ENTESTCLK			BIT(31)
>>> +
>>>  #define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	0x003FC000
>>>  #define PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT	14
>>>  
>>> @@ -110,6 +116,8 @@
>>>  #define PLL_IDLE_TIME	100	/* in milliseconds */
>>>  #define PLL_LOCK_TIME	100	/* in milliseconds */
>>>  
>>> +#define PIPE3_PHY_DISABLE_SYNC_POWER	BIT(4)
>>> +
>>>  struct pipe3_dpll_params {
>>>  	u16	m;
>>>  	u8	n;
>>> @@ -141,6 +149,7 @@ struct ti_pipe3 {
>>>  	unsigned int		power_reg; /* power reg. index within syscon */
>>>  	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
>>>  	bool			sata_refclk_enabled;
>>> +	u32			mode;
>>>  };
>>>  
>>>  static struct pipe3_dpll_map dpll_map_usb[] = {
>>> @@ -233,7 +242,10 @@ static int ti_pipe3_power_on(struct phy *x)
>>>  	rate = rate / 1000000;
>>>  	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK |
>>>  		  OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
>>> -	val = PIPE3_PHY_TX_RX_POWERON << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
>>> +	val = PIPE3_PHY_TX_RX_POWERON;
>>> +	if (phy->mode == PHY_MODE_PCIE)
>>> +		val |= PIPE3_PHY_DISABLE_SYNC_POWER;
>>> +	val <<= PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
>>>  	val |= rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
>>>  
>>>  	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
>>> @@ -328,13 +340,11 @@ static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
>>>  	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_EQUALIZER, val);
>>>  }
>>>  
>>> -static int ti_pipe3_init(struct phy *x)
>>> +static int ti_pipe3_pcie_init(struct ti_pipe3 *phy)
>>>  {
>>> -	struct ti_pipe3 *phy = phy_get_drvdata(x);
>>> -	u32 val;
>>>  	int ret = 0;
>>> +	u32 val;
>>>  
>>> -	ti_pipe3_enable_clocks(phy);
>>>  	/*
>>>  	 * Set pcie_pcs register to 0x96 for proper functioning of phy
>>>  	 * as recommended in AM572x TRM SPRUHZ6, section 18.5.2.2, table
>>> @@ -353,10 +363,31 @@ static int ti_pipe3_init(struct phy *x)
>>>  			return ret;
>>>  
>>>  		ti_pipe3_calibrate(phy);
>>> -
>>> -		return 0;
>>> +	} else {
>>> +		val = ti_pipe3_readl(phy->phy_rx,
>>> +				     PHY_RX_ANA_PRGRAMMABILITY_REG);
>>> +		val |= MEM_EN_PLLBYP;
>>> +		ti_pipe3_writel(phy->phy_rx, PHY_RX_ANA_PRGRAMMABILITY_REG,
>>> +				val);
>>> +		val = ti_pipe3_readl(phy->phy_tx, PHY_TX_TEST_CONFIG);
>>> +		val |= MEM_ENTESTCLK;
>>> +		ti_pipe3_writel(phy->phy_tx, PHY_TX_TEST_CONFIG, val);
>>>  	}
>>>  
>>> +	return 0;
>>> +}
>>> +
>>> +static int ti_pipe3_init(struct phy *x)
>>> +{
>>> +	struct ti_pipe3 *phy = phy_get_drvdata(x);
>>> +	u32 val;
>>> +	int ret = 0;
>>> +
>>> +	ti_pipe3_enable_clocks(phy);
>>> +
>>> +	if (phy->mode == PHY_MODE_PCIE)
>>> +		return ti_pipe3_pcie_init(phy);
>>> +
>>>  	/* Bring it out of IDLE if it is IDLE */
>>>  	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
>>>  	if (val & PLL_IDLE) {
>>> @@ -395,7 +426,7 @@ static int ti_pipe3_exit(struct phy *x)
>>>  		return 0;
>>>  
>>>  	/* PCIe doesn't have internal DPLL */
>>> -	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
>>> +	if (!(phy->mode == PHY_MODE_PCIE)) {
>>>  		/* Put DPLL in IDLE mode */
>>>  		val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
>>>  		val |= PLL_IDLE;
>>> @@ -429,11 +460,25 @@ static int ti_pipe3_exit(struct phy *x)
>>>  
>>>  	return 0;
>>>  }
>>> +
>>> +static int ti_pipe3_set_mode(struct phy *x, enum phy_mode mode, int submode)
>>> +{
>>> +	struct ti_pipe3 *phy = phy_get_drvdata(x);
>>> +
>>> +	if (phy->mode != PHY_MODE_INVALID)
>>> +		return -EBUSY;
>>> +
>>> +	phy->mode = mode;
>>
>> You are only saving the mode. But not really switching modes here.
>> How is this intended to work?
> 
> The PHY doesn't have a specific mode. Rather it is a set of configurations
> required to operate in a particular mode.
> 
> This mode value will be used in other init, power_on callback functions.
> 
> Thanks
> Kishon
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
