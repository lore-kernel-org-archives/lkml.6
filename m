Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E80C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E41F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+2XdPO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfAKFNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:13:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42637 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfAKFNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:13:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so5807802pga.9;
        Thu, 10 Jan 2019 21:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sIr0XR9JtSIXTySKwYaIUFJCPnOMAPJJ3pzvm0xJRbI=;
        b=U+2XdPO+b0Y5Wq2bgrVPFxop20iY3m6KFjB8cQoC5apiFJca48DoqliwuouseL3L/e
         eh6IxYxOa85yqcUFI7BCKmI6qiniRhQs4coDnUm1DrT6aq+y0ZGeJojpjfjPTF4p3C3j
         71eLod8/Ay0jeql+cTR0ld0+eiik2VnZ2Ni+V5FuXw+m2M6V3r1LFrkM/c1IwsPr3Kb6
         /RV5KgQYyZojMXJCot4Oy09nUdkSs5Lb3MtSaAcPfax6+91pO+YyxiDL8q5JGbAIiBy8
         5J5Vxglbrhf3xFYUfq5sC+t34E8jd78cEoOkmOMyEFk67vQfNXDtpt5ggBB0z0q1OtS8
         /8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sIr0XR9JtSIXTySKwYaIUFJCPnOMAPJJ3pzvm0xJRbI=;
        b=WX/jHLqQtipAZRYUE4/loSaammMpadTLLWuzbeo9CQw3zV3OAYGrFDI3XrP+qdKjlm
         7NfkRwjKFe+LUn8050Cr3fuN3q+2DBrCFvK7FzyvPj8V1eUACsRgwEOdQGy+z4skaFRO
         Hc54mIWYLld3mbHAPvFROXeiOg2YihJulTVkh5LSmae3mCTBBXeYfpbMrmxncLitI2xI
         h/JC6MMBMu4CTTF/zDHIIlxF0Yp92Rzom+ahY9FNqQ8CnfRoEgdwOEFvGA1WJLa/iwL5
         COTHLDZbNERqjySbQLqbBjdC5jrZK2kabl0vY6UVmHD8JkhhDzEfBKczPctsSzybCWXN
         cbyw==
X-Gm-Message-State: AJcUukeAv10kA3bAnUvcj0hw1Fv+KtLIeChKN1lPPeAvxIBiYHcN6jeE
        Tam5IFSJTL8WdgIZIEOeEm1fsoHry/42
X-Google-Smtp-Source: ALg8bN6MrepyiJeI9/hkg0ePCAkRL+WmhJa6GehuKilZH1gz5v9005Y4X/lsU0mx1lt2nZCPdWtAfg==
X-Received: by 2002:a63:7512:: with SMTP id q18mr11105826pgc.231.1547183626904;
        Thu, 10 Jan 2019 21:13:46 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q7sm93490471pgp.40.2019.01.10.21.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 21:13:46 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHv2 4/7] x86/setup: parse acpi to get hotplug info before init_mem_mapping()
Date:   Fri, 11 Jan 2019 13:12:54 +0800
Message-Id: <1547183577-20309-5-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, memblock bottom-up allocation can help us against staining over
movable node in very high probability. But if the hotplug info has already
been parsed, the memblock allocator can step around the movable node by
itself. This patch pushes the parsing step forward, just ahead of where,
the memblock allocator can work. About how memblock allocator steps around
the movable node, referring to the cond check on memblock_is_hotpluggable()
in __next_mem_range().
Later in this series, the bottom-up allocation style can be removed on x86_64.

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
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: x86@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-mm@kvack.org
---
 arch/x86/kernel/setup.c | 39 ++++++++++++++++++++++++++++++---------
 include/linux/acpi.h    |  1 +
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a0122cd..9b57e01 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -804,6 +804,35 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
+static void early_acpi_parse(void)
+{
+	phys_addr_t start, end, orig_start, orig_end;
+	bool enforcing;
+
+	enforcing = memblock_get_current_limit(&orig_start, &orig_end);
+	/* find a 16MB slot for temporary usage by the following routines. */
+	start = memblock_find_in_range(ISA_END_ADDRESS,
+			max_pfn, 1 << 24, 1);
+	end = start + 1 + (1 << 24);
+	memblock_set_current_limit(start, end, true);
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (get_ramdisk_size())
+		acpi_table_upgrade(__va(get_ramdisk_image()),
+			get_ramdisk_size());
+#endif
+	/*
+	 * Parse the ACPI tables for possible boot-time SMP configuration.
+	 */
+	acpi_boot_table_init();
+	early_acpi_boot_init();
+	initmem_init();
+	/* check whether memory is returned or not */
+	start = memblock_find_in_range(start, end, 1<<24, 1);
+	if (!start)
+		pr_warn("the above acpi routines change and consume memory\n");
+	memblock_set_current_limit(orig_start, orig_end, enforcing);
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -1129,6 +1158,7 @@ void __init setup_arch(char **cmdline_p)
 	if (movable_node_is_enabled())
 		memblock_set_bottom_up(true);
 #endif
+	early_acpi_parse();
 	init_mem_mapping();
 	memblock_set_current_limit(0, get_max_mapped(), false);
 
@@ -1173,21 +1203,12 @@ void __init setup_arch(char **cmdline_p)
 	reserve_initrd();
 
 
-	acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
 	vsmp_init();
 
 	io_delay_init();
 
 	early_platform_quirks();
 
-	/*
-	 * Parse the ACPI tables for possible boot-time SMP configuration.
-	 */
-	acpi_boot_table_init();
-
-	early_acpi_boot_init();
-
-	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
 	/*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0b6e0b6..4f6b391 100644
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

