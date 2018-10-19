Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036CC21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036CC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJSQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:18 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36172 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727215AbeJSQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:15 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AMKI9/xJn2Gabliak2NmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfI//xwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QLYpUj?=
 =?us-ascii?q?qg8qhrUgflhicZOTAk/m/Zict+g6BVoB+6uxBz35TZbJ2POfZiYq/Qe84RS2?=
 =?us-ascii?q?pbXsZWUixMGoOyYJEUAOoAJ+lYqZT2qVsUrRSgGAajGvnvyj5UiX/1wKY31O?=
 =?us-ascii?q?ohHhvd0wwuBN8Oq3fUrdXzNKgMTeC51rLHwivaYv5QxDzz65DIfwgirPyOR7?=
 =?us-ascii?q?59cMvcxVMtGg7BlFmctI/oMj2T2+8QqWaU9fBgWviqi2M/rgFxpSWgydk0h4?=
 =?us-ascii?q?nSg4IV1kjE9SJkwIYpPdG4SFB0YdqjEJZIsyGaMJd5TdkmQ2FovyY60aEGtY?=
 =?us-ascii?q?S/fCgN1Jso3RrfZOGAc4iN+B3jVeCRLS95hHJjZr2/mw6//Euix+HmV8S50U?=
 =?us-ascii?q?xGoyhBn9XWq3wA1BLe5tCCSvRn/0eh3TiP1xrU6uFBOU00m7DUJIUvwrMrjZ?=
 =?us-ascii?q?oTskTCHinol0XqlqOZbVsr9vCy6+v7erXmuoOcN4hshw7kMaQugsm/DP88Mg?=
 =?us-ascii?q?gPWWib5Ou92KTt/U3+XbVKiOA5nbPFsJDbIsQboLS1AwhP0oYs8xy/FSup0M?=
 =?us-ascii?q?wEnXkbK1JIYBCHgJLpO17UOvD4Dumwg0+3nTh33PDKJKHuApDQLnTZjrjuYK?=
 =?us-ascii?q?t94VZGyAUv1dBf+45UCrYZLf3vXU/+qcbXAwQlPAyv2eroFNB91p4EVW2RH6?=
 =?us-ascii?q?CZLbvYsUWU6eI3P+mMeIgVtS75K/gk4f7ukHA4lUYTfamywJQYdm64EepiI0?=
 =?us-ascii?q?iCf3rsjckOEX0Qsgo9UuPqkluCXiBXZ3qoWKI8/D47Apq8DYjfXoCtnKCB3C?=
 =?us-ascii?q?CjE51SZ2BGDE2MEHjxe4WHRfgMciSSLdFlkjEfS7ihRJEu1Qu0uA/51bVnNO?=
 =?us-ascii?q?zU9TMctZ7509h1/eLTnwko9TNoF8Sdz32NT2Zsk2MGXTA5x65/rFdmyleA0a?=
 =?us-ascii?q?l4heJXFcBJ6/xSTAhpfaLbmuV5E9XaXgPHY8fMRlG7RNmvHTA2SJQ22dBdTV?=
 =?us-ascii?q?x6HoCMhxrC1iziLaUYm7GRBZc3uvbS1nL/D91+2nDLyO8rgg91EYN0KWS6i/?=
 =?us-ascii?q?snpEDoDInTnhDBmg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgQh8gVMSKIwNX41+AYhQjgmBejgBhEAChQMiNA0NAQMBAQI?=
 =?us-ascii?q?BAQIBbCiCNiKCYgZWIxBROR4ZgyGBdRGoDYN9hieHLIQ6gUE/gRGIXYUNAoh?=
 =?us-ascii?q?tlVQJhiGKSwIVgU+Ec4lnmBU4gVVNIBiDJ4ImF44cPTCBAwE9AYoyAQE?=
X-IPAS-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?Qh8gVMSKIwNX41+AYhQjgmBejgBhEAChQMiNA0NAQMBAQIBAQIBbCiCNiKCY?=
 =?us-ascii?q?gZWIxBROR4ZgyGBdRGoDYN9hieHLIQ6gUE/gRGIXYUNAohtlVQJhiGKSwIVg?=
 =?us-ascii?q?U+Ec4lnmBU4gVVNIBiDJ4ImF44cPTCBAwE9AYoyAQE?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:20:12 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 5/7 linux-next] coda: remove sysctl object from module when unused
Date:   Fri, 19 Oct 2018 10:19:31 +0200
Message-Id: <1539937173-26260-6-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1539937173-26260-1-git-send-email-fabf@skynet.be>
References: <1539937173-26260-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by NFS sysctl process

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/coda/Makefile     |  3 ++-
 fs/coda/coda_int.h   | 10 ++++++++++
 fs/coda/coda_linux.h |  4 ----
 fs/coda/sysctl.c     | 11 -----------
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/coda/Makefile b/fs/coda/Makefile
index 1bab69a..30e4e1b 100644
--- a/fs/coda/Makefile
+++ b/fs/coda/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_CODA_FS) += coda.o
 
 coda-objs := psdev.o cache.o cnode.o inode.o dir.o file.o upcall.o \
-	     coda_linux.o symlink.o pioctl.o sysctl.o 
+	     coda_linux.o symlink.o pioctl.o
+coda-$(CONFIG_SYSCTL) += sysctl.o
 
 # If you want debugging output, please uncomment the following line.
 
diff --git a/fs/coda/coda_int.h b/fs/coda/coda_int.h
index bb0b3e0..f82b59c 100644
--- a/fs/coda/coda_int.h
+++ b/fs/coda/coda_int.h
@@ -13,9 +13,19 @@ extern int coda_fake_statfs;
 void coda_destroy_inodecache(void);
 int __init coda_init_inodecache(void);
 int coda_fsync(struct file *coda_file, loff_t start, loff_t end, int datasync);
+
+#ifdef CONFIG_SYSCTL
 void coda_sysctl_init(void);
 void coda_sysctl_clean(void);
+#else
+static inline void coda_sysctl_init(void)
+{
+}
 
+static inline void coda_sysctl_clean(void)
+{
+}
+#endif
 #endif  /*  _CODA_INT_  */
 
 
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 903f2a3..4087264 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -59,10 +59,6 @@ void coda_vattr_to_iattr(struct inode *, struct coda_vattr *);
 void coda_iattr_to_vattr(struct iattr *, struct coda_vattr *);
 unsigned short coda_flags_to_cflags(unsigned short);
 
-/* sysctl.h */
-void coda_sysctl_init(void);
-void coda_sysctl_clean(void);
-
 #define CODA_ALLOC(ptr, cast, size) do { \
     if (size < PAGE_SIZE) \
         ptr = kzalloc((unsigned long) size, GFP_KERNEL); \
diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 0301d45..fda3b70 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -12,7 +12,6 @@
 
 #include "coda_int.h"
 
-#ifdef CONFIG_SYSCTL
 static struct ctl_table_header *fs_table_header;
 
 static struct ctl_table coda_table[] = {
@@ -62,13 +61,3 @@ void coda_sysctl_clean(void)
 		fs_table_header = NULL;
 	}
 }
-
-#else
-void coda_sysctl_init(void)
-{
-}
-
-void coda_sysctl_clean(void)
-{
-}
-#endif
-- 
2.4.11

