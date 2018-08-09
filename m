Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0447C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1B82238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJlGBJyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1B82238D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeHIWsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:48:32 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37782 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeHIWsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:48:32 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so8027594qtl.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ORVO1sY1pv0CMxe49HdF1cTGhoRkM5gs+82FwiY+v0o=;
        b=BJlGBJygVnBp+4LwDOX7x2WegtvBzmoOdGIQL4aVqQjdpmaJ/COctxAQMDdhs9vTXD
         +W3DmhQyViWq6K6xxY59wMoNS7r3WNYBW1gA65+KIQHsZpGECRpCNouHXcxHNPUye1TB
         bSO2m0yW3X7k0xYFXLJunTQHaORw1rdSA7vk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ORVO1sY1pv0CMxe49HdF1cTGhoRkM5gs+82FwiY+v0o=;
        b=Lj7Dsxrlkvq43Rvi+DFU3aRdQ9j5Ytp76jDDYflf4Pj7S76/QmETqOzjVGNnc9enLX
         f63PVl0qczNjGg9LUXXTIaza1BZ+Fg1fQXyz+Sb1df1nY3YaDJ34sM18CqzktlOyWJk2
         oHdLrS3VGLuSY3upsY70J1fmsuQ7qhSnWMc63dTcYKxchTs+kgapmi5uH58PNDfsk0uR
         arWVX5bZEFXWVgMfbsRxGwMeW7KDTDNLeSI34wYs96NHD3+eRUMrSh76qN4VgT1z3i9P
         /FSotyA937XzJ89qtmuAUXvPMyRtE8kUbhcVRnTV0lpIXQeC78Cxh2PPzMnEIfQT8Vit
         z2Sg==
X-Gm-Message-State: AOUpUlFeG5Gbkn0ShpEaDNcUD0MRqUxcv8yhe2ToRBzVBthgNwipfT9V
        THbq/SVkBWcDqUXqMWHoir24k6xj8YFG7w==
X-Google-Smtp-Source: AA+uWPwOMcjsRMlsla04hK/kc56Pg0LCYj/Vvaik0Z6CP6fi+lFusGILK6Scjxp5PZ1TpoUMSH7VWw==
X-Received: by 2002:ac8:2ef9:: with SMTP id i54-v6mr3766818qta.416.1533846123891;
        Thu, 09 Aug 2018 13:22:03 -0700 (PDT)
Received: from localhost.localdomain ([45.56.156.50])
        by smtp.gmail.com with ESMTPSA id c184-v6sm4452094qkd.43.2018.08.09.13.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:22:03 -0700 (PDT)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        shuah@kernel.org, tglx@linutronix.de,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        peterz@infradead.org, rafael.tinoco@linaro.org,
        gregkh@linuxfoundation.org
Subject: [PATCH v2] selftests: membarrier: fix test by checking supported commands
Date:   Thu,  9 Aug 2018 17:21:57 -0300
Message-Id: <20180809202157.21148-1-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <9edf8459-aea1-c59e-5d73-112e986777e1@kernel.org>
References: <9edf8459-aea1-c59e-5d73-112e986777e1@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes membarrier_test compatible with older kernels (LTS) by checking if
the membarrier features exist before running the tests.

Link: https://bugs.linaro.org/show_bug.cgi?id=3771
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc: <stable@vger.kernel.org> #v4.17
---
 .../selftests/membarrier/membarrier_test.c    | 71 +++++++++++--------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 6793f8ecc8e7..4dc263824bda 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -223,7 +223,7 @@ static int test_membarrier_global_expedited_success(void)
 	return 0;
 }
 
-static int test_membarrier(void)
+static int test_membarrier(int supported)
 {
 	int status;
 
@@ -236,21 +236,22 @@ static int test_membarrier(void)
 	status = test_membarrier_global_success();
 	if (status)
 		return status;
-	status = test_membarrier_private_expedited_fail();
-	if (status)
-		return status;
-	status = test_membarrier_register_private_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_private_expedited_success();
-	if (status)
-		return status;
-	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
-	if (status < 0) {
-		ksft_test_result_fail("sys_membarrier() failed\n");
-		return status;
+
+	/* commit 22e4ebb975822833b083533035233d128b30e98f added this feature */
+	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED) {
+		status = test_membarrier_private_expedited_fail();
+		if (status)
+			return status;
+		status = test_membarrier_register_private_expedited_success();
+		if (status)
+			return status;
+		status = test_membarrier_private_expedited_success();
+		if (status)
+			return status;
 	}
-	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
+
+	/* commit 70216e18e519a54a2f13569e8caff99a092a92d6 added this feature */
+	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
 		status = test_membarrier_private_expedited_sync_core_fail();
 		if (status)
 			return status;
@@ -261,23 +262,28 @@ static int test_membarrier(void)
 		if (status)
 			return status;
 	}
-	/*
-	 * It is valid to send a global membarrier from a non-registered
-	 * process.
-	 */
-	status = test_membarrier_global_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_register_global_expedited_success();
-	if (status)
-		return status;
-	status = test_membarrier_global_expedited_success();
-	if (status)
-		return status;
+
+	/* commit c5f58bd58f432be5d92df33c5458e0bcbee3aadf added this feature */
+	if (supported & MEMBARRIER_CMD_GLOBAL_EXPEDITED) {
+		/*
+		 * It is valid to send a global membarrier from a non-registered
+		 * process.
+		 */
+		status = test_membarrier_global_expedited_success();
+		if (status)
+			return status;
+		status = test_membarrier_register_global_expedited_success();
+		if (status)
+			return status;
+		status = test_membarrier_global_expedited_success();
+		if (status)
+			return status;
+	}
+
 	return 0;
 }
 
-static int test_membarrier_query(void)
+static int test_membarrier_query(int *supported)
 {
 	int flags = 0, ret;
 
@@ -297,16 +303,19 @@ static int test_membarrier_query(void)
 		ksft_exit_skip(
 			"sys_membarrier unsupported: CMD_GLOBAL not found.\n");
 
+	*supported = ret;
 	ksft_test_result_pass("sys_membarrier available\n");
 	return 0;
 }
 
 int main(int argc, char **argv)
 {
+	int supported;
+
 	ksft_print_header();
 
-	test_membarrier_query();
-	test_membarrier();
+	test_membarrier_query(&supported);
+	test_membarrier(supported);
 
 	return ksft_exit_pass();
 }
-- 
2.18.0

