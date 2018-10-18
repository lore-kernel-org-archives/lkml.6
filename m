Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B09EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAB020838
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAB020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJRSA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:00:29 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52906 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbeJRSA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:00:28 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 4D3EA15D289;
        Thu, 18 Oct 2018 10:00:09 +0000 (UTC)
Message-ID: <c68f0da9607805e1f6673a9a16a7dcfff4d8fe91.camel@aosc.io>
Subject: Re: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 18 Oct 2018 18:00:05 +0800
In-Reply-To: <1886367.eljNk7jKYl@avalon>
References: <20181018073327.64942-1-icenowy@aosc.io>
         <20181018073327.64942-5-icenowy@aosc.io> <1886367.eljNk7jKYl@avalon>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-10-18四的 11:53 +0300，Laurent Pinchart写道：
> Hi Icenowy,
> 
> Thank you for the patch.
> 
> On Thursday, 18 October 2018 10:33:22 EEST Icenowy Zheng wrote:
> > The ANX6345 is an ultra-low power DisplayPort/eDP transmitter
> > designed
> > for portable devices.
> > 
> > Add a binding document for it.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  .../bindings/display/bridge/anx6345.txt       | 39
> > +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > b/Documentation/devicetree/bindings/display/bridge/anx6345.txt new
> > file
> > mode 100644
> > index 000000000000..0689d4eb5f65
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > @@ -0,0 +1,39 @@
> > +Analogix ANX6345 eDP Transmitter
> > +--------------------------------
> > +
> > +The ANX6345 is an ultra-low power Full-HD eDP transmitter designed
> > for
> > +portable devices.
> > +
> > +Required properties:
> > +
> > + - compatible		: "analogix,anx6345"
> > + - reg			: I2C address of the device
> > + - reset-gpios		: Which GPIO to use for reset
> > +
> > +Optional properties:
> > +
> > + - dvdd12-supply	: Regulator for 1.2V digital core power.
> > + - dvdd25-supply	: Regulator for 2.5V digital core power.
> 
> Shouldn't these to supplies be mandatory ?

Yes they should.

> 
> > + - panel-supply		: Regulator for the power of the panel.
> 
> Shouldn't the panel supply for specified in the DT node of the panel
> ?

However, eDP panel can be probed, may vary on the same device, and we
don't have a generic binding for it...

> 
> > + - edid			: verbatim EDID data block describing
> > attached
> > +			  panel, only used when the panel has no EDID
> > info.
> 
> This should also be specified in the panel DT node.
> 
> > + - Video port for RGB input, using the DT bindings defined in [1].
> 
> I think you should also add a port for the output.

What will it point to?

> 
> > +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> > +
> > +Example:
> > +
> > +anx6345: anx6345@38 {
> > +	compatible = "analogix,anx6345";
> > +	reg = <0x38>;
> > +	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> > +	panel-supply = <&reg_dc1sw>;
> > +	dvdd25-supply = <&reg_dldo2>;
> > +	dvdd12-supply = <&reg_fldo1>;
> > +
> > +	port {
> > +		anx6345_in: endpoint {
> > +			remote-endpoint = <&tcon0_out_anx6345>;
> > +		};
> > +	};
> > +};
> 
> 

