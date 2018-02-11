Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324155-2-14248709869565678038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324155; b=c3wfhmIn031DL935pFIWlReWGbtuvHA8ourjyAGa9AqxcFn
    NjJnMBcI/7+N9itjyfKGa0+oP6k015I/eDMg6hauCSTJGErgDy7h3BUjqVo7AkGb
    XMxZJOZT3/7tR5Mvu8NGHfA58QTYhk7h33Gr76gXldVk+zDq388i9kD9MP6yUUcU
    YbPh+StCQvFj2WjLlpOFpbY7B8IMxXvmOOBqc5E/0WCGlP3vkQDzGzFmLkdeup2L
    gU8qpqqgcz+wOswQXIuvL1x5lXzh2g7LcfKbzv6lWvfvKT0nXMm3TRkR8B2DjJ9r
    jsDGjOLHanmHMwta7HlIS5APj3P+KfbGh1asniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324155; bh=L59rnwqSR3lQZ9CvZN2
    QtrtDXC70YRijia+OLDmec0w=; b=MXN3Xi4F7JxIMIS7P3hh0gVFvZqCLmZIJ9P
    uBVOSQkLiLESr6xQwkVHNCCxU0FPIK1J8z2z2PR9zzcC6l53ZEwaNzFRzZdG06vm
    B9kmEma4LrA7vpFqVZxNLsFw8Z6+HnxAUZMClkKekZDvTSObSdZHqewVETSWlH1g
    nF4TYa/Z+FT7f11X5I95eQp/wVP1528jNX6C9M+x8tWagY20HqVJ4CW8o+CDIW1a
    5ONccizpQg7nZHaeGvZXdob4790N+kd6///0LAhAX0x8y6xo1mWYIhtHGTZ3A6CL
    5Ju0N66qpJCeMWQJlH3f1M0z34dNLgv9RY51jGvBUKHAwi+wdRg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeBKEk4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41648 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752708AbeBKEeF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:05 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Doug Berger" <opendmb@gmail.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.335181452@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 029/136] net: bcmgenet: enable loopback during UniMAC
 sw_reset
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

commit 28c2d1a7a0bfdf3617800d2beae1c67983c03d15 upstream.

It is necessary for the UniMAC to be clocked at least 5 cycles
while the sw_reset is asserted to ensure a clean reset.

It was discovered that this condition was not being met when
connected to an external RGMII PHY that disabled the Rx clock in
the Power Save state.

This commit modifies the reset_umac function to place the (RG)MII
interface into a local loopback mode where the Rx clock comes
from the GENET sourced Tx clk during the sw_reset to ensure the
presence and stability of the clock.

In addition, it turns out that the sw_reset of the UniMAC is not
self clearing, but this was masked by a bug in the timeout code.

The sw_reset is now explicitly cleared by zeroing the UMAC_CMD
register before returning from reset_umac which makes it no
longer necessary to do so in init_umac and makes the clearing of
CMD_TX_EN and CMD_RX_EN by umac_enable_set redundant. The
timeout code (and its associated bug) are removed so reset_umac
no longer needs to return a result, and that means init_umac
that calls reset_umac does not need to as well.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Update call to init_umac() in bcmgenet_wol_resume()
 - Drop changes in bcmgenet_resume()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1509,12 +1509,8 @@ static void bcmgenet_free_rx_buffers(str
 	}
 }
 
-static int reset_umac(struct bcmgenet_priv *priv)
+static void reset_umac(struct bcmgenet_priv *priv)
 {
-	struct device *kdev = &priv->pdev->dev;
-	unsigned int timeout = 0;
-	u32 reg;
-
 	/* 7358a0/7552a0: bad default in RBUF_FLUSH_CTRL.umac_sw_rst */
 	bcmgenet_rbuf_ctrl_set(priv, 0);
 	udelay(10);
@@ -1522,38 +1518,21 @@ static int reset_umac(struct bcmgenet_pr
 	/* disable MAC while updating its registers */
 	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
 
-	/* issue soft reset, wait for it to complete */
-	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
-	while (timeout++ < 1000) {
-		reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-		if (!(reg & CMD_SW_RESET))
-			return 0;
-
-		udelay(1);
-	}
-
-	if (timeout == 1000) {
-		dev_err(kdev,
-			"timeout waiting for MAC to come out of resetn\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	/* issue soft reset with (rg)mii loopback to ensure a stable rxclk */
+	bcmgenet_umac_writel(priv, CMD_SW_RESET | CMD_LCL_LOOP_EN, UMAC_CMD);
+	udelay(2);
+	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
 }
 
-static int init_umac(struct bcmgenet_priv *priv)
+static void init_umac(struct bcmgenet_priv *priv)
 {
 	struct device *kdev = &priv->pdev->dev;
-	int ret;
 	u32 reg, cpu_mask_clear;
 
 	dev_dbg(&priv->pdev->dev, "bcmgenet: init_umac\n");
 
-	ret = reset_umac(priv);
-	if (ret)
-		return ret;
+	reset_umac(priv);
 
-	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
 	/* clear tx/rx counter */
 	bcmgenet_umac_writel(priv,
 		MIB_RESET_RX | MIB_RESET_TX | MIB_RESET_RUNT, UMAC_MIB_CTRL);
@@ -1604,8 +1583,6 @@ static int init_umac(struct bcmgenet_pri
 
 	/* Enable rx/tx engine.*/
 	dev_dbg(kdev, "done init umac\n");
-
-	return 0;
 }
 
 /* Initialize all house-keeping variables for a TX ring, along
@@ -1994,14 +1971,10 @@ static void bcmgenet_set_hw_addr(struct
 
 static int bcmgenet_wol_resume(struct bcmgenet_priv *priv)
 {
-	int ret;
-
 	/* From WOL-enabled suspend, switch to regular clock */
 	clk_disable(priv->clk_wol);
 	/* init umac registers to synchronize s/w with h/w */
-	ret = init_umac(priv);
-	if (ret)
-		return ret;
+	init_umac(priv);
 
 	phy_init_hw(priv->phydev);
 	/* Speed settings must be restored */
@@ -2062,14 +2035,7 @@ static int bcmgenet_open(struct net_devi
 	/* take MAC out of reset */
 	bcmgenet_umac_reset(priv);
 
-	ret = init_umac(priv);
-	if (ret)
-		goto err_clk_disable;
-
-	/* disable ethernet MAC while updating its registers */
-	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-	reg &= ~(CMD_TX_EN | CMD_RX_EN);
-	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	init_umac(priv);
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
@@ -2603,9 +2569,7 @@ static int bcmgenet_probe(struct platfor
 	    !strcasecmp(phy_mode_str, "internal"))
 		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
 
-	err = reset_umac(priv);
-	if (err)
-		goto err_clk_disable;
+	reset_umac(priv);
 
 	err = bcmgenet_mii_init(dev);
 	if (err)
