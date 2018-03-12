Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeCLONK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:13:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43133 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932509AbeCLONG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:13:06 -0400
Subject: Re: [PATCH 2/2] crypto: talitos: Delete an error message for a failed
 memory allocation in talitos_edesc_alloc()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ad256dc9-a064-37f9-fb8e-aea22ba40a2b@users.sourceforge.net>
 <13bfdc03-1dee-2f1c-da8d-1e452f10c850@users.sourceforge.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1dcf05e3-1552-68b6-96cf-c5b57cd68e03@c-s.fr>
Date: Mon, 12 Mar 2018 15:13:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <13bfdc03-1dee-2f1c-da8d-1e452f10c850@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/03/2018 à 14:32, SF Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 12 Mar 2018 14:18:23 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   drivers/crypto/talitos.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index a2271322db34..4c7318981d28 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -1399,7 +1399,6 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
>   
>   	edesc = kmalloc(alloc_len, GFP_DMA | flags);
>   	if (!edesc) {
> -		dev_err(dev, "could not allocate edescriptor\n");
>   		err = ERR_PTR(-ENOMEM);
>   		goto error_sg;
>   	}
> 
