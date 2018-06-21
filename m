Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07782C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C1420874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmzkCKIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C1420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754439AbeFUArU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:47:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33254 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbeFUArS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:47:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so683893plb.0;
        Wed, 20 Jun 2018 17:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YmfUs0oMycm2fIrTWEN593Jb7ubVDybFOSbgfOjOK6M=;
        b=pmzkCKIHUJTxFiN3vOb4YPXISo1Xe1Rjj8wS8nyFcygXiplc9w8J+DxlhVvUVUw67+
         U3IOLJGvtyvgx0kQ8CmAEBXuOAopdTTp4qOV9PFZ3d/IsmsHyX4fXBpHf5psW3NxgBLe
         01WFy6w4LW75NraArPjZ131UVxvqcqIU5ldPMyvH47MbgEy5MvxRnaKruD7neu4vLKtj
         4zvKUHnlqst6akjCcgednSjOlDQNR3gpKjHOyHyNVb6e2b3x59lME5OItfBYPP5YCY5D
         rtPD2/cABb7i8NobZYCl/QXLJOTijARqCq5VFwRAhE9r3tjdBuZB3UssFjPu0n4RJL/l
         Y17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YmfUs0oMycm2fIrTWEN593Jb7ubVDybFOSbgfOjOK6M=;
        b=edwaEX0LjiwM5g6s2uwv/xgKT46K5XyG13sqav5EUdnrFXf9pjiwbofPYyHjFTsqvA
         aU/wEspgvDQDzx7WkaVYBcijPeRVffinQau0FW0bY3kU/NNYRr5P7RrEVF7Sfiw4VZv8
         qBQwWduMdsLt9aao0CojCwEVpx3gG9mjFBO/bYJiR4GCnmPoB+Subu6yEQxj/NgbLCyJ
         oL90NDEA11Hw6h1K0kQPrbGLv3+WE5gDRKj+lrbsRbtotrMMbv4kJNFYStSkDkz2NX0K
         JT9xdvzh/Sx6X7VtGFyKKpoMQSUq9rPlSwuIt91tIzlFllHfR8IxBMnSL7xsbVG2+DaQ
         oRcQ==
X-Gm-Message-State: APt69E1/QnFIZ51QPFE8z14/l7sDdtYtdclqSfqnjHmkajrI5TsSQWkz
        ojsZAAOMWmpT8z+2VRRV3do=
X-Google-Smtp-Source: ADUXVKLOKTce+MQjIqQ+W3jqm4K2psPYFgOOCzaML57f9rnfxWj7JU4OpbsTyPQ75XbC5LDo5dqDBg==
X-Received: by 2002:a17:902:778e:: with SMTP id o14-v6mr25820016pll.214.1529542038034;
        Wed, 20 Jun 2018 17:47:18 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id j8-v6sm9507083pfe.84.2018.06.20.17.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 17:47:17 -0700 (PDT)
Date:   Wed, 20 Jun 2018 17:47:15 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [dm-devel] [PATCH 07/11] crypto: xcbc: Remove VLA usage
Message-ID: <20180621004715.GI111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-8-keescook@chromium.org>
 <20180620234623.GE111712@gmail.com>
 <CAGXu5jJ30eGUoik5+fWgdSHcO7NrAi87LXWWA5=RX6zwK0ueVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ30eGUoik5+fWgdSHcO7NrAi87LXWWA5=RX6zwK0ueVg@mail.gmail.com>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:10:04PM -0700, Kees Cook wrote:
> On Wed, Jun 20, 2018 at 4:46 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > On Wed, Jun 20, 2018 at 12:04:04PM -0700, Kees Cook wrote:
> >> In the quest to remove all stack VLA usage from the kernel[1], this uses
> >> the maximum blocksize and adds a sanity check.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >>  crypto/xcbc.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/crypto/xcbc.c b/crypto/xcbc.c
> >> index 25c75af50d3f..016481b1f3ba 100644
> >> --- a/crypto/xcbc.c
> >> +++ b/crypto/xcbc.c
> >> @@ -65,7 +65,10 @@ static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
> >>       int bs = crypto_shash_blocksize(parent);
> >>       u8 *consts = PTR_ALIGN(&ctx->ctx[0], alignmask + 1);
> >>       int err = 0;
> >> -     u8 key1[bs];
> >> +     u8 key1[CRYPTO_ALG_MAX_BLOCKSIZE];
> >> +
> >> +     if (WARN_ON(bs > sizeof(key1)))
> >> +             return -EINVAL;
> >
> > Similarly, why not MAX_CIPHER_BLOCKSIZE?
> >
> > Also, xcbc_create() only allows a 16-byte block size, and you made the API
> > enforce the maximum for algorithms anyway.  So I think the extra check here
> > isn't very worthwhile.
> 
> Is the "parent" argument in crypto_xcbc_digest_setkey() always going
> to be the "alg" from xcbc_create()? I couldn't convince myself that
> was true. If it is, then yes, this VLA can trivially made to be 16,
> but it seemed like they were separate instances...

Yes, it's guaranteed to be an instance of "xcbc" which was created by
xcbc_create(), so it will have 'cra_blocksize == 16'.

So until someone actually tests and enables support in the "xcbc" template for
other block sizes (if the XCBC specification allows them), it would also be fine
to just '#define XCBC_BLOCK_SIZE 16' at the top of the file and use that
everywhere that references the block size.

Eric
