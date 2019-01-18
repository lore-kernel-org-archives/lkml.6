Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5CFC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C33420855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGv8lZ6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfARICU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:02:20 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38891 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfARICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:02:19 -0500
Received: by mail-lj1-f171.google.com with SMTP id c19-v6so10864702lja.5;
        Fri, 18 Jan 2019 00:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pf+orFAXU0UsxrI5UFtFzCZJ+tqvHhNURJ6yVZSS9js=;
        b=LGv8lZ6VDZL2GQj6WzeY6L19mATdsIlGldN5qMjbKmCFZgmvuPh+fB+C6zgQ2k69Nt
         HUQ+e/Jcodtm5kL2ZAD+fLfwzFyvtYZ75cTvZUDnUzlvGE2pt8rMtOv2ccw4GsYuHJM+
         LirOfc2UxqDlcAsldVv5V7vr9I3UWZAN6DGbRiDP7+1npXGwbBI1OfkkaMq8L5d+I2jJ
         nexvbBKPb5VusKaDb6lHHKmiIF10zbGca0iSL2CsTvKTvbou0LmetGqlrp9N8cio9dC2
         T7MO+b3BdRuBAEhvNSddfmCe2K/BQhkkvF32P3L+2x8WB4cimJDZ2GXMbe9eH2Ski0sz
         d9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pf+orFAXU0UsxrI5UFtFzCZJ+tqvHhNURJ6yVZSS9js=;
        b=mgXN33ovAryfAF0xYxblQTbev2qKEFzFhH5uiiMitkUkKJGmTmzaxBGnKNbsodQ9ge
         eNS/4uHLkSsObAb3J/iWHzFByNvE4VKt+/Q1JFzs8kMf6jAL3Sfafi+XPJPpFNFF/QIx
         5l/EDgVCML2D4v+Ra6nVlZqPZ12U9tZY7vBi+rLUkhdpKJ3a9yY0MWQ+A/p/ooPwCRPb
         QsiiIM2Z2y437tBGqIDAcVrSwyLHHxLgOP3XC3ed0Hcoq43SDvLa5Z6eNA9DIvyEElKv
         X5wWrZHu+bh1TYYC8AZrFrXbeLqb5CoqGEMJ7vG9DQC3jtVbIhzK4MG9bbtFB7CzXjER
         AV8w==
X-Gm-Message-State: AJcUukd0L8B0tjjaZZUXWYtES3ur6iPL+Fnd0BcLYoNoTo/g027LHnoh
        pYPk4y4uZzyyJXfYCwMcnqaJCdRzTfRJe6GCUZY=
X-Google-Smtp-Source: ALg8bN7ReaKKmO8lJAADvJPCYRa4VFT0az+fcgpuZJHjZ8OHhAxrxt8F8qK59/FmunH6kwwisnu6IuN9h3iWeMvkrdQ=
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr10176181ljj.149.1547798537950;
 Fri, 18 Jan 2019 00:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20190117231416.111952141@linutronix.de> <20190117231501.254152158@linutronix.de>
In-Reply-To: <20190117231501.254152158@linutronix.de>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Fri, 18 Jan 2019 09:02:06 +0100
Message-ID: <CAAUqJDufgoZMhPia5M6cc+V5tijX+huzncnd3LSp=DVhXy80Nw@mail.gmail.com>
Subject: Re: [patch 5/9] crypto: morus - Convert to SPDX license identifiers
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
>  crypto/morus1280.c |    6 +-----
>  crypto/morus640.c  |    6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> --- a/crypto/morus1280.c
> +++ b/crypto/morus1280.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * The MORUS-1280 Authenticated-Encryption Algorithm
>   *
>   * Copyright (c) 2016-2018 Ondrej Mosnacek <omosnacek@gmail.com>
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
>  #include <asm/unaligned.h>
> --- a/crypto/morus640.c
> +++ b/crypto/morus640.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * The MORUS-640 Authenticated-Encryption Algorithm
>   *
>   * Copyright (c) 2016-2018 Ondrej Mosnacek <omosnacek@gmail.com>
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
>  #include <asm/unaligned.h>
>
>
