Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F96C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D64F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D64F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJVRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:17:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53834 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeJJVRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:17:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D482B207BB; Wed, 10 Oct 2018 15:55:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id A207620618;
        Wed, 10 Oct 2018 15:55:13 +0200 (CEST)
Date:   Wed, 10 Oct 2018 15:55:14 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: inside-secure: safexcel - fix memory allocation
Message-ID: <20181010135514.GC3368@kwain>
References: <20181008191712.GA12892@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008191712.GA12892@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Mon, Oct 08, 2018 at 09:17:12PM +0200, Gustavo A. R. Silva wrote:
> The original intention is to allocate space for EIP197_DEFAULT_RING_SIZE
> *pointers* to struct, so sizeof(priv->ring[i].rdr_req) should be
> sizeof(*priv->ring[i].rdr_req).
> 
> Addresses-Coverity-ID: 1473962 ("Sizeof not portable")
> Fixes: 9744fec95f06 ("crypto: inside-secure - remove request list to improve performance")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Good catch, thanks!
Antoine

> ---
>  drivers/crypto/inside-secure/safexcel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> index 86c699c1..bc6c5cb 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -1066,7 +1066,7 @@ static int safexcel_probe(struct platform_device *pdev)
>  
>  		priv->ring[i].rdr_req = devm_kcalloc(dev,
>  			EIP197_DEFAULT_RING_SIZE,
> -			sizeof(priv->ring[i].rdr_req),
> +			sizeof(*priv->ring[i].rdr_req),
>  			GFP_KERNEL);
>  		if (!priv->ring[i].rdr_req) {
>  			ret = -ENOMEM;
> -- 
> 2.7.4
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
