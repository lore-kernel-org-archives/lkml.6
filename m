Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FEAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D191E21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="sQhEANfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D191E21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeKLPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:47:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37530 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeKLPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:47:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so3547699pge.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SYR6fS30aatFFhnOk6MmgadwC6xWSDexCl9TuLKHYXs=;
        b=sQhEANfaG0eK5sUFtPMxtcU87IoBnWKMDMvGsi5827t7LIPP4tiYc49nn8KhwibHZH
         zTILiIosQSNRAkTh+A/EkqPXgJuWqLJ+8IKRKwJW/JLK6kIxFtIxduTgOtaw1D3O7iJ/
         if52FnZafybRTPt2sxugSa7oEy1/NdS8/HWztfG0Rx9jETWoqvzprD2jsf7CBoNbgipJ
         pkwGi/I7s6IXdVLVT2VU744HUfa8KQVyUcbmZYbDeocHPw6KkLMHdofgNDuiKkgifYxS
         SwWDwFa1+ChBxIlyE8YQEeAU3XFdvL3EUGIJhMappjlfeLgtC5enHWQJQ+Qvin/+ebSY
         mNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SYR6fS30aatFFhnOk6MmgadwC6xWSDexCl9TuLKHYXs=;
        b=o4Pqq/ARgGSII7vngfz2bAn6NcwbvBgTrICdeJjS8rg0DIJ2pggWangJ/1RrkM3G3W
         eY/ZCZEo3nfYBVFmHBFJbZ+S7u5RzewRWXPuDcWmH+mmC2sCk77gJSNtrhSFUf2lPEfb
         TmJZga7b8Opk7BDBKhozIuV9sndKemuxkbb9dBXYGFUtoPx9Ejj4lTkkbgb+NrqWlc8A
         0rerLV5aFrzpY9WoKNwbYFXGQVquy0BVhUkpHQcZpKftLwkJjhXPizHA5LkmFZbYbzn2
         ECQfMl/UFkju1s/ViTcpWb8CeWCRUZDvLTn24kXZRWAGiHCYa1JrVajoU11m5lK9G5px
         AsjQ==
X-Gm-Message-State: AGRZ1gKJNNZ/kW8dEHmx4MHHer2JCmGOScehkN2bi7LuJ97naTodeCPp
        dlW0wG8Yfmz8nUR7F6zqY/vqig==
X-Google-Smtp-Source: AJdET5eiGyEFp7BCNGC3LaGI5IYYm3/k38mtLjDuZeCtknmHlY4o0tbgTjTNL2d2UK+3oJJOqRAoJw==
X-Received: by 2002:a65:624c:: with SMTP id q12mr2895654pgv.379.1542002128062;
        Sun, 11 Nov 2018 21:55:28 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id 124-v6sm34463799pfb.132.2018.11.11.21.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 21:55:27 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH] RISC-V: Build flat and compressed kernel images
Date:   Mon, 12 Nov 2018 11:25:15 +0530
Message-Id: <20181112055515.20341-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends Linux RISC-V build system to build and install:
Image - Flat uncompressed kernel image
Image.gz - Flat and GZip compressed kernel image

Quiet a few bootloaders (such as Uboot, UEFI, etc) are capable of
booting flat and compressed kernel images. In case of Uboot, booting
Image or Image.gz is achieved using bootm command.

The flat and uncompressed kernel image (i.e. Image) is very useful
in pre-silicon developent and testing because we can create back-door
HEX files for RAM on FPGAs from Image.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Makefile             | 15 ++++++++-
 arch/riscv/boot/.gitignore      |  2 ++
 arch/riscv/boot/Makefile        | 33 ++++++++++++++++++
 arch/riscv/boot/install.sh      | 60 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/head.S        | 10 ++++++
 arch/riscv/kernel/vmlinux.lds.S |  2 +-
 6 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/boot/.gitignore
 create mode 100644 arch/riscv/boot/Makefile
 create mode 100644 arch/riscv/boot/install.sh

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index d10146197533..d117a60362eb 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -71,10 +71,23 @@ KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
 # arch specific predefines for sparse
 CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
 
+# Default target when executing plain make
+boot		:= arch/riscv/boot
+KBUILD_IMAGE	:= $(boot)/Image.gz
+
 head-y := arch/riscv/kernel/head.o
 
 core-y += arch/riscv/kernel/ arch/riscv/mm/
 
 libs-y += arch/riscv/lib/
 
-all: vmlinux
+all: Image.gz
+
+Image: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+Image.%: Image
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+zinstall install:
+	$(Q)$(MAKE) $(build)=$(boot) $@
diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
new file mode 100644
index 000000000000..8dab0bb6ae66
--- /dev/null
+++ b/arch/riscv/boot/.gitignore
@@ -0,0 +1,2 @@
+Image
+Image.gz
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
new file mode 100644
index 000000000000..0990a9fdbe5d
--- /dev/null
+++ b/arch/riscv/boot/Makefile
@@ -0,0 +1,33 @@
+#
+# arch/riscv/boot/Makefile
+#
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2018, Anup Patel.
+# Author: Anup Patel <anup@brainfault.org>
+#
+# Based on the ia64 and arm64 boot/Makefile.
+#
+
+OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+
+targets := Image
+
+$(obj)/Image: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/Image.gz: $(obj)/Image FORCE
+	$(call if_changed,gzip)
+
+install:
+	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(obj)/Image System.map "$(INSTALL_PATH)"
+
+zinstall:
+	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
new file mode 100644
index 000000000000..18c39159c0ff
--- /dev/null
+++ b/arch/riscv/boot/install.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# arch/riscv/boot/install.sh
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
+# Adapted from code in arch/i386/boot/install.sh by Russell King
+#
+# "make install" script for the RISC-V Linux port
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - kernel image file
+#   $3 - kernel map file
+#   $4 - default install path (blank if root directory)
+#
+
+verify () {
+	if [ ! -f "$1" ]; then
+		echo ""                                                   1>&2
+		echo " *** Missing file: $1"                              1>&2
+		echo ' *** You need to run "make" before "make install".' 1>&2
+		echo ""                                                   1>&2
+		exit 1
+	fi
+}
+
+# Make sure the files actually exist
+verify "$2"
+verify "$3"
+
+# User may have a custom install script
+if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
+if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+
+if [ "$(basename $2)" = "Image.gz" ]; then
+# Compressed install
+  echo "Installing compressed kernel"
+  base=vmlinuz
+else
+# Normal install
+  echo "Installing normal kernel"
+  base=vmlinux
+fi
+
+if [ -f $4/$base-$1 ]; then
+  mv $4/$base-$1 $4/$base-$1.old
+fi
+cat $2 > $4/$base-$1
+
+# Install system map file
+if [ -f $4/System.map-$1 ]; then
+  mv $4/System.map-$1 $4/System.map-$1.old
+fi
+cp $3 $4/System.map-$1
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 711190d473d4..fe884cd69abd 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -44,6 +44,16 @@ ENTRY(_start)
 	amoadd.w a3, a2, (a3)
 	bnez a3, .Lsecondary_start
 
+	/* Clear BSS for flat non-ELF images */
+	la a3, __bss_start
+	la a4, __bss_stop
+	ble a4, a3, clear_bss_done
+clear_bss:
+	REG_S zero, (a3)
+	add a3, a3, RISCV_SZPTR
+	blt a3, a4, clear_bss
+clear_bss_done:
+
 	/* Save hart ID and DTB physical address */
 	mv s0, a0
 	mv s1, a1
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index ece84991609c..65df1dfdc303 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -74,7 +74,7 @@ SECTIONS
 		*(.sbss*)
 	}
 
-	BSS_SECTION(0, 0, 0)
+	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
 	EXCEPTION_TABLE(0x10)
 	NOTES
-- 
2.17.1

