Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522173925-2-16694749286079930684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173924; b=Bo9aYjWgtiSI+WoC1RXUfna4pcdFwiY0nGBw+NAxLTCsUBQ
    xZGiRM0X4t6yjS7GqoSugXIJ+Yx+SYnAP0BqrKgkKelkyYcD7hWd+l8FJrin4hW/
    FmRhLkitjhC5uDtHvj2FSI3Obdlpi5fJwuf6ouCtCHvSDbDty7RKw4KsXNVqVpeX
    R/R38A1KMJMAGUr2H6T9XNPi4f6B0VD3irZQfhYz23aq3dKdW8v3ft4KLylB/5S4
    SeL6+HUNyDSBQpUStxIod54x/qsRZOdVhaTKL9bz+TZ95aEiQDAaYsRUmUKkw0nP
    CzGidMdZN5XNaS9fDIVgO/23+QwVKLCJ8lEliKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173924; bh=J9U+0JHcUYT8gZ5H0+UaVzufdy
    J1wrf5XXaF/NClPbc=; b=U30WG9K/RZvX7MkCBFgq/5F6jt2WwDuwJDd59GJQw1
    C+3Eks+xFYVsu9eVBdme21wLGJw2BF3A/0Hc8U64aUtG7+wb2De8GZjJ60QZ5LVB
    8hBe68cSdJB7zC7EniFWm1fb5BQN7to7IhLJWLMSmuznXBN7i8/krycENmr61Z7I
    e5DXUw4EyePTLFZP0VC/JUt3708Cy+3+ajzSgtM1inqZgtBPaWPqKYPL8Gi8G3t8
    GBobMpyHvo+BwC5mnkVklFcICoVp/ZnlfjQvqxcoAvk+yu84l6zbr0/A9LL1Y4U1
    3oBzqcNpFUKbHcui9dYejG8vyRHK2GLsbS7RZJwS9ktg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI9W83jCBVM1uXfPqyynQzO45tOyXhGdLplV8EvcXexILnAGPO3kN/ARAnGARyEfgly+sqRNpW+zjNntvdf7xnyNsL3FgZJZ700zF7C57u2wYgP8fK4o
    Wo62tb60rcwaJHyciSoIdBQT/aDpUaj+EAu5uScFopuAkJ6s30QSzmin7TJlfD56tyMfu/Nrel9M4CSKs0w0wB5n2ENb1gbcq4zKE4KZR+n9fctku0TVJJBX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=nTPwkA1SAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=ell124Nj_k-FOHqzhwMA:9
    a=QEXdDO2ut3YA:10 a=Her_73y7XSQQkpQYGz2D:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeC0SFG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:05:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbeC0Q3o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andri Yngvason <andri.yngvason@marel.com>,
        Richard Weinberger <richard@nod.at>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.4 32/43] can: cc770: Fix queue stall & dropped RTR reply
Date: Tue, 27 Mar 2018 18:27:36 +0200
Message-Id: <20180327162718.214617074@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andri Yngvason <andri.yngvason@marel.com>

commit 746201235b3f876792099079f4c6fea941d76183 upstream.

While waiting for the TX object to send an RTR, an external message with a
matching id can overwrite the TX data. In this case we must call the rx
routine and then try transmitting the message that was overwritten again.

The queue was being stalled because the RX event did not generate an
interrupt to wake up the queue again and the TX event did not happen
because the TXRQST flag is reset by the chip when new data is received.

According to the CC770 datasheet the id of a message object should not be
changed while the MSGVAL bit is set. This has been fixed by resetting the
MSGVAL bit before modifying the object in the transmit function and setting
it after. It is not enough to set & reset CPUUPD.

It is important to keep the MSGVAL bit reset while the message object is
being modified. Otherwise, during RTR transmission, a frame with matching
id could trigger an rx-interrupt, which would cause a race condition
between the interrupt routine and the transmit function.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Tested-by: Richard Weinberger <richard@nod.at>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/cc770/cc770.c |   94 +++++++++++++++++++++++++++++-------------
 drivers/net/can/cc770/cc770.h |    2 
 2 files changed, 68 insertions(+), 28 deletions(-)

--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -390,37 +390,23 @@ static int cc770_get_berr_counter(const
 	return 0;
 }
 
-static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static void cc770_tx(struct net_device *dev, int mo)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
+	struct can_frame *cf = (struct can_frame *)priv->tx_skb->data;
 	u8 dlc, rtr;
 	u32 id;
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
-		return NETDEV_TX_OK;
-
-	if ((cc770_read_reg(priv,
-			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
-		netdev_err(dev, "TX register is still occupied!\n");
-		return NETDEV_TX_BUSY;
-	}
-
-	netif_stop_queue(dev);
-
 	dlc = cf->can_dlc;
 	id = cf->can_id;
-	if (cf->can_id & CAN_RTR_FLAG)
-		rtr = 0;
-	else
-		rtr = MSGCFG_DIR;
+	rtr = cf->can_id & CAN_RTR_FLAG ? 0 : MSGCFG_DIR;
+
+	cc770_write_reg(priv, msgobj[mo].ctrl0,
+			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
 			RMTPND_RES | TXRQST_RES | CPUUPD_SET | NEWDAT_RES);
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_SET | TXIE_SET | RXIE_RES | INTPND_RES);
+
 	if (id & CAN_EFF_FLAG) {
 		id &= CAN_EFF_MASK;
 		cc770_write_reg(priv, msgobj[mo].config,
@@ -439,13 +425,30 @@ static netdev_tx_t cc770_start_xmit(stru
 	for (i = 0; i < dlc; i++)
 		cc770_write_reg(priv, msgobj[mo].data[i], cf->data[i]);
 
-	/* Store echo skb before starting the transfer */
-	can_put_echo_skb(skb, dev, 0);
-
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
-			RMTPND_RES | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+			RMTPND_UNC | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+	cc770_write_reg(priv, msgobj[mo].ctrl0,
+			MSGVAL_SET | TXIE_SET | RXIE_SET | INTPND_UNC);
+}
+
+static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct cc770_priv *priv = netdev_priv(dev);
+	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_OK;
+
+	netif_stop_queue(dev);
+
+	if ((cc770_read_reg(priv,
+			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
+		netdev_err(dev, "TX register is still occupied!\n");
+		return NETDEV_TX_BUSY;
+	}
 
-	stats->tx_bytes += dlc;
+	priv->tx_skb = skb;
+	cc770_tx(dev, mo);
 
 	return NETDEV_TX_OK;
 }
@@ -671,13 +674,47 @@ static void cc770_tx_interrupt(struct ne
 	struct cc770_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	unsigned int mo = obj2msgobj(o);
+	struct can_frame *cf;
+	u8 ctrl1;
+
+	ctrl1 = cc770_read_reg(priv, msgobj[mo].ctrl1);
 
-	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
+	cc770_write_reg(priv, msgobj[mo].ctrl1,
+			RMTPND_RES | TXRQST_RES | MSGLST_RES | NEWDAT_RES);
 
-	stats->tx_packets++;
+	if (unlikely(!priv->tx_skb)) {
+		netdev_err(dev, "missing tx skb in tx interrupt\n");
+		return;
+	}
+
+	if (unlikely(ctrl1 & MSGLST_SET)) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+	}
+
+	/* When the CC770 is sending an RTR message and it receives a regular
+	 * message that matches the id of the RTR message, it will overwrite the
+	 * outgoing message in the TX register. When this happens we must
+	 * process the received message and try to transmit the outgoing skb
+	 * again.
+	 */
+	if (unlikely(ctrl1 & NEWDAT_SET)) {
+		cc770_rx(dev, mo, ctrl1);
+		cc770_tx(dev, mo);
+		return;
+	}
+
+	can_put_echo_skb(priv->tx_skb, dev, 0);
 	can_get_echo_skb(dev, 0);
+
+	cf = (struct can_frame *)priv->tx_skb->data;
+	stats->tx_bytes += cf->can_dlc;
+	stats->tx_packets++;
+
+	priv->tx_skb = NULL;
+
 	netif_wake_queue(dev);
 }
 
@@ -789,6 +826,7 @@ struct net_device *alloc_cc770dev(int si
 	priv->can.do_set_bittiming = cc770_set_bittiming;
 	priv->can.do_set_mode = cc770_set_mode;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
+	priv->tx_skb = NULL;
 
 	memcpy(priv->obj_flags, cc770_obj_flags, sizeof(cc770_obj_flags));
 
--- a/drivers/net/can/cc770/cc770.h
+++ b/drivers/net/can/cc770/cc770.h
@@ -193,6 +193,8 @@ struct cc770_priv {
 	u8 cpu_interface;	/* CPU interface register */
 	u8 clkout;		/* Clock out register */
 	u8 bus_config;		/* Bus conffiguration register */
+
+	struct sk_buff *tx_skb;
 };
 
 struct net_device *alloc_cc770dev(int sizeof_priv);
