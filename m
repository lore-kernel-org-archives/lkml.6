Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A986FC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623EE2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8F4CXK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623EE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933077AbeFTXmv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:42:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34983 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932597AbeFTXmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:42:36 -0400
Received: by mail-pf0-f194.google.com with SMTP id c22-v6so554057pfi.2;
        Wed, 20 Jun 2018 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=th9nn/aCwE+JUnbogInTYjEi2QI03gTSTd0O9iFYQJs=;
        b=Z8F4CXK//6f+QLKs0imC1c7wH4VTY8JQZ9y+VHjRid7Qw8kHFukrqoFoGWtGgJxHKt
         AV0FTsIYyKls6bS589GnNCtY+c3KxU6/EDvU7a5dMsHLEQvk2H0zk6pcAuYcqIKseG4N
         aYY8nV+admPJycsk8UZBKD4xGcJzczwYNLcDN2cdAQ84QRdiKLR+Q0KlyXe3I6Rlb2VH
         dHkEyb4/pwECzMAxfNmA6VUGjfvqXiZDh9OyMzR6JgS3Gi+ltWfalGAnxwoSzftL62HH
         SLqKai+E6sC/ilRk70skWc7vbGBj9ClrPfdr6Um1p/KPGB0IQNYsQdHHTvZU3Q6HCcYg
         SVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=th9nn/aCwE+JUnbogInTYjEi2QI03gTSTd0O9iFYQJs=;
        b=hYhk4LANL9ChLKfs9ToJiItd/l+O6sqQqu+KMRxGf7BAzi5rNlljk+qWDpEvaOXaBV
         qb4KJBFigUhsDl4fnDua9u3A5JKDswQKReM3uBSVDWtYDGknxMmq25ZpJvqtbyhXUNy9
         dsCi5mU1hPbE4b9/sQUbEaarZi6bEA3zBMcHUV38ImnJyFagwxrykuWUHZ1ksIk4mh7k
         yIGa3MiFS/61EYIV2fL3lMQ/Q5kxrjrFzIq63P7chyEWBuIUvDXDKrw49CArRL7bFRb8
         nSEND/7TiEy8dl1memm+keFfEUA1tJRi9vgifQW7ja+rK6wGUK3ex25UC0b+nue33n+Z
         3e6Q==
X-Gm-Message-State: APt69E3FMgNgmpW+JQI2ErkuHCLTEFaHMDIFe2vIxohl5MMLGcKMXn2N
        8Ad4aYWUpkc2/vgVo9OfebV82uoHP/w=
X-Google-Smtp-Source: ADUXVKLNzMJWWOH2iD0f23nlI3U7ocL8XJ7psfBRU2zAPsAgX8KYyM2A1ysqypixz64FfhSsnOujsg==
X-Received: by 2002:a62:50d6:: with SMTP id g83-v6mr24762185pfj.31.1529538155913;
        Wed, 20 Jun 2018 16:42:35 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id c17-v6sm5478420pgw.11.2018.06.20.16.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:42:35 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:42:33 -0700
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
Subject: Re: [dm-devel] [PATCH 06/11] crypto: cbc: Remove VLA usage
Message-ID: <20180620234233.GD111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620190408.45104-7-keescook@chromium.org>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:04:03PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the upper bounds on blocksize.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/crypto/cbc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
> index f5b8bfc22e6d..260096bcf99b 100644
> --- a/include/crypto/cbc.h
> +++ b/include/crypto/cbc.h
> @@ -113,7 +113,7 @@ static inline int crypto_cbc_decrypt_inplace(
>  	unsigned int bsize = crypto_skcipher_blocksize(tfm);
>  	unsigned int nbytes = walk->nbytes;
>  	u8 *src = walk->src.virt.addr;
> -	u8 last_iv[bsize];
> +	u8 last_iv[CRYPTO_ALG_MAX_BLOCKSIZE];
>  

Why not MAX_CIPHER_BLOCKSIZE?

- Eric
