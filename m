Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520377096; cv=none;
        d=google.com; s=arc-20160816;
        b=i+Jla8OAOvAk+lHGZTm8dpQpWKOyL0dNOZK33T6uJbx0lKVqyjpIQLstQ5SgjWamWH
         AmPazAPokZ9XvqoiMM6d99TosK3qy2UG+rbHzNLJPFH9Vo9G5YUhaLqhJHHWtcwyTYD3
         Vvr9bOgir2wOYcKiXn3ym8Q2DOzjcaVz+i6sHdPIjKJV9okrl7IKA7x//vZjniT5dBmj
         gdLy/4xWjuQ36+1nECobvdzKrU7ZK7Svu53T1XwgxwE3qC+OHTmEThZJtIbjrE4+R5Ul
         yMgo8xeVXH4VEQuvX6pq+XC3SyWn3BgIeNzyGY+azGT3hihtEd0+5jUFHi3GFx3O+vlq
         576w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=fWbpr7uO8nK86+AKjOzyXyrPCHkQF6ybBkLoToW+FqE=;
        b=qptwam1Mg6mmDTjjNYQaGCCRIXpDpKTPzK6QRfmEt8YVL1DbkGA1iZmsp5ikjU2p8g
         hu19s6uxt9zPbX3PgDSwObqvIHIgK8vRMHO6hGsrrvjg6zh2eRKp1YIuwSNv+0aUAxjV
         CP9CBvbqjhrKSql67k+C9x+nbLi53UZqFvvwjw4WgiKscd1RDnTod7bozZb9bOj7uW1x
         iO4YY8pbMX+9W0ESfecf+bg4bShEsGyEsTOxucNn0KPlU/3Z7/sXtNt0B2H0w9KpkdQy
         UwgLWw2Mh9zjnPS7M9PAXqtniRG2MWLK0wk59FNvrE4DGltCbOAJ+RIYCbNy1gLyLKBF
         KDUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=niU+3ZD2;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=niU+3ZD2;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELu+nkGiWS4qZe47tuz2KLtmZwwuXRWOdjkBSWm5c0D5Iu5jwH2YWffpPS1jOdAifGMvi25BrA==
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lkdtm: Relocate code to subdirectory
Date: Tue,  6 Mar 2018 14:58:09 -0800
Message-Id: <1520377090-6724-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520377090-6724-1-git-send-email-keescook@chromium.org>
References: <1520377090-6724-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594230933229457960?=
X-GMAIL-MSGID: =?utf-8?q?1594230934925070400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The LKDTM modules keep expanding, and it's getting weird to have each file
get a prefix. Instead, move to a subdirectory for cleaner handling.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS                                         |  2 +-
 drivers/misc/Makefile                               | 20 +-------------------
 drivers/misc/lkdtm/Makefile                         | 20 ++++++++++++++++++++
 drivers/misc/{lkdtm_bugs.c => lkdtm/bugs.c}         |  0
 drivers/misc/{lkdtm_core.c => lkdtm/core.c}         |  0
 drivers/misc/{lkdtm_heap.c => lkdtm/heap.c}         |  0
 drivers/misc/{ => lkdtm}/lkdtm.h                    |  0
 drivers/misc/{lkdtm_perms.c => lkdtm/perms.c}       |  0
 drivers/misc/{lkdtm_refcount.c => lkdtm/refcount.c} |  0
 drivers/misc/{lkdtm_rodata.c => lkdtm/rodata.c}     |  0
 drivers/misc/{lkdtm_usercopy.c => lkdtm/usercopy.c} |  0
 11 files changed, 22 insertions(+), 20 deletions(-)
 create mode 100644 drivers/misc/lkdtm/Makefile
 rename drivers/misc/{lkdtm_bugs.c => lkdtm/bugs.c} (100%)
 rename drivers/misc/{lkdtm_core.c => lkdtm/core.c} (100%)
 rename drivers/misc/{lkdtm_heap.c => lkdtm/heap.c} (100%)
 rename drivers/misc/{ => lkdtm}/lkdtm.h (100%)
 rename drivers/misc/{lkdtm_perms.c => lkdtm/perms.c} (100%)
 rename drivers/misc/{lkdtm_refcount.c => lkdtm/refcount.c} (100%)
 rename drivers/misc/{lkdtm_rodata.c => lkdtm/rodata.c} (100%)
 rename drivers/misc/{lkdtm_usercopy.c => lkdtm/usercopy.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..942df9264d2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8146,7 +8146,7 @@ F:	drivers/*/*/*pasemi*
 LINUX KERNEL DUMP TEST MODULE (LKDTM)
 M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
-F:	drivers/misc/lkdtm*
+F:	drivers/misc/lkdtm/*
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c3c8624f4d95..20be70c3f118 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
-obj-$(CONFIG_LKDTM)		+= lkdtm.o
+obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
@@ -57,21 +57,3 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
-
-lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
-lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
-lkdtm-$(CONFIG_LKDTM)		+= lkdtm_heap.o
-lkdtm-$(CONFIG_LKDTM)		+= lkdtm_perms.o
-lkdtm-$(CONFIG_LKDTM)		+= lkdtm_refcount.o
-lkdtm-$(CONFIG_LKDTM)		+= lkdtm_rodata_objcopy.o
-lkdtm-$(CONFIG_LKDTM)		+= lkdtm_usercopy.o
-
-KCOV_INSTRUMENT_lkdtm_rodata.o	:= n
-
-OBJCOPYFLAGS :=
-OBJCOPYFLAGS_lkdtm_rodata_objcopy.o := \
-			--set-section-flags .text=alloc,readonly \
-			--rename-section .text=.rodata
-targets += lkdtm_rodata.o lkdtm_rodata_objcopy.o
-$(obj)/lkdtm_rodata_objcopy.o: $(obj)/lkdtm_rodata.o FORCE
-	$(call if_changed,objcopy)
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
new file mode 100644
index 000000000000..3370a4138e94
--- /dev/null
+++ b/drivers/misc/lkdtm/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_LKDTM)		+= lkdtm.o
+
+lkdtm-$(CONFIG_LKDTM)		+= core.o
+lkdtm-$(CONFIG_LKDTM)		+= bugs.o
+lkdtm-$(CONFIG_LKDTM)		+= heap.o
+lkdtm-$(CONFIG_LKDTM)		+= perms.o
+lkdtm-$(CONFIG_LKDTM)		+= refcount.o
+lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
+lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
+
+KCOV_INSTRUMENT_rodata.o	:= n
+
+OBJCOPYFLAGS :=
+OBJCOPYFLAGS_rodata_objcopy.o	:= \
+			--set-section-flags .text=alloc,readonly \
+			--rename-section .text=.rodata
+targets += rodata.o rodata_objcopy.o
+$(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
+	$(call if_changed,objcopy)
diff --git a/drivers/misc/lkdtm_bugs.c b/drivers/misc/lkdtm/bugs.c
similarity index 100%
rename from drivers/misc/lkdtm_bugs.c
rename to drivers/misc/lkdtm/bugs.c
diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm/core.c
similarity index 100%
rename from drivers/misc/lkdtm_core.c
rename to drivers/misc/lkdtm/core.c
diff --git a/drivers/misc/lkdtm_heap.c b/drivers/misc/lkdtm/heap.c
similarity index 100%
rename from drivers/misc/lkdtm_heap.c
rename to drivers/misc/lkdtm/heap.c
diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
similarity index 100%
rename from drivers/misc/lkdtm.h
rename to drivers/misc/lkdtm/lkdtm.h
diff --git a/drivers/misc/lkdtm_perms.c b/drivers/misc/lkdtm/perms.c
similarity index 100%
rename from drivers/misc/lkdtm_perms.c
rename to drivers/misc/lkdtm/perms.c
diff --git a/drivers/misc/lkdtm_refcount.c b/drivers/misc/lkdtm/refcount.c
similarity index 100%
rename from drivers/misc/lkdtm_refcount.c
rename to drivers/misc/lkdtm/refcount.c
diff --git a/drivers/misc/lkdtm_rodata.c b/drivers/misc/lkdtm/rodata.c
similarity index 100%
rename from drivers/misc/lkdtm_rodata.c
rename to drivers/misc/lkdtm/rodata.c
diff --git a/drivers/misc/lkdtm_usercopy.c b/drivers/misc/lkdtm/usercopy.c
similarity index 100%
rename from drivers/misc/lkdtm_usercopy.c
rename to drivers/misc/lkdtm/usercopy.c
-- 
2.7.4
