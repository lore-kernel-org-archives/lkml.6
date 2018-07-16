Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46571ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4CA2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c+9uqglu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4CA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGPSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:35:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41072 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPSe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:34:59 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6GI68Yb021283;
        Mon, 16 Jul 2018 13:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531764369;
        bh=+gNJH6tUyaRo/CVLGwkbmkO/awXG5iSGvov9zPDwJBc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=c+9uqgluaLuQfNumjulFEHnoGJO0gOKX0O1S/iEDcGcXKYyDe/fq1T35HuuUy+hVy
         /KT+g32b/cfvuDJEqYXe3sKM+oyRhhNrQID5roPSl9VivGT84wgxBf1QAXR8FrtC4i
         n3JiqXAV6zdlpYc3z1aS1qntK6s81l1vp/TO2B0k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI68LA018309;
        Mon, 16 Jul 2018 13:06:08 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 16
 Jul 2018 13:06:08 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 16 Jul 2018 13:06:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI68gJ019367;
        Mon, 16 Jul 2018 13:06:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 1/6] mailbox: ti-msgmgr: Get rid of unused structure members
Date:   Mon, 16 Jul 2018 13:06:02 -0500
Message-ID: <20180716180607.16526-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180716180607.16526-1-nm@ti.com>
References: <20180716180607.16526-1-nm@ti.com>
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

Changes since V1: None
V1: https://patchwork.kernel.org/patch/10475339/
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

