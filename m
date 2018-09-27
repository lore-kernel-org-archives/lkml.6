Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6480EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFDA216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZdcxq50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFDA216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeI1CyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:54:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41716 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1CyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:54:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15-v6so4280606qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/+XihCCqQMTKXsngoMc/5Eb1lyFXZsVULQniLO2ZgM=;
        b=aZdcxq50A98Vkl2zQo/2n0xn4/CVOpMPvvCeQAzaKqPDwiXMjGNpAuVDDi3ofPb9qO
         NxybUwnPd3ikKnz4yaKhHX8nx3z8aByik8Ch13dH8uEPV0IDNPoCgtSb0fG8UyfgrxJH
         TRHSXSbyRuMAnvXzjo/NilXScG2nkgb8CkTzqGgKtE9q0FHH+5ZRJb+BMRuUqwDH+XIw
         e8pVrchgy3CTRfdgjikXfipdkyZ5gw+Lu6ec429D9Eonpr9Ap28LKid0U2UwIL8UfYAa
         Q1WsZfd8av49a9+HKB34clin/t7O+2ZEhPJaGgKWUBYPGWyKYlXqbiuiZ2nvXu77ORhR
         Chzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/+XihCCqQMTKXsngoMc/5Eb1lyFXZsVULQniLO2ZgM=;
        b=Ngz1SejIwVz6TYAJ628VyCux+szlkv8CtmdpwvSF1n+Ab9knqcAJC6qTOs2VMEtbIK
         2WNflQPgQa2mlF/4zc4NklOwJ4hPW3Z50Ypc7JvoQ9oLHTh1sQ0OHwRPX2KRbDrEVtZy
         YE3L/tHfXC2LeUP0mCu6kP+CvVePkdLt/Q8sDk+iyb2p2TfT2zqQ5aLvAE0OK75e09JR
         e5/jZAQVlSLZ3eIAkZ4pA9pICvp+Vj0bZtcJ0SN2Jkfg3/tA8lPjaEiwn9hkR/9Mvr8Z
         p3Muupp+PhNHvkGNCHLhqUDi3SUR8CPBSCmIQLE4n+2Caz94MFiFmlDTH5Acy2w+9Top
         zSeg==
X-Gm-Message-State: ABuFfoi6TSVDzsENPE44ywYl+6a6zFYlkOSjITHbarccZ0LMZH6aVAaf
        IKtrkyp7O4B+iwskucSH6g==
X-Google-Smtp-Source: ACcGV63JXZFlSveexiu5aFo/nlG/lHIVK681PSJncJr+H+hXA2s7oeXdt7f7/XHNqfBUCmNuRIOP9Q==
X-Received: by 2002:ac8:34ce:: with SMTP id x14-v6mr10037722qtb.115.1538080446958;
        Thu, 27 Sep 2018 13:34:06 -0700 (PDT)
Received: from centos7.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v187-v6sm1649374qka.73.2018.09.27.13.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:34:06 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] ACPI / NUMA: Add warning message if the padding size for KASLR is not enough
Date:   Thu, 27 Sep 2018 16:31:45 -0400
Message-Id: <20180927203146.12201-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927203146.12201-1-msys.mizuma@gmail.com>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add warning message if the padding size for KASLR,
rand_mem_physical_padding, is not enough. The message also
says the suitable padding size.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/include/asm/setup.h |  2 ++
 drivers/acpi/numa.c          | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc9..65a5bf8 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -80,6 +80,8 @@ static inline unsigned long kaslr_offset(void)
 	return (unsigned long)&_text - __START_KERNEL;
 }
 
+extern int rand_mem_physical_padding;
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 8516760..9c3cc3c 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -32,6 +32,7 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <asm/setup.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
@@ -435,6 +436,8 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int cnt = 0;
+	u32 max_phys_addr_tb;
+	u64 max_phys_addr;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -463,6 +466,17 @@ int __init acpi_numa_init(void)
 
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity, 0);
+
+		if (parsed_numa_memblks && kaslr_enabled()) {
+			max_phys_addr = PFN_PHYS(max_possible_pfn);
+			max_phys_addr_tb = (roundup(max_phys_addr, 1ULL << 40)) >> 40;
+
+			if (max_phys_addr_tb > rand_mem_physical_padding)
+				pr_warn("Set 'rand_mem_physical_padding=%d' "
+					"as the kernel parameter. "
+					"Otherwise, memory hotadd may be failed.\n",
+					max_phys_addr_tb);
+		}
 	}
 
 	/* SLIT: System Locality Information Table */
-- 
2.18.0

