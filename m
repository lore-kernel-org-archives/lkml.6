Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E364AC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF89F20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBTunrz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF89F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbeKGD3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:29:23 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34559 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeKGD3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:29:22 -0500
Received: by mail-yb1-f196.google.com with SMTP id n140-v6so5716693yba.1;
        Tue, 06 Nov 2018 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V7MKniJrLGnT6fCb4/VZFF1SNAIkJZJR8OHmmwCr30I=;
        b=gBTunrz5xVRozQVadmubG/bhimR9cpJY20JnpkIFYtz87KI25cN+fX+AbuDu9uuQk+
         vMXKVdS+OhE/JosyH1DusmoOG/AIpmtKBDh3kX7ps3j2TpWMNC8/gQZtB0PXCR2Hjt+g
         QsP+RrXLfvJb3jzJRtkbjOHG7ctY4ao7eP5u+rGHZsqsQmSwxXUeKhQ0VKYxCSOyceEo
         ABXJPFMRMedwDx4ZG3KvOAPy24s7Gsysx89d+2Th6GlyNEWO/fWA0c320Q008E9qvIco
         Ml4qFZxfb/U9JTueCCXNw4sq09eI0K3WEjWpTIY1S+vVbfhz+BegZ/izwZQuf8LEmXQE
         8wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V7MKniJrLGnT6fCb4/VZFF1SNAIkJZJR8OHmmwCr30I=;
        b=OKGNNAWwclhmzSKkus7xrCgrw6qrfWn+6RhpBgUu9gQMrMTXgtsn7cCpLE0LQ9J01r
         oBxpBzcHtkVp9SdRurR1QaG9Ke3lvkxXtD6UX1RSnWGfMSa4NWfrYgSGI7dQlQn7Nlov
         icZI+aJ3lojGguSw4X/fqfLjx52zDyOXgQBJWREDB4X3F+SY2LjDCxdaI6RlSL0W+Ptt
         jjBbQYE4mSDFhIK1g528HuyO7V23p6doRJZyFxztKEtDLBNbEWxWXhG0c/z6qyNCE+P5
         VSgRX9en9jCqYlNpMzI7N623tIdk05zeZcfUgnHOZ+tjyJrhwGvwwFzjq5op81re8CVt
         9fMQ==
X-Gm-Message-State: AGRZ1gIyYav3fA6MpnBaOpg+rV6AZVjhzj/qLCUWO9mnbiOmzh+TpeIq
        nta3duRqXpzT626M+VlmR9g=
X-Google-Smtp-Source: AJdET5dinlta7wLR64O1NXW1H1B5xEYKOJFj9sOl1BtWf9U+cgzOFBvnkOyKgplXoLD7MX1Ej1xfrA==
X-Received: by 2002:a25:ab86:: with SMTP id v6-v6mr12211384ybi.475.1541527378377;
        Tue, 06 Nov 2018 10:02:58 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 84-v6sm11490679ywn.83.2018.11.06.10.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 10:02:57 -0800 (PST)
Subject: Re: [PATCH] crypto: bcm: fix normal/non key hash algorithm failure
To:     Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Cc:     bcm-kernel-feedback-list@broadcom.com
References: <1541492938-29261-1-git-send-email-raveendra.padasalagi@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <dbac8a57-a1dd-1926-624f-cdbb2e4f6dff@gmail.com>
Date:   Tue, 6 Nov 2018 10:02:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541492938-29261-1-git-send-email-raveendra.padasalagi@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 12:28 AM, Raveendra Padasalagi wrote:
> Remove setkey() callback handler for normal/non key
> hash algorithms and keep it for AES-CBC/CMAC which needs key.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>

Should this have the following Fixes tag?

Fixes: 9d12ba86f818 ("crypto: brcm - Add Broadcom SPU driver")

> ---
>  drivers/crypto/bcm/cipher.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
> index 2d1f1db..4d67e22 100644
> --- a/drivers/crypto/bcm/cipher.c
> +++ b/drivers/crypto/bcm/cipher.c
> @@ -4652,12 +4652,16 @@ static int spu_register_ahash(struct iproc_alg_s *driver_alg)
>  	hash->halg.statesize = sizeof(struct spu_hash_export_s);
>  
>  	if (driver_alg->auth_info.mode != HASH_MODE_HMAC) {
> -		hash->setkey = ahash_setkey;
>  		hash->init = ahash_init;
>  		hash->update = ahash_update;
>  		hash->final = ahash_final;
>  		hash->finup = ahash_finup;
>  		hash->digest = ahash_digest;
> +		if ((driver_alg->auth_info.alg == HASH_ALG_AES) &&
> +		    ((driver_alg->auth_info.mode == HASH_MODE_XCBC) ||
> +		    (driver_alg->auth_info.mode == HASH_MODE_CMAC))) {
> +			hash->setkey = ahash_setkey;
> +		}
>  	} else {
>  		hash->setkey = ahash_hmac_setkey;
>  		hash->init = ahash_hmac_init;
> 


-- 
Florian
