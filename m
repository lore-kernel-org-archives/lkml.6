Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F45C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46A8217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBSHaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:30:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46893 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSHai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:30:38 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gvzrI-0002aL-HA; Tue, 19 Feb 2019 08:30:28 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gvzrI-0002Vg-1S; Tue, 19 Feb 2019 08:30:28 +0100
Date:   Tue, 19 Feb 2019 08:30:28 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        linux-pwm@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/5] dt-bindings: pwm: add a property
 "mediatek,num-pwms"
Message-ID: <20190219073028.eljpo6vlqpgmzcef@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <7e1de17a43f2cde73aecd2773e2b3a5fdfd294f3.1547781007.git.ryder.lee@mediatek.com>
 <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
 <20190218203658.GA20434@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190218203658.GA20434@bogus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 02:36:58PM -0600, Rob Herring wrote:
> On Fri, Jan 18, 2019 at 09:44:49AM +0100, Matthias Brugger wrote:
> > 
> > 
> > On 18/01/2019 04:24, Ryder Lee wrote:
> > > This adds a property "mediatek,num-pwms" in example so that we could
> > > set the number of PWM channels via device tree.
> > > 
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > ---
> > > Changes since v1: add a Reviewed-by tag.
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > index 991728c..f9e2d1f 100644
> > > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > > @@ -20,6 +20,7 @@ Required properties:
> > >   - pinctrl-names: Must contain a "default" entry.
> > >   - pinctrl-0: One property must exist for each entry in pinctrl-names.
> > >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> > > + - mediatek,num-pwms: the number of PWM channels.
> > >  
> > >  Example:
> > >  	pwm0: pwm@11006000 {
> > > @@ -37,4 +38,5 @@ Example:
> > >  			      "pwm3", "pwm4", "pwm5";
> > >  		pinctrl-names = "default";
> > >  		pinctrl-0 = <&pwm0_pins>;
> > > +		mediatek,num-pwms = <5>;
> > >  	};
> > > 
> > 
> > Wasn't there a comment in the last version to use num-pwms instead of
> > mediatek,num-pwms?
> > 
> > Uwe I think you requested that.
> 
> Perhaps, but why is this needed? Typically, this would be implied by the 
> compatible or the driver doesn't care and we assume 'pwms' properties 
> are not out of range.

I think it is sensible to standardize such a property because there are
a few drivers that support different variants of PWMs that only differ
in the number of supported pwms. See for example pwm-mediatek and
pwm-sun4i. I wrote a longer motivation in a mail that is available at
https://www.spinics.net/lists/linux-pwm/msg08859.html.

The short version is that there are at least four drivers that have to
solve the same task to determine the number of available pwms from the
compatible. While this isn't a hard task it seems sensible to me to
describe this generic property of a piece of hardware that provides PWMs
in the device tree instead of implementing a table in the driver.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
