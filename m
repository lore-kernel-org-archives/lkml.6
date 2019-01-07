Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B05C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5AA2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2jjbaPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfAGIZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:25:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32909 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfAGIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:25:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so21499429pfb.0;
        Mon, 07 Jan 2019 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jyr0NQzmfTXY3SvxPTqTGDtj4I10Ai88dMAhnn2h2iM=;
        b=K2jjbaPl31+ZnxtWPV5ZVTeGb034+favVT2aeDSbDPhbxfAyjBD2z6Btka2njjhL/f
         EjSTcnOSlUZik4SjiH0xmunFuk+eEJBizzYbgU/XekygUjxHgpYvxiIKG7wZsXe1nyb1
         wETpL16J5GmxLJdBCSgCApA5cKwwYKcbfUDJnXKo2sVVXx5Gg6nS5996yBJ5CtxnSa/K
         qkFf3DWldXM+NfKseDV1hNIiHJezUb9FYLqqqKydEgs2P9Jjt5a/tNcixppxcXjVDdNG
         Aqj0FTAagjyGlNu2UqNz8yYPnmCp42LVm4C1Anrve3d3xNhOtG7oesZvh5NupzabWcv3
         Hp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jyr0NQzmfTXY3SvxPTqTGDtj4I10Ai88dMAhnn2h2iM=;
        b=QaNa2OLGKL0LUkybtJp+A0B1OAPiV70u4XNWI7Y6hCVqBU7yFgnGdEY9/fWs7kRjky
         sgaXwRVm2NAGlWtc4/BgbF9YP8vEGTZgdoF3mhZuCmyw4V4rYtf+nthtsJmZ7PQ6srOn
         7szowXqcrHXYRGqobACGc59DOL+/Ot5iAoxTI+DWsP3A6X+kWpEBR4bSyu5r2LX+yvps
         RJZFwQdR5MujS9q5SMebtqBO60x+MqyO3PLxMgPM9eED8x/Qdk0vCzj90nXf9rOiC5qA
         f6CoMSd6mDH8TvPxWkDg5+4P7I0AbCVXwtCflVh4pWMiPUzJwGjwDcJaNXcnIKTWVHkX
         8JMQ==
X-Gm-Message-State: AJcUukffnrfngjFC5evRUFYEyB1arvzDlCcB4Vd0fEK/X8ZWv18pYbln
        OXBGGkKEHLEB3vrCqRVs4g==
X-Google-Smtp-Source: ALg8bN5XFL3PrHGwB/39h3p7mp60ii2fTsPEEaVTnXqG1/Rs21zLQOmviizN9UrBIe3IcuVNU6pKcQ==
X-Received: by 2002:a65:6491:: with SMTP id e17mr10063938pgv.418.1546849507066;
        Mon, 07 Jan 2019 00:25:07 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t3sm76981674pgv.31.2019.01.07.00.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:25:06 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-acpi@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] x86/setup: parse acpi to get hotplug info before init_mem_mapping()
Date:   Mon,  7 Jan 2019 16:24:43 +0800
Message-Id: <1546849485-27933-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, memblock bottom-up allocation can help us against stamping over
movable node in very high probability. But if the hotplug info has already
been parsed, the memblock allocator can step around the movable node by
itself. This patch pushes the parsing step forward, just ahead of where,
the memblock allocator can work. Later in this series, the bottom-up
allocation style can be removed on x86_64.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/setup.c | 15 +++++++++++++++
 include/linux/acpi.h    |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index acbcd62..df4132c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -805,6 +805,20 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
+/* only need the effect of acpi_numa_memory_affinity_init()
+ * ->memblock_mark_hotplug()
+ */
+static int early_detect_acpi_memhotplug(void)
+{
+#ifdef CONFIG_ACPI_NUMA
+	acpi_table_upgrade(__va(get_ramdisk_image()), get_ramdisk_size());
+	acpi_table_init();
+	acpi_numa_init();
+	acpi_tb_terminate();
+#endif
+	return 0;
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -1131,6 +1145,7 @@ void __init setup_arch(char **cmdline_p)
 	trim_platform_memory_ranges();
 	trim_low_memory_range();
 
+	early_detect_acpi_memhotplug();
 	init_mem_mapping();
 
 	idt_setup_early_pf();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 44dcbba..1b69044 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -235,6 +235,7 @@ int acpi_mps_check (void);
 int acpi_numa_init (void);
 
 int acpi_table_init (void);
+void acpi_tb_terminate(void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 			      int entry_id,
-- 
2.7.4

