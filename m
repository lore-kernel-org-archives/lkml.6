Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC5AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6412793E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SJM5csiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6412793E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936034AbeF1UhR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:37:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39614 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753417AbeF1UhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:37:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so6748378wro.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NzD6FkyOkk3IGqRCxQMM4/x5bGFK/E2HzpidJRXNW7w=;
        b=SJM5csiFi2dhdIcqrEieZrkNyLjOmOcZg0BRSN3PAKlj993uq+i48wAaEAVZqd0W5i
         Mu2n865Wc2wFwI78+hF5LXx8fPa9cN1LZqdDmQ3nhChpDUGn0J1i2uLYCRiEwjD1dq17
         fLnf5nWheJ0oNYckuMGghaTaMOHBNfLyP8ovMCfUIqoxYpTkZL+d1bbbTynLAfix1KNu
         vJzIOPCFYz6TeQfOOXkjfX/YKBqQcu9ffiP8lWykuGgqRm/iw868hum2YJW0aVOqfc9X
         LgCtK31Zk5orKoBVVS7i9C8+W+ja9AQ9KvOtQiuJSn0Y+5HBe8FoDBYs4PzQlJjxrLUT
         L5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NzD6FkyOkk3IGqRCxQMM4/x5bGFK/E2HzpidJRXNW7w=;
        b=JhHEr9T0/gW67e7+Atv3cZ2kMxlEYqpVjdYmlb3ElaiFw0huWJ3yUs7mDl2L4FMiNr
         XceqkBDF/YXkxKYz5+HFJHsjxXq787Xukv7Agq72EZ/0mBn4v59/2ZTdAPxLHz/JfVYV
         Lf/Utyi78okRdCXX3ssNVdLY8ttz895hf6DYmdeKjE7p2/XHf8Vdgx14gVZOvVYE1G2O
         Q4BmbmA1oTuS7c3jSELbjyvcEQoRerolg52j+j0uztqA8rfOyTiBG0q5AwdLXpMoN6rp
         LJe5P4XUh3bqOaghLPbE1uDLWQEUmlzDHbhlW85Rwl8iAqCmTxlZ5EmeoYG4PdpoV9is
         eq4A==
X-Gm-Message-State: APt69E0vNy74NoDSLSHAqZ9sFdqqdwUBIYuLvYWZhXucKn2A5XBPf1aL
        +sgIKGokqWFD4P9u3GRzEVSDFg==
X-Google-Smtp-Source: AAOMgpcxO+il3RggdYHwzRVBjtxUWs802y05VnfwP/9OvNb5kOxAW2EDD7GAv53avQQbSyZ6x3tZHQ==
X-Received: by 2002:adf:c646:: with SMTP id u6-v6mr9736101wrg.177.1530218234358;
        Thu, 28 Jun 2018 13:37:14 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id e13-v6sm9757529wrm.45.2018.06.28.13.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 13:37:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fYdfB-0004NC-Jw; Thu, 28 Jun 2018 14:37:09 -0600
Date:   Thu, 28 Jun 2018 14:37:09 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     linux-rdma@vger.kernel.org, Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmw_pvrdma: Release netdev when vmxnet3 module is removed
Message-ID: <20180628203709.GD379@ziepe.ca>
References: <20180628135938.19625-1-nhorman@tuxdriver.com>
 <20180628185946.GC379@ziepe.ca>
 <20180628194526.GA14168@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628194526.GA14168@hmswarspite.think-freely.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:45:26PM -0400, Neil Horman wrote:
> On Thu, Jun 28, 2018 at 12:59:46PM -0600, Jason Gunthorpe wrote:
> > On Thu, Jun 28, 2018 at 09:59:38AM -0400, Neil Horman wrote:
> > > On repeated module load/unload cycles, its possible for the pvrmda
> > > driver to encounter this crash:
> > > 
> > > ...
> > > 297.032448] RIP: 0010:[<ffffffff839e4620>]  [<ffffffff839e4620>] netdev_walk_all_upper_dev_rcu+0x50/0xb0
> > > [  297.034078] RSP: 0018:ffff95087780bd08  EFLAGS: 00010286
> > > [  297.034986] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff95087a0c0000
> > > [  297.036196] RDX: ffff95087a0c0000 RSI: ffffffff839e44e0 RDI: ffff950835d0c000
> > > [  297.037421] RBP: ffff95087780bd40 R08: ffff95087a0e0ea0 R09: abddacd03f8e0ea0
> > > [  297.038636] R10: abddacd03f8e0ea0 R11: ffffef5901e9dbc0 R12: ffff95087a0c0000
> > > [  297.039854] R13: ffffffff839e44e0 R14: ffff95087a0c0000 R15: ffff950835d0c828
> > > [  297.041071] FS:  0000000000000000(0000) GS:ffff95087fc00000(0000) knlGS:0000000000000000
> > > [  297.042443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  297.043429] CR2: ffffffffffffffe8 CR3: 000000007a652000 CR4: 00000000003607f0
> > > [  297.044674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  297.045893] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  297.047109] Call Trace:
> > > [  297.047545]  [<ffffffff839e4698>] netdev_has_upper_dev_all_rcu+0x18/0x20
> > > [  297.048691]  [<ffffffffc05d31af>] is_eth_port_of_netdev+0x2f/0xa0 [ib_core]
> > > [  297.049886]  [<ffffffffc05d3180>] ? is_eth_active_slave_of_bonding_rcu+0x70/0x70 [ib_core]
> > > ...
> > > 
> > > This occurs because vmw_pvrdma on probe stores a pointer to the netdev
> > > that exists on function 0 of the same bus/device/slot (which represents
> > > the vmxnet3 ethernet driver).  However, it never removes this pointer if
> > > the vmxnet3 module is removed, leading to crashes resulting from use
> > > after free dereferencing incidents like the one above.
> > > 
> > > The fix is pretty straightforward.  vmw_pvrdma should listen for
> > > NETDEV_REGISTER and NETDEV_UNREGISTER events in its event listener code
> > > block, and update the stored netdev pointer accordingly.  This solution
> > > has been tested by myself and the reporter with successful results.
> > > This fix also allows the pvrdma driver to find its underlying ethernet
> > > device in the event that vmxnet3 is loaded after pvrdma, which it was
> > > not able to do before.
> > > 
> > > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > > Reported-by: ruquin@redhat.com
> > > CC: Adit Ranadive <aditr@vmware.com>
> > > CC: VMware PV-Drivers <pv-drivers@vmware.com>
> > > CC: Doug Ledford <dledford@redhat.com>
> > > CC: Jason Gunthorpe <jgg@ziepe.ca>
> > > CC: linux-kernel@vger.kernel.org
> > >  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 25 +++++++++++++++++--
> > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> > > index 0be33a81bbe6..5b4782078a74 100644
> > > +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> > > @@ -699,8 +699,12 @@ static int pvrdma_del_gid(const struct ib_gid_attr *attr, void **context)
> > >  }
> > >  
> > >  static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
> > > +					  struct net_device *ndev,
> > >  					  unsigned long event)
> > >  {
> > > +	struct pci_dev *pdev_net;
> > > +
> > > +
> > >  	switch (event) {
> > >  	case NETDEV_REBOOT:
> > >  	case NETDEV_DOWN:
> > > @@ -718,6 +722,21 @@ static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
> > >  		else
> > >  			pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ACTIVE);
> > >  		break;
> > > +	case NETDEV_UNREGISTER:
> > > +		dev_put(dev->netdev);
> > > +		dev->netdev = NULL;
> > > +		break;
> > > +	case NETDEV_REGISTER:
> > > +		/* Paired vmxnet3 will have same bus, slot. But func will be 0 */
> > > +		pdev_net = pci_get_slot(dev->pdev->bus, PCI_DEVFN(PCI_SLOT(dev->pdev->devfn), 0));
> > > +		if ((dev->netdev == NULL) && (pci_get_drvdata(pdev_net) == ndev)) {
> > > +			/* this is our netdev */
> > > +			dev->netdev = ndev;
> > > +			dev_hold(ndev);
> > > +		}
> > > +		pci_dev_put(pdev_net);
> > > +		break;
> > > +
> > >  	default:
> > >  		dev_dbg(&dev->pdev->dev, "ignore netdevice event %ld on %s\n",
> > >  			event, dev->ib_dev.name);
> > > @@ -734,8 +753,9 @@ static void pvrdma_netdevice_event_work(struct work_struct *work)
> > >  
> > >  	mutex_lock(&pvrdma_device_list_lock);
> > >  	list_for_each_entry(dev, &pvrdma_device_list, device_link) {
> > > -		if (dev->netdev == netdev_work->event_netdev) {
> > > -			pvrdma_netdevice_event_handle(dev, netdev_work->event);
> > > +		if ((netdev_work->event == NETDEV_REGISTER) ||
> > > +		    (dev->netdev == netdev_work->event_netdev)) {
> > > +			pvrdma_netdevice_event_handle(dev, netdev_work->event_netdev, netdev_work->event);
> > >  			break;
> > >  		}
> > >  	}
> > > @@ -962,6 +982,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
> > >  	}
> > >  
> > >  	dev->netdev = pci_get_drvdata(pdev_net);
> > > +	dev_hold(dev->netdev);
> > >  	pci_dev_put(pdev_net);
> > >  	if (!dev->netdev) {
> > >  		dev_err(&pdev->dev, "failed to get vmxnet3 device\n");
> > 
> > I see a lot of new dev_hold's here, where are the matching
> > dev_puts()?
> > 
> I'm not sure I'd call 2 alot, but sure, there is a new dev_hold in the
> pvrdma_pci_probe routine, to hold a reference to the netdev that is looked up
> there.  It is balanced by the NETDEV_UNREGISTER case in
> pvrdma_netdevice_event_handle.  The UNREGISTER clause is also balancing the
> NETDEV_REGISTER case of the hanlder that looks up the matching netdev should a
> new device be registered.  Note that we will only hold a single device at a
> time, because a given pvrdma device only recongnizes a single vmxnet3 device
> (the one on function 0 of its own bus/device tuple).

I don't see how the dev_hold in pvrdma_pci_probe is undone during
error unwind (eg goto err_free_cq_ring)

And I don't see how it is put when pvrdma_pci_remove() is called.

Jason
