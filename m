Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A00C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B535420834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="sLqH76PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B535420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeLBDJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:09:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55479 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLBDJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:09:57 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so3091721itg.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41+3VCJ4ZSFEMCnJ05n6tH7/QnAaCqx2XlEKnbLFX9A=;
        b=sLqH76PDwUa0k9fHHpWj/Y0t0tx81YBCvJVNEPx3Jnk1LRrmvJuqNOYpTUpVmnEsCz
         9bz4xqL9Ge31Fpda2Rp0mYKVIUiShHhUduZeduI0bgXDKpuGKbO6mxVxVvdaeLcNHPpy
         HMuIQcXsmjhTlnfrl6GGgw3k+aJA8WzN088sZ+14NfEslyhvTepZH2qVOmWwIl4mafEF
         f86waR3j3gD3i+TFYoeRT7Ti0/25NTxm2NtU3J2LujZ1UyQySSXk899ufh0Iz7OPZRhB
         Y8tFKkWH8Ft5XPM/eUZXEuuIGV9DFQAinviIkKWe+ZxgOrVe6SMPOCE2dzGA6tml5PQU
         DlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41+3VCJ4ZSFEMCnJ05n6tH7/QnAaCqx2XlEKnbLFX9A=;
        b=m8pnK/JkNNSfZ5Mvi+hUCe72W1zAuEREmICcF7E4hl5dhY4A1xqlln6XLkBmXxo8f+
         O+574yn5dlNoNJtgVz3Kn4F1dBW7PC9WbeaNdYUJpS48t5sN+FrjzYxkeNgyR+BOZOw0
         Y831R2+tW7xVbiZsHfHIugqMaLFR5h4Baf8LnXB8tJy2GLBWVLJSwYlu81APPkHbjFQV
         VTlxHPJrl4RJSeWgRhTOnDqdiTVjc/C96bhXNRKgEyk8HUEP1BQjvwemzdhbUSRwYRG3
         Pqpt3nObi4daR64EBobyTMjztjMGKkRapFQVsztowW5Qv6CuaM0BGuFo0jUXrajB+bsk
         itew==
X-Gm-Message-State: AA+aEWb50cLsa2fw7aHKhOqsmMYZnSDU/oQS+hcSA6a/e9XJ7dtkmc4l
        zzZ2n6gDm0U7rZQbJDGUVTaVV8v0DpuEB/ktC7pwBw==
X-Google-Smtp-Source: AFSGD/WOULCqe6a03vpxSEF3Gl5gt19ghssY/tXc0uwSVsuQ5sHpKh4touYOF1/N10i9+Og6jKn8XjORba/X7me+cvI=
X-Received: by 2002:a24:22c6:: with SMTP id o189mr2376954ito.86.1543679827575;
 Sat, 01 Dec 2018 07:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br> <20181128192901.GG8952@piout.net>
In-Reply-To: <20181128192901.GG8952@piout.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 1 Dec 2018 13:56:55 -0200
Message-ID: <CAHd-oW4umU7-BnLHYsokA3JhNbQ0TRU+WM2U0HCgqSz0Ebk3Xw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Support Opensource <support.opensource@diasemi.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>, Milo Kim <milo.kim@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-usp@googlegroups.com,
        Lucas Santos <ilucas.ms@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review! I will fix those places.

Matheus

On Wed, Nov 28, 2018 at 5:29 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 28/11/2018 15:53:12-0200, Matheus Tavares wrote:
> > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> > index f10443f92e4c..9f9c186e2135 100644
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   *  exynos_adc.c - Support for ADC in EXYNOS SoCs
> >   *
> > @@ -5,16 +6,6 @@
> >   *
> >   *  Copyright (C) 2013 Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> >   *
> > - *  This program is free software; you can redistribute it and/or modify
> > - *  it under the terms of the GNU General Public License as published by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> >   *  You should have received a copy of the GNU General Public License
> >   *  along with this program; if not, write to the Free Software
> >   *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>
> You forgot to remove some of the boilerplate here.
>
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > index 36b59d8957fb..894d49843854 100644
> > --- a/drivers/iio/adc/hx711.c
> > +++ b/drivers/iio/adc/hx711.c
> > @@ -1,13 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   * HX711: analog to digital converter for weight sensor module
> >   *
> >   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> >   * This program is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>
> and here
>
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 729becb2d3d9..f5299c9bdbde 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -1,12 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
> >   *
> >   * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> >   * You should have received a copy of the GNU General Public License
> >   * along with this program. If not, see <http://www.gnu.org/licenses/>.
>
> and here.
>
> >   */
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20181128192901.GG8952%40piout.net.
> For more options, visit https://groups.google.com/d/optout.
