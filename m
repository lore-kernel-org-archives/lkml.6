Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9003AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EAC21A00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Cb5vlbVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EAC21A00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeFUSWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:22:12 -0400
Received: from mout01.posteo.de ([185.67.36.65]:33710 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753970AbeFUSWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:22:11 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2157721061
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:22:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529605330; bh=XIJ7/DGcrdgXs+weGVNvAdE3wxvpIcu33iSqy0hG890=;
        h=From:To:Cc:Subject:Date:From;
        b=Cb5vlbVRgexsKLjnfwX052eXLSUZOPwYoK0907JpFnNfBY/ZTwJs6UH8Hnz3S0W0s
         xvnwCiSzxAxT8kXsiQTavqC/vkhQ+A9IM/voU+qWSFYa2hMHEVWAASrujnz4aXhXG7
         XTlGCaXQXeik5oqrFYbe0KHNdktXuEvupUQ7BdcPxeq3Hi0tmBEfKqA382yCaz9Yj5
         tjHw8DfWzvpUe9b33Dspn8anhwSLfKOFLJu/+qJ8cxdFLKXVdLxhQGEPLmcO7bbMLo
         pNRZYIHS63P3dfLE1v62sKPz+2pw8SP2F95p2dxozFp/CWc08+ZJO1qEMjqBufi4Ki
         n36JXUWTijbWg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41BVR53rm4z9rxQ;
        Thu, 21 Jun 2018 20:22:09 +0200 (CEST)
From:   Michael Straube <michael.straube@posteo.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@posteo.de>
Subject: [PATCH] staging: rtl8723bs: fix brace coding style issues
Date:   Thu, 21 Jun 2018 20:21:55 +0200
Message-Id: <20180621182155.27769-1-michael.straube@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single line if statements.
Also fix a comparsion to NULL in one of the conditions.
Issues found by checkpatch.

Signed-off-by: Michael Straube <michael.straube@posteo.de>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index f852fde47350..2244ed72ab9c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -618,9 +618,8 @@ ssize_t proc_set_wait_hiq_empty(struct file *file, const char __user *buffer, si
 	if (count < 1)
 		return -EFAULT;
 
-	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
+	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
 		sscanf(tmp, "%u", &g_wait_hiq_empty);
-	}
 
 	return count;
 }
@@ -1425,9 +1424,8 @@ int proc_get_btcoex_info(struct seq_file *m, void *v)
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 
 	pbuf = rtw_zmalloc(bufsize);
-	if (NULL == pbuf) {
+	if (!pbuf)
 		return -ENOMEM;
-	}
 
 	rtw_btcoex_DisplayBtCoexInfo(padapter, pbuf, bufsize);
 
-- 
2.17.1

