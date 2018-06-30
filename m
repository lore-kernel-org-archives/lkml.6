Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBDCC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 07:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBC5254E8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFeWP76D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBC5254E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755488AbeF3HDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 03:03:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36166 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeF3HDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 03:03:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id m19-v6so1379276pgv.3;
        Sat, 30 Jun 2018 00:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tF0srp8upk7cKEmXjwaUu+XJYICv1Y1m/MyQyyySJ24=;
        b=HFeWP76DEO97H8mMD/YE6yesOVTXhpuJsqbfYj2PtvrxXX5dz97HNN6n05ApOc/Sxc
         RQQFhzStE3AII4wFhssIHwURS8602RYE0/2UnhNdNIKcAHRSOh0jFKupj8wyif927N1U
         epQ4twmRJseFITedOYjF07Ad4xd1LHBNK2NuxD63RnqiTCTZvw1rL3wP2Y2XFqw7eG3+
         Mw4r9/b/PNBL1/TvER/JpXQp5ZTYk6kvfywpseeRJqRtlucYNTBnVBCr72LUbo+pREHN
         Q39ELjkWRk0jNN/owONFD7wkBSR9063EaJzvI6ryfo705t0oOG2fToe3pSwGN1lFSsZQ
         FKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tF0srp8upk7cKEmXjwaUu+XJYICv1Y1m/MyQyyySJ24=;
        b=d8jWV90CDPRnQBKrvIR83glHu0oUIJShXRhhojsRHMi2lQmG5d02YqCEDoUBwpJSUC
         XjLrnva+YZaZqFVH4SyQtDoZWd7fVWXIWnkT1ddNWvJ/oqfLhNopiFQAr0nr/fSbRQ+n
         F3UoGzMOEND3n/8MJ+wCHFJDaIQMB+nym1T8xndT8ElAhKv3obg+w7fA/f7eltMHZg9P
         7Cz3n8usBD7btf7IT7flPNjEAuw0ccJhepOiH3EfLEbTS4XAnMJ5aCPzSqlOjkoQeGDq
         zxeG3bBWXihRk77retdgqdA49Ts5TeKGZ79AQB3TkVRgBtIl2PYkMdR4cieLHefp9fSL
         p9ww==
X-Gm-Message-State: APt69E1E7CPUaunokf66GKU7F/SZRhVou74JMuBltqv94T8CxcBlDbTb
        vfeAe/F70RtNN1o9klfeEPo=
X-Google-Smtp-Source: AAOMgpdqFBgowaayXxPp/4CnDh7XBwEMQNb0RzgA3Sc97jZhlAX9XU9DfOQ5ImJzrnIXyXG0TLK3bg==
X-Received: by 2002:a62:db05:: with SMTP id f5-v6mr17150690pfg.123.1530342184444;
        Sat, 30 Jun 2018 00:03:04 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id u15-v6sm23939455pfk.174.2018.06.30.00.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 00:03:03 -0700 (PDT)
Date:   Sat, 30 Jun 2018 00:03:01 -0700
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
Subject: Re: [dm-devel] [PATCH v3 9/9] crypto: shash: Remove VLA usage in
 unaligned hashing
Message-ID: <20180630070301.GA1706@sol.localdomain>
References: <20180629002843.31095-1-keescook@chromium.org>
 <20180629002843.31095-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629002843.31095-10-keescook@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 05:28:43PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this uses
> the newly defined max alignment to perform unaligned hashing to avoid
> VLAs, and drops the helper function while adding sanity checks on the
> resulting buffer sizes. Additionally, the __aligned_largest macro is
> removed since this helper was the only user.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/shash.c               | 19 ++++++++-----------
>  include/linux/compiler-gcc.h |  1 -
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/crypto/shash.c b/crypto/shash.c
> index ab6902c6dae7..8081c5e03770 100644
> --- a/crypto/shash.c
> +++ b/crypto/shash.c
> @@ -73,13 +73,6 @@ int crypto_shash_setkey(struct crypto_shash *tfm, const u8 *key,
>  }
>  EXPORT_SYMBOL_GPL(crypto_shash_setkey);
>  
> -static inline unsigned int shash_align_buffer_size(unsigned len,
> -						   unsigned long mask)
> -{
> -	typedef u8 __aligned_largest u8_aligned;
> -	return len + (mask & ~(__alignof__(u8_aligned) - 1));
> -}
> -
>  static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>  				  unsigned int len)
>  {
> @@ -88,11 +81,13 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>  	unsigned long alignmask = crypto_shash_alignmask(tfm);
>  	unsigned int unaligned_len = alignmask + 1 -
>  				     ((unsigned long)data & alignmask);
> -	u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
> -		__aligned_largest;
> +	u8 ubuf[MAX_ALGAPI_ALIGNMASK + 1];
>  	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
>  	int err;
>  
> +	if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
> +		return -EINVAL;
> +

How is 'ubuf' guaranteed to be large enough?  You removed the __aligned
attribute, so 'ubuf' can have any alignment.  So the aligned pointer 'buf' may
be as high as '&ubuf[alignmask]'.  Then, up to 'alignmask' bytes of data will be
copied into 'buf'... resulting in up to '2 * alignmask' bytes needed in 'ubuf'.
But you've only guaranteed 'alignmask + 1' bytes.

>  	if (unaligned_len > len)
>  		unaligned_len = len;
>  
> @@ -124,11 +119,13 @@ static int shash_final_unaligned(struct shash_desc *desc, u8 *out)
>  	unsigned long alignmask = crypto_shash_alignmask(tfm);
>  	struct shash_alg *shash = crypto_shash_alg(tfm);
>  	unsigned int ds = crypto_shash_digestsize(tfm);
> -	u8 ubuf[shash_align_buffer_size(ds, alignmask)]
> -		__aligned_largest;
> +	u8 ubuf[SHASH_MAX_DIGESTSIZE];
>  	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
>  	int err;
>  
> +	if (WARN_ON(buf + ds > ubuf + sizeof(ubuf)))
> +		return -EINVAL;
> +

Similar problem here.  Wouldn't 'ubuf' need to be of size 'alignmask + ds'?

>  	err = shash->final(desc, buf);
>  	if (err)
>  		goto out;
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f1a7492a5cc8..1f1cdef36a82 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -125,7 +125,6 @@
>   */
>  #define __pure			__attribute__((pure))
>  #define __aligned(x)		__attribute__((aligned(x)))
> -#define __aligned_largest	__attribute__((aligned))
>  #define __printf(a, b)		__attribute__((format(printf, a, b)))
>  #define __scanf(a, b)		__attribute__((format(scanf, a, b)))
>  #define __attribute_const__	__attribute__((__const__))
> -- 
> 2.17.1
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
