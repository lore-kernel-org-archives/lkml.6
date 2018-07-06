Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0493FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33DC22CA0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="wM1ldJvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33DC22CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934823AbeGFTc5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:32:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36968 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934789AbeGFTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id h20-v6so9183377pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=azaOCgzuDqG+aLW9vsDGR0WxQlTHNvuiWQ54EH9LC3g=;
        b=wM1ldJvvanU/MeY1KzzLj5SQ9MKeICGiOswiXPNGbl4XiJHylg+rcxa4e/9xv92sNI
         c+0oQk4Xa/fHwWcfSL1yylBv/cilZn5f2I4UQYPc2Za8qzb2dPvaG54SOV/EszEXywOy
         l6x32iAcaq+taiVsN/4yvpDIlKONHZe2PoaN6qaj9enaefEtFidz5J0cpRv2pkIRTILl
         vem6Og/OMSAxMC6DB+WX9E9wYH9FLFZIxLhvlnJX/THeOKESfPvr+mI/zT6MWJl2If7Z
         XzhrICSLaQCh8by+tPwMZr64i30mMI+TCvhKQKAXEOTZPY7WCdAnAFWo+f29M8FjvJvu
         HoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=azaOCgzuDqG+aLW9vsDGR0WxQlTHNvuiWQ54EH9LC3g=;
        b=TgGrm3dH4pqVxyjDV3MMoRhKaxwjRjJtzf37UOkWMqnQjAX8Ljftncg9sgJ6tDlXj1
         0VrRK18b7gDvP3rcq7BRUs1/pQnl2BQnruGqifBPJzicx0nuxOvCwz7ocpsTpphwyZnN
         RUKqMxlNvOxhUDnkdPYN0JDu13stdsxO7ic/8jfZIqyQtS57DPFPUx/ysl4V6PJ6GxJy
         Z5YAKbpv2fMKega1aGJBUTeNdle0YTorbOImHnJRrtlprn89KuPRcrbOj8oqrVoWp7w4
         tDIy48W2yq7xr305TJuXMX6GxqmPSpDcSI13Z0FtTvzRyrQod4PyKXq15rujlXsQov2e
         aIdg==
X-Gm-Message-State: APt69E1VzrncQWT8JzqNIanARIvNzg9ecSGHn7Jsf5UW20IDYTZEId9c
        MfejnXHVeUqvBLija2yLamKPfmmtKTE=
X-Google-Smtp-Source: AAOMgpe+1P+2bk8vaNjVHCc0aY27kfEsZqT9v0YiBQSWzEVn7RkLRfsyod3GyLEO5+I1towyEOWheg==
X-Received: by 2002:a62:32c4:: with SMTP id y187-v6mr11795464pfy.241.1530905572500;
        Fri, 06 Jul 2018 12:32:52 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:51 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 7/7] proc/kcore: add vmcoreinfo note to /proc/kcore
Date:   Fri,  6 Jul 2018 12:32:38 -0700
Message-Id: <3deb2f4781fa3ad42321227c3f4473e3c163e21c.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530904769.git.osandov@fb.com>
References: <cover.1530904769.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The vmcoreinfo information is useful for runtime debugging tools, not
just for crash dumps. A lot of this information can be determined by
other means, but this is much more convenient.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/Kconfig            |  1 +
 fs/proc/kcore.c            | 10 ++++++++--
 include/linux/crash_core.h |  2 ++
 kernel/crash_core.c        |  4 ++--
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 0eaeb41453f5..817c02b13b1d 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -31,6 +31,7 @@ config PROC_FS
 config PROC_KCORE
 	bool "/proc/kcore support" if !ARM
 	depends on PROC_FS && MMU
+	select CRASH_CORE
 	help
 	  Provides a virtual ELF core file of the live kernel.  This can
 	  be read with gdb and other ELF tools.  No modifications can be
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index f1e21579cd22..49537c4d78ab 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -10,6 +10,7 @@
  *	Safe accesses to vmalloc/direct-mapped discontiguous areas, Kanoj Sarcar <kanoj@sgi.com>
  */
 
+#include <linux/crash_core.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/kcore.h>
@@ -81,10 +82,13 @@ static size_t get_kcore_size(int *nphdr, size_t *phdrs_len, size_t *notes_len,
 	}
 
 	*phdrs_len = *nphdr * sizeof(struct elf_phdr);
-	*notes_len = (3 * (sizeof(struct elf_note) + ALIGN(sizeof(CORE_STR), 4)) +
+	*notes_len = (4 * sizeof(struct elf_note) +
+		      3 * ALIGN(sizeof(CORE_STR), 4) +
+		      VMCOREINFO_NOTE_NAME_BYTES +
 		      ALIGN(sizeof(struct elf_prstatus), 4) +
 		      ALIGN(sizeof(struct elf_prpsinfo), 4) +
-		      ALIGN(arch_task_struct_size, 4));
+		      ALIGN(arch_task_struct_size, 4) +
+		      ALIGN(vmcoreinfo_size, 4));
 	*data_offset = PAGE_ALIGN(sizeof(struct elfhdr) + *phdrs_len +
 				  *notes_len);
 	return *data_offset + size;
@@ -404,6 +408,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				  sizeof(prpsinfo));
 		append_kcore_note(notes, &i, CORE_STR, NT_TASKSTRUCT, current,
 				  arch_task_struct_size);
+		append_kcore_note(notes, &i, VMCOREINFO_NOTE_NAME, 0,
+				  vmcoreinfo_data, vmcoreinfo_size);
 
 		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
 		if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index b511f6d24b42..525510a9f965 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -60,6 +60,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 #define VMCOREINFO_CONFIG(name) \
 	vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
 
+extern unsigned char *vmcoreinfo_data;
+extern size_t vmcoreinfo_size;
 extern u32 *vmcoreinfo_note;
 
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b66aced5e8c2..d02c58b94460 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -14,8 +14,8 @@
 #include <asm/sections.h>
 
 /* vmcoreinfo stuff */
-static unsigned char *vmcoreinfo_data;
-static size_t vmcoreinfo_size;
+unsigned char *vmcoreinfo_data;
+size_t vmcoreinfo_size;
 u32 *vmcoreinfo_note;
 
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
-- 
2.18.0

