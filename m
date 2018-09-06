Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C642206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C642206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeIFLHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:07:14 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:37528 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIFLHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:07:14 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55b90ca2953f-ff298; Thu, 06 Sep 2018 14:33:14 +0800 (CST)
X-RM-TRANSID: 2ee55b90ca2953f-ff298
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85b90ca29f33-d8aa4;
        Thu, 06 Sep 2018 14:33:14 +0800 (CST)
X-RM-TRANSID: 2ee85b90ca29f33-d8aa4
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: remove redundant put_device
Date:   Thu,  6 Sep 2018 14:33:10 +0800
Message-Id: <1536215590-400-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_unregister will put device, do not need to do it one more time

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5b47188..cfaa878 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -369,7 +369,6 @@ static void xenbus_cleanup_devices(const char *path, struct bus_type *bus)
 		bus_for_each_dev(bus, NULL, &info, cleanup_dev);
 		if (info.dev) {
 			device_unregister(&info.dev->dev);
-			put_device(&info.dev->dev);
 		}
 	} while (info.dev);
 }
-- 
1.9.1



