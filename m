Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1ACC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB0F219E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB0F219E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966312AbeF0VfZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:35:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53140 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965145AbeF0VfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:35:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DD364206DE; Wed, 27 Jun 2018 23:35:22 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9884120012;
        Wed, 27 Jun 2018 23:35:12 +0200 (CEST)
Date:   Wed, 27 Jun 2018 23:35:12 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: mxc: remove __init qualifier from
 mxcnd_probe_dt
Message-ID: <20180627233512.44e820fe@bbrezillon>
In-Reply-To: <1530132464-8210-1-git-send-email-martin@kaiser.cx>
References: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
        <1530132464-8210-1-git-send-email-martin@kaiser.cx>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 22:47:44 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
> potentially be called at any time. After the __init functions are cleaned,
> mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.
> 
> mxcnd_probe used to be marked as __init, this was removed years ago.
> Remove the __init qualifier from from mxcnd_probe_dt as well.
> 
> Fixes: 06f255106923 ("mtd: remove use of __devinit")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> changes in v3
>    - show the first 12 characters of the SHA-1 ID in the Fixes: tag
> 
> changes in v2
>    - rephrased the commit message
>    - added a Fixes: tag
> 
>  drivers/mtd/nand/raw/mxc_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> index 26cef218bb43..90cfb5e730aa 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -1686,7 +1686,7 @@ static const struct of_device_id mxcnd_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mxcnd_dt_ids);
>  
> -static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
> +static int mxcnd_probe_dt(struct mxc_nand_host *host)
>  {
>  	struct device_node *np = host->dev->of_node;
>  	const struct of_device_id *of_id =
> @@ -1700,7 +1700,7 @@ static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
>  	return 0;
>  }
>  #else
> -static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
> +static int mxcnd_probe_dt(struct mxc_nand_host *host)
>  {
>  	return 1;
>  }

