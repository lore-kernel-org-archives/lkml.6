Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeEJWpl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:45:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751634AbeEJWph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:45:37 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 3/5] rxrpc: Fix the min security level for kernel calls
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 23:45:35 +0100
Message-ID: <152599233556.26376.11688481680261849433.stgit@warthog.procyon.org.uk>
In-Reply-To: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
References: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the kernel call initiation to set the minimum security level for kernel
initiated calls (such as from kAFS) from the sockopt value.

Fixes: 19ffa01c9c45 ("rxrpc: Use structs to hold connection params and protocol info")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/af_rxrpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9a2c8e7c000e..2b463047dd7b 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -313,7 +313,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 	memset(&cp, 0, sizeof(cp));
 	cp.local		= rx->local;
 	cp.key			= key;
-	cp.security_level	= 0;
+	cp.security_level	= rx->min_sec_level;
 	cp.exclusive		= false;
 	cp.upgrade		= upgrade;
 	cp.service_id		= srx->srx_service;
