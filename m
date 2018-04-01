Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeDAUn0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754147AbeDAUnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:23 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 31/45] C++: Avoid using 'compl' and 'and' as names
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:21 +0100
Message-ID: <152261540175.30503.3674118602569067854.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'compl' and 'and' are synonyms for operators, so avoid them.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/cpumask.h |    4 ++--
 include/linux/crypto.h  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index bf53d893ad02..73bee9ff6cb3 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -273,9 +273,9 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
  *
  * After the loop, cpu is >= nr_cpu_ids.
  */
-#define for_each_cpu_and(cpu, mask, and)				\
+#define for_each_cpu_and(cpu, mask, and_with)				\
 	for ((cpu) = -1;						\
-		(cpu) = cpumask_next_and((cpu), (mask), (and)),		\
+		(cpu) = cpumask_next_and((cpu), (mask), (and_with)),	\
 		(cpu) < nr_cpu_ids;)
 #endif /* SMP */
 
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 7e6e84cf6383..f8f95615ba69 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -1034,9 +1034,9 @@ static inline void ablkcipher_request_free(struct ablkcipher_request *req)
  */
 static inline void ablkcipher_request_set_callback(
 	struct ablkcipher_request *req,
-	u32 flags, crypto_completion_t compl, void *data)
+	u32 flags, crypto_completion_t c, void *data)
 {
-	req->base.complete = compl;
+	req->base.complete = c;
 	req->base.data = data;
 	req->base.flags = flags;
 }
