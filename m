Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC23420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="TL0f3D7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Il9twd9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC23420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeKBH6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:58:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40445 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727645AbeKBH6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:58:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 499EA21D33;
        Thu,  1 Nov 2018 18:53:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Nov 2018 18:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=4OzHYlasIVCTcfzJtCDXWBa4+Z
        cmcKmPXzbvFBogPHA=; b=TL0f3D7kOUiroKUufInLv/Ae596fCIvdpkHqmpZWff
        JXzygV3EygQtnhjxb1v4ILL+mGaNYQuSCL6ZGUVKM3SS4d0DloOV+NrQ6c17IkJE
        OjTLfavf0o93zKO1/5cgaYebwLgpqjH1STdQ/NvvbvwfzOxgeojrCFaLiDitfHfZ
        ZdrY+F++2CMveXAm0OChMyc4Uab4uLOWQrffTQv56KqjQUQ1yI7Ldd71RtpWqgQl
        gzcDoY1NqaqcFwzEELFkcBF/EolNyp8GJFbrL+tnUEusIqSA7hTjm0KB063ehw6N
        NXgKxVNWB1DFoJ/HBPN335AvQLReXt+toXUO/02uMt6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=4OzHYlasIVCTcfzJtCDXWBa4+ZcmcKmPXzbvFBogP
        HA=; b=Il9twd9bOusKOz6+WZg2rnGUWUT1A4h7Ydjeb75va+sY1Ed1wY/N9QNiq
        6ywFjpIP96wwvi5ShXw0nkAXhfzxJHbRruqKoeKOjd024YLe/Q+JUTfUaHQrlK8E
        sgA06nCdaBosIroh9+PYZv+xQsYcSYwZIHeV472w1x75FDBCFCFHSsfS6OvCfMfN
        Hr4y8Oqc4Bd6g0QVyrEDpaLSDhYwOQ/wFcB4aEQedl8RotWMZYdhnXsISzTwMm3G
        tqx/cmNTgrZ4AuHQ0ySoh1PLHmieStWSni87n1GRS0jeVqJ+REgOnP4xFIVbG6Fz
        ZpINC2w8GfMszGajyI9VWfTCKN2cg==
X-ME-Sender: <xms:1IPbWwMhjmNSceT_rcgmOJ9vnn44_u3Kzfe3l70luGP4Lco_V5JcgQ>
X-ME-Proxy: <xmx:1IPbW9TrdnAsZ0zbXP7U9BkBQezM-m0gi3JyBLfkyuL-2Bhc9CAxwQ>
    <xmx:1IPbWx_VDYpH8_ePFh-tTqe295Ugc8_zFoIqkY6fVIZ7ZADJwIYsKA>
    <xmx:1YPbWx_zB6Qxh4Y7aCRxaYmJSA_DsiBE2UFxs6ZqzyM5JUEykVlbbA>
    <xmx:1YPbW1Qc_MuZDDkZ_joUpiZaiELnzgxyaxZ7XQYR_-oPdOJezZOgVA>
    <xmx:1YPbWzEp765CDJUZ3iy_qVbaHY_NRz7EM3DkaSnkPBj0XhtXhnZ5pw>
    <xmx:1oPbW-TqaFMZDgdn902IMb9K2fGt1RgX5IW26a98H_sWzCk2YWJJ6w>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0196E427A;
        Thu,  1 Nov 2018 18:53:06 -0400 (EDT)
Message-ID: <c4f0fdcc971ca258539899a8b15755b96b2353f5.camel@mendozajonas.com>
Subject: Re: [PATCH net-next 5/6] net/ncsi: Reset channel state in
 ncsi_start_dev()
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Fri, 02 Nov 2018 09:53:03 +1100
In-Reply-To: <96158616f0774e3d9fae0e99bb16e605@AUSX13MPS306.AMER.DELL.COM>
References: <20181018035917.19413-1-sam@mendozajonas.com>
         <20181018035917.19413-6-sam@mendozajonas.com>
         <96158616f0774e3d9fae0e99bb16e605@AUSX13MPS306.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 21:26 +0000, Justin.Lee1@Dell.com wrote:
> > +int ncsi_reset_dev(struct ncsi_dev *nd)
> > +{
> > +	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
> > +	struct ncsi_channel *nc, *active;
> > +	struct ncsi_package *np;
> > +	unsigned long flags;
> > +	bool enabled;
> > +	int state;
> > +
> > +	active = NULL;
> > +	NCSI_FOR_EACH_PACKAGE(ndp, np) {
> > +		NCSI_FOR_EACH_CHANNEL(np, nc) {
> > +			spin_lock_irqsave(&nc->lock, flags);
> > +			enabled = nc->monitor.enabled;
> > +			state = nc->state;
> > +			spin_unlock_irqrestore(&nc->lock, flags);
> > +
> > +			if (enabled)
> > +				ncsi_stop_channel_monitor(nc);
> > +			if (state == NCSI_CHANNEL_ACTIVE) {
> > +				active = nc;
> > +				break;
> 
> Is the original intention to process the channel one by one?
> If it is the case, there are two loops and we might need to use
> "goto found" instead.

Yes we'll need to break out of the package loop here as well.

> 
> > +			}
> > +		}
> > +	}
> > +
> 
> found: ?
> 
> > +	if (!active) {
> > +		/* Done */
> > +		spin_lock_irqsave(&ndp->lock, flags);
> > +		ndp->flags &= ~NCSI_DEV_RESET;
> > +		spin_unlock_irqrestore(&ndp->lock, flags);
> > +		return ncsi_choose_active_channel(ndp);
> > +	}
> > +
> > +	spin_lock_irqsave(&ndp->lock, flags);
> > +	ndp->flags |= NCSI_DEV_RESET;
> > +	ndp->active_channel = active;
> > +	ndp->active_package = active->package;
> > +	spin_unlock_irqrestore(&ndp->lock, flags);
> > +
> > +	nd->state = ncsi_dev_state_suspend;
> > +	schedule_work(&ndp->work);
> > +	return 0;
> > +}
> 
> Also similar issue in ncsi_choose_active_channel() function below.
> 
> > @@ -916,32 +1045,49 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
> >  
> >  			ncm = &nc->modes[NCSI_MODE_LINK];
> >  			if (ncm->data[2] & 0x1) {
> > -				spin_unlock_irqrestore(&nc->lock, flags);
> >  				found = nc;
> > -				goto out;
> > +				with_link = true;
> >  			}
> >  
> > -			spin_unlock_irqrestore(&nc->lock, flags);
> > +			/* If multi_channel is enabled configure all valid
> > +			 * channels whether or not they currently have link
> > +			 * so they will have AENs enabled.
> > +			 */
> > +			if (with_link || np->multi_channel) {
> 
> I notice that there is a case that we will misconfigure the interface.
> For example below, multi-channel is not enable for package 1.
> But we enable the channel for ncsi2 below (package 1 channel 0) as that interface is the first
> channel for that package with link.

I don't think I see the issue here; multi-channel is not set on package
1, but both channels are in the channel whitelist. Channel 0 is
configured since it's the first found on package 1, and channel 1 is not
since channel 0 is already found. Are you expecting something different?
 
> 
> cat /sys/kernel/debug/ncsi_protocol/ncsi_device_
> IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
> =====================================================================
>   2   eth2   ncsi0  000 000 1  1  1  1  1  1  0  2  1  1  1  1  0  1
>   2   eth2   ncsi1  000 001 1  0  1  1  1  1  0  2  1  1  1  1  0  1
>   2   eth2   ncsi2  001 000 1  0  1  0  1  1  0  2  1  1  1  1  0  1
>   2   eth2   ncsi3  001 001 0  0  1  0  1  1  0  1  0  1  1  1  0  1
> =====================================================================
> MP: Multi-mode Package     WP: Whitelist Package
> MC: Multi-mode Channel     WC: Whitelist Channel
> PC: Primary Channel        CS: Channel State IA/A/IV 1/2/3
> PS: Poll Status            LS: Link Status
> RU: Running                CR: Carrier OK
> NQ: Queue Stopped          HA: Hardware Arbitration
> 
> I temporally change to the following to avoid that.
> 			if ((with_link &&
> 			     !np->multi_channel &&
> 			     list_empty(&ndp->channel_queue)) || np->multi_channel) {
> 
> > +				spin_lock_irqsave(&ndp->lock, flags);
> > +				list_add_tail_rcu(&nc->link,
> > +						  &ndp->channel_queue);
> > +				spin_unlock_irqrestore(&ndp->lock, flags);
> > +
> > +				netdev_dbg(ndp->ndev.dev,
> > +					   "NCSI: Channel %u added to queue (link %s)\n",
> > +					   nc->id,
> > +					   ncm->data[2] & 0x1 ? "up" : "down");
> > +			}
> > +
> > +			spin_unlock_irqrestore(&nc->lock, cflags);
> > +
> > +			if (with_link && !np->multi_channel)
> > +				break;
> 
> Similar issue here. As we are using break, so each package will configure one active TX.
> 

I believe this is handled properly in ncsi_channel_is_tx() in the most
recent revision.

> >  		}
> > +		if (with_link && !ndp->multi_package)
> > +			break;
> >  	}
> >  
> > -	if (!found) {
> > +	if (list_empty(&ndp->channel_queue) && found) {
> > +		netdev_info(ndp->ndev.dev,
> > +			    "NCSI: No channel with link found, configuring channel %u\n",
> > +			    found->id);
> > +		spin_lock_irqsave(&ndp->lock, flags);
> > +		list_add_tail_rcu(&found->link, &ndp->channel_queue);
> > +		spin_unlock_irqrestore(&ndp->lock, flags);
> > +	} else if (!found) {
> >  		netdev_warn(ndp->ndev.dev,
> > -			    "NCSI: No channel found with link\n");
> > +			    "NCSI: No channel found to configure!\n");
> >  		ncsi_report_link(ndp, true);
> >  		return -ENODEV;
> >  	}
> 
> Also, for deselect package handler function, do we want to set to inactive here?
> If we just change the state, the cached data still keeps the old value. If the new 
> ncsi_reset_dev() function is handling one by one, can we skip this part?

Technically yes we could skip the state change here since
ncsi_reset_dev() will have already done it. However if we send a DP
command via some other means then it is probably best to ensure we treat
all channels on that package as inactive.

> 
> static int ncsi_rsp_handler_dp(struct ncsi_request *nr)
> {
> 	struct ncsi_rsp_pkt *rsp;
> 	struct ncsi_dev_priv *ndp = nr->ndp;
> 	struct ncsi_package *np;
> 	struct ncsi_channel *nc;
> 	unsigned long flags;
> 
> 	/* Find the package */
> 	rsp = (struct ncsi_rsp_pkt *)skb_network_header(nr->rsp);
> 	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
> 				      &np, NULL);
> 	if (!np)
> 		return -ENODEV;
> 
> 	/* Change state of all channels attached to the package */
> 	NCSI_FOR_EACH_CHANNEL(np, nc) {
> 		spin_lock_irqsave(&nc->lock, flags);
> 		nc->state = NCSI_CHANNEL_INACTIVE;
> 
> 		spin_unlock_irqrestore(&nc->lock, flags);
> 	}
> 
> 	return 0;
> }
> 
> 


