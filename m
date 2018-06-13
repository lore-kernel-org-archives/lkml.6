Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B4CA4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C45220891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LOklnhUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C45220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934639AbeFMH3M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:29:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60341 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933912AbeFMH3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=++iM2jtluYId9VxzTzB9/vPQSysaGgX8opAQUKXM/20=;
        b=LOklnhUyXgMiQxZSPOyteXkcBy/dnOSJUKCH5MqRHWo6Dv+R8AlsxzUX/6ZdBbM0XUm4Ue/SMs+kdCZy9pEkSO4DTvQTX5UL+u08ncpINVVZ7R2qM6KWc/+vLra4AJ6glYo/wE6f7upEfc04GjK4TWcrcjKccrBUFExAsfiY4FI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fT0DJ-0006kt-R9; Wed, 13 Jun 2018 09:29:05 +0200
Date:   Wed, 13 Jun 2018 09:29:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     davem@davemloft.net, michal.simek@xilinx.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return
 check
Message-ID: <20180613072905.GE24314@lunn.ch>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:05:19PM +0530, Radhey Shyam Pandey wrote:
> Errors are already reported in xemaclite_mdio_setup so avoid
> reporting it again.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index ec4608e..2a0c06e 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -1143,9 +1143,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
>  	xemaclite_update_address(lp, ndev->dev_addr);
>  
>  	lp->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
> -	rc = xemaclite_mdio_setup(lp, &ofdev->dev);
> -	if (rc)
> -		dev_warn(&ofdev->dev, "error registering MDIO bus\n");
> +	xemaclite_mdio_setup(lp, &ofdev->dev);
>  
>  	dev_info(dev, "MAC address is now %pM\n", ndev->dev_addr);

The patch itself is O.K. 

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

However, do you want to keep going if the MDIO bus fails? Maybe you
should failed the probe?

    Andrew
