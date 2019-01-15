Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A9EC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820E120651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfAONnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:43:47 -0500
Received: from foss.arm.com ([217.140.101.70]:50752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbfAONno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8F4BA78;
        Tue, 15 Jan 2019 05:43:43 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495D93F70D;
        Tue, 15 Jan 2019 05:43:42 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Hadar Gat <hadar.gat@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] crypto: ccree: remove legacy leftover
Date:   Tue, 15 Jan 2019 15:43:14 +0200
Message-Id: <20190115134318.28712-5-gilad@benyossef.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115134318.28712-1-gilad@benyossef.com>
References: <20190115134318.28712-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

Remove legacy code no longer in use.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index 5be7fd431b05..33dbf3e6d15d 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -111,13 +111,11 @@ struct cc_crypto_req {
  * @cc_base:	virt address of the CC registers
  * @irq:	device IRQ number
  * @irq_mask:	Interrupt mask shadow (1 for masked interrupts)
- * @fw_ver:	SeP loaded firmware version
  */
 struct cc_drvdata {
 	void __iomem *cc_base;
 	int irq;
 	u32 irq_mask;
-	u32 fw_ver;
 	struct completion hw_queue_avail; /* wait for HW queue availability */
 	struct platform_device *plat_dev;
 	cc_sram_addr_t mlli_sram_addr;
-- 
2.20.1

