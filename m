Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD91C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44982085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD29YydG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44982085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJLJU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:20:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37152 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeJLJU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:20:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so11354072wmt.2;
        Thu, 11 Oct 2018 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lbPDkw8B79vAveAPAAnDcRQbuEznomdsJGqz3Eo/Jd4=;
        b=uD29YydGo71HARPGUNanbZLnwT28fSpI+GuTcKq3l2+ca7MPS9Bh8WJvM9PJ5uDKgD
         j+B1nQWkQnMpIx2neXQrpleXpNmXq+8SfgzefRYDYcxtkDyzGBNAF7oeXcBhJ3l32hHl
         ddS7FeDcTWWncO2ns/IDaCWOA6Gumt1C6USYX4r3N0ZuzIF1OrOJs/sIvIlCS+782Na2
         DfUiS4lpyaryiVuioGooKmhEmjzTJ7Lp/fCoLddzu5KuMszJMSFRa6GBJv5GqbgUs5F+
         HpUGI2yX9Lm7oUrPPKU0T3lSa/ZzhkoeuVm2FqKDNiFmM5RTvYfiJvzfIX0KgFN846q2
         Q3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbPDkw8B79vAveAPAAnDcRQbuEznomdsJGqz3Eo/Jd4=;
        b=oeHeIUysNLUciX0IrA+z53a9VbolUNbMkL5LZ2Iom6KCcHbdrVBVbJt4fZNp11XFPn
         xij1B0fQAXhjrBeNghqO6yE3+vu+WOjfk1eseD5hvl301ZZoerBTQOaaEF0L6Jl/m84x
         twRpxg9AOD3DTz0g7KSs6qj4gGwJHY4b5l9tz5t9WoHQ4SHM7c8FUlVA5h6pfe/jkoRm
         +oJXh9vhkdgYjQjzMHVupErYrIxoOB38aP3mz/LFh9xIBBEBr9XnpKkAtDlGo9bt76Rs
         +sljGUWs1XbGkVKcYmjJXVLhrOnC3S5LHYjL9YJHnL9aV1wOm/+cVUJaeTYO4FKJ+7Ts
         DpIA==
X-Gm-Message-State: ABuFfoi/K80rai4mh566i2sDRMWuDoXikVvrVT6CHEn8h+4zjEJDBfFb
        N9uy7rM6iKfPItSbF12eQVgPG0NbiOvgKQ==
X-Google-Smtp-Source: ACcGV61NexnTQKvkWvKAvYMaQJ9Up+V/jtggPEUxMe8Z4LkVLT1poI0mhI3zQYgBosWYwDOSpb8KWQ==
X-Received: by 2002:a7b:c259:: with SMTP id b25-v6mr3401102wmj.138.1539309025402;
        Thu, 11 Oct 2018 18:50:25 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l38-v6sm26845111wre.38.2018.10.11.18.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 18:50:24 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:50:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     ndesaulniers@google.com
Cc:     jejb@linux.vnet.ibm.com, dhowells@redhat.com, ebiggers@google.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-ID: <20181012015022.GA7508@flashbox>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011203126.15338-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 01:31:26PM -0700, ndesaulniers@google.com wrote:
> by swapping h2 and h3.
> 
> security/keys/trusted.c:146:17: warning: passing an object that
> undergoes default
>       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>         va_start(argp, h3);
>                        ^
> security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> char' is declared here
> unsigned char *h2, unsigned char h3, ...)
>                                ^
> 
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
> Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  security/keys/trusted.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index b69d3b1777c2..d425b2b839af 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
>   */
>  static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  			unsigned int keylen, unsigned char *h1,
> -			unsigned char *h2, unsigned char h3, ...)
> +			unsigned char h2, unsigned char *h3, ...)

Prototype needs to be updated in include/keys/trusted.h and it looks
like this function is used in crypto/asymmetric_keys/asym_tpm.c so these
same changes should be made there.

Otherwise, looks good to me! Thanks for sending the patch.

Nathan

>  {
>  	unsigned char paramdigest[SHA1_DIGEST_SIZE];
>  	struct sdesc *sdesc;
> @@ -139,7 +139,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  		return PTR_ERR(sdesc);
>  	}
>  
> -	c = h3;
> +	c = h2;
>  	ret = crypto_shash_init(&sdesc->shash);
>  	if (ret < 0)
>  		goto out;
> @@ -163,7 +163,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
>  	if (!ret)
>  		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
>  				  paramdigest, TPM_NONCE_SIZE, h1,
> -				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
> +				  TPM_NONCE_SIZE, h3, 1, &c, 0, 0);
>  out:
>  	kzfree(sdesc);
>  	return ret;
> @@ -508,7 +508,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  	if (pcrinfosize == 0) {
>  		/* no pcr info specified */
>  		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> -				   sess.enonce, td->nonceodd, cont,
> +				   sess.enonce, cont, td->nonceodd,
>  				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
>  				   td->encauth, sizeof(uint32_t), &pcrsize,
>  				   sizeof(uint32_t), &datsize, datalen, data, 0,
> @@ -516,7 +516,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  	} else {
>  		/* pcr info specified */
>  		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> -				   sess.enonce, td->nonceodd, cont,
> +				   sess.enonce, cont, td->nonceodd,
>  				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
>  				   td->encauth, sizeof(uint32_t), &pcrsize,
>  				   pcrinfosize, pcrinfo, sizeof(uint32_t),
> @@ -608,12 +608,12 @@ static int tpm_unseal(struct tpm_buf *tb,
>  		return ret;
>  	}
>  	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
> -			   enonce1, nonceodd, cont, sizeof(uint32_t),
> +			   enonce1, cont, nonceodd, sizeof(uint32_t),
>  			   &ordinal, bloblen, blob, 0, 0);
>  	if (ret < 0)
>  		return ret;
>  	ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
> -			   enonce2, nonceodd, cont, sizeof(uint32_t),
> +			   enonce2, cont, nonceodd, sizeof(uint32_t),
>  			   &ordinal, bloblen, blob, 0, 0);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.19.0.605.g01d371f741-goog
> 
