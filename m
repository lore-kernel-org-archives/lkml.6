Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B775C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4FB2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2/f4jmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4FB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJMAhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:37:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51361 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeJMAhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:37:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so12906762wmf.1;
        Fri, 12 Oct 2018 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dh0q9Qy+eV5Y58ojZBXV2Z+3zMv259LbCRS9Pi30Tj8=;
        b=I2/f4jmosJPoStNYadtdeqakMeScqPUpCtqPWKtNSfJtfz7TKgPgWkLsXjHYT7UAKm
         EBDK2mVJGxVsNxqhBu1uX2POrnIsPLNrMI5wpXVhYG4SjAZ5hSBrxq9nO59qoSEpEJEF
         PdO1t1DTRj3onPiYTkSZ1FStrfpfAvbu6dlEKTJOd0M7H1ny+YrSUwsPVssGuo/ZINdC
         NwcC+hJSbYeR7lOQnGyQwY2xNbgHQBwBe0X1hjB5h9nA/or9P8qEIEs1sx79D2IcUX+G
         LCiqaPQw4AFp9AchSY5oGnVBtyEr7oWakqWFhDYTSlmTex2drOUJ8DNmfFVB5f9W3lN+
         lpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dh0q9Qy+eV5Y58ojZBXV2Z+3zMv259LbCRS9Pi30Tj8=;
        b=aJVMbqwfXeyKTU/kbIaM2khHPcXBtUyByseb5sGVSvXUqGnmKRjJvieJkGIP7CDDq/
         Zqm9dAu1p5h4r5Wtd9ln4jMljagln3D7L9mSeLhBr3xz3SvO3qe2OhvB39LVHcYzyJGF
         bjD1nRqz911HA5uNk/kpd/U2mAvJM3ewae93uFSBIfCPvi4+CTb49apf4y0MjaAidZUL
         nBh8cRrTQjZSuJ1kzs9qHeMoRkYiiBLjDnbkZLxIxyBc5/Rj0f2t7JvMaU2SbSBB/pMw
         CYuW1JaTzJ/jPSYbm1pY7/ZRWciFeXfpF14YG6ovEwDILAifjfezQubv4E9O4kRUbdVW
         Fptw==
X-Gm-Message-State: ABuFfogxXjBAuSSqNGFlohFWj9hf41ALdRGB2LGYkbzT89dsJcqCFxUR
        aYa2pux+8WKJX9PJ81ULCME=
X-Google-Smtp-Source: ACcGV62hi/4GSv6/JcquAPKTXzWL1tZjc1eZ0HT2BYpO/UdAKhlN24M1XaIgWSyzuo54Mch2NaLhLA==
X-Received: by 2002:a1c:d04e:: with SMTP id h75-v6mr6021725wmg.92.1539363823009;
        Fri, 12 Oct 2018 10:03:43 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l140-v6sm2389353wmb.24.2018.10.12.10.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 10:03:42 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:03:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        dhowells@redhat.com, Eric Biggers <ebiggers@google.com>,
        zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
Message-ID: <20181012170340.GA27813@flashbox>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <20181012015022.GA7508@flashbox>
 <CAKwvOdnNHfF2vHSaDtxpJ+mNxARDjKG0gvjWMdtKJ8XgriAqVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnNHfF2vHSaDtxpJ+mNxARDjKG0gvjWMdtKJ8XgriAqVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:55:55AM -0700, Nick Desaulniers wrote:
> On Thu, Oct 11, 2018 at 6:50 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Oct 11, 2018 at 01:31:26PM -0700, ndesaulniers@google.com wrote:
> > > by swapping h2 and h3.
> > >
> > > security/keys/trusted.c:146:17: warning: passing an object that
> > > undergoes default
> > >       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> > >         va_start(argp, h3);
> > >                        ^
> > > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > > char' is declared here
> > > unsigned char *h2, unsigned char h3, ...)
> > >                                ^
> > >
> > > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > > standards explicitly call this out as undefined behavior:
> > >
> > > The parameter parmN is the identifier of the rightmost parameter in
> > > the variable parameter list in the function definition (the one just
> > > before the ...). If the parameter parmN is declared with ... or with a
> > > type that is not compatible with the type that results after
> > > application of the default argument promotions, the behavior is
> > > undefined.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/41
> > > Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  security/keys/trusted.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> > > index b69d3b1777c2..d425b2b839af 100644
> > > --- a/security/keys/trusted.c
> > > +++ b/security/keys/trusted.c
> > > @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
> > >   */
> > >  static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> > >                       unsigned int keylen, unsigned char *h1,
> > > -                     unsigned char *h2, unsigned char h3, ...)
> > > +                     unsigned char h2, unsigned char *h3, ...)
> >
> > Prototype needs to be updated in include/keys/trusted.h and it looks
> > like this function is used in crypto/asymmetric_keys/asym_tpm.c so these
> > same changes should be made there.
> 
> Thanks for the review. Which tree are you looking at? These files
> don't exist in torvalds/linux, but maybe -next or the crypto tree have
> expanded the number of call sites of this function?
> 

Yes, sorry I always work off of -next. Looks like commit 67714f79c8f7 ("KEYS:
trusted: Expose common functionality [ver #2]") exposes the function in
trusted.h and commit 27728d92a7df ("KEYS: asym_tpm: Add loadkey2 and
flushspecific [ver #2]") uses it. They're currently in -next, from the next-keys
branch in the security tree.

> >
> > Otherwise, looks good to me! Thanks for sending the patch.
> >
> > Nathan
> >
> > >  {
> > >       unsigned char paramdigest[SHA1_DIGEST_SIZE];
> > >       struct sdesc *sdesc;
> > > @@ -139,7 +139,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> > >               return PTR_ERR(sdesc);
> > >       }
> > >
> > > -     c = h3;
> > > +     c = h2;
> > >       ret = crypto_shash_init(&sdesc->shash);
> > >       if (ret < 0)
> > >               goto out;
> > > @@ -163,7 +163,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> > >       if (!ret)
> > >               ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
> > >                                 paramdigest, TPM_NONCE_SIZE, h1,
> > > -                               TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
> > > +                               TPM_NONCE_SIZE, h3, 1, &c, 0, 0);
> > >  out:
> > >       kzfree(sdesc);
> > >       return ret;
> > > @@ -508,7 +508,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
> > >       if (pcrinfosize == 0) {
> > >               /* no pcr info specified */
> > >               ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> > > -                                sess.enonce, td->nonceodd, cont,
> > > +                                sess.enonce, cont, td->nonceodd,
> > >                                  sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
> > >                                  td->encauth, sizeof(uint32_t), &pcrsize,
> > >                                  sizeof(uint32_t), &datsize, datalen, data, 0,
> > > @@ -516,7 +516,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
> > >       } else {
> > >               /* pcr info specified */
> > >               ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> > > -                                sess.enonce, td->nonceodd, cont,
> > > +                                sess.enonce, cont, td->nonceodd,
> > >                                  sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
> > >                                  td->encauth, sizeof(uint32_t), &pcrsize,
> > >                                  pcrinfosize, pcrinfo, sizeof(uint32_t),
> > > @@ -608,12 +608,12 @@ static int tpm_unseal(struct tpm_buf *tb,
> > >               return ret;
> > >       }
> > >       ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
> > > -                        enonce1, nonceodd, cont, sizeof(uint32_t),
> > > +                        enonce1, cont, nonceodd, sizeof(uint32_t),
> > >                          &ordinal, bloblen, blob, 0, 0);
> > >       if (ret < 0)
> > >               return ret;
> > >       ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
> > > -                        enonce2, nonceodd, cont, sizeof(uint32_t),
> > > +                        enonce2, cont, nonceodd, sizeof(uint32_t),
> > >                          &ordinal, bloblen, blob, 0, 0);
> > >       if (ret < 0)
> > >               return ret;
> > > --
> > > 2.19.0.605.g01d371f741-goog
> > >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
