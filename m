Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECF120693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5O5KiR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECF120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGQVd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:33:29 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44265 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeGQVd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:33:29 -0400
Received: by mail-lf0-f67.google.com with SMTP id g6-v6so1839812lfb.11;
        Tue, 17 Jul 2018 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xQD8rXDSZuNUjODavj/BObqQe1YuTPyRihz1AZ/+1O4=;
        b=O5O5KiR0qcvMhAgfiCepX2Wjp2X5YbQzXEiMyCtzpHPRsDyuGm+N5HGAYfH1rs/bfZ
         FPqeJJMl/CNA2fKk/g9eP8RhzpEpBpvFWEEc9cdaIPL9JE5ujLAogZFb4MieW7bAa3aM
         uPuaMBiaNINJikrpeMjpYsH3MkyTK1QYxhgzLwGBORFfnETx53LfsWMeCj8nVEiYTrSJ
         YYeqrfIYKu/OpgkMojXILR1ZICZayR3OujDSIytaXOmGzj/gVeT1dHEPPbDhiejLPePs
         EiX8TAnYAtTSiEqMHz9jUq4nbnC7pBPZYAoh2iR7EXi3Tdw9ylEayzI8OjYbYV+t0v+z
         Nvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xQD8rXDSZuNUjODavj/BObqQe1YuTPyRihz1AZ/+1O4=;
        b=QQoPlEWdnT8m0u90KL8nNvI5amwwtOzzy43Txw5/i6wRXCsoDGXMTZ2eDx5p/uACMa
         cn013ROlf1HchyK/sRvLdXCjv/WdJelUapRqPEK8HDdcr6Rwf39bBP+SJCikSVySFiy8
         DfXfBl65x93KAr/ByeftvvAUUnvYeeDFRwponBEtlHhigKeqRQ447YRxA5SRwGeitF0z
         AgMvxsrxsTmtslizNpKmKJ3U+6+vkl+Jp2AJdQttKQGDVaVMaqL8GWHsVgi4o6oGMgyb
         d7BVBGlC57t+hu/qUJWYa9moWuIwUu4q3vCgF6pf3z+wAsHrdVEup4OxVO+RuJ/5hlIw
         fYsA==
X-Gm-Message-State: AOUpUlEiBqQDMWqWx4KaBShTfgdahzZP/h3EvB/Uc9YTFu4MioZIeJSC
        tig2yivpY9PbKfmBQTSso7dYiu87Kodf2jfgHdk=
X-Google-Smtp-Source: AAOMgpdfBH/3ThwNmGdiXnmKqYdHMVitAFxiNadDAsvx5bxnPjAovUpbNzWjHJ2gdC3nZEzkS/GpoZVHMKymeSbZGH8=
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr2321816lfe.148.1531861141737;
 Tue, 17 Jul 2018 13:59:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:59:00
 -0700 (PDT)
In-Reply-To: <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au> <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
 <20180713052029.cfo24bsr5swtbdja@gondor.apana.org.au> <CAGXu5jLG4gE44z9cXL3-D1bjbZB1RgTnTsb3PWhU7B3NdRrwVg@mail.gmail.com>
 <CAK8P3a3nk4-EewKTXcLENTb86r1+bJz_WrkJoJt+D1uTwcpxPA@mail.gmail.com> <CAGXu5j+Q_jc_f9VybyoJqmV7_Q-3hqnC-pOubfNsi7uyAROVrQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Jul 2018 22:59:00 +0200
X-Google-Sender-Auth: ygSPwkRKrTzzbBxLpxAZEi-9gWY
Message-ID: <CAK8P3a3Dh+g=v++BMCtmmiOSnVu4CEUgss0U7BZS_K45aTddqg@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 6:28 AM, Kees Cook <keescook@chromium.org> wrote:
>
> After my ahash to shash conversions, only ccm is left as an ahash
> user, since it actually uses sg. But with the hard-coded value reduced
> to 376, this doesn't trip the frame warnings any more. :)
>
> I'll send an updated series soon.

Maybe we should get rid of that one as well then and remove
AHASH_REQUEST_ON_STACK()?

I see that Ard (now on Cc) added this usage only recently. Looking
at the code some more, I also find that the descsize is probably
much smaller than 376 for all possible cases   of "cbcmac(*)",
either alg->cra_blocksize plus a few bytes or sizeof(mac_desc_ctx)
(i.e. 20) for arch/arm64/crypto/aes-glue.c.

Walking the sglist here means open-coding a shash_ahash_update()
implementation in crypto_ccm_auth(), that that doesn't seem to
add much complexity over what it already has to do to chain
the sglist today.

      Arnd
