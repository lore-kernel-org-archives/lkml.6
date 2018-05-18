Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeERQVo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:21:44 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:57265 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750957AbeERQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:21:41 -0400
From: Vlad Buslov <vladbu@mellanox.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, davem@davemloft.net, lucasb@mojatatu.com,
        jhs@mojatatu.com, mrv@mojatatu.com, linux-kernel@vger.kernel.org,
        Vlad Buslov <vladbu@mellanox.com>
Subject: [PATCH] tc-testing: flush gact actions on test teardown
Date: Fri, 18 May 2018 19:21:22 +0300
Message-Id: <1526660482-10424-1-git-send-email-vladbu@mellanox.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test 6fb4 creates one mirred and one pipe action, but only flushes mirred
on teardown. Leaking pipe action causes failures in other tests.

Add additional teardown command to also flush gact actions.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
---
 tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index 443c9b3..acb24f7 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -44,7 +44,8 @@
         "matchPattern": "action order [0-9]*: mirred \\(Egress Redirect to device lo\\).*index 2 ref",
         "matchCount": "1",
         "teardown": [
-            "$TC actions flush action mirred"
+            "$TC actions flush action mirred",
+            "$TC actions flush action gact"
         ]
     },
     {
-- 
2.7.5
