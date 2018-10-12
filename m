Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8771C71122
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6CF205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6CF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJMCOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:14:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57225 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeJMCOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:14:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 72AF4207B4; Fri, 12 Oct 2018 20:40:26 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 43048206A2;
        Fri, 12 Oct 2018 20:40:16 +0200 (CEST)
Date:   Fri, 12 Oct 2018 20:40:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] clk: at91: Rework DT bindings
Message-ID: <20181012184017.GH2843@piout.net>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
 <153271100280.48062.2538655794734424353@swboyd.mtv.corp.google.com>
 <20180816114755.GH21707@piout.net>
 <153573753043.93865.2420370848457480370@swboyd.mtv.corp.google.com>
 <153936888640.5275.18223880548754104359@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153936888640.5275.18223880548754104359@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 11:28:06-0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2018-08-31 10:45:30)
> > Quoting Alexandre Belloni (2018-08-16 04:47:55)
> > > On 27/07/2018 10:03:22-0700, Stephen Boyd wrote:
> > > > Quoting Alexandre Belloni (2018-07-17 15:27:41)
> > > > > This is the promised rework of the at91 PMC clocks driver. It is mainly
> > > > > necessary to remove the DTC warnings but it also complies with the CCF
> > > > > rule that there should be one node per controller instead of one node
> > > > > per clock.
> > > > > 
> > > > > This only handles the PMC, I'm planning to also rework the SCKC bindings
> > > > > later (without breaking the DT ABI).
> > > > > 
> > > > > The series is based on top of clk-next plus at91-dt so I don't think it
> > > > > is convenient to have it this cycle. However, I would really like to
> > > > > ensure we agree on the new bindings this cycle before converting all the
> > > > > other platforms as this is a bit tedious.
> > > > > 
> > > > > The first two patches are actually fixes and may be considered for this
> > > > > cycle.
> > > > > 
> > > > > One nice note:
> > > > > at91-sama5d2_xplained.dtb goes from 29351 bytes to 22082 bytes
> > > > 
> > > > Patches look mostly good. Rob is happy with the bindings and so am I.
> > > > 
> > > > One general question is why the drivers can't be moved to real platform
> > > > drivers instead of using OF_CLK_DECLARE?
> > > > 
> > > 
> > > I tried, this makes the clocksource drivers fail with -EPROBE_DEFER and
> > > so the kernel just stops there.
> > > 
> > 
> > Ok. We have CLK_OF_DECLARE_DRIVER for that. Can you use that?
> > 
> 
> I assume this will be resent. I haven't seen anything yet though.
> 

It will, would you be willing to take it for this cycle if I manage to
send it on Monday? (it seems that we will have an -rc8).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
