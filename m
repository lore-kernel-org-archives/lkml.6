Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A8CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2C220658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFmCtNEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2C220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJLETl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:19:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43231 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeJLETl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:19:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id p24-v6so4992957pff.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rD1ltHdhBzF00zbyANLu4JX0kA9qS5geMIhPKYpoKdo=;
        b=CFmCtNEPJrD63eK2i3aeF4hylnraLGnWSAWA7V323N5qIy3J3kONXCQ7dsUV+gOGTL
         g8eWkFtGzxovx5As2F73ZoM8jM8KYFgpkMe7y4u2XLuKJDOKkeExuicH1cjjJ//uBmJw
         SO2d81ouAovjq3Hp4gW497ccaqnSbki1cDZTIDqKnZe4uwsa1fkIPzzlhWV0S18WNqGG
         uf+z96wsaZmh1YiF2xqKx33E5qOTsx+KSueAeSH/rQXwoaAZW05sSBVw0ny6i8GQdTYW
         WPa/ifO148AeuBpFUfkeyDyzFrl95+js3qUlyPFdupRd6b4FJsbM/NuaeILDwbXrmlM+
         a2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rD1ltHdhBzF00zbyANLu4JX0kA9qS5geMIhPKYpoKdo=;
        b=WgnfBzcKkoGPCTxJSlK5hryptr7VtGCwnGIfm69tRXwe+mIIOfpmmCS98607Dck8YZ
         Nzu8v1jowmKUmTHJQ9m2BLzrQDWsNXQJddYuzrKYK/BAuNxacrzncRUZ75RfNYt542qZ
         XXL3URopJzIXr6kSWUUa7xHjI4/KKRpQD96htuY/nYfueLu5g4N9HQlFxwnxX+YW4uhI
         3TEFzpcUCWYN8iEthOojVK2vx25UgvNHr6IKTtdEazqhhzxHUiBJJ/vfqIcL7zB2/mO4
         ZMcE1UQFFioKmwkmbpjfdIFo8Oyw3481xmm6hMxmdzH4A1nAuhUXtgD6PtxbJ3eccOe1
         RWNA==
X-Gm-Message-State: ABuFfog/Epg2zq7ALsxJjPF2YYMjHxZjAw1RmvuSwAA/Tq6aPPgneRpr
        Kam3svxu4Y3YiDi0gLm6U/bd5/lqvQCLAYpVaqLgNA==
X-Google-Smtp-Source: ACcGV62ql0kQlN7sSPyUhVNPbRVIP04p6cW0HX2XN9MWZp8ZdmNkhyUmDi7C5zVoUW/7bkcoc6RPkso/mx+jbBzB/Eo=
X-Received: by 2002:a63:df06:: with SMTP id u6-v6mr2800082pgg.202.1539291042601;
 Thu, 11 Oct 2018 13:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181010214006.21304-1-natechancellor@gmail.com>
 <CAKwvOdk+JmBP4TBAG+DfhehofM0sO0vWRXbAbEifYy+T+u_SVQ@mail.gmail.com> <CAOtvUMezOMmyE=FW+nRqrR+r2NsNOCCXWwp0fja9gF7j-xQAnw@mail.gmail.com>
In-Reply-To: <CAOtvUMezOMmyE=FW+nRqrR+r2NsNOCCXWwp0fja9gF7j-xQAnw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Oct 2018 13:50:31 -0700
Message-ID: <CAKwvOdkUnpxJe+zXMWDHsfozi9D-TpPZgmasciRU-nkCA9xOGg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - avoid implicit enum conversion
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 12:47 AM Gilad Ben-Yossef <gilad@benyossef.com> wro=
te:
>
> Hi Nick,
>
> On Thu, Oct 11, 2018 at 2:49 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > $ grep -r set_cipher_config0 -n
> >
> > shows a healthy mix of DESC_DIRECTION_ENCRYPT_ENCRYPT,
> > HASH_DIGEST_RESULT_LITTLE_ENDIAN, and DRV_CRYPTO_DIRECTION_ENCRYPT
> > (all enumeration values of different enums).
> >
> > >
> > > drivers/crypto/ccree/cc_aead.c:1643:30: warning: implicit conversion
> > > from enumeration type 'enum drv_hash_hw_mode' to different enumeratio=
n
> > > type 'enum drv_cipher_mode' [-Wenum-conversion]
> > >         set_cipher_mode(&desc[idx], DRV_HASH_HW_GHASH);
> >
> > Looks like a lot fewer call sites using DRV_HASH_HW_GHASH; same value
> > as DRV_CIPHER_OFB (different enum), but can a block cipher mode and a
> > hash be valid values for pdesc->word[4]?
> >
> > >
> > > Since this fundamentally isn't a problem because these values just
> > > represent simple integers for a shift operation, make it clear to Cla=
ng
> > > that this is okay by making the mode parameter in both functions an i=
nt.
> >
> > This also looks like the simplest fix to me, assuming the values of
> > all of these enums are valid for whatever pdesc->word[4] is.  Can the
> > maintainers explain what is CC7x-DESC what the comment makes reference
> > to?
>
> They indeed are. CC7x-DESC is a shorthand for "CryptoCell 7xx
> Descriptor" used in the hardware documents.
> These descriptors are comprised of fields with context sensitive
> meaning, hence this "overloading".
>
> Given this overloading of meaning an  "int" type is indeed a better
> suited type here.

Sounds like they're valid values then.  Thanks for the info.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Thanks,
> Gilad
> --
> Gilad Ben-Yossef
> Chief Coffee Drinker
>
> values of =CE=B2 will give rise to dom!



--=20
Thanks,
~Nick Desaulniers
