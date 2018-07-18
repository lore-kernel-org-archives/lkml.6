Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5572064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5572064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeGRPhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:37:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55565 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbeGRPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:37:23 -0400
Received: from wicke.hi.pengutronix.de ([2001:67c:670:100:2e4d:54ff:fe9d:8eb7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1ffnut-00067J-SU; Wed, 18 Jul 2018 16:58:59 +0200
Received: from mfe by wicke.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1ffnut-0005Qi-0S; Wed, 18 Jul 2018 16:58:59 +0200
Date:   Wed, 18 Jul 2018 16:58:58 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pfuze100: add optional disable
 switch-regulators binding
Message-ID: <20180718145858.7xsyweyohiazrkl2@pengutronix.de>
References: <20180713125002.24331-1-m.felsch@pengutronix.de>
 <20180713125002.24331-2-m.felsch@pengutronix.de>
 <20180716175535.GA10835@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716175535.GA10835@rob-hp-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:2e4d:54ff:fe9d:8eb7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

thanks for the review. I will integrate it in a v3.

Regards,
Marco

On 18-07-16 11:55, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 02:50:01PM +0200, Marco Felsch wrote:
> > This binding is used to keep the backward compatibility with the current
> > dtb's [1]. The binding informs the driver that the unused switch regulators
> > can be disabled.
> > If it is not specified, the driver doesn't disable the switch regulators.
> > 
> > [1] https://patchwork.kernel.org/patch/10490381/
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > 
> > ---
> > Changes in V2:
> >   - add more information about the binding
> >   - rename binding and add vendor prefix
> > 
> >  .../devicetree/bindings/regulator/pfuze100.txt        | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
> > index 672c939045ff..2c46b8d368db 100644
> > --- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
> > +++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
> > @@ -4,6 +4,17 @@ Required properties:
> >  - compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000", "fsl,pfuze3001"
> >  - reg: I2C slave address
> >  
> > +Optional properties:
> > +- fsl,pfuze-support-disable: Boolean, if present disable all unused switch
> > +  regulators to save power consumption. Attention, till 4.18 these regulators
> 
> You shouldn't have kernel version info in bindings.
> 
> > +  were always on without specifying "regulator-always-on". So be sure to mark
> > +  import regulators as "regulator-always-on" (e.g. DDR ref, DDR supply). If
> 
> s/import/important/
> 
> > +  not present, the switched regualtors are always on and can't be disabled.
> > +  This binding is a workaround to keep backward compatibility with old dtb's
> > +  which rely on the fact that the switched regulators are always on and don't
> > +  mark them explicit as "regulator-always-on". On new dtbs this property should
> > +  always be present.
> > +
> >  Required child node:
> >  - regulators: This is the list of child nodes that specify the regulator
> >    initialization data for defined regulators. Please refer to below doc
> > -- 
> > 2.18.0
> > 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5082 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
