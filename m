Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE55C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E575420870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfAKFbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:31:39 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52020 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725769AbfAKFbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:31:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,464,1539619200"; 
   d="scan'208";a="51768316"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2019 13:31:35 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 7D8734BAD914;
        Fri, 11 Jan 2019 13:31:33 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 13:31:32 +0800
Date:   Fri, 11 Jan 2019 13:30:37 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Baoquan He <bhe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCHv2 2/7] acpi: change the topo of acpi_table_upgrade()
Message-ID: <20190111053036.GA13263@localhost.localdomain>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547183577-20309-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 7D8734BAD914.AD370
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:12:52PM +0800, Pingfan Liu wrote:
>The current acpi_table_upgrade() relies on initrd_start, but this var is
>only valid after relocate_initrd(). There is requirement to extract the
>acpi info from initrd before memblock-allocator can work(see [2/4]), hence
>acpi_table_upgrade() need to accept the input param directly.
>
>Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: "H. Peter Anvin" <hpa@zytor.com>
>Cc: Dave Hansen <dave.hansen@linux.intel.com>
>Cc: Andy Lutomirski <luto@kernel.org>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>Cc: Len Brown <lenb@kernel.org>
>Cc: Yinghai Lu <yinghai@kernel.org>
>Cc: Tejun Heo <tj@kernel.org>
>Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Juergen Gross <jgross@suse.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: x86@kernel.org
>Cc: linux-acpi@vger.kernel.org
>Cc: linux-mm@kvack.org
>---
> arch/arm64/kernel/setup.c | 2 +-
> arch/x86/kernel/setup.c   | 2 +-
> drivers/acpi/tables.c     | 4 +---
> include/linux/acpi.h      | 4 ++--
> 4 files changed, 5 insertions(+), 7 deletions(-)
>
>diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>index f4fc1e0..bc4b47d 100644
>--- a/arch/arm64/kernel/setup.c
>+++ b/arch/arm64/kernel/setup.c
>@@ -315,7 +315,7 @@ void __init setup_arch(char **cmdline_p)
> 	paging_init();
> 	efi_apply_persistent_mem_reservations();
> 
>-	acpi_table_upgrade();
>+	acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
> 
> 	/* Parse the ACPI tables for possible boot-time configuration */
> 	acpi_boot_table_init();
>diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>index ac432ae..dc8fc5d 100644
>--- a/arch/x86/kernel/setup.c
>+++ b/arch/x86/kernel/setup.c
>@@ -1172,8 +1172,8 @@ void __init setup_arch(char **cmdline_p)
> 
> 	reserve_initrd();
> 
>-	acpi_table_upgrade();
> 
I wonder whether this will cause two blank lines together.

Thanks,
Chao Fan

>+	acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
> 	vsmp_init();
> 
> 	io_delay_init();
>diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>index 61203ee..84e0a79 100644
>--- a/drivers/acpi/tables.c
>+++ b/drivers/acpi/tables.c
>@@ -471,10 +471,8 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
> 
> #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
> 
>-void __init acpi_table_upgrade(void)
>+void __init acpi_table_upgrade(void *data, size_t size)
> {
>-	void *data = (void *)initrd_start;
>-	size_t size = initrd_end - initrd_start;
> 	int sig, no, table_nr = 0, total_offset = 0;
> 	long offset = 0;
> 	struct acpi_table_header *table;
>diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>index ed80f14..0b6e0b6 100644
>--- a/include/linux/acpi.h
>+++ b/include/linux/acpi.h
>@@ -1254,9 +1254,9 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
> #endif
> 
> #ifdef CONFIG_ACPI_TABLE_UPGRADE
>-void acpi_table_upgrade(void);
>+void acpi_table_upgrade(void *data, size_t size);
> #else
>-static inline void acpi_table_upgrade(void) { }
>+static inline void acpi_table_upgrade(void *data, size_t size) { }
> #endif
> 
> #if defined(CONFIG_ACPI) && defined(CONFIG_ACPI_WATCHDOG)
>-- 
>2.7.4
>
>
>


