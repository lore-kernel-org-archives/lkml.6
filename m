Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A5ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6943E2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6943E2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeJQQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:10:10 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:43285 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeJQQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:10:10 -0400
Received: from ubuntu-CJ.clients.t30.sncf.fr ([109.190.253.13])
        by mwinf5d23 with ME
        id oYFb1y00B0J6jfR03YFb6Q; Wed, 17 Oct 2018 10:15:37 +0200
X-ME-Helo: ubuntu-CJ.clients.t30.sncf.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Oct 2018 10:15:37 +0200
X-ME-IP: 109.190.253.13
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, quytelda@tamalin.org,
        straube.linux@gmail.com, mamtashukla555@gmail.com,
        baijiaju1990@gmail.com, arushisinghal19971997@gmail.com,
        natechancellor@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: rtl8723bs: Fix the return value in case of error in 'rtw_wx_read32()'
Date:   Wed, 17 Oct 2018 10:15:34 +0200
Message-Id: <20181017081534.2959-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We return 0 unconditionally in 'rtw_wx_read32()'.
However, 'ret' is set to some error codes in several error handling paths.

Return 'ret' instead to propagate the error code.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 28bfdbdc6e76..b8631baf128d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2289,7 +2289,7 @@ static int rtw_wx_read32(struct net_device *dev,
 exit:
 	kfree(ptmp);
 
-	return 0;
+	return ret;
 }
 
 static int rtw_wx_write32(struct net_device *dev,
-- 
2.17.1

