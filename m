Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86473C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E1B208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E1B208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeHBPFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:05:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49203 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732298AbeHBPFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:05:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B264520739; Thu,  2 Aug 2018 15:14:33 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53FC0206A8;
        Thu,  2 Aug 2018 15:14:33 +0200 (CEST)
Date:   Thu, 2 Aug 2018 15:14:34 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, broonie@kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, pp@emlix.com, Zhiqiang.Hou@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: m25p80: Call spi_mem_get_name() to let
 controller set a custom name
Message-ID: <20180802151434.6c978937@bbrezillon>
In-Reply-To: <1533214434-28761-4-git-send-email-frieder.schrempf@exceet.de>
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
        <1533214434-28761-4-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 14:53:54 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
> set a custom name for the memory device if necessary.
> This is useful to keep mtdparts compatible when controller drivers are
> ported from the MTD to the SPI layer.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/devices/m25p80.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index e84563d..aac48800 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -202,6 +202,9 @@ static int m25p_probe(struct spi_mem *spimem)
>  	if (data && data->name)
>  		nor->mtd.name = data->name;
>  
> +	if (!nor->mtd.name)
> +		nor->mtd.name = spi_mem_get_name(spimem);
> +
>  	/* For some (historical?) reason many platforms provide two different
>  	 * names in flash_platform_data: "name" and "type". Quite often name is
>  	 * set to "m25p80" and then "type" provides a real chip name.

