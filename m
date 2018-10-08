Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E5DC6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B3D206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B3D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJIGC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJIGC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:02:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 563473DE;
        Mon,  8 Oct 2018 22:48:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1337A60F86;
        Mon,  8 Oct 2018 22:48:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 09/10] rxrpc: Fix the rxrpc_tx_packet trace line
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:48:25 +0100
Message-ID: <153903890527.17944.3079291580025755626.stgit@warthog.procyon.org.uk>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 08 Oct 2018 22:48:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the rxrpc_tx_packet trace line by storing the where parameter.

Fixes: 4764c0da69dc ("rxrpc: Trace packet transmission")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/rxrpc.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 837393fa897b..573d5b901fb1 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -931,6 +931,7 @@ TRACE_EVENT(rxrpc_tx_packet,
 	    TP_fast_assign(
 		    __entry->call = call_id;
 		    memcpy(&__entry->whdr, whdr, sizeof(__entry->whdr));
+		    __entry->where = where;
 			   ),
 
 	    TP_printk("c=%08x %08x:%08x:%08x:%04x %08x %08x %02x %02x %s %s",

