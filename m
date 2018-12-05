Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCFCC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0941B20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544037711;
	bh=f4fEzsQka7d0wlsvHtxzOszwgJSnuOy3W4rjne0azAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mvliNVQdddwjOrmcasfBh0W/4gBvcw8+PB9p63b9zmZGaMlvcbQExYDt+reHutMdh
	 ephUwnqEkjP99FGJIrmFLtszNJQ5lC5TN/bHMZDHyeU3PU5X0YKGZAf3pbVXR7nqPj
	 3GnmBj+BInNGn5+Qf60vCJVXWk9xsIG0h+tf0Dbs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0941B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeLETVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLETVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:21:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E822082D;
        Wed,  5 Dec 2018 19:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544037708;
        bh=f4fEzsQka7d0wlsvHtxzOszwgJSnuOy3W4rjne0azAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZi2abCjlgBo2zcUaUsSJq7nAYvrGXYZcMHCwqRoO5rDajtHd4kC+58mdGJURSpPk
         mLURIoDXSgA5ZHu2AeGOv47E0HgeB81tZEKPKYIZtzJsEc6Qz7sUZ8m6Vzy5qjaNcp
         twYnynWgOdGnm6yt2cSnExSBWiqGprBClmMfLSdI=
Date:   Wed, 5 Dec 2018 20:21:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dag B <dag@bakke.com>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] hid2hci: Fix udev rules for linux-4.14+
Message-ID: <20181205192145.GC434@kroah.com>
References: <20180620164240.6535-1-ville.syrjala@linux.intel.com>
 <20181204204117.14964-1-ville.syrjala@linux.intel.com>
 <20181205070621.GE16346@kroah.com>
 <20181205154032.GT9144@intel.com>
 <c2f9f862-0bf1-be6b-ad9f-8c375d4b8ff0@bakke.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2f9f862-0bf1-be6b-ad9f-8c375d4b8ff0@bakke.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:09:35PM +0100, Dag B wrote:
> 
> 
> On 05.12.2018 16:40, Ville Syrjälä wrote:
> > On Wed, Dec 05, 2018 at 08:06:21AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 04, 2018 at 10:41:17PM +0200, Ville Syrjala wrote:
> > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > 
> > > > Since commit 1455cf8dbfd0 ("driver core: emit uevents when
> > > > device is bound to a driver") the kernel started emitting
> > > > "bind" and "unbind" uevents which confuse the hid2hci
> > > > udev rules.
> > > > 
> > > > The symptoms on an affected machine (Dell E5400 in my case)
> > > > include bluetooth devices not appearing and udev hogging
> > > > the cpu as it's busy processing a constant stream of these
> > > > "bind"+"unbind" uevents.
> > > What is causing a "stream" of bind and unbind events?  This only happens
> > > when a device is attached to a driver or removed from a driver, which is
> > > caused by something else happening.
> > Not sure if it's just due to this thing causing devices to
> > appear/disappear during bind/unbind events or what.
> > 
> > > This should not be a normal
> > > occurance, unless something odd is happening to your hardware?
> > It's not specific to my hardware. Lot's of people are affected.
> > See eg.
> > https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1759836
> > 
> > Acutally looking through that bug it seems someone else noticed
> > hid2hci failing lot in the logs. So maybe it's just that we already
> > switched the mode during "add", and then we try to redo the same
> > thing during "bind" which fails, and that then causes and unbind?
> > Dunno, udev is beyond me.
> > 
> > 
> There is another bluetooth scenario where a cpu core peaks at 100%.
> This is when a bluetooth keyboard goes out to lunch/suspends/disappears.
> No idea if this is related to the original issue, asking forgiveness if it
> is not.

I have bluetooth keyboards working just fine here, again, more specifics
would be good to have.

> I have found it challenging to attract any attention to the problem, despite
> it not being an entirely new or uncommon occurence.
> 
> Google the following terms: bluetooth keyboard bluetoothd linux 100% cpu
> 
> 
> 
> By chance, I discovered a supposed fix for this on github today. I have not
> had the chance to test it (or if it even applies) yet:
> 
> https://github.com/peak3d/bluez/commit/9cc3c1afd793e40b1a0cdc4a13e08b5e2575759e
> 
> Could someone please shine a light on the sanity of this patch?

That's a userspace bluez patch, I think you are asking on the wrong
list, sorry.

greg k-h
