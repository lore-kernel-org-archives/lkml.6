Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A569C67870
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A952087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A952087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJLLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:31:06 -0400
Received: from foss.arm.com ([217.140.101.70]:46034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeJLLbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:31:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B9331684;
        Thu, 11 Oct 2018 21:00:42 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3B183F5B7;
        Thu, 11 Oct 2018 21:00:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, steve.capper@arm.com,
        catalin.marinas@arm.com, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: [PATCH V2 4/5] arm64/mm: Enable HugeTLB migration
Date:   Fri, 12 Oct 2018 09:29:58 +0530
Message-Id: <1539316799-6064-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let arm64 subscribe to generic HugeTLB page migration framework. Right now
this only works on the following PMD and PUD level HugeTLB page sizes with
various kernel base page size combinations.

       CONT PTE    PMD    CONT PMD    PUD
       --------    ---    --------    ---
4K:         NA     2M         NA      1G
16K:        NA    32M         NA
64K:        NA   512M         NA

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e9..e54350f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1305,6 +1305,10 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config ARCH_ENABLE_HUGEPAGE_MIGRATION
+	def_bool y
+	depends on HUGETLB_PAGE && MIGRATION
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
-- 
2.7.4

