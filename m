Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693222089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyH5kQl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693222089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeIZARl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:17:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeIZARj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:17:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id t15so16417205wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qpq8xhJhRVyPIhybIrRVbsiL98w7WDObH988kQk9jIk=;
        b=lyH5kQl0MtYSQ0e0ZZ+Aw+pOZoJ05xEGN105fykxTjUCsXt905xiZczKKpj0eTnj0i
         fl8DyIDY6xwMIj7ThYO523uNwUskC4HcfyZL3Qee58dw70MEHj4p+zFM/0PmYIS29kEC
         78/oUC948cBKaA99QqyEt3QOy7VKw6xWXE1xzeH6zMfuRaYMv5arvoYJJJmwgeloHjCl
         a/r3Jl4itW9o3modo6t6Ca67XaP47Wzr6AptZ4eq2Vh/w80b8s+UH95r1YkQqGTihTqo
         VFNUvPhQazUwnd/cAZfTreFSVw9KiJgiK66fdV1oQMhvjP7gyM0gdtHZUslPIFdUzNuj
         jt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qpq8xhJhRVyPIhybIrRVbsiL98w7WDObH988kQk9jIk=;
        b=uWSyfUDeotQTmmyZPSapfU/9UUQAPz2c2Yr/m+Y7y4P9odXvPd0mv8Xmr+TBdS/kJV
         31IX48Oz9lz9rcMXiEhAEbXJOQGgGiX+asVkSZbUhhratmvn0jpNWAprTdLEMxS0cCbM
         SEBsrxbqWjKv6Y5qkGl7jIWFKF5Z1lhPAnXdxL29nKjVUa2uIOURaMBXSD3zF3Zlr5mP
         P30wsKYpYwVmhJkPKeKbJLDaDCYlQBD0SNZVRyqD9OrT1uZt5iswZ74m9TH8Ohx7c571
         6p9RKABEpS7+El0ZLXAO3PHBKKfV11WCYxBaJaAZHMG2tXxIZjyPTLuOuLBH+qhxRqlo
         69HQ==
X-Gm-Message-State: ABuFfoibqFOUO0XcVNfVTxW1/AIbvg6ylVXoRhovy3/M+Tj2ISZONNbs
        kepdcBOVqvmIJ32uzCQrsC0=
X-Google-Smtp-Source: ACcGV60Nm85mSWG4aFlMQvgbwX8t5k+k0mnEmFmvSAP6BqtZK1gAkzpqSKHfCHw0nuP/X9CwgD9NqA==
X-Received: by 2002:adf:ac13:: with SMTP id v19-v6mr2077035wrc.135.1537898935836;
        Tue, 25 Sep 2018 11:08:55 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:55 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Octeon: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
Date:   Tue, 25 Sep 2018 21:08:25 +0300
Message-Id: <20180925180825.24659-5-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELF appended dtb can be accessed now via 'fw_passed_dtb'.

Since raw appended dtb is accessed via that variable too,
this now effectively allows to boot with CONFIG_MIPS_RAW_APPENDED_DTB=y
on Octeon.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/cavium-octeon/setup.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..3c26054ce72b 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1156,7 +1156,6 @@ void __init prom_free_prom_memory(void)
 void __init octeon_fill_mac_addresses(void);
 int octeon_prune_device_tree(void);
 
-extern const char __appended_dtb;
 extern const char __dtb_octeon_3xxx_begin;
 extern const char __dtb_octeon_68xx_begin;
 void __init device_tree_init(void)
@@ -1165,15 +1164,12 @@ void __init device_tree_init(void)
 	bool do_prune;
 	bool fill_mac;
 
-#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
-	if (!fdt_check_header(&__appended_dtb)) {
-		fdt = &__appended_dtb;
+	if (fw_passed_dtb) {
+		fdt = (void *)fw_passed_dtb;
 		do_prune = false;
 		fill_mac = true;
 		pr_info("Using appended Device Tree.\n");
-	} else
-#endif
-	if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
+	} else if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
 		fdt = phys_to_virt(octeon_bootinfo->fdt_addr);
 		if (fdt_check_header(fdt))
 			panic("Corrupt Device Tree passed to kernel.");
-- 
2.19.0

