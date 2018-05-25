Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965372AbeEYJiR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:38:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55101 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965130AbeEYJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:38:16 -0400
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: linux-afs@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH] afs/server: Remove leftover variable
Date: Fri, 25 May 2018 11:38:01 +0200
Message-Id: <20180525093801.45661-1-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.15.1
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ret is set two times in afs_install_server() but never
dereferenced. It is a leftover of a rework of afs_install_server() by
commit d2ddc776a458 ("afs: Overhaul volume and server record caching and
fileserver rotation").

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 fs/afs/server.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index 3af4625e2f8c..b69a70362bd5 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -153,7 +153,7 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server;
 	struct rb_node **pp, *p;
-	int ret = -EEXIST, diff;
+	int diff;
 
 	_enter("%p", candidate);
 
@@ -198,7 +198,6 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 		hlist_add_head_rcu(&server->addr6_link, &net->fs_addresses6);
 
 	write_sequnlock(&net->fs_addr_lock);
-	ret = 0;
 
 exists:
 	afs_get_server(server);
-- 
2.15.1
