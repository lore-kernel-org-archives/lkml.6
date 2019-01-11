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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80595214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8FShFzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfAKFNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:13:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36881 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfAKFNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:13:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so6233908plr.4;
        Thu, 10 Jan 2019 21:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fl+859MCIsPrIsKoMm9QR3qOmotIpRzZocMuktvJB6I=;
        b=J8FShFzHpRwxxdAjPdsiYXXAAyRJEOJ7x+Ptmmt4Wb0lGPeFqtyC/n60IU/sB46Qha
         KkpZPD9RHyntynn6sKdVgFQnmo+mQ4xtUceXylBrPNJPrv4HEEMzhb63T7rUtJHHazbv
         3Kj9X/gAQ+r9zkfqOkDZ0SgXhMRPEO8mzItkC3NKFgk1vkYl4DwDPCTBC3iugC0LcnLg
         +cgcIjFI0ugxScM9kmJOi1X8WxxFOWMCWKQ/zdyKC0dQJW9EhdhawghMZNNPgjdxMXqY
         //Q19MPdQEUsSe+IL4wM706RIeimx2acLihtqYBdxd5cN/bVgpoMawedTsMV674r3atT
         BpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fl+859MCIsPrIsKoMm9QR3qOmotIpRzZocMuktvJB6I=;
        b=Sxj+svP6F6jsyvhyln3hc+leJ+3n/6qq1j5O1uGGePzMizT3ZuDMJDlEAFiv9LIgfL
         RiHLxhDX4L2MXtDCLcaHd/U26SlzYJukPOsTdRiVRA6XpDUyA3MdiszxDdKmTtORELMn
         SroYFATJDYY4orR4tpldtEbKJxvysBcCY254XcCGOdU+rLpRvM39tcQ7z7tkFIUUISSp
         mt/7MzT2BcBgqdKJJp0U4s7yuc+r6j/Eb9QUkL43DqB5SgQBSVtW50RK+ymqwBtDRpyA
         q0FmbYvH5Jfg1ADJ3yB+asos9a2E7rJ4taAYs1mzyaaA+Dhk2bkD0QzAklGY3hpq5m5V
         NN+w==
X-Gm-Message-State: AJcUukfWl/dCHMx92XXbmPYcOp8udh508kmLjDMFrfmH5+tgIJd07aN9
        vkmC6oK4Sh3EnmF3zwx4sOER16R6vl4r
X-Google-Smtp-Source: ALg8bN7JOdeQYRn3zkVi+6IJkspRtFUCj2IVmwO03Kj270ObKQXYdJIXZvMHTdOdX/LYWeVLxSP2JQ==
X-Received: by 2002:a17:902:7e4f:: with SMTP id a15mr8905337pln.149.1547183611922;
        Thu, 10 Jan 2019 21:13:31 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q7sm93490471pgp.40.2019.01.10.21.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 21:13:31 -0800 (PST)
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
Subject: [PATCHv2 2/7] acpi: change the topo of acpi_table_upgrade()
Date:   Fri, 11 Jan 2019 13:12:52 +0800
Message-Id: <1547183577-20309-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current acpi_table_upgrade() relies on initrd_start, but this var is
only valid after relocate_initrd(). There is requirement to extract the
acpi info from initrd before memblock-allocator can work(see [2/4]), hence
acpi_table_upgrade() need to accept the input param directly.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
 arch/arm64/kernel/setup.c | 2 +-
 arch/x86/kernel/setup.c   | 2 +-
 drivers/acpi/tables.c     | 4 +---
 include/linux/acpi.h      | 4 ++--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0..bc4b47d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -315,7 +315,7 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 	efi_apply_persistent_mem_reservations();
 
-	acpi_table_upgrade();
+	acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
 
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ac432ae..dc8fc5d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1172,8 +1172,8 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_initrd();
 
-	acpi_table_upgrade();
 
+	acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
 	vsmp_init();
 
 	io_delay_init();
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 61203ee..84e0a79 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -471,10 +471,8 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
 
 #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
 
-void __init acpi_table_upgrade(void)
+void __init acpi_table_upgrade(void *data, size_t size)
 {
-	void *data = (void *)initrd_start;
-	size_t size = initrd_end - initrd_start;
 	int sig, no, table_nr = 0, total_offset = 0;
 	long offset = 0;
 	struct acpi_table_header *table;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed80f14..0b6e0b6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1254,9 +1254,9 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
 #endif
 
 #ifdef CONFIG_ACPI_TABLE_UPGRADE
-void acpi_table_upgrade(void);
+void acpi_table_upgrade(void *data, size_t size);
 #else
-static inline void acpi_table_upgrade(void) { }
+static inline void acpi_table_upgrade(void *data, size_t size) { }
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_ACPI_WATCHDOG)
-- 
2.7.4

