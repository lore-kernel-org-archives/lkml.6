Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF749C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8824820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8824820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbeHAOod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:44:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389226AbeHAOod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:44:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 120AC7DAC8;
        Wed,  1 Aug 2018 12:58:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85F3F1C65F;
        Wed,  1 Aug 2018 12:58:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 01/10] rxrpc: remove redundant variables 'sp' and
 'did_discard'
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 13:58:52 +0100
Message-ID: <153312833206.27702.8015718705514139851.stgit@warthog.procyon.org.uk>
In-Reply-To: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
References: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 12:58:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 12:58:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Variables 'sp' and 'did_discard' are being assigned,
but are never used, hence they are redundant and can be removed.

fix following warning:

net/rxrpc/call_event.c:165:25: warning: variable 'sp' set but not used [-Wunused-but-set-variable]
net/rxrpc/conn_client.c:1054:7: warning: variable 'did_discard' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/call_event.c  |    2 --
 net/rxrpc/conn_client.c |    2 --
 2 files changed, 4 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 20210418904b..8e7434e92097 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -162,7 +162,6 @@ static void rxrpc_congestion_timeout(struct rxrpc_call *call)
  */
 static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 {
-	struct rxrpc_skb_priv *sp;
 	struct sk_buff *skb;
 	unsigned long resend_at;
 	rxrpc_seq_t cursor, seq, top;
@@ -207,7 +206,6 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 
 		skb = call->rxtx_buffer[ix];
 		rxrpc_see_skb(skb, rxrpc_skb_tx_seen);
-		sp = rxrpc_skb(skb);
 
 		if (anno_type == RXRPC_TX_ANNO_UNACK) {
 			if (ktime_after(skb->tstamp, max_age)) {
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 5736f643c516..e4bfbd7e48a8 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -1051,7 +1051,6 @@ void rxrpc_discard_expired_client_conns(struct work_struct *work)
 		container_of(work, struct rxrpc_net, client_conn_reaper);
 	unsigned long expiry, conn_expires_at, now;
 	unsigned int nr_conns;
-	bool did_discard = false;
 
 	_enter("");
 
@@ -1113,7 +1112,6 @@ void rxrpc_discard_expired_client_conns(struct work_struct *work)
 	 * If someone re-sets the flag and re-gets the ref, that's fine.
 	 */
 	rxrpc_put_connection(conn);
-	did_discard = true;
 	nr_conns--;
 	goto next;
 

