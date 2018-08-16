Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6505C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE421470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFE421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeHPWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:47:31 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49835 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeHPWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:47:31 -0400
Received: from w540 (unknown [2.43.46.19])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 28A70240006;
        Thu, 16 Aug 2018 19:47:00 +0000 (UTC)
Date:   Thu, 16 Aug 2018 21:46:51 +0200
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
Message-ID: <20180816194651.GA30122@w540>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803072308.14962-3-peda@axentia.se>
 <20180803081128.GA4528@w540>
 <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
 <20180803085143.GC4528@w540>
 <061a99d5-4fe6-795c-7e91-cf7127fb8472@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <061a99d5-4fe6-795c-7e91-cf7127fb8472@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter,

On Thu, Aug 16, 2018 at 02:52:41PM +0200, Peter Rosin wrote:
> On 2018-08-03 10:51, jacopo mondi wrote:
> > On Fri, Aug 03, 2018 at 10:40:02AM +0200, Peter Rosin wrote:
> >> On 2018-08-03 10:11, jacopo mondi wrote:
> >>> Hi Peter!
> >>>
> >>> On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
> >>>> With bus-type/bus-width properties in the endpoint nodes, the video-
> >>>> interface of the connection can be specified for cases where the
> >>>> heuristic fails to select the correct output mode. This can happen
> >>>> e.g. if not all RGB pins are routed on the PCB; the driver has no
> >>>> way of knowing this, and needs to be told explicitly.
> >>>>
> >>>> This is critical for the devices that have the "conflicting output
> >>>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> >>>> RGB bits move around depending on the selected output mode. For
> >>>> devices that do not have the "conflicting output formats" issue
> >>>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> >>>>
> >>>> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >>>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>> ---
> >>>>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
> >>>>  1 file changed, 26 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >>>> index 82f2acb3d374..9de434a8f523 100644
> >>>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >>>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >>>> @@ -15,6 +15,14 @@ Required children nodes:
> >>>>   to external devices using the OF graph reprensentation (see ../graph.txt).
> >>>>   At least one port node is required.
> >>>>
> >>>> +Optional properties in grandchild nodes:
> >>>> + Any endpoint grandchild node may specify a desired video interface
> >>>> + according to ../../media/video-interfaces.txt, specifically
> >>>> + - bus-type: must be <0>.
> >>>
> >>> Is there any value in specifying this, if it has a fixed value to
> >>> "autodetect"? I understand it's optional, so if nobody else objects,
> >>> feels free to keep it there.
> >>
> >> That's just how media/video-interfaces.txt works.
> >>
> >> bus-type 0 means that other properties describe the bus type. In this
> >> case bus-width is specified, so that means a parallel bus. But bus-width
> >> has no meaning (or may not have) if bus-type is non-zero. But checking
> >> that bus-type for zero in the code seemed like overkill to me since the
> >> driver already knows that it is a parallel bus...
> >>
> >
> > Yeah, I felt like pointing that out since you're not cheking for its value,
> > and that property is only used by v4l2-fwnode to handle some
> > not-that-used-anymore bus as CCP2 is.
> >
> >> TL;DR I'd like to keep it.
> >>
> >
> > Fine with me then.
> >
> >>>
> >>>> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> >>>> +   override any output mode selection heuristic, forcing "rgb444",
> >>>> +   "rgb565", "rgb666" and "rgb888" respectively.
> >>>> +
> >>>>  Example:
> >>>>
> >>>>  	hlcdc: hlcdc@f0030000 {
> >>>> @@ -50,3 +58,21 @@ Example:
> >>>>  			#pwm-cells = <3>;
> >>>>  		};
> >>>>  	};
> >>>> +
> >>>
> >>> Two blank lines here.
> >>>
> >>>> +
> >>>> +Example 2: With a video interface override to force rgb565; as above
> >>>> +but with these changes/additions:
> >>>> +
> >>>> +	&hlcdc {
> >>>> +		hlcdc-display-controller {
> >>>> +			pinctrl-names = "default";
> >>>> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> >>>> +
> >>>> +			port@0 {
> >>>
> >>> The node has a unit address specified, you're missing a reg = <0>
> >>> property (no big deal, it's an example, but the other one has it)
> >>>
> >>>> +				hlcdc_panel_output: endpoint@0 {
> >>>
> >>> Missing reg here too.
> >>
> >> I'll fix those (I think they appeared for the original example after I
> >> wrote the patch).
> >>
> >
> > Ok, then please consider also describing the port@0 node cell sizes too
> > since it has a child endpoint node.
>
> Ok, I have now figured out why this was as it were, and I no longer agree
> with adding the extra properties. The whole of example 2 is inside a
> reference (using the &hlcdc notation) to the hlcdc node in example 1, and
> therefore these "missing" properties are not missing. I think they are
> just clutter that hides what is really needed/different between example 1
> and 2, and apparently Boris and Rob agreed when they acked/reviewed. The
> description of example 2 also clearly states that example 2 is changes
> and additions on top of example 1. So, I plan to have this in the next
> iteration:
>
> 	&hlcdc {
> 		hlcdc-display-controller {
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
>
> 			port@0 {
> 				hlcdc_panel_output: endpoint@0 {
> 					bus-width = <16>;

Right, I thought that even when re-defining a node, reg properties
should be there, but yes, I had no reasons to think so :)

> 				};
> 			};
> 		};
> 	};
>
> Jacopo, please let me know if you want me to keep your review tag anyway...
>

Sure

>
> >> Cheers,
> >> Peter
> >>
> >>> Minors apart:
>
> ...because I interpret this to mean that I could add your tag if I made the
> changes you suggested. Or did it mean that I could add your tag regardless
> because the issues were minor?
>v

Sorry, I was not clear. That was a minor nit, you could have add my
tag anyhow.

Thanks
   j

> Cheers,
> Peter
>
> >>>
> >>> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>>
>  >>> Thanks
> >>>    j
> >>>
> >>>> +					bus-type = <0>;
> >>>> +					bus-width = <16>;
> >>>> +				};
> >>>> +			};
> >>>> +		};
> >>>> +	};
> >>>> --
> >>>> 2.11.0
> >>>>
> >>
>

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbddSlAAoJEHI0Bo8WoVY8+tMP/iDKNi5Ir9G8oN36J8pkC/xC
wTC5GDuqwSNeL4SYh8gfIwn2rV4uJwPOCUZzHGXXnbVbNj7DDvQrd9QyHUVkLxJE
NaSCkvWCOB5I5gYXH5yDPShs5KE3FH6ZIhpHCw+O0P9Evg40SA/AByaEIkfk99Ql
fhwB6npxsYbvcxi0SO1hkJR3afu4dpTUpt5p4ixBHpzKA/XJUvJCMC+ScRNzNUEk
haII2XPdvSmLMGHjPZF/iESWdMjZ+S1oJ73+MV5XFupwlWaDifwDgn4autva+aJ/
SZvKWGkDclXC8eWfwal11RITQkAp+M0rOaAuQePjpsbDEkDpGqjIPnclaToOyXdY
RzpP7Cbms1VxIS36ycctnLGC48OTyizXHL/nd/ZdbufEyiIyprJG4P5TrPnvWNrB
7EIp2QlYpzMy5JSfV3bu7RQ27eiFrTTwIdSmjouaNMmBvzpVitRT8z89EoJsFmON
xDS3q7BxvIN0p04usICCAJ2aBP3KVo3BW4N7rsEOOYL7wAg/vNsVL/9VkyXmE5ub
dJZTrFftuB0tL/jixxnbIq6ris/kbK6pfahUfNvI/uOzpNQGcTgckK1m2R8mmEIB
h4szakP+uQNkrMWzJNe86BKIVmkS9D2WJM51lG7Uok9XvaFxRBRQm5G2YDNk9uU6
9pmp1DfuMlgTVzY6TVfy
=XDwT
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
