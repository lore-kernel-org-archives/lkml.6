Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093B8C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ABD20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ABD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeINCC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:02:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55462 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeINCC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:02:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F088E20730; Thu, 13 Sep 2018 22:51:45 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id C538A206FF;
        Thu, 13 Sep 2018 22:51:35 +0200 (CEST)
Date:   Thu, 13 Sep 2018 22:51:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
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
Message-ID: <20180913205136.GL14988@piout.net>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
 <20180913190516.GG14988@piout.net>
 <20180913204412.GA30987@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913204412.GA30987@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 22:44:12+0200, Sam Ravnborg wrote:
> > The boolean properties usually don't work well for RTCs because people
> > usually want to keep any previous configuration that may have been done
> > at the factory or in the bootloader so I would use:
> > 
> > nxp,quartz_load_fF and this would be either 7000 or 12500.
> We had is implmented like this (using pF) in the beginning but
> then went for the simpler property.
> Will add a fF property as you suggest and avoid breaking the existing drivers.
> We will check a few of the boards to see if the current configuration
> of the pcf8523 driver looks wrong, and if so we will print
> the warnings as suggested.
> 
> I think the above covers feedback on all patches.
> And thanks for the feedback!
> 

Hint: look at the cubox-i and the hummingboard schematics. I'm
definitely not an analog expert but the two capacitors on the cubox-i
are making me think that the setting should be different from the
hummingboard.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
