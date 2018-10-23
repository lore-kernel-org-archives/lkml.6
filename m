Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6884DC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991E220674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWwU7inQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991E220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJWIVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:21:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55612 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWIVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:21:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id x6-v6so644733wmc.5;
        Mon, 22 Oct 2018 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMozjLO2AkOaduQqwXZYBsZUrZ1QZa9lUM/qe262pPc=;
        b=nWwU7inQfPiJmcM8Fr+mCGTSXIPKbYXB9z9BKS/jAWRH8Bzz5A6ofcgud8YrkVwpWp
         eHR5MqVZaPaQmlpw+nvj2UuRzqkOnjE2iOgcuqpy8SrgUonvQRxlgn3hU/skVmyjqsmu
         agkxtCmvaDaJu40phb0iEV5E6ggIAjatGHHfWGnii1Kicg/JjUyQqgaGtUsGd1Z+w3r6
         WvAHdqPA7HW4bUEtx3MnbG0ZU+DBwinoA1XzmCIs4+Au3cZ3FxulbvFM09qn1c+0/0hJ
         Zw8KNtZrJt/T/qW6VQQ88RQQWWZNb8RPClIgqQwq5S0gFsu9O7mwEGDs9FP27L6TMzEY
         uKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMozjLO2AkOaduQqwXZYBsZUrZ1QZa9lUM/qe262pPc=;
        b=eRKuCGv0xQ4n6xdJBCxjsvk/i1lS0ru7tOzAQzberdawO1ED6qSrWc3zLX4CfaMwCr
         57sVTDTCkgzj5zxS9o8uC1L9s62s2B0cEuU/gqdlzhjzoS+2jhWQ4Xtta+Z9j0Aa40XQ
         CzuX2r5ctZpaMPW4Fnwmyfsia6FobUd1F42bCxQ3e2KyedG9YvcNPp/jp1gydxQ+BrXu
         sdv9+XUV2a9lKZb7oQy3rOvvbv/gwSxVEXMm+VIKlPRVtRK8gaLdHx2okZ0A+bemhGH/
         DQnky1JNtFtmaVxRj3REhiCr1T+ijQmI6X0oyyYD00FoHvHKy/JbGW75sUcYlRTQYz07
         MOHw==
X-Gm-Message-State: AGRZ1gLwiGWAdYuU1y7Ovmux/xlBqVMfqPcJAGX7PL2b7/HzhlNm0Ixi
        WAHN+mbMjhvHzzoJiRN7eKw=
X-Google-Smtp-Source: ACcGV61XyEuOu5vVXkIvuaWNF4lQFHSAdzjHcmTZar5ECOyIcocFXxVC2c5krCVcQEAcJnLJlH2KAw==
X-Received: by 2002:a1c:85d0:: with SMTP id h199-v6mr17714382wmd.127.1540252855135;
        Mon, 22 Oct 2018 17:00:55 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x12-v6sm2482547wmd.32.2018.10.22.17.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 17:00:54 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:00:51 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     ndesaulniers@google.com
Cc:     dhowells@redhat.com, jejb@linux.vnet.ibm.com,
        David.Laight@aculab.com, denkenz@gmail.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
Message-ID: <20181023000051.GA17367@flashbox>
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
 <20181022234357.82217-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022234357.82217-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 04:43:57PM -0700, ndesaulniers@google.com wrote:
> Fixes the warning reported by Clang:
> security/keys/trusted.c:146:17: warning: passing an object that
> undergoes default
>       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>         va_start(argp, h3);
>                        ^
> security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> char' is declared here
> unsigned char *h2, unsigned char h3, ...)
>                                ^
> Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> standards explicitly call this out as undefined behavior:
> 
> The parameter parmN is the identifier of the rightmost parameter in
> the variable parameter list in the function definition (the one just
> before the ...). If the parameter parmN is declared with ... or with a
> type that is not compatible with the type that results after
> application of the default argument promotions, the behavior is
> undefined.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/41
> Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
> Suggested-by: David Laight <David.Laight@aculab.com>
> Suggested-by: Denis Kenzior <denkenz@gmail.com>
> Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> v1 -> v2:
> * Don't reorder args, just use default function promotion type
> of unsigned int.
> * Add !! boolean cast as per Denis in
> https://lkml.org/lkml/2018/10/12/838.
> * Tested with gcc-8 and clang-8.
> 
>  include/keys/trusted.h  | 2 +-
>  security/keys/trusted.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/keys/trusted.h b/include/keys/trusted.h
> index adbcb6817826..0071298b9b28 100644
> --- a/include/keys/trusted.h
> +++ b/include/keys/trusted.h
> @@ -38,7 +38,7 @@ enum {
>  
>  int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  			unsigned int keylen, unsigned char *h1,
> -			unsigned char *h2, unsigned char h3, ...);
> +			unsigned char *h2, unsigned int h3, ...);
>  int TSS_checkhmac1(unsigned char *buffer,
>  			  const uint32_t command,
>  			  const unsigned char *ononce,
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index ff6789365a12..335ce6d1cf6b 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>   */
>  int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  			unsigned int keylen, unsigned char *h1,
> -			unsigned char *h2, unsigned char h3, ...)
> +			unsigned char *h2, unsigned int h3, ...)
>  {
>  	unsigned char paramdigest[SHA1_DIGEST_SIZE];
>  	struct sdesc *sdesc;
> @@ -139,7 +139,7 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  		return PTR_ERR(sdesc);
>  	}
>  
> -	c = h3;
> +	c = !!h3;
>  	ret = crypto_shash_init(&sdesc->shash);
>  	if (ret < 0)
>  		goto out;
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

Thank you for the fix!
Nathan
