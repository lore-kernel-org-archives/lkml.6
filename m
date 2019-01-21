Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3048DC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0ABA20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548087419;
	bh=JxtVpJxY3XtxWcUbYSQ+0yAiHD86+4cmV6KOM9FsZEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N2CwAsWVI/8fndRqpFJKow7pCWDaXz2arcV8zu6XkG48pEs8RGVJOS64Met3wWE6R
	 2af+YSxQi9Cc32YMWVwy/ynqlkb7usgCUcCFq8yn0qSZRJKPEfcrd/7VOCnM7xpdwj
	 SO0bntmqLqtpDOGmz00JZemHQxr3ESt/+C/t0CMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfAUQQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbfAUQQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:16:56 -0500
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com [209.85.161.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166C121019;
        Mon, 21 Jan 2019 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548087415;
        bh=JxtVpJxY3XtxWcUbYSQ+0yAiHD86+4cmV6KOM9FsZEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ECjtTXcBLoNOY/dpE3oMp5KquniUbESzthQ6KvzvvN4WC5HZGntNlwhOk6qrHw+qK
         3Hm5zphxjavtiYS8H2Yjg4rzDirneGhpse1IkN1DxfBLl2R+B1QrpIT1eykwuwVEA3
         QYaN6ZPLqzJzsNKo506e39AAFO8DPlhnpMIEEyCg=
Received: by mail-yw1-f45.google.com with SMTP id t13so8198411ywe.13;
        Mon, 21 Jan 2019 08:16:55 -0800 (PST)
X-Gm-Message-State: AJcUukcnSpmFMIqRln/0CyXjGTxronlMhJ6iZ2bO6mSMqq0r6iTOBF7D
        HrmrJmshsy9C2NRP+dpIC8p5Qr0p5fzK7+zvEQ==
X-Google-Smtp-Source: ALg8bN5uKiCJja1bkYucZ4/Iy8rEPPSAeQoVr8/Ke9rCRYMH02APxWY8TC9A1J4rhyzly0huq1jdpEcPH2hC6OQHXoI=
X-Received: by 2002:a81:3944:: with SMTP id g65mr29110172ywa.337.1548087414360;
 Mon, 21 Jan 2019 08:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com> <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
In-Reply-To: <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Jan 2019 10:16:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com>
Message-ID: <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Please CC DT list if you want bindings reviewed.
>
> Sorry I forgot.
>
> >
> > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > which need to supply for controllers like GT5663 on some boards
> > > > to trigger the power.
> > > >
> > > > So, document the supply property so-that the require boards
> > > > that used on GT5663 can enable it via device tree.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > @@ -23,6 +23,7 @@ Optional properties:
> > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > >                               (swapping is done after inverting the axis)
> > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > >
> > > I think we normally use lower case in DT bindings and rarely encode
> > > voltage in the supply name unless we are dealing with several supplies
> > > of the same kind, but I'll let Ron comment on this.
> >
> > Yes on lowercase though there are some exceptions.
> >
> > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > probably need to keep the voltage, but the binding is incomplete.
>
> What is incomplete here? can you please elaborate.

You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.

Rob
