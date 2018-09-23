Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E3C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EF62148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rsr2M8AC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EF62148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeIWTfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:35:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45262 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIWTfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:35:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so246309pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Zilsh2tFgZXnd5LLq1Z4euqgXWzST7tVUMLvmFK1/HA=;
        b=rsr2M8ACOw2f6hJrczsl229WsNB8iqcMS0JKuaqTsjC6gdt2SlCg8OYLEQay+wMTXL
         eRqL4tTx4Plu2tOfOhLJGPuORCA5Zaq4VY/D0Ad69vokTg6mSeY8E56Wn8Xcbuw3Tsrm
         mC/oFU50nDFRdHOoQCHHrx1lOAeFhhDQwyHHsJfNtES3fnS+K2dSxbo5RmgDp3542SuK
         9f13q/WOGOVTdLt5WCVlTFj1u6lHLBSawt5X16uDgTJ/QBB4nfApOTuAwkvx2dJlLsEs
         DE+jp0cq+Fh63NKshYnAAs1kH/CFkaHCg5v2l4YYrZFC2q9v57wdi8ISPqHdmH3RZUlI
         1rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zilsh2tFgZXnd5LLq1Z4euqgXWzST7tVUMLvmFK1/HA=;
        b=OBiYWgVtrU7vnc+VoG23OMbXgWTWeNznfbFsy+4gpbiqm9T9RcyojQWosJBmO1k7+2
         PKWgF6ESJkKZ6GYGRZ4tGwrqSYdTcj98fMGc6BIsNGMvOfpanEAQ8oGba7gowuucm7CE
         WTz+0wKrO2j+4QoF/NeErSX1mvUdYR+wpm3zYbW5UmtjO1yudopb2Uytg+wqG6Y2qBiL
         CLpPcdf3HHYkbORCAN5/r2TWmZN3gyhtJy99WSoJJJS8GmCYP65fHm2Yz3gUM+YwrZdx
         kR5TSxku+66iE0oV2JpxRFonAcaF7OgtitiegmowOcXDUYYM9cU0kNKW4Y5NUXpqQZzd
         iuUw==
X-Gm-Message-State: ABuFfohTwpg2trc8N2+DhhDFfA7iZKV13UjAA2Uue+jgFAVPnxPKaJ80
        ZF3vfdzR341RtjX9xvPcUf07CA==
X-Google-Smtp-Source: ACcGV63REVoEEo6io9wjsz75CHtYOyzRwj5oBTkOkzV1jE44O31bpbKpRG0x2QJAy0T8f2zXv+m2lw==
X-Received: by 2002:a63:fe02:: with SMTP id p2-v6mr5994391pgh.148.1537709871594;
        Sun, 23 Sep 2018 06:37:51 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id j16-v6sm62428654pfk.125.2018.09.23.06.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 06:37:50 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
Date:   Sun, 23 Sep 2018 19:07:37 +0530
Message-Id: <20180923133737.22693-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
is in-correct. This patch shows CPU ID and Hart ID separately
in /proc/cpuinfo using cpuid_to_hardid_map().

With this patch, contents of /proc/cpuinfo looks as follows:
processor	: 0
hart		: 1
isa		: rv64imafdc
mmu		: sv48

processor	: 1
hart		: 0
isa		: rv64imafdc
mmu		: sv48

processor	: 2
hart		: 2
isa		: rv64imafdc
mmu		: sv48

processor	: 3
hart		: 3
isa		: rv64imafdc
mmu		: sv48

Signed-off-by: Anup Patel <anup@brainfault.org>
---

Changes since v1:
 - Show logical CPU ID as "processor" attribute in /proc/cpuinfo

 arch/riscv/kernel/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 36b6ddb19b4d..392c7c19c4a3 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -81,7 +81,7 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 #endif
 
 	/* Print the base ISA, as we already know it's legal. */
-	seq_puts(f, "isa\t: ");
+	seq_puts(f, "isa\t\t: ");
 	seq_write(f, isa, 5);
 	isa += 5;
 
@@ -96,6 +96,7 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 			isa++;
 		}
 	}
+	seq_puts(f, "\n");
 
 	/*
 	 * If we were given an unsupported ISA in the device tree then print
@@ -116,7 +117,7 @@ static void print_mmu(struct seq_file *f, const char *mmu_type)
 		return;
 #endif
 
-	seq_printf(f, "mmu\t: %s\n", mmu_type+6);
+	seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
@@ -144,14 +145,15 @@ static int c_show(struct seq_file *m, void *v)
 						   NULL);
 	const char *compat, *isa, *mmu;
 
-	seq_printf(m, "hart\t: %lu\n", cpu_id);
+	seq_printf(m, "processor\t: %lu\n", cpu_id);
+	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hardid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa))
 		print_isa(m, isa);
 	if (!of_property_read_string(node, "mmu-type", &mmu))
 		print_mmu(m, mmu);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
-		seq_printf(m, "uarch\t: %s\n", compat);
+		seq_printf(m, "uarch\t\t: %s\n", compat);
 	seq_puts(m, "\n");
 
 	return 0;
-- 
2.17.1

