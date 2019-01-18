Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1200CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5A02087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAROQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:16:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44639 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfAROQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:16:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A314A207B0; Fri, 18 Jan 2019 15:16:15 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr [109.213.9.46])
        by mail.bootlin.com (Postfix) with ESMTPSA id DECB120712;
        Fri, 18 Jan 2019 15:16:14 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v4 2/4] clk: mvebu: armada-37xx-tbg: fix error message
References: <20190108161940.4814-1-miquel.raynal@bootlin.com>
        <20190108161940.4814-3-miquel.raynal@bootlin.com>
Date:   Fri, 18 Jan 2019 15:16:13 +0100
In-Reply-To: <20190108161940.4814-3-miquel.raynal@bootlin.com> (Miquel
        Raynal's message of "Tue, 8 Jan 2019 17:19:38 +0100")
Message-ID: <875zumnj9u.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The error message should state that the driver failed to get the
> parent clock, not the opposite.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/clk/mvebu/armada-37xx-tbg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
> index ee272d4d8c24..77b978c55ef6 100644
> --- a/drivers/clk/mvebu/armada-37xx-tbg.c
> +++ b/drivers/clk/mvebu/armada-37xx-tbg.c
> @@ -98,7 +98,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
>  
>  	parent = clk_get(dev, NULL);
>  	if (IS_ERR(parent)) {
> -		dev_err(dev, "Could get the clock parent\n");
> +		dev_err(dev, "Could not get the clock parent\n");
>  		return -EINVAL;
>  	}
>  	parent_name = __clk_get_name(parent);
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
