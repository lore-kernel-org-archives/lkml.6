Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EyjZM19LHVsgPwAAmS7hNA
	; Sun, 10 Jun 2018 16:01:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C3A2F60795; Sun, 10 Jun 2018 16:01:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5465D6070A;
	Sun, 10 Jun 2018 16:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5465D6070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeFJQB1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 12:01:27 -0400
Received: from [195.159.176.226] ([195.159.176.226]:39132 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbeFJQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 12:01:25 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1fS2kG-0003pu-GX
        for linux-kernel@vger.kernel.org; Sun, 10 Jun 2018 17:59:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] EDAC, altera: Fix an error handling path in
 'mv64x60_pci_err_probe()'
Date: Sun, 10 Jun 2018 18:01:12 +0200
Message-ID: <2fc37391-e491-a68a-ad45-cf39cf7595d5@wanadoo.fr>
References: <20180610153423.10769-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
In-Reply-To: <20180610153423.10769-1-christophe.jaillet@wanadoo.fr>
Content-Language: fr
X-Antivirus: Avast (VPS 180610-2, 10/06/2018), Outbound message
X-Antivirus-Status: Clean
Cc: kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180610160112.v5I4Ai-OBo68oymnQUgKLJD0x4lFst_ukuG44IF60J8@z>

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
