Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52076C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EE521723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EE521723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeHCKG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:06:59 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39209 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:06:58 -0400
X-Originating-IP: 82.50.90.136
Received: from w540 (host136-90-dynamic.50-82-r.retail.telecomitalia.it [82.50.90.136])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CB5D1E001B;
        Fri,  3 Aug 2018 08:11:34 +0000 (UTC)
Date:   Fri, 3 Aug 2018 10:11:28 +0200
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
Message-ID: <20180803081128.GA4528@w540>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803072308.14962-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20180803072308.14962-3-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter!

On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
> With bus-type/bus-width properties in the endpoint nodes, the video-
> interface of the connection can be specified for cases where the
> heuristic fails to select the correct output mode. This can happen
> e.g. if not all RGB pins are routed on the PCB; the driver has no
> way of knowing this, and needs to be told explicitly.
>
> This is critical for the devices that have the "conflicting output
> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> RGB bits move around depending on the selected output mode. For
> devices that do not have the "conflicting output formats" issue
> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> index 82f2acb3d374..9de434a8f523 100644
> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> @@ -15,6 +15,14 @@ Required children nodes:
>   to external devices using the OF graph reprensentation (see ../graph.txt).
>   At least one port node is required.
>
> +Optional properties in grandchild nodes:
> + Any endpoint grandchild node may specify a desired video interface
> + according to ../../media/video-interfaces.txt, specifically
> + - bus-type: must be <0>.

Is there any value in specifying this, if it has a fixed value to
"autodetect"? I understand it's optional, so if nobody else objects,
feels free to keep it there.


> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> +   override any output mode selection heuristic, forcing "rgb444",
> +   "rgb565", "rgb666" and "rgb888" respectively.
> +
>  Example:
>
>  	hlcdc: hlcdc@f0030000 {
> @@ -50,3 +58,21 @@ Example:
>  			#pwm-cells = <3>;
>  		};
>  	};
> +

Two blank lines here.

> +
> +Example 2: With a video interface override to force rgb565; as above
> +but with these changes/additions:
> +
> +	&hlcdc {
> +		hlcdc-display-controller {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +
> +			port@0 {

The node has a unit address specified, you're missing a reg = <0>
property (no big deal, it's an example, but the other one has it)

> +				hlcdc_panel_output: endpoint@0 {

Missing reg here too.

Minors apart:

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
   j

> +					bus-type = <0>;
> +					bus-width = <16>;
> +				};
> +			};
> +		};
> +	};
> --
> 2.11.0
>

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbZA4vAAoJEHI0Bo8WoVY8aeMQAIm5HcyWTXTBWIjfHUulvw9T
F0eFetBBXbdC0VTjrB3i9w6uO282S5P9eJf3rB1BjTvFyu+OcJ5AEG7Hv2c54tpn
hScsmrXyLfpaMNVUHyGMwMwVztoJVkb28vT0+5QAxxH3odJtCqDeXgPnmVIX/gPN
chhZ/zP/hX328f/LeaO565aL7kJL1hyBgeLYO+p73PC3rFFxlOKLziqiDf69f+AI
dbcIG/xJZRQR54jReaXQPl2TcQxwjRxsEDAJaP45P1Kvg2N+mG3lMQCcTr8QHegk
vWh+BhTbhBfjo3EdumiaetL3jytjFrhlTJLSdHmJlihtGR1Z/kZwelxOaLy2gvCs
X5n5syeUD+b3+3P+f9ogKGmeaLRl962S8nmOrsAH+A1tLWXEjiLAcuWftPN/L8DQ
jUjsa60uw62DCJwl4PtIBqXgJO8avCjWOVw/msW/uOzyfG2qlAr6W2Z0tQsmjzpV
LsJb8Y7YgC/fntP5yGHNipnm7JN4iFdvUzDGaCHhROa8u07DJNAQifxgz1KJdHcW
PA1tKKHeZ5O8T+iyVxBGlIUvTLyRMW1LP2bYHz4S6CAdp5DE9463mtmtifz4n/ki
OxMOBgN9U8neyIAEv/1aMedBY9p/ufnZmNOtxgRZwWSAaaec8sfk6r/zNcnO9PcC
8CzYkWsy8xrmQ6DNeUWb
=4Hd+
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
