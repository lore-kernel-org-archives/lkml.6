Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFDBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73E921531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73E921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeI0C5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:57:44 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:57314 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeI0C5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:57:43 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id CA3F82006D;
        Wed, 26 Sep 2018 22:42:53 +0200 (CEST)
Date:   Wed, 26 Sep 2018 22:42:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/5] dt-binding: rtci-pcf8523: add quartz_load property
Message-ID: <20180926204252.GA8654@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
 <20180913190516.GG14988@piout.net>
 <20180926154708.GA3264@bogus>
 <20180926185121.GF16644@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926185121.GF16644@piout.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=GNNGDwhTSeOm1O2XKAkA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:51:21PM +0200, Alexandre Belloni wrote:
> On 26/09/2018 10:47:08-0500, Rob Herring wrote:
> > > > +Optional property:
> > > > +- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
> > > > +  which differ from the default value of 7 pF
> > > > +
> > > 
> > > The boolean properties usually don't work well for RTCs because people
> > > usually want to keep any previous configuration that may have been done
> > > at the factory or in the bootloader so I would use:
> > > 
> > > nxp,quartz_load_fF and this would be either 7000 or 12500.
> > 
> > Use '-' rather than '_'.
> > 
> > There's already a defined unit suffix of '-picofarads'. If you need 
> > '-femtofarads', then please add to property-units.txt. Though I'd prefer 
> > not as wouldn't a value of 12 (or 13) be close enough for the needs 
> > here?
> > 
> 
> For that particular RTC, yes but the isl1208 has 0.5pF steps and the
> x1205 has 0.25pf steps. I'd prefer having a single generic property for
> all the RTCs: quartz-load-femtofarads.

I will change to use this, and update property-units.txt too, when I get
back to the patch set in a week or so.

	Sam
