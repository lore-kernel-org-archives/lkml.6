Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeBHFvL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 00:51:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8390 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750766AbeBHFvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 00:51:09 -0500
X-UUID: 42840e3e02314102b5d2d9e438c74c6d-20180208
Message-ID: <1518069065.24094.48.camel@mtkswgap22>
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
From: Ryder Lee <ryder.lee@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Date: Thu, 8 Feb 2018 13:51:05 +0800
In-Reply-To: <CAL_Jsq+kM19=+cMzfgvE3j01L9ahbf6PNh2eJJOkwd096RcFhg@mail.gmail.com>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
         <8651585c91ee40f6ab3e30b893bcfb90fe5c2c25.1515639336.git.ryder.lee@mediatek.com>
         <20180205060833.p56dun5i4bvs3jye@rob-hp-laptop>
         <1517821892.12510.32.camel@mtkswgap22>
         <CAL_Jsq+kM19=+cMzfgvE3j01L9ahbf6PNh2eJJOkwd096RcFhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 18:49 -0600, Rob Herring wrote:
> >> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> >> > index 9b8f578..677af40 100644
> >> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> >> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> >> > @@ -1,22 +1,45 @@
> >> > -MediaTek AUDSYS controller
> >> > +MediaTek Audio Subsystem
> >> >  ============================
> >> > +The audio subsystem is one of the multi-function blocks of MediaTek SoCs.
> >> > +It contains a system controller, which provides a number registers giving
> >> > +access to two features: AUDSYS clocks and Audio Front End (AFE) components.
> >> >
> >> > +For the top level node:
> >> > +- compatible: must be: "syscon", "simple-mfd";
> >>
> >> This should have some SoC specific compatible.
> >
> > As we don't have a specific driver (compatible string) for it and if we
> > need to add that I think the term '*-audsys' is very suitable here, but
> > unfortunately, it has already picked for clock driver (see child node).
> 
> Perhaps the clocks block should have "-clk" on the end or something.
> 
> Why do you really need to change this in the first place? You don't
> have to have DT child nodes to create child (struct) devices and child
> drivers.
> 

I'm not sure I get your point. Did you mean that we could have a parent
(which represents clock and its compatible is something like
"*-audsys","syscon","simple-mfd") with a subnode for audio function?

If so, there's no special reason. I just think it more specifically to
let people know we have an MFD (top node) and it has two sub-functions
(children) share the same region.

> >> > +Required sub-nodes:
> >> > +
> >> > +AUDSYS clocks:
> >> > +-------
> >> >  The MediaTek AUDSYS controller provides various clocks to the system.
> >> >
> >> >  Required Properties:
> >> >
> >> >  - compatible: Should be one of:
> >> > -   - "mediatek,mt7622-audsys", "syscon"
> >> > +   - "mediatek,mt2701-audsys";
> >> > +   - "mediatek,mt7622-audsys";
> >> >  - #clock-cells: Must be 1
> >> >
> >> >  The AUDSYS controller uses the common clk binding from
> >> >  Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> >  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> >>
> >> There's no register range associated with the clocks? If there is, add a
> >> reg property.
> >
> > No, we don't need reg property here, as the two sub-drivers will obtain
> > the regmap  which is propagated from the parent.
> 
> I know regmap doesn't need it. That's not what I asked. If you have a
> range of registers for the clocks, then define that in reg. Only if
> the clock control bits are mixed up with other functions within the
> same registers, then you can omit it.
> 

Oh okay, I didn't read the mail well.  We have four or five registers
for the clocks, but one of them (offset:0x634) is mixed up with the
audio function (bit 17-19), so I omit it.

Ryder.
