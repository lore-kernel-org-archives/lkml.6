Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753086AbeC3VOq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:14:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753046AbeC3VOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:43 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 06/12] rxrpc: remove unused static variables
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:41 +0100
Message-ID: <152244448168.4629.14499901321174329420.stgit@warthog.procyon.org.uk>
In-Reply-To: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
References: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The rxrpc_security_methods and rxrpc_security_sem user has been removed
in 648af7fca159 ("rxrpc: Absorb the rxkad security module"). This was
noticed by kbuild test robot for the -RT tree but is also true for !RT.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/security.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index e9f428351293..c4479afe8ae7 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -19,9 +19,6 @@
 #include <keys/rxrpc-type.h>
 #include "ar-internal.h"
 
-static LIST_HEAD(rxrpc_security_methods);
-static DECLARE_RWSEM(rxrpc_security_sem);
-
 static const struct rxrpc_security *rxrpc_security_types[] = {
 	[RXRPC_SECURITY_NONE]	= &rxrpc_no_security,
 #ifdef CONFIG_RXKAD
