Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E2BC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE6724AEC
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgaau846"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE6724AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeFWClx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:41:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41515 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934625AbeFWClw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:41:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so4288845ply.8;
        Fri, 22 Jun 2018 19:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jtquc1jN/9AVahUJ+O/biPGKIbL6lgAZorLtDU6WAG0=;
        b=bgaau846uFub8cr/N4T6viUNuxxtty+wjAUPh5BhOYSe2JkYBChqwfy50XA+VLT/kL
         O0Fac2+YsRODy7UUyzP59ec7pAR1we8jS1L3Lk5XzzoBzr/1X+3m+Ky6nADXdDEn4VoV
         vSOqNOLhdFT8iG/9lRH/fu89xf7E8NOVSSrX6hzZC515+4BYfCzpgitnJfOuJtPzqtTn
         7lq+y2wVEKa9nUupprqc8/OuGpBO/nJVx4rj+0RwXLMBcm9m1rhwoNDlhxphdboFIY+O
         BqEBlxYFqg+EKITI9tity6ZarNgyGjrAL2K5y/47P3Mg8XDv2ai6r6ckQvpz1ldM5Q2P
         dN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jtquc1jN/9AVahUJ+O/biPGKIbL6lgAZorLtDU6WAG0=;
        b=s1wUMZ9esFETdSvTtUPSXJN5c/bJsNztxrbCG0VKv+gCgqnelzBRJjpW5e5QJbN1AC
         T0DSzn5mUoe6ThLD2dbj3b4o2f8qGDGwKWmXeqXvFQKpTSG4ftJ4LfkJnbfCjg46CNsh
         HMDWhuB4xk5MKLBupfhYt/xuh3W151/5YiY2gPW4pYdwoYdTLI8eUhQ+O6R3PvfbjMGc
         /IQU9tOrjdl9GIghMDjqg86VHzQFXB7OBY9cWvXzH1BEOCGzq0CKLvjAUWb29ocjfS17
         b/OcMwHMwZk8+e5+rTb3CFIvy2gcPWCw7cCcIxdkOu/TXdozCEdPxjjuiJbbLaU8OPwV
         /y0w==
X-Gm-Message-State: APt69E112WI1dzQNNNHIRGIIsObzncAv5N0aqEdVlbrCkYFo4vbs0ZNL
        OQyQHsX7koRY5LP9Z37QcFgrRIBR
X-Google-Smtp-Source: ADUXVKJr6gYFswnKVWM4QOT26Oj/cRBUGnxzkHb7WV/TUcOeq7BJl+My2tIzTlsMwsOM4cfvwSubXg==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17-v6mr3983126plo.9.1529721711818;
        Fri, 22 Jun 2018 19:41:51 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x2-v6sm12740365pfn.11.2018.06.22.19.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 19:41:51 -0700 (PDT)
Date:   Fri, 22 Jun 2018 19:41:49 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 1/2] crypto: Fix -Wstringop-truncation warnings
Message-ID: <20180623024149.GB880@sol.localdomain>
References: <20180623020753.27266-1-shorne@gmail.com>
 <20180623020753.27266-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180623020753.27266-2-shorne@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 11:07:52AM +0900, Stafford Horne wrote:
> As of GCC 9.0.0 the build is reporting warnings like:
> 
>     crypto/ablkcipher.c: In function ‘crypto_ablkcipher_report’:
>     crypto/ablkcipher.c:374:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
>       strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        sizeof(rblkcipher.geniv));
>        ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This means the strnycpy might create a non null terminated string.  Fix this by
> limiting the size of the string copy to include the null terminator.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  crypto/ablkcipher.c | 4 ++--
>  crypto/blkcipher.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
> index d880a4897159..972cd7c879f6 100644
> --- a/crypto/ablkcipher.c
> +++ b/crypto/ablkcipher.c
> @@ -372,7 +372,7 @@ static int crypto_ablkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>  
>  	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
>  	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
> -		sizeof(rblkcipher.geniv));
> +		sizeof(rblkcipher.geniv) - 1);
>  
>  	rblkcipher.blocksize = alg->cra_blocksize;
>  	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> @@ -446,7 +446,7 @@ static int crypto_givcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>  
>  	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
>  	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
> -		sizeof(rblkcipher.geniv));
> +		sizeof(rblkcipher.geniv) - 1);
>  
>  	rblkcipher.blocksize = alg->cra_blocksize;
>  	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
> index 01c0d4aa2563..f1644b5cf68c 100644
> --- a/crypto/blkcipher.c
> +++ b/crypto/blkcipher.c
> @@ -511,7 +511,7 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>  
>  	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
>  	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
> -		sizeof(rblkcipher.geniv));
> +		sizeof(rblkcipher.geniv) - 1);
>  
>  	rblkcipher.blocksize = alg->cra_blocksize;
>  	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;

Your "fix" introduces an information disclosure bug, as it results in
uninitialized memory being copied to userspace.  This same broken patch was sent
by someone else too.

Maybe it would be best to just memset() the crypto_report_* structs to 0 after
declaration and then replace the strncpy()'s with strscpy()'s, even if just to
stop people from sending broken "fixes".  Do you want to do that?

- Eric
