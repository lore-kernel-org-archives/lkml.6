Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AC8C004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007C620674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="TFWZiRg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeJWIZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:25:26 -0400
Received: from onstation.org ([52.200.56.107]:39250 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeJWIZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:25:26 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6B3C2354;
        Tue, 23 Oct 2018 00:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1540253079;
        bh=HE0X7iadmLS2WTNw9rk/I/B0HyBHTA7gcoP+liuWy9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFWZiRg6Np6ABovjZK+fHPhEZ5VXSPscP7oXakftBX0mDTrtliORhqpQD+38QFcWH
         c0IAUGcH2UG54dN5WRd2OTogDPZsplPhW/hFinukAykZXGF5r010SJK2+tyDNBle4Z
         87Naws426FERHt47nRvBopFqejHT/RDKzgMDRXyA=
Date:   Mon, 22 Oct 2018 20:04:39 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     andy.gross@linaro.org, sre@kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH RFC 1/5] dt-bindings: power: supply: bq24190_charger: add
 bq24192 and usb-otg-vbus
Message-ID: <20181023000439.neadgrmsyg2t6da4@38e519447dc0>
References: <20181001053005.18906-1-masneyb@onstation.org>
 <20181001053005.18906-2-masneyb@onstation.org>
 <20181015185252.GA8056@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015185252.GA8056@bogus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Oct 15, 2018 at 01:52:52PM -0500, Rob Herring wrote:
> On Mon, Oct 01, 2018 at 01:30:01AM -0400, Brian Masney wrote:
> > Add support for the ti,bq24192 variant and a child node for the
> > usb-otg-vbus regulator.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> >  Documentation/devicetree/bindings/power/supply/bq24190.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> > index 9e517d307070..8f2560824a97 100644
> > --- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
> > +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> > @@ -3,6 +3,7 @@ TI BQ24190 Li-Ion Battery Charger
> >  Required properties:
> >  - compatible: contains one of the following:
> >      * "ti,bq24190"
> > +    * "ti,bq24192"
> >      * "ti,bq24192i"
> >  - reg: integer, I2C address of the charger.
> >  - interrupts[-extended]: configuration for charger INT pin.
> > @@ -19,6 +20,12 @@ Optional properties:
> >  - ti,system-minimum-microvolt: when power is connected and the battery is below
> >    minimum system voltage, the system will be regulated above this setting.
> >  
> > +child nodes:
> > +- usb-otg-vbus:
> > +  Usage: optional
> > +  Description: Regulator that is used to control the VBUS voltage direction for
> > +               either USB host mode or for charging on the OTG port.
> 
> What about the regulator properties?

There are no regulator properties underneath this child node. This is a
similar setup to what is described in
Documentation/devicetree/bindings/power/supply/qcom_smbb.txt.

If this is the correct way to do this, then perhaps I can add the
usb_otg_vbus node to the example in v2.

Brian

> > +
> >  Notes:
> >  - Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
> >    charge current on USB SDP ports, among other features). To simulate this on
> > -- 
> > 2.17.1
> > 
