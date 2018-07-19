Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC704ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0202084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0202084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeGSFXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:23:17 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:42975 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727104AbeGSFXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:23:17 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id B6B67B7F3A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 23:42:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id g0lSfYsO8bXuJg0lSfgVAy; Wed, 18 Jul 2018 23:42:06 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=45286 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fg0lS-003aUu-6J; Wed, 18 Jul 2018 23:42:06 -0500
Date:   Wed, 18 Jul 2018 23:42:05 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390/ap_bus: replace PTR_RET with PTR_ERR_OR_ZERO
Message-ID: <20180719044205.GA24764@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fg0lS-003aUu-6J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:45286
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/s390/crypto/ap_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index c0a6723..bf27fc4 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -474,7 +474,7 @@ static int ap_poll_thread_start(void)
 		return 0;
 	mutex_lock(&ap_poll_thread_mutex);
 	ap_poll_kthread = kthread_run(ap_poll_thread, NULL, "appoll");
-	rc = PTR_RET(ap_poll_kthread);
+	rc = PTR_ERR_OR_ZERO(ap_poll_kthread);
 	if (rc)
 		ap_poll_kthread = NULL;
 	mutex_unlock(&ap_poll_thread_mutex);
@@ -1242,7 +1242,7 @@ static int __init ap_module_init(void)
 
 	/* Create /sys/devices/ap. */
 	ap_root_device = root_device_register("ap");
-	rc = PTR_RET(ap_root_device);
+	rc = PTR_ERR_OR_ZERO(ap_root_device);
 	if (rc)
 		goto out_bus;
 
-- 
2.7.4

