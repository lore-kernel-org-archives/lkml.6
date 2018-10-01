Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C37208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar9iNFdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C37208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeJAUrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:47:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40150 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbeJAUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:47:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id e9-v6so14054371qtp.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T88SmNFZReKHrafxj/2Qw1Kp7FwffRvSlAJk6/q7o8s=;
        b=Ar9iNFdjuPTbv0nF8yP0paCbPpVZitMghADIac8yWeaYn2cxVhouqBxeEYMpjhgVrn
         SQWhcDAO0W44ypBhJ/VSfK/+H1jZUSMv1AVcfdB3LuzCbIs8FBRBJCQ2KCLqVH4COvBU
         YSiMjAQpOuer8HbN3j+5zPF1RkkxRvv9gNqwxovjXLtcQldLwNtPtsZaselvVw4p43/P
         3/QgHOeUVcZCFh+G10U7cP3gGx/E6t+4zxWcZ6Uw7/T2C9s2abX+SXAMHHSjJZYkLWoD
         NbzkLKH8X7luinCWfGnYS5IJdB3S3TXeriQdeDAIfa37uOwNPgRBwa7oVmzcknuuga8Y
         5r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T88SmNFZReKHrafxj/2Qw1Kp7FwffRvSlAJk6/q7o8s=;
        b=GKQDz5LJuy4JGUwY/z0HgWotDzEAhqw82ASJdaFEBl1dPCGgjJUsnjgXByKeM1vPG+
         1iLslgJrNfPV24KZI477jKyjWrEWkCAeBMjHA0jIV67bEe8tLTwRGjEEtwvHHQF5JCD7
         uLe3jg7qZypQI+OKTYAyh40sTHg4pmoJg0joVaoDoAfkGhdHrJEBU2hfWhVV8DRsOR7v
         HvQR61hZXGRJikG+tkFjp3dV3h0OIMqVtRHN0E0KPuT/Yt5LLoZYKmpdEsAelE/ZSYg4
         3SRisG9mkJeEN6bag1A7EP06DEmfVMo/0csJDFHbx/g6f7eYj0W3bgYvv1KUUfKCD2uy
         +56A==
X-Gm-Message-State: ABuFfogPrc9Tx9GzUnC4OPrfxN6fFAMlMtuYL6MDnm1fjIB4rtXbr0hF
        0prVn7q+gSeBSInR8r7bQQ==
X-Google-Smtp-Source: ACcGV62M4vt4EXSpm4aS4tX/v3IneCdRJ4TsMzmxro9MBEz3ebtKSFL7HMlof/svLRzfwB4NvxJhzg==
X-Received: by 2002:a0c:e98f:: with SMTP id z15-v6mr8565280qvn.116.1538402951642;
        Mon, 01 Oct 2018 07:09:11 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j19-v6sm5714496qtr.6.2018.10.01.07.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:09:11 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] ACPI / NUMA: Add warning message if the padding size for KASLR is not enough
Date:   Mon,  1 Oct 2018 10:08:42 -0400
Message-Id: <20181001140843.26137-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001140843.26137-1-msys.mizuma@gmail.com>
References: <20181001140843.26137-1-msys.mizuma@gmail.com>
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
 drivers/acpi/numa.c          | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

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
index 8516760..5a11aa5 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -32,6 +32,7 @@
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <asm/setup.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
@@ -435,6 +436,7 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int cnt = 0;
+	u64 max_possible_phys, max_actual_phys, threshold;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -463,6 +465,20 @@ int __init acpi_numa_init(void)
 
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity, 0);
+
+		/* check the padding size for KASLR is enough. */
+		if (parsed_numa_memblks && kaslr_enabled()) {
+			max_actual_phys = roundup(PFN_PHYS(max_pfn),
+							1ULL << 40);
+			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn),
+							1ULL << 40);
+			threshold = max_actual_phys +
+					((u64)rand_mem_physical_padding << 40);
+
+			if (max_possible_phys > threshold)
+				pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
+				  (max_possible_phys - max_actual_phys) >> 40);
+		}
 	}
 
 	/* SLIT: System Locality Information Table */
-- 
2.18.0

