Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90DE2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90DE2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeI0BFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:05:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60127 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbeI0BFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:05:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0272320731; Wed, 26 Sep 2018 20:51:31 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id CFDE720379;
        Wed, 26 Sep 2018 20:51:20 +0200 (CEST)
Date:   Wed, 26 Sep 2018 20:51:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
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
Message-ID: <20180926185121.GF16644@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
 <20180913190516.GG14988@piout.net>
 <20180926154708.GA3264@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926154708.GA3264@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2018 10:47:08-0500, Rob Herring wrote:
> > > +Optional property:
> > > +- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
> > > +  which differ from the default value of 7 pF
> > > +
> > 
> > The boolean properties usually don't work well for RTCs because people
> > usually want to keep any previous configuration that may have been done
> > at the factory or in the bootloader so I would use:
> > 
> > nxp,quartz_load_fF and this would be either 7000 or 12500.
> 
> Use '-' rather than '_'.
> 
> There's already a defined unit suffix of '-picofarads'. If you need 
> '-femtofarads', then please add to property-units.txt. Though I'd prefer 
> not as wouldn't a value of 12 (or 13) be close enough for the needs 
> here?
> 

For that particular RTC, yes but the isl1208 has 0.5pF steps and the
x1205 has 0.25pf steps. I'd prefer having a single generic property for
all the RTCs: quartz-load-femtofarads.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
