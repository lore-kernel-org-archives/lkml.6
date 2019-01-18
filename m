Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD89C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640ED20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LXMsJsZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfARQBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:01:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40870 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfARQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:01:18 -0500
Received: by mail-io1-f65.google.com with SMTP id k2so11081606iog.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Byut/1RlUBRrULvMfwQGaAMeJfD4ScFHr+GlttByFqM=;
        b=LXMsJsZTgJzNIIa/y00gNhjPYRcYyZu1Mb6gFZk8uKA8A7qjpDb27JnIo7blnB2tM5
         0gM3L09m35NoVCKA519U+bORfXaTqltilFLKNb0yNkvUDrBqccDR08HRGlT9sZqzDeuk
         tmOzfeuxecVCUTIng3z3/qr01hqdGwOXeJhzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Byut/1RlUBRrULvMfwQGaAMeJfD4ScFHr+GlttByFqM=;
        b=uXg/4N1GuHtzT4f+Ych4boIYVCWHPK3hA33MtGmRrNKk2Rwa1gcbEhmW2z8RoeWeJi
         ZUCQow4g8UsCHq7ajuHFhB/3pqDvzy7QYA1hKRZbVU3ChOLIhLIF+6u17OScRLMQKSF1
         BzIguyDkK4Xu9dY7AL1dTHWUe8SCiz4uGPrXYmaqXrDGTj38otp2/ejVBK/78dVfBHv4
         DSsKoLzd8/Lwk05f+HUKuNiQUS4puW+CibSL+rM4iy96M1XALAAxh320ISrscdc0hA5B
         4PJZjbnNg7jpFNSOueK1AKcG0zTLfnFzT1j0KEKcW4Q9cIcoaGNhscmhSvS6hGErw9wy
         PM/Q==
X-Gm-Message-State: AJcUukc0I/daI/C9dq2P3dmMJphHui8HfCQHIaHuGE1NUSYtu+mubClf
        WbzIaQFZ/sxQwWpncQD6cyyFSsJWLtG348xUAs3vJA==
X-Google-Smtp-Source: ALg8bN7M5HyFccpv/BhVTv+RATOwZOZSOKKHkkq2L3pApu20Gpbd4uFD724ER22CSVhLxQBbNPpkmxc056dVo+2SOKA=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr10802431iou.252.1547827277280;
 Fri, 18 Jan 2019 08:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
In-Reply-To: <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 18 Jan 2019 21:31:04 +0530
Message-ID: <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
To:     Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
>
> Please CC DT list if you want bindings reviewed.

Sorry I forgot.

>
> On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > which need to supply for controllers like GT5663 on some boards
> > > to trigger the power.
> > >
> > > So, document the supply property so-that the require boards
> > > that used on GT5663 can enable it via device tree.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > index f7e95c52f3c7..c4622c983e08 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > @@ -23,6 +23,7 @@ Optional properties:
> > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > >                               (swapping is done after inverting the axis)
> > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> >
> > I think we normally use lower case in DT bindings and rarely encode
> > voltage in the supply name unless we are dealing with several supplies
> > of the same kind, but I'll let Ron comment on this.
>
> Yes on lowercase though there are some exceptions.
>
> There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> probably need to keep the voltage, but the binding is incomplete.

What is incomplete here? can you please elaborate.
