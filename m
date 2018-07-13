Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65886ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED622147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="FsTCA8Kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED622147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbeGMAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:21:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33089 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387765AbeGMAVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:21:51 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so11355510plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hqXOv/pQAA2Y4p7P/OejUXRLzoNG+pGHVAE0o7PbajM=;
        b=FsTCA8KrAlN3BGjPmGmoCXJR9MuTliR+buoJ4u/ZLctvVfzvXLlkrsaysbzz1FoyZn
         tCv7CcpYC6IPDTUV7lLoZYvcotCSFnHOrGBlfJhwftSkbhJ3VUth7HAhPPfNFoyrCVBi
         mVxTSEHvN2F+Ix0uReL7Je9aqPAOr/Vh63QudD1f/EoA23nfSP4lds6evxV7SVrNsE7W
         ffHscHsF8OyJSihTXxtMOFAdcOYELeiPUuxLDTPyrrO6WdiUcbA3TIXxRY73wWsCJuD+
         ++xpea5T4CVRdeORnPzbw+M2bmIYzBADuuHiSbUqVjjShC6hhnVpreNVMHKGvuFYJyDu
         AWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hqXOv/pQAA2Y4p7P/OejUXRLzoNG+pGHVAE0o7PbajM=;
        b=OwnSUOsPlKn2G7GUhSVrT+k1InXXA0QbryZ3OVohXodtYWzpVdHqCjNdys12nQnqxG
         YSHEeTWhwIpkH/Ws6jnTVN2sfNoXBzScZ3ZhEC3E8TnaJM7YXdgj9An6Y5MohuatDTIH
         WllpQf/BqPB7DxpNiODbBPElGxCWrHto1rLoJ+JB6o4KzQ3/IvW8Ou2YW9tmWmCjXIDZ
         nIQyr1pCQRc/Dg9cVDI8sq5WlRo/tpA7pX5w5YkV+d28vDTQ/vGbVZcf56bicjZPwToy
         o4vzqhxnHLpd5Myp0joKGMMYgHc3y35RRpDqT1v4Q/j9r8UDRrWjls2Djl7/LBbXi8rz
         Dqqw==
X-Gm-Message-State: AOUpUlHNlBx1elhFkXeTmnS4VIppnZ8cCfIf+vzi55dberpQfNo0GJRa
        2nA+vZEspswaVvoOCe3esteW814206w=
X-Google-Smtp-Source: AAOMgpdc/1ly9RzxBiZduIXDJsMUDrBY2IE7abgSGs3HuZFVHrS+xqzdIhcr7k0CK4DKFIztTadPVg==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr4133472pld.289.1531440593539;
        Thu, 12 Jul 2018 17:09:53 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:74a0])
        by smtp.gmail.com with ESMTPSA id b86-v6sm4452067pfj.35.2018.07.12.17.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:09:52 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v2 7/7] proc/kcore: add vmcoreinfo note to /proc/kcore
Date:   Thu, 12 Jul 2018 17:09:39 -0700
Message-Id: <19c55add0fd15854798dde00d93350d76034896d.1531440458.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531440458.git.osandov@fb.com>
References: <cover.1531440458.git.osandov@fb.com>
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
index d1b875afc359..bef78923b387 100644
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

