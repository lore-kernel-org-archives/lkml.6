Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933522AbeCEI7Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:59:25 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:52515 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933424AbeCEI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:59:22 -0500
Subject: Re: [PATCH 1/4] crypto: omap-sham: Remove useless check for non-null
 request
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
References: <1519937413-24468-1-git-send-email-krzk@kernel.org>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <4062df04-e605-60c1-0cab-2d519efdc4b1@ti.com>
Date: Mon, 5 Mar 2018 10:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519937413-24468-1-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/18 22:50, Krzysztof Kozlowski wrote:
> ahash_request 'req' argument passed by the caller
> omap_sham_handle_queue() cannot be NULL here because it is obtained from
> non-NULL pointer via container_of().
> 
> This fixes smatch warning:
>      drivers/crypto/omap-sham.c:812 omap_sham_prepare_request() warn: variable dereferenced before check 'req' (see line 805)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/crypto/omap-sham.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
> index 86b89ace836f..7650b1b449bb 100644
> --- a/drivers/crypto/omap-sham.c
> +++ b/drivers/crypto/omap-sham.c
> @@ -809,9 +809,6 @@ static int omap_sham_prepare_request(struct ahash_request *req, bool update)
>   	bool final = rctx->flags & BIT(FLAGS_FINUP);
>   	int xmit_len, hash_later;
>   
> -	if (!req)
> -		return 0;
> -
>   	bs = get_block_size(rctx);
>   
>   	if (update)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
