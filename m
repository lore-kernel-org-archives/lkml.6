Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D2C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442752081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rlxLigYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442752081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeKDSZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 13:25:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53445 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbeKDSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 13:25:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id v24-v6so5421566wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 01:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3wy75baK0prJgF7Nw2mVSDrHufYm18+njdvhsdjxRDA=;
        b=rlxLigYISSLWJaP7JqqSmqi5WO3LXuPilYtN+ezLDsrVgrNklPGNiZ882T/CtPsIu9
         XhvEG+DtQW7hLgIR9COwTh3mGLOy4BfcbZFWB+c5IuzGJ/fsY5MXZRE1ZEbx/B332m13
         0OznrxWO99VMQDMYRUyPajDUd3vNv8F2OIhIrGy2/PlZZjlDG0ZE2hCndQFityWRdKXF
         kjriGnSpaz7IhYZKGfATEoseekJ3titPW+pApg8t5KLAYimXk3pKK1LXoi0vBa029X3P
         JvNOWfSqBsB84HX/mADyigE/0iYl6V5hJimmSutN2ugmyltCraFVkiv/GigWuxihOUZk
         hkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3wy75baK0prJgF7Nw2mVSDrHufYm18+njdvhsdjxRDA=;
        b=XQ+jBZyZoBKHBwYxx2sgYUFBipKX6038LN7DOyEet+/2FjIYS6JKDFTa/1HLOsAuwO
         4pAWToxffLx+Pw7M8ASSj+bIUSMHO13owQhX7q2FOg9w/3iPDOw/gN3WMGpUTBrPtWP6
         nhJaCirKuzT7PTj53+jxe6HSfU68a8rM5etguOcl7xOGF+GTcMFNNFlnRLsGVjvfjmQR
         Aj4AFz8q4Xdb+fouTPqd7tIDml2noSSDvdJgb6ePH8hHC16l7dL3TQNl/kA3Bgd5q5sT
         4k1ezwrreiE0idbnFJJ9vHFSbRKrhffXpDDp4BPlxyTdGo+OCTq3uBMeUkK2Zew3IfFD
         hStw==
X-Gm-Message-State: AGRZ1gLqTPjB+TYgYjKHQolEu2unsdfZTCIVfLYkuP6/RgZ32si3/lYs
        kByTSl2/PciuwwsrHWQgufMAQg==
X-Google-Smtp-Source: AJdET5dYehHxmGmc2yc4rleEhVeaVYkF7e3WZCXDMMvcb7S/En8/3pL/9YI1jYI3vEGJrDVtx6/NYA==
X-Received: by 2002:a1c:4e18:: with SMTP id g24-v6mr2853678wmh.92.1541322667787;
        Sun, 04 Nov 2018 01:11:07 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l140-v6sm58105678wmb.24.2018.11.04.01.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 01:11:06 -0800 (PST)
Date:   Sun, 4 Nov 2018 10:11:04 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        nhorman@tuxdriver.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: Implement a generic crypto statistics
Message-ID: <20181104091104.GA6963@Red>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-2-git-send-email-clabbe@baylibre.com>
 <20181103221935.GB808@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103221935.GB808@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 03:19:36PM -0700, Eric Biggers wrote:
> Hi Corentin,
> 
> On Wed, Sep 19, 2018 at 10:10:54AM +0000, Corentin Labbe wrote:
> > This patch implement a generic way to get statistics about all crypto
> > usages.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  crypto/Kconfig                               |  11 +
> >  crypto/Makefile                              |   1 +
> >  crypto/ahash.c                               |  21 +-
> >  crypto/algapi.c                              |   8 +
> >  crypto/{crypto_user.c => crypto_user_base.c} |   9 +-
> >  crypto/crypto_user_stat.c                    | 463 +++++++++++++++++++++++++++
> >  crypto/rng.c                                 |   1 +
> >  include/crypto/acompress.h                   |  38 ++-
> >  include/crypto/aead.h                        |  51 ++-
> >  include/crypto/akcipher.h                    |  76 ++++-
> >  include/crypto/hash.h                        |  32 +-
> >  include/crypto/internal/cryptouser.h         |   8 +
> >  include/crypto/kpp.h                         |  51 ++-
> >  include/crypto/rng.h                         |  29 +-
> >  include/crypto/skcipher.h                    |  44 ++-
> >  include/linux/crypto.h                       | 110 ++++++-
> >  include/uapi/linux/cryptouser.h              |  52 +++
> >  17 files changed, 970 insertions(+), 35 deletions(-)
> >  rename crypto/{crypto_user.c => crypto_user_base.c} (97%)
> >  create mode 100644 crypto/crypto_user_stat.c
> >  create mode 100644 include/crypto/internal/cryptouser.h
> > 
> > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > index 90f2811fac5f..4ef95b0b25a3 100644
> > --- a/crypto/Kconfig
> > +++ b/crypto/Kconfig
> > @@ -1799,6 +1799,17 @@ config CRYPTO_USER_API_AEAD
> >  	  This option enables the user-spaces interface for AEAD
> >  	  cipher algorithms.
> >  
> > +config CRYPTO_STATS
> > +	bool "Crypto usage statistics for User-space"
> > +	help
> > +	  This option enables the gathering of crypto stats.
> > +	  This will collect:
> > +	  - encrypt/decrypt size and numbers of symmeric operations
> > +	  - compress/decompress size and numbers of compress operations
> > +	  - size and numbers of hash operations
> > +	  - encrypt/decrypt/sign/verify numbers for asymmetric operations
> > +	  - generate/seed numbers for rng operations
> > +
> >  config CRYPTO_HASH_INFO
> >  	bool
> >  
> > diff --git a/crypto/Makefile b/crypto/Makefile
> > index d719843f8b6e..ff5c2bbda04a 100644
> > --- a/crypto/Makefile
> > +++ b/crypto/Makefile
> > @@ -54,6 +54,7 @@ cryptomgr-y := algboss.o testmgr.o
> >  
> >  obj-$(CONFIG_CRYPTO_MANAGER2) += cryptomgr.o
> >  obj-$(CONFIG_CRYPTO_USER) += crypto_user.o
> > +crypto_user-y := crypto_user_base.o crypto_user_stat.o
> >  obj-$(CONFIG_CRYPTO_CMAC) += cmac.o
> >  obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
> >  obj-$(CONFIG_CRYPTO_VMAC) += vmac.o
> 
> Why is crypto_user_stat.c always being compiled when CONFIG_CRYPTO_USER is
> enabled, even when CONFIG_CRYPTO_STATS is not?
> 
> When CONFIG_CRYPTO_STATS is disabled, all the crypto stat stuff should be
> stubbed out so that crypto_user_stat.c doesn't need to be compiled.
> 
> [...]
> > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > index e8839d3a7559..3634ad6fe202 100644
> > --- a/include/linux/crypto.h
> > +++ b/include/linux/crypto.h
> > @@ -454,6 +454,33 @@ struct compress_alg {
> >   * @cra_refcnt: internally used
> >   * @cra_destroy: internally used
> >   *
> > + * All following statistics are for this crypto_alg
> > + * @encrypt_cnt:	number of encrypt requests
> > + * @decrypt_cnt:	number of decrypt requests
> > + * @compress_cnt:	number of compress requests
> > + * @decompress_cnt:	number of decompress requests
> > + * @generate_cnt:	number of RNG generate requests
> > + * @seed_cnt:		number of times the rng was seeded
> > + * @hash_cnt:		number of hash requests
> > + * @sign_cnt:		number of sign requests
> > + * @setsecret_cnt:	number of setsecrey operation
> > + * @generate_public_key_cnt:	number of generate_public_key operation
> > + * @verify_cnt:			number of verify operation
> > + * @compute_shared_secret_cnt:	number of compute_shared_secret operation
> > + * @encrypt_tlen:	total data size handled by encrypt requests
> > + * @decrypt_tlen:	total data size handled by decrypt requests
> > + * @compress_tlen:	total data size handled by compress requests
> > + * @decompress_tlen:	total data size handled by decompress requests
> > + * @generate_tlen:	total data size of generated data by the RNG
> > + * @hash_tlen:		total data size hashed
> > + * @akcipher_err_cnt:	number of error for akcipher requests
> > + * @cipher_err_cnt:	number of error for akcipher requests
> > + * @compress_err_cnt:	number of error for akcipher requests
> > + * @aead_err_cnt:	number of error for akcipher requests
> > + * @hash_err_cnt:	number of error for akcipher requests
> > + * @rng_err_cnt:	number of error for akcipher requests
> > + * @kpp_err_cnt:	number of error for akcipher requests
> > + *
> >   * The struct crypto_alg describes a generic Crypto API algorithm and is common
> >   * for all of the transformations. Any variable not documented here shall not
> >   * be used by a cipher implementation as it is internal to the Crypto API.
> > @@ -487,6 +514,45 @@ struct crypto_alg {
> >  	void (*cra_destroy)(struct crypto_alg *alg);
> >  	
> >  	struct module *cra_module;
> > +
> > +	union {
> > +		atomic_t encrypt_cnt;
> > +		atomic_t compress_cnt;
> > +		atomic_t generate_cnt;
> > +		atomic_t hash_cnt;
> > +		atomic_t setsecret_cnt;
> > +	};
> > +	union {
> > +		atomic64_t encrypt_tlen;
> > +		atomic64_t compress_tlen;
> > +		atomic64_t generate_tlen;
> > +		atomic64_t hash_tlen;
> > +	};
> > +	union {
> > +		atomic_t akcipher_err_cnt;
> > +		atomic_t cipher_err_cnt;
> > +		atomic_t compress_err_cnt;
> > +		atomic_t aead_err_cnt;
> > +		atomic_t hash_err_cnt;
> > +		atomic_t rng_err_cnt;
> > +		atomic_t kpp_err_cnt;
> > +	};
> > +	union {
> > +		atomic_t decrypt_cnt;
> > +		atomic_t decompress_cnt;
> > +		atomic_t seed_cnt;
> > +		atomic_t generate_public_key_cnt;
> > +	};
> > +	union {
> > +		atomic64_t decrypt_tlen;
> > +		atomic64_t decompress_tlen;
> > +	};
> > +	union {
> > +		atomic_t verify_cnt;
> > +		atomic_t compute_shared_secret_cnt;
> > +	};
> > +	atomic_t sign_cnt;
> > +
> >  } CRYPTO_MINALIGN_ATTR;
> 
> The new fields here should all be behind CONFIG_CRYPTO_STATS.
> 
> Ideally there would be zero overhead when CONFIG_CRYPTO_STATS is disabled.
> That's not quite the case currently.
> 
> - Eric

Hello

I will address thoses problem in a followup patch.

Thanks

