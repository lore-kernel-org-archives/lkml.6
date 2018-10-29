Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E75C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982D02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982D02084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbeJ2TDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:03:52 -0400
Received: from foss.arm.com ([217.140.101.70]:38160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbeJ2TDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:03:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1E951596;
        Mon, 29 Oct 2018 03:15:50 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3A183F6A8;
        Mon, 29 Oct 2018 03:15:49 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        joe@perches.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 1/2] efi/fdt: Indentation fix
Date:   Mon, 29 Oct 2018 10:15:41 +0000
Message-Id: <1540808142-33208-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540808142-33208-1-git-send-email-julien.thierry@arm.com>
References: <1540808142-33208-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Closing bracket seems to end a for statement when it is actually ending
the contained if. Add some brackets to have clear delimitation of each
scope.

No functional change/fix, just fix the indentation.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 8830fa6..8b6696e 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -372,7 +372,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 	tables = (efi_config_table_t *) sys_table->tables;
 	fdt = NULL;
 
-	for (i = 0; i < sys_table->nr_tables; i++)
+	for (i = 0; i < sys_table->nr_tables; i++) {
 		if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
 			fdt = (void *) tables[i].table;
 			if (fdt_check_header(fdt) != 0) {
@@ -381,7 +381,8 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 			}
 			*fdt_size = fdt_totalsize(fdt);
 			break;
-	 }
+		}
+	}
 
 	return fdt;
 }
-- 
1.9.1

