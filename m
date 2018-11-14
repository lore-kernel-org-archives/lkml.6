Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4137BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0189D22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0189D22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbeKOCRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:17:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39417 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeKOCRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:17:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so11624497edt.6;
        Wed, 14 Nov 2018 08:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfWOmKQRmbEMHOxjGZmsaVrE2lw6kPdjyzf9nnMLiVo=;
        b=t+VXDM84HSpQppqVlIHLpLdU81tBChsIZDq9qwaP0tFIidOobeV1ZUEXdzQ7a24SL3
         yhKuDFZLOyCW9FuukCpwNyE76+hODWeUvg7o4lZ5pBd5vP6TdtIHY1FTaVPxTNfrpeOH
         4w9AQl55MzB7xkB6JM+JX8xFGHosSvOilqcDlIgluU/AZ47qG+243O3gPp8VgPUcrm3V
         47ZZ6oWmkueQCukXRt7U998Mw16XGE/F4Zy4kBvzngJmR8Q9EdHJ7IsqKPSkicq5L2EX
         h4GJwjCLJ8nCutUd2DDfoKJOGQrRyeHN3Qk0fjNifvYrTXEc1vDgk0QHF5Nj3qdMa6Np
         apRw==
X-Gm-Message-State: AGRZ1gJdhOwm2+7wxKWPKsLpsdOf1ODcIkocXRl5/jvcLFIJRovH9pPw
        UmtzzLhpaJfRFi5evXvyCCa58n7F28w=
X-Google-Smtp-Source: AJdET5cBtAaaRaF0vD/pPtOhP77+GfZr61beYiewA1kSHWc5r7xo0RCtew5qUfhQfHkv45gIIFiigg==
X-Received: by 2002:a50:afc4:: with SMTP id h62-v6mr2689497edd.209.1542212031705;
        Wed, 14 Nov 2018 08:13:51 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id b39-v6sm7434154ede.42.2018.11.14.08.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:13:51 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id b13so17905596wrx.6;
        Wed, 14 Nov 2018 08:13:51 -0800 (PST)
X-Received: by 2002:a5d:69ce:: with SMTP id s14-v6mr2668598wrw.177.1542212030738;
 Wed, 14 Nov 2018 08:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20181107101308.7626-1-wens@csie.org> <20181107101308.7626-2-wens@csie.org>
 <5bea0ebe.1c69fb81.e15d7.98e1@mx.google.com> <CAGb2v65PqwKrRdh2_Y48zYnmJa0=hv3Bd4UdvdWvBBMfT2BfSw@mail.gmail.com>
 <CAL_JsqJrJHatiYB=Vaakbi1UUGOkqvAkZnZRG=zz5Ae_RzxGgg@mail.gmail.com>
In-Reply-To: <CAL_JsqJrJHatiYB=Vaakbi1UUGOkqvAkZnZRG=zz5Ae_RzxGgg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 00:13:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v651WWMJigwLFneg6wXcwUeZKF0CooWe5bFpROMcjfn91A@mail.gmail.com>
Message-ID: <CAGb2v651WWMJigwLFneg6wXcwUeZKF0CooWe5bFpROMcjfn91A@mail.gmail.com>
Subject: Re: [PATCH 01/15] dt-bindings: net: broadcom-bluetooth: Fix external
 clock names
To:     Rob Herring <robh@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:51 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 13, 2018 at 9:15 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Tue, Nov 13, 2018 at 7:37 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Nov 07, 2018 at 06:12:54PM +0800, Chen-Yu Tsai wrote:
> > > > The Broadcom Bluetooth controllers can take up to two external clocks:
> > > > an external frequency reference, substituting the main crystal, and a
> > > > LPO clock at 32.768 kHz substituting the internal LPO clock.
> > > >
> > > > In particular, the external LPO clock must be used when the controller
> > > > does not have NVRAM connected, and the main reference frequency is not
> > > > the default 20 MHz. This is described in detail in the datasheet.
> > > >
> > > > The original "extclk" clock name is ambiguous as to which of these it
> > > > refers to, and some designs might even require both.
> > > >
> > > > This patch deprecates the existing name, and adds "txco" and "lpo".
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > > > index 4194ff7e6ee6..2535e54219af 100644
> > > > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > > > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > > > @@ -18,7 +18,10 @@ Optional properties:
> > > >   - shutdown-gpios: GPIO specifier, used to enable the BT module
> > > >   - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
> > > >   - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
> > > > - - clocks: clock specifier if external clock provided to the controller
> > > > + - clocks and clock-names: clock specifier if external clocks are provided
> > > > +   - "txco": external reference clock
> > > > +   - "extclk": deprecated, replaced by "txco"
> > > > +   - "lpo": external low power 32.768 kHz clock
> > > >   - clock-names: should be "extclk"
> > >
> > > This line should change?
> >
> > Yes. Missed that.
> >
> > >
> > > 'clocks' needs to describe how many clocks and the order of them.
> > >
> > > 'clock-names' needs to list the names. Keep them separate.
> >
> > I was under the impression that when clock-names was used, the
> > order of clocks shouldn't matter.
>
> Generally, no. The order should be defined still.
>
> > Also, both clocks are optional. The controller can use a standalone
> > crystal instead of an external TXCO, which would not get described in
> > the device tree, and/or not use an LPO clock. How would one describe
> > a device that has an LPO clock input but not a TXCO clock input?
>
> A crystal would still be a fixed-clock. Does s/w need to know which one it is?

The datasheet doesn't mention anything s/w related. It does provide
a CLK_REQ signal that the application can use to determine if the
TXCO signal is required or not, but then again one can just enable
it as part of the power sequencing. TXCO is general connected to the
same pin as an XTAL input, so nothing s/w related there.

As for the clock rate, the hardware detects it via some measuring
mechanism that requires the LPO clock be provided. Or the clock rate
is provided through NVRAM, or if it's one of the two standard rates,
using a latched pin. Hence I think if a crystal is used, it doesn't
need to go into the device tree.

> Your's is a case where index alone doesn't work and you need
> clock-names. But still, you should define the order for when both
> clocks are present so we don't end with both orders for no good
> reason.

I see. That makes sense.

> > Last, IMHO listing them with name + description, one item per line
> > is more readable then having the items on one line, then having the
> > next line list all their respective names. If ordering and number of
> > items is important, I could add the requirements to the description
> > of "clocks and clock-names"?
>
> clocks can just say something like "1 or 2 clocks as defined in clock-names".

OK. I'll rework this.

ChenYu
