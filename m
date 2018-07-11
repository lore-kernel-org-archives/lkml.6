Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF672083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAIjelsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF672083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbeGKJo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40341 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732649AbeGKJo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so1821984wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6onjEFl2BD59yiPdC7EvEbLejow6UKfjhclEvp4LkA=;
        b=FAIjelsbktZKTdXOlDgXx8BIdZLA3mpzvc/qBvRBbuHHBgjgSpxQWUxUCdtKCeoo90
         9EKDY2skViyPH/ng/v1zuQDPGWw4qJluEZl/JY9pAJmpQ3bxcnrTADN+o/5TNkPCTPZq
         Hh2KJ5KsyyBdSiZ2oKe3DPaG8UdGaerdscnN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6onjEFl2BD59yiPdC7EvEbLejow6UKfjhclEvp4LkA=;
        b=kwGS9ddl1Hl4ZW9vgz1AGMNZ6zx5EG2Ph5jNYxiIe0uYOyMYCJBmlGZeUgfHvVfh6M
         xX4hAyKKNHeWIMrCJhdOjjrlTPGfyUIzSZEtSA0Z4hEjfWuP5nUUS3dGm2LHFiie/9Ul
         EmLboymqZ+n8UTXc81g/DLJNpuO8bDBK8y7fskyZ2rqo4Sz4DW10No2SABauN7OQYih3
         ttPAe/wytvW736wyqr98AKsmCZBiW8HAKt7RyBojdMRFV+cuC4rvPEykMYFzLjza+chN
         yc3gxd5/wu7wf5U18Z/iFybCdszZkD/NY+Fhxv0PjJwX8jbmn6sznBbaiQyWgaBa267i
         MQaA==
X-Gm-Message-State: APt69E3IrTNh+HGX6DUlGeLn/IbHWp1nVjmcywkhZCpHGg+t7FtumRwM
        8+6Uueyn/KKRYwaO7K1m3o/rEFWkyYE=
X-Google-Smtp-Source: AAOMgpeJHwSUIaVGlIyIW/2N5qO8CA5Vpvp7uZdrYbniZgnqU+VVDEMcdS1knzf4maEixKX/QamKTw==
X-Received: by 2002:a1c:894f:: with SMTP id l76-v6mr16495795wmd.103.1531302058259;
        Wed, 11 Jul 2018 02:40:58 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1641311wmt.29.2018.07.11.02.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:40:57 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>
Subject: [PATCH 7/8] efi: drop type and attribute checks in efi_mem_desc_lookup()
Date:   Wed, 11 Jul 2018 11:40:39 +0200
Message-Id: <20180711094040.12506-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of efi_mem_desc_lookup() includes the
following check on the memory descriptor it returns:

    if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
        md->type != EFI_BOOT_SERVICES_DATA &&
        md->type != EFI_RUNTIME_SERVICES_DATA) {
            continue;
    }

This means that only EfiBootServicesData or EfiRuntimeServicesData
regions are considered, or any other region type provided that it
has the EFI_MEMORY_RUNTIME attribute set.

Given what the name of the function implies, and the fact that any
physical address can be described in the UEFI memory map only a single
time, it does not make sense to impose this condition in the body of the
loop, but instead, should be imposed by the caller depending on the value
that is returned to it.

Two such callers exist at the moment:
- The BGRT code when running on x86, via efi_mem_reserve() and
  efi_arch_mem_reserve(). In this case, the region is already known to
  be EfiBootServicesData, and so the check is redundant.
- The ESRT handling code which introduced this function, which calls it
  both directly from efi_esrt_init() and again via efi_mem_reserve() and
  efi_arch_mem_reserve() [on x86].

So let's move this check into the callers instead. This preserves the
current behavior both for BGRT and ESRT handling, and allows the lookup
routine to be reused by other [upcoming] users that don't have this
limitation.

In the ESRT case, keep the entire condition, so that platforms that
deviate from the UEFI spec and use something other than
EfiBootServicesData for the ESRT table will keep working as before.

For x86's efi_arch_mem_reserve() implementation, limit the type to
EfiBootServicesData, since it is the only type the reservation code
expects to operate on in the first place.

While we're at it, drop the __init annotation so that drivers can use it
as well.

Cc: Peter Jones <pjones@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 3 ++-
 drivers/firmware/efi/efi.c     | 8 +-------
 drivers/firmware/efi/esrt.c    | 5 ++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 6af39dc40325..844d31cb8a0c 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -248,7 +248,8 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md)) {
+	if (efi_mem_desc_lookup(addr, &md) ||
+	    md.type != EFI_BOOT_SERVICES_DATA) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1379a375dfa8..d8a33a781a57 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -402,7 +402,7 @@ subsys_initcall(efisubsys_init);
  * and if so, populate the supplied memory descriptor with the appropriate
  * data.
  */
-int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
+int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 {
 	efi_memory_desc_t *md;
 
@@ -420,12 +420,6 @@ int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
 		u64 size;
 		u64 end;
 
-		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
-		    md->type != EFI_BOOT_SERVICES_DATA &&
-		    md->type != EFI_RUNTIME_SERVICES_DATA) {
-			continue;
-		}
-
 		size = md->num_pages << EFI_PAGE_SHIFT;
 		end = md->phys_addr + size;
 		if (phys_addr >= md->phys_addr && phys_addr < end) {
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 1ab80e06e7c5..375a77c1c6e5 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -250,7 +250,10 @@ void __init efi_esrt_init(void)
 		return;
 
 	rc = efi_mem_desc_lookup(efi.esrt, &md);
-	if (rc < 0) {
+	if (rc < 0 ||
+	    (!(md.attribute & EFI_MEMORY_RUNTIME) &&
+	     md.type != EFI_BOOT_SERVICES_DATA &&
+	     md.type != EFI_RUNTIME_SERVICES_DATA)) {
 		pr_warn("ESRT header is not in the memory map.\n");
 		return;
 	}
-- 
2.17.1

