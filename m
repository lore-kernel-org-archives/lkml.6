Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EA4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B61218FF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iXDGqimz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfBQJQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:16:06 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40151 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfBQJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:16:05 -0500
Received: by mail-it1-f194.google.com with SMTP id i2so34146826ite.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eicSp+PuSyOkItE3ZkwDQ1ChRoEgiArLpn1+vZed4pY=;
        b=iXDGqimzS0MkMcjiB77NiUCcBDjlPfQ6y/P7hqzDlY5ZdZTuRyjL37goCJzF8rJv84
         SH4XtfTlHqw+Et3Z7gXmo6uRuHoEoGlK/mi35AJsZz+H7u6TyxUB5WyBbKdagJ05ZeYJ
         gTpbzwXaNGD9n91/tlTdgZZD1WgxzSQIo/MHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eicSp+PuSyOkItE3ZkwDQ1ChRoEgiArLpn1+vZed4pY=;
        b=jSgizLVnFNVgkbte6+9LmvMHxPaEwrGFX+vIeJ8XVORqH5WqR28BopiIoBvbSQeUHH
         S3Z/j48MjUqpMF3oONQ0qcsBd/Kxdz75FD6250HCtCJ90jMWoVM3ajoN0RV/1jA6PLAN
         V/yevW5V399PoQkCFCEnxDjZghhv2BsTXAC3V6WrHPnhtJ78X3SSWbpS12i0hEOJf9q2
         4opHWtLqfOgdBHpYSUMRMZVDHJYwqRTPKeKpHx4un7iZ82GiKPocWKciYOFZIQAn17jG
         OeOjJ4MGduQ0X171ffASrwTPLNk39GuWeK1VljAXycdWGCZC0V7lANrEa0Irac8OoZaO
         5AyQ==
X-Gm-Message-State: AHQUAuZXxJCak5spkqr5RqSOL1G3dHgVAW5U0cx288boM7dWUIEpswff
        vts5YIZ7/QFmgeYjbYxARqS+mQc3OyrVN3ODCvpc/Q==
X-Google-Smtp-Source: AHgI3IbLSFmUv4MrziKkrS+PY429DOMYIgasdac4nLOZE0j2KETMQfVUGlW8q1ggM9aKJfgDnz0dBq555auK+uByy6Y=
X-Received: by 2002:a05:660c:252:: with SMTP id t18mr4667498itk.173.1550394964415;
 Sun, 17 Feb 2019 01:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com>
 <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
 <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com> <CAMty3ZDMB=pwY8Rxdt3du=90pksBedLo0Pc_-=diqx9-Xndzqg@mail.gmail.com>
In-Reply-To: <CAMty3ZDMB=pwY8Rxdt3du=90pksBedLo0Pc_-=diqx9-Xndzqg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 17 Feb 2019 14:45:52 +0530
Message-ID: <CAMty3ZDBu2Y9psNu9nrZ=BNVvhpJ2qYn-Qp7MDqdhK9_SrcpNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
To:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 1:21 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Dmitry and Rob,
>
> On Thu, Feb 14, 2019 at 3:21 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jan 22, 2019 at 7:39 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Mon, Jan 21, 2019 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > >
> > > > > On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > Please CC DT list if you want bindings reviewed.
> > > > >
> > > > > Sorry I forgot.
> > > > >
> > > > > >
> > > > > > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > > > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > > > > > which need to supply for controllers like GT5663 on some boards
> > > > > > > > to trigger the power.
> > > > > > > >
> > > > > > > > So, document the supply property so-that the require boards
> > > > > > > > that used on GT5663 can enable it via device tree.
> > > > > > > >
> > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > ---
> > > > > > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > @@ -23,6 +23,7 @@ Optional properties:
> > > > > > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > > > > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > > > > > >                               (swapping is done after inverting the axis)
> > > > > > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > > > > > >
> > > > > > > I think we normally use lower case in DT bindings and rarely encode
> > > > > > > voltage in the supply name unless we are dealing with several supplies
> > > > > > > of the same kind, but I'll let Ron comment on this.
> > > > > >
> > > > > > Yes on lowercase though there are some exceptions.
> > > > > >
> > > > > > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > > > > > probably need to keep the voltage, but the binding is incomplete.
> > > > >
> > > > > What is incomplete here? can you please elaborate.
> > > >
> > > > You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.
> > >
> > > Though it has other supplies, only AVDD28 is connected in the Host
> > > interface design similar like 9. Reference Schematic on Page, 23 in
> > > attached manual.
> >
> > That is for a particular board design. It still has other supplies.
> > Just make the binding complete please. You can make them optional. I
> > don't care if the driver supports controlling all the supplies or not
> > (though Dmitry might).
>
> So, Can I make bulk get and enable in all 4 regulators global to
> driver or specific to that chip, in either way the regulators which
> are not used to process via dummy regulators (which we all know).
>
> or regulator which are not using are get via devm_regulator_get_optional.
>
> Any suggestions?

Just realized to go with bulk calls, please have a look at on v5 [1]

[1] https://patchwork.kernel.org/cover/10816901/
