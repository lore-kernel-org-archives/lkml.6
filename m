Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477552-2-34274661984509397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477551; b=sPq80tcsE7P/SpEx2/TYN/Y/lOMxCYmswCJg9SvtA3KmcuAg+F
    zpowRQetarFiHeg6ojUW7GoCNPdiO2qk4nJd+yiys942S5lN2Y3fKmnfzuQmOTQB
    9gnQIKbz/Lm1cHmSc49zuZsWmzExHz2iU+tSkNX6vVXDUgi20jtSwq27kR9utrH0
    xZE+Gzhkc1o4sbNqL/eU+kQjrq6nXZHXzsXEbnPXBj0t6VClLoo2ogDiMAg+2rzR
    lDxuYv1TPvrmhLuQtYnSF9TR/y32NxZG/AtjwDe1BrUxTk0xhJ578Q56nFGqxosM
    HjTXsJnCVkxBNGSCmTSr4TjhShFcT5HM5UxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477551; bh=p/r5yTEZJ8cHKZ+kDqjVMXj+X/8dzE
    /OqvJR0kdb8yI=; b=AF3jBhuvxW2PQ57n4KvlXjgTgJ0SWMxKAM8yY4qkyxU8gd
    /AwV2xXU14hl4HjMFe8Q3UQbIYxdpIMlozSzF4sHj1UCrBozPOEyjVy6rvrtDog7
    7lfEiXT2QKJfPXc1s62cWWDi/qK1cKvmgudMS+e0bnb3kvB6/eAjvETwd5t502sV
    BkwHNQUp1nw0t4PR+l4IS+n8yRAdctb7/7yeVnuApmqyeJKbR5MlhWU7uiwL7qO0
    T1+UrEqgCsugBvGjaE2ucmr1v+6KzENIP+6fGi2jb+N6xCW3jEWZOlfPx+dada15
    oO7QuOl7UsA5sKgghYt2aRM34qmnRdrk46R8ofqg==
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
X-CM-Envelope: MS4wfI7wY/FGFRZiOwABZBVPfGP7gCLE3sE47YZOuUzOa5uX88W2Q1CsVbd7YDv46VmMQdBKZcmBuXl0Wtrg6PZ8JU1+p1agHFZAgny9I/BfkXeMUqrFMuPt
    vpe2YkWeleO5l7Q/GxyvK03iaba+qmrWd3ekqhDUz3A028yQj2NKhGiC4z5z4VrkyKsY8UZmMqNxOAs/ZtNt3ngwkG95yM5FD56ZEHfvcYKrLQKICFtRlhNK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=5mpuRNi4AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=zHlpfFh8LsOBOOXGY8cA:9 a=QEXdDO2ut3YA:10 a=eHWn0xJZPbZ7L6UZR85b:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbeDKSyI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeDKSyG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 030/310] net: qca_spi: Fix alignment issues in rx path
Date: Wed, 11 Apr 2018 20:32:49 +0200
Message-Id: <20180411183623.586481484@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>


[ Upstream commit 8d66c30b12ed3cb533696dea8b9a9eadd5da426a ]

The qca_spi driver causes alignment issues on ARM devices.
So fix this by using netdev_alloc_skb_ip_align().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/qca_spi.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -296,8 +296,9 @@ qcaspi_receive(struct qcaspi *qca)
 
 	/* Allocate rx SKB if we don't have one available. */
 	if (!qca->rx_skb) {
-		qca->rx_skb = netdev_alloc_skb(net_dev,
-					       net_dev->mtu + VLAN_ETH_HLEN);
+		qca->rx_skb = netdev_alloc_skb_ip_align(net_dev,
+							net_dev->mtu +
+							VLAN_ETH_HLEN);
 		if (!qca->rx_skb) {
 			netdev_dbg(net_dev, "out of RX resources\n");
 			qca->stats.out_of_mem++;
@@ -377,7 +378,7 @@ qcaspi_receive(struct qcaspi *qca)
 					qca->rx_skb, qca->rx_skb->dev);
 				qca->rx_skb->ip_summed = CHECKSUM_UNNECESSARY;
 				netif_rx_ni(qca->rx_skb);
-				qca->rx_skb = netdev_alloc_skb(net_dev,
+				qca->rx_skb = netdev_alloc_skb_ip_align(net_dev,
 					net_dev->mtu + VLAN_ETH_HLEN);
 				if (!qca->rx_skb) {
 					netdev_dbg(net_dev, "out of RX resources\n");
@@ -759,7 +760,8 @@ qcaspi_netdev_init(struct net_device *de
 	if (!qca->rx_buffer)
 		return -ENOBUFS;
 
-	qca->rx_skb = netdev_alloc_skb(dev, qca->net_dev->mtu + VLAN_ETH_HLEN);
+	qca->rx_skb = netdev_alloc_skb_ip_align(dev, qca->net_dev->mtu +
+						VLAN_ETH_HLEN);
 	if (!qca->rx_skb) {
 		kfree(qca->rx_buffer);
 		netdev_info(qca->net_dev, "Failed to allocate RX sk_buff.\n");
