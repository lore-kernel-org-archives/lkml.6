Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5311C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F89205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F89205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeKYFzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 00:55:55 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:37514 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeKYFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 00:55:55 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 2470B40018;
        Sat, 24 Nov 2018 21:06:49 +0200 (EET)
Date:   Sat, 24 Nov 2018 21:06:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Greg KH <greg@kroah.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, linux-omap@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181124190648.GB3416@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
 <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
 <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
 <20181124001740.GI12912@darkstar.musicnaut.iki.fi>
 <20181124174823.GQ6920@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124174823.GQ6920@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Nov 24, 2018 at 05:48:23PM +0000, Russell King - ARM Linux wrote:
> Hmm, there's more questionable stuff in this driver, and the gadget
> layer.

[...]

> So, whatever way I look at this, the code in the removal path both
> in omap_udc and the gadget removal code higher up looks very wrong
> and broken to me.

Yes, week ago I saw omap_udc crashing on both probe failure and
module removal and sent some fixes for the most obvious failures (see
https://marc.info/?l=linux-usb&m=154258778316932&w=2).

Is there any good driver that uses usb_add_gadget_udc_release() correctly?
Looking at fsl_qe_udc.c and fsl_udc_core.c they should also crash if
usb_add_gadget_udc_release() fails.

A.
