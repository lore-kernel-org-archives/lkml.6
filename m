Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeDAUnB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753918AbeDAUm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:59 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/45] C++: Disable __same_type() for the moment
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:57 +0100
Message-ID: <152261537790.30503.11036840023392668385.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/compiler_types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9bba9a7..7858c827c100 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -263,7 +263,7 @@ struct ftrace_likely_data {
 
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
-# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
+# define __same_type(a, b) true // not in C++ __builtin_types_compatible_p(typeof(a), typeof(b))
 #endif
 
 /* Is this type a native word size -- useful for atomic operations */
