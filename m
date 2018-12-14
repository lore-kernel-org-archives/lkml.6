Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A879AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797292080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797292080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeLNIpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:45:40 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:53912 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeLNIpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:45:35 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2D8FB2E25779238F7AD9;
        Fri, 14 Dec 2018 16:45:33 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBE8jAdl022872;
        Fri, 14 Dec 2018 16:45:10 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018121416454883-16718670 ;
          Fri, 14 Dec 2018 16:45:48 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH 1/3]  misc/pvpanic: return 0 for empty body register function
Date:   Fri, 14 Dec 2018 17:06:49 +0800
Message-Id: <1544778411-121925-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-14 16:45:49,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-14 16:44:55,
        Serialize complete at 2018-12-14 16:44:55
X-MAIL: mse01.zte.com.cn wBE8jAdl022872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return 0 for empty body register function normally.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/pvpanic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 3150dc2..f84ed30 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -125,7 +125,7 @@ static void pvpanic_unregister_acpi_driver(void)
 #else
 static int pvpanic_register_acpi_driver(void)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static void pvpanic_unregister_acpi_driver(void) {}
-- 
1.8.3.1

