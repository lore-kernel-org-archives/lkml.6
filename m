Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E16C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704472064E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKK30L2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704472064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJMA3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:29:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38267 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeJMA3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:29:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id f29-v6so6495981pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZqIrbWJKC3RtxsrK/0HJ6SbrXDpmv9rKA5oHxqvaDM=;
        b=qKK30L2LBG4SDZ6XEZ+XI27BlpgfDXqoPco+Yi5ChT1oZvwX8eLals57RjewUNWnxg
         MhxkG5L7CxoOLCxRaUfCwnUPjKaZL40Pf93QJSyq6qv1YYKGTcCEQ1LxUpgLrxt36kRu
         frCKRp26q2lLz9WZKjvxVGqfAesu52vJ5kT0O9Ese2EXPuDk2tE8QJ4UAFx/nD5VIdzA
         5Mx04px6J48IqnT3eXHMF+2ozxSagGOen5byeUO+x5DdhJu3AgyJCoDS6seysb7r8kd5
         QQ56kNLvzGUo/rFpQDBd9Oqk9LnlBIV+2RhtnqI8rYMbAF1jwuRuRuZ0YiOnLwVBe82i
         e9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZqIrbWJKC3RtxsrK/0HJ6SbrXDpmv9rKA5oHxqvaDM=;
        b=UylXlLt5K9jl3MrmsmJ/vyTwAfPeMe5P06Hr6cCBqCIVye9QUVnPNMmNovJr7E+uan
         jux+MCxocxlQUIDLAntJM8Hj8P6qMD2FIIfEU1v8RBBCf+haikYdwrdi8KTHnNUrDA1Q
         bPHC57wNx7pgO7Baj/0Ox30iiyNDd7yNHiRLvT8p7K322fjjiA4t512MLxlPdZvqammq
         mkCNnydwLRaW21IsZyla9We9hy1W7E2HaN7C/HlEj1QLVPcflzormbujG2fq/ja3veR0
         DkhEFMf+SG+vxoL5B41H2AbPd3T/YkfCqzw0K8NSly4TM7os1QRY4f/UBZUBmY7Ad48z
         1AyQ==
X-Gm-Message-State: ABuFfojVQ6PcFFrAMLWvFn+rpRmYrf7BuOuT1L31PZNl5NUI4BONjeLa
        TDiZG/TgxuP+26zJ50D5UCEa2WOlkkm5U5sGEM6g+w==
X-Google-Smtp-Source: ACcGV62JNiCP6kC1SxCAfXU5cydF+DlG7yj7YALpPBZi34LVdxG+lE/52Jxzax8eVLhi1X2YtlBJAizIEEjbV6av6lg=
X-Received: by 2002:a63:df06:: with SMTP id u6-v6mr6248735pgg.202.1539363367091;
 Fri, 12 Oct 2018 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <20181012015022.GA7508@flashbox>
In-Reply-To: <20181012015022.GA7508@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Oct 2018 09:55:55 -0700
Message-ID: <CAKwvOdnNHfF2vHSaDtxpJ+mNxARDjKG0gvjWMdtKJ8XgriAqVA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        dhowells@redhat.com, Eric Biggers <ebiggers@google.com>,
        zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 6:50 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Oct 11, 2018 at 01:31:26PM -0700, ndesaulniers@google.com wrote:
> > by swapping h2 and h3.
> >
> > security/keys/trusted.c:146:17: warning: passing an object that
> > undergoes default
> >       argument promotion to 'va_start' has undefined behavior [-Wvarargs]
> >         va_start(argp, h3);
> >                        ^
> > security/keys/trusted.c:126:37: note: parameter of type 'unsigned
> > char' is declared here
> > unsigned char *h2, unsigned char h3, ...)
> >                                ^
> >
> > Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
> > standards explicitly call this out as undefined behavior:
> >
> > The parameter parmN is the identifier of the rightmost parameter in
> > the variable parameter list in the function definition (the one just
> > before the ...). If the parameter parmN is declared with ... or with a
> > type that is not compatible with the type that results after
> > application of the default argument promotions, the behavior is
> > undefined.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/41
> > Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  security/keys/trusted.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> > index b69d3b1777c2..d425b2b839af 100644
> > --- a/security/keys/trusted.c
> > +++ b/security/keys/trusted.c
> > @@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
> >   */
> >  static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> >                       unsigned int keylen, unsigned char *h1,
> > -                     unsigned char *h2, unsigned char h3, ...)
> > +                     unsigned char h2, unsigned char *h3, ...)
>
> Prototype needs to be updated in include/keys/trusted.h and it looks
> like this function is used in crypto/asymmetric_keys/asym_tpm.c so these
> same changes should be made there.

Thanks for the review. Which tree are you looking at? These files
don't exist in torvalds/linux, but maybe -next or the crypto tree have
expanded the number of call sites of this function?

>
> Otherwise, looks good to me! Thanks for sending the patch.
>
> Nathan
>
> >  {
> >       unsigned char paramdigest[SHA1_DIGEST_SIZE];
> >       struct sdesc *sdesc;
> > @@ -139,7 +139,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> >               return PTR_ERR(sdesc);
> >       }
> >
> > -     c = h3;
> > +     c = h2;
> >       ret = crypto_shash_init(&sdesc->shash);
> >       if (ret < 0)
> >               goto out;
> > @@ -163,7 +163,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
> >       if (!ret)
> >               ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
> >                                 paramdigest, TPM_NONCE_SIZE, h1,
> > -                               TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
> > +                               TPM_NONCE_SIZE, h3, 1, &c, 0, 0);
> >  out:
> >       kzfree(sdesc);
> >       return ret;
> > @@ -508,7 +508,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
> >       if (pcrinfosize == 0) {
> >               /* no pcr info specified */
> >               ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> > -                                sess.enonce, td->nonceodd, cont,
> > +                                sess.enonce, cont, td->nonceodd,
> >                                  sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
> >                                  td->encauth, sizeof(uint32_t), &pcrsize,
> >                                  sizeof(uint32_t), &datsize, datalen, data, 0,
> > @@ -516,7 +516,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
> >       } else {
> >               /* pcr info specified */
> >               ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
> > -                                sess.enonce, td->nonceodd, cont,
> > +                                sess.enonce, cont, td->nonceodd,
> >                                  sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
> >                                  td->encauth, sizeof(uint32_t), &pcrsize,
> >                                  pcrinfosize, pcrinfo, sizeof(uint32_t),
> > @@ -608,12 +608,12 @@ static int tpm_unseal(struct tpm_buf *tb,
> >               return ret;
> >       }
> >       ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
> > -                        enonce1, nonceodd, cont, sizeof(uint32_t),
> > +                        enonce1, cont, nonceodd, sizeof(uint32_t),
> >                          &ordinal, bloblen, blob, 0, 0);
> >       if (ret < 0)
> >               return ret;
> >       ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
> > -                        enonce2, nonceodd, cont, sizeof(uint32_t),
> > +                        enonce2, cont, nonceodd, sizeof(uint32_t),
> >                          &ordinal, bloblen, blob, 0, 0);
> >       if (ret < 0)
> >               return ret;
> > --
> > 2.19.0.605.g01d371f741-goog
> >



-- 
Thanks,
~Nick Desaulniers
