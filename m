Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9457DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B3D205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cxDe0L5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B3D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeKYEhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 23:37:39 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41992 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYEhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 23:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BQJHxF1J0il6O8yNgQgtphdYspqFwdOUwLTRgBjUR+o=; b=cxDe0L5Ao41nKBSixvyNsPdnm
        xmlNrFPnM2k4BLsp0szH+/Fv21i2XDniXTpdh72SCWfXdcGr0yeqmYSFGfBaD4dom4Lji5JnDGb79
        v5MAHlPy6hnv6iHKd0n0U85usKkZP+PYtpdkswFafh0XpjkJcHZfEeS/bX9HQU8mSpAdI=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:41613)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gQc2e-0006FL-L2; Sat, 24 Nov 2018 17:48:28 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gQc2b-00060n-EU; Sat, 24 Nov 2018 17:48:25 +0000
Date:   Sat, 24 Nov 2018 17:48:23 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>, Greg KH <greg@kroah.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony@atomide.com,
        linux-omap@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181124174823.GQ6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
 <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
 <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
 <20181124001740.GI12912@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124001740.GI12912@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 02:17:40AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Nov 23, 2018 at 01:45:46PM +0200, Peter Ujfalusi wrote:
> > On 23/11/2018 0.01, Aaro Koskinen wrote:
> > > With that reverted, the DMA works OK (and I can also now confirm that
> > > OMAP_DMA_LCH_2D works). I haven't yet checked if we actually need that
> > > quirk in OMAP UDC,
> > 
> > The omap_udc driver is a bit of a mess, need to check it myself, but for
> > now we can just set the quirk_ep_out_aligned_size and investigate later.
> 
> OK, with quirk_ep_out_aligned_size we get 770/16xx DMA working again,
> but on 15xx the omap_udc DMA still doesn't work (tested today for the
> first time ever, I have no idea if it has ever worked and if so, when?).

Hmm, there's more questionable stuff in this driver, and the gadget
layer.

Fundamental fact of struct device - it's a ref-counted structure and
will only be freed when the last reference is dropped.  dev_unregister()
merely drops the refcount, it doesn't guarantee that it's dropped to
zero (iow, there can be other users).  Only when the refcount drops
to zero is the dev.release function called.  However:

usb_add_gadget_udc_release(..., release)
{
        if (release)
                gadget->dev.release = release;
        else
                gadget->dev.release = usb_udc_nop_release;
        device_initialize(&gadget->dev);
        ret = device_add(&gadget->dev);
}

At this point, that struct device is registered, so its refcount can
be increased by other users.

void usb_del_gadget_udc(struct usb_gadget *gadget)
{
...
        device_unregister(&gadget->dev);
        memset(&gadget->dev, 0x00, sizeof(gadget->dev));
}

That memset() is down-right wrong - the refcount on this struct device
may _not_ be zero at this point, the struct device could well be in
use by another thread.  That memset will trample over the contents of
the structure potentially while someone else is using it, and
_potentially_ before the gadget->dev.release function has been called.

However, that _may_ be a good thing when you read the omap_udc code:

        status = usb_add_gadget_udc_release(&pdev->dev, &udc->gadget,
                        omap_udc_release);

During the omap_udc_remove() function:
{
...
        usb_del_gadget_udc(&udc->gadget);
        if (udc->driver)
                return -EBUSY;

        udc->done = &done;

... more dereferences of udc, which is a _global_ variable ...

        wait_for_completion(&done);
}

Now, omap_udc_release() does this:

        complete(udc->done);
        kfree(udc);
        udc = NULL;

So, when usb_del_gadget_udc() is called, if device_unregister() within
there drops the last reference count, omap_udc_release() will be called
immediately.  Since udc->done hasn't been setup at that point, that
complete() will fail with a NULL pointer dereference.  If that doesn't
happen, then the kfree() and following set of the global 'udc' variable
to NULL means that all future references to 'udc' after the call to
usb_del_gadget_udc() in omap_udc_remove() will be dereferencing a NULL
pointer.  So one way or the other, this leads to a kernel OOPS.

If, on the other hand, omap_udc_release() was not called in
device_unregister(), the function pointer will be zeroed by the
memset(), which will lead to 'udc' never being freed - in other words,
we leak memory.

What's more is that 'done' is never "completed" so we end up hanging
at the wait_for_completion().

Then there's the pointless:

        if (udc->driver)
                return -EBUSY;

in omap_udc_remove().  The effect of returning an error is... what
exactly?  It doesn't prevent the device being removed at all, it
doesn't delay it, in fact the whole "remove returns an int" is
nothing but confusion - the return value from all driver remove
methods is completely ignored.

If udc->driver is still set at this point, it basically means that
we skip the rest of the tear down, but the platform device will
still be unbound from the driver, leaving (eg) the transceiver phy
still claimed, the procfs file still registered, the interrupts
still claimed, the memory region still registered, etc.  If omap_udc
is built as a module, the module could even be removed while all
that is still registered.

So, whatever way I look at this, the code in the removal path both
in omap_udc and the gadget removal code higher up looks very wrong
and broken to me.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
