Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B57C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DED214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ve2C5CHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DED214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbeKOBzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbeKOBzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:55:06 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4941C2250E;
        Wed, 14 Nov 2018 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542210678;
        bh=VTHr3fAdt5vwARfak4LZXfyZmBjUoFavs+fdfIZIV7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ve2C5CHb3hdZfl9ZwjhW0CZWCTa4UEWi0GF/FB9+0f40jqtrwpIjlZVPGVASq1NWn
         8JcgogU9rIWBMTk1E31RbZDjNYZKxGy96K8yedl82OfVezDc2aKcrapmdwFJpD11VM
         zUfOZxmeRDXm+W/AYxM5vrF+XMYoqDFspnOEnJRs=
Received: by mail-qk1-f177.google.com with SMTP id d19so26545507qkg.5;
        Wed, 14 Nov 2018 07:51:18 -0800 (PST)
X-Gm-Message-State: AGRZ1gKjNrvJ+bsSCqoKzRfnT23bKroS+dEo0d+EHV865d8GjDBS5U4G
        UoK26r/3gAehb6qFW19v2zKI3SktteRUQNKL3Q==
X-Google-Smtp-Source: AJdET5dmVTn7ADDx8cfyCE/ie6eD7l/DpKIxg//L8J+CaN/aopv7fzZWfz0GtYQIHrKDBgsNJwwNV2U5XlovmjOl5TA=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr2342136qve.246.1542210677398;
 Wed, 14 Nov 2018 07:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20181107101308.7626-1-wens@csie.org> <20181107101308.7626-2-wens@csie.org>
 <5bea0ebe.1c69fb81.e15d7.98e1@mx.google.com> <CAGb2v65PqwKrRdh2_Y48zYnmJa0=hv3Bd4UdvdWvBBMfT2BfSw@mail.gmail.com>
In-Reply-To: <CAGb2v65PqwKrRdh2_Y48zYnmJa0=hv3Bd4UdvdWvBBMfT2BfSw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Nov 2018 09:51:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJrJHatiYB=Vaakbi1UUGOkqvAkZnZRG=zz5Ae_RzxGgg@mail.gmail.com>
Message-ID: <CAL_JsqJrJHatiYB=Vaakbi1UUGOkqvAkZnZRG=zz5Ae_RzxGgg@mail.gmail.com>
Subject: Re: [PATCH 01/15] dt-bindings: net: broadcom-bluetooth: Fix external
 clock names
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 9:15 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Nov 13, 2018 at 7:37 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Nov 07, 2018 at 06:12:54PM +0800, Chen-Yu Tsai wrote:
> > > The Broadcom Bluetooth controllers can take up to two external clocks:
> > > an external frequency reference, substituting the main crystal, and a
> > > LPO clock at 32.768 kHz substituting the internal LPO clock.
> > >
> > > In particular, the external LPO clock must be used when the controller
> > > does not have NVRAM connected, and the main reference frequency is not
> > > the default 20 MHz. This is described in detail in the datasheet.
> > >
> > > The original "extclk" clock name is ambiguous as to which of these it
> > > refers to, and some designs might even require both.
> > >
> > > This patch deprecates the existing name, and adds "txco" and "lpo".
> > >
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > > index 4194ff7e6ee6..2535e54219af 100644
> > > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > > @@ -18,7 +18,10 @@ Optional properties:
> > >   - shutdown-gpios: GPIO specifier, used to enable the BT module
> > >   - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
> > >   - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
> > > - - clocks: clock specifier if external clock provided to the controller
> > > + - clocks and clock-names: clock specifier if external clocks are provided
> > > +   - "txco": external reference clock
> > > +   - "extclk": deprecated, replaced by "txco"
> > > +   - "lpo": external low power 32.768 kHz clock
> > >   - clock-names: should be "extclk"
> >
> > This line should change?
>
> Yes. Missed that.
>
> >
> > 'clocks' needs to describe how many clocks and the order of them.
> >
> > 'clock-names' needs to list the names. Keep them separate.
>
> I was under the impression that when clock-names was used, the
> order of clocks shouldn't matter.

Generally, no. The order should be defined still.

> Also, both clocks are optional. The controller can use a standalone
> crystal instead of an external TXCO, which would not get described in
> the device tree, and/or not use an LPO clock. How would one describe
> a device that has an LPO clock input but not a TXCO clock input?

A crystal would still be a fixed-clock. Does s/w need to know which one it is?

Your's is a case where index alone doesn't work and you need
clock-names. But still, you should define the order for when both
clocks are present so we don't end with both orders for no good
reason.

> Last, IMHO listing them with name + description, one item per line
> is more readable then having the items on one line, then having the
> next line list all their respective names. If ordering and number of
> items is important, I could add the requirements to the description
> of "clocks and clock-names"?

clocks can just say something like "1 or 2 clocks as defined in clock-names".

Rob
