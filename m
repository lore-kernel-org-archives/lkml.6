Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520825000-2-12247388510774239913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825000; b=Oayp/FP7C6FAaH+eJ+6a6Qz997u1hry/lpuwgW1tgJVr+Ij
    54mZKv26RdxR58oEG8WeXSXnGWUc2GvKGbUni3CLsQO/VCiIqkCpzjS3ztqx5dWX
    2NTl2pb8T6ZoX41NA/8ieUadEZz/w/l2GUjsU4foKW/B7rrRGSt1wQo72hzXdwJd
    Mj6iuocb1RUs69kbAzHGfyZwutJzTGYTplVglOpLi9FY5zXdMa3QC0+3rjicqqhT
    1fl6Tyx0Scvl7EZXxaDzgnreVLoNOQmaylUg9ma61bH0oJDbLPeibcDRH0W7mIqY
    VTXP9gCFKrwL8AdhoQEqK6bS+Y968KoUE2vGaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825000; bh=j1MFSfPJ7EIQRbrpDQ0
    CxPovbLu0VWySnibnqZYqaTg=; b=oncWEEbo8uq4s59btVm838A5hevxd2C6b5a
    LAgZtcXqQ9RihZT6XGDJgn8vzPQfPA1YSZ6lHEWYdY1Nq/0Wy9mCQybV9o2dCfT1
    KCmbYNLctkJJ1NVm82343+mpOLVr11BESQh7qyH/PZHQMo4TDyUF0OW/CnBhduyy
    FaTdqLdkn67W03OcLAd7Df9sY2h2FhOTmMo2q5OP6UWG450YWeI7il9E4u2MfsfB
    YDghJE5RfoYTBHt/gL0V2p0BFk6zRO8XzboR/qhTbunnVGxFEUH93pCXxt0ChSRv
    rFyU5bRu0s5catA7H8AivtUDtDxiO/9/5XPgCEoOZhHCjooz8rw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeCLDWL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:22:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41290 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932710AbeCLDHp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:45 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paul Bolle" <pebolle@tiscali.nl>,
        "David S. Miller" <davem@davemloft.net>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.825355303@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 025/104] atp: remove set_rx_mode_8012()
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Bolle <pebolle@tiscali.nl>

commit bb263e18f481199a04f7aab9454c18cd3dbdb218 upstream.

Building atp.o triggers this GCC warning:
    drivers/net/ethernet/realtek/atp.c: In function ‘set_rx_mode’:
    drivers/net/ethernet/realtek/atp.c:871:26: warning: ‘mc_filter[0]’ may be used uninitialized in this function [-Wuninitialized]

GCC is correct. In promiscuous mode 'mc_filter' will be used
uninitialized in set_rx_mode_8012(), which is apparently inlined into
set_rx_mode().

But it turns out set_rx_mode_8012() will never be called, since
net_local.chip_type will always be RTL8002. So we can just remove
set_rx_mode_8012() and do some related cleanups.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/realtek/atp.c | 58 ++------------------------------------
 drivers/net/ethernet/realtek/atp.h |  2 --
 2 files changed, 2 insertions(+), 58 deletions(-)

--- a/drivers/net/ethernet/realtek/atp.c
+++ b/drivers/net/ethernet/realtek/atp.c
@@ -176,8 +176,7 @@ struct net_local {
     unsigned int tx_unit_busy:1;
     unsigned char re_tx,	/* Number of packet retransmissions. */
 		addr_mode,		/* Current Rx filter e.g. promiscuous, etc. */
-		pac_cnt_in_tx_buf,
-		chip_type;
+		pac_cnt_in_tx_buf;
 };
 
 /* This code, written by wwc@super.org, resets the adapter every
@@ -340,7 +339,6 @@ static int __init atp_probe1(long ioaddr
 	write_reg_high(ioaddr, CMR1, CMR1h_RESET | CMR1h_MUX);
 
 	lp = netdev_priv(dev);
-	lp->chip_type = RTL8002;
 	lp->addr_mode = CMR2h_Normal;
 	spin_lock_init(&lp->lock);
 
@@ -853,7 +851,7 @@ net_close(struct net_device *dev)
  *	Set or clear the multicast filter for this adapter.
  */
 
-static void set_rx_mode_8002(struct net_device *dev)
+static void set_rx_mode(struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
@@ -865,58 +863,6 @@ static void set_rx_mode_8002(struct net_
 	write_reg_high(ioaddr, CMR2, lp->addr_mode);
 }
 
-static void set_rx_mode_8012(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-	unsigned char new_mode, mc_filter[8]; /* Multicast hash filter */
-	int i;
-
-	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
-		new_mode = CMR2h_PROMISC;
-	} else if ((netdev_mc_count(dev) > 1000) ||
-		   (dev->flags & IFF_ALLMULTI)) {
-		/* Too many to filter perfectly -- accept all multicasts. */
-		memset(mc_filter, 0xff, sizeof(mc_filter));
-		new_mode = CMR2h_Normal;
-	} else {
-		struct netdev_hw_addr *ha;
-
-		memset(mc_filter, 0, sizeof(mc_filter));
-		netdev_for_each_mc_addr(ha, dev) {
-			int filterbit = ether_crc_le(ETH_ALEN, ha->addr) & 0x3f;
-			mc_filter[filterbit >> 5] |= 1 << (filterbit & 31);
-		}
-		new_mode = CMR2h_Normal;
-	}
-	lp->addr_mode = new_mode;
-    write_reg(ioaddr, CMR2, CMR2_IRQOUT | 0x04); /* Switch to page 1. */
-    for (i = 0; i < 8; i++)
-		write_reg_byte(ioaddr, i, mc_filter[i]);
-	if (net_debug > 2 || 1) {
-		lp->addr_mode = 1;
-		printk(KERN_DEBUG "%s: Mode %d, setting multicast filter to",
-			   dev->name, lp->addr_mode);
-		for (i = 0; i < 8; i++)
-			printk(" %2.2x", mc_filter[i]);
-		printk(".\n");
-	}
-
-	write_reg_high(ioaddr, CMR2, lp->addr_mode);
-    write_reg(ioaddr, CMR2, CMR2_IRQOUT); /* Switch back to page 0 */
-}
-
-static void set_rx_mode(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-
-	if (lp->chip_type == RTL8002)
-		return set_rx_mode_8002(dev);
-	else
-		return set_rx_mode_8012(dev);
-}
-
-
 static int __init atp_init_module(void) {
 	if (debug)					/* Emit version even if no cards detected. */
 		printk(KERN_INFO "%s", version);
--- a/drivers/net/ethernet/realtek/atp.h
+++ b/drivers/net/ethernet/realtek/atp.h
@@ -16,8 +16,6 @@ struct rx_header {
 #define PAR_STATUS	1
 #define PAR_CONTROL 2
 
-enum chip_type { RTL8002, RTL8012 };
-
 #define Ctrl_LNibRead	0x08	/* LP_PSELECP */
 #define Ctrl_HNibRead	0
 #define Ctrl_LNibWrite	0x08	/* LP_PSELECP */
