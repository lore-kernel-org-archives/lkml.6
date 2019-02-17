Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B47C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F872195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="U3VZcLod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfBQHvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 02:51:38 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37395 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBQHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 02:51:38 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so5775413itc.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 23:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELtZwcO6EdbEYuyrkDnaZRUMLsiN11Y6I/1350//bz4=;
        b=U3VZcLod/pnQYxuE+m6Wt0L2rMdBuCnYqwbTm/K/SO7UkT9w5stW7C/MDgKKlmhDqf
         w95x5p4QJpox2JxG0mxddol8NXR/InDbbWVZPF9/MJ5VDSulssvcnUfIbkRjfDHnkZQ7
         RBFFw/o+uydN51Vz7OC+Z6qsl/aJ/KIuO4UJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELtZwcO6EdbEYuyrkDnaZRUMLsiN11Y6I/1350//bz4=;
        b=Lukbtt6i/q9FTqXyIXBZ4x2Avm2mganYjp9jKN0P3RBQaR66VOPGPP0Q8HXH253Tag
         YKfwWqrd2R6GR6kfHIjnKGNDmf8jR7erUY15w026zMy06VNvHQ06rYgcNwipkpQqZj8h
         gBbL5+zvblevFHuZ7fPKhtBIyV0SG1lMWRD3G7f1l3u43uJFtrE+FFRkVV+QStTHzYjz
         XIqho578P0kkuq8qnrIxZofcFxrCQA6qvz5T7gPzS/HCAPF208/wjz4k+6ixfcqzWCZ0
         ZRVs7mVZ92OM5jIuTjvKE20P3dAVtYPSfQCYaf3onUsQj+X7F0WmPXhuDPVJis8th5KY
         Ex0g==
X-Gm-Message-State: AHQUAuaoSP1sJwh5Pa76WiHp5pnSCURsJtUYc/wjgxD8dc4tlkg7Hy73
        jv7RehSK/d8GGOarrcVf0VpCvt+21Rrrgcjo6mvbkA==
X-Google-Smtp-Source: AHgI3IYk9eO2gjWnuedaTDo2YU7s+JZWh2o8NKp3Fqmgrq92XQKizN3hrCRsXVSLdE8gDmkiMZsg4V7dD2orgYY3vlY=
X-Received: by 2002:a24:385:: with SMTP id e127mr8725543ite.32.1550389896954;
 Sat, 16 Feb 2019 23:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com>
 <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com> <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
In-Reply-To: <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 17 Feb 2019 13:21:25 +0530
Message-ID: <CAMty3ZDMB=pwY8Rxdt3du=90pksBedLo0Pc_-=diqx9-Xndzqg@mail.gmail.com>
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

Hi Dmitry and Rob,

On Thu, Feb 14, 2019 at 3:21 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 22, 2019 at 7:39 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Mon, Jan 21, 2019 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > Please CC DT list if you want bindings reviewed.
> > > >
> > > > Sorry I forgot.
> > > >
> > > > >
> > > > > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > > > > which need to supply for controllers like GT5663 on some boards
> > > > > > > to trigger the power.
> > > > > > >
> > > > > > > So, document the supply property so-that the require boards
> > > > > > > that used on GT5663 can enable it via device tree.
> > > > > > >
> > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > > @@ -23,6 +23,7 @@ Optional properties:
> > > > > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > > > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > > > > >                               (swapping is done after inverting the axis)
> > > > > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > > > > >
> > > > > > I think we normally use lower case in DT bindings and rarely encode
> > > > > > voltage in the supply name unless we are dealing with several supplies
> > > > > > of the same kind, but I'll let Ron comment on this.
> > > > >
> > > > > Yes on lowercase though there are some exceptions.
> > > > >
> > > > > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > > > > probably need to keep the voltage, but the binding is incomplete.
> > > >
> > > > What is incomplete here? can you please elaborate.
> > >
> > > You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.
> >
> > Though it has other supplies, only AVDD28 is connected in the Host
> > interface design similar like 9. Reference Schematic on Page, 23 in
> > attached manual.
>
> That is for a particular board design. It still has other supplies.
> Just make the binding complete please. You can make them optional. I
> don't care if the driver supports controlling all the supplies or not
> (though Dmitry might).

So, Can I make bulk get and enable in all 4 regulators global to
driver or specific to that chip, in either way the regulators which
are not used to process via dummy regulators (which we all know).

or regulator which are not using are get via devm_regulator_get_optional.

Any suggestions?
