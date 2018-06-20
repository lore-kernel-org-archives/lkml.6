Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B68DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAE120693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAE120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755006AbeFTJk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:40:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47255 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754192AbeFTJk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:40:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 80503207D4; Wed, 20 Jun 2018 11:40:25 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4126A206D8;
        Wed, 20 Jun 2018 11:40:25 +0200 (CEST)
Date:   Wed, 20 Jun 2018 11:40:25 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH v2 5/6] mtd: rawnand: micron: add
 ONFI_FEATURE_ON_DIE_ECC to supported features
Message-ID: <20180620114025.0b18b22f@bbrezillon>
In-Reply-To: <20180619053125.16792-6-chris.packham@alliedtelesis.co.nz>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
        <20180619053125.16792-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 17:31:24 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Add ONFI_FEATURE_ON_DIE_ECC to the set/get features list for Micron
> NAND flash.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Queued to master (AKA mtd/fixes).

Thanks,

Boris

> ---
> Changes in v2:
> - New
> 
>  drivers/mtd/nand/raw/nand_micron.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index e582c9e61715..d1e8f57544a0 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -66,7 +66,9 @@ static int micron_nand_onfi_init(struct nand_chip *chip)
>  
>  	if (p->supports_set_get_features) {
>  		set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->set_feature_list);
> +		set_bit(ONFI_FEATURE_ON_DIE_ECC, p->set_feature_list);
>  		set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->get_feature_list);
> +		set_bit(ONFI_FEATURE_ON_DIE_ECC, p->get_feature_list);
>  	}
>  
>  	return 0;

