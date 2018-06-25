Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57F7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD426257
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnetxetd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AD426257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeFYW4P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:56:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34025 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932174AbeFYW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:56:12 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so676915plo.1;
        Mon, 25 Jun 2018 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFmZ+9nj9Fzer412y/y2HUmYZnLtfG6x9XhTViIwmdE=;
        b=Mnetxetd/D7bqfkht3SFT8qUG2GnWBwXgaIVrV+NkEHSkTTi0G3RSx2554JEnwzK0i
         hVlXcFFYwz7mJYKc/hoXGJ5lc6opJr5XnILgFpo+2TnbBfxhxUBL8ZkQLA0OFpAvqUJa
         Y5hr9Y2IHCi7Mm+L3sRRfhlorrIzd9+45euXpTEOUBBRZ/8RmLVZMFuVTfqaplflBAA/
         NzLwz3DJDdLhOrH2jiszAd4qRJ73T99Y9Grb2LVTWUSuGDFf3NPySXGE5FkAukpJiI55
         vn2PtPEyw0ly9GYKSjF3Qf14KeuIbNGwd9sXdggFc6B5U0VVxh7UAiAtvpDlEnC5Uv/T
         Oq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFmZ+9nj9Fzer412y/y2HUmYZnLtfG6x9XhTViIwmdE=;
        b=X/JQmPH2MYAzGWMPDEqA5hRtGfZdF9qVlg+co15VzL0RRNY7ASNy8nfcYC0OS/CCUS
         itdf4ulP46qDb3tN5obzmGTwQk5NpatotgWTY2SiPjmvhjfxXWmGlaOPL92IHL2kffHS
         vXd4XBvvbb3wlIZ3zKlpiJ+k9ZBTKK6VMbq38XLco16Dk89es6LYyP61Nq4FtR/LNFqT
         OEU/pnlXUbYtncDCUK0MNCZv5vTZvoacAX5aKSIROpVZAlZonB0i4pBVgG8Ye1ZvpYJV
         +bf30q9c4ZB7gKU970PQyInicjETi6m6u7XvgaLPC2v+o7Enz5q4StY+FqIDth/O+92k
         9rQg==
X-Gm-Message-State: APt69E3h4eRry1FYJq6FpCu5Ye9ttS3mP2Nsj2ilh/VneaR1mJjj7ENg
        DWn9rq0AKcrKyS+gF3AgMrg=
X-Google-Smtp-Source: ADUXVKJ1JySm+f3MpPKeB3BDn03vyvIdLZ1AXBl7V3pD1j6QI1pyfybx2aRGnYsh8P8l/JoUkX4mng==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr13838478pll.243.1529967371959;
        Mon, 25 Jun 2018 15:56:11 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id g70-v6sm99342pfc.107.2018.06.25.15.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 15:56:11 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:56:09 -0700
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
Subject: Re: [dm-devel] [PATCH v2 10/11] crypto: ahash: Remove VLA usage for
 AHASH_REQUEST_ON_STACK
Message-ID: <20180625225609.GA181665@gmail.com>
References: <20180625211026.15819-1-keescook@chromium.org>
 <20180625211026.15819-11-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625211026.15819-11-keescook@chromium.org>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:10:25PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this caps
> the ahash request size similar to the other limits and adds a sanity
> check at registration. Unfortunately, these reqsizes can be huge. Looking
> at all callers of crypto_ahash_set_reqsize(), the largest appears to be
> 664 bytes, based on a combination of manual inspection and pahole output:
> 
> 4       dcp_sha_req_ctx
> 40      crypto4xx_ctx
> 52      hash_req_ctx
> 80      ahash_request
> 88      rk_ahash_rctx
> 104     sun4i_req_ctx
> 200     mcryptd_hash_request_ctx
> 216     safexcel_ahash_req
> 228     sha1_hash_ctx
> 228     sha256_hash_ctx
> 248     img_hash_request_ctx
> 252     mtk_sha_reqctx
> 276     sahara_sha_reqctx
> 304     mv_cesa_ahash_req
> 316     iproc_reqctx_s
> 320     caam_hash_state
> 320     qce_sha_reqctx
> 356     sha512_hash_ctx
> 384     ahash_req_ctx
> 400     chcr_ahash_req_ctx
> 416     stm32_hash_request_ctx
> 432     talitos_ahash_req_ctx
> 462     atmel_sha_reqctx
> 496     ccp_aes_cmac_req_ctx
> 616     ccp_sha_req_ctx
> 664     artpec6_hash_request_context
> 
> So, this chooses 720 as a larger "round" number for the max.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Rabin Vincent <rabinv@axis.com>
> Cc: Lars Persson <larper@axis.com>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/crypto/hash.h          | 3 ++-
>  include/crypto/internal/hash.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 5d79e2f0936e..b550077c4767 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -66,10 +66,11 @@ struct ahash_request {
>  
>  #define AHASH_MAX_DIGESTSIZE	512
>  #define AHASH_MAX_STATESIZE	512
> +#define AHASH_MAX_REQSIZE	720
>  
>  #define AHASH_REQUEST_ON_STACK(name, ahash) \
>  	char __##name##_desc[sizeof(struct ahash_request) + \
> -		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
> +		AHASH_MAX_REQSIZE] CRYPTO_MINALIGN_ATTR; \
>  	struct ahash_request *name = (void *)__##name##_desc
>  
>  /**
> diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
> index a0b0ad9d585e..d96ae5f52125 100644
> --- a/include/crypto/internal/hash.h
> +++ b/include/crypto/internal/hash.h
> @@ -142,6 +142,7 @@ static inline struct ahash_alg *__crypto_ahash_alg(struct crypto_alg *alg)
>  static inline void crypto_ahash_set_reqsize(struct crypto_ahash *tfm,
>  					    unsigned int reqsize)
>  {
> +	BUG_ON(reqsize > AHASH_MAX_REQSIZE);
>  	tfm->reqsize = reqsize;
>  }

This isn't accounting for the cases where a hash algorithm is "wrapped" with
another one, which increases the request size.  For example, "sha512_mb" ends up
with a request size of

	sizeof(struct ahash_request) +
	sizeof(struct mcryptd_hash_request_ctx) +
	sizeof(struct ahash_request) + 
	sizeof(struct sha512_hash_ctx)

	== 808 bytes, on x86_64 with CONFIG_DEBUG_SG enabled.

	(Note also that structure sizes can vary depending on the architecture
	 and the kernel config.)

So, with the self-tests enabled your new BUG_ON() is hit on boot:

------------[ cut here ]------------
kernel BUG at ./include/crypto/internal/hash.h:145!
invalid opcode: 0000 [#1] SMP PTI
CPU: 4 PID: 337 Comm: cryptomgr_test Not tainted 4.18.0-rc2-00048-gda396e1e8ca5 #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RIP: 0010:mcryptd_hash_init_tfm+0x36/0x40 crypto/mcryptd.c:289
Code: 01 00 00 e8 0c 05 fd ff 48 3d 00 f0 ff ff 77 18 48 89 43 40 8b 40 40 05 c8 00 00 00 3d d0 02 00 00 77 07 89 43 f8 31 c0 5b c3 <0f> 0b 0f 1f 84 00 00 00 00 00 80 7f 0c 00 74 01 c3 65 8b 05 d2 e2 
RSP: 0000:ffffb180c0dafc50 EFLAGS: 00010202
RAX: 00000000000002d8 RBX: ffffa1867c9267c8 RCX: ffffffffb66f5ef0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa1867c927c48
RBP: ffffa1867c926780 R08: 0000000000000001 R09: ffffa1867c927c00
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffa1867c9c6848 R14: ffffa1867c9c6848 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffa1867fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000035c10001 CR4: 00000000001606e0
Call Trace:
 crypto_create_tfm+0x86/0xd0 crypto/api.c:475
 crypto_alloc_tfm+0x4b/0xb0 crypto/api.c:543
 mcryptd_alloc_ahash+0x6f/0xb0 crypto/mcryptd.c:603
 sha512_mb_async_init_tfm+0x1a/0x50 arch/x86/crypto/sha512-mb/sha512_mb.c:724
 crypto_create_tfm+0x86/0xd0 crypto/api.c:475
 crypto_alloc_tfm+0x4b/0xb0 crypto/api.c:543
 __alg_test_hash+0x1c/0x90 crypto/testmgr.c:1799
 alg_test_hash+0x6b/0x100 crypto/testmgr.c:1841
 alg_test.part.5+0x119/0x2a0 crypto/testmgr.c:3687
 cryptomgr_test+0x3b/0x40 crypto/algboss.c:223
 kthread+0x114/0x130 kernel/kthread.c:240
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
---[ end trace d726be03a53bddb5 ]---
