Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F49C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C824A208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAlTxUKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C824A208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756168AbeFSGqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:46:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38452 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755546AbeFSGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:44:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id b74-v6so9426125pfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4JA6eFkAcHnZdVX+KGJS4BsoGkUY10529cl+HxpjAI8=;
        b=CAlTxUKEW8gWmVi9b4La27J3km0ZG/CnGJyzaFuTN9MjJRuSQMpUjNGh7Q7aSFEPpC
         qB6OyHmF2gI23HUg6qsFgBQglrnzCsexaX27Kb+dkYtYHPX/a4scwQs4/zgiYpT9RaKb
         jcBRW4E5KytRIQf9l5jMdUeIXLbYktQkpjgzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4JA6eFkAcHnZdVX+KGJS4BsoGkUY10529cl+HxpjAI8=;
        b=ntPeeQF1/+1rwIg7Sskkk40uyIfUt6OtvHxr/3h/Eil7GD0P/sToZDOasobtPI9IcI
         owfp5rio0eHvekUTL2ZN0illkYdOAZRgTyHqOONe1pm0gMwe15Sr2umUKOYPj7RvkQG6
         NA3SpVcQe2hyHOZjdmjCKHAD4+fOdk2i5wHMEnZGB4BBezkF/TwCnVjH8/1sLkbtS6oX
         +l6er9ZV4WNhU+glUzwTTi7OMYz6ytfnF0FYPrO4g+vkeHERez/+gU4ZQT6BUfcns5f/
         5M/z/vU3XKIy/O6+fPAMPyI5cvs9+t+RWDYvFr1KVrIDUl1AlxKdojfgDUHb0TS86mwo
         hfpQ==
X-Gm-Message-State: APt69E0f8ftCyLYAPitdUAPzQEXNQBDj5MmUimq+bM8/bPZosGOm2oSo
        YSltMxSqhode+B4Fu0Q/RL23bg==
X-Google-Smtp-Source: ADUXVKK7BvKnYkVufTRFfz29lA8BsTAciEx+Y3kvIZ8ZkpWQvsOL2J0bue2fuEJ+UmB4MSMNg/mtjA==
X-Received: by 2002:a63:a44a:: with SMTP id c10-v6mr13488189pgp.198.1529390656084;
        Mon, 18 Jun 2018 23:44:16 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 67-v6sm33800825pfm.171.2018.06.18.23.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 23:44:15 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
Date:   Tue, 19 Jun 2018 15:44:23 +0900
Message-Id: <20180619064424.6642-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180619064424.6642-1-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since arm_enter_runtime_services() was modified to always create a virtual
mapping of UEFI memory map in the previous patch, it is now renamed to
efi_enter_virtual_mode() and called earlier before acpi_load_tables()
in acpi_early_init().

This will allow us to use UEFI memory map in acpi_os_ioremap() to create
mappings of ACPI tables using memory attributes described in UEFI memory
map.

See a relevant commit:
    arm64: acpi: fix alignment fault in accessing ACPI tables

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/firmware/efi/arm-runtime.c | 15 ++++++---------
 init/main.c                        |  3 +++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 30ac5c82051e..566ef0a9edb5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -106,46 +106,43 @@ static bool __init efi_virtmap_init(void)
  * non-early mapping of the UEFI system table and virtual mappings for all
  * EFI_MEMORY_RUNTIME regions.
  */
-static int __init arm_enable_runtime_services(void)
+void __init efi_enter_virtual_mode(void)
 {
 	u64 mapsize;
 
 	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
-		return 0;
+		return;
 	}
 
 	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
 
 	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
 		pr_err("Failed to remap EFI memory map\n");
-		return 0;
+		return;
 	}
 
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
-		return 0;
+		return;
 	}
 
 	if (efi_enabled(EFI_RUNTIME_SERVICES)) {
 		pr_info("EFI runtime services access via paravirt.\n");
-		return 0;
+		return;
 	}
 
 	pr_info("Remapping and enabling EFI services.\n");
 
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
-		return -ENOMEM;
+		return;
 	}
 
 	/* Set up runtime services function pointers */
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
-
-	return 0;
 }
-early_initcall(arm_enable_runtime_services);
 
 void efi_virtmap_load(void)
 {
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..532fc0d02353 100644
--- a/init/main.c
+++ b/init/main.c
@@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
 	debug_objects_mem_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
+	if (IS_ENABLED(CONFIG_EFI) &&
+	    (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
+		efi_enter_virtual_mode();
 	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
-- 
2.17.0

