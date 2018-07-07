Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7999DC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290542255D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290542255D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGGBId (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:08:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46234 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbeGGBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:07:31 -0400
Received: by mail-qt0-f196.google.com with SMTP id h5-v6so11388941qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G8bm2A6jdNl0stTUH/JzRpL8g4uxF5q/j6B4Lylu5iE=;
        b=klzHxCniSmbLipo7oZd8BVxUB8Ix3QKYD+KCBmev6ZNlSg46QN5cu1TvYptTBN0nql
         JVzX2d7PHivRJDm8Icqh5cE4g+Kvy3/F39CSs4s/aINS6+ABmdpHKlnSMD6SL4ZlLiXz
         Btvx7fZPfWGd/nTT6vh9p6FSIlrm8CKMq2ZL2I9nEGN+68T9UFcqfhkpo73uFYCwSMas
         8nDc1IgiOZhnbdBpLJGwaphpTKqRinFnIiw5SMUyD922oAl47/CAzc9qtHvMehmYA/yd
         zoqbbevDmhY2ezhBx4iQ1kIuvuTSH8/chwjRr8iaOeqdSMpNYTuWjj9DQPplcrPQj/e5
         NSyQ==
X-Gm-Message-State: APt69E0wplIMQv582f+EUYZ4R9U11xXMZTaUMOvZYQq5lzE5QGCcg2vF
        v8a/IBm/eDUS6l1mJW5/YajHqg==
X-Google-Smtp-Source: AAOMgpdQVJzXF0ub1/fvXdl7xS3/vVTAxTf452F7XU/qRtwZXm3wEnjC5wQHK/Npm1OnGXwxitjGPg==
X-Received: by 2002:ac8:2a46:: with SMTP id l6-v6mr11696989qtl.118.1530925650896;
        Fri, 06 Jul 2018 18:07:30 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3359698qtg.20.2018.07.06.18.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 18:07:29 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH 3/7] treewide: Rename HOSTCFLAGS -> KBUILD_HOSTCFLAGS
Date:   Fri,  6 Jul 2018 18:07:05 -0700
Message-Id: <20180707010709.16648-4-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707010709.16648-1-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for enabling command line CFLAGS, re-name HOSTCFLAGS to
KBUILD_HOSTCFLAGS as the internal use only flags. This should not have any
visible effects.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Makefile                   |  4 ++--
 arch/alpha/boot/Makefile   |  2 +-
 arch/s390/tools/Makefile   |  4 ++--
 arch/x86/tools/Makefile    |  4 ++--
 net/bpfilter/Makefile      |  2 +-
 samples/bpf/Makefile       | 26 +++++++++++++-------------
 samples/connector/Makefile |  2 +-
 samples/hidraw/Makefile    |  2 +-
 samples/seccomp/Makefile   | 24 ++++++++++++------------
 samples/statx/Makefile     |  2 +-
 samples/uhid/Makefile      |  2 +-
 scripts/Kbuild.include     |  2 +-
 scripts/Makefile           |  4 ++--
 scripts/Makefile.host      |  4 ++--
 scripts/dtc/Makefile       | 24 ++++++++++++------------
 scripts/genksyms/Makefile  |  4 ++--
 scripts/kconfig/Makefile   | 12 ++++++------
 tools/build/Build.include  |  2 +-
 tools/objtool/Makefile     |  2 +-
 19 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/Makefile b/Makefile
index d15ac32afbaf..16cab22b1f40 100644
--- a/Makefile
+++ b/Makefile
@@ -359,7 +359,7 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS)
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
+KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
 HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
 HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
@@ -429,7 +429,7 @@ KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
 LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
-export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
+export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
 export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
diff --git a/arch/alpha/boot/Makefile b/arch/alpha/boot/Makefile
index 0cbe4c59d3ce..dfccf0195306 100644
--- a/arch/alpha/boot/Makefile
+++ b/arch/alpha/boot/Makefile
@@ -14,7 +14,7 @@ targets		:= vmlinux.gz vmlinux \
 		   tools/bootpzh bootloader bootpheader bootpzheader 
 OBJSTRIP	:= $(obj)/tools/objstrip
 
-HOSTCFLAGS	:= -Wall -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS	:= -Wall -I$(objtree)/usr/include
 BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
 
 # SRM bootable image.  Copy to offset 512 of a partition.
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 48cdac1143a9..40afcebf4e67 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -14,8 +14,8 @@ kapi:	$(kapi-hdrs-y)
 hostprogs-y		    += gen_facilities
 hostprogs-y		    += gen_opcode_table
 
-HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
-HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)
+KBUILD_HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
+KBUILD_HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)
 
 # Ensure output directory exists
 _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 09af7ff53044..140de7589aa2 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -29,9 +29,9 @@ posttest: $(obj)/insn_decoder_test vmlinux $(obj)/insn_sanity
 hostprogs-y	+= insn_decoder_test insn_sanity
 
 # -I needed for generated C source and C source which in the kernel tree.
-HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/uapi/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/uapi/
+KBUILD_HOSTCFLAGS_insn_decoder_test.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/uapi/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/uapi/
 
-HOSTCFLAGS_insn_sanity.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/
+KBUILD_HOSTCFLAGS_insn_sanity.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/
 
 # Dependencies are also needed.
 $(obj)/insn_decoder_test.o: $(srctree)/arch/x86/lib/insn.c $(srctree)/arch/x86/lib/inat.c $(srctree)/arch/x86/include/asm/inat_types.h $(srctree)/arch/x86/include/asm/inat.h $(srctree)/arch/x86/include/asm/insn.h $(objtree)/arch/x86/lib/inat-tables.c
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 39c6980b5d99..70beeb4ad806 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -5,7 +5,7 @@
 
 hostprogs-y := bpfilter_umh
 bpfilter_umh-objs := main.o
-HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
+KBUILD_HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
 HOSTCC := $(CC)
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1303af10e54d..09f90955412e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -164,21 +164,21 @@ always += xdpsock_kern.o
 always += xdp_fwd_kern.o
 always += task_fd_query_kern.o
 
-HOSTCFLAGS += -I$(objtree)/usr/include
-HOSTCFLAGS += -I$(srctree)/tools/lib/
-HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
-HOSTCFLAGS += -I$(srctree)/tools/perf
+KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS += -I$(srctree)/tools/lib/
+KBUILD_HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
+KBUILD_HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
+KBUILD_HOSTCFLAGS += -I$(srctree)/tools/perf
 
-HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
-HOSTCFLAGS_trace_helpers.o += -I$(srctree)/tools/lib/bpf/
+KBUILD_HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
+KBUILD_HOSTCFLAGS_trace_helpers.o += -I$(srctree)/tools/lib/bpf/
 
-HOSTCFLAGS_trace_output_user.o += -I$(srctree)/tools/lib/bpf/
-HOSTCFLAGS_offwaketime_user.o += -I$(srctree)/tools/lib/bpf/
-HOSTCFLAGS_spintest_user.o += -I$(srctree)/tools/lib/bpf/
-HOSTCFLAGS_trace_event_user.o += -I$(srctree)/tools/lib/bpf/
-HOSTCFLAGS_sampleip_user.o += -I$(srctree)/tools/lib/bpf/
-HOSTCFLAGS_task_fd_query_user.o += -I$(srctree)/tools/lib/bpf/
+KBUILD_HOSTCFLAGS_trace_output_user.o += -I$(srctree)/tools/lib/bpf/
+KBUILD_HOSTCFLAGS_offwaketime_user.o += -I$(srctree)/tools/lib/bpf/
+KBUILD_HOSTCFLAGS_spintest_user.o += -I$(srctree)/tools/lib/bpf/
+KBUILD_HOSTCFLAGS_trace_event_user.o += -I$(srctree)/tools/lib/bpf/
+KBUILD_HOSTCFLAGS_sampleip_user.o += -I$(srctree)/tools/lib/bpf/
+KBUILD_HOSTCFLAGS_task_fd_query_user.o += -I$(srctree)/tools/lib/bpf/
 
 HOST_LOADLIBES		+= $(LIBBPF) -lelf
 HOSTLOADLIBES_tracex4		+= -lrt
diff --git a/samples/connector/Makefile b/samples/connector/Makefile
index fe3c8542ae4a..a29fbe0c93cf 100644
--- a/samples/connector/Makefile
+++ b/samples/connector/Makefile
@@ -9,7 +9,7 @@ endif
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
-HOSTCFLAGS_ucon.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_ucon.o += -I$(objtree)/usr/include
 
 all: modules
 
diff --git a/samples/hidraw/Makefile b/samples/hidraw/Makefile
index dec1b22adf54..67cead2a5f56 100644
--- a/samples/hidraw/Makefile
+++ b/samples/hidraw/Makefile
@@ -5,6 +5,6 @@ hostprogs-y := hid-example
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
-HOSTCFLAGS_hid-example.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_hid-example.o += -I$(objtree)/usr/include
 
 all: hid-example
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index ba942e3ead89..59eda1340859 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -2,18 +2,18 @@
 ifndef CROSS_COMPILE
 hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
 
-HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
-HOSTCFLAGS_bpf-helper.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-helper.o += -idirafter $(objtree)/include
+KBUILD_HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
+KBUILD_HOSTCFLAGS_bpf-helper.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_bpf-helper.o += -idirafter $(objtree)/include
 bpf-fancy-objs := bpf-fancy.o bpf-helper.o
 
-HOSTCFLAGS_dropper.o += -I$(objtree)/usr/include
-HOSTCFLAGS_dropper.o += -idirafter $(objtree)/include
+KBUILD_HOSTCFLAGS_dropper.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_dropper.o += -idirafter $(objtree)/include
 dropper-objs := dropper.o
 
-HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
+KBUILD_HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
 bpf-direct-objs := bpf-direct.o
 
 # Try to match the kernel target.
@@ -26,10 +26,10 @@ else
 MFLAG = -m31
 endif
 
-HOSTCFLAGS_bpf-direct.o += $(MFLAG)
-HOSTCFLAGS_dropper.o += $(MFLAG)
-HOSTCFLAGS_bpf-helper.o += $(MFLAG)
-HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
+KBUILD_HOSTCFLAGS_bpf-direct.o += $(MFLAG)
+KBUILD_HOSTCFLAGS_dropper.o += $(MFLAG)
+KBUILD_HOSTCFLAGS_bpf-helper.o += $(MFLAG)
+KBUILD_HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
 HOSTLOADLIBES_bpf-direct += $(MFLAG)
 HOSTLOADLIBES_bpf-fancy += $(MFLAG)
 HOSTLOADLIBES_dropper += $(MFLAG)
diff --git a/samples/statx/Makefile b/samples/statx/Makefile
index 59df7c25a9d1..e22a682a9fa0 100644
--- a/samples/statx/Makefile
+++ b/samples/statx/Makefile
@@ -4,4 +4,4 @@ hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
-HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/uhid/Makefile b/samples/uhid/Makefile
index 8d7fd6190ac4..aa77a2fa063a 100644
--- a/samples/uhid/Makefile
+++ b/samples/uhid/Makefile
@@ -4,4 +4,4 @@ hostprogs-y := uhid-example
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
-HOSTCFLAGS_uhid-example.o += -I$(objtree)/usr/include
+KBUILD_HOSTCFLAGS_uhid-example.o += -I$(objtree)/usr/include
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c8156d61678c..827344dfb185 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -126,7 +126,7 @@ cc-option = $(call __cc-option, $(CC),\
 # hostcc-option
 # Usage: cflags-y += $(call hostcc-option,-march=winchip-c6,-march=i586)
 hostcc-option = $(call __cc-option, $(HOSTCC),\
-	$(HOSTCFLAGS) $(HOST_EXTRACFLAGS),$(1),$(2))
+	$(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS),$(1),$(2))
 
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn,-march=winchip-c6)
diff --git a/scripts/Makefile b/scripts/Makefile
index 25ab143cbe14..43dad0e066ac 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -20,8 +20,8 @@ hostprogs-$(CONFIG_MODULE_SIG)	 += sign-file
 hostprogs-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += extract-cert
 hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
 
-HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
-HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
+KBUILD_HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
+KBUILD_HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTLOADLIBES_sign-file = -lcrypto
 HOSTLOADLIBES_extract-cert = -lcrypto
 
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index aa971cc3f339..7a4c90f2b0ce 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -62,8 +62,8 @@ host-cxxshobjs	:= $(addprefix $(obj)/,$(host-cxxshobjs))
 #####
 # Handle options to gcc. Support building with separate output directory
 
-_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
-                 $(HOSTCFLAGS_$(basetarget).o)
+_hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
+                 $(KBUILD_HOSTCFLAGS_$(basetarget).o)
 _hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(basetarget).o)
 
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 9cac65b7419c..b85ff7234e7c 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -10,20 +10,20 @@ dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
 # Source files need to get at the userspace version of libfdt_env.h to compile
 
-HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
+KBUILD_HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
 
-HOSTCFLAGS_checks.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_data.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_dtc.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_flattree.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_fstree.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_livetree.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_srcpos.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_treesource.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_util.o := $(HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_checks.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_data.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_dtc.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_flattree.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_fstree.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_livetree.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_srcpos.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_treesource.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_util.o := $(KBUILD_HOSTCFLAGS_DTC)
 
-HOSTCFLAGS_dtc-lexer.lex.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_dtc-parser.tab.o := $(HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_dtc-lexer.lex.o := $(KBUILD_HOSTCFLAGS_DTC)
+KBUILD_HOSTCFLAGS_dtc-parser.tab.o := $(KBUILD_HOSTCFLAGS_DTC)
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
index 03b7ce97de14..001ae41baa26 100644
--- a/scripts/genksyms/Makefile
+++ b/scripts/genksyms/Makefile
@@ -31,8 +31,8 @@ $(obj)/parse.tab.h: $(src)/parse.y FORCE
 endif
 
 # -I needed for generated C source (shipped source)
-HOSTCFLAGS_parse.tab.o := -I$(src)
-HOSTCFLAGS_lex.lex.o := -I$(src)
+KBUILD_HOSTCFLAGS_parse.tab.o := -I$(src)
+KBUILD_HOSTCFLAGS_lex.lex.o := -I$(src)
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/lex.lex.o: $(obj)/parse.tab.h
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index a3ac2c91331c..f98a22618e1f 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -162,16 +162,16 @@ hostprogs-y := conf
 targets		+= zconf.lex.c
 
 # generated files seem to need this to find local include files
-HOSTCFLAGS_zconf.lex.o	:= -I$(src)
-HOSTCFLAGS_zconf.tab.o	:= -I$(src)
+KBUILD_HOSTCFLAGS_zconf.lex.o	:= -I$(src)
+KBUILD_HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
 # nconf: Used for the nconfig target based on ncurses
 hostprogs-y	+= nconf
 nconf-objs	:= nconf.o zconf.tab.o nconf.gui.o
 
 HOSTLOADLIBES_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
-HOSTCFLAGS_nconf.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
-HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
+KBUILD_HOSTCFLAGS_nconf.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
+KBUILD_HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
 
 $(obj)/nconf.o: $(obj)/.nconf-cfg
 
@@ -182,7 +182,7 @@ mconf-objs	:= mconf.o zconf.tab.o $(addprefix lxdialog/, $(lxdialog))
 
 HOSTLOADLIBES_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
 $(foreach f, mconf.o $(lxdialog), \
-  $(eval HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
+  $(eval KBUILD_HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
 
 $(addprefix $(obj)/, mconf.o $(lxdialog)): $(obj)/.mconf-cfg
 
@@ -207,7 +207,7 @@ hostprogs-y	+= gconf
 gconf-objs	:= gconf.o zconf.tab.o
 
 HOSTLOADLIBES_gconf = $(shell . $(obj)/.gconf-cfg && echo $$libs)
-HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
+KBUILD_HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
 
 $(obj)/gconf.o: $(obj)/.gconf-cfg
 
diff --git a/tools/build/Build.include b/tools/build/Build.include
index b5c679cd441c..84e688bbb122 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -98,4 +98,4 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
 ###
 ## HOSTCC C flags
 
-host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
+host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(KBUILD_HOSTCFLAGS_$(basetarget).o) $(KBUILD_HOSTCFLAGS_$(obj))
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index f76d9914686a..b5d8c2964b52 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,7 +31,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(HOSTCFLAGS) -g $(INCLUDES)
+CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
 LDFLAGS  += -lelf $(LIBSUBCMD) $(HOSTLDFLAGS)
 
 # Allow old libelf to be used:
-- 
2.17.1

