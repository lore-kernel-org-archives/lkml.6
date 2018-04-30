Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1992793-1525122316-2-7979337129131151432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525122314; b=bvMXjP+mJ0Gmh+CmR7vGyD4RsFPjwvhNJot/oxfiJpTU6JdtQi
    CeQvqN8GUhd7LBcq6nnph5P/xSsrBOkRMI+AGSoQD+SI7vrS4RyFq/NzYh1e6QU6
    MAHp7rJvBv+Z+3k/VkCKQt5KTlDJG07IibS1jKqI35dSvkllp74OHOiCCSa8tdc9
    T6fRdAq8gsCrTVUgMzZOJCoXkh2qILMCWelaEwx4eKxRQ77ee+IgBbmV5ZCDqCRU
    Bc71tqxmjbvWkpe/Nlsarc4+xYN3Uk5+nJefoUaRFAm7MDvKg7m8Gngtd/CgR3N7
    BnaU2Fe7NsC7AR++WH4dE6yR9/bm0XLnZiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:in-reply-to:references
    :content-type:content-transfer-encoding:sender:list-id; s=fm2;
    t=1525122314; bh=NxDS0KiIIQs75VxzJDwYU7+3hUK/v7rFgwburzVpQcc=; b=
    gb66lX9Cn4LO71/aj8yfkz8qC1mpm5qV1+xWJg96ee70oqZ4XDrReWSyHCj4Wzq3
    txsGTco+vGfCMnfjehtaCkJ4mO85KKt2uVFPf/E3Xh1g703y/z3c//iaYzzXKkwO
    VCh+adrctyGEoQqPHxJwhFr4LJWY02Pno8JeaXVN7qupan6aysrOJWfwrLc6mzo9
    2Eq8py8tauWYfJ67hdtmEAwSqBhQ7U00YSXhbMqRrY25bXtfJe+K/pVVs2KWFSHJ
    oaakmC1EgZb66tMQ4Rsh6hsaa/xKG8AD9Zh0H0MIfGle1Jmf809rrBasx/JHd5+x
    wZ5uu2e04a9/t0Q8MbdrJQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkHHxnJU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkHHxnJU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-95 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJIqLatTwGKyfpd+X+sj5wb0KdG7R5PI3kMnQ6sQqcmOoFG7RaRsQAfANnSTfHvF/qt5rw+zgw+7aecUBoXWQnN5qaT2mct0Wj1eTc1n47FCwa1lT7nB
    MzWcOvMsm1AK8TLZ7ZWY8AjHYChfsY+KcXckEbjME0WOb46VbBBkg4BuXI5CE3SbunG1Q0CfKogi0IheyiGhMYESkj5ONbvWJZJac77xFoyHxHZSji/0GgXf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=MM2ucqnZdJZwX4rvuC4A:9
    a=vX4FZJAdW6U-ZguH:21 a=Yz-KJel5R-Jjx0J2:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755379AbeD3VFD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:05:03 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45065 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755199AbeD3VDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:03:02 -0400
X-ME-Sender: <xms:hYTnWpg4G2fWPi1F_XRZ3IYYnnjThYtcdgkxLUM8V-NFoggKZROVWQ>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>, stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/6] xen-netfront: do not use data already exposed to backend
Date: Mon, 30 Apr 2018 23:01:47 +0200
Message-Id: <5fe0e5dad9d9868991cc9c94fb9729d38f7e5926.1525122026.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
In-Reply-To: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Backend may freely modify anything on shared page, so use data which was
supposed to be written there, instead of reading it back from the shared
page.

This is complementary to XSA155.

CC: stable@vger.kernel.org
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/net/xen-netfront.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index dc99763..934b8a4 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -458,7 +458,7 @@ static void xennet_tx_setup_grant(unsigned long gfn, unsigned int offset,
 	tx->flags = 0;
 
 	info->tx = tx;
-	info->size += tx->size;
+	info->size += len;
 }
 
 static struct xen_netif_tx_request *xennet_make_first_txreq(
@@ -574,7 +574,7 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int slots;
 	struct page *page;
 	unsigned int offset;
-	unsigned int len;
+	unsigned int len, this_len;
 	unsigned long flags;
 	struct netfront_queue *queue = NULL;
 	unsigned int num_queues = dev->real_num_tx_queues;
@@ -634,14 +634,15 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* First request for the linear area. */
+	this_len = min_t(unsigned int, XEN_PAGE_SIZE - offset, len);
 	first_tx = tx = xennet_make_first_txreq(queue, skb,
 						page, offset, len);
-	offset += tx->size;
+	offset += this_len;
 	if (offset == PAGE_SIZE) {
 		page++;
 		offset = 0;
 	}
-	len -= tx->size;
+	len -= this_len;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		/* local packet? */
-- 
git-series 0.9.1
