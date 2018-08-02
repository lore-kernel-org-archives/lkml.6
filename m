Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5BC46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018C9208EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018C9208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeHBKDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:03:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730113AbeHBKDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:03:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9077F402242D;
        Thu,  2 Aug 2018 08:13:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9E7A2026D66;
        Thu,  2 Aug 2018 08:13:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next] rxrpc: Remove set but not used variable 'nowj'
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com
Date:   Thu, 02 Aug 2018 09:13:33 +0100
Message-ID: <153319761338.28801.14787677585388434259.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 02 Aug 2018 08:13:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 02 Aug 2018 08:13:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

net/rxrpc/proc.c: In function 'rxrpc_call_seq_show':
net/rxrpc/proc.c:66:29: warning:
 variable 'nowj' set but not used [-Wunused-but-set-variable]
  unsigned long timeout = 0, nowj;
                             ^

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/proc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 163d05df339d..9805e3b85c36 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -63,7 +63,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	struct rxrpc_peer *peer;
 	struct rxrpc_call *call;
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
-	unsigned long timeout = 0, nowj;
+	unsigned long timeout = 0;
 	rxrpc_seq_t tx_hard_ack, rx_hard_ack;
 	char lbuff[50], rbuff[50];
 
@@ -97,7 +97,6 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 
 	if (call->state != RXRPC_CALL_SERVER_PREALLOC) {
 		timeout = READ_ONCE(call->expect_rx_by);
-		nowj = jiffies;
 		timeout -= jiffies;
 	}
 

