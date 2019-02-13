Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F66C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582F521934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ERt/4jnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404878AbfBMSQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:16:01 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50532 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfBMSQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EcJk791Pq66UPF57+dabzkxCJr2L7yCBI4Jmdyzryts=; b=ERt/4jnwdZwUeb8tqNXoDYXy9F
        XEMa/sxn8mkSNPi0ArGYF4vHPzewy4M+K47B5vyf59+6Cz0szcyVicUaZQfVEPRTV6ZoyR+SlEcRw
        wWcX3NiwNW1XdOmGAbsKPR5tPVbpZp/p6Hk1y/bYSWUEXJ6wfRkuyVSiwHqCWGEQ7mgk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gtz4c-0000mH-OA; Wed, 13 Feb 2019 19:15:54 +0100
Date:   Wed, 13 Feb 2019 19:15:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Message-ID: <20190213181554.GB708@lunn.ch>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
 <1550055743-15542-3-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550055743-15542-3-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:02:22PM +0200, Claudiu Manoil wrote:
> The LS1028A RDB board features an Atheros PHY connected over
> SGMII to the ENETC PF0 (or Port0).  ENETC Port1 (PF1) has no
> external connection on this board, so it can be disabled for now.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index fdeb417..c8487893 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -71,3 +71,18 @@
>  &duart1 {
>  	status = "okay";
>  };
> +
> +&enetc_port0 {
> +	phy-handle = <&sgmii_phy0>;
> +	phy-connection-type = "sgmii";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	sgmii_phy0: ethernet-phy@2 {
> +		reg = <0x2>;
> +	};
> +};
> +

Hi Claudiu

It is better to use:

&enetc_port0 {
	phy-handle = <&sgmii_phy0>;
	phy-connection-type = "sgmii";
	#address-cells = <1>;
	#size-cells = <0>;

	mdio {
		sgmii_phy0: ethernet-phy@2 {
			reg = <0x2>;
		};
	};
};

	Andrew
