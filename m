Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9920C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641FD2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SPsLcnG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641FD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030661AbeFSTxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:53:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56644 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030504AbeFSTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:53:20 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 15:53:20 EDT
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5JJhbhT021336;
        Tue, 19 Jun 2018 14:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437418;
        bh=iG1a6hrZC1OZv9XhqmdvLFvpwbE9VvlZfH8NcaYKvK0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SPsLcnG39b4dq3PtfS0Xt177zKMjOoKOJHf/4s3MHZmk0izYDTcdE21nXD1533X3S
         WhGHD6MA9/Vcsy/Dc186uX7LziKIEg4NjRthd+GiFeEtbL8yqTtw1U/kAPqNaV5LUn
         QYv1fumXVfwHoh2G6U4ugbVqcqtFe6QUwOjyInlA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhbKU024508;
        Tue, 19 Jun 2018 14:43:37 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:43:37 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:43:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhblu017890;
        Tue, 19 Jun 2018 14:43:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/6] mailbox: ti-msgmgr: Get rid of unused structure members
Date:   Tue, 19 Jun 2018 14:43:32 -0500
Message-ID: <20180619194337.31522-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194337.31522-1-nm@ti.com>
References: <20180619194337.31522-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though q_proxies and q_slices do describe the hardware configuration,
they are not necessary for operation given that the values are
always default. Hence drop the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since RFC: None
RFC: https://patchwork.kernel.org/patch/10447665/

 drivers/mailbox/ti-msgmgr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 5d04738c3c8a..5fe6ce200264 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -42,8 +42,6 @@ struct ti_msgmgr_valid_queue_desc {
  * @queue_count:	Number of Queues
  * @max_message_size:	Message size in bytes
  * @max_messages:	Number of messages
- * @q_slices:		Number of queue engines
- * @q_proxies:		Number of queue proxies per page
  * @data_first_reg:	First data register for proxy data region
  * @data_last_reg:	Last data register for proxy data region
  * @tx_polled:		Do I need to use polled mechanism for tx
@@ -58,8 +56,6 @@ struct ti_msgmgr_desc {
 	u8 queue_count;
 	u8 max_message_size;
 	u8 max_messages;
-	u8 q_slices;
-	u8 q_proxies;
 	u8 data_first_reg;
 	u8 data_last_reg;
 	bool tx_polled;
@@ -494,8 +490,6 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.queue_count = 64,
 	.max_message_size = 64,
 	.max_messages = 128,
-	.q_slices = 1,
-	.q_proxies = 1,
 	.data_first_reg = 16,
 	.data_last_reg = 31,
 	.tx_polled = false,
-- 
2.15.1

