Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0A5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9C2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF9C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbeGJArQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:47:16 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45306 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933384AbeGJAqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id c192-v6so10709546qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ua1g1G0lescBbUlUdAfrf1piptZXS/FR4xQ9ZnDXWEI=;
        b=ZQbtHc6X17+/3CumgAzsa2nD38OqHHclFP2XtZWcPyLHqOv/6Uc/n5eZHRgbZQEVqf
         boBdKWht1LiGlYUWdSC/SoDihz32b/vwwQ5Gj/7UcqLidwC0xzSE/nVlQgl1eK5/nIhu
         N5Sbl+hWkGXLujl/0kU4cr6u17nzI3sHOE5+WJxk3blEL8HKByCw0/mDnTi8LtgdZeZw
         bK1LbTeNfMdT94koC6EmChm95tvJXXkvjt2sNOz72hq80JqFUULym2Gh2SyI9R0goNd+
         Zz79QgV+98cR+jOM8mkzBU+TdPqFF3opfvSvym3VU1fI4Q6rlGmELz6znE29PZ0UF3v7
         CRzA==
X-Gm-Message-State: APt69E0x5cTvSSeBTbqjRYSIhXrIXrMv3hfxhgPPlUE/36Lk4nfLnNoY
        2WVxJ3jHTx3PodFP2hqasgixqw==
X-Google-Smtp-Source: AAOMgpcCPsKlvztRV6MaUNGbN4Rl7tIifbrnBsKwsT8k0jWSnA6oMT7NO1XdR1Zcr+ZkcezH42fkLg==
X-Received: by 2002:a37:2121:: with SMTP id h33-v6mr19646402qkh.319.1531183583611;
        Mon, 09 Jul 2018 17:46:23 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:22 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCHv2 5/7] treewide: Rename HOSTLDFLAGS to KBUILD_HOSTLDFLAGS
Date:   Mon,  9 Jul 2018 17:46:00 -0700
Message-Id: <20180710004602.21599-6-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for enabling command line LDFLAGS, re-name HOSTLDFLAGS to
KBUILD_HOSTLDFLAGS as the internal use only flags. This should not have any
visible effects.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: No change
---
 Makefile               |  4 ++--
 net/bpfilter/Makefile  |  2 +-
 scripts/Makefile.host  | 10 +++++-----
 tools/build/Makefile   |  2 +-
 tools/objtool/Makefile |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 857ccd28dc36..bd2d64b89463 100644
--- a/Makefile
+++ b/Makefile
@@ -362,7 +362,7 @@ HOSTCXX      = g++
 KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
 KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
-HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
+KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
 HOST_LOADLIBES := $(HOST_LFS_LIBS)
 
 # Make variables (CC, etc...)
@@ -430,7 +430,7 @@ LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
-export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
+export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS HOST_LOADLIBES
 export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 70beeb4ad806..0947ee7f70d5 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -12,7 +12,7 @@ ifeq ($(CONFIG_BPFILTER_UMH), y)
 # builtin bpfilter_umh should be compiled with -static
 # since rootfs isn't mounted at the time of __init
 # function is called and do_execv won't find elf interpreter
-HOSTLDFLAGS += -static
+KBUILD_HOSTLDFLAGS += -static
 endif
 
 $(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 455d85aa1d37..c019d781b2c9 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -84,7 +84,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
 # Create executable from a single .c file
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
-      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(HOSTLDFLAGS) -o $@ $< \
+      cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(KBUILD_HOSTLDFLAGS) -o $@ $< \
 	  	$(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 	$(call if_changed_dep,host-csingle)
@@ -92,7 +92,7 @@ $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 # Link an executable based on list of .o files, all plain c
 # host-cmulti -> executable
 quiet_cmd_host-cmulti	= HOSTLD  $@
-      cmd_host-cmulti	= $(HOSTCC) $(HOSTLDFLAGS) -o $@ \
+      cmd_host-cmulti	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(addprefix $(obj)/,$($(@F)-objs)) \
 			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-cmulti): FORCE
@@ -109,7 +109,7 @@ $(host-cobjs): $(obj)/%.o: $(src)/%.c FORCE
 # Link an executable based on list of .o files, a mixture of .c and .cc
 # host-cxxmulti -> executable
 quiet_cmd_host-cxxmulti	= HOSTLD  $@
-      cmd_host-cxxmulti	= $(HOSTCXX) $(HOSTLDFLAGS) -o $@ \
+      cmd_host-cxxmulti	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(foreach o,objs cxxobjs,\
 			  $(addprefix $(obj)/,$($(@F)-$(o)))) \
 			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
@@ -143,7 +143,7 @@ $(host-cxxshobjs): $(obj)/%.o: $(src)/%.c FORCE
 # Link a shared library, based on position independent .o files
 # *.o -> .so shared library (host-cshlib)
 quiet_cmd_host-cshlib	= HOSTLLD -shared $@
-      cmd_host-cshlib	= $(HOSTCC) $(HOSTLDFLAGS) -shared -o $@ \
+      cmd_host-cshlib	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
 			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
 			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-cshlib): FORCE
@@ -153,7 +153,7 @@ $(call multi_depend, $(host-cshlib), .so, -objs)
 # Link a shared library, based on position independent .o files
 # *.o -> .so shared library (host-cxxshlib)
 quiet_cmd_host-cxxshlib	= HOSTLLD -shared $@
-      cmd_host-cxxshlib	= $(HOSTCXX) $(HOSTLDFLAGS) -shared -o $@ \
+      cmd_host-cxxshlib	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
 			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
 			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
 $(host-cxxshlib): FORCE
diff --git a/tools/build/Makefile b/tools/build/Makefile
index 5edf65e684ab..727050c40f09 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -43,7 +43,7 @@ $(OUTPUT)fixdep-in.o: FORCE
 	$(Q)$(MAKE) $(build)=fixdep
 
 $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
-	$(QUIET_LINK)$(HOSTCC) $(HOSTLDFLAGS) -o $@ $<
+	$(QUIET_LINK)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
 
 FORCE:
 
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index b5d8c2964b52..c9d038f91af6 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -32,7 +32,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
-LDFLAGS  += -lelf $(LIBSUBCMD) $(HOSTLDFLAGS)
+LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
-- 
2.17.1

