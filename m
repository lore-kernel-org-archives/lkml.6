Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeCIJ3z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:29:55 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60071 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCIJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:29:53 -0500
Date: Fri, 9 Mar 2018 10:29:45 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: Document THC63LVD1024
 LVDS decoder
Message-ID: <20180309092945.GE14819@w540>
References: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
 <1520522643-11756-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVQqp7YcoQ6eN5pSznZB4zn7ztv1WFfkcQOzP_3DhG_Vg@mail.gmail.com>
 <20180309090422.GD14819@w540>
 <CAMuHMdUaOjJekCK5b1n3vYAt-ZkRvTcu=G9eADhC4+0AD7UD6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUaOjJekCK5b1n3vYAt-ZkRvTcu=G9eADhC4+0AD7UD6Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Mar 09, 2018 at 10:22:39AM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Fri, Mar 9, 2018 at 10:04 AM, jacopo mondi <jacopo@jmondi.org> wrote:
> > On Fri, Mar 09, 2018 at 09:10:55AM +0100, Geert Uytterhoeven wrote:
> >> On Thu, Mar 8, 2018 at 4:24 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> >> > Document Thine THC63LVD1024 LVDS decoder.
> >> >
> >> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>
> >> Thanks for your patch!
> >>
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> >> > @@ -0,0 +1,59 @@
> >> > +THine Electronics THC63LVD1024 LVDS receiver
> >>
> >> Thine
> >>
> >> > +--------------------------------------------
> >> > +
> >> > +The THC63LVD1024 is an LVDS receiver designed to convert multiple LVDS streams
> >> > +to digital CMOS/TTL parallel data.
> >> > +
> >> > +Required properties:
> >> > +- compatible: Shall be one of the following:
> >> > +  "thine,thc63lvd1024",
> >> > +  "lvds-decoder"
> >>
> >> What's the purpose of the second compatible value?
> >> When should it be used?
> >
> > It is probably my bad having started with a generic LVDS decoder in
> > mind and having then added properties specific to THC63LVD1024 to the
> > driver and its bindings.
> >
> > "lvds,decoder" can be used when the chip is completely transparent to
> > the SoC and none of the optional properties I have described in the
> > bindings are specified (a generic "power-gpios" apart, see Andrzej
> > comments on "pwdn-gpios" property).
> >
> > Also, I should make the driver behavior depend on the matched compatible
> > string. When "lvds-decoder" is matched, it will just look for an
> > optional power down gpio, when "thc63lvd1024" is matched, all of its
> > Vcc supplies, pwdn gpio and oe gpios will be queried and, if present,
> > eventually used in enable/disable routines.
> >
> > I'm just not sure how to describe that in bindings. Would something
> > like the following work?
> >
> > Optional properties for "lvds,decoder"
>
> "lvds-decoder"?
>

Yes, sorry

> > - power-gpios: Power control GPIOs
> >
> > Optional properties for "thine,thc63lvd1024"
> > - pwdn-gpios: ...
> > - oe-gpios: ...
> > - supply-vcc: ...
> > - supply-cvcc: ...
> > - supply-pvcc: ...
> > - supply-lvcc: ...
>
> Sounds like you need a (separate) generic lvds-decoder DT bindings document,
> which you can extend/refer to from the THC63LVD1024-specific bindings.

Ok, I'll go with two bindings document then and see how it looks.

Thanks
   j



>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
