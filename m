Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A1C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D29D20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="EDhoIV+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QaIhjpeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D29D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeKFJvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:51:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50235 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbeKFJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:51:25 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AB4322BCC;
        Mon,  5 Nov 2018 19:29:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Nov 2018 19:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=OkIZBWOJ34PZn7DiZatgYhN7cI
        2KZw3XynpoGl/ErjU=; b=EDhoIV+Y7YQKwRSbhAJm2XeQqqy+hugAYpTThns4K4
        R8h6RSGSbj/WoHApoC1tt/tFlgvpLqk2So+j3XHmd49YhG6QomdkKtKyVpG9PsoG
        IUzWw7Mv/QlSZswfK/pIDYyJFIqb+67YsPjN8+zTOeYVe4Racpzrvh+oa8/9N+d6
        7gQ1Sm7qnxhzriZpQhLs9RGaRstuGOOCTqj4qSTBf2DlpYjhJpCuY82j9l6RCwUj
        g8xrdzuNLyuFZmvM3Opr9rGqNy6wxUEZ2OnrBJhAclXyFBCWRixZqiFg3faTNCgj
        ZiBfa6OLqPUCMECltlLaw6YQ1Y44iXWGJInxS0X/jNUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=OkIZBWOJ34PZn7DiZatgYhN7cI2KZw3XynpoGl/Er
        jU=; b=QaIhjpeYHSn8Dm0ZYtRGtkgF274SWLGX5n1LdNRLJslyvHnOyGCOvKzwq
        b4ZY2L+m3X/jVrEIRyclkf/98Z922LFZHy5TFFxWaFZMz7woO2QPlBqLSi/nbsqm
        +je3TwmAc9cOfXRwrQN0v3t8uygb+p/qXy574VFRWNj+tGenuXrYRjyca3wkzF1b
        rbbpfwTlAumDK/jsBkgzlHUXaMGj5emLjKEJI6NuweGmMS2EXmASIbXUtTWHQTW7
        lBD+o3/wa/UPNQcVhTF7mfgKQCSKXwDKWJgufyNKd2p1f6o7nAIh5ooPR/pdXcSm
        +dIK33Ay9rJhCWWnPOicIz0DPXz7g==
X-ME-Sender: <xms:S-DgW93TIr8tnx_bDnyc8AKeQPoWzf1AbxN9p8a0K2hg4ic0Kg1NDg>
X-ME-Proxy: <xmx:S-DgW9MQWpVrxFniDfENKn3nJEadKW72uW82M7_MSc_KzcAnju9Xpw>
    <xmx:S-DgWx9DZ_4rc6KQTSs4bhsjJAZ-AEXsaZ7CBO5KXZMH90IOygawFg>
    <xmx:S-DgWwkjFI0digSACdH9A2boI3nzpXWgybVAtM-8ev5rKhKbzsVZjA>
    <xmx:S-DgWx4dPWUGPmjlZqYBZlmpP-nzGyECpn2Nk9kO7RegPji4JqjvMA>
    <xmx:S-DgW_IOeKlwfzap_tm8FeND3FIifHIL0w8n-K6tayHafohJc8fB_Q>
    <xmx:TODgW9R0tStWwjXxn88_YBMQOWn4Rv44FCjhyDv0m6kqmM0ka3z1rw>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id B7371E47C4;
        Mon,  5 Nov 2018 19:28:56 -0500 (EST)
Message-ID: <de9816e6c9cb31fdae1bb3d4a38da65b8f3a7694.camel@mendozajonas.com>
Subject: Re: [PATCH net-next 5/6] net/ncsi: Reset channel state in
 ncsi_start_dev()
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Tue, 06 Nov 2018 11:28:53 +1100
In-Reply-To: <ea740068c02a47e2a5411f84c61e69b3@AUSX13MPS302.AMER.DELL.COM>
References: <20181018035917.19413-1-sam@mendozajonas.com>
         <20181018035917.19413-6-sam@mendozajonas.com>
         <96158616f0774e3d9fae0e99bb16e605@AUSX13MPS306.AMER.DELL.COM>
         <c4f0fdcc971ca258539899a8b15755b96b2353f5.camel@mendozajonas.com>
         <ea740068c02a47e2a5411f84c61e69b3@AUSX13MPS302.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 18:01 +0000, Justin.Lee1@Dell.com wrote:
> > On Tue, 2018-10-30 at 21:26 +0000, Justin.Lee1@Dell.com wrote:
> > > > +int ncsi_reset_dev(struct ncsi_dev *nd)
> > > > +{
> > > > +	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
> > > > +	struct ncsi_channel *nc, *active;
> > > > +	struct ncsi_package *np;
> > > > +	unsigned long flags;
> > > > +	bool enabled;
> > > > +	int state;
> > > > +
> > > > +	active = NULL;
> > > > +	NCSI_FOR_EACH_PACKAGE(ndp, np) {
> > > > +		NCSI_FOR_EACH_CHANNEL(np, nc) {
> > > > +			spin_lock_irqsave(&nc->lock, flags);
> > > > +			enabled = nc->monitor.enabled;
> > > > +			state = nc->state;
> > > > +			spin_unlock_irqrestore(&nc->lock, flags);
> > > > +
> > > > +			if (enabled)
> > > > +				ncsi_stop_channel_monitor(nc);
> > > > +			if (state == NCSI_CHANNEL_ACTIVE) {
> > > > +				active = nc;
> > > > +				break;
> > > 
> > > Is the original intention to process the channel one by one?
> > > If it is the case, there are two loops and we might need to use
> > > "goto found" instead.
> > 
> > Yes we'll need to break out of the package loop here as well.
> > 
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +
> > > 
> > > found: ?
> > > 
> > > > +	if (!active) {
> > > > +		/* Done */
> > > > +		spin_lock_irqsave(&ndp->lock, flags);
> > > > +		ndp->flags &= ~NCSI_DEV_RESET;
> > > > +		spin_unlock_irqrestore(&ndp->lock, flags);
> > > > +		return ncsi_choose_active_channel(ndp);
> > > > +	}
> > > > +
> > > > +	spin_lock_irqsave(&ndp->lock, flags);
> > > > +	ndp->flags |= NCSI_DEV_RESET;
> > > > +	ndp->active_channel = active;
> > > > +	ndp->active_package = active->package;
> > > > +	spin_unlock_irqrestore(&ndp->lock, flags);
> > > > +
> > > > +	nd->state = ncsi_dev_state_suspend;
> > > > +	schedule_work(&ndp->work);
> > > > +	return 0;
> > > > +}
> > > 
> > > Also similar issue in ncsi_choose_active_channel() function below.
> > > 
> > > > @@ -916,32 +1045,49 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
> > > >  
> > > >  			ncm = &nc->modes[NCSI_MODE_LINK];
> > > >  			if (ncm->data[2] & 0x1) {
> > > > -				spin_unlock_irqrestore(&nc->lock, flags);
> > > >  				found = nc;
> > > > -				goto out;
> > > > +				with_link = true;
> > > >  			}
> > > >  
> > > > -			spin_unlock_irqrestore(&nc->lock, flags);
> > > > +			/* If multi_channel is enabled configure all valid
> > > > +			 * channels whether or not they currently have link
> > > > +			 * so they will have AENs enabled.
> > > > +			 */
> > > > +			if (with_link || np->multi_channel) {
> > > 
> > > I notice that there is a case that we will misconfigure the interface.
> > > For example below, multi-channel is not enable for package 1.
> > > But we enable the channel for ncsi2 below (package 1 channel 0) as that interface is the first
> > > channel for that package with link.
> > 
> > I don't think I see the issue here; multi-channel is not set on package
> > 1, but both channels are in the channel whitelist. Channel 0 is
> > configured since it's the first found on package 1, and channel 1 is not
> > since channel 0 is already found. Are you expecting something different?
> >  
> 
> The setting is that multi-package is enable for both package 0 and 1.
> Multi-channel is only enabled for package 0.
> 
> > > cat /sys/kernel/debug/ncsi_protocol/ncsi_device_
> > > IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
> > > =====================================================================
> > >   2   eth2   ncsi0  000 000 1  1  1  1  1  1  0  2  1  1  1  1  0  1
> > >   2   eth2   ncsi1  000 001 1  0  1  1  1  1  0  2  1  1  1  1  0  1
> > >   2   eth2   ncsi2  001 000 1  0  1  0  1  1  0  2  1  1  1  1  0  1
> 
> I was replying to the wrong old email and it might cause a bit confusion.
> The first 1 meaning channel is enabled for package 1 channel 0 (ncsi2). 
> For eth2, we already has ncsi0 as the active channel with TX enable.
> I would think that package doesn't have the multi-channel enabled and
> we should not enable the channel for ncsi2. The problem is that package 1 doesn't
> enable the multi-channel and it believes it needs to enable one channel for its package 
> but it doesn't aware that the other package already has one active channel.

Ah, maybe the confusion here is that multi_channel is a per-package
setting; it determines what a package does with its own channels.

So you have package 0 with multi-channel enabled so it enables channels 0
& 1.
Then you have package 1 without multi-channel so it enables only channel
0.
There is still only one Tx channel (package 0, channel 0).

Does that sound right, or have I missed something?

> 
> > >   2   eth2   ncsi3  001 001 0  0  1  0  1  1  0  1  0  1  1  1  0  1
> > > =====================================================================
> > > MP: Multi-mode Package     WP: Whitelist Package
> > > MC: Multi-mode Channel     WC: Whitelist Channel
> > > PC: Primary Channel        CS: Channel State IA/A/IV 1/2/3
> > > PS: Poll Status            LS: Link Status
> > > RU: Running                CR: Carrier OK
> > > NQ: Queue Stopped          HA: Hardware Arbitration
> > > 
> > > I temporally change to the following to avoid that.
> > > 			if ((with_link &&
> > > 			     !np->multi_channel &&
> > > 			     list_empty(&ndp->channel_queue)) || np->multi_channel) {
> > > 
> > > > +				spin_lock_irqsave(&ndp->lock, flags);
> > > > +				list_add_tail_rcu(&nc->link,
> > > > +						  &ndp->channel_queue);
> > > > +				spin_unlock_irqrestore(&ndp->lock, flags);
> > > > +
> > > > +				netdev_dbg(ndp->ndev.dev,
> > > > +					   "NCSI: Channel %u added to queue (link %s)\n",
> > > > +					   nc->id,
> > > > +					   ncm->data[2] & 0x1 ? "up" : "down");
> > > > +			}
> > > > +
> > > > +			spin_unlock_irqrestore(&nc->lock, cflags);
> > > > +
> > > > +			if (with_link && !np->multi_channel)
> > > > +				break;
> > > 
> > > Similar issue here. As we are using break, so each package will configure one active TX.
> > > 
> > 
> > I believe this is handled properly in ncsi_channel_is_tx() in the most
> > recent revision.
> 
> I saw this issue with the last revision. I was using the wrong email to reply.
> 
> > > >  		}
> > > > +		if (with_link && !ndp->multi_package)
> > > > +			break;
> > > >  	}
> > > >  
> > > > -	if (!found) {
> > > > +	if (list_empty(&ndp->channel_queue) && found) {
> > > > +		netdev_info(ndp->ndev.dev,
> > > > +			    "NCSI: No channel with link found, configuring channel %u\n",
> > > > +			    found->id);
> > > > +		spin_lock_irqsave(&ndp->lock, flags);
> > > > +		list_add_tail_rcu(&found->link, &ndp->channel_queue);
> > > > +		spin_unlock_irqrestore(&ndp->lock, flags);
> > > > +	} else if (!found) {
> > > >  		netdev_warn(ndp->ndev.dev,
> > > > -			    "NCSI: No channel found with link\n");
> > > > +			    "NCSI: No channel found to configure!\n");
> > > >  		ncsi_report_link(ndp, true);
> > > >  		return -ENODEV;
> > > >  	}
> > > 
> > > Also, for deselect package handler function, do we want to set to inactive here?
> > > If we just change the state, the cached data still keeps the old value. If the new 
> > > ncsi_reset_dev() function is handling one by one, can we skip this part?
> > 
> > Technically yes we could skip the state change here since
> > ncsi_reset_dev() will have already done it. However if we send a DP
> > command via some other means then it is probably best to ensure we treat
> > all channels on that package as inactive.
> 
> When I tested, if I didn't comment out the state change in response handler,
> ncsi_reset_dev() function will not handle properly and some channels got into
> invisible state and at the end we lost those selectable channels.

Well that's not good :)
The deselect package command should only be sent once all channels on a
package have become inactive, so I wouldn't expect it to interfere with
ncsi_reset_dev(), but perhaps this gets combined with the issues sending
netlink commands close together. I'll investigate, if I'm lucky this will
be resolved with the same fixes.

> 
> > > static int ncsi_rsp_handler_dp(struct ncsi_request *nr)
> > > {
> > > 	struct ncsi_rsp_pkt *rsp;
> > > 	struct ncsi_dev_priv *ndp = nr->ndp;
> > > 	struct ncsi_package *np;
> > > 	struct ncsi_channel *nc;
> > > 	unsigned long flags;
> > > 
> > > 	/* Find the package */
> > > 	rsp = (struct ncsi_rsp_pkt *)skb_network_header(nr->rsp);
> > > 	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
> > > 				      &np, NULL);
> > > 	if (!np)
> > > 		return -ENODEV;
> > > 
> > > 	/* Change state of all channels attached to the package */
> > > 	NCSI_FOR_EACH_CHANNEL(np, nc) {
> > > 		spin_lock_irqsave(&nc->lock, flags);
> > > 		nc->state = NCSI_CHANNEL_INACTIVE;
> > > 
> > > 		spin_unlock_irqrestore(&nc->lock, flags);
> > > 	}
> > > 
> > > 	return 0;
> > > }
> > > 
> > > 
> 
> 


