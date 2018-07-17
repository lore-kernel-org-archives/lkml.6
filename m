Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5F2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E1920693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtKtcUjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E1920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeGQRRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:17:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32829 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbeGQRRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:17:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so692535pgv.0;
        Tue, 17 Jul 2018 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LVliLGUXjJx6K5xTmsCB+TKQAknILrDDERvjEifRfM=;
        b=KtKtcUjGAdjyGmcjyoFyYy9yiiwTnPn//AU3FLkUDu+U9wvuo0HQ/9b7A2oY+tnxz0
         ngCGKFkzTG3vO/1QRSMWxW9cirTj7HHDqS3pIqkG2ll2Xfuds8aTRQvOysQYScrzF6aw
         T0SBrOztOU4phES6xYtNLh1wWHsyX0vSTAfFCLs7C3VQD5GRMhXa0VbPY7o6EW4oqGwF
         eNYdWqHZGx4ivzBKyHrKUi8cEBCI//K2voJw9x7d566s5hr5Fgc9HXsgNBuzaSz4+EqI
         zB0p8XeqC9+fqfAUR/4kGePDeOraXgw0ybJY6fox5da2YVncboVhuq5oXfCefOyTPue8
         zeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LVliLGUXjJx6K5xTmsCB+TKQAknILrDDERvjEifRfM=;
        b=NYFlO89s+2vV2rbZ+Czkubohimr0QoEqG7kkFkpWQgMHWDkExadSj7Urbj8WUbYksf
         GQ9PtMmlhqoWEWMj/fBhKRiayHJSdHXJPNf1YIhutqF1Mu4EZ0XKyw/BAMiW0vLQ2tce
         9V5g7nbZ046hB+woaDXYkscNGW3qFiIjOIIrjX7BHuRNYNELzvPicmUuPVAl78ZRdQI5
         mUETmpUhjJV9EXzlaJ7spBW4/Fg3zm/ieodk3mk7aNFIf0XNMSNpRAFh9ERJFVGHoT8E
         sdPHN8oRjY8LfQuTDlqvnPJtOH37bCAc9nYtZkSzNWibro7tkhoi6NdrFHlLvETuDPro
         mX+g==
X-Gm-Message-State: AOUpUlF3o8nqyF4yK3nmcHnxG67N2DFdOgY0VGIUdOTcWkhxuEdAcJCW
        SSdK3Oc4wTNMJ9s+NF97rQY=
X-Google-Smtp-Source: AAOMgpdkesPzs2KmkWA7XQgW35SdCiuaVtVX/ojOT0TQz09/Itp+qxP7Z4pGdV49dDSxdo+e2ArUlw==
X-Received: by 2002:a65:66d7:: with SMTP id c23-v6mr2280659pgw.427.1531845840501;
        Tue, 17 Jul 2018 09:44:00 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id l84-v6sm3862872pfg.3.2018.07.17.09.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 09:44:00 -0700 (PDT)
Date:   Tue, 17 Jul 2018 09:43:58 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>, qat-linux@intel.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-crypto@vger.kernel.org, Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [dm-devel] [PATCH v5 10/11] crypto: ahash: Remove VLA usage for
 AHASH_REQUEST_ON_STACK
Message-ID: <20180717164358.GC75957@gmail.com>
References: <20180717042150.37761-1-keescook@chromium.org>
 <20180717042150.37761-11-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717042150.37761-11-keescook@chromium.org>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:21:49PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this caps
> the ahash request size similar to the other limits and adds a sanity
> check at initialization. AHASH_REQUEST_ON_STACK is special, though: it
> is only ever used for shash-wrapped ahash, so its size is bounded only
> by non-async hashes. A manual inspection of this shows the largest to be:
> sizeof(struct shash_desc) + SHASH_MAX_DESCSIZE
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/shash.c        |  9 ++++++++-
>  include/crypto/hash.h | 10 +++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/shash.c b/crypto/shash.c
> index 8d4746b14dd5..e344560458cb 100644
> --- a/crypto/shash.c
> +++ b/crypto/shash.c
> @@ -355,6 +355,7 @@ int crypto_init_shash_ops_async(struct crypto_tfm *tfm)
>  	struct crypto_ahash *crt = __crypto_ahash_cast(tfm);
>  	struct crypto_shash **ctx = crypto_tfm_ctx(tfm);
>  	struct crypto_shash *shash;
> +	size_t reqsize;
>  
>  	if (!crypto_mod_get(calg))
>  		return -EAGAIN;
> @@ -365,6 +366,12 @@ int crypto_init_shash_ops_async(struct crypto_tfm *tfm)
>  		return PTR_ERR(shash);
>  	}
>  
> +	reqsize = sizeof(struct shash_desc) + crypto_shash_descsize(shash);
> +	if (WARN_ON(reqsize > AHASH_MAX_REQSIZE)) {
> +		crypto_mod_put(calg);
> +		return -EINVAL;
> +	}

'crypto_free_shash(shash);' instead of 'crypto_mod_put(calg);'

- Eric
