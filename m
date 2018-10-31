Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB04ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B55E20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq2wbLiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B55E20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeJaSNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:13:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:13:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so1422774wre.1;
        Wed, 31 Oct 2018 02:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fsq1VqTew96OoSDms5Ov7sKntaVeoGGNOSSHZqFQ0U4=;
        b=jq2wbLiKUycP0bgpaY3R7vzvqANS2Jc0pmTU4WRpoayd+2U1Tu0ly+rsV8p8IntWiW
         BYCPJf15sCtp1MfvAna1CnFbGVXyBQUTOmrTd98Bu0FjgUeytrwsY/VpdK79GIPToqS5
         rzRwWTvxgDIAEJ76mGQ7BmCRlZAi8mTFk8ff0D65owh4kEbbhZHXtchjVh7kW6rbCjBZ
         rv2rT0MHz6Lig7shp+GNs8YLh+mgDuQuN7nKzIc3EqC8XaED6gz/xCy2esJkU7QvjnGF
         PqrDaX7H2jQYblRUw9/+ohtu6xV0b5tLOc7JrdrNBO8gjpDcLCLFKPb099+zjYpZ96qq
         Gjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fsq1VqTew96OoSDms5Ov7sKntaVeoGGNOSSHZqFQ0U4=;
        b=XNpG0pz0GjNFpg3fE/Z0urLgNlZhzSmeu1RZiZ5fx4iF3jtFjrkNn37PeA7KDsq4g7
         FhPc1pkq+RXBt6i8s8yqgo3+/iToRC3c7sqV6quqchbTBfaUcplmpA8gZ1yVHQXU3n1c
         5hK0hj/kcwtKgxSs8zWGpG7zNxzArOS0M1tcZBeHyBDVFDpyx0gr2sFnqgBTWGxSQHkk
         MlGYrizSx4Vckk8/SLmsD/QizJYf3AvyG8fdnFxhLDEb9JKBrM4DaWaSbDJtJmEPQGSO
         sObe2xv3Yr0yEFxxmDGxRLYKbb2zCvCN8O8mF5BecpR2AsIacsZ8R/XZsAbTgx9kr3LJ
         tFvQ==
X-Gm-Message-State: AGRZ1gIAVKp35Z4CVmwUNwuMpnHoCLpiD3I7jAojpbRyBY57pAB/1D+I
        q9FDaPf2wYV8UMr/DgsMo04BVj5tTpSCQoLyRtw=
X-Google-Smtp-Source: AJdET5dV0Yd97hiCU4cmQta1pKPYHWajtwcagGwthP2Ia/JhwTyvEaxTlJIF+nC6KtRL2OorEx82F+hiBujsNMUtF2Y=
X-Received: by 2002:adf:ae09:: with SMTP id x9-v6mr1881102wrc.102.1540977364981;
 Wed, 31 Oct 2018 02:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com> <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
 <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
In-Reply-To: <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Wed, 31 Oct 2018 20:15:52 +1100
Message-ID: <CAGRGNgWUpaG6W92CDBy7XCun10-TnPggTgY=iZ_4dg4E1cM7ew@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 17/25] dt-bindings: panel: Add
 Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     a.hajda@samsung.com, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>, jernej.skrabec@siol.net,
        anarsoul@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        michael@amarulasolutions.com,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Wed, Oct 31, 2018 at 7:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >
> > On 26.10.2018 16:43, Jagan Teki wrote:
> > > Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> > > bridge panel, which is available on same PCB with 24-bit RGB interface.
> > >
> > > So, this patch adds DSI specific binding details on existing
> > > dt-bindings file.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - Use existing binding doc and update dsi details
> > > Changes for v2:
> > > - none
> > >
> > >  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
> > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > > index 35bc0c839f49..b7855dc7c66f 100644
> > > --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > > +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > > @@ -1,12 +1,39 @@
> > >  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> > >
> > > +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
> > > +
> > > +Depending on the variant, the PCB attached to the panel module either
> > > +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> > > +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> > > +itself
> >
> > As I understand this is display board, which contains 'pure' RGB panel
> > S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
> > These are separate devices, just connected by vendor to simplify its
> > assembly. Why don't you create then bridge driver for ICN6211 and RGB
> > panel driver for S070WV20-CT16 - it looks more generic.
> > Then you can describe both in dts and voila.
> > Creating drivers for every combo of devices (panel + bridge), just
> > because some vendor sells them together seems incorrect - we have
> > devicetree for it.
>
> Rob suggested this, and also the opposite: using the same
> "bananapi,s070wv20-ct16"
> compatible string for both types of connections, and have the driver deal with
> detecting the bus type.
>
> The thing about the bridge chip is that there's no available datasheet that
> describes all the parts of the init sequence, in fact none at all. I managed
> to work out some bits, but the others remain a mystery and must be hard-coded
> to match the panel. That would work against having a generic bridge driver.

To me it seems logical that we'd model it as another step in the graph
between the DSI component and the panel. It's conceivable that some
other manufacturer will probably buy these for their panels and having
a somewhat generic driver seems vaguely future proof to me.

As I see it, the weird init process belongs to the bridge chip and the
timings belong to the panel and we shouldn't "confuse" them by giving
them the same compatible.

That said, I'm sure that these chips are already old hat and we'll
have something different and even more incomprehensible next week.

Thanks,

--
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
