Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D574720869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 04:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeLTE5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 23:57:15 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:39832 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbeLTE5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 23:57:14 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4707AE3ED86D41C13016;
        Thu, 20 Dec 2018 12:57:12 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBK4v6Ha022265;
        Thu, 20 Dec 2018 12:57:06 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122012573478-17743685 ;
          Thu, 20 Dec 2018 12:57:34 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH RESEND V5 1/3]  misc/pvpanic: return 0 for empty body register function
Date:   Thu, 20 Dec 2018 13:14:46 +0800
Message-Id: <1545282888-38059-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-20 12:57:34,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-20 12:56:54,
        Serialize complete at 2018-12-20 12:56:54
X-MAIL: mse01.zte.com.cn wBK4v6Ha022265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return 0 for empty body register function normally.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
v4 --> v5 : resolve kbuild issue: handle all typo "drvier/driver" 
            in funtion name. 

v3 --> v4 : use pcim* function instead of pci* function.
            handle typo "drvier/driver" in funtion name. 

v2 --> v3 : resolve kbuild issue : a uninitialized variable in some path.

v2 --> v1 : resolve kbuild issue : arch=sh don't support pci, adjust
            CONFIG_PCI macro. 

v1 : QEMU community requires additional PCI devices to simulate PVPANIC devices
so that some architectures can not occupy precious less than 4G of memory 
space.

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

