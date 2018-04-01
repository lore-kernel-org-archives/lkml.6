Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754670AbeDAUob (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754471AbeDAUo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:28 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 42/45] C++: Hide C++ keywords
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:27 +0100
Message-ID: <152261546762.30503.9337930260734861018.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hide C++ keywords like new, delete, class and private.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/page-flags.h |    3 +++
 include/linux/types.h      |    6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 50c2b8786831..6705394b8f69 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -131,6 +131,9 @@ enum pageflags {
 
 	/* non-lru isolated movable page */
 	PG_isolated = PG_reclaim,
+
+	/* C++-ism */
+	PG__Private = PG_private,
 };
 
 #ifndef __GENERATING_BOUNDS_H
diff --git a/include/linux/types.h b/include/linux/types.h
index d233b12c7ebe..1554319a3ff2 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -11,6 +11,12 @@
 
 #ifndef __ASSEMBLY__
 
+#define class _Class
+#define new _New
+#define delete _Delete
+#define namespace _Namespace
+#define private _Private
+
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
