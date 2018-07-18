Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B674ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="u919IaPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B9E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGRXj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42616 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbeGRXj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so2885476pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m1/hDZna1k9kEadKgQvnzi8gv4717mSyGgIlzsk+u7g=;
        b=u919IaPMgov9aSaeendZxG49ChQnWO8WYKxWfz/D6k1ZSKsT1lxJALQF7r8C6Pj/wS
         FWkjJowJ8INwb7BmXjcfftqAV7IDklZFTKXTVUPCdoaaBvx6F56kIS2HoE9sDNodx9ET
         o6acHtl3rJZHad174AW7f4DY5x+Db3K+mEWSUVki+t28TyHgtV5VKWOt5BL/9fcAb/8A
         MROB8Dcx92EaFcV7FU58roSSYkkBJ+JqVcMCGweTFFTS/7Bs+rKGoNZgdqAKcw1hSFF/
         rEsNXjbe08IUiwixTESBZLQkrJvKfg7xwnAk1GZF83/ZitHPJsBWxHycQmKQWoer89Ph
         HdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m1/hDZna1k9kEadKgQvnzi8gv4717mSyGgIlzsk+u7g=;
        b=Urr6V2WIkn/bXwE7KjHFZ7iQTHxRsMklODB3lZl3F2bYMh0rH1AmAvSRYOI1ti2whW
         /mky8fMOW/KQxl/3rCVqalC3S/NRlEzT4ABW3bCU6lOq7PyNTGV1vwzN/qM0U2tmS4kJ
         gUUmA7uokU+vaYZzsEroJ6Tq5H+p28EkX2COArSQ86zV2J7BPULQkrM+FBHy+SXLrzTQ
         2aUI/gN1OcTx8qaSAO4N+Ds8+W0ZgfOlLwX/YNlfWGM/By+6lK9+QNQd6mJxK1AAif+H
         hHJEcaUdyd5csBK/wcbbY7hM6d3rVZ597qw2TLtdeu0yDZ7dycstokcT9NCaRbr85h7P
         Kang==
X-Gm-Message-State: AOUpUlGqNflaNLBhXvup7Dv0OX51Mg2ev2NvmymZCDIv12+r6u9mQZrt
        OweIXm892tVcR3ksARaBmMRivq/vscc=
X-Google-Smtp-Source: AAOMgpccKFMvRyZ8s06QRau9vUfPWuihv9MIiFo/t3wA4ZJx95VmHM5ziTQ8Q3yIhU2sQnG1QrjjRQ==
X-Received: by 2002:a63:5964:: with SMTP id j36-v6mr7637540pgm.222.1531954761700;
        Wed, 18 Jul 2018 15:59:21 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:21 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 8/8] proc/kcore: add vmcoreinfo note to /proc/kcore
Date:   Wed, 18 Jul 2018 15:58:48 -0700
Message-Id: <fddbcd08eed76344863303878b12de1c1e2a04b6.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531953780.git.osandov@fb.com>
References: <cover.1531953780.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The vmcoreinfo information is useful for runtime debugging tools, not
just for crash dumps. A lot of this information can be determined by
other means, but this is much more convenient, and it only adds a page
at most to the file.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/Kconfig            |  1 +
 fs/proc/kcore.c            | 18 ++++++++++++++++--
 include/linux/crash_core.h |  2 ++
 kernel/crash_core.c        |  4 ++--
 4 files changed, 21 insertions(+), 4 deletions(-)

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
index 25fefdd05ee5..ab7c1a1dad50 100644
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
@@ -406,6 +410,16 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				  sizeof(prpsinfo));
 		append_kcore_note(notes, &i, CORE_STR, NT_TASKSTRUCT, current,
 				  arch_task_struct_size);
+		/*
+		 * vmcoreinfo_size is mostly constant after init time, but it
+		 * can be changed by crash_save_vmcoreinfo(). Racing here with a
+		 * panic on another CPU before the machine goes down is insanely
+		 * unlikely, but it's better to not leave potential buffer
+		 * overflows lying around, regardless.
+		 */
+		append_kcore_note(notes, &i, VMCOREINFO_NOTE_NAME, 0,
+				  vmcoreinfo_data,
+				  min(vmcoreinfo_size, notes_len - i));
 
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

