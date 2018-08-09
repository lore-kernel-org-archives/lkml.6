Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8664CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A0D21EA0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A0D21EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeHIRDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:03:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731227AbeHIRDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:03:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5EA13B14D9D6C;
        Thu,  9 Aug 2018 22:37:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Thu, 9 Aug 2018 22:37:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <linux@armlinux.org.uk>, <vladimir.murzin@arm.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm:pmsa-v8: remove some extra semicolon
Date:   Thu, 9 Aug 2018 22:26:10 +0800
Message-ID: <1533824770-35931-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some extra semicolon in pmsa-v8.c. So just remove them.
I detect the issue with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/mm/pmsa-v8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
index 617a83d..0d7d5fb 100644
--- a/arch/arm/mm/pmsa-v8.c
+++ b/arch/arm/mm/pmsa-v8.c
@@ -165,7 +165,7 @@ static int __init pmsav8_setup_ram(unsigned int number, phys_addr_t start,phys_a
 		return -EINVAL;
 
 	bar = start;
-	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
 
 	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED;
 	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
@@ -181,7 +181,7 @@ static int __init pmsav8_setup_io(unsigned int number, phys_addr_t start,phys_ad
 		return -EINVAL;
 
 	bar = start;
-	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
 
 	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN;
 	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN;
-- 
1.7.12.4

