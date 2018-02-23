Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeBWVd7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:33:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751527AbeBWVd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:33:58 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: [PATCH v0 3/3] livepatch: update documentation for shadow variables
Date: Fri, 23 Feb 2018 16:33:50 -0500
Message-Id: <1519421630-12025-4-git-send-email-joe.lawrence@redhat.com>
In-Reply-To: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update livepatch shadow variable documentation with respect to new
atomic replace / cumulative patch functionality.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 Documentation/livepatch/shadow-vars.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/livepatch/shadow-vars.txt b/Documentation/livepatch/shadow-vars.txt
index 89c66634d600..9a2754cf551c 100644
--- a/Documentation/livepatch/shadow-vars.txt
+++ b/Documentation/livepatch/shadow-vars.txt
@@ -179,6 +179,30 @@ doesn't matter what data value the shadow variable holds, its existence
 suggests how to handle the parent object.
 
 
+Use in cumulative patches
+-------------------------
+
+Cumulative livepatches provide a "one-stop" module containing all active
+livepatch code.  A cumulative patch disables and replaces any previously
+loaded livepatch.  Shadow variable lifetimes should be carefully
+considered when loading cumulative livepatches:
+
+- If shadow variables lifetimes are specific to livepatch module
+  versions, it may make sense to free them when the corresponding
+  livepatch module is unloaded.
+
+- If shadow variable instances may be safely handled across cumulative
+  livepatch module versions, then it may make sense to free them from
+  unpatch callbacks.  When a cumulative patch replaces an existing
+  livepatch, only the cumulative patch's callbacks will be executed.
+  This means that new cumulative livepatches may be loaded while
+  deprecated / disabled livepatches may be unloaded without clearing
+  existing shadow variables.
+
+See Documentation/livepatch/callbacks.txt and cumulative.txt for more
+information on these subjects.
+
+
 3. References
 =============
 
-- 
1.8.3.1
