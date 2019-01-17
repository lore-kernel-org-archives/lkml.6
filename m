Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC130C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E5620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfAQMIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:08:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35806 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfAQMIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:08:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0C62A207B6; Thu, 17 Jan 2019 13:08:43 +0100 (CET)
Received: from localhost (unknown [109.190.253.11])
        by mail.bootlin.com (Postfix) with ESMTPSA id B2BF62078C;
        Thu, 17 Jan 2019 13:08:42 +0100 (CET)
Date:   Thu, 17 Jan 2019 13:08:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jan Kotas <jank@cadence.com>
Cc:     Rob Herring <robh@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: Add bindings for Cadence RTC
Message-ID: <20190117120842.GB26715@piout.net>
References: <20190111151401.25047-1-jank@cadence.com>
 <20190111151401.25047-2-jank@cadence.com>
 <20190116210806.GA21535@bogus>
 <46BA7224-B229-4594-B039-8801A806657E@global.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46BA7224-B229-4594-B039-8801A806657E@global.cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2019 10:46:50+0000, Jan Kotas wrote:
> 
> > On 16 Jan 2019, at 22:08, Rob Herring <robh@kernel.org> wrote:
> > 
> > 
> > On Fri, Jan 11, 2019 at 03:14:00PM +0000, Jan Kotas wrote:
> >> This patch adds a DT binding documentation for
> >> Cadence RTC controller.
> >> +Required properties:
> >> +- compatible: Should be "cdns,rtc-r109v3"
> >> +- reg: Specifies base physical address and size of the register area.
> >> +- interrupts: A single interrupt specifier.
> >> +- clocks: Must contain two entries:
> >> +	- pclk: APB registers clock
> >> +	- ref_clk: reference 1Hz of 100Hz clock, depending on IP configuration
> > 
> > 1Hz OR 100Hz?
> 
> Hi,
> 
> The IP has a configuration parameter at build time,
> which selects the reference clock frequency.
> 
> It cannot be changed later, and there’s no register which
> tells the software which option was selected.
> 
> In this version of the patch, both values are accepted.
> If it makes sense I can add a bool property, like
> refclock-100hz, which can be used to check the clock frequency.
> 

I guess what rob suggested was s/of/or/


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
