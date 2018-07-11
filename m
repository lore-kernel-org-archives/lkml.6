Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56912083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWjg/fqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56912083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbeGKJoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35790 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732628AbeGKJoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so1840740wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=semFZDZ5nZhcHHAbVFoDCVNYOqmDtPeCRsqInWmd32A=;
        b=BWjg/fqTgl5cNpg7yim7h3iQMkc7YJV61kg5WOiBg59yZZtM5yxShPo9dWI5gdVMD3
         2PIpjqvI9zVgj/I4osdj8UDv5ayb9uYhnRhy631Lam2Mlw/9V3SQWlF7R0B4f1E4+iNU
         a0AxXPVMWUvChd3jRy3/0Tnq3yXEEBFqN/Ui0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=semFZDZ5nZhcHHAbVFoDCVNYOqmDtPeCRsqInWmd32A=;
        b=nFYFjxLdvXGcikh6rM7C0QQmGeVTT8OdkppEHSbSqa/iz+A4QqqRRmkMsYnbDzwkd+
         sM0JrF3lxiYzZSswaYwnd5A/XRV7AH6SmxN9lXs+950yosE3lHCiHkrO9Uf7OmpEQ1Zb
         t7FVcV1jISz9Z0nAI26Jtz8ReUDdC9kVjzR6MP+NM9VqbeK2wewlFpmuN9aGy91JYUj9
         SYFoNBaBbMKqIvIgqM79PmHVJAS+adGEs9wc98XXD1vOvPidZln/O6E73Sm2AYKc4zgl
         dhoC56p9tKrn4kluOwI5Aeojb4LwqmqEqH15T8ZJUPD7Shu2kqmj2bpW4pUhW50qmT/X
         bCFw==
X-Gm-Message-State: APt69E3Y7DB/H3LP9y7MR1mW3DGIp1SFSqFjcPA/Flm4zB78rgvX1w7n
        XiRFFmVdVVilEYNCCWpMvb1ozw==
X-Google-Smtp-Source: AAOMgpfnfdBlM5yNiNwu4p7issa9/cBTEAczXbFsmq0+dVu6I/45sqD8+4klO/9vQSBwGZZLfuhtaQ==
X-Received: by 2002:a1c:8d0a:: with SMTP id p10-v6mr17760280wmd.121.1531302056988;
        Wed, 11 Jul 2018 02:40:56 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1641311wmt.29.2018.07.11.02.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:40:56 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] efi/libstub/arm: add opt-in Kconfig option for the DTB loader
Date:   Wed, 11 Jul 2018 11:40:38 +0200
Message-Id: <20180711094040.12506-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are various ways a platform can provide a device tree binary
to the kernel, with different levels of sophistication:
- ideally, the UEFI firmware, which is tightly coupled with the
  platform, provides a device tree image directly as a UEFI
  configuration table, and typically permits the contents to be
  manipulated either via menu options or via UEFI environment
  variables that specify a replacement image,
- GRUB for ARM has a 'devicetree' directive which allows a device
  tree image to be loaded from any location accessible to GRUB, and
  supersede the one provided by the firmware,
- the EFI stub implements a dtb= command line option that allows a
  device tree image to be loaded from a file residing in the same
  file system as the one the kernel image was loaded from.

The dtb= command line option was never intended to be more than a
development feature, to allow the other options to be implemented
in parallel. So let's make it an opt-in feature that is disabled
by default, but can be re-enabled at will.

Note that we already disable the dtb= command line option when we
detect that we are running with UEFI Secure Boot enabled.

Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Reviewed-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/Kconfig            | 12 ++++++++++++
 drivers/firmware/efi/libstub/arm-stub.c |  7 ++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 781a4a337557..fc1cb2961d5b 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -87,6 +87,18 @@ config EFI_RUNTIME_WRAPPERS
 config EFI_ARMSTUB
 	bool
 
+config EFI_ARMSTUB_DTB_LOADER
+	bool "Enable the DTB loader"
+	depends on EFI_ARMSTUB
+	help
+	  Select this config option to add support for the dtb= command
+	  line parameter, allowing a device tree blob to be loaded into
+	  memory from the EFI System Partition by the stub.
+
+	  The device tree is typically provided by the platform or by
+	  the bootloader, and so this option is mostly for development
+	  purposes only.
+
 config EFI_BOOTLOADER_CONTROL
 	tristate "EFI Bootloader Control"
 	depends on EFI_VARS
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 01a9d78ee415..c98b1856fc3d 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -202,9 +202,10 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
 	 * boot is enabled if we can't determine its state.
 	 */
-	if (secure_boot != efi_secureboot_mode_disabled &&
-	    strstr(cmdline_ptr, "dtb=")) {
-		pr_efi(sys_table, "Ignoring DTB from command line.\n");
+	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
+	     secure_boot != efi_secureboot_mode_disabled) {
+		if (strstr(cmdline_ptr, "dtb="))
+			pr_efi(sys_table, "Ignoring DTB from command line.\n");
 	} else {
 		status = handle_cmdline_files(sys_table, image, cmdline_ptr,
 					      "dtb=",
-- 
2.17.1

