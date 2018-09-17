Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B459ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72A02146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72A02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbeIREkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbeIREkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:21 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 67918C49;
        Mon, 17 Sep 2018 23:10:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 044/158] tc-testing: remove duplicate spaces in connmark match patterns
Date:   Tue, 18 Sep 2018 00:41:14 +0200
Message-Id: <20180917211713.241551269@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@mellanox.com>

[ Upstream commit 757a9a39d483ae415a712388c33d4042a98b751f ]

Match patterns for some connmark tests contain duplicate whitespace that is
not present in actual tc output. This causes tests to fail because they
can't match required action, even when it was successfully created.

Fixes: 1dad0f9ffff7 ("tc-testing: add connmark action tests")
Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json |   24 +++++-----
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/connmark.json
@@ -17,7 +17,7 @@
         "cmdUnderTest": "$TC actions add action connmark",
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 pipe",
+        "matchPattern": "action order [0-9]+: connmark zone 0 pipe",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -41,7 +41,7 @@
         "cmdUnderTest": "$TC actions add action connmark pass index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 1",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 pass.*index 1 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 pass.*index 1 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -65,7 +65,7 @@
         "cmdUnderTest": "$TC actions add action connmark drop index 100",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 100",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 drop.*index 100 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 drop.*index 100 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -89,7 +89,7 @@
         "cmdUnderTest": "$TC actions add action connmark pipe index 455",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 455",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 pipe.*index 455 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 pipe.*index 455 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -113,7 +113,7 @@
         "cmdUnderTest": "$TC actions add action connmark reclassify index 7",
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 reclassify.*index 7 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 reclassify.*index 7 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -137,7 +137,7 @@
         "cmdUnderTest": "$TC actions add action connmark continue index 17",
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 continue.*index 17 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 continue.*index 17 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -161,7 +161,7 @@
         "cmdUnderTest": "$TC actions add action connmark jump 10 index 17",
         "expExitCode": "0",
         "verifyCmd": "$TC actions list action connmark",
-        "matchPattern": "action order [0-9]+:  connmark zone 0 jump 10.*index 17 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 0 jump 10.*index 17 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -185,7 +185,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 100 pipe index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 1",
-        "matchPattern": "action order [0-9]+:  connmark zone 100 pipe.*index 1 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 100 pipe.*index 1 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -209,7 +209,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 65536 reclassify index 21",
         "expExitCode": "255",
         "verifyCmd": "$TC actions get action connmark index 1",
-        "matchPattern": "action order [0-9]+:  connmark zone 65536 reclassify.*index 21 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 65536 reclassify.*index 21 ref",
         "matchCount": "0",
         "teardown": [
             "$TC actions flush action connmark"
@@ -233,7 +233,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 655 unsupp_arg pass index 2",
         "expExitCode": "255",
         "verifyCmd": "$TC actions get action connmark index 2",
-        "matchPattern": "action order [0-9]+:  connmark zone 655 unsupp_arg pass.*index 2 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 655 unsupp_arg pass.*index 2 ref",
         "matchCount": "0",
         "teardown": [
             "$TC actions flush action connmark"
@@ -258,7 +258,7 @@
         "cmdUnderTest": "$TC actions replace action connmark zone 555 reclassify index 555",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 555",
-        "matchPattern": "action order [0-9]+:  connmark zone 555 reclassify.*index 555 ref",
+        "matchPattern": "action order [0-9]+: connmark zone 555 reclassify.*index 555 ref",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"
@@ -282,7 +282,7 @@
         "cmdUnderTest": "$TC actions add action connmark zone 555 pipe index 5 cookie aabbccddeeff112233445566778800a1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions get action connmark index 5",
-        "matchPattern": "action order [0-9]+:  connmark zone 555 pipe.*index 5 ref.*cookie aabbccddeeff112233445566778800a1",
+        "matchPattern": "action order [0-9]+: connmark zone 555 pipe.*index 5 ref.*cookie aabbccddeeff112233445566778800a1",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action connmark"


