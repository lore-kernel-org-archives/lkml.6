Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396C1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A092075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550006344;
	bh=b8USUSrg3lJKX89ykkFcbjrdlAPDyKVL3G6hd2eIKTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sC8sVXb2fDc2wdzHWHvg3zv8xeQxaWXD+eZEkIYXecS0JmBEwGz0gG6wbsq072Sw+
	 No23rFTxO21C8dZuDjPLW4T71guC2jtwPlB4NEtiKw+vRnNxvH5NpglwWpo8QkJCVE
	 Ryt2io4CQX7v1Hhk7rdIG5rsKR6Tcy4V3gvK2nLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfBLVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBLVTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:19:02 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3B32081B;
        Tue, 12 Feb 2019 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550006340;
        bh=b8USUSrg3lJKX89ykkFcbjrdlAPDyKVL3G6hd2eIKTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QdssbfCLQx+1NjM8RrOrm7erZtinwVjJSa4a+r6GZrAp0tadbkmNAFQKP8lDSnx2t
         /fk514a292jF6WGM0psVno9umMFG/65mLK8EARg2npiOQmvQdMy1Q8UhhgODYecGFV
         vxO9Ieagwq/6/nV2T08oKRAQ1CVyeaZ5HjX38sIw=
Received: by mail-qk1-f172.google.com with SMTP id x9so118980qkf.0;
        Tue, 12 Feb 2019 13:19:00 -0800 (PST)
X-Gm-Message-State: AHQUAuZUuD74N0bLG91TBijdsBlo/1g7bjedM21EM7Me82bYhjE1vPDS
        OfGmJd46Ld+eXkvhxrMeHj/sfChzh4ph5XMWpQ==
X-Google-Smtp-Source: AHgI3IbGBC5HehArOZY6ed9XOuq2/9Lb4TpJX6nU6mD811cwtyzYbz48P+dF9MwrYsEa7CmR2h8pY4pkQsvgQAsxg2c=
X-Received: by 2002:a37:5686:: with SMTP id k128mr3941140qkb.29.1550006339312;
 Tue, 12 Feb 2019 13:18:59 -0800 (PST)
MIME-Version: 1.0
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com> <20190130155016.GA26536@bogus>
 <20190211092251.GV4686@localhost>
In-Reply-To: <20190211092251.GV4686@localhost>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Feb 2019 15:18:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
Message-ID: <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
To:     Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 3:23 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> > On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> > > Add binding for Mediatek-based GNSS receivers.
> > >
> > > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> > > ---
> > >
> > > v3:
> > > Removed the I2C and SPI interfaces references.
> > > Removed the "mediatek,mt3339" compatible line.
> > > Added the optional propertied (reset, fix)
> > > Added the pin names for the optional properties.
> > >
> > > v2:
> > > Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> > > Moved current-speed as an optional propertie.
> > > Removed the status line in the example.
> > > Added "mediatek,mt3339" compatible.
> > >
> > >  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > > new file mode 100644
> > > index 000000000000..00650d81c5c8
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > > @@ -0,0 +1,37 @@
> > > +Mediatek-based GNSS Receiver DT binding
> > > +
> > > +Mediatek chipsets are used in GNSS-receiver modules produced by several
> > > +vendors and can use an UART interface.
>
> s/an/a/
>
> > > +
> > > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> > > +properties.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible       : Must be
> > > +
> > > +                   "globaltop,pa6h"
> > > +
> > > +- vcc-supply       : Main voltage regulator (pin name: VCC)
> > > +
> > > +Optional properties:
> > > +
> > > +- gtop,reset-gpios : GPIO used to reset the device
> > > +                     (pin name: RESET, NRESET)
> >
> > reset-gpios is the standard name.
> >
> > > +- gtop,fix-gpios   : GPIO used to determine device position fix state
> > > +                     (pin name: FIX, 3D_FIX)
>
> I'm thinking we might need a standard name for fix-gpios as well. This
> isn't a feature that is globaltop (or mediatek) specific, and other
> manufacturers provide similar functionality through pins named UI_FIX,
> or even LCKIND (lock indicator).
>
> The pin is typically used to drive an indicator LED AFAIU, but the
> characteristics of the signal varies from device to device (fw to fw),
> for example, pulse when no lock and low otherwise, or pulse when a 2d or
> 3d-fix is acquired, etc.
>
> I'm not sure how useful the pulsing would be for software, but someone
> might find a use for it in some form.
>
> Rob, is this something we want to keep in the binding, and if so, how
> about using a generic name such as "gnss-fix-gpios"?

Sure. As long as details like being a pulse and when the pulse occurs
are implied by compatible string. So we don't get an endless addition
of properties to describe those.

Rob
