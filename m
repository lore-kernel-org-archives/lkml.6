Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5BC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CECD20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfAUInO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:43:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42945 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbfAUInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:43:13 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glVAd-0002pF-AB; Mon, 21 Jan 2019 09:43:03 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glVAb-0000NW-Tw; Mon, 21 Jan 2019 09:43:01 +0100
Date:   Mon, 21 Jan 2019 09:43:01 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 2/5] dt-bindings: pwm: add a property
 "mediatek,num-pwms"
Message-ID: <20190121084301.s5cx27sbywu2yr3m@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <7e1de17a43f2cde73aecd2773e2b3a5fdfd294f3.1547781007.git.ryder.lee@mediatek.com>
 <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 09:44:49AM +0100, Matthias Brugger wrote:
> 
> 
> On 18/01/2019 04:24, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" in example so that we could
> > set the number of PWM channels via device tree.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> > Changes since v1: add a Reviewed-by tag.
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index 991728c..f9e2d1f 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -20,6 +20,7 @@ Required properties:
> >   - pinctrl-names: Must contain a "default" entry.
> >   - pinctrl-0: One property must exist for each entry in pinctrl-names.
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> > + - mediatek,num-pwms: the number of PWM channels.
> >  
> >  Example:
> >  	pwm0: pwm@11006000 {
> > @@ -37,4 +38,5 @@ Example:
> >  			      "pwm3", "pwm4", "pwm5";
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&pwm0_pins>;
> > +		mediatek,num-pwms = <5>;
> >  	};
> > 
> 
> Wasn't there a comment in the last version to use num-pwms instead of
> mediatek,num-pwms?
> 
> Uwe I think you requested that.

I think it is sensible, but it needs Thierry's blessing. Unfortunately
he seems busy with other stuff and getting feedback from him needs
patience.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
