Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1ADC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6194420831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6194420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fluff.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeKSU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:58:55 -0500
Received: from hetzy.fluff.org ([88.198.11.153]:53848 "EHLO hetzy"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbeKSU6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:58:54 -0500
X-Greylist: delayed 1691 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2018 15:58:52 EST
Received: from ben by hetzy with local (Exim 4.89)
        (envelope-from <ben@fluff.org>)
        id 1gOgRo-0001TG-Ix; Mon, 19 Nov 2018 10:06:28 +0000
Date:   Mon, 19 Nov 2018 10:06:28 +0000
From:   Ben Dooks <ben@fluff.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Ben Dooks <ben-linux@fluff.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: host: ehci: allow tine of highspeed nak-count
Message-ID: <20181119100628.iukzaouikfsbrywq@hetzy.fluff.org>
References: <39eb9e8b-2b5d-ea75-3232-be77c3743dbc@codethink.co.uk>
 <Pine.LNX.4.44L0.1811161034500.1487-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1811161034500.1487-100000@iolanthe.rowland.org>
X-Disclaimer: These are my views alone.
X-URL:  http://www.fluff.org/
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@fluff.org
X-SA-Exim-Scanned: No (on hetzy); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 10:38:18AM -0500, Alan Stern wrote:
> On Fri, 16 Nov 2018, Ben Dooks wrote:
> 
> > On 14/11/18 18:47, Alan Stern wrote:
> > > On Wed, 14 Nov 2018, Ben Dooks wrote:
> > > 
> > >> From: Ben Dooks <ben.dooks@codethink.co.uk>
> > >>
> > >> At least some systems benefit with less scheduling if the NAK count
> > >> value is set higher than the default 4. For instance a Tegra3 with
> > >> an SMSC9512 showed less interrupt load when this was changed to 14.
> > > 
> > > Interesting.  Why do you think this is?  In theory, increasing the NAK
> > > count RL value should cause a higher memory bus load and perhaps a
> > > slight rise in the interrupt load (transfers will complete a little
> > > more quickly because the controller tries harder to poll the endpoints
> > > and see if they are ready).
> > 
> > I thought the NAK counter was decremented until the transfer is given
> > up on.
> 
> That's right.  So if the RL value is higher, there will be more polling
> attempts in quick succession before the NAK counter drops to 0 and the
> controller gives up.  More polling attempts in quick succession means 
> heavier memory bus usage.
> 
> > I'm going to have to go back and get some actual figures from
> > a running system as this was originally done over a year ago with the
> > SMSC9512 (IIRC) network driver.
> > 
> > >> To allow the changing of this value, add a sysfs node to each of
> > >> the controllers to allow run-time changing.
> > >>
> > >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > 
> > > The patch looks okay to me.
> > 
> > I'll look at getting some tracing from the SMSC driver to see what
> > is going on.
> 
> Okay.  Should we consider the patch to be held in suspense until then?

Yes, I'm not going to have access to any of the test hardware until the
end of the week, and will re-verify my initial notes from last year.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

