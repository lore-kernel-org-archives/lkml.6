Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F130C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443620855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTrREv6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfARIBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:01:36 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:39056 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfARIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:01:35 -0500
Received: by mail-lf1-f45.google.com with SMTP id n18so9801944lfh.6;
        Fri, 18 Jan 2019 00:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q1A/ERqRkb8HYuG2x3CL6B3TQY/QFcUAvI4jNtRrkj4=;
        b=iTrREv6QGmRjVGTcmo3wBRdP5fbZkarHvxkOlQ5aVJ2m5dZk+1mvIbAQgpNGM6uUw5
         XgvpcKrLhP7IKTAP+YOhaQJNfTbwjU07uIIR7mED5QaoHDTCfXy0cUHgXDh8BwZhNSEq
         hwVX4BxLTSB1bblV9N4irWOpYFNmZbyUgHtnuZLdw0z63MFgTcgS8bb+A4tPzUpc3/7A
         l+bYlB3l9ebZNkvawaG3evOXfJxrB7uaPJjZIx4kKoVFfdOPPJisRYbDDzdEIFcdT5Mw
         ZhOWjqfKkjSCA8K15v2+yWrbmz2PyRElYFKoPOPyh27aV9tVoR75aV/n6LsdDzee/uZH
         nXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q1A/ERqRkb8HYuG2x3CL6B3TQY/QFcUAvI4jNtRrkj4=;
        b=UvDOxiJt+3+Mioji0dDfNgF3VWpLS/kA9aUVhRImypO87WV1njODzOeT7Kb6P34Ekt
         40dTuMrcGZ+0w46TyBqAOptYfOHbLG62udpgb802oEZi6S0//TYfv96MYFOzBIuIJfGo
         J6SvGrylAalmcFVzjbGQQPgoxIXYWPRirkERERg8yKPvdBRQwzkYhFUt/dyn3W1VIpBL
         dlBcWPvygSAfyPPVjGkXJFGXAsfaapCtAYRFd61cfKUYwumROKfavGKT7Mw/QOR9CBRP
         M718rhqwU+CL7Zl0/NdNJaLLfEUVeaUt0EGZxcke8BmTXO+JpVS1jklUkLbKaCfDU5sz
         GUrQ==
X-Gm-Message-State: AJcUukc2aDFjtPrtbhnhzbJ5uQrKdb556JxK62OYD60Y5lLZgshscWBp
        f4IWsff/5wAkqTCvdRvuwYFT3r9b+7UPZWjdsOM=
X-Google-Smtp-Source: ALg8bN6tAm23h9Q+D/AZyj4hBKGWtf8lSx0tgf3iXvumx0xgsLjV4oBIil5KBvpM2XLSHRoWadV0ZlpxJ19K8FQziCU=
X-Received: by 2002:a19:2395:: with SMTP id j143mr11915090lfj.107.1547798493630;
 Fri, 18 Jan 2019 00:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20190117231416.111952141@linutronix.de> <20190117231501.162093731@linutronix.de>
In-Reply-To: <20190117231501.162093731@linutronix.de>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Fri, 18 Jan 2019 09:01:22 +0100
Message-ID: <CAAUqJDu99D=gS5UabQXz1bDMjwiSUNpdW=MVrFcBLXcy_TzWbA@mail.gmail.com>
Subject: Re: [patch 4/9] crypto: aegis - Convert to SPDX license identifiers
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
> The license boiler plate text is not ideal for machine parsing. The kerne=
l
> uses SPDX license identifiers for that purpose, which replace the boiler
> plate text.
>
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
>  crypto/aegis128.c  |    6 +-----
>  crypto/aegis128l.c |    6 +-----
>  crypto/aegis256.c  |    6 +-----
>  3 files changed, 3 insertions(+), 15 deletions(-)
>
> --- a/crypto/aegis128.c
> +++ b/crypto/aegis128.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * The AEGIS-128 Authenticated-Encryption Algorithm
>   *
>   * Copyright (c) 2017-2018 Ondrej Mosnacek <omosnacek@gmail.com>
>   * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
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
>  #include <crypto/algapi.h>
> --- a/crypto/aegis128l.c
> +++ b/crypto/aegis128l.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * The AEGIS-128L Authenticated-Encryption Algorithm
>   *
>   * Copyright (c) 2017-2018 Ondrej Mosnacek <omosnacek@gmail.com>
>   * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
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
>  #include <crypto/algapi.h>
> --- a/crypto/aegis256.c
> +++ b/crypto/aegis256.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * The AEGIS-256 Authenticated-Encryption Algorithm
>   *
>   * Copyright (c) 2017-2018 Ondrej Mosnacek <omosnacek@gmail.com>
>   * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
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
>  #include <crypto/algapi.h>
>
>
