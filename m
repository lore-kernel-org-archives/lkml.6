Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF656C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9C42064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="m451Bn5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKdkrq+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9C42064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeKANcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 09:32:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38225 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbeKANcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 09:32:00 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id EBCBE22444;
        Thu,  1 Nov 2018 00:30:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Nov 2018 00:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=8sxYpk5eLwsk5iXa/2gYvUiyTu
        YyFl1QOAdiRRPoMJc=; b=m451Bn5YTTvmSnlCWpMyFraJozAgdCkued6N9/2YJa
        oZCt9+cYQp79M77ijQ+fkBvOy3r/UEy+iwiYSJmautxw7j6xGoVRaaAqkRp6ybrc
        RjzECqakSyrCax7hYggY//srVVVWP2q3VcO2AuvgrMOFncaITWb7R/8K+H+dQoIY
        azaYeiOkMCcdsSDa0kDnQwXVSeBXHrapMt9vPR5NIw7Zl/9e1n0f6kzuU2irC2Ee
        TbhY3z7j2aS1lbdBk4BV8AqTfRuFz+vaRiS4CXgvPy69e/r8Bf//x8RYShpxeq3k
        6s+E+/HwSw38wLMEHFINnE+mxC6GIOhh0fqHjdqy69KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=8sxYpk5eLwsk5iXa/2gYvUiyTuYyFl1QOAdiRRPoM
        Jc=; b=pKdkrq+jDBf7Gj+yYMFJafIyelNLFbkMJLKq03qv5PmpFz2KrJ1sd8cYJ
        iDhYqTPTSgaAJ93q2+PLejW10dV5cdeT4UGhOvowXaG5DnBO4rhgdKITdFpc7YI3
        M+Hvo/gXysqAmdS/ukuTT8rqbND/HRISq2ZIKasX4MTYeUdy5lhnicHxyhF7EQYy
        efjbcNb9KXqxCZoI23Pp1WoTqdx7sMFqvmgCzBn/1u9zecUOb97fgVRokY/+ZkEP
        TBLZc+jINTlXHXO4pzVVtR3FSweq5uio9Ttg/zdKZG6FiKmFtCIP5u/aVbSnXnpT
        UTCmh7no749zZ/nuU3Vpyi2cfNPFg==
X-ME-Sender: <xms:c4HaWxpgY39fnb-e18IE3x6VtCNlT71ibA3lnxlub5c4TZBDY93kig>
X-ME-Proxy: <xmx:c4HaWwIkPOLGxvk2Yl8HAz46XUYeea_eINns8xlRmx118-9_oCvLog>
    <xmx:c4HaW-amRazImVBKdv5LFffpJZuQh1IO18wC4W1WBnGbMEDRrsV6zA>
    <xmx:c4HaW6D38DTcmoD5Cn-_7d_Hfw0oxzMQHhERHd4rnhhj73JsK7jDLQ>
    <xmx:c4HaWwYCeAda06wc0js12ReVNNCWucjDiFtppZaRktfGYkJv_RCApQ>
    <xmx:c4HaW6lbPeF__wWgpynwWl1T6fb-nIE28oa8K4rJ181bw-BtBFvEbg>
    <xmx:c4HaW1PXcR-HXCypKnVFqm21LUhTGDOK1HjXo0alDn6Ui9IZlal57w>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1D4A6E425A;
        Thu,  1 Nov 2018 00:30:40 -0400 (EDT)
Message-ID: <8004d6c236582253a82004ce72425b45f09d7d56.camel@mendozajonas.com>
Subject: Re: [PATCH net-next v2 5/6] net/ncsi: Reset channel state in
 ncsi_start_dev()
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Thu, 01 Nov 2018 15:30:38 +1100
In-Reply-To: <2be6038ad8cb43559495e6f84e97b8a6@AUSX13MPS306.AMER.DELL.COM>
References: <20181023215201.27315-1-sam@mendozajonas.com>
         <20181023215201.27315-6-sam@mendozajonas.com>
         <d6172566ffe94dec83c1026108e24c98@AUSX13MPS306.AMER.DELL.COM>
         <b0fd357b1fc4b9aed6300019557dc8a391ecf52d.camel@mendozajonas.com>
         <2be6038ad8cb43559495e6f84e97b8a6@AUSX13MPS306.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 18:23 +0000, Justin.Lee1@Dell.com wrote:
> > On Fri, 2018-10-26 at 17:25 +0000, Justin.Lee1@Dell.com wrote:
> > > Hi Samuel,
> > > 
> > > I noticed a few issues and commented below.
> > > 
> > > Thanks,
> > > Justin
> > > 
> > > 
> > > >  /* Resources */
> > > > +int ncsi_reset_dev(struct ncsi_dev *nd);
> > > >  void ncsi_start_channel_monitor(struct ncsi_channel *nc);
> > > >  void ncsi_stop_channel_monitor(struct ncsi_channel *nc);
> > > >  struct ncsi_channel *ncsi_find_channel(struct ncsi_package *np,
> > > > diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> > > > index 014321ad31d3..9bad03e3fa5e 100644
> > > > --- a/net/ncsi/ncsi-manage.c
> > > > +++ b/net/ncsi/ncsi-manage.c
> > > > @@ -550,8 +550,10 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
> > > >  		spin_lock_irqsave(&nc->lock, flags);
> > > >  		nc->state = NCSI_CHANNEL_INACTIVE;
> > > >  		spin_unlock_irqrestore(&nc->lock, flags);
> > > > -		ncsi_process_next_channel(ndp);
> > > > -
> > > > +		if (ndp->flags & NCSI_DEV_RESET)
> > > > +			ncsi_reset_dev(nd);
> > > > +		else
> > > > +			ncsi_process_next_channel(ndp);
> > > >  		break;
> > > >  	default:
> > > >  		netdev_warn(nd->dev, "Wrong NCSI state 0x%x in suspend\n",
> > > > @@ -1554,7 +1556,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
> > > >  		return 0;
> > > >  	}
> > > >  
> > > > -	return ncsi_choose_active_channel(nd);
> > > > +	return ncsi_reset_dev(nd);
> > > 
> > > If there is no available channel due to the whitelist, ncsi_start_dev() function will return failed
> > > Status and the network interface may fail to bring up too. It is possible for user to disable all 
> > > channels and leave the interface up for checking the LOM status.
> > > 
> > 
> > I'm not sure that that is a bug, or at least not in the scope of this
> > series. If the whitelist is set such that no channels are valid then
> > there's nothing for NCSI to do. If we want to do something like always
> > monitor all channels then that would be best to do in another patch.
> > 
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(ncsi_start_dev);
> > > 
> > > Also, if I send set_package_mask and set_channel_mask commands back to back in a program,
> > > the state machine doesn't work well. If I use command line and wait for it to complete for 
> > > each step, then it is fine.
> > 
> > Yeah that's not great; probably hitting some corner cases in the NCSI
> > locking. I'll look into the multi-channel related stuff but I have a
> > feeling that if you tried this with the existing set/clear commands you
> > would probably hit something similar, especially on your dual core
> > platform. If so this is probably something to fix separately.
> > 
> 
> It is possible that it is causing by the following code in ncsi_reset_dev() function.
> The state might be overwritten and the previous operation is interrupted.
> 
> 	spin_lock_irqsave(&ndp->lock, flags);
> 	ndp->flags |= NCSI_DEV_RESET;
> 	ndp->active_channel = active;
> 	ndp->active_package = active->package;
> 	spin_unlock_irqrestore(&ndp->lock, flags);
> 
> 	nd->state = ncsi_dev_state_suspend;

Yep, we should probably add a check before calling ncsi_reset_dev() in
the netlink code if we're already in reset, and check in ncsi_reset_dev()
if we mid-configuration.

For your trace below can you share exactly which commands you were
sending? Those messages aren't upstream so it's not 100% clear what's
being sent.

Thanks!
Sam

> 
> > > npcm7xx-emc f0825000.eth eth2: NCSI: Multi-package enabled on ifindex 2, mask 0x00000001
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_stop_channel_monitor() - pkg 0 ch 0
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 state 0400
> > > npcm7xx-emc f0825000.eth eth2: NCSI: pkg 0 ch 0 set as preferred channel
> > > npcm7xx-emc f0825000.eth eth2: NCSI: Multi-channel enabled on ifindex 2, mask 0x00000003
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_stop_channel_monitor() - pkg 0 ch 1
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 1 state 0400
> > > npcm7xx-emc f0825000.eth eth2: NCSI: Package 1 set to all channels disabled
> > > npcm7xx-emc f0825000.eth eth2: NCSI: Multi-channel enabled on ifindex 2, mask 0x00000000
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel()
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - pkg 0
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - pass pkg whitelist
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - ch 0
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - pass ch whitelist
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - skip
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - ch 1
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - pass ch whitelist
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - skip
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - next pkg
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_choose_active_channel() - pkg 1
> > > npcm7xx-emc f0825000.eth eth2: NCSI: No channel found to configure!
> > > npcm7xx-emc f0825000.eth eth2: NCSI interface down
> > > npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
> > > npcm7xx-emc f0825000.eth eth2: Wrong NCSI state 0x100 in workqueue
> > > 
> > > All masks are set correctly, but you can see the PS column is not right and channel doesn't
> > > configure correctly.
> > > 
> > > /sys/kernel/debug/ncsi_protocol# cat ncsi_device_status
> > > IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC PS LS RU CR NQ HA
> > > ===================================================================
> > >   2   eth2   ncsi0  000 000 1  1  1  1  1  1  1  0  1  1  1  0  1
> > >   2   eth2   ncsi1  000 001 1  0  1  1  1  1  0  0  1  1  1  0  1
> > >   2   eth2   ncsi2  001 000 0  0  1  1  0  0  0  0  1  1  1  0  1
> > >   2   eth2   ncsi3  001 001 0  0  1  1  0  0  0  0  1  1  1  0  1
> > > ===================================================================
> > > MP: Multi-mode Package     WP: Whitelist Package
> > > MC: Multi-mode Channel     WC: Whitelist Channel
> > > PC: Primary Channel
> > > PS: Poll Status
> > > LS: Link Status
> > > RU: Running
> > > CR: Carrier OK
> > > NQ: Queue Stopped
> > > HA: Hardware Arbitration
> > > 
> > > PS column is getting from (int)nc->monitor.enabled.
> 
> 


