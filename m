Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9198C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8305420661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfAIStv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:49:51 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39969 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAIStv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:49:51 -0500
Received: by mail-ua1-f68.google.com with SMTP id n7so2757151uao.7;
        Wed, 09 Jan 2019 10:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+rgcDqI8CEHwQAJP0zPbgTwogwHzwkVgpn2Q+/ndIY=;
        b=ImgoTRif0XanKU6zLeeT3um7qKZ8lZx/+estHoj3khNCAjOfwfipzMKEFEJbnhokD0
         UF4HXN4Ogq3SYpZnj5EvBmi/P2pVsyP4I+q3Ec3FG0I4voaDK4ebqlvW19iBoYZv/Qxw
         +Nc8SMcI9epVXMeTG36XyKUVUvEOlRJkaW2+Ea8BHQhfVZLIGsGCdciXZI2Q1QV0Xt2Y
         qQOSj6mERpQ/nLOyR5CHvMALoLAfU6KN2kzjjFpbK0EdHEXLHHDI2P+GxkqRVOzzFXTo
         UMxEwwgKqotdLM9Zxk93qqppMXYTJRkogypS/mAAG+rbRR1TY6ytX6iQupiQ3tapO35K
         72Mw==
X-Gm-Message-State: AJcUukfUSgbKr6AdzyadE29d4G8UY63VlYzOr4U1mt3Y2bgoXnTwXgt5
        p1P9claa6YvtXGtfCKOc789+HCwgQQZbzsazvHkAGeQK
X-Google-Smtp-Source: ALg8bN4lqdNLaXNOGiAtZ8kEeFcqJsCijrRjVK3BN8kmQm+DfYDwcsLFO5VJ4iiEDmC/IuBR36eGWqdZm1K1xefyHgg=
X-Received: by 2002:ab0:216:: with SMTP id 22mr2628571uas.28.1547059789275;
 Wed, 09 Jan 2019 10:49:49 -0800 (PST)
MIME-Version: 1.0
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw> <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
In-Reply-To: <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jan 2019 19:49:37 +0100
Message-ID: <CAMuHMdUPsN-VMhbttVK19gL_nPdaCTHHC7Dn3ajPoVhMqDJf_w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On Wed, Jan 9, 2019 at 7:47 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 01/08/2019 07:16 AM, Mason Yang wrote:
> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> >
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>
>    You now need to add:
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -544,6 +544,12 @@ config SPI_RSPI
> >       help
> >         SPI driver for Renesas RSPI and QSPI blocks.
> >
> > +config SPI_RENESAS_RPC_IF
>
>    Since the driver is called without -IF suffix, I wouldn't use it in the
> Kconfig name either, the following is enough:
>
> > +     tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
> > +     depends on ARCH_RENESAS || COMPILE_TEST
>
>    Judging on the compilation error reported by the 0-day bot about readq(),
> we now need to depend on 64BIT or something...

IIRC, this hardware block is also used on RZ/A, which is 32-bit.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
