Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeC2Lq1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:46:27 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:59320 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbeC2L0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:26:15 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: [PATCH 102/109] kexec: move sys_kexec_load() prototype to syscalls.h
Date: Thu, 29 Mar 2018 13:24:19 +0200
Message-Id: <20180329112426.23043-103-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the syscall function should only be called from the system call table
but not from elsewhere in the kernel, move the prototype for
sys_kexec_load() to include/syscall.h.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/kexec.h    | 4 ----
 include/linux/syscalls.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f16f6ceb3875..0ebcbeb21056 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -223,10 +223,6 @@ struct kimage {
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
 extern void machine_kexec_cleanup(struct kimage *image);
-extern asmlinkage long sys_kexec_load(unsigned long entry,
-					unsigned long nr_segments,
-					struct kexec_segment __user *segments,
-					unsigned long flags);
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 815fbdd9cca1..8330f046541e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -936,6 +936,10 @@ asmlinkage long sys_pkey_mprotect(unsigned long start, size_t len,
 				  unsigned long prot, int pkey);
 asmlinkage long sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 asmlinkage long sys_pkey_free(int pkey);
+asmlinkage long sys_kexec_load(unsigned long entry,
+			       unsigned long nr_segments,
+			       struct kexec_segment __user *segments,
+			       unsigned long flags);
 asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 
-- 
2.16.3
