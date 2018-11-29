Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D382081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+KU4g/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D382081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeK2SEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:04:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35812 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeK2SEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:04:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so772626oif.2;
        Wed, 28 Nov 2018 23:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HM0aL8n+oQrEdDnPyjU9BKZi6/yD9UyY+k/TLgqyg8=;
        b=Z+KU4g/7sC+S1AVEcAGSb9RTA4e+3cWRtN+s9+MFq7TA5stMNeVCyQgfJBva2FHJ/N
         T7Ao50asKDAe0FxSnDhbdiYFqRJ7ivJi9Ib4YMx9eR0a6Q8R10aMNpBvkgXkM1QES/Qb
         MZA6HruIMUQu8o73DhxmZtNramf1d0vMrRWZ/hhzB/yuTBAtYMEaW63d9v7FexOT5srj
         3SIzB6jigjBmh7NRuKcmItwP3O5VYMduYQCShJczn7gLkAEUNNxFynn4QtMX5cEPF3KM
         au0Iv0h/M4kb5fpeDbgxlqlo7MEPgfWSd2/aF8OvfXX26qa9mmYPOKrbsPqefKwjRq87
         fYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HM0aL8n+oQrEdDnPyjU9BKZi6/yD9UyY+k/TLgqyg8=;
        b=aL5uSg+kARPO9DrN6CXezLX57aJqtVmEQKvgDbmOthBit27y6c3P0lmyST1E800VYh
         wG1T7Vh0c/80K3YR9L+E9UFuZ851XjfwqvMuJTuT7mI9uhMUcQOqXlTG/x7QyixwiP6x
         vL4zUXO94Lwi6wExc/jt50Py5URq1CbUbhErPUTef68v/o53+ef7Wc9IaoUxikgsJ0O7
         mGnzYyVBNIgMsGF3Bw9fyVsT9Gba9jHCVtMPzJvUFdJDmmyBTVjNDEIo/lvAjo9LC206
         8MptW0YU31LL97776MBjQ10miUPnnXOLpvsRFphVFr9NMOBao2t0bzZKwQqlsdfLOVpn
         onpw==
X-Gm-Message-State: AA+aEWbk/X86GSMfQQZKHPXFlUmtQfxaNi7hY9JYHff4qMA2SepgaJby
        Jf2OUTGQDH1lgPO6JINvrbP9IV6VXGFi/ySqbPmEtraNeiU=
X-Google-Smtp-Source: AFSGD/X0j+gtCGJyJXSzfznfGLMS5qLgzIYGf1jaK07WdrvlwmrX9a195RYCwdbopp6KjiXtCaBki57vuF6xuJwbV6I=
X-Received: by 2002:aca:4709:: with SMTP id u9mr189277oia.212.1543474802140;
 Wed, 28 Nov 2018 23:00:02 -0800 (PST)
MIME-Version: 1.0
References: <CA+XhMqz7ZaGVNpkrRM-t4h2f9UZVQPjLVB5Txco4bKGRm8k=mA@mail.gmail.com>
 <20181129064913.wbudlexjzszpa7dq@gondor.apana.org.au>
In-Reply-To: <20181129064913.wbudlexjzszpa7dq@gondor.apana.org.au>
From:   David CARLIER <devnexen@gmail.com>
Date:   Thu, 29 Nov 2018 06:59:50 +0000
Message-ID: <CA+XhMqzw9pqFw30QD=XpFTAqu+t1v5q24ODR+zynZQJJrS9xZw@mail.gmail.com>
Subject: Re: [PATCH] crypto: use memzero_explicit instead of memset to clear contexts.
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meant regardless how the kernel is compiled (ie optimisation level),
the contexts are guaranteed to be wiped because of the memory fences
used.

Kind regards.
On Thu, 29 Nov 2018 at 06:49, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Wed, Nov 28, 2018 at 07:36:50PM +0000, David CARLIER wrote:
> > There might be a little performance drop but to make sure it stands
> > by it comments, we really wipe the whole context after usage.
> > ---
> >  crypto/chacha20poly1305.c | 3 ++-
> >  crypto/md5.c              | 2 +-
> >  crypto/rmd128.c           | 3 ++-
> >  crypto/rmd160.c           | 3 ++-
> >  crypto/rmd256.c           | 3 ++-
> >  crypto/rmd320.c           | 3 ++-
> >  crypto/sha3_generic.c     | 3 ++-
> >  7 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/crypto/chacha20poly1305.c b/crypto/chacha20poly1305.c
> > index 600afa99941f..6e93d998109e 100644
> > --- a/crypto/chacha20poly1305.c
> > +++ b/crypto/chacha20poly1305.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/string.h>
> >
> >  #include "internal.h"
> >
> > @@ -388,7 +389,7 @@ static int poly_genkey(struct aead_request *req)
> >         }
> >
> >         sg_init_table(creq->src, 1);
> > -       memset(rctx->key, 0, sizeof(rctx->key));
> > +       memzero_explicit(rctx->key, sizeof(rctx->key));
>
> Please explain the purpose of this patch.  As it stands this
> makes no sense.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
