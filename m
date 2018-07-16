Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989B62084A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989B62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeGPOpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:45:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35730 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeGPOpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:45:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A2BDC207B4; Mon, 16 Jul 2018 16:17:22 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 759FA206ED;
        Mon, 16 Jul 2018 16:17:12 +0200 (CEST)
Date:   Mon, 16 Jul 2018 16:17:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, andrew@lunn.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microsemi.com
Subject: Re: [PATCH net-next] net: mscc: simplify retrieving the tag type
 from the frame header
Message-ID: <20180716141712.GA5983@piout.net>
References: <20180713145757.3574-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180713145757.3574-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2018 16:57:57+0200, Antoine Ténart wrote:
> The tag type in the frame extraction header is only a bit wide. There's
> no need to use GENMASK when retrieving the information. This patch
> simplify the code by dropping GENMASK and using BIT instead.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/ethernet/mscc/ocelot_board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
> index 18df7d934e81..26bb3b18f3be 100644
> --- a/drivers/net/ethernet/mscc/ocelot_board.c
> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
> @@ -29,7 +29,7 @@ static int ocelot_parse_ifh(u32 *ifh, struct frame_info *info)
>  	info->port = (ifh[2] & GENMASK(14, 11)) >> 11;
>  
>  	info->cpuq = (ifh[3] & GENMASK(27, 20)) >> 20;
> -	info->tag_type = (ifh[3] & GENMASK(16, 16)) >> 16;
> +	info->tag_type = (ifh[3] & BIT(16)) >> 16;
>  	info->vid = ifh[3] & GENMASK(11, 0);
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
