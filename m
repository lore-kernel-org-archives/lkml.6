Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3E82082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3E82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeLEJLr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:11:47 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44353 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEJLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:11:47 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so11614072vsd.11;
        Wed, 05 Dec 2018 01:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BGg1+77tU3sD+fgVGBgdcnlBqoPPDehgShNpz79U790=;
        b=QsrLffzkM8hI1Erbw9oINWZUCnOWqVS5+DnZKYmfglpP3CP1fbicO99qEVfIgafBEd
         mTjRs+U3gba/uSA/eL4mxfVgapRV/KBQ+Gj8XLGZ6e9/KlAmKAqB8vZg5KYJ/pDutAWd
         g12F56FX2TSh+YQI+lYUQIvl/RbOm5MYFc9q9EB9drxy/SB2it1PHfh/En8kuTf6ARd9
         kIOHYi9ExzCUFlYa+j1Qb+pJIoB2W3AySkITBQorc5YUqUWnG6o1E0ZVDNpiOzYrszd0
         pa2lMBtlIpG9tbi5pDnwit/m+5WOWx1SBZC8eqUS3Oq6EURhKRS1d31U64RfXVew7nE5
         qc8g==
X-Gm-Message-State: AA+aEWYbxPxjupb9eW5DvXk+X+A2DcdhEukvi+7gIXLyeu2lFflgso+1
        y3PNbm/sEhCdKGZ9lyhOv6rXPehS/apakdjNdvU=
X-Google-Smtp-Source: AFSGD/VhczJmhGQ/SW1iQt4QUWgEs6T0o4OfuzLf0924E9dJUC37EFr0NSTaUjd/JkV7XRH2ML7XxeAG2wMf/8VVLy8=
X-Received: by 2002:a67:d119:: with SMTP id u25mr9575026vsi.63.1544001106166;
 Wed, 05 Dec 2018 01:11:46 -0800 (PST)
MIME-Version: 1.0
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com> <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
In-Reply-To: <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Dec 2018 10:11:34 +0100
Message-ID: <CAMuHMdXS_039E6F3=+UgfE_KgJcwmVvA-zPraOiQPUXMEwck2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
To:     masonccyang@mxic.com.tw
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Wed, Dec 5, 2018 at 8:44 AM <masonccyang@mxic.com.tw> wrote:
> > "Marek Vasut" <marek.vasut@gmail.com>
> > 2018/12/05 上午 10:04
> > On 12/03/2018 10:18 AM, Mason Yang wrote:
> > > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> > >
> > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

> > > +static u8 rpc_bits_xfer(u32 nbytes)
> > > +{
> > > +   if (nbytes > 4)
> > > +      nbytes = 4;
> >
> > Use clamp() ?
> >
>
> nbytes = clamp(nbytes, 1, 4);
>
> got many warnings, something like,
> ./include/linux/kernel.h:845:29: warning: comparison of distinct pointer types lacks a cast

You can either make the constants unsigned (1U and 4U), or
use clamp_t(u32, ...).

> > > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> > > +               (op->data.nbytes)) | RPC_SMENR_SPIDB
> > > +               (fls(op->data.buswidth >> 1));
> >
> > Drop parenthesis around fls()
>
> ?
> no way.

Please split the line before RPC_SMENR_SPIDB, and join the next line
with the parameters, so it becomes obvious the parentheses are needed
because RPC_SMENR_SPIDB() is a macro taking parameters.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
