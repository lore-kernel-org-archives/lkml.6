Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479673-2-14915487012136336741
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
    1523479672; b=sCqU9tRTsgL+JIZVZBSfNxIl911HPJEGLLXNKDOdcnC9Na5iEE
    wra9/P4arsnwUnWfhoQRWHcFeTe+7VBGw7yT5GjnWEo9vqP3xDcvrsOXqvoDe+OF
    UrXnecjVciwIf9quP0YfitXbIx62CyfhJxmwwMrg+GanyXZz1b3QrslgiePGyd/P
    Iu4Cc6rQPh3v2455M365qh/nsaz7huo6unHLzjD6k5G9BpidUzYJb+GB5gzaNAbY
    iyLkpn63DBIRIjDQenflmrLo+ADvrKGuKMTteJrHa1CiSfyjNao3ctTwuO9b7tfC
    dTPujjlXTA+6Fxep4Tk1iH405iU/Vjm9FxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479672; bh=F1TlwZOVyRbGsnzYrys92bjlj5x0rv
    /xIZOMqsZv8oE=; b=nS2wfvYUqH8pgxsYzZow9Lw+mjz1sFRHtAK2itR6/cFneY
    uzc8L7M97CwUQ+RcbxY66nEI2Hy9nFni2IUeX7CeNmiNGC+2iwlz46XRi3e6Ljg0
    50u83Md6mNrwN5v/gmZOipM9ixstLYXFmvbqF1vkSkWjU7UxPzT/x1WZt3G2Vcrw
    FW8zWt9legzXazwLUOCfNKVGDHFXpxsQyJoNpSnq+v6SUvsSJ6CDrkhvoKMFywvZ
    ZZovRHSw+AMGtMdwnUW9C0S9DB030K6+Uu5W3oNjautWAttYs1VdLHBlWD8YKNtH
    aIEu/e6aPyakh3slS+SVwG4TNlngfAEpzShbSyZA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfMr0PgsqSMVBbIU4tIUlMupqo3I7y8u8BBm9fMbI7UmfkyXZBkaLd2ANW9HEuH7rSoQaYWI3zF7xWf+KTBNjXSfdv5MoQbmXnSnCyL9jaosEf7HQz6B1
    0AVKV7jWUsScnIAwjlwCesxj1hFp8lX+0jO7rS2Bvx+1NtfbAg4FN9W6Bz7JifSkfgegTXAH5fcLBBSczp/zVan4Y6JX94WbjEVP20sehRq9r8r+ngT7R0fS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=5mpuRNi4AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=zHlpfFh8LsOBOOXGY8cA:9 a=QEXdDO2ut3YA:10 a=eHWn0xJZPbZ7L6UZR85b:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755731AbeDKSq0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbeDKSqU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 022/190] net: qca_spi: Fix alignment issues in rx path
Date: Wed, 11 Apr 2018 20:34:28 +0200
Message-Id: <20180411183551.414389676@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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
