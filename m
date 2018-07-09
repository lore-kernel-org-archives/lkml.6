Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76416C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDBB208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeTciVgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDBB208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbeGIXmU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:42:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38244 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbeGIXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:42:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id x13-v6so4806297pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6svwEjRZKw/fRIHWE4svwtkCI66G0b2U5AUFtaL5oWI=;
        b=FeTciVgRbk0YToviRxoz9bYqVWMSEQiEJeqNWbSeMvGwcrZJZo/UZyIrS27iadOssY
         JmTSWtU8+ugcFaFxk3q1QaRfTD+cKR/cEXRm8xLT0//nSgU91OvC496vj1eWzI429RGd
         aU37D3xacRIkpZEAoqbQ9u1z7MdC8h39cwdfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6svwEjRZKw/fRIHWE4svwtkCI66G0b2U5AUFtaL5oWI=;
        b=eDmjterxGIMaCoVI5crtZxDNbrC50y3vRCc7CU7eUSPFQBIkHMpOnpRSg/w3/iMSK+
         iSJzD8cpVqdFVSUjbV5Pb85JsV/Pl9k/+vVwlnbunNbKFoY9WwZuN5I7a7XYcHoMRTIr
         SQyifI1YlVZrQ1Ifgwao+6pJXa6fZ+IA30H0+mvDT/HJZhDe+UOSmKhTht5g6Mhb8vSX
         bB20mAwyVDW15gOAheUH5c57eMXt+onL8YCfINR0Wnj7YkgCrovQgk4oYu5rXe9ouGlj
         yWF76FW9xjgnL9HPKcMGDDJNrG/4eHPOluQsIZn6TmaaIMJQCl5WpO4iPICluHoHw/54
         YAtw==
X-Gm-Message-State: APt69E3rnhy2fuobBg1yIWL++Tz4Wxl3tyM0lu6/Rme5uj5LGCKLGjSv
        /JWEyTkWkMz6tq4Z46W0IrvScw==
X-Google-Smtp-Source: AAOMgpczgUeSnu5TlYsHMBObQ11TnIv5AyBgBx71eoDGls/uL90/hIQwdIfkx+rzF084axxrlH1t/w==
X-Received: by 2002:a62:d34a:: with SMTP id q71-v6mr23092699pfg.17.1531179737032;
        Mon, 09 Jul 2018 16:42:17 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id b62-v6sm71862898pfm.97.2018.07.09.16.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 16:42:16 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3.1 3/4] efi/arm: map UEFI memory map even w/o runtime services enabled
Date:   Tue, 10 Jul 2018 08:42:28 +0900
Message-Id: <20180709234229.20181-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709234229.20181-1-takahiro.akashi@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under the current implementation, UEFI memory map will be mapped and made
available in virtual mappings only if runtime services are enabled.
But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
to create mappings of ACPI tables using memory attributes described in
UEFI memory map.
See the following commit:
    arm64: acpi: fix alignment fault in accessing ACPI tables

So, as a first step, arm_enter_runtime_services() is modified, alongside
Ard's patch[1], so that UEFI memory map will not be freed even if
efi=noruntime.

[1] https://marc.info/?l=linux-efi&m=152930773507524&w=2

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 59a8c0ec94d5..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -117,6 +117,13 @@ static int __init arm_enable_runtime_services(void)
 
 	efi_memmap_unmap();
 
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return 0;
+	}
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
@@ -129,13 +136,6 @@ static int __init arm_enable_runtime_services(void)
 
 	pr_info("Remapping and enabling EFI services.\n");
 
-	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
-
-	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
-		pr_err("Failed to remap EFI memory map\n");
-		return -ENOMEM;
-	}
-
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
 		return -ENOMEM;
-- 
2.17.0

