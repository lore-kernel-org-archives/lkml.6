Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836317-2-4604297145268197490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836316; b=rJ2p8XNIKrZa6DY2K37y6vtPrtVN2TMkf6XviCuK8GHnEK/
    GulY95iQnbihUafTUKDdw/L4DAfUWPizwqcsQdr/gwGUzpgNOuDnvR+NKJj4pqyr
    rO6n7ZGLIFsuA0rK2XQeBWY//VRN63VmKSrPNZcN8n4mgEX0GwaWafu8PlnDRL76
    gq/rzKzy2WimIvsObVtKabSO+PMO9xbBrzX/P70Q8cPOi9k5/nalDxImHYWPcOZw
    w144Q9ub582jXVLrIzJYYagzXIPTviBmGgQNlSQzt5sAg920i8j+v5b9NgO84agq
    9O0gdi85+xc997D2krielPVsRUN5EyMvkY86QGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836316; bh=j2sCDvcwwQbaKzWEYMb
    j1cV8HRZDBd9F6pAQWLtBAT0=; b=J0Z8V3m449ghecJVHLTKR2NHd2F4W5+BaOg
    wvzkT+Ej3Jol7nthYF8q0MW5g/VtS2dpWfDg6f/ZlhYAOW2B1cjRc677gsnGhV3J
    2chKZbOx0nDAP75aq1F7IXPqnURUhQA1mIwatQIcgp+lnqtroo2mHixa4RGzu110
    sHt7eguLrx6LTDxgBG3MbCZzIjRRWqjMCHIDaYrTTi5ZkCZvcdWdOfrlXX6oxoDz
    NKk3TFD4/2gWTrSPMJXv9gsMKjI26l6jqL1TRRjCNa0wubFWN+mqG+ndGrgGdPSS
    WN/VeapXp/cnjCXNyJ80294XfaNFvBsXtk3xEEkFUcjMJORKPXw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeB1QAe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:00:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34662 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932351AbeB1QAb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:31 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Christophe Leroy" <christophe.leroy@c-s.fr>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.887211024@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 218/254] net: fs_enet: do not call phy_stop() in
 interrupts
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit f8b39039cbf2a15f2b8c9f081e1cbd5dee00aaf5 upstream.

In case of TX timeout, fs_timeout() calls phy_stop(), which
triggers the following BUG_ON() as we are in interrupt.

[92708.199889] kernel BUG at drivers/net/phy/mdio_bus.c:482!
[92708.204985] Oops: Exception in kernel mode, sig: 5 [#1]
[92708.210119] PREEMPT
[92708.212107] CMPC885
[92708.214216] CPU: 0 PID: 3 Comm: ksoftirqd/0 Tainted: G        W       4.9.61 #39
[92708.223227] task: c60f0a40 task.stack: c6104000
[92708.227697] NIP: c02a84bc LR: c02a947c CTR: c02a93d8
[92708.232614] REGS: c6105c70 TRAP: 0700   Tainted: G        W        (4.9.61)
[92708.241193] MSR: 00021032 <ME,IR,DR,RI>[92708.244818]   CR: 24000822  XER: 20000000
[92708.248767]
GPR00: c02a947c c6105d20 c60f0a40 c62b4c00 00000005 0000001f c069aad8 0001a688
GPR08: 00000007 00000100 c02a93d8 00000000 000005fc 00000000 c6213240 c06338e4
GPR16: 00000001 c06330d4 c0633094 00000000 c0680000 c6104000 c6104000 00000000
GPR24: 00000200 00000000 ffffffff 00000004 00000078 00009032 00000000 c62b4c00
NIP [c02a84bc] mdiobus_read+0x20/0x74
[92708.281517] LR [c02a947c] kszphy_config_intr+0xa4/0xc4
[92708.286547] Call Trace:
[92708.288980] [c6105d20] [c6104000] 0xc6104000 (unreliable)
[92708.294339] [c6105d40] [c02a947c] kszphy_config_intr+0xa4/0xc4
[92708.300098] [c6105d50] [c02a5330] phy_stop+0x60/0x9c
[92708.305007] [c6105d60] [c02c84d0] fs_timeout+0xdc/0x110
[92708.310197] [c6105d80] [c035cd48] dev_watchdog+0x268/0x2a0
[92708.315593] [c6105db0] [c0060288] call_timer_fn+0x34/0x17c
[92708.321014] [c6105dd0] [c00605f0] run_timer_softirq+0x21c/0x2e4
[92708.326887] [c6105e50] [c001e19c] __do_softirq+0xf4/0x2f4
[92708.332207] [c6105eb0] [c001e3c8] run_ksoftirqd+0x2c/0x40
[92708.337560] [c6105ec0] [c003b420] smpboot_thread_fn+0x1f0/0x258
[92708.343405] [c6105ef0] [c003745c] kthread+0xbc/0xd0
[92708.348217] [c6105f40] [c000c400] ret_from_kernel_thread+0x5c/0x64
[92708.354275] Instruction dump:
[92708.357207] 7c0803a6 bbc10018 38210020 4e800020 7c0802a6 9421ffe0 54290024 bfc10018
[92708.364865] 90010024 7c7f1b78 81290008 552902ee <0f090000> 3bc3002c 7fc3f378 90810008
[92708.372711] ---[ end trace 42b05441616fafd7 ]---

This patch moves fs_timeout() actions into an async worker.

Fixes: commit 48257c4f168e5 ("Add fs_enet ethernet network driver, for several embedded platforms")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 16 +++++++++++++---
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h      |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -696,9 +696,11 @@ static int fs_enet_start_xmit(struct sk_
 	return NETDEV_TX_OK;
 }
 
-static void fs_timeout(struct net_device *dev)
+static void fs_timeout_work(struct work_struct *work)
 {
-	struct fs_enet_private *fep = netdev_priv(dev);
+	struct fs_enet_private *fep = container_of(work, struct fs_enet_private,
+						   timeout_work);
+	struct net_device *dev = fep->ndev;
 	unsigned long flags;
 	int wake = 0;
 
@@ -710,7 +712,6 @@ static void fs_timeout(struct net_device
 		phy_stop(fep->phydev);
 		(*fep->ops->stop)(dev);
 		(*fep->ops->restart)(dev);
-		phy_start(fep->phydev);
 	}
 
 	phy_start(fep->phydev);
@@ -721,6 +722,13 @@ static void fs_timeout(struct net_device
 		netif_wake_queue(dev);
 }
 
+static void fs_timeout(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	schedule_work(&fep->timeout_work);
+}
+
 /*-----------------------------------------------------------------------------
  *  generic link-change handler - should be sufficient for most cases
  *-----------------------------------------------------------------------------*/
@@ -847,6 +855,7 @@ static int fs_enet_close(struct net_devi
 	netif_carrier_off(dev);
 	if (fep->fpi->use_napi)
 		napi_disable(&fep->napi);
+	cancel_work_sync(&fep->timeout_work);
 	phy_stop(fep->phydev);
 
 	spin_lock_irqsave(&fep->lock, flags);
@@ -1102,6 +1111,7 @@ static int fs_enet_probe(struct platform
 
 	ndev->netdev_ops = &fs_enet_netdev_ops;
 	ndev->watchdog_timeo = 2 * HZ;
+	INIT_WORK(&fep->timeout_work, fs_timeout_work);
 	if (fpi->use_napi)
 		netif_napi_add(ndev, &fep->napi, fs_enet_rx_napi,
 		               fpi->napi_weight);
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -124,6 +124,7 @@ struct fs_enet_private {
 	spinlock_t lock;	/* during all ops except TX pckt processing */
 	spinlock_t tx_lock;	/* during fs_start_xmit and fs_tx         */
 	struct fs_platform_info *fpi;
+	struct work_struct timeout_work;
 	const struct fs_ops *ops;
 	int rx_ring, tx_ring;
 	dma_addr_t ring_mem_addr;
