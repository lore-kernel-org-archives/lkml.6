Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF921547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFF921547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbeIUHc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:32:29 -0400
Received: from mail.windriver.com ([147.11.1.11]:54747 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:32:29 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8L1jmFN010641
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 18:45:48 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Sep 2018 18:45:47 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 5/6] platform/x86: acerhdf: mark appropriate content with __init prefix
Date:   Thu, 20 Sep 2018 21:44:20 -0400
Message-ID: <20180921014421.30804-6-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180921014421.30804-1-paul.gortmaker@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three functions are only called from the probe code which is
already marked __init and hence these can be __init as well.

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/acerhdf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index eddcd8e94a88..5f579fcde315 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -619,7 +619,7 @@ static int str_starts_with(const char *str, const char *start)
 }
 
 /* check hardware */
-static int acerhdf_check_hardware(void)
+static int __init acerhdf_check_hardware(void)
 {
 	char const *vendor, *version, *product;
 	const struct bios_settings *bt = NULL;
@@ -695,7 +695,7 @@ static int acerhdf_check_hardware(void)
 	return 0;
 }
 
-static int acerhdf_register_platform(void)
+static int __init acerhdf_register_platform(void)
 {
 	int err = 0;
 
@@ -727,7 +727,7 @@ static void acerhdf_unregister_platform(void)
 	platform_driver_unregister(&acerhdf_driver);
 }
 
-static int acerhdf_register_thermal(void)
+static int __init acerhdf_register_thermal(void)
 {
 	cl_dev = thermal_cooling_device_register("acerhdf-fan", NULL,
 						 &acerhdf_cooling_ops);
-- 
2.15.0

