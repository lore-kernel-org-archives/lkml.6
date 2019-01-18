Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC9E20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw3H/3Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfARIC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:02:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39088 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfARIC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:02:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so10849936ljh.6;
        Fri, 18 Jan 2019 00:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fsKFVPzF0dRyW1g/yUfRd0CuK4ng6hz+eiWHoWJNg90=;
        b=Nw3H/3XoNTq240K+aiU98OyLO7GRAT+s1V6btI/iqXwcL2403RtI8/WkU0de2qUVG/
         mizOCMNoiGUB7GCQ1rG8llwZbnJigyTdQFYhmInxo1sB9YHhraAaS4O4FROvhDewHL/O
         tKOq27goK70tjh09bQdS0Khz8808O55s6JlpG26GOxRkls0qdZabxJ15zNfv5PPvzHmk
         l8hSo09v1Kx6YvY5lOoTs5ZBe1S4NqSOJG9qoOCXm2HUkzMpBZJ9TXKXOwhvmCju2Cq5
         rrxcfnRjVxDhRFriIwIBkHrfrvnZLRC1mk+QuZcYnkjiXFufiAaE4TCvOL1AegCMLoxS
         Jg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsKFVPzF0dRyW1g/yUfRd0CuK4ng6hz+eiWHoWJNg90=;
        b=kNe4YkOfre7aF2+7HDAlsNoBFXRYoSTfhQpx4+N9rBkPsj8p3/bakcb69VJm3QBlA1
         ExVDFS0GnIphDVJIFY5/E8lKO5OQ42wkQL7qZh6Ld3FVFvQ/htq8R/hMgDZjEzub+T35
         5EiMMAc+dfMGgSj/qlx063n6f2SlsMBDyC+Xe4j85CWD16U0wPyI6VyyRDdMkjupLHPV
         pmtOCwW3HVO1sWiGIzXFk+HZeqSoUO7f94rxri+bzMxOYA27zEV2tOuL7eB/4nSU1v7I
         ZIOY4POY+1w9t/GX9PPqzQc5rO6QTTKNE1uckIItvLPMau6oS6lbk2+2pk+KJih3qPCO
         JGRg==
X-Gm-Message-State: AJcUukcgichZ8McVNlgq5iOEEudHgX4vwkfYdGLBwLcddiJr4fzT25rC
        eXeNbkL2gaHEcnH1oLoUz1/UzIr7nG4v4ECRcbw=
X-Google-Smtp-Source: ALg8bN7jmgesgwL3dvoBE6omK4xazCvgKF8Gru08iJ3qsLQ5ydHv4xm18IIahJacrxmjRWYr8ox2mnABPo7a6EfA1/g=
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr11461379ljk.76.1547798576341;
 Fri, 18 Jan 2019 00:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20190117231416.111952141@linutronix.de> <20190117231500.970473486@linutronix.de>
In-Reply-To: <20190117231500.970473486@linutronix.de>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Fri, 18 Jan 2019 09:02:44 +0100
Message-ID: <CAAUqJDs0TqhgUw6kFGmGoR_RWiqUAgb68zne45J3JLKWAFjThw@mail.gmail.com>
Subject: Re: [patch 2/9] crypto: aegis - Cleanup license mess
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pi 18. 1. 2019 o 0:15 Thomas Gleixner <tglx@linutronix.de> nap=C3=ADsal(a):
> Precise and non-ambiguous license information is important. The recently
> added aegis header file has a SPDX license identifier, which is nice, but
> at the same time it has a contradictionary license boiler plate text.
>
>   SPDX-License-Identifier: GPL-2.0
>
> versus
>
>   * This program is free software; you can redistribute it and/or modify =
it
>   * under the terms of the GNU General Public License as published by the=
 Free
>   * Software Foundation; either version 2 of the License, or (at your opt=
ion)
>   * any later version
>
> Oh well.
>
> As the other aegis related files are licensed under the GPL v2 or later,
> it's assumed that the boiler plate code is correct, but the SPDX license
> identifier is wrong.
>
> Fix the SPDX identifier and remove the boiler plate as it is redundant.
>
> Fixes: f606a88e5823 ("crypto: aegis - Add generic AEGIS AEAD implementati=
ons")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ondrej Mosnacek <omosnacek@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org

Acked-by: Ondrej Mosnacek <omosnacek@gmail.com>
(feel free to keep the ack also if you decide to switch to the "GPL-2.0+" f=
orm)

> ---
>
> P.S.: This patch is part of a larger cleanup, but independent of other
>       patches and is intended to be picked up by the maintainer directly.
>
> ---
>  crypto/aegis.h |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> --- a/crypto/aegis.h
> +++ b/crypto/aegis.h
> @@ -1,14 +1,9 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   * AEGIS common definitions
>   *
>   * Copyright (c) 2018 Ondrej Mosnacek <omosnacek@gmail.com>
>   * Copyright (c) 2018 Red Hat, Inc. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify =
it
> - * under the terms of the GNU General Public License as published by the=
 Free
> - * Software Foundation; either version 2 of the License, or (at your opt=
ion)
> - * any later version.
>   */
>
>  #ifndef _CRYPTO_AEGIS_H
>
>
