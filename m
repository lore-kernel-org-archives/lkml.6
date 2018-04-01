Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbeDAUoJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754042AbeDAUoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:05 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 38/45] C++: mutex_trylock_recursive_enum() int->enum
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:03 +0100
Message-ID: <152261544366.30503.65430592511529554.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make mutex_trylock_recursive_enum() cast the int it derives to the enum
return type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/mutex.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index cb3bbed4e633..2bacc5065980 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -224,13 +224,14 @@ enum mutex_trylock_recursive_enum {
  *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
  *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
  */
-static inline /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
+static inline /* __deprecated */ __must_check
+enum mutex_trylock_recursive_enum
 mutex_trylock_recursive(struct mutex *lock)
 {
 	if (unlikely(__mutex_owner(lock) == current))
 		return MUTEX_TRYLOCK_RECURSIVE;
 
-	return mutex_trylock(lock);
+	return (enum mutex_trylock_recursive_enum)mutex_trylock(lock);
 }
 
 #endif /* __LINUX_MUTEX_H */
