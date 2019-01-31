Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0820C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66D52082C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KVGulXci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAaVxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:53:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37442 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfAaVxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:53:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so1943090pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:from:message-id:cc
         :references:user-agent:to:in-reply-to:date;
        bh=kDOqpi260tMB/+OJjw4/Es0QJMcc0lVjzm6HaAG14H8=;
        b=KVGulXcitOhJONDt43kZ0P/mdeJoKKfVKiWFlAybwvtWoTQqdW8Tw/eBX23x28iSre
         iTa96tG8U9gtc0FV5FQsJIUgnCK1+4XgVog/BqoChi/zbVn3PXkkOrPArMwpLYlF9/1+
         6/8VA9ymsRa7uy/R4m/GbgZKp8xRzos7Jj+8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:message-id:cc:references:user-agent:to:in-reply-to:date;
        bh=kDOqpi260tMB/+OJjw4/Es0QJMcc0lVjzm6HaAG14H8=;
        b=Ja9sp1qFN619X40g5rQACpSy1QOsjlfTrCP8bYEjLovVxr4sJpdJ4uqyM7JWuEeUTf
         u1esgNdSq5HBY2Ry72C5TS0GxxBo8diG6aS2FmhhMPqzR3Yp20xwK73F1hywa4zn7YfJ
         UzitRHbcqA4ROpvTuaKVqx3ODoooQ+YkFyYiBKUIJy9yjpE36yJzoWo0CMQFmBPrsiLF
         MuzerQtCn3QyFTgw4GsXZ5HTQVU+rsx270XZ8UCrZYx3Ym1zDOQTj7bTKJXnm9ppvgt9
         SPxrcZMrSVmo055qoYZ9iTro+7wfNEJHxhXxXqryFuh/twCxUNH0WJaI7AVP24xyLBVj
         mIrA==
X-Gm-Message-State: AJcUukcNcQwup5E3rjU7EEGlv5q3cDnbe/JnoF5PBeno6qyYd+EgvdV9
        2fh9p9lSRl8A1B/veInCBOMG0Q==
X-Google-Smtp-Source: ALg8bN5bIsPRbKmHBVvwyOrx2c0wZ6HfmLzINXWX+3jsJDVTJ0y6faCmca++BXbaXK4eCXA86z8ijQ==
X-Received: by 2002:a63:441e:: with SMTP id r30mr33466651pga.128.1548971624451;
        Thu, 31 Jan 2019 13:53:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f6sm8285511pfg.188.2019.01.31.13.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:53:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent for GPIO
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154897162267.169292.1911486544543857784@swboyd.mtv.corp.google.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-5-ilina@codeaurora.org> <20181229000714.GA3654@bogus> <20190107185113.GH14960@codeaurora.org> <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com> <20190109173111.GB22547@codeaurora.org> <CAL_JsqL1z-iOewqBeE43n1cVSGiQyOPHBGbRmEm9zcVLJkoLEA@mail.gmail.com> <154724884881.169631.9705938789464714812@swboyd.mtv.corp.google.com> <154827672955.136743.8509585166504871320@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
To:     Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh@kernel.org>
In-Reply-To: <154827672955.136743.8509585166504871320@swboyd.mtv.corp.google.com>
Date:   Thu, 31 Jan 2019 13:53:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-01-23 12:52:09)
> Quoting Stephen Boyd (2019-01-11 15:20:48)
> > Quoting Rob Herring (2019-01-09 11:36:56)
> > >=20
> > > > >However, my main concern is documenting something genericish in a
> > > > >device specific binding. It looks like Tegra is trying to add the =
same
> > > > >thing, so this needs to be documented in a common place. One quest=
ion
> > > > >is whether wakeup is the only use or if this should be more genera=
lly
> > > > >a secondary interrupt parent?
> > > > >
> > > > Yes, wakeup is the only use of this interrupt parent.
> > >=20
> > > Maybe for you, but I was wondering about this more generally. Should
> > > we encode what the function (e.g. wakeup) is in the property name or
> > > have something like aux-interrupt-controller? Maybe some platforms
> > > have some need for a secondary interrupt-controller which is not
> > > wakeup. Routing interrupts to other cores perhaps?
> > >=20
> >=20
> > I'd say it's not the interrupt-parent, but a secondary-interrupt-parent,
> > because it's another path that some GPIO interrupts will go through vs.
> > the "normal" summary irq line that uses the interrupt-parent. Maybe
> > that's similar to the interrupt partitioning that ARM is doing for PPIs
> > that only go to some CPUs?
> >=20
> > We don't really specify that some GPIO is corresponding to the secondary
> > or primary interrupt controller for the GPIO controller in DT. If we
> > did, then we could do something like the interrupt-map binding and have
> > the index of that property be the gpio number and the interrupt parent
> > that it maps to (either summary from the GIC or MPM pin number).
> >=20
> >  interrupt-map =3D <0 0 &gic GIC_SPI 208 0>,
> >                  <1 0 &pdc 3 0>;
> >  interrupt-map-mask =3D <0xfffffff 0>;
> >=20
> > And then we would pass the 2-cell GPIO interrupt specifier (gpio# and
> > flags) through the table and remap it to arbitrary domain parents. We
> > could use this same design for the SSBI and SPMI gpio interrupt
> > controller where we're currently looking at hardcoding the base
> > interrupt number in the driver (0xc0) and then adding the GPIO number to
> > that to get the parent interrupt specifier.
> >=20
> > It's sort of an abuse of interrupt-map, but I don't know if it really
> > matters because there isn't a child of the gpio controller that is going
> > to go through this table.
> >=20
>=20
> Rob, can you please respond?
>=20

Thinking more about this it doesn't seem too beneficial to use the
interrupt-map binding to figure out the parent domain. When we create
the irqdomain in the gpio controller, we have to specify the parent
domain at the same time, and there can only be one parent of an
irqdomain. Furthermore, we can have many irqdomains per device node, and
the DT binding doesn't indicate which irqdomain we want to parent to,
just the device node for the parent.

The nice part about using a DT binding to map the incoming irq specifier
to the parent specifier is that we don't have to put that mapping
somewhere in the driver. Instead, we can look it up in DT. This is
especially helpful with these qcom devices where they seem to randomly
assign gpios to PDC pins, and change it every time they make a new SoC.
Having those data tables in the kernel is annoying to maintain, and
having the child to parent hwirq numbers in DT isn't too great either
when it's just a bunch of numbers:

	<0 208>, <1 3>, etc.

It makes more sense when we at least have the parent phandle and can
assume the incoming irq specifier is for the current node.

	<[#interrupt-cells] [phandle to parent to irq remap] [parents #interrupt-c=
ells]>

	<0 0 &pdc 208 0>, <1 0 &pdc 3 0>, etc.

But then, the parent phandle is always the same because a domain can't
have more than one parent.

In theory, we could also do simple trigger type inverting or collapsing
if we wanted to while translating the irq specifier to the parent.
Currently, drivers do that with some code to translate the specifier to
a hwirq and flags and then overwrite the incoming flags from the child
to be what the parent can accept.

So should we make some new binding like 'irqdomain-<foo>-map' that maps
the irq specifiers coming into the containing node's 'foo' irqdomain to
a parent's irq specifier, instead of writing that in each irqchip
driver? Or is this too verbose because each irq needs to be specified in
the mapping table?

I'm prototyping out some code to do the remapping based on this type of
DT property, because it will make the irqdomain::alloc function a little
simpler to implement by passing in a struct irq_fwspec and getting out a
parent irq_fwspec and it will make the patches to add these mapping
tables in C irrelevant. Plus, I think Lina will be happy that the
pinctrl driver will know if some pin maps to the PDC or not without
having to see if it fails to allocate in the parent irqdomain. But there
will still need to be a property for 'wakeup-parent' unless we do
something to expose irqdomain tokens into DT.

