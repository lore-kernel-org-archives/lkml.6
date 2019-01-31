Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD74218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfAaLV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:21:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfAaLVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:21:25 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90BED536742E149ACA3B;
        Thu, 31 Jan 2019 19:21:23 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 19:21:15 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <marc.zyngier@arm.com>
CC:     <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Fix probing for ITT_entry_size
Date:   Thu, 31 Jan 2019 11:19:43 +0000
Message-ID: <1548933583-12504-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to ARM IHI 0069C (ID070116), we should use GITS_TYPER's
bits [7:4] as ITT_entry_size.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 071b4cb..c848a7c 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -319,7 +319,7 @@
 #define GITS_TYPER_PLPIS		(1UL << 0)
 #define GITS_TYPER_VLPIS		(1UL << 1)
 #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
-#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
+#define GITS_TYPER_ITT_ENTRY_SIZE(r)	((((r) >> GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) & 0xf) + 1)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
-- 
1.8.3.1


