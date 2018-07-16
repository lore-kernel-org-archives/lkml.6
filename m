Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9357ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94339208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axfM/pUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94339208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeGPRua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:50:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32957 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:50:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so15541531plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=86Rtw6gUDAo9afBakUKMWAaoAkmK617VGGybLbfNr4c=;
        b=axfM/pUsRPaih1r+3OtlM9L9SHmHvXyTNtt/cBPdHNCN//zkYF12gjGpbeDw7CVKF1
         qaFwM9yPwYIS4qHS1B9h04N0kvz8/RGd/SvHh2iWTost7AxekxJLZjQsp7dhQTW5iiKi
         sl2cRApGlrzc9LJ35+CFUgxijDHF/+VvQEPyr5ESnwHyFlA7IyXTyV2uFqCu5OGJs9rD
         7qDeB8+na51nTumWx7oqVwxt7Eyd13M7t2389RvzygWg9QjGh3nmhytgKu9mtOlzEZbP
         ygIGmVBy7nawwnlCLXgRopm46X5ImQVYwSI7fNTwgCxxMYwsXA3+EC/mj1ExOmsjOggy
         bFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86Rtw6gUDAo9afBakUKMWAaoAkmK617VGGybLbfNr4c=;
        b=jHG6B+sSawWxsZzNqNCB/ZWIZ74VlZJ7ifba/PZ3rMpvpplrkavaZ4wJSLfA3fzluM
         04O2J8qPgA0yqny+fq7n2OmnLTRzGPzCzwSncOLZ8R0nLUvR/oI4B7rWHedrqD5tjETs
         N3EFgx+7WcdAFQVXz0m961GBl5NcgXLQRukPU22c2eXQS4PoCJB6IqhUnj7LgfOzVj01
         m/JcxrEulZnocZxIdJgHOvYbvxyOB7ZXGdR0P8G/jb1lsa9RyQPfUE268bMV3Y4LTwAH
         sHbJGnKw8x6q/z86x7/b7RTqxCC7XGjwN2P8/yuy3HLCl9HYxuG8lGyLaLt2nojUDkKv
         B4ZA==
X-Gm-Message-State: AOUpUlGKgncuqZeXTsSQAllxwJdwxiU4kPGtXrIHUmWK3uJw8JgrzEse
        H1PXFOl8ncu78wC38ceQLUdeyg==
X-Google-Smtp-Source: AAOMgpfJDdbdbkuqVadhG3XON0Hwigy83P8pPqrRdAa/FFiT+aWADUJxakFIiialK07iRid7WteDIQ==
X-Received: by 2002:a17:902:20ca:: with SMTP id v10-v6mr17244505plg.255.1531761727529;
        Mon, 16 Jul 2018 10:22:07 -0700 (PDT)
Received: from google.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id r25-v6sm39207303pge.81.2018.07.16.10.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:22:06 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:22:05 -0700
From:   Eric Biggers <ebiggers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/power/64: Remove VLA usage
Message-ID: <20180716172205.GB77258@google.com>
References: <20180716035657.GA32180@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716035657.GA32180@beast>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 08:56:57PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
> shash directly and allocating the descriptor in heap memory (which should
> be fine: the tfm has already been allocated there too).
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/power/hibernate_64.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index 67ccf64c8bd8..0ed01bb935a6 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -233,28 +233,31 @@ struct restore_data_record {
>   */
>  static int get_e820_md5(struct e820_table *table, void *buf)
>  {
> -	struct scatterlist sg;
> -	struct crypto_ahash *tfm;
> +	struct crypto_shash *tfm;
> +	struct shash_desc *desc;
>  	int size;
>  	int ret = 0;
>  
> -	tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
> +	tfm = crypto_alloc_shash("md5", 0, 0);
>  	if (IS_ERR(tfm))
>  		return -ENOMEM;
>  
> -	{
> -		AHASH_REQUEST_ON_STACK(req, tfm);
> -		size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry) * table->nr_entries;
> -		ahash_request_set_tfm(req, tfm);
> -		sg_init_one(&sg, (u8 *)table, size);
> -		ahash_request_set_callback(req, 0, NULL, NULL);
> -		ahash_request_set_crypt(req, &sg, buf, size);
> -
> -		if (crypto_ahash_digest(req))
> -			ret = -EINVAL;
> -		ahash_request_zero(req);
> -	}
> -	crypto_free_ahash(tfm);
> +	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
> +		       GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;

Need crypto_free_shash(tfm) if the kmalloc() here fails.

> +
> +	desc->tfm = tfm;
> +	desc->flags = 0;
> +
> +	size = offsetof(struct e820_table, entries) +
> +		sizeof(struct e820_entry) * table->nr_entries;
> +
> +	if (crypto_shash_digest(desc, (u8 *)table, size, buf))
> +		ret = -EINVAL;
> +
> +	kzfree(desc);
> +	crypto_free_shash(tfm);
>  
>  	return ret;
>  }
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security
