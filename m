Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D305F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D305F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeIDLRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:17:22 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:40624 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbeIDLRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:17:22 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 47B74BB209119C48FE01;
        Tue,  4 Sep 2018 14:53:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w846rRhK082051;
        Tue, 4 Sep 2018 14:53:27 +0800 (GMT-8)
        (envelope-from zhang.xianwei8@zte.com.cn)
Received: from localhost.localdomain ([10.75.9.60])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018090414533093-7105958 ;
          Tue, 4 Sep 2018 14:53:30 +0800 
From:   Zhang Xianwei <zhang.xianwei8@zte.com.cn>
To:     ike.pan@canonical.com, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn,
        zhang.xianwei8@zte.com.cn
Subject: [PATCH] platform/x86: ideapad-laptop: Use __func__ instead of read_ec_cmd in pr_err
Date:   Tue, 4 Sep 2018 15:08:19 +0800
Message-Id: <1536044899-10452-1-git-send-email-zhang.xianwei8@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-09-04 14:53:31,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-09-04 14:53:23,
        Serialize complete at 2018-09-04 14:53:23
X-MAIL: mse01.zte.com.cn w846rRhK082051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to the commit f1395edbcec8 ("platform/x86: ideapad-laptop: Use
__func__ instead of write_ec_cmd in pr_err"), prefer using '"%s...",
__func__' to using 'read_ec_cmd' in read_ec_data.

Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index d4f1259..f856d59 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -212,7 +212,7 @@ static int read_ec_data(acpi_handle handle, int cmd, unsigned long *data)
 			return 0;
 		}
 	}
-	pr_err("timeout in read_ec_cmd\n");
+	pr_err("timeout in %s\n", __func__);
 	return -1;
 }
 
-- 
2.9.5

