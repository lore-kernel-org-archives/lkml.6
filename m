Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D06C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABFF208A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LN44cLHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABFF208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeGFKGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:06:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40578 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbeGFKEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ffwMMdfSMkC5tdUXSd3+GsiJpUTzu109vWpYv40l8r0=; b=LN44cLHkTG77QBanDvpWQjZR3
        K9I9BYzv1hamNajEH7mHIuFwJz/tOysWs5PIr7SPbZiIBu3ZD9rYy6x/jlLItTqxcif07ZarJHaiR
        TyM3G8wyt8tGAelcviuAL5JOzarDIZngmTzzJlbvIV26miERP2Da2bxEZSH12M1BQC5g8=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:37254)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fbNag-0005A1-L7; Fri, 06 Jul 2018 11:03:50 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fbNad-0000RG-OF; Fri, 06 Jul 2018 11:03:47 +0100
Date:   Fri, 6 Jul 2018 11:03:46 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
Message-ID: <20180706100346.GV17271@n2100.armlinux.org.uk>
References: <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
 <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
 <20180424080833.GJ16141@n2100.armlinux.org.uk>
 <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
 <0cbee3bd-8987-5f2f-519d-f8d1b426f2a3@ti.com>
 <20180424170625.GL16141@n2100.armlinux.org.uk>
 <b7a7ffb6-b282-cbc5-435e-9ca1cd405e33@ti.com>
 <20180424232523.GN16141@n2100.armlinux.org.uk>
 <7e8cdcf6-c816-1e01-24f1-a526fb0a591f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8cdcf6-c816-1e01-24f1-a526fb0a591f@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 11:01:15PM +0300, Jyri Sarha wrote:
> On 25/04/18 02:25, Russell King - ARM Linux wrote:
> > On Tue, Apr 24, 2018 at 09:25:44PM +0300, Jyri Sarha wrote:
> >> On 24/04/18 20:06, Russell King - ARM Linux wrote:
> >>> On Tue, Apr 24, 2018 at 07:04:16PM +0300, Jyri Sarha wrote:
> >>>> On 24/04/18 13:14, Peter Rosin wrote:
> >>>>> On 2018-04-24 10:08, Russell King - ARM Linux wrote:
> >>>>>> On Tue, Apr 24, 2018 at 08:58:42AM +0200, Peter Rosin wrote:
> >>>>>>> On 2018-04-23 18:08, Russell King - ARM Linux wrote:
> >>>>>>>> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
> >>>>>>>>>  static int tda998x_remove(struct i2c_client *client)
> >>>>>>>>>  {
> >>>>>>>>> -	component_del(&client->dev, &tda998x_ops);
> >>>>>>>>> +	struct device *dev = &client->dev;
> >>>>>>>>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> >>>>>>>>> +
> >>>>>>>>> +	drm_bridge_remove(&bridge->bridge);
> >>>>>>>>> +	component_del(dev, &tda998x_ops);
> >>>>>>>>> +
> >>>>>>>>
> >>>>>>>> I'd like to ask a rather fundamental question about DRM bridge support,
> >>>>>>>> because I suspect that there's a major fsckup here.
> >>>>>>>>
> >>>>>>>> The above is the function that deals with the TDA998x device being
> >>>>>>>> unbound from the driver.  With the component API, this results in the
> >>>>>>>> DRM device correctly being torn down, because one of the hardware
> >>>>>>>> devices has gone.
> >>>>>>>>
> >>>>>>>> With DRM bridge, the bridge is merely removed from the list of
> >>>>>>>> bridges:
> >>>>>>>>
> >>>>>>>> void drm_bridge_remove(struct drm_bridge *bridge)
> >>>>>>>> {
> >>>>>>>>         mutex_lock(&bridge_lock);
> >>>>>>>>         list_del_init(&bridge->list);
> >>>>>>>>         mutex_unlock(&bridge_lock);
> >>>>>>>> }
> >>>>>>>> EXPORT_SYMBOL(drm_bridge_remove);
> >>>>>>>>
> >>>>>>>> and the memory backing the "struct tda998x_bridge" (which contains
> >>>>>>>> the struct drm_bridge) will be freed by the devm subsystem.
> >>>>>>>>
> >>>>>>>> However, there is no notification into the rest of the DRM subsystem
> >>>>>>>> that the device has gone away.  Worse, the memory that is still in
> >>>>>>>> use by DRM has now been freed, so further use of the DRM device
> >>>>>>>> results in a use-after-free bug.
> >>>>>>>>
> >>>>>>>> This is really not good, and to me looks like a fundamental problem
> >>>>>>>> with the DRM bridge code.  I see nothing in the DRM bridge code that
> >>>>>>>> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
> >>>>>>>> the actual device itself.
> >>>>>>>>
> >>>>>>>> So, from what I can see, there seems to be a fundamental lifetime
> >>>>>>>> issue with the design of the DRM bridge code.  This needs to be
> >>>>>>>> fixed.
> >>>>>>>
> >>>>>>> Oh crap. A gigantic can of worms...
> >>>>>>
> >>>>>> Yes, it's especially annoying for me, having put the effort in to
> >>>>>> the component helper to cover all these cases.
> >>>>>>
> >>>>>>> Would a patch (completely untested btw) along this line of thinking make
> >>>>>>> any difference whatsoever?
> >>>>>>
> >>>>>> It looks interesting - from what I can see of the device links code,
> >>>>>> it would have the effect of unbinding the DRM device just before
> >>>>>> TDA998x is unbound, so that's an improvement.
> >>>>>>
> >>>>>> However, from what I can see, the link vanishes at that point (as
> >>>>>> DL_FLAG_AUTOREMOVE is set), and re-binding the TDA998x device results
> >>>>>> in nothing further happening - the link will be recreated, but there
> >>>>>> appears to be nothing that triggers the "consumer" to rebind at that
> >>>>>> point.  Maybe I've missed something?
> >>>>>
> >>>>> Right, auto-remove is a no-go. So, improving on the previous...
> >>>>>
> >>>>> (I think drm_panel might suffer from this issue too?)
> >>>>
> >>>> Yes it does and I took a shot at trying to fix it at the end of the
> >>>> previous merge window, but gave up as I run out of time. I re-spun the
> >>>> work now after reading this thread. I add you and Russell to cc.
> >>>
> >>> Right, and these exact problems are what the component helper is
> >>> there to sort out, in a subsystem independent way.
> >>>
> >>> What is the problem with the component helper that people seem to
> >>> be soo loathed to use it, instead preferring to come up with sub-
> >>> standard and broken alternatives?
> >>>
> >>
> >> Nothing but time. Embedding component helpers seamlessly into drm
> >> framework does not sound like a couple of days job. Right now I simply
> >> do not have time to take on a challenge like that. If someone does it I
> >> am all for it.
> >>
> >> However, I would not call device links substandard. They are in the
> >> device core after all.
> > 
> > Umm, no, I was not talking about the device links, but the tendency to
> > have subsystem or component specific solutions to this problem.
> > 
> 
> Oh yes. But in this case the substandard solution is already there and
> it is already widely used, despite it being severely broken. I am merely
> trying to fix the existing substandard solution.
> 
> I admit that a full integration with component helpers would probably be
> more elegant solution to the problem, but the amount of work is just too
> much. The change would impact the way all the master drm drivers pull
> them selves together. The drivers that already use the component helpers
> for some internal stuff will add their own challenge. Separate component
> matching implementations are needed for device-tree and ACPI (are ther
> more flavors?) etc. I just do not see this happening any time soon (am
> happy to be wrong about this).

The issue is actually worse than that:

- drivers that are already componentised can't use bridges
- drivers that use bridges can't use componentised stuff

because bridges don't register themselves with the component helper,
and the helpers in drm_of.c assume that all graph nodes will be
components.

The whole thing about whether stuff is componentised or bridge based
is really getting out of hand, and the push is towards bridge based
stuff even though that is technically inferior when it comes to being
able to develop and test (which involves being able to remove and
re-insert modules.)

Consequently more and more code is being written for bridges, and
the component helper ignored, and the problems with bridges are
being ignored.  This is not healthy.

The problem is only going to get worse.  Someone needs to bite the
bullet and fix bridges before the problem gets any more out of hand.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
