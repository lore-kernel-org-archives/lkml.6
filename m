Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4440C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789F525635
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789F525635
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754709AbeFYIvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:51:00 -0400
Received: from exmail.andestech.com ([59.124.169.137]:29052 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754253AbeFYIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:50:58 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5P8qXv9009388;
        Mon, 25 Jun 2018 16:52:33 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 25 Jun 2018
 16:49:50 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <hch@infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zongbox@gmail.com>
CC:     Zong Li <zong@andestech.com>, <greentime@andestech.com>
Subject: [PATCH v2 1/4] RISC-V: Add conditional macro for zone of DMA32
Date:   Mon, 25 Jun 2018 16:49:37 +0800
Message-ID: <3d8fcfce1e99fe1f07c11b535319164ee2511c02.1529915117.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529915117.git.zong@andestech.com>
References: <cover.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5P8qXv9009388
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA32 is for 64-bit usage.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c77df8142be2..58a522f9bcc3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,7 +28,9 @@ static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
 
+#ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
+#endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
 	free_area_init_nodes(max_zone_pfns);
-- 
2.16.1

