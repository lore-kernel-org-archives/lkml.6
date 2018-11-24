Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6641020664
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6641020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeKXLED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:04:03 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:40484 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbeKXLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:04:03 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id DE8D6B0044;
        Sat, 24 Nov 2018 02:17:40 +0200 (EET)
Date:   Sat, 24 Nov 2018 02:17:40 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, linux-omap@vger.kernel.org,
        rmk+kernel@armlinux.org.uk,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181124001740.GI12912@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
 <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
 <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 23, 2018 at 01:45:46PM +0200, Peter Ujfalusi wrote:
> On 23/11/2018 0.01, Aaro Koskinen wrote:
> > With that reverted, the DMA works OK (and I can also now confirm that
> > OMAP_DMA_LCH_2D works). I haven't yet checked if we actually need that
> > quirk in OMAP UDC,
> 
> The omap_udc driver is a bit of a mess, need to check it myself, but for
> now we can just set the quirk_ep_out_aligned_size and investigate later.

OK, with quirk_ep_out_aligned_size we get 770/16xx DMA working again,
but on 15xx the omap_udc DMA still doesn't work (tested today for the
first time ever, I have no idea if it has ever worked and if so, when?).

A.
