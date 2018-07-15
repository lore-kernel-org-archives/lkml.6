Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8603ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525172089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="B7DT6OTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525172089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeGOEPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 00:15:21 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41836 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeGOEPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 00:15:21 -0400
Received: by mail-yw0-f195.google.com with SMTP id q129-v6so10330294ywg.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 20:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9KKAyAbYBhWEcPGx2FCv9KHmTdztaCSUXU5/poEkbwU=;
        b=B7DT6OTkIbL5xJcUeOLR7O1920YS7jIYo30XSaKBbyhlC1w4ZybSeuduEOSmAoiPic
         Y/jf4T60ugZKjZfipYO4s+bLtYXwz6TKdXY6+V6mdH/9rgJec2dyinFAVG0WYP+sC95Y
         JYB10jFjy0WDB7WXoi9E2a906hV1hU4lLlIrMgsnxhxVaHzvH9aYkZTTtNTw6xUl72YZ
         Chee1zQPqM3jN0BBcqdLO5tmKzyOYWxLll5Q5hPmljXmO4wrasOs7sI/UuvSqbbWiRSn
         SB5xeLFCwj7yQzJBcSpnj7O1MKFwqMs2LBIckkOv84lwHPtuQjJINs1jmW0x/eWE8uoI
         qjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9KKAyAbYBhWEcPGx2FCv9KHmTdztaCSUXU5/poEkbwU=;
        b=YRf4XW+fhmRubmPVmBgIwElMmblVsCtbmInM3J0Iuds2sqoL97GPJh6klhiN23EQN/
         4CycpWnHlEh83WOHf+sL7WPGepvCDG0Myd24TTHvVC49NRCO3zWr089IlBT2zkJ5mght
         hPdVA8Nyd2vksAJhRPMaOvYA3CcES4A35PqaqXmiYLhIPolXjFyufFcGqJrRVSGETzVa
         i4f3tcMzV3/rTbfpLIm0/virjTqXcTzlkGdRbrqx7sNteY3nnfwJC4syqoUSGd4ZFeva
         gHN9tdthDkiCvYVZMaCaj7ibeD6W0PMyQLaETs9WBc1yjsbsWcR70n3KO4SC6K/wP4fb
         Jbug==
X-Gm-Message-State: AOUpUlGok4C+sRUBTluFYPm+yUR8cSDwSOt8zO5slsTE+StmepgDq8z2
        tZ8Psj2ghhWNaiv6WUTZfpD84Q==
X-Google-Smtp-Source: AAOMgpcNGgw81qaVOzvbxEl1ULMckpwH+PH/dEw2peqyrHvth4t0FPBycZsWWz/qnxnFMgMZnHjHyA==
X-Received: by 2002:a81:2202:: with SMTP id i2-v6mr5834904ywi.167.1531626834822;
        Sat, 14 Jul 2018 20:53:54 -0700 (PDT)
Received: from brutus.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id w143-v6sm3039782yww.49.2018.07.14.20.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 20:53:53 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] arm64: cpuinfo: Include cleartext implementer and part strings
Date:   Sat, 14 Jul 2018 20:53:42 -0700
Message-Id: <20180715035342.11371-1-olof@lixom.net>
X-Mailer: git-send-email 2.8.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's some use in printing out what the implementer and part numbers
decode to for cases where they're known.

I filled in the table based on public information; mostly from ARM TRMs
and other tools (and some of the SSBD tables in the kernel, etc).

Apple IDs came from
https://github.com/apple/darwin-xnu/blob/master/osfmk/arm/cpuid.h

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/kernel/cpuinfo.c | 79 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index e9ab7b3..9a7c25d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -121,6 +121,67 @@ static const char *const compat_hwcap2_str[] = {
 };
 #endif /* CONFIG_COMPAT */
 
+struct midr_info {
+	unsigned int mask;
+	unsigned int val;
+	char *id;
+};
+
+static const struct midr_info midr_part[] = {
+	// ARM
+	{ .mask = 0xff00fff0, .val = 0x4100d030, .id = "Cortex-A53" },
+	{ .mask = 0xff00fff0, .val = 0x4100d040, .id = "Cortex-A35" },
+	{ .mask = 0xff00fff0, .val = 0x4100d070, .id = "Cortex-A57" },
+	{ .mask = 0xff00fff0, .val = 0x4100d080, .id = "Cortex-A72" },
+	{ .mask = 0xff00fff0, .val = 0x4100d090, .id = "Cortex-A73" },
+	{ .mask = 0xff00fff0, .val = 0x4100d0a0, .id = "Cortex-A75" },
+	{ .mask = 0xff00fff0, .val = 0x4100d0f0, .id = "Cortex-A55" },
+	// Broadcom
+	{ .mask = 0xff00fff0, .val = 0x42001000, .id = "Brahma-B53" },
+	{ .mask = 0xff00fff0, .val = 0x42005160, .id = "ThunderX2" },
+	// Cavium
+	{ .mask = 0xff00fff0, .val = 0x43000a00, .id = "ThunderX" },
+	{ .mask = 0xff00fff0, .val = 0x43000a10, .id = "ThunderX 88xx" },
+	{ .mask = 0xff00fff0, .val = 0x43000a20, .id = "ThunderX 81xx" },
+	{ .mask = 0xff00fff0, .val = 0x43000a30, .id = "ThunderX 83xx" },
+	{ .mask = 0xff00fff0, .val = 0x43000af0, .id = "ThunderX2 99xx" },
+	// Nvidia
+	{ .mask = 0xff00fff0, .val = 0x4e000000, .id = "Denver" },
+	{ .mask = 0xff00fff0, .val = 0x4e000030, .id = "Denver 2" },
+	// Applied Micro
+	{ .mask = 0xff00fff0, .val = 0x50000000, .id = "X-Gene" },
+	// Qualcomm
+	{ .mask = 0xff00fff0, .val = 0x51002010, .id = "Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51002050, .id = "Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51002110, .id = "Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51008000, .id = "Falkor V1/Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51008010, .id = "Kryo V2" },
+	{ .mask = 0xff00fff0, .val = 0x5100c000, .id = "Falkor" },
+	{ .mask = 0xff00fff0, .val = 0x5100c010, .id = "Saphira" },
+	// Samsung
+	{ .mask = 0xff00fff0, .val = 0x53000010, .id = "M1" },
+	// Apple
+	{ .mask = 0xff00fff0, .val = 0x61000010, .id = "Cyclone" },
+	{ .mask = 0xff00fff0, .val = 0x61000020, .id = "Typhoon" },
+	{ .mask = 0xff00fff0, .val = 0x61000030, .id = "Typhoon/Capri" },
+	{ .mask = 0xff00fff0, .val = 0x61000040, .id = "Twister" },
+	{ .mask = 0xff00fff0, .val = 0x61000050, .id = "Twister/Elba/Malta" },
+	{ .mask = 0xff00fff0, .val = 0x61000060, .id = "Hurricane" },
+	{ .mask = 0xff00fff0, .val = 0x61000070, .id = "Hurricane/Myst" },
+};
+
+static const struct midr_info midr_impl[] = {
+	{ .mask = 0xff000000, .val = 0x41000000, .id = "ARM" },
+	{ .mask = 0xff000000, .val = 0x42000000, .id = "Broadcom" },
+	{ .mask = 0xff000000, .val = 0x43000000, .id = "Cavium" },
+	{ .mask = 0xff000000, .val = 0x4d000000, .id = "Motorola" },
+	{ .mask = 0xff000000, .val = 0x4e000000, .id = "Nvidia" },
+	{ .mask = 0xff000000, .val = 0x50000000, .id = "Applied Micro" },
+	{ .mask = 0xff000000, .val = 0x51000000, .id = "Qualcomm" },
+	{ .mask = 0xff000000, .val = 0x53000000, .id = "Samsung" },
+	{ .mask = 0xff000000, .val = 0x61000000, .id = "Apple" },
+};
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
@@ -129,6 +190,16 @@ static int c_show(struct seq_file *m, void *v)
 	for_each_online_cpu(i) {
 		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
 		u32 midr = cpuinfo->reg_midr;
+		char *impl = NULL;
+		char *part = NULL;
+
+		for (j = 0; !impl && j < ARRAY_SIZE(midr_impl); j++)
+			if ((midr & midr_impl[j].mask) == midr_impl[j].val)
+				impl = midr_impl[j].id;
+
+		for (j = 0; !part && j < ARRAY_SIZE(midr_part); j++)
+			if ((midr & midr_part[j].mask) == midr_part[j].val)
+				part = midr_part[j].id;
 
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
@@ -168,11 +239,12 @@ static int c_show(struct seq_file *m, void *v)
 		}
 		seq_puts(m, "\n");
 
-		seq_printf(m, "CPU implementer\t: 0x%02x\n",
-			   MIDR_IMPLEMENTOR(midr));
+		seq_printf(m, "CPU implementer\t: 0x%02x (%s)\n",
+			   MIDR_IMPLEMENTOR(midr), impl ? : "unknown");
 		seq_printf(m, "CPU architecture: 8\n");
 		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
-		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
+		seq_printf(m, "CPU part\t: 0x%03x (%s)\n", MIDR_PARTNUM(midr),
+			   part ? : "unknown");
 		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
 	}
 
@@ -300,6 +372,7 @@ static int __init cpuinfo_regs_init(void)
 	}
 	return 0;
 }
+
 static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.8.6

