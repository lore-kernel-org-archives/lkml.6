Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeDAUkh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:40:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753999AbeDAUke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:40:34 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/45] Fix loop var in be32_to_cpu_array() and
 cpu_to_be32_array()
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:40:33 +0100
Message-ID: <152261523340.30503.9462301336245251828.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the loop variable in be32_to_cpu_array() and cpu_to_be32_array() to be
a size_t like the variable it's limited by to avoid signed-unsigned
comparison warnings.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/byteorder/generic.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index 451aaa0786ae..4e297a6376d3 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -173,7 +173,7 @@ static inline void be64_add_cpu(__be64 *var, u64 val)
 
 static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = cpu_to_be32(src[i]);
@@ -181,7 +181,7 @@ static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 
 static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = be32_to_cpu(src[i]);
