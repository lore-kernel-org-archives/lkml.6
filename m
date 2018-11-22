Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8850AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D95020820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D95020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438996AbeKWJFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 04:05:54 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:58832 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbeKWJFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 04:05:54 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 08877200F3;
        Fri, 23 Nov 2018 00:24:26 +0200 (EET)
Date:   Fri, 23 Nov 2018 00:24:26 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony@atomide.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122151236.GA9611@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 22, 2018 at 10:29:48AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
> > > I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> > > API were too annoying and flooding the console. And now that I tried
> > > using DMA again with g_ether, it doesn't work anymore. The device get's
> > > recognized on host side, but no traffic goes through. Switching back to
> > > PIO makes it to work again.
> > 
> > A solution to that would be to do what the warning message says, and
> > update the driver to the DMAengine API.

Fully agreed, but I was busy debugging other more serious issues, and
just wanted to get a reliable ssh or USB serial access to the device
without any extra noise, so switching to PIO using a module parameter
is probably what most users do in such situations.

> Here's a partial conversion (not even build tested) - it only supports
> OUT transfers with dmaengine at the moment.

Thanks, I'll take a closer look and try to do some testing hopefully
during the weekend.

A.
