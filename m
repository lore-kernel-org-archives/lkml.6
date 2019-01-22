Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69456C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330C621726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q9WOOGSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAVUxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:53:49 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55386 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAVUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:53:49 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93780575;
        Tue, 22 Jan 2019 21:53:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548190426;
        bh=QGo0DUwfA7Z7zXNfbOwkABnYildWi/mItLvCeCe0cno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9WOOGSeNjlxOuYfwtkGyQ4eKz7hOohudvxuo/7LU94kiu8wu1tblvzqLS/y9q+aX
         3HNQOF8OYyNGrV01H6OXZM5ER7jHSSD4817gDgF0VnINagMJfoy70enXF0SzmsmRnX
         pL52gM8nyWZ7LOQtnUlcIeipo8FKecpis03sWwcU=
Date:   Tue, 22 Jan 2019 22:53:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: display: bridge: fork out
 ti,ds90c185 from lvds-transmitter
Message-ID: <20190122205345.GF3264@pendragon.ideasonboard.com>
References: <20181229070649.21308-1-peda@axentia.se>
 <20181229070649.21308-2-peda@axentia.se>
 <20190111144904.GA5052@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111144904.GA5052@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 11, 2019 at 08:49:04AM -0600, Rob Herring wrote:
> On Sat, Dec 29, 2018 at 07:07:19AM +0000, Peter Rosin wrote:
> > DS90C185 has a shutdown pin which does not fit in the lvds-transmitter
> > binding, which is meant to be generic.
> > 
> > The sister chip DS90C187 is similar to DS90C185, describe it here as well.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  .../bindings/display/bridge/lvds-transmitter.txt   |  8 +---
> >  .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++++++
> >  2 files changed, 56 insertions(+), 7 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> > index 50220190c203..fd39ad34c383 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> > +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> > @@ -22,13 +22,7 @@ among others.
> >  
> >  Required properties:
> >  
> > -- compatible: Must be one or more of the following
> > -  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
> > -  - "lvds-encoder" for a generic LVDS encoder device
> > -
> > -  When compatible with the generic version, nodes must list the
> > -  device-specific version corresponding to the device first
> > -  followed by the generic version.
> 
> I think you should keep something here. I'd reword it to say any encoder 
> with additional properties must have a device specific compatible in 
> addition.

I was going to mention this too. Maybe

- compatible: Shall contain a device-specific compatible string follow
  by "lvds-encoder".

That's stronger than Rob's suggestion, as I don't think we should allow
omitting the device-specific compatible string in any case to make sure
we can preserve backward compatibility in the future.

> > +- compatible: Must be "lvds-encoder"
> >  
> >  Required nodes:
> >  
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> > new file mode 100644
> > index 000000000000..e575f996959a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> > @@ -0,0 +1,55 @@
> > +Texas Instruments FPD-Link (LVDS) Serializer
> > +--------------------------------------------
> > +
> > +The DS90C185 and DS90C187 are low-power serializers for portable
> > +battery-powered applications that reduces the size of the RGB
> > +interface between the host GPU and the display.
> > +
> > +Required properties:
> > +
> > +- compatible: Should be
> > +  "ti,ds90c185", "lvds-encoder"  for the TI DS90C185 FPD-Link Serializer
> > +  "ti,ds90c187", "lvds-encoder"  for the TI DS90C187 FPD-Link Serializer

s/  for/ for/

With these fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > +
> > +Optional properties:
> > +
> > +- powerdown-gpios: Power down control GPIO (the PDB pin, active-low)
> > +
> > +Required nodes:
> > +
> > +The devices have two video ports. Their connections are modeled using the OF
> > +graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> > +
> > +- Video port 0 for parallel input
> > +- Video port 1 for LVDS output
> > +
> > +
> > +Example
> > +-------
> > +
> > +lvds-encoder {
> > +	compatible = "ti,ds90c185", "lvds-encoder";
> > +
> > +	powerdown-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
> > +
> > +	ports {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		port@0 {
> > +			reg = <0>;
> > +
> > +			lvds_enc_in: endpoint {
> > +				remote-endpoint = <&lcdc_out_rgb>;
> > +			};
> > +		};
> > +
> > +		port@1 {
> > +			reg = <1>;
> > +
> > +			lvds_enc_out: endpoint {
> > +				remote-endpoint = <&lvds_panel_in>;
> > +			};
> > +		};
> > +	};
> > +};

-- 
Regards,

Laurent Pinchart
