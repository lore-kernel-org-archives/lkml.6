Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69924C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3231920870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547270812;
	bh=2Q66eYeImLrPy5L7hPfPOW9Wo2sUYqNRiLld3K786cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LfecR369MrE8yEyYLVYZc/h+XUPXiHgOpjm2Mgdyi9cdbTdLZvlYwn+r6UI3EjAOK
	 ycaV3rQDTkd2SjqJpOMYi27rZB7HvwHi5GAinpMmd4c45j+DkqccUM5USEbgOlNofr
	 eV+8uZt+hEajtxO/yP0oUbU4mwtpIZ/aWRpzIin0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbfALF0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 00:26:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfALF0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 00:26:49 -0500
Received: from sol.localdomain (c-24-23-143-129.hsd1.ca.comcast.net [24.23.143.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC742084E;
        Sat, 12 Jan 2019 05:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547270808;
        bh=2Q66eYeImLrPy5L7hPfPOW9Wo2sUYqNRiLld3K786cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLG53a2OJXWaptFMNZG/5us+oR2pxJUD3XYr7Bc63irnhF+j7nxgj8USm0A4OQVYD
         tlMUZV9RCtjVVXcy5Se4seLvo6D70tCXJVqIshOHuJYFiOmYMBefA7uDOB3MmHBp5b
         bjw+aZ2SkUqGF7BoPH2N6/8ygVqSmFSHlvffEoLw=
Date:   Fri, 11 Jan 2019 21:26:46 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 3/6] crypto: kdf - add known answer tests
Message-ID: <20190112052645.GC639@sol.localdomain>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190109082103.GA8586@sol.localdomain>
 <9733066.Vrs4h5eWcW@positron.chronox.de>
 <8456866.1rT4qWozqf@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8456866.1rT4qWozqf@positron.chronox.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:10:22PM +0100, Stephan Müller wrote:
> Add known answer tests to the testmgr for the KDF (SP800-108) cipher.
> 
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/testmgr.c | 226 +++++++++++++++++++++++++++++++++++++++++++++++
>  crypto/testmgr.h | 110 +++++++++++++++++++++++
>  2 files changed, 336 insertions(+)
> 
> diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> index 0f684a414acb..ff9051bffa1f 100644
> --- a/crypto/testmgr.c
> +++ b/crypto/testmgr.c
> @@ -110,6 +110,11 @@ struct drbg_test_suite {
>  	unsigned int count;
>  };
>  
> +struct kdf_test_suite {
> +	struct kdf_testvec *vecs;
> +	unsigned int count;
> +};
> +
>  struct akcipher_test_suite {
>  	const struct akcipher_testvec *vecs;
>  	unsigned int count;
> @@ -133,6 +138,7 @@ struct alg_test_desc {
>  		struct hash_test_suite hash;
>  		struct cprng_test_suite cprng;
>  		struct drbg_test_suite drbg;
> +		struct kdf_test_suite kdf;
>  		struct akcipher_test_suite akcipher;
>  		struct kpp_test_suite kpp;
>  	} suite;
> @@ -2020,6 +2026,64 @@ static int drbg_cavs_test(const struct drbg_testvec *test, int pr,
>  	return ret;
>  }
>  
> +static int kdf_cavs_test(struct kdf_testvec *test,
> +			 const char *driver, u32 type, u32 mask)

Why not just "kdf_test()"?

> +{
> +	int ret = -EAGAIN;
> +	struct crypto_rng *drng;
> +	unsigned char *buf = kzalloc(test->expectedlen, GFP_KERNEL);

s/unsigned char/u8

> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	drng = crypto_alloc_rng(driver, type | CRYPTO_ALG_INTERNAL, mask);
> +	if (IS_ERR(drng)) {
> +		printk(KERN_ERR "alg: kdf: could not allocate cipher handle "
> +		       "for %s\n", driver);

pr_err

> +		kzfree(buf);

kfree is fine here.

> +		return -ENOMEM;
> +	}
> +
> +	ret = crypto_rng_reset(drng, test->K1, test->K1len);
> +	if (ret) {
> +		printk(KERN_ERR "alg: kdf: could not set key derivation key\n");

pr_err

> +		goto err;
> +	}
> +
> +	ret = crypto_rng_generate(drng, test->context, test->contextlen,
> +				  buf, test->expectedlen);
> +	if (ret) {
> +		printk(KERN_ERR "alg: kdf: could not obtain key data\n");

pr_err

> +		goto err;
> +	}
> +
> +	ret = memcmp(test->expected, buf, test->expectedlen);

Elsewhere this function returns an -errno value but this is different.

> +
> +err:
> +	crypto_free_rng(drng);
> +	kzfree(buf);

kfree would be fine here too.

> +	return ret;
> +}
> +
> +static int alg_test_kdf(const struct alg_test_desc *desc, const char *driver,
> +			u32 type, u32 mask)
> +{
> +	int err = 0;
> +	unsigned int i = 0;
> +	struct kdf_testvec *template = desc->suite.kdf.vecs;

const

- Eric
