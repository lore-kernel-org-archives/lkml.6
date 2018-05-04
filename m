Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeEDKcK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:32:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:32:09 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH REPOST] rbtree: include rcu.h because we use it
Date: Fri,  4 May 2018 12:31:59 +0200
Message-Id: <20180504103159.19938-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c1adf20052d8 ("Introduce rb_replace_node_rcu()")
rbtree_augmented.h uses RCU related data structures but does not include
them. It works as long as gets somehow included before that and fails
otherwise.

Cc: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rbtree_augmented.h |    1 +
 include/linux/rbtree_latch.h     |    1 +
 2 files changed, 2 insertions(+)

--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -26,6 +26,7 @@
=20
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
+#include <linux/rcupdate.h>
=20
 /*
  * Please note - only struct rb_augment_callbacks and the prototypes for
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -35,6 +35,7 @@
=20
 #include <linux/rbtree.h>
 #include <linux/seqlock.h>
+#include <linux/rcupdate.h>
=20
 struct latch_tree_node {
 	struct rb_node node[2];
