Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E045C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C4E20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="avxU0T0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C4E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeKYGSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:18:53 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43062 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeKYGSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y7BhvAviZeKkaAIktEN1o690B3U3u8nUksuY3ADWplo=; b=avxU0T0KZK6QHlwyjKCoGsqaV
        hV3QeFpSL7DQwdUJN4gtrDQCujqTnfML9ZjERjYAyLrdX63CwiJcPSs/r+PDQuor6/olgcWvnZLni
        p5jt5oM12GZTbyQ0Iz1XknVDa+q+R6ZYEGeGNV1lEeYOQLcDtc/zTrSelnM/ewaLYBicg=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:47876)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gQdcS-0006bi-QP; Sat, 24 Nov 2018 19:29:33 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gQdcQ-0006vC-0O; Sat, 24 Nov 2018 19:29:30 +0000
Date:   Sat, 24 Nov 2018 19:29:28 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg KH <greg@kroah.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, linux-omap@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181124192928.GR6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
 <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
 <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
 <20181124001740.GI12912@darkstar.musicnaut.iki.fi>
 <20181124174823.GQ6920@n2100.armlinux.org.uk>
 <20181124190648.GB3416@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124190648.GB3416@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 09:06:48PM +0200, Aaro Koskinen wrote:
> Hello,
> 
> On Sat, Nov 24, 2018 at 05:48:23PM +0000, Russell King - ARM Linux wrote:
> > Hmm, there's more questionable stuff in this driver, and the gadget
> > layer.
> 
> [...]
> 
> > So, whatever way I look at this, the code in the removal path both
> > in omap_udc and the gadget removal code higher up looks very wrong
> > and broken to me.
> 
> Yes, week ago I saw omap_udc crashing on both probe failure and
> module removal and sent some fixes for the most obvious failures (see
> https://marc.info/?l=linux-usb&m=154258778316932&w=2).

The effect of your patch is basically to replace the release function
with a no-op function.

> Is there any good driver that uses usb_add_gadget_udc_release() correctly?
> Looking at fsl_qe_udc.c and fsl_udc_core.c they should also crash if
> usb_add_gadget_udc_release() fails.

usb_add_gadget_udc_release() itself will call the release function
automatically on error.

The release function should _also_ be called when usb_del_gadget_udc()
is called (and would be guaranteed if the memset() is removed.)

So, moving the cleanup in the remove path into the release function
would solve the problem with omap_udc, and removing the memset()
would solve the problem with the core code.

It does leave a problem if the omap_udc module is removed - the
release function _could_ be called after the module has been removed
which would lead to an oops.  That's presumably why there's a
completion.  One solution to that would be to move the assignment
of udc->done before the call to usb_del_gadget_udc().

However, using a completion for something like this tends to be
frowned upon, but I don't see any other way to ensure correctness
here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
