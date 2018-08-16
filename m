Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8651FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3715B214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3715B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391337AbeHPOqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 10:46:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55138 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeHPOqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 10:46:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3CF4220763; Thu, 16 Aug 2018 13:48:03 +0200 (CEST)
Received: from localhost (unknown [78.250.249.73])
        by mail.bootlin.com (Postfix) with ESMTPSA id E0042206DE;
        Thu, 16 Aug 2018 13:48:01 +0200 (CEST)
Date:   Thu, 16 Aug 2018 13:47:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] clk: at91: Rework DT bindings
Message-ID: <20180816114755.GH21707@piout.net>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
 <153271100280.48062.2538655794734424353@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153271100280.48062.2538655794734424353@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2018 10:03:22-0700, Stephen Boyd wrote:
> Quoting Alexandre Belloni (2018-07-17 15:27:41)
> > This is the promised rework of the at91 PMC clocks driver. It is mainly
> > necessary to remove the DTC warnings but it also complies with the CCF
> > rule that there should be one node per controller instead of one node
> > per clock.
> > 
> > This only handles the PMC, I'm planning to also rework the SCKC bindings
> > later (without breaking the DT ABI).
> > 
> > The series is based on top of clk-next plus at91-dt so I don't think it
> > is convenient to have it this cycle. However, I would really like to
> > ensure we agree on the new bindings this cycle before converting all the
> > other platforms as this is a bit tedious.
> > 
> > The first two patches are actually fixes and may be considered for this
> > cycle.
> > 
> > One nice note:
> > at91-sama5d2_xplained.dtb goes from 29351 bytes to 22082 bytes
> 
> Patches look mostly good. Rob is happy with the bindings and so am I.
> 
> One general question is why the drivers can't be moved to real platform
> drivers instead of using OF_CLK_DECLARE?
> 

I tried, this makes the clocksource drivers fail with -EPROBE_DEFER and
so the kernel just stops there.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
