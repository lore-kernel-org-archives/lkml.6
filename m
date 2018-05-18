Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeERQbd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:31:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:58628 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750882AbeERQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:31:29 -0400
From: Vlad Buslov <vladbu@mellanox.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, davem@davemloft.net, lucasb@mojatatu.com,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, chrism@mellanox.com,
        linux-kernel@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>
Subject: [PATCH] tc-testing: fix ip address in u32 test
Date: Fri, 18 May 2018 19:31:06 +0300
Message-Id: <1526661066-11138-1-git-send-email-vladbu@mellanox.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix expected ip address to actually match configured ip address.
Fix test to expect single matched filter.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
---
 tools/testing/selftests/tc-testing/tc-tests/filters/tests.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json b/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
index 5fa02d8..99a5ffc 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
@@ -12,8 +12,8 @@
         "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 u32 match ip src 127.0.0.1/32 flowid 1:1 action ok",
         "expExitCode": "0",
         "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
-        "matchPattern": "match 7f000002/ffffffff at 12",
-        "matchCount": "0",
+        "matchPattern": "match 7f000001/ffffffff at 12",
+        "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
-- 
2.7.5
