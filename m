Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D9D20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYQi/M10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfARIAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:00:36 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:45045 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfARIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:00:35 -0500
Received: by mail-lj1-f177.google.com with SMTP id k19-v6so10809595lji.11;
        Fri, 18 Jan 2019 00:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CquQiRt0SoSbb2VUuWFwF4qNFQ3WPGTFJPlZGC5XVek=;
        b=SYQi/M10sQATFffroDBGfFJdxgOIwAgBJq9OqwSTYANJxFZ/TbpIdbTYXIH5ca5/mo
         spStlefWIhFwVXjFn3DRJuF8itRsSCFcLDwG0gqn8v3gfwZFwx6JCD4Meh8CJYZTy7AA
         SqbNhwVJaaU75UEbxJNs+O9x/pmUdtACLfK5ELhXEQrrJpaF/+geJE7VuW9Trd13cgfa
         n3K+x1610HcmsUlYIbRaQv0o//N1a4hpsxcxoFIpPwcgzRCE7KtJaBh7qNeDoDXgc+g+
         QDpd3WAzqy1xBwVNQ/LuZX/G82tvxyXmsTl/D8KueWB3YPxI2bLPM81XUIXu8LdDQAYd
         bT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CquQiRt0SoSbb2VUuWFwF4qNFQ3WPGTFJPlZGC5XVek=;
        b=q6Ql8eUjfG8ad5/RfV8qjV9j5rKuG+FJNIoS+Mj0bJOGB/4OO7nEpGuWCxwq3Y4zZx
         W5kk4e5ZUak788sWZpAt/oXkTcYmaYWSfDtN1JS4piIB7wNrUbh3t9QBA+I851DVjU4K
         qE8wtWGJpWgKl1W7d6lU9VMusi2R6d3ndkcy9vKAolqshylB60WngaxzTJhVy/Vd6w81
         YF3KglHfgUxlWM30GztiNE0EnvyrIldQrUdFDB2OiLTILC1w9xnwCHcg/EsFXS7Xu6aj
         /nlUPUbKK1HBFGhSP/lYVpG/YL5HvFVgJSsOKw7WQiOsqggwJqpcsRxOn5ui2DBArewU
         JCGQ==
X-Gm-Message-State: AJcUukcnkoi00xUb+Fx7nlfwWRZbR/4WtWfoimGVeS5M4auU/+3h24XG
        lqjZUyPuwNpp9aEGdSavfPL631UB7Khjja8N15P695M0
X-Google-Smtp-Source: ALg8bN4ASNm7hDXW+0b4+yc4pBHjidS4V4mFVcQCpO/If6p40Ob7QqvEAIqmKlXOycwkMGYzk+QmWSqiD2iDWh5fVt8=
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr11682597ljc.172.1547798432266;
 Fri, 18 Jan 2019 00:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20190117231416.111952141@linutronix.de> <20190117231501.068505479@linutronix.de>
In-Reply-To: <20190117231501.068505479@linutronix.de>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Fri, 18 Jan 2019 09:00:20 +0100
Message-ID: <CAAUqJDs6VoE-pTQ9Sk0eTV1+Z+20WFh3hxQTkNAxePkVZDgtpg@mail.gmail.com>
Subject: Re: [patch 3/9] crypto: morus - Cleanup license mess
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
> added morus header files have a SPDX license identifier, which is nice, b=
ut
> at the same time they have a contradictionary license boiler plate text.
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
> As the other morus related files are licensed under the GPL v2 or later,
> it's assumed that the boiler plate code is correct, but the SPDX license
> identifier is wrong.
>
> Fix the SPDX identifier and remove the boiler plate as it is redundant.

Thanks, I must have copy-pasted the bits from somewhere and didn't
notice the discrepancy...

>
> Fixes: 56e8e57fc3a7 ("crypto: morus - Add common SIMD glue code for MORUS=
")
> Fixes: 396be41f16fd ("crypto: morus - Add generic MORUS AEAD implementati=
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
> ---
>  include/crypto/morus1280_glue.h |    7 +------
>  include/crypto/morus640_glue.h  |    7 +------
>  include/crypto/morus_common.h   |    7 +------
>  3 files changed, 3 insertions(+), 18 deletions(-)
>
> --- a/include/crypto/morus1280_glue.h
> +++ b/include/crypto/morus1280_glue.h
> @@ -1,15 +1,10 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   * The MORUS-1280 Authenticated-Encryption Algorithm
>   *   Common glue skeleton -- header file
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
>  #ifndef _CRYPTO_MORUS1280_GLUE_H
> --- a/include/crypto/morus640_glue.h
> +++ b/include/crypto/morus640_glue.h
> @@ -1,15 +1,10 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   * The MORUS-640 Authenticated-Encryption Algorithm
>   *   Common glue skeleton -- header file
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
>  #ifndef _CRYPTO_MORUS640_GLUE_H
> --- a/include/crypto/morus_common.h
> +++ b/include/crypto/morus_common.h
> @@ -1,15 +1,10 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   * The MORUS Authenticated-Encryption Algorithm
>   *   Common definitions
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
>  #ifndef _CRYPTO_MORUS_COMMON_H
>
>
