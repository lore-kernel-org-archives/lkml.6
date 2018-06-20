Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F466C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0FB20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq4zhwAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0FB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933146AbeFTXkh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:40:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38958 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeFTXke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:40:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so546716pfl.6;
        Wed, 20 Jun 2018 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sBu7Ebf4sjnNOBuCZ4IAv5e6w/dU1nCIwd7epmp5m3Y=;
        b=Pq4zhwAbeyeV+ZPoddLV8zGkHKp/jPRAWWayuU0N7WEH5SwvHUxQMOmuQgeJjpQI0i
         5WUe/DVTU2UZ79qfyB9vCJ5cwagIjVXwMGoeJlFIsiQMznKPrASGXZzdrEDpdT3c4pec
         d/7KFK7OxC1nvCuqRUUXW4hdPLQESYkuf/H4BLyXIvN+HQjV8j2DHeBI9qOWvJv1JmWm
         YHiiJ1Mz4vVK4b/HyQMyNEIgZQeADADjAQbNuW2VJzJT7eykfyT6bCTxAESzm+8gGi03
         JEbJ80oIN1UH+C9lSokwgxhXX30/W9NO8QoFrz11nt5e2J/DseFp/R0vf9Je8nPa2h3F
         gX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBu7Ebf4sjnNOBuCZ4IAv5e6w/dU1nCIwd7epmp5m3Y=;
        b=aU2cYqaDonl2yehFHBcDjm9/RZ3NuwImpYlkwMp6B7IQB+oDIRhh5/Jv89NZump/wb
         zN9tuztWEm1m4DtRXoYy+mPIVGZflQLk2b4eZQjWFTvc4i7zMuL6oGu7pQnM44f1hW4P
         BL9ONHpkSUXB/pBVrpUypO7vJm3rwDhwWDrDQger7tYd65hx9cTBc0xZQ9FuQ4sUGdy4
         5es9tqOTxjj0U3JyblIoEzFHjkYVQJ4lxF4LweW8BwW0RMCdB9ZVi4LxAccvAm59qDae
         YxaUIgZIfWKeU5M1WJdD/sxFcR30gpfGLr17TOq06VhgDrZQJV44YfU/ELRO1yZ2AW/g
         GGqg==
X-Gm-Message-State: APt69E2G/Ca+N2FdTCkO0J8WrAJLQTtZkNzTTjBrgV8shoq4scgIB0CI
        qX3P+NprFpmc3hF9awsIz7w=
X-Google-Smtp-Source: ADUXVKILEErufo5lcR8PwAqXEgwmJj6Vygg9HjEFuf+e90T6YIyChvA+9lH2odybDBh9HUnE1BH2eQ==
X-Received: by 2002:a65:4241:: with SMTP id d1-v6mr19995297pgq.392.1529538034105;
        Wed, 20 Jun 2018 16:40:34 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id v26-v6sm4838619pfe.13.2018.06.20.16.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:40:33 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:40:31 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-crypto@vger.kernel.org,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [dm-devel] [PATCH 05/11] crypto alg: Introduce max blocksize and
 alignmask
Message-ID: <20180620234031.GC111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620190408.45104-6-keescook@chromium.org>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:04:02PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> exposes the existing upper bound on crypto block sizes for VLA removal,
> and introduces a new check for alignmask (current maximum in the kernel
> is 63 from manual inspection of all cra_alignmask settings).
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/algapi.c        | 5 ++++-
>  include/linux/crypto.h | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index c0755cf4f53f..760a412b059c 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -57,7 +57,10 @@ static int crypto_check_alg(struct crypto_alg *alg)
>  	if (alg->cra_alignmask & (alg->cra_alignmask + 1))
>  		return -EINVAL;
>  
> -	if (alg->cra_blocksize > PAGE_SIZE / 8)
> +	if (alg->cra_blocksize > CRYPTO_ALG_MAX_BLOCKSIZE)
> +		return -EINVAL;
> +
> +	if (alg->cra_alignmask > CRYPTO_ALG_MAX_ALIGNMASK)
>  		return -EINVAL;
>  
>  	if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 6eb06101089f..e76ffcbd5aa6 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -134,6 +134,10 @@
>   */
>  #define CRYPTO_MAX_ALG_NAME		128
>  
> +/* Maximum values for registered algorithms. */
> +#define CRYPTO_ALG_MAX_BLOCKSIZE    (PAGE_SIZE / 8)
> +#define CRYPTO_ALG_MAX_ALIGNMASK    63
> +

How do these differ from MAX_CIPHER_BLOCKSIZE and MAX_CIPHER_ALIGNMASK, and why
are they declared in different places?

- Eric
