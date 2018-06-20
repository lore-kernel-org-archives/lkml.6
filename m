Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69196C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6F820020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6F820020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbeFTUWm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:22:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42492 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933085AbeFTUWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:22:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 419x8W206gz9ttmc;
        Wed, 20 Jun 2018 22:22:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Tndj5VldOE2z; Wed, 20 Jun 2018 22:22:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 419x8W1RMSz9ttmD;
        Wed, 20 Jun 2018 22:22:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8281D8B83D;
        Wed, 20 Jun 2018 22:22:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lYdXz4YwVzwS; Wed, 20 Jun 2018 22:22:39 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE5328B82D;
        Wed, 20 Jun 2018 22:22:38 +0200 (CEST)
Subject: Re: [PATCH 11/11] crypto: skcipher: Remove VLA usage for
 SKCIPHER_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-12-keescook@chromium.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6537de88-cd81-1c96-afc0-45af17a07729@c-s.fr>
Date:   Wed, 20 Jun 2018 20:22:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180620190408.45104-12-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 07:04 PM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> caps the skcipher request size similar to other limits and adds a sanity
> check at registration.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

crypto/echainiv.c: In function ‘echainiv_encrypt’:
crypto/echainiv.c:88:1: warning: the frame size of 2120 bytes is larger 
than 1024 bytes [-Wframe-larger-than=]
crypto/authenc.c: In function ‘crypto_authenc_copy_assoc’:
crypto/authenc.c:197:1: warning: the frame size of 2120 bytes is larger 
than 1024 bytes [-Wframe-larger-than=]
crypto/authencesn.c: In function ‘crypto_authenc_esn_copy’:
crypto/authencesn.c:194:1: warning: the frame size of 2120 bytes is 
larger than 1024 bytes [-Wframe-larger-than=]
crypto/algif_aead.c: In function ‘crypto_aead_copy_sgl’:
crypto/algif_aead.c:90:1: warning: the frame size of 2120 bytes is 
larger than 1024 bytes [-Wframe-larger-than=]

Christophe

> ---
>   include/crypto/internal/skcipher.h | 1 +
>   include/crypto/skcipher.h          | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
> index e42f7063f245..5035482cbe68 100644
> --- a/include/crypto/internal/skcipher.h
> +++ b/include/crypto/internal/skcipher.h
> @@ -130,6 +130,7 @@ static inline struct crypto_skcipher *crypto_spawn_skcipher(
>   static inline void crypto_skcipher_set_reqsize(
>   	struct crypto_skcipher *skcipher, unsigned int reqsize)
>   {
> +	BUG_ON(reqsize > SKCIPHER_MAX_REQSIZE);
>   	skcipher->reqsize = reqsize;
>   }
>   
> diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
> index 2f327f090c3e..25294d0089b2 100644
> --- a/include/crypto/skcipher.h
> +++ b/include/crypto/skcipher.h
> @@ -139,9 +139,11 @@ struct skcipher_alg {
>   	struct crypto_alg base;
>   };
>   
> +#define SKCIPHER_MAX_REQSIZE	(PAGE_SIZE / 8)
> +
>   #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
>   	char __##name##_desc[sizeof(struct skcipher_request) + \
> -		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
> +		SKCIPHER_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
>   	struct skcipher_request *name = (void *)__##name##_desc
>   
>   /**
> 
