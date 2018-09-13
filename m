Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4067C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EE620881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EE620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeINBzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:55:31 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:59301 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeINBza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:55:30 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C624C2001F;
        Thu, 13 Sep 2018 22:44:13 +0200 (CEST)
Date:   Thu, 13 Sep 2018 22:44:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/5] dt-binding: rtci-pcf8523: add quartz_load property
Message-ID: <20180913204412.GA30987@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
 <20180913190516.GG14988@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913190516.GG14988@piout.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8
        a=7CQSdrXTAAAA:8 a=CQ2M3AanYSmxaPcD9a4A:9 a=wPNLvfGTeEIA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=d3PnA9EDa4IxuAV0gXij:22
        a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre.

On Thu, Sep 13, 2018 at 09:05:16PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> You can remove 'rtci-' from the subject.

The 'i' part was me fooling around in vi.
After submitting this serie I read the proper subject would be:
(from bindings/submitting-patches.txt)

dt-bindings: rtc: <short description>

I will use this in next submission so it is clear this is rtc related.

> 
> On 07/09/2018 21:35:04+0200, Sam Ravnborg wrote:
> > From: Søren Andersen <san@skov.dk>
> > 
> > The NXP pcf8523 supports two different quartz loads.
> > - 7 pF (default)
> > - 12.5 pF (minimum power consumption)
> > 
> > The pcf8523 needs to know the size of the quartz load,
> > otherwise the the RTC will have a bad precision.
> > 
> > The default for the rtc (after power-on) is 7 pF.
> > Add a property that tells if the external capacitor is 12.5 pF.
> > 
> > Signed-off-by: Søren Andersen <san@skov.dk>
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 19 +++++++++++++++++++
> >  Documentation/devicetree/bindings/trivial-devices.txt |  1 -
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > new file mode 100644
> > index 000000000000..7c5e93f5077c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > @@ -0,0 +1,19 @@
> > +* NXP PCF8523 Real Time Clock
> > +
> > +NXP PCF8523 Real Time Clock
> > +
> > +Required properties:
> > +- compatible: Should contain "nxp,pcf8523".
> > +- reg: I2C address for chip.
> > +
> > +Optional property:
> > +- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
> > +  which differ from the default value of 7 pF
> > +
> 
> The boolean properties usually don't work well for RTCs because people
> usually want to keep any previous configuration that may have been done
> at the factory or in the bootloader so I would use:
> 
> nxp,quartz_load_fF and this would be either 7000 or 12500.
We had is implmented like this (using pF) in the beginning but
then went for the simpler property.
Will add a fF property as you suggest and avoid breaking the existing drivers.
We will check a few of the boards to see if the current configuration
of the pcf8523 driver looks wrong, and if so we will print
the warnings as suggested.

I think the above covers feedback on all patches.
And thanks for the feedback!

	Sam
