Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D233C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D4A2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXkaI2hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394704AbfBOMfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:35:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52742 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393807AbfBOMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:35:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so9790839wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSWVPDeW6Y6e3BJiwHPZzYiuddTe78aLBSeVRNBTdIU=;
        b=bXkaI2hDvhnNO685cjXMTl9TOoxG4WUy+qHiluxj0OGFHJq+7rZipSimJ7jrNtSG9r
         Sl7PaCtHqWSF0uuHMb+zLktaPsApxMDuRiyTgRBPEQ2JQTlEMA6vyJ+tkUCJ/A5i10MM
         tM5bx4tfQmIav9aLtYitKhxHeHMAyLc+YMqLMZ6uBxZQhFLeKA0qTjt7zwlQ03EJo+S3
         vNSAA7ND7GdHMBM9pwtxcrYAj6npI9roSiQfpZTDeN4gvOAWLlR08BRoZfsuX1uZZ0Ac
         5lk21fnOa7cUT31Zf27u1xdYwmGHhbkcdo0CMxCZDOa7vvkMN9WtHXan07LC+jyo/QRu
         9JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSWVPDeW6Y6e3BJiwHPZzYiuddTe78aLBSeVRNBTdIU=;
        b=L1CM3d59mY+YFH5rlZn4eaw/zoudjqfTZ1MdknQRIGJJBKsYR+fL+3Yy3RyJUefuHG
         cvHIbt/m75Nv20F8BhNStK9k5UdEKXwgNJKFztFI3isM1vnS0WhSmhmDkEWh0aCpMGvj
         uCvwUkW28zvCskfOcTV0RIBNhPecADHwYQjyY8D3sidd22ys8LDnfHpzFvDQmxdwjFcs
         9hUw5j0eN5AxSPmpDLqdvFx+AhkVD+vxhbbQQ0vWABDSsceEWoGiYx7UIUGnA4oaYDte
         kkJ3jEeNVnnuYqGEEA+K4fZu8/A3tgqsXYKhANxCUK8VevQyyFJKunqQDrVrCdMpdquJ
         W2Pw==
X-Gm-Message-State: AHQUAubiLKhBxJdpKliFpDjPZqo/Zmg2PW9e+lhLBhmI7XS8ZNKkMYk4
        cXOXyiGslvqNWwKjghR3a/gIeg==
X-Google-Smtp-Source: AHgI3IYHeM5q4fTg1ijZObcvzdP+a1hAOUuVxDEYHVDh71jsZw6sHk+Q6qDMIcppMc4arEzfw05/jw==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr6412702wmc.38.1550234112073;
        Fri, 15 Feb 2019 04:35:12 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y13sm636673wrw.31.2019.02.15.04.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 04:35:10 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/2] efi/arm: Revert "Defer persistent reservations until after paging_init()"
Date:   Fri, 15 Feb 2019 13:33:33 +0100
Message-Id: <20190215123333.21209-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
References: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit eff896288872d687d9662000ec9ae11b6d61766f, which
deferred the processing of persistent memory reservations to a point
where the memory may have already been allocated and overwritten,
defeating the purpose.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/setup.c               | 1 -
 drivers/firmware/efi/efi.c              | 4 ----
 drivers/firmware/efi/libstub/arm-stub.c | 3 ---
 include/linux/efi.h                     | 7 -------
 4 files changed, 15 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e1231625c..d09ec76f08cf 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,7 +313,6 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
-	efi_apply_persistent_mem_reservations();
 
 	acpi_table_upgrade();
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..55b77c576c42 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -592,11 +592,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
-	return 0;
-}
 
-int __init efi_apply_persistent_mem_reservations(void)
-{
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index eee42d5e25ee..c037c6c5d0b7 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -75,9 +75,6 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
-	if (IS_ENABLED(CONFIG_ARM))
-		return;
-
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..28604a8d0aa9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1198,8 +1198,6 @@ static inline bool efi_enabled(int feature)
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
 
 extern bool efi_is_table_address(unsigned long phys_addr);
-
-extern int efi_apply_persistent_mem_reservations(void);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1218,11 +1216,6 @@ static inline bool efi_is_table_address(unsigned long phys_addr)
 {
 	return false;
 }
-
-static inline int efi_apply_persistent_mem_reservations(void)
-{
-	return 0;
-}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
-- 
2.20.1

