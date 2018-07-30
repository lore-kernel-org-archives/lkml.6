Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2664FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44420893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C44420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeG3Ps6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:48:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33566 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeG3Ps6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:48:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E87BB20884; Mon, 30 Jul 2018 16:13:44 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B414C207AC;
        Mon, 30 Jul 2018 16:13:34 +0200 (CEST)
Date:   Mon, 30 Jul 2018 16:13:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] net: phy: mscc: the extended page access
 register is 16 bits
Message-ID: <20180730141335.GG28585@piout.net>
References: <20180730125313.3405-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730125313.3405-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 14:53:13+0200, Quentin Schulz wrote:
> The Extended Page Access is a 16-bit register, so change the page
> parameter of vsc85xx_phy_page_set to a u16.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/phy/mscc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 650c2667d523..84ca9ff40ae0 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -123,7 +123,7 @@ static const struct vsc8531_edge_rate_table edge_table[] = {
>  };
>  #endif /* CONFIG_OF_MDIO */
>  
> -static int vsc85xx_phy_page_set(struct phy_device *phydev, u8 page)
> +static int vsc85xx_phy_page_set(struct phy_device *phydev, u16 page)
>  {
>  	int rc;
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
