Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754358AbeDAUmO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754342AbeDAUmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:11 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/45] C++: Turn ktime_add/sub_ns() into inline template
 functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:09 +0100
Message-ID: <152261532989.30503.8240475094491126505.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn ktime ns arithmetic functions into template functions to handle the
nanosecond value type conversion correctly.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/ktime.h |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 5b9fddbaac41..d46a16f23ffc 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -58,13 +58,21 @@ static inline ktime_t ktime_set(const s64 secs, const unsigned long nsecs)
  * Add a ktime_t variable and a scalar nanosecond value.
  * res = kt + nsval:
  */
-#define ktime_add_ns(kt, nsval)		((kt) + (nsval))
+template <typename NSVAL>
+static inline ktime_t ktime_add_ns(ktime_t kt, NSVAL nsval)
+{
+	return kt + nsval;
+}
 
 /*
  * Subtract a scalar nanosecod from a ktime_t variable
  * res = kt - nsval:
  */
-#define ktime_sub_ns(kt, nsval)		((kt) - (nsval))
+template <typename NSVAL>
+static inline ktime_t ktime_sub_ns(ktime_t kt, NSVAL nsval)
+{
+	return kt - nsval;
+}
 
 /* convert a timespec to ktime_t format: */
 static inline ktime_t timespec_to_ktime(struct timespec ts)
