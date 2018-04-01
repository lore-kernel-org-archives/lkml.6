Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeDAUnK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753918AbeDAUnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:05 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/45] C++: Move ctx_state enum out of struct
 context_tracking
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:03 +0100
Message-ID: <152261538388.30503.9843594429504553190.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ctx_state enum out of struct context_tracking so that it isn't limited
in scope.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/context_tracking_state.h |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index f128dc3be0df..02a9efe0827e 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -5,6 +5,13 @@
 #include <linux/percpu.h>
 #include <linux/static_key.h>
 
+enum ctx_state {
+	CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
+	CONTEXT_KERNEL = 0,
+	CONTEXT_USER,
+	CONTEXT_GUEST,
+};
+
 struct context_tracking {
 	/*
 	 * When active is false, probes are unset in order
@@ -14,12 +21,7 @@ struct context_tracking {
 	 */
 	bool active;
 	int recursion;
-	enum ctx_state {
-		CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
-		CONTEXT_KERNEL = 0,
-		CONTEXT_USER,
-		CONTEXT_GUEST,
-	} state;
+	enum ctx_state state;
 };
 
 #ifdef CONFIG_CONTEXT_TRACKING
