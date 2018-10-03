Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB65C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0008920878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifr9Gftx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0008920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeJCITw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:19:52 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33039 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeJCITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:19:51 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so1651908ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i2dirU9hRhF8xMc+mQHif3hQwnTj9fBMkLt6b6fXRUA=;
        b=ifr9Gftx7cUmtHNiLHg/kCRWRVKhq3BE6PIxAr+fJ8D7ir9Fz6+IxE4bd93K+hg/DW
         jpFo5auj3/vXIyodqJR8HcjjH4ID1RvVHjS99lbDNLqI3QPeIpK+F1tUVCTr/5Alp7+G
         anO3VxEVnB7EucxvyQ47xZ2vRlsNVawVDb2fjDgCZS1NCIfcRdPE+UezZUBF2TQ5f/kd
         GEELmXF4qs/g5oC8pHQSuY/SMI9mNd+2RiDIvOGM16QG7VY9fxczWzNnUG5/MjJtPE6K
         BflxuHvquJqLSq2h/aBQBb7bnWy7vn++TY/ekmA5YM6orIcPsI3IZAxo9bgZqkgz3rQX
         SFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i2dirU9hRhF8xMc+mQHif3hQwnTj9fBMkLt6b6fXRUA=;
        b=FsF5uJL5dKUakYJzaGbjEcHe4/nFf1LGUXp6/FU3VudtKUIW+4hrtwkY0170mZR/kH
         8o95KojGPL3etUr9wIWs4pYgQ7TD9EhZAPeGX6ae+Q2H2b+lRV7g78s7EDvGyHSyvE5Y
         OH2N62ZwyzRKgv0wkbHtHjE+vn47jonMPlJ1ShjuK8zrL6kE3D4zgEWPnViTzzxPLhmO
         1KQ56QS/Pe9fiRfSjZI7NMhYe/xpCDF5ga+CiHG9akZPjCcmHKfWzLGYYlfFZRzYU3TQ
         WgbHqJZ3mU1XCywBks8uKy/2cBreb65S5543VpRVnmISQjaRaMTUpVoi37+qaTnjCqnY
         +/bA==
X-Gm-Message-State: ABuFfohXAOT/QddJnumC+xc2pGWHfAY+h7017/pXWtrOhMjJ8NkIjLbQ
        teDo3E0w6VyY9MiaLizkiA==
X-Google-Smtp-Source: ACcGV60JqiK7ZOS3GqBK8rJLYFWLyFvr6JsfQZgzeIyVwyU3DavbHE2zo7vZMVou1JjgzuxArRuXDA==
X-Received: by 2002:a81:9f96:: with SMTP id w144-v6mr10195147ywg.88.1538530422196;
        Tue, 02 Oct 2018 18:33:42 -0700 (PDT)
Received: from gabell.hsd1.ma.comcast.net (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id x64-v6sm5908556ywx.103.2018.10.02.18.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 18:33:41 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] ACPI/NUMA: Add warning message if the padding size for KASLR is not enough
Date:   Tue,  2 Oct 2018 21:33:22 -0400
Message-Id: <20181003013323.4162-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003013323.4162-1-msys.mizuma@gmail.com>
References: <20181003013323.4162-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add warning message if the padding size for KASLR,
rand_mem_physical_padding, is not enough. The message also
says the suitable padding size.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 drivers/acpi/numa.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 8516760..420ed2c 100644
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
+				((u64)get_rand_mem_physical_padding() << 40);
+
+			if (max_possible_phys > threshold)
+				pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
+				  (max_possible_phys - max_actual_phys) >> 40);
+		}
 	}
 
 	/* SLIT: System Locality Information Table */
-- 
2.18.0

