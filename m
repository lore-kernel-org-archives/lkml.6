Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1928C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B62A20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBIArb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:47:31 -0500
Received: from foss.arm.com ([217.140.101.70]:58576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfBIAra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:47:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594EF1596;
        Fri,  8 Feb 2019 16:47:30 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB2543F719;
        Fri,  8 Feb 2019 16:47:29 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Date:   Fri,  8 Feb 2019 18:47:16 -0600
Message-Id: <20190209004718.3292087-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190209004718.3292087-1-jeremy.linton@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Placeholder patch for upstream ACPICA commit]

Add just ACPI 6.3 changes associated with the arm64 SPE.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/acpi/actbl2.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c50ef7e6b942..4b58eb6cf64e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -623,7 +623,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
+/* 11: Generic Interrupt (ACPI 5.0 + 6.0 + 6.3 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -641,7 +641,8 @@ struct acpi_madt_generic_interrupt {
 	u64 gicr_base_address;
 	u64 arm_mpidr;
 	u8 efficiency_class;
-	u8 reserved2[3];
+	u8 reserved2;
+	u16 spe_overflow_interrupt;
 };
 
 /* Masks for Flags field above */
-- 
2.17.2

