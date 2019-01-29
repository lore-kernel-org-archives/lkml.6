Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D629C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEAD2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782555;
	bh=x33nJ5bH6myQDzTmDUHe7OAVf7PqkQ1uZct4VIOW8G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iOqLnmd8GXcLFisOeIOs8Qr+Xh5Hf8cgRm7NsAwMgplNHDGSRAiUsNw74MhsW/Qeo
	 vs8IsADBxZCZ+KakXGAGrhnMBYb/pKSsqscZn/sT8CQjeaMBT4fEIVVb50lXQ0D3iF
	 DEjiYiF6IOVkATqqlHKYJhpnAiX5CKvdurHyw8jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfA2RWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfA2RWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:22:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82502087E;
        Tue, 29 Jan 2019 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548782551;
        bh=x33nJ5bH6myQDzTmDUHe7OAVf7PqkQ1uZct4VIOW8G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyyW1Fzw19ooyw0RceOWO1PdMIPKuYJOifNJ+cQbr0pmLOdNdUs+GI4icQkFS8diA
         5Jw1ocNRDAzH4TkuV9yJqzL5EoWLhpceMrMo/VMSbYR5X5cXAh2unNNHJbNM1r+ptL
         fEH/cVViEwD8s0WSH6lE2JAqjQ384vU4pxLPfiso=
Date:   Tue, 29 Jan 2019 18:22:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Camelia Alexandra Groza <camelia.groza@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 4.19 006/103] net: phy: phy driver features are mandatory
Message-ID: <20190129172229.GA27005@kroah.com>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129113159.909710200@linuxfoundation.org>
 <2f2aa129-e9fb-c75a-1b60-1821863986bf@applied-asynchrony.com>
 <VI1PR04MB4799457AC9ECABE4EE8E5021F2970@VI1PR04MB4799.eurprd04.prod.outlook.com>
 <20190129163321.GA21868@kroah.com>
 <19d73292-95c4-2990-8ec6-c2a9b87c5598@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19d73292-95c4-2990-8ec6-c2a9b87c5598@applied-asynchrony.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:57:38PM +0100, Holger Hoffstätte wrote:
> On 1/29/19 5:33 PM, Greg Kroah-Hartman wrote:
> > On Tue, Jan 29, 2019 at 04:05:16PM +0000, Camelia Alexandra Groza wrote:
> > > > -----Original Message-----
> > > > From: Holger Hoffstätte <holger@applied-asynchrony.com>
> > > > Sent: Tuesday, January 29, 2019 17:50
> > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> > > > kernel@vger.kernel.org
> > > > Cc: stable@vger.kernel.org; Scott Wood <oss@buserror.net>; Camelia
> > > > Alexandra Groza <camelia.groza@nxp.com>; David S. Miller
> > > > <davem@davemloft.net>; Heiner Kallweit <hkallweit1@gmail.com>
> > > > Subject: Re: [PATCH 4.19 006/103] net: phy: phy driver features are
> > > > mandatory
> > > > 
> > > > On 1/29/19 12:34 PM, Greg Kroah-Hartman wrote:
> > > > > 4.19-stable review patch.  If anyone has any objections, please let me
> > > > know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Camelia Groza <camelia.groza@nxp.com>
> > > > > 
> > > > > [ Upstream commit 3e64cf7a435ed0500e3adaa8aada2272d3ae8abc ]
> > > > > 
> > > > > Since phy driver features became a link_mode bitmap, phy drivers that
> > > > > don't have a list of features configured will cause the kernel to crash
> > > > > when probed.
> > > > > 
> > > > > Prevent the phy driver from registering if the features field is missing.
> > > > > 
> > > > > Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with
> > > > link_mode bitmap")
> > > > > Reported-by: Scott Wood <oss@buserror.net>
> > > > > Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> > > > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > ---
> > > > >    drivers/net/phy/phy_device.c |    5 +++++
> > > > >    include/linux/phy.h          |    4 ++--
> > > > >    2 files changed, 7 insertions(+), 2 deletions(-)
> > > > > 
> > > > > --- a/drivers/net/phy/phy_device.c
> > > > > +++ b/drivers/net/phy/phy_device.c
> > > > > @@ -1917,6 +1917,11 @@ int phy_driver_register(struct phy_drive
> > > > >    {
> > > > >    	int retval;
> > > > > 
> > > > > +	if (WARN_ON(!new_driver->features)) {
> > > > > +		pr_err("%s: Driver features are missing\n", new_driver-
> > > > > name);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > >    	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
> > > > >    	new_driver->mdiodrv.driver.name = new_driver->name;
> > > > >    	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
> > > > > --- a/include/linux/phy.h
> > > > > +++ b/include/linux/phy.h
> > > > > @@ -491,8 +491,8 @@ struct phy_device {
> > > > >     *   only works for PHYs with IDs which match this field
> > > > >     * name: The friendly name of this PHY type
> > > > >     * phy_id_mask: Defines the important bits of the phy_id
> > > > > - * features: A list of features (speed, duplex, etc) supported
> > > > > - *   by this PHY
> > > > > + * features: A mandatory list of features (speed, duplex, etc)
> > > > > + *   supported by this PHY
> > > > >     * flags: A bitfield defining certain other features this PHY
> > > > >     *   supports (like interrupts)
> > > > >     *
> > > > > 
> > > > 
> > > > This patch leads to the following dump during boot and no working
> > > > network:
> > > > 
> > > > Jan 29 13:11:50 ragnarok kernel: RIP: 0010:phy_driver_register+0x5f/0x80
> > > > [libphy]
> > > > Jan 29 13:11:50 ragnarok kernel: Code: dd 06 a0 48 c7 47 40 30 e4 06 a0 48 89
> > > > 77 10 c7 47 24 02 00 00 00 e8 10 5c 44 e1 89 c5 85 c0 0f 85 aa 1d 00 00 89 e8 5b
> > > > 5d c3 <0f> 0b 48 c7 c7 f0 20 07 a0 48 89 c6 bd ea ff ff ff e8 c9 4c 02 e1
> > > > Jan 29 13:11:50 ragnarok kernel: RSP: 0018:ffffc90000df3c78 EFLAGS:
> > > > 00010246
> > > > Jan 29 13:11:50 ragnarok kernel: RAX: ffffffffa0071c8d RBX: 0000000000000000
> > > > RCX: 0000000000000000
> > > > Jan 29 13:11:50 ragnarok kernel: RDX: 0000000000000000 RSI: ffffffffa0076900
> > > > RDI: ffffffffa0076040
> > > > Jan 29 13:11:50 ragnarok kernel: RBP: ffffffffa007a000 R08: 0000000000000044
> > > > R09: 0000000000000228
> > > > Jan 29 13:11:50 ragnarok kernel: R10: ffff888603a0d6f8 R11:
> > > > 000000000000003c R12: ffff888601252d00
> > > > Jan 29 13:11:50 ragnarok kernel: R13: 0000000000000002 R14:
> > > > ffffc90000df3e98 R15: ffffffffa0076900
> > > > Jan 29 13:11:50 ragnarok kernel: FS:  00007feea9ced800(0000)
> > > > GS:ffff888607240000(0000) knlGS:0000000000000000
> > > > Jan 29 13:11:50 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> > > > 0000000080050033
> > > > Jan 29 13:11:50 ragnarok kernel: CR2: 00007feea9cdfc42 CR3:
> > > > 00000005fec64001 CR4: 00000000000606e0
> > > > Jan 29 13:11:50 ragnarok kernel: Call Trace:
> > > > Jan 29 13:11:50 ragnarok kernel:  ? 0xffffffffa007a000
> > > > Jan 29 13:11:50 ragnarok kernel:  phy_init+0x24/0x58 [libphy]
> > > > Jan 29 13:11:50 ragnarok kernel:  do_one_initcall+0x43/0x1af
> > > > Jan 29 13:11:50 ragnarok kernel:  ? _cond_resched+0x15/0x30
> > > > Jan 29 13:11:50 ragnarok kernel:  ? kmem_cache_alloc_trace+0x154/0x1b0
> > > > Jan 29 13:11:50 ragnarok kernel:  do_init_module+0x5a/0x210
> > > > Jan 29 13:11:50 ragnarok kernel:  load_module+0x203a/0x2500
> > > > Jan 29 13:11:50 ragnarok kernel:  ? vfs_read+0x10d/0x130
> > > > Jan 29 13:11:50 ragnarok kernel:  ? __se_sys_finit_module+0xb1/0xd0
> > > > Jan 29 13:11:50 ragnarok kernel:  __se_sys_finit_module+0xb1/0xd0
> > > > Jan 29 13:11:50 ragnarok kernel:  do_syscall_64+0x3e/0xe0
> > > > Jan 29 13:11:50 ragnarok kernel:
> > > > entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > Jan 29 13:11:50 ragnarok kernel: RIP: 0033:0x7feeaa2417c9
> > > > Jan 29 13:11:50 ragnarok kernel: Code: 00 00 00 75 05 48 83 c4 18 c3 e8 82 9c 01
> > > > 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05
> > > > <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 87 c6 0c 00 f7 d8 64 89 01 48
> > > > Jan 29 13:11:50 ragnarok kernel: RSP: 002b:00007fff6fa6ea08 EFLAGS:
> > > > 00000246 ORIG_RAX: 0000000000000139
> > > > Jan 29 13:11:50 ragnarok kernel: RAX: ffffffffffffffda RBX: 000055c6eac06db0
> > > > RCX: 00007feeaa2417c9
> > > > Jan 29 13:11:50 ragnarok kernel: RDX: 0000000000000000 RSI:
> > > > 00007feeaa4198fd RDI: 0000000000000006
> > > > Jan 29 13:11:50 ragnarok kernel: RBP: 00007feeaa4198fd R08:
> > > > 0000000000000000 R09: 000055c6eac03000
> > > > Jan 29 13:11:50 ragnarok kernel: R10: 0000000000000006 R11:
> > > > 0000000000000246 R12: 0000000000000000
> > > > Jan 29 13:11:50 ragnarok kernel: R13: 000055c6eabfc1d0 R14:
> > > > 0000000000020000 R15: 000055c6eac06db0
> > > > Jan 29 13:11:50 ragnarok kernel: ---[ end trace 18e05a0afeb140b2 ]---
> > > > Jan 29 13:11:50 ragnarok kernel: libphy: Generic 10G PHY: Driver features are
> > > > missing
> > > > 
> > > > Apparently the r8169 driver for my NIC does something wrong wrt. this
> > > > fix and the original commit (719655a14971), but regardless - reverting this
> > > > patch leads to a booting & working 4.19.19:
> > > > 
> > > > Jan 29 13:29:16 ragnarok kernel: libphy: r8169: probed
> > > > Jan 29 13:29:19 ragnarok kernel: RTL8211E Gigabit Ethernet r8169-400:00:
> > > > attached PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=r8169-
> > > > 400:00, irq=IGNORE)
> > > > 
> > > > I've cc'ed Heiner Kallweit who might know why phylib with this fix and r8169
> > > > don't like each other.
> > > > 
> > > > cheers,
> > > > Holger
> > > 
> > > Hi
> > > 
> > > This points to an issue with the Generic 10G PHY driver. The following patch seems to be missing from the 4.19 stable tree and should be merged:
> > > f802912 net: phy: genphy_10g_driver: Avoid NULL pointer dereference
> > 
> > But that patch says it:
> > Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
> > 
> > Which is not in 4.19.y, it showed up in 4.20.
> 
> Nope, as you found 719655a14971 was backported:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=719655a149715f26fc4de904fe0aa83068bd5b9e

That doesn't show that happening, sorry, it's on a different branch.

It really did not get applied to the 4.19.y branch, you can see that if
you search manually with a local copy.

> > Ah, wait, I think that there was a patch backported to the 4.19.y queue
> > that should not have, specifically:
> > 	3e64cf7a435e ("net: phy: phy driver features are mandatory")
> > which said it too fixes:
> > 	719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
> > 
> > 
> > Holger, if you revert 3e64cf7a435e, does that solve the problem for you
> > here?
> 
> Yes, as per $SUBJECT if I patch --reverse 3e64cf7a435e it works again,
> seem my original log above.
> 
> Fwiw just test-booted 5.0-rc4 and it works too.

Wonderful, I'll go drop 3e64cf7a435e and push out a new -rc release.

Thanks so much for the quick testing and debugging.

greg k-h
