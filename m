Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5739B2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5739B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeKLUmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:42:10 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38522 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeKLUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:42:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wACAmfGh097000;
        Mon, 12 Nov 2018 04:48:41 -0600
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wACAmfar056487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 04:48:41 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 04:48:41 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 04:48:41 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wACAmYbE019719;
        Mon, 12 Nov 2018 04:48:35 -0600
Subject: Re: [PATCH v2 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-5-grygorii.strashko@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <13d935ae-131b-8555-242d-00f5a3e41c71@ti.com>
Date:   Mon, 12 Nov 2018 16:18:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109234755.21687-5-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine, David Miller

Please ACK this patch if it looks okay.

Thanks
Kishon

On 10/11/18 5:17 AM, Grygorii Strashko wrote:
> Convert mvebu-cp110-comphy PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +-----
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 83 ++++++++++++++-----------
>  2 files changed, 48 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 7a37a37..731793a 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -1165,28 +1165,13 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
>   */
>  static int mvpp22_comphy_init(struct mvpp2_port *port)
>  {
> -	enum phy_mode mode;
>  	int ret;
>  
>  	if (!port->comphy)
>  		return 0;
>  
> -	switch (port->phy_interface) {
> -	case PHY_INTERFACE_MODE_SGMII:
> -	case PHY_INTERFACE_MODE_1000BASEX:
> -		mode = PHY_MODE_SGMII;
> -		break;
> -	case PHY_INTERFACE_MODE_2500BASEX:
> -		mode = PHY_MODE_2500SGMII;
> -		break;
> -	case PHY_INTERFACE_MODE_10GKR:
> -		mode = PHY_MODE_10GKR;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	ret = phy_set_mode(port->comphy, mode);
> +	ret = phy_set_mode_ext(port->comphy, PHY_MODE_ETHERNET,
> +			       port->phy_interface);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> index 79b52c3..7dee72b 100644
> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> @@ -9,6 +9,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -131,26 +132,26 @@ struct mvebu_comhy_conf {
>  
>  static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
>  	/* lane 0 */
> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  	/* lane 1 */
> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  	/* lane 2 */
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_2500SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_10GKR, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_2500BASEX, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_10GKR, 0x1),
>  	/* lane 3 */
> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_2500SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_2500BASEX, 0x2),
>  	/* lane 4 */
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_2500SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_10GKR, 0x2),
> -	MVEBU_COMPHY_CONF(4, 1, PHY_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_2500BASEX, 0x2),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_10GKR, 0x2),
> +	MVEBU_COMPHY_CONF(4, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
>  	/* lane 5 */
> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  };
>  
>  struct mvebu_comphy_priv {
> @@ -163,10 +164,12 @@ struct mvebu_comphy_lane {
>  	struct mvebu_comphy_priv *priv;
>  	unsigned id;
>  	enum phy_mode mode;
> +	int submode;
>  	int port;
>  };
>  
> -static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
> +static int mvebu_comphy_get_mux(int lane, int port,
> +				enum phy_mode mode, int submode)
>  {
>  	int i, n = ARRAY_SIZE(mvebu_comphy_cp110_modes);
>  
> @@ -177,7 +180,7 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>  	for (i = 0; i < n; i++) {
>  		if (mvebu_comphy_cp110_modes[i].lane == lane &&
>  		    mvebu_comphy_cp110_modes[i].port == port &&
> -		    mvebu_comphy_cp110_modes[i].mode == mode)
> +		    mvebu_comphy_cp110_modes[i].mode == submode)
>  			break;
>  	}
>  
> @@ -187,8 +190,7 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>  	return mvebu_comphy_cp110_modes[i].mux;
>  }
>  
> -static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
> -					     enum phy_mode mode)
> +static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
>  {
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
> @@ -206,14 +208,14 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
>  		 MVEBU_COMPHY_SERDES_CFG0_HALF_BUS |
>  		 MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xf) |
>  		 MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xf));
> -	if (mode == PHY_MODE_10GKR)
> +	if (lane->submode == PHY_INTERFACE_MODE_10GKR)
>  		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xe) |
>  		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xe);
> -	else if (mode == PHY_MODE_2500SGMII)
> +	else if (lane->submode == PHY_INTERFACE_MODE_2500BASEX)
>  		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x8) |
>  		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x8) |
>  		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
> -	else if (mode == PHY_MODE_SGMII)
> +	else if (lane->submode == PHY_INTERFACE_MODE_SGMII)
>  		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x6) |
>  		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x6) |
>  		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
> @@ -243,7 +245,7 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
>  	/* refclk selection */
>  	val = readl(priv->base + MVEBU_COMPHY_MISC_CTRL0(lane->id));
>  	val &= ~MVEBU_COMPHY_MISC_CTRL0_REFCLK_SEL;
> -	if (mode == PHY_MODE_10GKR)
> +	if (lane->submode == PHY_INTERFACE_MODE_10GKR)
>  		val |= MVEBU_COMPHY_MISC_CTRL0_ICP_FORCE;
>  	writel(val, priv->base + MVEBU_COMPHY_MISC_CTRL0(lane->id));
>  
> @@ -261,8 +263,7 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane,
>  	writel(val, priv->base + MVEBU_COMPHY_LOOPBACK(lane->id));
>  }
>  
> -static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
> -				  enum phy_mode mode)
> +static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane)
>  {
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
> @@ -303,13 +304,13 @@ static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane,
>  	return 0;
>  }
>  
> -static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
> +static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
>  {
>  	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
>  
> -	mvebu_comphy_ethernet_init_reset(lane, mode);
> +	mvebu_comphy_ethernet_init_reset(lane);
>  
>  	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
>  	val &= ~MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
> @@ -330,7 +331,7 @@ static int mvebu_comphy_set_mode_sgmii(struct phy *phy, enum phy_mode mode)
>  	val |= MVEBU_COMPHY_GEN1_S0_TX_EMPH(0x1);
>  	writel(val, priv->base + MVEBU_COMPHY_GEN1_S0(lane->id));
>  
> -	return mvebu_comphy_init_plls(lane, PHY_MODE_SGMII);
> +	return mvebu_comphy_init_plls(lane);
>  }
>  
>  static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
> @@ -339,7 +340,7 @@ static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
>  	struct mvebu_comphy_priv *priv = lane->priv;
>  	u32 val;
>  
> -	mvebu_comphy_ethernet_init_reset(lane, PHY_MODE_10GKR);
> +	mvebu_comphy_ethernet_init_reset(lane);
>  
>  	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
>  	val |= MVEBU_COMPHY_RX_CTRL1_RXCLK2X_SEL |
> @@ -469,7 +470,7 @@ static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
>  	val |= MVEBU_COMPHY_EXT_SELV_RX_SAMPL(0x1a);
>  	writel(val, priv->base + MVEBU_COMPHY_EXT_SELV(lane->id));
>  
> -	return mvebu_comphy_init_plls(lane, PHY_MODE_10GKR);
> +	return mvebu_comphy_init_plls(lane);
>  }
>  
>  static int mvebu_comphy_power_on(struct phy *phy)
> @@ -479,7 +480,8 @@ static int mvebu_comphy_power_on(struct phy *phy)
>  	int ret, mux;
>  	u32 val;
>  
> -	mux = mvebu_comphy_get_mux(lane->id, lane->port, lane->mode);
> +	mux = mvebu_comphy_get_mux(lane->id, lane->port,
> +				   lane->mode, lane->submode);
>  	if (mux < 0)
>  		return -ENOTSUPP;
>  
> @@ -492,12 +494,12 @@ static int mvebu_comphy_power_on(struct phy *phy)
>  	val |= mux << MVEBU_COMPHY_SELECTOR_PHY(lane->id);
>  	regmap_write(priv->regmap, MVEBU_COMPHY_SELECTOR, val);
>  
> -	switch (lane->mode) {
> -	case PHY_MODE_SGMII:
> -	case PHY_MODE_2500SGMII:
> -		ret = mvebu_comphy_set_mode_sgmii(phy, lane->mode);
> +	switch (lane->submode) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		ret = mvebu_comphy_set_mode_sgmii(phy);
>  		break;
> -	case PHY_MODE_10GKR:
> +	case PHY_INTERFACE_MODE_10GKR:
>  		ret = mvebu_comphy_set_mode_10gkr(phy);
>  		break;
>  	default:
> @@ -517,10 +519,17 @@ static int mvebu_comphy_set_mode(struct phy *phy,
>  {
>  	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
>  
> -	if (mvebu_comphy_get_mux(lane->id, lane->port, mode) < 0)
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +
> +	if (submode == PHY_INTERFACE_MODE_1000BASEX)
> +		submode = PHY_INTERFACE_MODE_SGMII;
> +
> +	if (mvebu_comphy_get_mux(lane->id, lane->port, mode, submode) < 0)
>  		return -EINVAL;
>  
>  	lane->mode = mode;
> +	lane->submode = submode;
>  	return 0;
>  }
>  
> 
