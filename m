Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBBD2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KW12Jx+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfBRTac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:30:32 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37449 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBRTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:30:32 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so626634itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXhtUK9yvDv33+alsQQVdc5aweSnwD0PtOPFyoh7TbE=;
        b=KW12Jx+Yg+w+7LGEVs421mHid8FaFDqaepoQ9ju8EPzH+gzRM0MhmrBIw7bLDoy8Im
         Paz1t0TMDcTBjVE9QCWBbx5OCY52mx9QBEGtT6CxHi8SsDdiPgKhicHAvGO7zF8Zlry3
         +OzVidYfRGsCgdnNUyYRobdJ+x42VKgBTpoWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXhtUK9yvDv33+alsQQVdc5aweSnwD0PtOPFyoh7TbE=;
        b=bl6EDkJb7MRZQ3nYzscwMeElui+Yembpcj+9vyvZbbA9anLgv3y+i2LptyFj+RJ1Na
         ZlnJfxZ0aUSXqJ+DY/w8fD8TTuZz8aYboeeYvFFgdN0t8RYcXBOJXBIyoDYVqa8VAaO5
         Y+ZkNmJALFJZ1hAij2pnfKdKD6kBMsS5uVZo+AuIX0MqxBwRmsGxSjTIyHkMD0KYbMsl
         kX55VWc0jrGWAqbf1GlBA/pZ/fEfC3FcT56bw69Vq1xKR1v3tGe9WQqAUVC0roZ7RnnB
         a0PyIyl4ibif5f51uUFKjwz8sAeqHtFeEby5HLarLiyfXTIjzjLwI5yZqnqVHGXE7sdc
         gUFw==
X-Gm-Message-State: AHQUAuagphBXd7UIKA4CvBkzFpKGrQN91RTkNvhphRwHJOC52s1AQYgE
        p65ISg0n2M4Riw9dCdTwe4SjUaRTHU0rwvoELd1/BQ==
X-Google-Smtp-Source: AHgI3Ia3h+oETBfjiDLUKCCdRG3QGdGq/4zXrHXtPp8zcLGEKAcJw1xsNXgGZaLkf9WpTyAvNdcrLYIIFe14z8zU/Fo=
X-Received: by 2002:a02:104a:: with SMTP id 71mr1611038jay.103.1550518230924;
 Mon, 18 Feb 2019 11:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com>
 <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
 <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
 <CAMty3ZDMB=pwY8Rxdt3du=90pksBedLo0Pc_-=diqx9-Xndzqg@mail.gmail.com>
 <CAMty3ZDBu2Y9psNu9nrZ=BNVvhpJ2qYn-Qp7MDqdhK9_SrcpNg@mail.gmail.com>
 <20190218071207.GE242714@dtor-ws> <CAMty3ZDbFU-NpWQvkaUWgUiVTabjTZoFWUCUZSPKMA6VuHc+iQ@mail.gmail.com>
In-Reply-To: <CAMty3ZDbFU-NpWQvkaUWgUiVTabjTZoFWUCUZSPKMA6VuHc+iQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 19 Feb 2019 01:00:19 +0530
Message-ID: <CAMty3ZBVpNY+JF_vEMs83M29WKQDhzmk7LyL-HHCCA7uD0Y+=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 3:03 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Dmitry,
>
> On Mon, Feb 18, 2019 at 12:42 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Sun, Feb 17, 2019 at 02:45:52PM +0530, Jagan Teki wrote:
> > > On Sun, Feb 17, 2019 at 1:21 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > Hi Dmitry and Rob,
> > > >
> > > > On Thu, Feb 14, 2019 at 3:21 AM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jan 22, 2019 at 7:39 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > >
> > > > > > On Mon, Jan 21, 2019 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > Please CC DT list if you want bindings reviewed.
> > > > > > > >
> > > > > > > > Sorry I forgot.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > > > > > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > > > > > > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > > > > > > > > which need to supply for controllers like GT5663 on some boards
> > > > > > > > > > > to trigger the power.
> > > > > > > > > > >
> > > > > > > > > > > So, document the supply property so-that the require boards
> > > > > > > > > > > that used on GT5663 can enable it via device tree.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > > > > > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > > > > > @@ -23,6 +23,7 @@ Optional properties:
> > > > > > > > > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > > > > > > > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > > > > > > > > >                               (swapping is done after inverting the axis)
> > > > > > > > > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > > > > > > > > >
> > > > > > > > > > I think we normally use lower case in DT bindings and rarely encode
> > > > > > > > > > voltage in the supply name unless we are dealing with several supplies
> > > > > > > > > > of the same kind, but I'll let Ron comment on this.
> > > > > > > > >
> > > > > > > > > Yes on lowercase though there are some exceptions.
> > > > > > > > >
> > > > > > > > > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > > > > > > > > probably need to keep the voltage, but the binding is incomplete.
> > > > > > > >
> > > > > > > > What is incomplete here? can you please elaborate.
> > > > > > >
> > > > > > > You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.
> > > > > >
> > > > > > Though it has other supplies, only AVDD28 is connected in the Host
> > > > > > interface design similar like 9. Reference Schematic on Page, 23 in
> > > > > > attached manual.
> > > > >
> > > > > That is for a particular board design. It still has other supplies.
> > > > > Just make the binding complete please. You can make them optional. I
> > > > > don't care if the driver supports controlling all the supplies or not
> > > > > (though Dmitry might).
> > > >
> > > > So, Can I make bulk get and enable in all 4 regulators global to
> > > > driver or specific to that chip, in either way the regulators which
> > > > are not used to process via dummy regulators (which we all know).
> > > >
> > > > or regulator which are not using are get via devm_regulator_get_optional.
> > > >
> > > > Any suggestions?
> > >
> > > Just realized to go with bulk calls, please have a look at on v5 [1]
> >
> > I do not believe you can use bulk regulator API here as you need to
> > implement the power up timing scheme mentioned on p. 12 of the spec you
> > referenced earlier. And, because of that timing diagram, I believe if
> > you want to control AVDD supply, you also have to control VDDIO supply
> > as it has to be on only after enabling AVDD.
>
> AVDD here is AVDD28 it' is an out name of pin (mentioned in p. 23). So
> the power scheme goes to enable AVDD28 and then VDDIO does that really
> mean bulk of two regulators?

The time between these two regulator operations is nearly 0, as per
power scheme diagram T1 >= 0us. I think I can use bulk since there is
no necessity of delay between these two regulator operations.

What do you think?
