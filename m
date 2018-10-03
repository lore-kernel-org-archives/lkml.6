Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50337C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B3F21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B3F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJDBev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:34:51 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41893 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDBeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:34:50 -0400
Received: by mail-vk1-f196.google.com with SMTP id x21-v6so297149vke.8;
        Wed, 03 Oct 2018 11:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7H/BHggausBgvhl/2pvWbDrV7w0Drjgjnt6hABz3h5g=;
        b=UVdBc6BwktM/jY/KNC3R51+0+zXEyRdYYGAcABxkwNfFNOfiF9nu12nTZtjBq5rOFA
         /kvK2gRuOMH7xtgH+Ovaj7a3jytay8AJmrcOYZH4FcdQAJCWDYOJ++VI3MccApKhsLz0
         flQ31P+QuyhjMMtNy0H4UdBSylLGj+lBX+Q2aY2nVAvct50qPVdP4b2A2Rb8P+fOgYDG
         ubQoElRqq7FRnPV6QjtJfGa7GZXOhv86Gb0fDnPwFG09FQR6e8WQWjMh8o3WC/mGAaux
         31E9N7x5FlrOgxMy8THLAxXxvRaIwnRtAlQsbvcaDJ5DzHqSJl7iwPLSAlqywEfQwj9J
         xvTA==
X-Gm-Message-State: ABuFfojTZJxnFC0xVd9LqxhP1KF1wtKs81S74ZmICyq1YBw/nNhcIV9E
        NyrJ8n6K2VMQ7lrjEjejWIW677LEaChvUeU+SKo=
X-Google-Smtp-Source: ACcGV61MVV8VCotlXsaFTavxyZbh9si0Pc1tVwcziw+vFsPBgYXLn2J8K4/8U0AocdvsDju4CiyJLkHDuyFxS6Xbp5Y=
X-Received: by 2002:a1f:2d56:: with SMTP id t83-v6mr1154967vkt.65.1538592314105;
 Wed, 03 Oct 2018 11:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
 <20181003132212.12619-6-boris.brezillon@bootlin.com> <c7b929a8c8ebaec7ce0f0e09f803e414e74f986b.camel@perches.com>
In-Reply-To: <c7b929a8c8ebaec7ce0f0e09f803e414e74f986b.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Oct 2018 20:45:02 +0200
Message-ID: <CAMuHMdVA7eKD+qfzzCqrXus69NPb3Qd_G0k=TYvrdt=2pRG51A@mail.gmail.com>
Subject: Re: [PATCH v8 05/10] dt-bindings: i3c: Add macros to help fill
 I3C/I2C device's reg property
To:     Joe Perches <joe@perches.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, pgaj@cadence.com,
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Oct 3, 2018 at 8:37 PM Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-10-03 at 15:22 +0200, Boris Brezillon wrote:
> > The reg property of devices connected to an I3C bus have 3 cells, and
> > filling them manually is not trivial. Provides macros to help doing
> > that.
>
> This patch logic seems excessively fragile.

> > --- /dev/null
> > +++ b/include/dt-bindings/i3c/i3c.h

> > +
> > +#define I3C_PID(manufid, partid, instid, extrainfo)          \
> > +     ((manufid) << 1)                                        \
> > +     (((partid) << 16) | ((instid) << 12) | (extrainfo))
>
> This macro doesn't make any sense.  Missing a shift and an or?

No, it generates two of the three cells.

> > +
> > +#define I3C_DEV_WITH_STATIC_ADDR(addr, manufid, partid,              \
> > +                              instid, extrainfo)             \
> > +     (addr) I3C_PID(manufid, partid, instid, extrainfo)
> > +
> > +#define I3C_DEV(manufid, partid, instid, extrainfo)          \
> > +     I3C_DEV_WITH_STATIC_ADDR(0x0, manufid, partid,          \
> > +                              instid, extrainfo)

And the above two macros generate all three cells.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
