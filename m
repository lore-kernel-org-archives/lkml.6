Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CA3ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA012154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA012154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbeIUHc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:32:58 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53988 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389064AbeIUHc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:32:58 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8L1j5QU030705
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 18:45:47 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Sep 2018 18:45:41 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 4/6] platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307
Date:   Thu, 20 Sep 2018 21:44:19 -0400
Message-ID: <20180921014421.30804-5-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180921014421.30804-1-paul.gortmaker@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix:

  acerhdf: unknown (unsupported) BIOS version Gateway  /LT31   /v1.3307 , please report, aborting!

As can be seen in the context, the BIOS registers haven't changed in
the previous versions, so the assumption is they won't have changed
in this last update for this somewhat older platform either.

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/acerhdf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index fef3b727bc24..eddcd8e94a88 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -236,6 +236,7 @@ static const struct bios_settings bios_tbl[] = {
 	{"Gateway", "LT31",   "v1.3201",  0x55, 0x58, {0x9e, 0x00}, 0},
 	{"Gateway", "LT31",   "v1.3302",  0x55, 0x58, {0x9e, 0x00}, 0},
 	{"Gateway", "LT31",   "v1.3303t", 0x55, 0x58, {0x9e, 0x00}, 0},
+	{"Gateway", "LT31",   "v1.3307",  0x55, 0x58, {0x9e, 0x00}, 0},
 	/* Packard Bell */
 	{"Packard Bell", "DOA150",  "v0.3104",  0x55, 0x58, {0x21, 0x00}, 0},
 	{"Packard Bell", "DOA150",  "v0.3105",  0x55, 0x58, {0x20, 0x00}, 0},
-- 
2.15.0

