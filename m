Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A880C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FCC2780D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vikw59ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FCC2780D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936006AbeF1S7y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:59:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35243 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935093AbeF1S7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:59:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id z137-v6so10163231wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kL/0RKlrM2UCByDRfCDoAFNlKwtyaEaQBTklTLyi9Ww=;
        b=Vikw59ZNCH7gLKuFITIb+9Qz60gw5veqxNIGt2bMNb0FKMyl2sHVqJaVOyAI4kbgjI
         mMOSQlwjaU9cT7YhwDiUh5t1cYZnkSkZydZy4/k5xfw0jM3KEImnV4wnJrx1rIu4x/yx
         PkDka8IUM6qzjXpk3oKWPjvJ6+chwCuMbiBy/aU8gjib1FpstS/emACVRd3CqOHQpUsH
         jXN9X8YWBsDTEiByJNCSidMNk7ng9mq+pR83ZcXXXRDsRjYrJWwX3ppNh9+dSRA2y7T1
         LyDZVQvkFRkIM4+47z1YtLrsObqQaupBV2F1wB6oJro4rxsNuW8unIFB9txx0Xow9316
         kMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kL/0RKlrM2UCByDRfCDoAFNlKwtyaEaQBTklTLyi9Ww=;
        b=AWlY2+K6gAL0b7xkXB62xFwUo0aTJ0mo5UiG9shRiELrxasq7cNzggYG5KCZWyX/lz
         RnHVMSdZ9lkoqhvCUVK8XX8X2oLTTdp8M0LAjJkAZtPwJHLnM0b9UOspGkYLsw+exRki
         l9iLtTOjlAHDN4q4rvF7CjGHZTCXQUIh0singz2j2OPT0XLJjE708p4oufRH6tOs7Z0w
         7O2TIAaj3BpKCqSRzAJDl1jBOhuGHPwwq0ymKIwti+6vF+JheJBaNNsZG5jILKLyT2FX
         lyhF5/4UBK3ONPFv/cOSXBC6+7zDo87sXQjOXUpTlZBq+x9c7uLuKnR4dzBoalRzIawh
         7QGw==
X-Gm-Message-State: APt69E3C+5xhZgUKkCvWX9jm50i/ibec1GVkSHVpWS97CorU1NtbKMP5
        UoZrLFtAwv12i+IZTBUhkknIbCmAq50=
X-Google-Smtp-Source: AAOMgpcfvW6TZ4IPI8NRLa51s7Qnse0iv8J5dJMQkWPWkFKZ3TtNxzcrJtnZ+1GmmWJ0Y5HNTotjqg==
X-Received: by 2002:a1c:d482:: with SMTP id l124-v6mr8574109wmg.22.1530212391446;
        Thu, 28 Jun 2018 11:59:51 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x11-v6sm9554174wrm.78.2018.06.28.11.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:59:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fYc8w-0003cn-Qj; Thu, 28 Jun 2018 12:59:46 -0600
Date:   Thu, 28 Jun 2018 12:59:46 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     linux-rdma@vger.kernel.org, Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmw_pvrdma: Release netdev when vmxnet3 module is removed
Message-ID: <20180628185946.GC379@ziepe.ca>
References: <20180628135938.19625-1-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628135938.19625-1-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:59:38AM -0400, Neil Horman wrote:
> On repeated module load/unload cycles, its possible for the pvrmda
> driver to encounter this crash:
> 
> ...
> 297.032448] RIP: 0010:[<ffffffff839e4620>]  [<ffffffff839e4620>] netdev_walk_all_upper_dev_rcu+0x50/0xb0
> [  297.034078] RSP: 0018:ffff95087780bd08  EFLAGS: 00010286
> [  297.034986] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff95087a0c0000
> [  297.036196] RDX: ffff95087a0c0000 RSI: ffffffff839e44e0 RDI: ffff950835d0c000
> [  297.037421] RBP: ffff95087780bd40 R08: ffff95087a0e0ea0 R09: abddacd03f8e0ea0
> [  297.038636] R10: abddacd03f8e0ea0 R11: ffffef5901e9dbc0 R12: ffff95087a0c0000
> [  297.039854] R13: ffffffff839e44e0 R14: ffff95087a0c0000 R15: ffff950835d0c828
> [  297.041071] FS:  0000000000000000(0000) GS:ffff95087fc00000(0000) knlGS:0000000000000000
> [  297.042443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  297.043429] CR2: ffffffffffffffe8 CR3: 000000007a652000 CR4: 00000000003607f0
> [  297.044674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  297.045893] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  297.047109] Call Trace:
> [  297.047545]  [<ffffffff839e4698>] netdev_has_upper_dev_all_rcu+0x18/0x20
> [  297.048691]  [<ffffffffc05d31af>] is_eth_port_of_netdev+0x2f/0xa0 [ib_core]
> [  297.049886]  [<ffffffffc05d3180>] ? is_eth_active_slave_of_bonding_rcu+0x70/0x70 [ib_core]
> ...
> 
> This occurs because vmw_pvrdma on probe stores a pointer to the netdev
> that exists on function 0 of the same bus/device/slot (which represents
> the vmxnet3 ethernet driver).  However, it never removes this pointer if
> the vmxnet3 module is removed, leading to crashes resulting from use
> after free dereferencing incidents like the one above.
> 
> The fix is pretty straightforward.  vmw_pvrdma should listen for
> NETDEV_REGISTER and NETDEV_UNREGISTER events in its event listener code
> block, and update the stored netdev pointer accordingly.  This solution
> has been tested by myself and the reporter with successful results.
> This fix also allows the pvrdma driver to find its underlying ethernet
> device in the event that vmxnet3 is loaded after pvrdma, which it was
> not able to do before.
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> Reported-by: ruquin@redhat.com
> CC: Adit Ranadive <aditr@vmware.com>
> CC: VMware PV-Drivers <pv-drivers@vmware.com>
> CC: Doug Ledford <dledford@redhat.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: linux-kernel@vger.kernel.org
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> index 0be33a81bbe6..5b4782078a74 100644
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> @@ -699,8 +699,12 @@ static int pvrdma_del_gid(const struct ib_gid_attr *attr, void **context)
>  }
>  
>  static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
> +					  struct net_device *ndev,
>  					  unsigned long event)
>  {
> +	struct pci_dev *pdev_net;
> +
> +
>  	switch (event) {
>  	case NETDEV_REBOOT:
>  	case NETDEV_DOWN:
> @@ -718,6 +722,21 @@ static void pvrdma_netdevice_event_handle(struct pvrdma_dev *dev,
>  		else
>  			pvrdma_dispatch_event(dev, 1, IB_EVENT_PORT_ACTIVE);
>  		break;
> +	case NETDEV_UNREGISTER:
> +		dev_put(dev->netdev);
> +		dev->netdev = NULL;
> +		break;
> +	case NETDEV_REGISTER:
> +		/* Paired vmxnet3 will have same bus, slot. But func will be 0 */
> +		pdev_net = pci_get_slot(dev->pdev->bus, PCI_DEVFN(PCI_SLOT(dev->pdev->devfn), 0));
> +		if ((dev->netdev == NULL) && (pci_get_drvdata(pdev_net) == ndev)) {
> +			/* this is our netdev */
> +			dev->netdev = ndev;
> +			dev_hold(ndev);
> +		}
> +		pci_dev_put(pdev_net);
> +		break;
> +
>  	default:
>  		dev_dbg(&dev->pdev->dev, "ignore netdevice event %ld on %s\n",
>  			event, dev->ib_dev.name);
> @@ -734,8 +753,9 @@ static void pvrdma_netdevice_event_work(struct work_struct *work)
>  
>  	mutex_lock(&pvrdma_device_list_lock);
>  	list_for_each_entry(dev, &pvrdma_device_list, device_link) {
> -		if (dev->netdev == netdev_work->event_netdev) {
> -			pvrdma_netdevice_event_handle(dev, netdev_work->event);
> +		if ((netdev_work->event == NETDEV_REGISTER) ||
> +		    (dev->netdev == netdev_work->event_netdev)) {
> +			pvrdma_netdevice_event_handle(dev, netdev_work->event_netdev, netdev_work->event);
>  			break;
>  		}
>  	}
> @@ -962,6 +982,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
>  	}
>  
>  	dev->netdev = pci_get_drvdata(pdev_net);
> +	dev_hold(dev->netdev);
>  	pci_dev_put(pdev_net);
>  	if (!dev->netdev) {
>  		dev_err(&pdev->dev, "failed to get vmxnet3 device\n");

I see a lot of new dev_hold's here, where are the matching
dev_puts()?

Jason
