Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeDAUn6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754042AbeDAUnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:53 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 36/45] C++: Fix kernfs_type() int->enum
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:51 +0100
Message-ID: <152261543174.30503.14502150262018803568.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernfs_type() to cast the integer derived from kn->flags to the return
type enum.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/kernfs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index ab25c8b6d9e3..1f06e9ddc930 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -271,7 +271,7 @@ struct kernfs_ops {
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
 {
-	return kn->flags & KERNFS_TYPE_MASK;
+	return (enum kernfs_node_type)(kn->flags & KERNFS_TYPE_MASK);
 }
 
 /**
