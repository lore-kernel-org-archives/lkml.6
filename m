Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7714C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5332563C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5332563C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeFYIvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:51:33 -0400
Received: from exmail.andestech.com ([59.124.169.137]:64480 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754539AbeFYIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:50:58 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5P8qc1N009403;
        Mon, 25 Jun 2018 16:52:38 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 25 Jun 2018
 16:49:55 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <hch@infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zongbox@gmail.com>
CC:     Zong Li <zong@andestech.com>, <greentime@andestech.com>
Subject: [PATCH v2 2/4] RISC-V: Select GENERIC_UCMPDI2 on RV32I
Date:   Mon, 25 Jun 2018 16:49:38 +0800
Message-ID: <e83cbb33e4b72fdef56bfe396131474040a194b7.1529915117.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529915117.git.zong@andestech.com>
References: <cover.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5P8qc1N009403
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit, it need to use __ucmpdi2, otherwise, it can't find the __ucmpdi2
symbol.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6debcc4afc72..3e683be9b7a8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -122,6 +122,7 @@ config ARCH_RV32I
 	select GENERIC_ASHLDI3
 	select GENERIC_ASHRDI3
 	select GENERIC_LSHRDI3
+	select GENERIC_UCMPDI2
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.16.1

