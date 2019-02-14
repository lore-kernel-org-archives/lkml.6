Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D3E2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zQh6uNDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407111AbfBNNku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:40:50 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51816 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387696AbfBNNku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dFkiC3dfv0iwknkOldbJAOIn/enUrVcnD3etEIIX/EQ=; b=zQh6uNDhF/TVBubu+BQxvQRcJ7
        qp1M14V4unCvoMEatFy6FINQ4eLL2RSRkXNty9wrhg3vfwwYPBKsZqq+x9x+REqhIud1cGKJEVl9V
        SDd2Ox6W40hitF8COVAHVrdAL/d6LnvCEegO8nQbNwvYdJoW2eldU+8+81/47CBphx4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1guHFo-0001g1-84; Thu, 14 Feb 2019 14:40:40 +0100
Date:   Thu, 14 Feb 2019 14:40:40 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe Roullier <christophe.roullier@st.com>
Cc:     robh@kernel.org, davem@davemloft.net, joabreu@synopsys.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH  2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Message-ID: <20190214134040.GA5699@lunn.ch>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Feb 14, 2019 at 07:45:57AM +0100, Christophe Roullier wrote:
> @@ -131,19 +185,19 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII:
>  		val = SYSCFG_PMCR_ETH_SEL_RGMII;
> -		if (dwmac->int_phyclk)
> +		if (dwmac->eth_clk_sel_reg)
>  			val |= SYSCFG_PMCR_ETH_CLK_SEL;
>  		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
>  		break;

Hi Christophe

This code should handle all 4 PHY_INTERFACE_MODE_RGMII* values.

     Andrew
