Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F4C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5598121D69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5598121D69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbeHIPtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:49:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35089 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHIPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:49:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8517A805F2; Thu,  9 Aug 2018 15:24:23 +0200 (CEST)
Date:   Thu, 9 Aug 2018 15:24:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
Message-ID: <20180809132418.GB4469@localhost>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd>
 <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd>
 <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
 <53691469-4554-42a8-c182-762c1a3939b7@gmail.com>
 <01bbf05a-8e5e-d3ce-857a-ac5c6efb779c@ti.com>
 <683f9e60-9ad8-93d8-e4ed-dbfdae78c307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683f9e60-9ad8-93d8-e4ed-dbfdae78c307@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> 2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
> >>> to when setting the brightness.  Each Bank has a separate register for brightness control.
> >>
> >> Just a blind shot, without going into details - could you please check
> >> if led-sources property documented in the common LED bindings couldn't
> >> help here?
> >>
> > 
> > I could change the name to led-sources.  But this part does not really follow the 1 output to a
> > 1 LED string topology.
> 
> led-sources was designed for describing the topology where one LED can
> be connected to more then one output, see bindings of
> max77693-led (in Documentation/devicetree/bindings/mfd/max77693.txt).
> 
> Here the topology is a bit different - more than one LED (string) can be
> connected to a single bank, but this is accomplished inside the chip.
> Logically LEDs configured that way can be treated as a single LED
> (string) connected to two outputs, and what follows they should be
> described by a single DT child node.
> 
> led-sources will fit very well for this purpose. You could do
> the following mapping:
> 
> 0 - HVLED1
> 1 - HVLED2
> 2 - HVLED3
> 
> Then, in the child DT nodes you would use these identifiers to describe
> the topology:
> 
> Following node would describe strings connected to the outputs
> HVLED1 and HVLED2 controlled by bank A.
> 
> led@0 {
> 	reg = <0>;
> 	led-sources = <0>. <1>;
> 	label = "white:first_backlight_cluster";
> 	linux,default-trigger = "backlight";
> };
> 
> 
> IOW I agree with Pavel, but I propose to use already documented common
> DT LED property.

This is better than my proposal. Thanks!
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
