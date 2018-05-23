Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754497AbeEWHsW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:48:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:56854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754467AbeEWHr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:47:56 -0400
From: Petr Mladek <pmladek@suse.com>
To: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] livepatch: Remove not longer valid limitations from the documentation
Date: Wed, 23 May 2018 09:47:42 +0200
Message-Id: <20180523074742.20171-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Semantic changes are possible since the commit d83a7cb375eec21f04
("livepatch: change to a per-task consistency model").

Also data structures can be patched since the commit 439e7271dc2b63de37
("livepatch: introduce shadow variable API").

It is a high time we removed these limitations from the documentation.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
I have found this when working on v12 of the atomic replace. It looks
like a no-brainer and does not conflict with the patchset, so ... ;-)

 Documentation/livepatch/livepatch.txt | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 1ae2de758c08..2d7ed09dbd59 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -429,30 +429,6 @@ See Documentation/ABI/testing/sysfs-kernel-livepatch for more details.
 
 The current Livepatch implementation has several limitations:
 
-
-  + The patch must not change the semantic of the patched functions.
-
-    The current implementation guarantees only that either the old
-    or the new function is called. The functions are patched one
-    by one. It means that the patch must _not_ change the semantic
-    of the function.
-
-
-  + Data structures can not be patched.
-
-    There is no support to version data structures or anyhow migrate
-    one structure into another. Also the simple consistency model does
-    not allow to switch more functions atomically.
-
-    Once there is more complex consistency mode, it will be possible to
-    use some workarounds. For example, it will be possible to use a hole
-    for a new member because the data structure is aligned. Or it will
-    be possible to use an existing member for something else.
-
-    There are no plans to add more generic support for modified structures
-    at the moment.
-
-
   + Only functions that can be traced could be patched.
 
     Livepatch is based on the dynamic ftrace. In particular, functions
-- 
2.13.6
