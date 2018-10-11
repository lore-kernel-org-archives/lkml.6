Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2F3C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0662087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="id/ZkOyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0662087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeJKPNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:13:36 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42072 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeJKPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:13:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id e126so7627271vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wd+5i5zoj3nhmh5T/im6jwqG/NtYklTjRzxwTnK4Z3w=;
        b=id/ZkOybZCU6dh6FE9jYaZy/QNNdMd9VBnkN5KAm677o3cnodjaelKq3UGoNPmQIHX
         xCSxYbbRjbx6Hjh3/cbD4/IGZzLJxKxgopAdoVbVXUB6ns9lU/PVZ98lOs5dmekvKQpN
         g5yDwOoB5A3ltNhXOb0KqsAOQuBsyJq/hR7TB80BDBGZLe7HNv8jvx9V6kZ5P2FsR3LX
         ND9GH+24NCuqdzM/+EakQpvMPngDPVTaQq7w4AeCNt51GtSkbfqF/VcqLViarLOMJOf6
         Mfb+bt+hnx3PBdqwvH2hZEdzav+WpgggB3CyVsm6QPHNiCEnRzWM9PWiYBXb5W6vX5vr
         GIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wd+5i5zoj3nhmh5T/im6jwqG/NtYklTjRzxwTnK4Z3w=;
        b=Xh87OA2utclVG+RpoCffiHaMl/Ft8koPp9z6JlAkCh11Ne+D38ia2hrGdyKjt8KAxz
         VY2VOIw2SO67ajSPAYOc4zaUgzo8ES+d8nQN0fucJMJS19cGDOmVWd61blR0B5YV9hw9
         8rC1Nam5AHbQ0C0WC6eay/GeVH+HBYIdQgPFEHkaMo2ERP/v8VeMsmgY+aZjGSPkpfk2
         LODMKo+X2KMFqHV6nxKKLeSHEZMp/MSLDvNzZfSwrmaSeUlM9IZOvUwuyNier3dc3DyV
         QNZ07j4DxHO3ywHtFTiZLRo3DTipyQKg9Acu/rty2rhFmy8A2+Z3nMk6fJG9eo0KZJiY
         +9Mg==
X-Gm-Message-State: ABuFfoh7PRV9Yr8iNEbPQ07rOU7jvdG9b36MCIgVc4oFJWUQaKVUUS8H
        IFqTHqJ7zwECbiV0Tn08vCi42wOQ5bik6tIZ8K3NwA==
X-Google-Smtp-Source: ACcGV63XkMnJp3ypakcvJuKzT/2SIY7IfMCBCMjeC87et6fJP08lC37PJRy55wd/zyTZHPpDeCz62nevGVL1loZKPVM=
X-Received: by 2002:a67:3e81:: with SMTP id a1mr197329vsi.136.1539244051746;
 Thu, 11 Oct 2018 00:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181010214006.21304-1-natechancellor@gmail.com> <CAKwvOdk+JmBP4TBAG+DfhehofM0sO0vWRXbAbEifYy+T+u_SVQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk+JmBP4TBAG+DfhehofM0sO0vWRXbAbEifYy+T+u_SVQ@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 11 Oct 2018 10:47:20 +0300
Message-ID: <CAOtvUMezOMmyE=FW+nRqrR+r2NsNOCCXWwp0fja9gF7j-xQAnw@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - avoid implicit enum conversion
To:     ndesaulniers@google.com
Cc:     natechancellor@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Oct 11, 2018 at 2:49 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> $ grep -r set_cipher_config0 -n
>
> shows a healthy mix of DESC_DIRECTION_ENCRYPT_ENCRYPT,
> HASH_DIGEST_RESULT_LITTLE_ENDIAN, and DRV_CRYPTO_DIRECTION_ENCRYPT
> (all enumeration values of different enums).
>
> >
> > drivers/crypto/ccree/cc_aead.c:1643:30: warning: implicit conversion
> > from enumeration type 'enum drv_hash_hw_mode' to different enumeration
> > type 'enum drv_cipher_mode' [-Wenum-conversion]
> >         set_cipher_mode(&desc[idx], DRV_HASH_HW_GHASH);
>
> Looks like a lot fewer call sites using DRV_HASH_HW_GHASH; same value
> as DRV_CIPHER_OFB (different enum), but can a block cipher mode and a
> hash be valid values for pdesc->word[4]?
>
> >
> > Since this fundamentally isn't a problem because these values just
> > represent simple integers for a shift operation, make it clear to Clang
> > that this is okay by making the mode parameter in both functions an int=
.
>
> This also looks like the simplest fix to me, assuming the values of
> all of these enums are valid for whatever pdesc->word[4] is.  Can the
> maintainers explain what is CC7x-DESC what the comment makes reference
> to?

They indeed are. CC7x-DESC is a shorthand for "CryptoCell 7xx
Descriptor" used in the hardware documents.
These descriptors are comprised of fields with context sensitive
meaning, hence this "overloading".

Given this overloading of meaning an  "int" type is indeed a better
suited type here.

Thanks,
Gilad
--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
