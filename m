Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8D8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F9F208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="frP8DxlE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPJK6J6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F9F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeKLK3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:29:35 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54279 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:29:35 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 518BBA11;
        Sun, 11 Nov 2018 19:38:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 11 Nov 2018 19:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=loRrjAZIEO9LPbzMDCQ/pdxJrY
        U6ADNA11xkOPbn6cE=; b=frP8DxlE+OV3IGFj+dV4FQjjyhY8T0o6MbOOycAyTd
        jEx+04ewQwpc6a8cyMJ7VW2NFykUmEAHymhXWhPViW8B1thXq0Lk86+KCWd/OThC
        Pkxm5nvZdR2yvQDo4b9U6wmHjsIPhWseCHY9BpVX5nmnLgXw1IsFFrmPD+IzqeUC
        YkHwpdlOBPBi+xXfl4KrIi6p2N/w3cOIqBXSyGFWCd7Dn6fzfs4qop6UjPll3J7+
        1Rxc5GAMOptRPFASVfgrOdVIql6Xwt9DQT68jYuFjcFPJlYgv8xGVgPK+CDin/I1
        1gw2n/PZVDe+8KN8quY1pNGAFphFGuJms5NfL/8uQRZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=loRrjAZIEO9LPbzMDCQ/pdxJrYU6ADNA11xkOPbn6
        cE=; b=HPJK6J6o1BoImhIPr7mohUIckkEoj6VOXgLaksSZFJdxvNo9shABNTxAf
        81RsDdj6QR4NiuNUr7DIwLwXhv6qKVTMb7WTfh9RBnoOYAIp1uLbZYPbEvfkR5Fl
        wnFdUeBptgN2z0Wk3tFUpJFfvM/HrMItrQhrF9vXlyZIZbtn0FCxbjqGR98oDSeh
        yne7MqH92aTKzsgIA+UsQIz2d6q2R4MyPZBlVdg3W11s79k95g1vpSQQTDDd0aCi
        kJ6FiBTMFXYpr4THpN3x/qPbbOQAnHA2X+hXmKZvz46XHjg5T9RXU5V1zNbtPvnz
        cbBsiVVzIdFbdB5ZRahFKf7m+ekLQ==
X-ME-Sender: <xms:ocvoW8JGnAEKtAS0v6cZMIVWOLDqZYcDGrEA_Fcv17DGqtRw5fj8Ng>
X-ME-Proxy: <xmx:ocvoW2eGJdpEZ719ua9NB8G2ByA5hqgvSV6Fpre3N0WhgAkDduJozg>
    <xmx:ocvoW9yf8rzN_Nw9M5fB1mYheJ2klIM8wrb5eMB4VFn5LlKECDvV6Q>
    <xmx:ocvoW98mbSQznWEm2cJMPvxgB0ORLheZu-NK4g5XKgUlCkksxHBR5g>
    <xmx:ocvoW1i7rhJHV5Ef0TwCfEoJlFlVvffftUWwZ2g36K7D1YGgy1TNaw>
    <xmx:ocvoW0E0JEgIJ3EN3El6vdXqCoKX9lqBwQWDUAzY9fIvBt4-teXneQ>
    <xmx:ocvoW3PAMY6eUbWPDKQx2FUyRzLR-S14Xbma3WT5qkhZHAo7lMF2Yg>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A183E4750;
        Sun, 11 Nov 2018 19:38:55 -0500 (EST)
Message-ID: <cfeab378a2b226c1c0ba62912d18c5a254de8daa.camel@mendozajonas.com>
Subject: Re: [PATCH net-next v3 6/6] net/ncsi: Configure multi-package,
 multi-channel modes with failover
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Mon, 12 Nov 2018 11:38:52 +1100
In-Reply-To: <b2c6aea94f1648648dd349d23ce61bf6@AUSX13MPS302.AMER.DELL.COM>
References: <20181108024909.9897-1-sam@mendozajonas.com>
         <20181108024909.9897-7-sam@mendozajonas.com>
         <f9d0309dafe248a6aac8198f96f9bc4b@AUSX13MPS306.AMER.DELL.COM>
         <ce6a678b1a0673050bc8070cb99dd68d1929c227.camel@mendozajonas.com>
         <b2c6aea94f1648648dd349d23ce61bf6@AUSX13MPS302.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-09 at 21:58 +0000, Justin.Lee1@Dell.com wrote:
> Hi Samuel,
> 
> After running more testing, I notice that the extra patch causing failover function
> to fail. Also, occasionally, I will see two channels having TX enabled if I
> send netlink command back-to-back.
> 
> cat /sys/kernel/debug/ncsi_protocol/ncsi_device_
> IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
> =====================================================================
>   2   eth2   ncsi0  000 000 1  1  1  1  1  1  1  2  1  1  1  1  0  1
>   2   eth2   ncsi1  000 001 1  1  1  1  1  1  0  2  1  1  1  1  0  1
>   2   eth2   ncsi2  001 000 0  0  1  1  0  0  0  1  0  1  1  1  0  1
>   2   eth2   ncsi3  001 001 0  0  1  1  0  0  0  1  0  1  1  1  0  1
> =====================================================================
> MP: Multi-mode Package  WP: Whitelist Package
> MC: Multi-mode Channel  WC: Whitelist Channel
> PC: Primary Channel     CS: Channel State IA/A/IV 1/2/3
> PS: Poll Status         LS: Link Status
> RU: Running             CR: Carrier OK
> NQ: Queue Stopped       HA: Hardware Arbitration
> 
> Thanks,
> Justin
> 
> 
> > From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> > From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> > Date: Fri, 9 Nov 2018 13:11:03 +1100
> > Subject: [PATCH] net/ncsi: Reset state fixes, single-channel LSC
> > 
> > ---
> >  net/ncsi/ncsi-aen.c    |  8 +++++---
> >  net/ncsi/ncsi-manage.c | 19 +++++++++++++++----
> >  2 files changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
> > index 39c2e9eea2ba..034cb1dc5566 100644
> > --- a/net/ncsi/ncsi-aen.c
> > +++ b/net/ncsi/ncsi-aen.c
> > @@ -93,14 +93,16 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
> >  	if ((had_link == has_link) || chained)
> >  		return 0;
> >  
> > -	if (!ndp->multi_package && !nc->package->multi_channel) {
> > -		if (had_link)
> > -			ndp->flags |= NCSI_DEV_RESHUFFLE;
> > +	if (!ndp->multi_package && !nc->package->multi_channel && had_link) {
> > +		ndp->flags |= NCSI_DEV_RESHUFFLE;
> >  		ncsi_stop_channel_monitor(nc);
> >  		spin_lock_irqsave(&ndp->lock, flags);
> >  		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
> >  		spin_unlock_irqrestore(&ndp->lock, flags);
> >  		return ncsi_process_next_channel(ndp);
> > +	} else {
> > +		/* Configured channel came up */
> > +		return 0;
> 
> It is always going to else statement if multi_package and/or mutlit_channel is enabled.
>  
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_aen_handler_lsc() - pkg 0 ch 0 state down
> npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_aen_handler_lsc() - had_link 1, has_link 0, chained 0
> 
> These codes have no chance to run.
> 	if (had_link) {
> 		ncm = &nc->modes[NCSI_MODE_TX_ENABLE];
> 		if (ncsi_channel_is_last(ndp, nc)) {
> 			/* No channels left, reconfigure */
> 			return ncsi_reset_dev(&ndp->ndev);
> 		} else if (ncm->enable) {
> 			/* Need to failover Tx channel */
> 			ncsi_update_tx_channel(ndp, nc->package, nc, NULL);
> 		}
> 
> >  	}
> > 

Oops, wrote that patch a little fast it seems. This may also affect the
double-Tx above since ncsi_update_tx_channel() won't be reached.
I've attached a fixed up version below.

For the failover issue you're seeing in your previous email the issue is
likely in the ncsi_dev_state_suspend_gls state. This should send a GLS
command to all available channels, but it only does it for the current
package. Since not all packages are necessarily enabled in single-channel 
mode I'll need to have a think about the neatest way to handle that, but
it's a separate issue from this patch.

Cheers,
Sam


From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Fri, 9 Nov 2018 13:11:03 +1100
Subject: [PATCH] net/ncsi: Reset state fixes, single-channel LSC

---
 net/ncsi/ncsi-aen.c    | 16 ++++++++++------
 net/ncsi/ncsi-manage.c | 19 +++++++++++++++----
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 39c2e9eea2ba..76559d0eeea8 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -94,13 +94,17 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 		return 0;
 
 	if (!ndp->multi_package && !nc->package->multi_channel) {
-		if (had_link)
+		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
-		ncsi_stop_channel_monitor(nc);
-		spin_lock_irqsave(&ndp->lock, flags);
-		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
-		spin_unlock_irqrestore(&ndp->lock, flags);
-		return ncsi_process_next_channel(ndp);
+			ncsi_stop_channel_monitor(nc);
+			spin_lock_irqsave(&ndp->lock, flags);
+			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
+			spin_unlock_irqrestore(&ndp->lock, flags);
+			return ncsi_process_next_channel(ndp);
+		} else {
+			/* Configured channel came up */
+			return 0;
+		}
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



