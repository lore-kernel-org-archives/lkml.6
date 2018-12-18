Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD61FC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8207421849
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeLRIYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:24:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbeLRIYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:24:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F10D715AB;
        Tue, 18 Dec 2018 00:24:20 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6828E3F575;
        Tue, 18 Dec 2018 00:24:17 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: [RESEND PATCH V3 4/5] arm64/mm: Enable HugeTLB migration
Date:   Tue, 18 Dec 2018 13:54:09 +0530
Message-Id: <1545121450-1663-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
References: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
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

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Steve Capper <steve.capper@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab03..57d0c4bf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1359,6 +1359,10 @@ config SYSVIPC_COMPAT
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

