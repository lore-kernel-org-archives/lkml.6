Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157608-2-6870569452188060077
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527157608; b=bsaGoxxSzBYLdpvWDFuLib7ef7oMH8nwV9Ez9fuPkUt3d/uCyk
    +ZuHMXPxpmnI5wwseyH6PNjmr2XSalpxDWunYCgc/Sz197d15G70koWJDUxiVVjW
    B9j5PGwu490pJsqGldQhV2aRyQBFvBGs0Nle3S6DeNOqloTrqekSsIaUDDi/NhOr
    UKShmRLyNb1/7PXniqEDqBFkz5d/CCsd6gNq2Nkh6mBY5lC/RhCUfCL8nmD8sQ+G
    +Uu7qZqpK74mgiQ8/zVuUMGre/bNdQrhyz+als3C4Z5uwo8Jlly0VaD0GRD7pcee
    XZ6BWvRYLHJx2Aky1AWZN6crfX/7d/42Uyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157608; bh=JQqKRAOxXgKyELPRD+wGZpXUpAA67h
    cf8eAvmopxPzA=; b=mkujfuY+qOthCpzY5BcQJin/lvxZVuoURHo4mPWfB/PxzR
    v1hxPYXJoYiR/p1n98M98s4Cy7MeZfdF63tE3GvuTi1izTEC6Zxk8x2ApsV0CxZQ
    XyckOldhbd+WX8g9Kpa9h5UW0kbR8KWR/KpfImREj590PQY2jUge6tC0mubfqpCC
    MZlW6Cf7c5IViO7WRec64lLIhsmYzTGgFRWVNJGyGYS7Ez8p5d7aFrxhha4TAUvf
    9Ai+ype/X5yqQmLsFOPP9/QanhY28R9g4iNESwTH/DUPffS9CtXuKv455b25ddKV
    +Mk3y+69qZjuYzHY8RhlVepLnZGwDXzTjR4yOG5g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ctOA5Wji x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ctOA5Wji x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHzJasvZtF/m4ZuH/ZLsEMksOmNJHrCNamm9uMX4y7eDPanGfy9kH/g+jj7A7r8iDS6TvYvXlJpxG4jyQjLoTs7ZQQO/DJo6CjBA/Ibq91J6jTueBZ22
    z2+toqajcY5VPyaBis4Lx5wU0bjWBGebuxsJL5BQhen8+J1tUdvjzbN1zDAF+fqF69XEVRwt5DsRv+woj6Jva22FmMaPK2MeWpHVcxYsQ1gDtuOKMBYW3AGX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=tQEnYGki-cvHqFAnU_wA:9
    a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031014AbeEXKB4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031003AbeEXKBr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <Ariel.Elior@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 031/161] qed: Fix possibility of list corruption during rmmod flows
Date: Thu, 24 May 2018 11:37:36 +0200
Message-Id: <20180524093022.068814571@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>

[ Upstream commit ffd2c0d12752a69e480366031ec7a7d723dd2510 ]

The ll2 flows of flushing the txq/rxq need to be synchronized with the
regular fp processing. Caused list corruption during load/unload stress
tests.

Fixes: 0a7fb11c23c0f ("qed: Add Light L2 support")
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -292,6 +292,7 @@ static void qed_ll2_txq_flush(struct qed
 	struct qed_ll2_tx_packet *p_pkt = NULL;
 	struct qed_ll2_info *p_ll2_conn;
 	struct qed_ll2_tx_queue *p_tx;
+	unsigned long flags = 0;
 	dma_addr_t tx_frag;
 
 	p_ll2_conn = qed_ll2_handle_sanity_inactive(p_hwfn, connection_handle);
@@ -300,6 +301,7 @@ static void qed_ll2_txq_flush(struct qed
 
 	p_tx = &p_ll2_conn->tx_queue;
 
+	spin_lock_irqsave(&p_tx->lock, flags);
 	while (!list_empty(&p_tx->active_descq)) {
 		p_pkt = list_first_entry(&p_tx->active_descq,
 					 struct qed_ll2_tx_packet, list_entry);
@@ -309,6 +311,7 @@ static void qed_ll2_txq_flush(struct qed
 		list_del(&p_pkt->list_entry);
 		b_last_packet = list_empty(&p_tx->active_descq);
 		list_add_tail(&p_pkt->list_entry, &p_tx->free_descq);
+		spin_unlock_irqrestore(&p_tx->lock, flags);
 		if (p_ll2_conn->input.conn_type == QED_LL2_TYPE_OOO) {
 			struct qed_ooo_buffer *p_buffer;
 
@@ -328,7 +331,9 @@ static void qed_ll2_txq_flush(struct qed
 						      b_last_frag,
 						      b_last_packet);
 		}
+		spin_lock_irqsave(&p_tx->lock, flags);
 	}
+	spin_unlock_irqrestore(&p_tx->lock, flags);
 }
 
 static int qed_ll2_txq_completion(struct qed_hwfn *p_hwfn, void *p_cookie)
@@ -556,6 +561,7 @@ static void qed_ll2_rxq_flush(struct qed
 	struct qed_ll2_info *p_ll2_conn = NULL;
 	struct qed_ll2_rx_packet *p_pkt = NULL;
 	struct qed_ll2_rx_queue *p_rx;
+	unsigned long flags = 0;
 
 	p_ll2_conn = qed_ll2_handle_sanity_inactive(p_hwfn, connection_handle);
 	if (!p_ll2_conn)
@@ -563,13 +569,14 @@ static void qed_ll2_rxq_flush(struct qed
 
 	p_rx = &p_ll2_conn->rx_queue;
 
+	spin_lock_irqsave(&p_rx->lock, flags);
 	while (!list_empty(&p_rx->active_descq)) {
 		p_pkt = list_first_entry(&p_rx->active_descq,
 					 struct qed_ll2_rx_packet, list_entry);
 		if (!p_pkt)
 			break;
-
 		list_move_tail(&p_pkt->list_entry, &p_rx->free_descq);
+		spin_unlock_irqrestore(&p_rx->lock, flags);
 
 		if (p_ll2_conn->input.conn_type == QED_LL2_TYPE_OOO) {
 			struct qed_ooo_buffer *p_buffer;
@@ -588,7 +595,9 @@ static void qed_ll2_rxq_flush(struct qed
 						      cookie,
 						      rx_buf_addr, b_last);
 		}
+		spin_lock_irqsave(&p_rx->lock, flags);
 	}
+	spin_unlock_irqrestore(&p_rx->lock, flags);
 }
 
 static u8 qed_ll2_convert_rx_parse_to_tx_flags(u16 parse_flags)
