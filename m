Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8861C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925E4222A6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094693;
	bh=yGjH5vgIFWXajVcNqHuUGUz3Z5VHCBG3KE7tWxlyFOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VmCZFSkImgMece7PdFq7jKdA3bkY1xZLhm/OrikkU2vj6Yw7bn5U/QdoVPBAzzJTI
	 8ZYK+YcOiaiB4d+ni/LC4xy78oW+vSMeK9dfd2a9iyN5WbHQ4LEUW6l77DmENLztSi
	 AvZR9JnmDQ7J+01Kb178i/lnt5cjQJZAq0+apyEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436964AbfBMVvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfBMVvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:51:31 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0905B222C9;
        Wed, 13 Feb 2019 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550094689;
        bh=yGjH5vgIFWXajVcNqHuUGUz3Z5VHCBG3KE7tWxlyFOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WWCHSh5IAqgmfJA6mbNuKZhl1e4eIF5rlQNIcxa22REq30kB3UmN+J6Ym82ktmQZe
         Hk2mJqS71Bovafx85wvXY/5pRYMaewhKnscB5FpI2hnJ0vFg1GFlsSV1MMHPad18a0
         BYE3kFJ7Qemjjy3ua35QWw4IOTT0F/YSdK8ooY1Y=
Received: by mail-qt1-f173.google.com with SMTP id p48so4552493qtk.2;
        Wed, 13 Feb 2019 13:51:29 -0800 (PST)
X-Gm-Message-State: AHQUAubyZIH7vdwQfqMybhwk7aN99dTZMF2u4z968S1zEkg4xXCGavoo
        jqC61OQ+1sR0Uq8224Ac1gzy11wIRJEUXhdcWw==
X-Google-Smtp-Source: AHgI3IYPBIKjO1mnzKuwsD7PbEn8n0TrRoY+RoQXW/wJLCnI0OMeDIfNZWySbXwDR38++B5hcN/rfGra3ozZGyNze+Q=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr316251qta.76.1550094688260;
 Wed, 13 Feb 2019 13:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com> <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
In-Reply-To: <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Feb 2019 15:51:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
Message-ID: <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
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

On Tue, Jan 22, 2019 at 7:39 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Jan 21, 2019 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > Please CC DT list if you want bindings reviewed.
> > >
> > > Sorry I forgot.
> > >
> > > >
> > > > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > > > which need to supply for controllers like GT5663 on some boards
> > > > > > to trigger the power.
> > > > > >
> > > > > > So, document the supply property so-that the require boards
> > > > > > that used on GT5663 can enable it via device tree.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > @@ -23,6 +23,7 @@ Optional properties:
> > > > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > > > >                               (swapping is done after inverting the axis)
> > > > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > > > >
> > > > > I think we normally use lower case in DT bindings and rarely encode
> > > > > voltage in the supply name unless we are dealing with several supplies
> > > > > of the same kind, but I'll let Ron comment on this.
> > > >
> > > > Yes on lowercase though there are some exceptions.
> > > >
> > > > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > > > probably need to keep the voltage, but the binding is incomplete.
> > >
> > > What is incomplete here? can you please elaborate.
> >
> > You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.
>
> Though it has other supplies, only AVDD28 is connected in the Host
> interface design similar like 9. Reference Schematic on Page, 23 in
> attached manual.

That is for a particular board design. It still has other supplies.
Just make the binding complete please. You can make them optional. I
don't care if the driver supports controlling all the supplies or not
(though Dmitry might).
