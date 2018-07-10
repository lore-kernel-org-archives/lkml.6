Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40C42083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40C42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeGJAql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:46:41 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40081 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933412AbeGJAq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:26 -0400
Received: by mail-qt0-f172.google.com with SMTP id h4-v6so16997317qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BeaYs0gOOdzuM0e3tMBR4mOByPCFLqz/qCfB9bqK1po=;
        b=IexoMWPTKpaiTcKjoSY1XSrMo5nNw/XGY9cKYad0buGN+mpO4oDhTCgkc5s6KEPfYg
         AFTE+uz5zzWnPbqsOb+kOgHA8GW/AmkIRpgiLQT8gaTZ7bo6bgv3hwyTIHnqt4VKFD/I
         ZZuoIZBKrRdli4tSUKjZ72xlNcK8vlwWzMvGvaW44jSC95q8GBmKtlUSsCVZeCRY1Exr
         ba8890/Gfq30mcl0cLK0nJs15co2iMsJo2fmQwQK2a/RuQFsdN1PcFhBvSoKUWPo9+ns
         mhDcYkuCFga//6ihek+Z2FAGovJYDWxF1otzMttVo+6eBIw2taeH+Ox02USxTlhS6Hi6
         kGzA==
X-Gm-Message-State: APt69E2rEoIy2lH/WCz4seUDeYrpBbW6ft0i9ynASiUfBsp5nu2lTnDp
        GizozE5F91ZZ7m8y1Vc4jqHEYB9lEvI=
X-Google-Smtp-Source: AAOMgpeIoUTee9I+I0NmXD6gPJtXnDYSfln8ayc1+Myc8PFo+oo+t/d3CfrF8PAQ7e1HD983HO9p0Q==
X-Received: by 2002:ac8:43da:: with SMTP id w26-v6mr21152417qtn.137.1531183585860;
        Mon, 09 Jul 2018 17:46:25 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:24 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCHv2 6/7] treewide: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS
Date:   Mon,  9 Jul 2018 17:46:01 -0700
Message-Id: <20180710004602.21599-7-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for enabling command line LDLIBS, re-name HOST_LOADLIBES to
KBUILD_HOSTLDLIBS as the internal use only flags. Also rename existing usage
to HOSTLDLIBS for consistency. This should not have any visible effects.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Rename existing HOSTLOADLIBES to HOSTLDLIBS
---
 Makefile                 |  4 ++--
 samples/bpf/Makefile     | 12 ++++++------
 samples/seccomp/Makefile |  6 +++---
 scripts/Makefile         |  4 ++--
 scripts/Makefile.host    | 10 +++++-----
 scripts/kconfig/Makefile |  8 ++++----
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index bd2d64b89463..96e34381d9ee 100644
--- a/Makefile
+++ b/Makefile
@@ -363,7 +363,7 @@ KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
 KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
 KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
-HOST_LOADLIBES := $(HOST_LFS_LIBS)
+KBUILD_HOSTLDLIBS := $(HOST_LFS_LIBS)
 
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
@@ -430,7 +430,7 @@ LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
-export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS HOST_LOADLIBES
+export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
 export MAKE LEX YACC AWK GENKSYMS INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
 export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 494ef04c56cc..bd9f6c2a808e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -180,12 +180,12 @@ HOSTCFLAGS_trace_event_user.o += -I$(srctree)/tools/lib/bpf/
 HOSTCFLAGS_sampleip_user.o += -I$(srctree)/tools/lib/bpf/
 HOSTCFLAGS_task_fd_query_user.o += -I$(srctree)/tools/lib/bpf/
 
-HOST_LOADLIBES		+= $(LIBBPF) -lelf
-HOSTLOADLIBES_tracex4		+= -lrt
-HOSTLOADLIBES_trace_output	+= -lrt
-HOSTLOADLIBES_map_perf_test	+= -lrt
-HOSTLOADLIBES_test_overhead	+= -lrt
-HOSTLOADLIBES_xdpsock		+= -pthread
+KBUILD_HOSTLDLIBS		+= $(LIBBPF) -lelf
+HOSTLDLIBS_tracex4		+= -lrt
+HOSTLDLIBS_trace_output	+= -lrt
+HOSTLDLIBS_map_perf_test	+= -lrt
+HOSTLDLIBS_test_overhead	+= -lrt
+HOSTLDLIBS_xdpsock		+= -pthread
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index ba942e3ead89..cf34ff6b4065 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -30,9 +30,9 @@ HOSTCFLAGS_bpf-direct.o += $(MFLAG)
 HOSTCFLAGS_dropper.o += $(MFLAG)
 HOSTCFLAGS_bpf-helper.o += $(MFLAG)
 HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
-HOSTLOADLIBES_bpf-direct += $(MFLAG)
-HOSTLOADLIBES_bpf-fancy += $(MFLAG)
-HOSTLOADLIBES_dropper += $(MFLAG)
+HOSTLDLIBS_bpf-direct += $(MFLAG)
+HOSTLDLIBS_bpf-fancy += $(MFLAG)
+HOSTLDLIBS_dropper += $(MFLAG)
 endif
 always := $(hostprogs-m)
 endif
diff --git a/scripts/Makefile b/scripts/Makefile
index 25ab143cbe14..166b94db90e3 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -22,8 +22,8 @@ hostprogs-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE) += insert-sys-cert
 
 HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
-HOSTLOADLIBES_sign-file = -lcrypto
-HOSTLOADLIBES_extract-cert = -lcrypto
+HOSTLDLIBS_sign-file = -lcrypto
+HOSTLDLIBS_extract-cert = -lcrypto
 
 always		:= $(hostprogs-y) $(hostprogs-m)
 
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index c019d781b2c9..0393f75db4d4 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -85,7 +85,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
       cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(KBUILD_HOSTLDFLAGS) -o $@ $< \
-	  	$(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+		$(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
 $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 	$(call if_changed_dep,host-csingle)
 
@@ -94,7 +94,7 @@ $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 quiet_cmd_host-cmulti	= HOSTLD  $@
       cmd_host-cmulti	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(addprefix $(obj)/,$($(@F)-objs)) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
 $(host-cmulti): FORCE
 	$(call if_changed,host-cmulti)
 $(call multi_depend, $(host-cmulti), , -objs)
@@ -112,7 +112,7 @@ quiet_cmd_host-cxxmulti	= HOSTLD  $@
       cmd_host-cxxmulti	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(foreach o,objs cxxobjs,\
 			  $(addprefix $(obj)/,$($(@F)-$(o)))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
 $(host-cxxmulti): FORCE
 	$(call if_changed,host-cxxmulti)
 $(call multi_depend, $(host-cxxmulti), , -objs -cxxobjs)
@@ -145,7 +145,7 @@ $(host-cxxshobjs): $(obj)/%.o: $(src)/%.c FORCE
 quiet_cmd_host-cshlib	= HOSTLLD -shared $@
       cmd_host-cshlib	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
 			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
 $(host-cshlib): FORCE
 	$(call if_changed,host-cshlib)
 $(call multi_depend, $(host-cshlib), .so, -objs)
@@ -155,7 +155,7 @@ $(call multi_depend, $(host-cshlib), .so, -objs)
 quiet_cmd_host-cxxshlib	= HOSTLLD -shared $@
       cmd_host-cxxshlib	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
 			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
 $(host-cxxshlib): FORCE
 	$(call if_changed,host-cxxshlib)
 $(call multi_depend, $(host-cxxshlib), .so, -objs)
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 035c5670d9ff..4baab548b979 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -169,7 +169,7 @@ HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 hostprogs-y	+= nconf
 nconf-objs	:= nconf.o zconf.tab.o nconf.gui.o
 
-HOSTLOADLIBES_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
+HOSTLDLIBS_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
 HOSTCFLAGS_nconf.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
 HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
 
@@ -180,7 +180,7 @@ hostprogs-y	+= mconf
 lxdialog	:= checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
 mconf-objs	:= mconf.o zconf.tab.o $(addprefix lxdialog/, $(lxdialog))
 
-HOSTLOADLIBES_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
+HOSTLDLIBS_mconf = $(shell . $(obj)/.mconf-cfg && echo $$libs)
 $(foreach f, mconf.o $(lxdialog), \
   $(eval KBUILD_HOSTCFLAGS_$f = $$(shell . $(obj)/.mconf-cfg && echo $$$$cflags)))
 
@@ -191,7 +191,7 @@ hostprogs-y	+= qconf
 qconf-cxxobjs	:= qconf.o
 qconf-objs	:= zconf.tab.o
 
-HOSTLOADLIBES_qconf	= $(shell . $(obj)/.qconf-cfg && echo $$libs)
+HOSTLDLIBS_qconf	= $(shell . $(obj)/.qconf-cfg && echo $$libs)
 HOSTCXXFLAGS_qconf.o	= $(shell . $(obj)/.qconf-cfg && echo $$cflags)
 
 $(obj)/qconf.o: $(obj)/.qconf-cfg $(obj)/qconf.moc
@@ -206,7 +206,7 @@ $(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
 hostprogs-y	+= gconf
 gconf-objs	:= gconf.o zconf.tab.o
 
-HOSTLOADLIBES_gconf = $(shell . $(obj)/.gconf-cfg && echo $$libs)
+HOSTLDLIBS_gconf = $(shell . $(obj)/.gconf-cfg && echo $$libs)
 HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
 
 $(obj)/gconf.o: $(obj)/.gconf-cfg
-- 
2.17.1

