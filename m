Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659712170B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659712170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeHYRzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 13:55:51 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:36236 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeHYRzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 13:55:51 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id AAB8B4147A;
        Sat, 25 Aug 2018 16:16:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 9lnmfpJ0vDZV; Sat, 25 Aug 2018 16:16:42 +0200 (CEST)
Subject: Re: [PATCHv2 2/2] phy:phy-lantiq-rcu-usb2: Use PTR_ERR_OR_ZERO to
 replace the open coded version
To:     zhong jiang <zhongjiang@huawei.com>, alcooperx@gmail.com,
        kishon@ti.com, robh@kernel.org, ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org
References: <1534435135-49332-1-git-send-email-zhongjiang@huawei.com>
 <1534435135-49332-3-git-send-email-zhongjiang@huawei.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <3de3eebf-4d28-5791-d0cf-e76290d630ce@hauke-m.de>
Date:   Sat, 25 Aug 2018 16:16:40 +0200
MIME-Version: 1.0
In-Reply-To: <1534435135-49332-3-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/16/2018 05:58 PM, zhong jiang wrote:
> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> just replace them rather than duplicating its implement.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> index 986224f..a918c5b 100644
> --- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> +++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> @@ -196,10 +196,8 @@ static int ltq_rcu_usb2_of_parse(struct ltq_rcu_usb2_priv *priv,
>  	}
>  
>  	priv->phy_reset = devm_reset_control_get_optional(dev, "phy");
> -	if (IS_ERR(priv->phy_reset))
> -		return PTR_ERR(priv->phy_reset);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(priv->phy_reset);
>  }
>  
>  static int ltq_rcu_usb2_phy_probe(struct platform_device *pdev)
> 
