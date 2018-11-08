Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB0C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9330A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeKHTgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:36:50 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:49450 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726304AbeKHTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:36:50 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wA8A2FxE059684;
        Thu, 8 Nov 2018 18:02:15 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from app09.andestech.com (10.0.15.117) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 8 Nov 2018
 18:01:58 +0800
From:   Nylon Chen <nylon7@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <nylon7717@gmail.com>, Nylon Chen <nylon7@andestech.com>
Subject: [PATCH v2 1/2] nds32: Fix the items of hwcap_str ordering issue.
Date:   Thu, 8 Nov 2018 18:00:02 +0800
Message-ID: <20181108100002.2195-1-nylon7@andestech.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.117]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wA8A2FxE059684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwcap_str should be set in a correct order according to HWCAP_xx.
We also add the missing "fpu_dp" to it.

Signed-off-by: Nylon Chen <nylon7@andestech.com>
---
 arch/nds32/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 63a1a5ef5219..87683583f206 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -71,8 +71,9 @@ static const char *hwcap_str[] = {
 	"div",
 	"mac",
 	"l2c",
-	"dx_regs",
+	"fpu_dp",
 	"v2",
+	"dx_regs",
 	NULL,
 };
 
-- 
2.18.0

