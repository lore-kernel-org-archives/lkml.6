Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7C9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A6D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R+/tNlVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfAaLFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:05:07 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43408 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfAaLFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:05:06 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0VB541T101988;
        Thu, 31 Jan 2019 05:05:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548932704;
        bh=xifPl3PMD9iaqfZ5zziSvBtlSTBVkfB5YsJhnB1ycQs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R+/tNlVmFw1UGP+2ZKa7flhNhMrJ82D7sSJKmg2aZ92GbO1GBP33C2qliEYWsgVI4
         7/Tu1CF/mYtYcpQmFDgydrxfzq5uc37sFzW08Lg/UMGe4EX9Qs5moRTF+ySQ+d1Gsk
         yt4bwW4FfxwXjStGmVIQMV7Xkudd+Qr42qMIkh8Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0VB51v8021092
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 05:05:04 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 31
 Jan 2019 05:05:03 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 31 Jan 2019 05:05:03 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0VB51lM029522;
        Thu, 31 Jan 2019 05:05:02 -0600
Subject: Re: [PATCH] phy: ti-pipe3: Add set_mode callback to configure usb3
 phy as pcie phy
To:     Roger Quadros <rogerq@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20190124104822.22411-1-kishon@ti.com> <5C51BBAD.3090304@ti.com>
 <66b1de88-dd11-178d-374b-09eb5739bfb3@ti.com> <5C52D0F1.2020807@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0c39b4f6-98fd-9765-c90e-701387cf9e83@ti.com>
Date:   Thu, 31 Jan 2019 16:34:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C52D0F1.2020807@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/01/19 4:11 PM, Roger Quadros wrote:
> 
> 
> On 31/01/19 08:02, Kishon Vijay Abraham I wrote:
>> Roger,
>>
>> On 30/01/19 8:28 PM, Roger Quadros wrote:
>>> Kishon,
>>>
>>> On 24/01/19 12:48, Kishon Vijay Abraham I wrote:
>>>> DRA72 platform has the second instance of PHY shared between USB3
>>>> controller and PCIe controller with default as USB3 controller.
>>>> Since it is used with USB3 controller by default, it uses the
>>>> compatible specific to USB (ti,omap-usb3).
>>>>
>>>> Populate set_mode callback so that the USB3 PHY can be configured
>>>> to be used with PCIe controller.
>>>
>>> How about rewording this to,
>>>
>>> "On DRA72x SoCs, the USB3 PHY can be used either as USB Super-Speed
>>> lane or as PCIe Lane (i.e. second lane for PCIe_SS1 in 2 lane mode or single
>>> lane for PCIe_SS2). The default mode for the USB3 PHY is USB Super-Speed.
>>> Provide a way for the PHY user to choose the appropriate mode via the
>>> .set_mode hook"
>>
>> hmm okay
>>>
>>> More comments below.
>>>
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/phy/ti/phy-ti-pipe3.c | 66 ++++++++++++++++++++++++++++-------
>>>>  1 file changed, 54 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
>>>> index 68ce4a082b9b..8c98f366416d 100644
>>>> --- a/drivers/phy/ti/phy-ti-pipe3.c
>>>> +++ b/drivers/phy/ti/phy-ti-pipe3.c
>>>> @@ -56,6 +56,12 @@
>>>>  
>>>>  #define SATA_PLL_SOFT_RESET	BIT(18)
>>>>  
>>>> +#define PHY_RX_ANA_PRGRAMMABILITY_REG	0xC
>>>> +#define MEM_EN_PLLBYP			BIT(7)
>>>> +
>>>> +#define PHY_TX_TEST_CONFIG		0x2C
>>>> +#define MEM_ENTESTCLK			BIT(31)
>>>> +
>>>>  #define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	0x003FC000
>>>>  #define PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT	14
>>>>  
>>>> @@ -110,6 +116,8 @@
>>>>  #define PLL_IDLE_TIME	100	/* in milliseconds */
>>>>  #define PLL_LOCK_TIME	100	/* in milliseconds */
>>>>  
>>>> +#define PIPE3_PHY_DISABLE_SYNC_POWER	BIT(4)
>>>> +
>>>>  struct pipe3_dpll_params {
>>>>  	u16	m;
>>>>  	u8	n;
>>>> @@ -141,6 +149,7 @@ struct ti_pipe3 {
>>>>  	unsigned int		power_reg; /* power reg. index within syscon */
>>>>  	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
>>>>  	bool			sata_refclk_enabled;
>>>> +	u32			mode;
>>>>  };
>>>>  
>>>>  static struct pipe3_dpll_map dpll_map_usb[] = {
>>>> @@ -233,7 +242,10 @@ static int ti_pipe3_power_on(struct phy *x)
>>>>  	rate = rate / 1000000;
>>>>  	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK |
>>>>  		  OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
>>>> -	val = PIPE3_PHY_TX_RX_POWERON << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
>>>> +	val = PIPE3_PHY_TX_RX_POWERON;
>>>> +	if (phy->mode == PHY_MODE_PCIE)
>>>> +		val |= PIPE3_PHY_DISABLE_SYNC_POWER;
>>>
>>> Is this required only for the USB3 PHY being used as PCIe lane or can it
>>> be done for the PCIe PHY as well?
>>
>> This setting was given only for USB3 PHY. I did check PCIe PHY (1-lane) to see
>> if this is causing issues before posting the patch.
>>
>> Thinking again, it might be safer to just use this setting for USB3 PHY.
>>>
>>> I ask this because phy->mode can be PHY_MODE_PCIE for both USB3 PHY and PCIe PHY
>>> and it might break PCIe PHY as we don't do PIPE3_PHY_DISABLE_SYNC_POWER for that
>>> currently.
>>>
>>> Maybe this is safer?
>>>
>>> 	if (phy->mode == PHY_MODE_PCIE && of_device_is_compatible(node, "ti,phy-usb3"))
>>
>> yeah..
>>>
>>>> +	val <<= PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
>>>>  	val |= rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
>>>>  
>>>>  	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
>>>> @@ -328,13 +340,11 @@ static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
>>>>  	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_EQUALIZER, val);
>>>>  }
>>>>  
>>>> -static int ti_pipe3_init(struct phy *x)
>>>> +static int ti_pipe3_pcie_init(struct ti_pipe3 *phy)
>>>>  {
>>>> -	struct ti_pipe3 *phy = phy_get_drvdata(x);
>>>> -	u32 val;
>>>>  	int ret = 0;
>>>> +	u32 val;
>>>>  
>>>> -	ti_pipe3_enable_clocks(phy);
>>>>  	/*
>>>>  	 * Set pcie_pcs register to 0x96 for proper functioning of phy
>>>>  	 * as recommended in AM572x TRM SPRUHZ6, section 18.5.2.2, table
>>>> @@ -353,10 +363,31 @@ static int ti_pipe3_init(struct phy *x)
>>>>  			return ret;
>>>>  
>>>>  		ti_pipe3_calibrate(phy);
>>>> -
>>>> -		return 0;
>>>> +	} else {
>>>
>>> How about
>>>
>>> 	else if (of_device_is_compatible(node, "ti,phy-usb3")) {
>>
>> This check is implicit no?
> 
> For now yes. But phy_set_mode can be called for SATA PHY as well
> and that might need different settings than USB3 PHY?

This function will be invoked only for PCIe.
> 
>>> 		/* USB3 PHY being used as PCIe Lane */
>>>
>>>> +		val = ti_pipe3_readl(phy->phy_rx,
>>>> +				     PHY_RX_ANA_PRGRAMMABILITY_REG);
>>>> +		val |= MEM_EN_PLLBYP;
>>>> +		ti_pipe3_writel(phy->phy_rx, PHY_RX_ANA_PRGRAMMABILITY_REG,
>>>> +				val);
>>>> +		val = ti_pipe3_readl(phy->phy_tx, PHY_TX_TEST_CONFIG);
>>>> +		val |= MEM_ENTESTCLK;
>>>> +		ti_pipe3_writel(phy->phy_tx, PHY_TX_TEST_CONFIG, val);
>>>>  	}
>>>>  
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int ti_pipe3_init(struct phy *x)
>>>> +{
>>>> +	struct ti_pipe3 *phy = phy_get_drvdata(x);
>>>> +	u32 val;
>>>> +	int ret = 0;
>>>> +
>>>> +	ti_pipe3_enable_clocks(phy);
>>>> +
>>>> +	if (phy->mode == PHY_MODE_PCIE)
>>>
>>> Here you expect PHY "ti,phy-pipe3-pcie" to have mode = PHY_MODE_PCIE.
>>> Should we set the mode to PCI_MODE_PCIE explicitly it in probe?
>>
>> The set_mode callback checks if the phy->mode is INVALID before setting the
>> mode. The phy_set_mode in the PCIe consumer driver will return error if it is
>> already set. The phy_set_mode will be called for both the lanes by the PCIe driver.
> 
> see below.
> 
>>>
>>>> +		return ti_pipe3_pcie_init(phy);
>>>> +
>>>>  	/* Bring it out of IDLE if it is IDLE */
>>>>  	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
>>>>  	if (val & PLL_IDLE) {
>>>> @@ -395,7 +426,7 @@ static int ti_pipe3_exit(struct phy *x)
>>>>  		return 0;
>>>>  
>>>>  	/* PCIe doesn't have internal DPLL */
>>>> -	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
>>>> +	if (!(phy->mode == PHY_MODE_PCIE)) {
>>>
>>> But this might be a USB3 PHY, which has DPLL.
>>
>> hmm. I have to check this. We should also then reset PLL_IDLE bit in phy_init.
>>>
>>>>  		/* Put DPLL in IDLE mode */
>>>>  		val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
>>>>  		val |= PLL_IDLE;
>>>> @@ -429,11 +460,25 @@ static int ti_pipe3_exit(struct phy *x)
>>>>  
>>>>  	return 0;
>>>>  }
>>>> +
>>>> +static int ti_pipe3_set_mode(struct phy *x, enum phy_mode mode, int submode)
>>>> +{
>>>> +	struct ti_pipe3 *phy = phy_get_drvdata(x);
>>>> +
>>>> +	if (phy->mode != PHY_MODE_INVALID)
>>>> +		return -EBUSY;
> 
> I think you are referring to this. Why is this necessary?
> This will restrict the PHY to one mode per boot. We don't want to
> impose that limitation.

Isn't that true? Our PHYs can work only in one mode right?

Maybe we can add a check like below but there too we can't set the PHY mode of
USB PHY to USB in probe, for the PHY that is shared with PCIe.

if (phy->mode != PHY_MODE_INVALID) && (phy->mode != mode)
	return -EBUSY.

Thanks
Kishon
