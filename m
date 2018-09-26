Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CDAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371F221527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371F221527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeI0DiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:38:12 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:38449 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeI0DiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:38:12 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 4171763;
        Wed, 26 Sep 2018 21:23:18 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id DB6F552;
        Wed, 26 Sep 2018 21:23:17 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     shuah@kernel.org, erosca@de.adit-jv.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [V3 PATCH 1/2] selftests: watchdog: Fix error message.
Date:   Wed, 26 Sep 2018 15:23:08 -0600
Message-Id: <1537996989-13092-2-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1537996989-13092-1-git-send-email-jerry.hoemann@hpe.com>
References: <1537996989-13092-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printf's say errno but print the string version of error.
Make consistent.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index 6e29087..8429186 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -103,7 +103,7 @@ int main(int argc, char *argv[])
 				printf("Last boot is caused by: %s.\n", (flags != 0) ?
 					"Watchdog" : "Power-On-Reset");
 			else
-				printf("WDIOC_GETBOOTSTATUS errno '%s'\n", strerror(errno));
+				printf("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
 			break;
 		case 'd':
 			flags = WDIOS_DISABLECARD;
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 			if (!ret)
 				printf("Watchdog card disabled.\n");
 			else
-				printf("WDIOS_DISABLECARD errno '%s'\n", strerror(errno));
+				printf("WDIOS_DISABLECARD error '%s'\n", strerror(errno));
 			break;
 		case 'e':
 			flags = WDIOS_ENABLECARD;
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])
 			if (!ret)
 				printf("Watchdog card enabled.\n");
 			else
-				printf("WDIOS_ENABLECARD errno '%s'\n", strerror(errno));
+				printf("WDIOS_ENABLECARD error '%s'\n", strerror(errno));
 			break;
 		case 'p':
 			ping_rate = strtoul(optarg, NULL, 0);
@@ -133,7 +133,7 @@ int main(int argc, char *argv[])
 			if (!ret)
 				printf("Watchdog timeout set to %u seconds.\n", flags);
 			else
-				printf("WDIOC_SETTIMEOUT errno '%s'\n", strerror(errno));
+				printf("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
 			break;
 		default:
 			usage(argv[0]);
-- 
1.8.3.1

