Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8022CC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CA420818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D3/CX1LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CA420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeKIH7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:59:18 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36210 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zZXmITg4kc3K/wcdLi/pAdqyUz4PEZBt00gTQPPymRs=; b=D3/CX1LN/QYhS2eMnGH1iDOds
        +C9AQn6PcYIy9m+FOYRKlyMy7wMfAIFgZSbOLBA47lh3UxGz5/OyzM7Sg7ELNpov7VG093unQD7Rs
        4YIphNH7PreB6feozIWl6LDDbeCmVcpMzTt/p9MgXJoTLAgMmLClW2PzOX/v5cJhf9EfU=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:34582)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gKsg6-0006h5-6v; Thu, 08 Nov 2018 22:21:30 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gKsg1-0005SP-UU; Thu, 08 Nov 2018 22:21:26 +0000
Date:   Thu, 8 Nov 2018 22:21:23 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 4/5] phy: mvebu-cp110-comphy: convert to use eth phy mode
 and submode
Message-ID: <20181108222123.GZ30658@n2100.armlinux.org.uk>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
 <20181108003617.10334-5-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108003617.10334-5-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:36:16PM -0600, Grygorii Strashko wrote:
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 7a37a37..fb28b71 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -1165,28 +1165,17 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
>   */
>  static int mvpp22_comphy_init(struct mvpp2_port *port)
>  {
> -	enum phy_mode mode;
> +	int submode;
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
> +	submode = port->phy_interface;
> +	if (submode == PHY_INTERFACE_MODE_1000BASEX)
> +		submode = PHY_INTERFACE_MODE_SGMII;

If the intention is to move the ethernet PHY mode into the generic PHY
layer, I'd suggest that the equivalence of 1000base-X and SGMII is
handled in the generic PHY driver rather than ethernet drivers.  Just
move this into this hunk of the comphy driver:

> @@ -517,10 +519,14 @@ static int mvebu_comphy_set_mode(struct phy *phy,
>  {
>  	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
>  
> -	if (mvebu_comphy_get_mux(lane->id, lane->port, mode) < 0)
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +
> +	if (mvebu_comphy_get_mux(lane->id, lane->port, mode, submode) < 0)
>  		return -EINVAL;
>  
>  	lane->mode = mode;
> +	lane->submode = submode;
>  	return 0;
>  }

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
