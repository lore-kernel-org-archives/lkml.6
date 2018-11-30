Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E65C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED952146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcGabfnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED952146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeK3RwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeK3RwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:52:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624CA20863;
        Fri, 30 Nov 2018 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543560238;
        bh=1KbS/H6E5H0W1qh4RtVpQWod+3yOS5qydDBCJ/kE3fQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bcGabfnUaY7qhe71t8JtmyGOqInchiNtzvyFGGQ87JC6XIEOm7Ll9N2KALe382057
         vfB+KM2zou0sWmD+Wu0NaoZBeueD0J9hL+YEJyKoWPIJWZwk9iPrBfrCWjntSMX00/
         3XY35oXIolDpVSO+IwkIOJS+U2kTMDijrSxd0b88=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <458178ac-c0fc-9671-7fc8-ed2d6f61424c@suse.com>
Cc:     matthias.bgg@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
 <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
 <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
 <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
 <458178ac-c0fc-9671-7fc8-ed2d6f61424c@suse.com>
Message-ID: <154356023767.88331.18401188808548429052@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for mmsys
 clocks
Date:   Thu, 29 Nov 2018 22:43:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2018-11-21 09:09:52)
> =

> =

> On 21/11/2018 17:46, Stephen Boyd wrote:
> > Quoting Rob Herring (2018-11-19 11:15:16)
> >> On Sun, Nov 18, 2018 at 11:12 AM Matthias Brugger
> >> <matthias.bgg@gmail.com> wrote:
> >>> On 11/17/18 12:15 AM, Rob Herring wrote:
> >>>> On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg@kernel.org wr=
ote:
> >>>>> -    #clock-cells =3D <1>;
> >>>>> +
> >>>>> +    mmsys_clk: clock-controller@14000000 {
> >>>>> +            compatible =3D "mediatek,mt2712-mmsys-clk";
> >>>>> +            #clock-cells =3D <1>;
> >>>>
> >>>> This goes against the general direction of not defining separate nod=
es
> >>>> for providers with no resources.
> >>>>
> >>>> Why do you need this and what does it buy if you have to continue to
> >>>> support the existing chips?
> >>>>
> >>>
> >>> It would show explicitly that the mmsys block is used to probe two
> >>> drivers, one for the gpu and one for the clocks. Otherwise that is
> >>> hidden in the drm driver code. I think it is cleaner to describe that=
 in
> >>> the device tree.
> >>
> >> No, that's maybe cleaner for the driver implementation in the Linux
> >> kernel. What about other OS's or when Linux drivers and subsystems
> >> needs change? Cleaner for DT is design bindings that reflect the h/w.
> >> Hardware is sometimes just messy.
> >>
> > =

> > I agree. I fail to see what this patch series is doing besides changing
> > driver probe and device creation methods and making a backwards
> > incompatible change to DT. Is there any other benefit here?
> > =

> =

> You are referring whole series?
> Citing the cover letter:
> "MMSYS in Mediatek SoCs has some registers to control clock gates (which =
is
> used in the clk driver) and some registers to set the routing and enable
> the differnet (sic!) blocks of the display subsystem.
> =

> Up to now both drivers, clock and drm are probed with the same device tree
> compatible. But only the first driver get probed, which in effect breaks
> graphics on mt8173 and mt2701.

Ouch!

> =

> This patch uses a platform device registration in the DRM driver, which
> will trigger the probe of the corresponding clock driver. It was tested o=
n the
> bananapi-r2 and the Acer R13 Chromebook."

Alright, please don't add nodes in DT just to make device drivers probe.
Instead, register clks from the drm driver or create a child platform
device for the clk bits purely in the drm driver and have that probe the
associated clk driver from there.

> =

> DT is broken right now, because two drivers rely on the same node, which =
gets
> consumed just once. The new DT introduced does not break anything because=
 it is
> only used for boards that: "[..] are not available to the general public
> (mt2712e) or only have the mmsys clock driver part implemented (mt6797)."

Ok, so backwards compatibility is irrelevant then. Sounds fine to me.

