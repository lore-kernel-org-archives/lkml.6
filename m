Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C75C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9DA2197C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kE6FvC7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9DA2197C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934651AbeFZKf2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:35:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56014 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933870AbeFZKf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:35:26 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2E5EE5C1D1D;
        Tue, 26 Jun 2018 12:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530009325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybRMssVRNAGWTAWJ0M+01qhxR8RMHcL5ZAypXCzqO6k=;
        b=kE6FvC7/4wbM567bpL7FXMmXBKeRFtKLyZSwlJRFTYNjicm2CE/0tNWjjWEZl+ML1UFBtz
        Zwux6U0ntycnb/sxY4az5X7OHUjfthtN061A3EE5+UWlkk+D+feEESeD23smwyaaiMaqWt
        m+Vnv6sOQRYaWuHPVtv/SG6hKzySn2s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jun 2018 12:35:24 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Lucas Stach <dev@lynxeye.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: fix a couple of spelling mistakes
In-Reply-To: <20180626102629.31083-1-colin.king@canonical.com>
References: <20180626102629.31083-1-colin.king@canonical.com>
Message-ID: <93be5d64cc447fb282bcc14fed853f0c@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.2018 12:26, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix of two spelling mistakes in dev_err error messages:
> "supportes" -> "supports" and "strenght" -> "strength"

Acked-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/nand/raw/tegra_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> b/drivers/mtd/nand/raw/tegra_nand.c
> index 4daa88d81413..9f7de36be893 100644
> --- a/drivers/mtd/nand/raw/tegra_nand.c
> +++ b/drivers/mtd/nand/raw/tegra_nand.c
> @@ -1002,14 +1002,14 @@ static int tegra_nand_chips_init(struct device *dev,
>  	}
>  
>  	if (chip->ecc.algo == NAND_ECC_BCH && mtd->writesize < 2048) {
> -		dev_err(dev, "BCH supportes 2K or 4K page size only\n");
> +		dev_err(dev, "BCH supports 2K or 4K page size only\n");
>  		return -EINVAL;
>  	}
>  
>  	if (!chip->ecc.strength) {
>  		ret = tegra_nand_select_strength(chip, mtd->oobsize);
>  		if (ret < 0) {
> -			dev_err(dev, "No valid strenght found, minimum %d\n",
> +			dev_err(dev, "No valid strength found, minimum %d\n",
>  				chip->ecc_strength_ds);
>  			return ret;
>  		}
