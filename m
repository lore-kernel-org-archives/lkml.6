Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeCEI7v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:59:51 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:59181 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933424AbeCEI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:59:49 -0500
Subject: Re: [PATCH 2/4] crypto: omap-sham - Fix misleading indentation
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
References: <1519937413-24468-1-git-send-email-krzk@kernel.org>
 <1519937413-24468-2-git-send-email-krzk@kernel.org>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <fe1ae684-9f16-e31e-c88e-3e9df083e012@ti.com>
Date: Mon, 5 Mar 2018 10:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519937413-24468-2-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/18 22:50, Krzysztof Kozlowski wrote:
> Commit 8043bb1ae03c ("crypto: omap-sham - convert driver logic to use
> sgs for data xmit") removed the if() clause leaving the statement as is.
> The intention was in that case to finish the request always so the goto
> instruction seems sensible.
> 
> Remove the indentation to fix Smatch warning:
>      drivers/crypto/omap-sham.c:1761 omap_sham_done_task() warn: inconsistent indenting
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/crypto/omap-sham.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
> index 7650b1b449bb..6cb6ab6f52c0 100644
> --- a/drivers/crypto/omap-sham.c
> +++ b/drivers/crypto/omap-sham.c
> @@ -1758,7 +1758,7 @@ static void omap_sham_done_task(unsigned long data)
>   		if (test_and_clear_bit(FLAGS_OUTPUT_READY, &dd->flags)) {
>   			/* hash or semi-hash ready */
>   			clear_bit(FLAGS_DMA_READY, &dd->flags);
> -				goto finish;
> +			goto finish;
>   		}
>   	}
>   
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
