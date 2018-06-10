Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id djVrK1VLHVuQQgAAmS7hNA
	; Sun, 10 Jun 2018 16:01:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9FD8E60791; Sun, 10 Jun 2018 16:01:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3121F6070A;
	Sun, 10 Jun 2018 16:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3121F6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeFJQBV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 12:01:21 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:34390 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeFJQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 12:01:20 -0400
Received: from [192.168.43.42] ([77.136.41.215])
        by mwinf5d55 with ME
        id x41E1x0084eY8hp0341EfS; Sun, 10 Jun 2018 18:01:17 +0200
X-ME-Helo: [192.168.43.42]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Jun 2018 18:01:17 +0200
X-ME-IP: 77.136.41.215
Subject: Re: [PATCH] EDAC, altera: Fix an error handling path in
 'mv64x60_pci_err_probe()'
To: thor.thayer@linux.intel.com, bp@alien8.de, mchehab@kernel.org
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.janitors
References: <20180610153423.10769-1-christophe.jaillet@wanadoo.fr>
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Message-ID: <2fc37391-e491-a68a-ad45-cf39cf7595d5@wanadoo.fr>
Date: Sun, 10 Jun 2018 18:01:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180610153423.10769-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 180610-2, 10/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/06/2018 à 17:34, Christophe JAILLET a écrit :
> IF 'regmap_write()' fails, we should release some resources as done in all
> the other error handling paths of the function.
> 
> Fixes: e9918d7fafae ("EDAC, altera: Handle SDRAM Uncorrectable Errors on Stratix10")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/edac/altera_edac.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index d0d5c4dbe097..5762c3c383f2 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -730,7 +730,8 @@ static int altr_s10_sdram_probe(struct platform_device *pdev)
>   			 S10_DDR0_IRQ_MASK)) {
>   		edac_printk(KERN_ERR, EDAC_MC,
>   			    "Error clearing SDRAM ECC count\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err2;
>   	}
>   
>   	if (regmap_update_bits(drvdata->mc_vbase, priv->ecc_irq_en_offset,
> 

Wrong subjet, will resend a v2 for that.
