Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B2F223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B2F223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbeKOTge convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:36:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60298 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeKOTge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:36:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9639020D98; Thu, 15 Nov 2018 10:29:32 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5A99D20510;
        Thu, 15 Nov 2018 10:29:22 +0100 (CET)
Date:   Thu, 15 Nov 2018 10:29:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Huijin Park <huijin.park@samsung.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbanghj.park@gmail.com
Subject: Re: [PATCH v2] mtd: change len type from signed to unsigned type
Message-ID: <20181115102921.5117af90@xps13>
In-Reply-To: <1542258430-19885-1-git-send-email-huijin.park@samsung.com>
References: <CGME20181115050724eucas1p169b2046c03e108035199a4481a82a560@eucas1p1.samsung.com>
        <1542258430-19885-1-git-send-email-huijin.park@samsung.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huijin,

Huijin Park <huijin.park@samsung.com> wrote on Thu, 15 Nov 2018
00:07:10 -0500:

> From: "huijin.park" <huijin.park@samsung.com>
> 
> This patch casts the "len" parameter to an unsigned int.
> The callers of erase_write() pass the "len" parameter as unsigned int.

Indeed. Perhaps it is worth backporting this patch to a stable releases?

> 
> Signed-off-by: huijin.park <huijin.park@samsung.com>
> ---
>  drivers/mtd/mtdblock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> index a5b1933..b2d5ed1 100644
> --- a/drivers/mtd/mtdblock.c
> +++ b/drivers/mtd/mtdblock.c
> @@ -56,7 +56,7 @@ struct mtdblk_dev {
>   */
>  
>  static int erase_write (struct mtd_info *mtd, unsigned long pos,
> -			int len, const char *buf)
> +			unsigned int len, const char *buf)
>  {
>  	struct erase_info erase;
>  	size_t retlen;

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
