Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371FFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BC62173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BC62173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeHCKrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:47:13 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36895 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeHCKrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:47:13 -0400
X-Originating-IP: 82.50.90.136
Received: from w540 (host136-90-dynamic.50-82-r.retail.telecomitalia.it [82.50.90.136])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 69CDE40008;
        Fri,  3 Aug 2018 08:51:44 +0000 (UTC)
Date:   Fri, 3 Aug 2018 10:51:43 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
Message-ID: <20180803085143.GC4528@w540>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803072308.14962-3-peda@axentia.se>
 <20180803081128.GA4528@w540>
 <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Aug 03, 2018 at 10:40:02AM +0200, Peter Rosin wrote:
> On 2018-08-03 10:11, jacopo mondi wrote:
> > Hi Peter!
> >
> > On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
> >> With bus-type/bus-width properties in the endpoint nodes, the video-
> >> interface of the connection can be specified for cases where the
> >> heuristic fails to select the correct output mode. This can happen
> >> e.g. if not all RGB pins are routed on the PCB; the driver has no
> >> way of knowing this, and needs to be told explicitly.
> >>
> >> This is critical for the devices that have the "conflicting output
> >> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> >> RGB bits move around depending on the selected output mode. For
> >> devices that do not have the "conflicting output formats" issue
> >> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> >>
> >> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> index 82f2acb3d374..9de434a8f523 100644
> >> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> @@ -15,6 +15,14 @@ Required children nodes:
> >>   to external devices using the OF graph reprensentation (see ../graph.txt).
> >>   At least one port node is required.
> >>
> >> +Optional properties in grandchild nodes:
> >> + Any endpoint grandchild node may specify a desired video interface
> >> + according to ../../media/video-interfaces.txt, specifically
> >> + - bus-type: must be <0>.
> >
> > Is there any value in specifying this, if it has a fixed value to
> > "autodetect"? I understand it's optional, so if nobody else objects,
> > feels free to keep it there.
>
> That's just how media/video-interfaces.txt works.
>
> bus-type 0 means that other properties describe the bus type. In this
> case bus-width is specified, so that means a parallel bus. But bus-width
> has no meaning (or may not have) if bus-type is non-zero. But checking
> that bus-type for zero in the code seemed like overkill to me since the
> driver already knows that it is a parallel bus...
>

Yeah, I felt like pointing that out since you're not cheking for its value,
and that property is only used by v4l2-fwnode to handle some
not-that-used-anymore bus as CCP2 is.

> TL;DR I'd like to keep it.
>

Fine with me then.

> >
> >> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> >> +   override any output mode selection heuristic, forcing "rgb444",
> >> +   "rgb565", "rgb666" and "rgb888" respectively.
> >> +
> >>  Example:
> >>
> >>  	hlcdc: hlcdc@f0030000 {
> >> @@ -50,3 +58,21 @@ Example:
> >>  			#pwm-cells = <3>;
> >>  		};
> >>  	};
> >> +
> >
> > Two blank lines here.
> >
> >> +
> >> +Example 2: With a video interface override to force rgb565; as above
> >> +but with these changes/additions:
> >> +
> >> +	&hlcdc {
> >> +		hlcdc-display-controller {
> >> +			pinctrl-names = "default";
> >> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> >> +
> >> +			port@0 {
> >
> > The node has a unit address specified, you're missing a reg = <0>
> > property (no big deal, it's an example, but the other one has it)
> >
> >> +				hlcdc_panel_output: endpoint@0 {
> >
> > Missing reg here too.
>
> I'll fix those (I think they appeared for the original example after I
> wrote the patch).
>

Ok, then please consider also describing the port@0 node cell sizes too
since it has a child endpoint node.

Cheers
  j

> Cheers,
> Peter
>
> > Minors apart:
> >
> > Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > Thanks
> >    j
> >
> >> +					bus-type = <0>;
> >> +					bus-width = <16>;
> >> +				};
> >> +			};
> >> +		};
> >> +	};
> >> --
> >> 2.11.0
> >>
>

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbZBefAAoJEHI0Bo8WoVY8YEAQAK4/Xl3bZx+rmnDsc8c5zudH
dsY4OmeO985t/cxZH1P6brYKThwYqMZ70/Xr7GYmhn2v0N6GcjXwOh6k4+rmLMrn
lT8OXuaO6DbqTmdQAosnZcdbie9YdpDwnc2xRGZw1jZth+OMw3D7Ue5BiAcGX7lV
XNQ8DFufd5rrfWzHVNV5mTbfPx3WA/H8J68B5BFNW+rCzcxSw8Ez2eiPwkc/XOL/
rn7k/jKvzbwDqahyVO7UfQkUrqxM5Uaa/SRMT2Cl4NSiUM6QIVRMJ3nfBwSo6JMw
9nL7EUhLS1AXeGRaiiMssb7I6+SvRISVjwTJhF+D/6CIBTPDIdDrNaxGEY4oYOT/
BRYNhynIks6LDV6UR+SiQ5VjYSbZvvDIvJoUr7es4gEMwDGn5aHUdACGnfFuVEEm
urh0IVGpoPtOi3IOCk9C17hCuzuXoBd1n+yN2q07uqx5DTYNnvJMoZKULHDhLC4U
vzNDiqbWbackuY5LBFEu3wuCtXuagtQkhGF6Kn24d+419c/5K+fbEDD7Qq/z67ma
43SUy2w6XvqRM5sMjs+E7rFQK60W92XuHIv4DP7s+meuJe14Km6BHnSZNi6QsOMn
7oIGhSujoBY8vYrV+MoKhrg2UccH2DMxTl6RCa5xoeMkGb5GrB4YMlpe4boRM3af
f68v4sPv0G9bTYxiXr8R
=wH5T
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
