Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6208C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7320894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz72uwF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD7320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbeGaWHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41935 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbeGaWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so9626053pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCQpqZYgVBKzGF52b6VgMfQgfSptljLztiekVmDl1Hg=;
        b=Iz72uwF0ENGNcYC1e5GdCTCtH8uzv9oycyqqIg+NXyqdSIDF2E+nqX+ctKHhUfnSEm
         Ipiti8VMZVAcvnQCnkSJ/e3q+SNHoUtxuX4uSe4qxPoyYZG9j7IylfFZrcQwnjH0N/kf
         SKKm/R3wkgAFlJ54O697LIBIWiEyzU77gUNxcgCjzkPx1GwLrCcrSb3n9TZKnCXWkC+K
         TE0+4Jrb10/MmzyE2ttS5kSkmPxRqcf3cPetnvCCrfP0Elak76LzumlGYlSKloqjBri0
         8F6mU53nMI/uyKo8iAAMpU2jTz/JPGmc0vIwV3QsmFXwsaAhla68zpCkyxb++s9lWUx6
         RzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCQpqZYgVBKzGF52b6VgMfQgfSptljLztiekVmDl1Hg=;
        b=o8OAPvTkG4gn2WupOuvLoD6czjMIE9GMGHU8lEiCTYbeGI35ocjIg87fdT7s1FTRzn
         mV0+7caDyzf/5Af4z746bvplOL8x0a0BaRb7C9p+z0kVSVnYbpCp+40zloBA2Ya/PR5f
         9RL3flh2wOLODKOCXtlq2u2RTaDHbhq55yldvEYQ/mf6p0QRjYxxCfQGa5INz1otPS5N
         nLvICecSDwRGoYl0lMxhzt1sR7HEzmW7rhPD9hnJmhCdfrbouikWVCp7xY2Mq5GJ7Gak
         /jU+p0QsM4s/IPA4qhYXOhiVAx9WL0oP6Ak2SdGULOJXdunhVyJxxANbmJTrxDlzlLVX
         Gx7w==
X-Gm-Message-State: AOUpUlHu2M1OAFZAVMuLWWLatXOBfpToGzb+bCKVItyJtnugzTr+Om7c
        yRsKEVpMGKO12L7zlBfOe2s=
X-Google-Smtp-Source: AAOMgpeP70Yy0DrweyLKGg+C/jZ+vFgHi+Oo7hU9k3MOlNjP/Td5KKSdGgbfmhr0wQc0d06trjf31A==
X-Received: by 2002:a63:4c56:: with SMTP id m22-v6mr21341786pgl.299.1533068723704;
        Tue, 31 Jul 2018 13:25:23 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:23 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 12/15] staging: gasket: apex: move driver-private defines out of apex.h
Date:   Tue, 31 Jul 2018 13:24:45 -0700
Message-Id: <20180731202448.229487-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

apex.h is supposed to contain kernel-userspace interface definitions,
but has a number of defines that are only used by apex_driver.c or are
not used at all.  Move driver implementation defines not shared with
userspace to the driver source.  Remove unused defines.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex.h        | 62 +---------------------------
 drivers/staging/gasket/apex_driver.c | 29 +++++++++++++
 2 files changed, 31 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/gasket/apex.h b/drivers/staging/gasket/apex.h
index d89cc2387b7d..3bbceffff5e4 100644
--- a/drivers/staging/gasket/apex.h
+++ b/drivers/staging/gasket/apex.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Apex kernel-userspace interface definition(s).
+ * Apex kernel-userspace interface definitions.
  *
  * Copyright (C) 2018 Google, Inc.
  */
@@ -8,66 +8,8 @@
 #define __APEX_H__
 
 #include <linux/ioctl.h>
-#include <linux/bitops.h>
 
-#include "gasket.h"
-
-/* Structural definitions/macros. */
-/* The number of PCI BARs. */
-#define APEX_NUM_BARS 3
-
-/* Size of a memory page in bytes, and the related number of bits to shift. */
-#define APEX_PAGE_SHIFT 12
-#define APEX_PAGE_SIZE BIT(APEX_PAGE_SHIFT)
-
-#define APEX_EXTENDED_SHIFT 63 /* Extended address bit position. */
-
-/*
- * Addresses are 2^3=8 bytes each. Page in second level page table holds
- * APEX_PAGE_SIZE/8 addresses.
- */
-#define APEX_ADDR_SHIFT 3
-#define APEX_LEVEL_SHIFT (APEX_PAGE_SHIFT - APEX_ADDR_SHIFT)
-#define APEX_LEVEL_SIZE BIT(APEX_LEVEL_SHIFT)
-
-#define APEX_PAGE_TABLE_MAX 65536
-#define APEX_SIMPLE_PAGE_MAX APEX_PAGE_TABLE_MAX
-#define APEX_EXTENDED_PAGE_MAX (APEX_PAGE_TABLE_MAX << APEX_LEVEL_SHIFT)
-
-/* Check reset 120 times */
-#define APEX_RESET_RETRY 120
-/* Wait 100 ms between checks. Total 12 sec wait maximum. */
-#define APEX_RESET_DELAY 100
-
-#define APEX_CHIP_INIT_DONE 2
-#define APEX_RESET_ACCEPTED 0
-
-enum apex_reset_types {
-	APEX_CHIP_REINIT_RESET = 3,
-};
-
-/* Interrupt defines */
-/* Gasket device interrupts enums must be dense (i.e., no empty slots). */
-enum apex_interrupt {
-	APEX_INTERRUPT_INSTR_QUEUE = 0,
-	APEX_INTERRUPT_INPUT_ACTV_QUEUE = 1,
-	APEX_INTERRUPT_PARAM_QUEUE = 2,
-	APEX_INTERRUPT_OUTPUT_ACTV_QUEUE = 3,
-	APEX_INTERRUPT_SC_HOST_0 = 4,
-	APEX_INTERRUPT_SC_HOST_1 = 5,
-	APEX_INTERRUPT_SC_HOST_2 = 6,
-	APEX_INTERRUPT_SC_HOST_3 = 7,
-	APEX_INTERRUPT_TOP_LEVEL_0 = 8,
-	APEX_INTERRUPT_TOP_LEVEL_1 = 9,
-	APEX_INTERRUPT_TOP_LEVEL_2 = 10,
-	APEX_INTERRUPT_TOP_LEVEL_3 = 11,
-	APEX_INTERRUPT_FATAL_ERR = 12,
-	APEX_INTERRUPT_COUNT = 13,
-};
-
-/*
- * Clock Gating ioctl.
- */
+/* Clock Gating ioctl. */
 struct apex_gate_clock_ioctl {
 	/* Enter or leave clock gated state. */
 	u64 enable;
diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index c0d3922e1d7c..dfbff47b4608 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -54,6 +54,17 @@
  */
 #define APEX_PAGE_TABLE_TOTAL_ENTRIES 8192
 
+#define APEX_EXTENDED_SHIFT 63 /* Extended address bit position. */
+
+enum apex_reset_types {
+	APEX_CHIP_REINIT_RESET = 3,
+};
+
+/* Check reset 120 times */
+#define APEX_RESET_RETRY 120
+/* Wait 100 ms between checks. Total 12 sec wait maximum. */
+#define APEX_RESET_DELAY 100
+
 /* Enumeration of the supported sysfs entries. */
 enum sysfs_attribute_type {
 	ATTR_KERNEL_HIB_PAGE_TABLE_SIZE,
@@ -133,6 +144,24 @@ static const struct gasket_mappable_region mappable_regions[NUM_REGIONS] = {
 static const struct gasket_mappable_region cm_mappable_regions[1] = { { 0x0,
 	APEX_CH_MEM_BYTES } };
 
+/* Gasket device interrupts enums must be dense (i.e., no empty slots). */
+enum apex_interrupt {
+	APEX_INTERRUPT_INSTR_QUEUE = 0,
+	APEX_INTERRUPT_INPUT_ACTV_QUEUE = 1,
+	APEX_INTERRUPT_PARAM_QUEUE = 2,
+	APEX_INTERRUPT_OUTPUT_ACTV_QUEUE = 3,
+	APEX_INTERRUPT_SC_HOST_0 = 4,
+	APEX_INTERRUPT_SC_HOST_1 = 5,
+	APEX_INTERRUPT_SC_HOST_2 = 6,
+	APEX_INTERRUPT_SC_HOST_3 = 7,
+	APEX_INTERRUPT_TOP_LEVEL_0 = 8,
+	APEX_INTERRUPT_TOP_LEVEL_1 = 9,
+	APEX_INTERRUPT_TOP_LEVEL_2 = 10,
+	APEX_INTERRUPT_TOP_LEVEL_3 = 11,
+	APEX_INTERRUPT_FATAL_ERR = 12,
+	APEX_INTERRUPT_COUNT = 13,
+};
+
 /* Interrupt descriptors for Apex */
 static struct gasket_interrupt_desc apex_interrupts[] = {
 	{
-- 
2.18.0.345.g5c9ce644c3-goog

