Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658F9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B6720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="aoq9uteb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yH1qwV2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B6720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeKILzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:55:54 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50319 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727157AbeKILzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:55:54 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 28EDF2260D;
        Thu,  8 Nov 2018 21:17:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Nov 2018 21:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=N0T6q/aodxLC8Ry+nvg0mAOcT1
        uNDPsqpOW0oXqPvoE=; b=aoq9uteb0GpKbp/K/lfLWekwSBckwcrwMj/S/Jwbf0
        wxfmN+1lU+18UexmeXWE28/PyomHpqHN1243UZknGkJZMpITOPUVhXNxBcIce6fy
        508j4aFW40y/5SdSeJw9E5nzHgan8YvFXpFDt8DXOuMeD68C91mvKWB8rFho3pkx
        XFACDWCkAJbpGq06nf52Uw3/7upgh7cadcs7xeIScBJO4zTIh6xgtzRMtV//LCHh
        1OJhUh3Wv6HM64TFOZOcfLxfLweWK5zfUxN3F/XAdbxehmqYfNFAAlxJRLYArJtq
        PRU1p6drvI/EVmUyFxlIAH1quph2g0ldbwGT5BgNgqtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=N0T6q/aodxLC8Ry+nvg0mAOcT1uNDPsqpOW0oXqPv
        oE=; b=yH1qwV2n884/VYvbZLk4ITFvJg6QEtl9tXnROTugwjzRQavQLNiocaNK1
        y20mnneCW7qwkQZuNPr31vzOGUEh/LYDmAg5MAOq7AGC/jz7yUi3a1x5xjZdzvU0
        sWvDZKUlPHLseijVvd/F6ps1mIdyPotWAKVGMcAIt2kuY9OqrTP6gOu5AkSANgJO
        wHOhDOfZ3fy8Z0+784ipkkYMH4yGXdmVzWjjfyjZrXiAZWqLXjmntThhv2p04VQh
        KOw0HrGuLJUEGA6TzOosPPuRjuGqCaOHO/saathjCpfoypqtlsAf+Xgvvl90TFNW
        YrJapdQcbqFrwEYPTojmM2RuFscpw==
X-ME-Sender: <xms:Nu7kW1UGJkJvjAsznbUQAJ9Phm8E8Uz7vVbUwyshUtzJTC59agBJVQ>
X-ME-Proxy: <xmx:Nu7kW9nJs2STmReRixtpWDwj2PjISg8P-vycZ9H71T1Kd_mdKItC3A>
    <xmx:Nu7kWw-58NQOtRUue5JFhQjN9G1MBLgXp38qDGEAqkUQu8LRtf6Lrg>
    <xmx:Nu7kWzJTL1Y_H0tOZzT9FiWpjfpOX3PjXDgwr4J_c0sYYKuj0YkYeA>
    <xmx:Nu7kW9jWZ5fXApOfiQ937P2fWl9f7zJeRXC_nELawxY4KBSN0h19zg>
    <xmx:Nu7kW3-rTJ7ihjVSxyl_WF0i-9jP1YG8p0vRezJnAJEiXA6u-gAATw>
    <xmx:N-7kWwGa_10hEfHUN4roOQrvpLSO6xRNXIClEjr9RXddPbR-93SHTw>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56404E4043;
        Thu,  8 Nov 2018 21:17:24 -0500 (EST)
Message-ID: <ce6a678b1a0673050bc8070cb99dd68d1929c227.camel@mendozajonas.com>
Subject: Re: [PATCH net-next v3 6/6] net/ncsi: Configure multi-package,
 multi-channel modes with failover
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Fri, 09 Nov 2018 13:17:21 +1100
In-Reply-To: <f9d0309dafe248a6aac8198f96f9bc4b@AUSX13MPS306.AMER.DELL.COM>
References: <20181108024909.9897-1-sam@mendozajonas.com>
         <20181108024909.9897-7-sam@mendozajonas.com>
         <f9d0309dafe248a6aac8198f96f9bc4b@AUSX13MPS306.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 22:48 +0000, Justin.Lee1@Dell.com wrote:
> Hi Samuel,
> 
> For multi-package and multi-channel case, channel seems to be select correctly. Expect that,
> I still see the timing issue for back-to-back netlink command. Due to that, channel might be
> set to invisible state. Please refer to ncsi0 and ncsi2 below. The channel state is set to 3.
> 
> cat /sys/kernel/debug/ncsi_protocol/ncsi_device_status
> IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
> =====================================================================
>   2   eth2   ncsi0  000 000 1  1  1  1  1  0  0  3  0  1  1  1  0  1
>   2   eth2   ncsi1  000 001 0  0  1  1  1  0  0  1  0  1  1  1  0  1
>   2   eth2   ncsi2  001 000 1  0  1  1  1  1  0  3  0  1  1  1  0  1
>   2   eth2   ncsi3  001 001 1  0  1  1  1  1  0  2  1  1  1  1  0  1
> =====================================================================
> MP: Multi-mode Package  WP: Whitelist Package
> MC: Multi-mode Channel  WC: Whitelist Channel
> PC: Primary Channel     CS: Channel State IA/A/IV 1/2/3
> PS: Poll Status         LS: Link Status
> RU: Running             CR: Carrier OK
> NQ: Queue Stopped       HA: Hardware Arbitration
> 
> The timing issue is not only happening in application. If I use using the following way
> to send the request, I can see the issue as well. 
> 
> ncsi_netlink -l 2 -a 0x01 -m; ncsi_netlink -l 2 -p 0 -b 0x03 -m; ncsi_netlink -l 2 -p 1 -b 0x00 -m;
> ncsi_netlink -l 2 -a 0x03 -m; ncsi_netlink -l 2 -p 0 -b 0x00 -m; ncsi_netlink -l 2 -p 1 -b 0x03 -m;

This actually recreates for me as well; I see now what you mean about
channels getting stuck in the invisible state. I believe I've narrowed
down the issue. I've pasted an additional patch below if you are able to
test on your machine.

> 
> 
> Also, there is one issue below for non-multi-package/non-multi-channel case.
> 
> Thanks,
> Justin
> 
> 
> > @@ -1008,32 +1164,49 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
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
> The line needs to change to "goto found". If not, all channels with link will be added
> even if the multi-channel is not enabled for that package. The ncsi1 below is enabled.
> There is no netlink command sent to enable multi-package or multi-channel.
> 
> IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
> =====================================================================
>   2   eth2   ncsi0  000 000 1  1  0  0  1  1  0  2  1  1  1  1  0  1
>   2   eth2   ncsi1  000 001 1  0  0  0  1  1  0  2  1  1  1  1  0  1
>   2   eth2   ncsi2  001 000 0  0  0  0  1  1  0  1  0  1  1  1  0  1
>   2   eth2   ncsi3  001 001 0  0  0  0  1  1  0  1  0  1  1  1  0  1
> =====================================================================
> MP: Multi-mode Package  WP: Whitelist Package
> MC: Multi-mode Channel  WC: Whitelist Channel
> PC: Primary Channel     CS: Channel State IA/A/IV 1/2/3
> PS: Poll Status         LS: Link Status
> RU: Running             CR: Carrier OK
> NQ: Queue Stopped       HA: Hardware Arbitration
> 
> >  		}
> > +		if (with_link && !ndp->multi_package)
> > +			break;
> >  	}
> 
> found:

This *may* be part of the above issue, I don't see this in normal
operation. The combination of (with_link && !np->multi_channel) and
(with_link && !ndp->multi_package) should prevent additional channels
being added without the need for 'goto found'. Please let me know if you
still see it with the extra patch.

> 
> After applying this change, I notice that if there is no link available to BMC when BMC
> starts, NC-SI can't properly configure channel once I plug in the Ethernet cable. 
> 
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_aen_handler_lsc() - pkg 0 ch 0 state up
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_aen_handler_lsc() - had_link 0, has_link 1, chained 0
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_stop_channel_monitor() - pkg 0 ch 0
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel()
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel() - pkg 0 ch 0 INVISIBLE
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel() - suspending pkg 0 ch 0
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 state 0400 select
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 state 0403 dc
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 state 0404 deselect
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 state 0405 done
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_rsp_handler_dp() - pkg 0 ch 0 INACTIVE
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_rsp_handler_dp() - pkg 0 ch 1 INACTIVE
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 state 0406 deselect
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 INACTIVE
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel()
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel() - No more channels to process
> npcm7xx-emc f0825000.eth eth2: NCSI interface down

Good find, there was a corner case in the LSC AEN handler changes that
led to this, I've fixed this in the patch as well. Thanks for testing!


From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Fri, 9 Nov 2018 13:11:03 +1100
Subject: [PATCH] net/ncsi: Reset state fixes, single-channel LSC

---
 net/ncsi/ncsi-aen.c    |  8 +++++---
 net/ncsi/ncsi-manage.c | 19 +++++++++++++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 39c2e9eea2ba..034cb1dc5566 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -93,14 +93,16 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (!ndp->multi_package && !nc->package->multi_channel) {
-		if (had_link)
-			ndp->flags |= NCSI_DEV_RESHUFFLE;
+	if (!ndp->multi_package && !nc->package->multi_channel && had_link) {
+		ndp->flags |= NCSI_DEV_RESHUFFLE;
 		ncsi_stop_channel_monitor(nc);
 		spin_lock_irqsave(&ndp->lock, flags);
 		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 		spin_unlock_irqrestore(&ndp->lock, flags);
 		return ncsi_process_next_channel(ndp);
+	} else {
+		/* Configured channel came up */
+		return 0;
 	}
 
 	if (had_link) {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index fa3c2144f5ba..92e59f07f9a7 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1063,17 +1063,17 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 	case ncsi_dev_state_config_done:
 		netdev_dbg(ndp->ndev.dev, "NCSI: channel %u config done\n",
 			   nc->id);
+		spin_lock_irqsave(&nc->lock, flags);
+		nc->state = NCSI_CHANNEL_ACTIVE;
+
 		if (ndp->flags & NCSI_DEV_RESET) {
 			/* A reset event happened during config, start it now */
-			spin_lock_irqsave(&nc->lock, flags);
 			nc->reconfigure_needed = false;
 			spin_unlock_irqrestore(&nc->lock, flags);
-			nd->state = ncsi_dev_state_functional;
 			ncsi_reset_dev(nd);
 			break;
 		}
 
-		spin_lock_irqsave(&nc->lock, flags);
 		if (nc->reconfigure_needed) {
 			/* This channel's configuration has been updated
 			 * part-way during the config state - start the
@@ -1092,7 +1092,6 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			break;
 		}
 
-		nc->state = NCSI_CHANNEL_ACTIVE;
 		if (nc->modes[NCSI_MODE_LINK].data[2] & 0x1) {
 			hot_nc = nc;
 		} else {
@@ -1803,6 +1802,18 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
 			spin_unlock_irqrestore(&ndp->lock, flags);
 			return 0;
 		}
+	} else {
+		switch (nd->state) {
+		case ncsi_dev_state_suspend_done:
+		case ncsi_dev_state_config_done:
+		case ncsi_dev_state_functional:
+			/* Ok */
+			break;
+		default:
+			/* Current reset operation happening */
+			spin_unlock_irqrestore(&ndp->lock, flags);
+			return 0;
+		}
 	}
 
 	if (!list_empty(&ndp->channel_queue)) {
-- 
2.19.1



