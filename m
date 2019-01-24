Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D002C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD68218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nRNRO1D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfAXEdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:33:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35642 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfAXEdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:33:02 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so2578166itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 20:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwWvCt7u+at9RudSFzks1IpTk55hx60weblM3U2HHgY=;
        b=nRNRO1D6U6JggJmn2XAZIAGZQ3XabbINBj9XrPE1Qo0hsQXuiORN9wHpIONhobCg+N
         LuwOVgBhaKzqyMyaXM3y6N63n+ztaRAdks8DQ9C37o6Tfg2MarQ4Kcy7ks+jlk9yNEoD
         5MAXZROxniaBUL3zbC3nJ4jx5lCIRJEbDvNTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwWvCt7u+at9RudSFzks1IpTk55hx60weblM3U2HHgY=;
        b=rvmmkz0RvfJkMPpSU97E2lvB7gDFH2YAPWegrZco01BQbRDhOnSP6Opi/rvTg/RQDb
         qQqV7bKtOZkonkftK/v+ndtUminPTpDCwOSyAG1dwLCMROv+RjDtUMI+A2Y60c6hyb49
         LRK8v77+AeeBqr4r1XCV9kfYJLwxCGg1F3T8E264DfkTXT0htQEiXV9p4mrIs30KN/CG
         eaMzFt2gw34TNNvrFPjKYxp4mtmViXViomAP8ujGq8Fo9HKdfktVGJZ1XAvdbzwTXzo6
         3NbRtCcY220JZvToU4izOi6Jt5m6BekbA2SOsRR9oyvTKsjmvh9qrZrz6rK5vXjvKnFw
         XMtQ==
X-Gm-Message-State: AJcUukeT1fBDUBeQgmbfz6UMbxk7hSzmOWln3OHeAnCrs26A6pG342Ja
        cT9cXKUGotb56YO40g9ii88I0xlqnkLL335Yu4xrPA==
X-Google-Smtp-Source: ALg8bN6tIm9vb76003GObzd1cbe7wbFbV35HZnL0Q6sXtLZ6Ao7Hum7bW3EFSz5keMUG2SNsXQNFdHX/GnumP6Y/yNk=
X-Received: by 2002:a24:385:: with SMTP id e127mr510288ite.32.1548304381613;
 Wed, 23 Jan 2019 20:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com> <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
In-Reply-To: <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 24 Jan 2019 10:02:50 +0530
Message-ID: <CAMty3ZAYn=jTB_2SKYKO_7WHTCNeazytsDPVxW23DcxO7QUiEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
To:     Rob Herring <robh@kernel.org>
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

+ DT ML

On Tue, Jan 22, 2019 at 7:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
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
