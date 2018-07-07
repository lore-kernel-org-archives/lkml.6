Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBEC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F13522531
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F13522531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbeGGBHm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:07:42 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34176 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932867AbeGGBHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:07:38 -0400
Received: by mail-qk0-f176.google.com with SMTP id b66-v6so7219721qkj.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cbSd3n+yquxTh0g79lkM7vAM+swHN7gXqC3qAGD44tw=;
        b=Zp8sr/mCmu5dwy9U6fMCo47riAX8Axaz+jryG+uz+h/pvDzNKtLTtLOso4gHdH9lo0
         oR0vBJhbQL6UCd6SZz16Ti8a76KXPqyGh1EYbyJZ/4vjr/9POODap2pZRzhjerm64zdV
         ArAawOTNWaS7kLbEhhGcKScGUaA6unTeSQ5J2z9vv4CfQ3cxLs2syq45Pbh/hbDhMbQS
         N0gJKWs2GUaNZHnyVHhZ84qtY6mIY1ZVolCxH347LltiA0FPhNXx0ca76Y9XhOHs5ytR
         LXxkhT25SCx8udtcLe2a+9qKdwqFuMVabVq53zSyxqmLS3CgXwVufeM9q+Q2jcBoF5oS
         lJTg==
X-Gm-Message-State: APt69E0iTMxtHeu9K1+97/1mIIBdatk3vlI27iYlJ/W0wSFyH+pI0inj
        jcCRM9P0oSpCcHK8L1s5tTVCSA==
X-Google-Smtp-Source: AAOMgpf0ETKaUo1inL4av38rKxi0XA2kr+1R51QWD1bOFhTSPzkOmcSG3JIZFLui1mOVsEJb3iaUjg==
X-Received: by 2002:a37:1741:: with SMTP id i62-v6mr10632525qkh.147.1530925658023;
        Fri, 06 Jul 2018 18:07:38 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3359698qtg.20.2018.07.06.18.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 18:07:36 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH 6/7] treewide: Rename HOST_LOADLIBES to KBUILD_HOSTLDLIBS
Date:   Fri,  6 Jul 2018 18:07:08 -0700
Message-Id: <20180707010709.16648-7-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707010709.16648-1-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for enabling command line LDLIBS, re-name HOST_LOADLIBES to
KBUILD_HOSTLDLIBS as the internal use only flags. This should not have any
visible effects.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Makefile              |  4 ++--
 samples/bpf/Makefile  |  2 +-
 scripts/Makefile.host | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 319736b80016..d925af1fb11b 100644
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
index 09f90955412e..c20fb2fa9c37 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -180,7 +180,7 @@ KBUILD_HOSTCFLAGS_trace_event_user.o += -I$(srctree)/tools/lib/bpf/
 KBUILD_HOSTCFLAGS_sampleip_user.o += -I$(srctree)/tools/lib/bpf/
 KBUILD_HOSTCFLAGS_task_fd_query_user.o += -I$(srctree)/tools/lib/bpf/
 
-HOST_LOADLIBES		+= $(LIBBPF) -lelf
+KBUILD_HOSTLDLIBS		+= $(LIBBPF) -lelf
 HOSTLOADLIBES_tracex4		+= -lrt
 HOSTLOADLIBES_trace_output	+= -lrt
 HOSTLOADLIBES_map_perf_test	+= -lrt
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 07acf5779f55..7b784413d921 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -85,7 +85,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
       cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(KBUILD_HOSTLDFLAGS) -o $@ $< \
-	  	$(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+		$(KBUILD_HOSTLDLIBS) $(HOSTLOADLIBES_$(@F))
 $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 	$(call if_changed_dep,host-csingle)
 
@@ -94,7 +94,7 @@ $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 quiet_cmd_host-cmulti	= HOSTLD  $@
       cmd_host-cmulti	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(addprefix $(obj)/,$($(@F)-objs)) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLOADLIBES_$(@F))
 $(host-cmulti): FORCE
 	$(call if_changed,host-cmulti)
 $(call multi_depend, $(host-cmulti), , -objs)
@@ -112,7 +112,7 @@ quiet_cmd_host-cxxmulti	= HOSTLD  $@
       cmd_host-cxxmulti	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(foreach o,objs cxxobjs,\
 			  $(addprefix $(obj)/,$($(@F)-$(o)))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLOADLIBES_$(@F))
 $(host-cxxmulti): FORCE
 	$(call if_changed,host-cxxmulti)
 $(call multi_depend, $(host-cxxmulti), , -objs -cxxobjs)
@@ -145,7 +145,7 @@ $(host-cxxshobjs): $(obj)/%.o: $(src)/%.c FORCE
 quiet_cmd_host-cshlib	= HOSTLLD -shared $@
       cmd_host-cshlib	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
 			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLOADLIBES_$(@F))
 $(host-cshlib): FORCE
 	$(call if_changed,host-cshlib)
 $(call multi_depend, $(host-cshlib), .so, -objs)
@@ -155,7 +155,7 @@ $(call multi_depend, $(host-cshlib), .so, -objs)
 quiet_cmd_host-cxxshlib	= HOSTLLD -shared $@
       cmd_host-cxxshlib	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -shared -o $@ \
 			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(HOST_LOADLIBES) $(HOSTLOADLIBES_$(@F))
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLOADLIBES_$(@F))
 $(host-cxxshlib): FORCE
 	$(call if_changed,host-cxxshlib)
 $(call multi_depend, $(host-cxxshlib), .so, -objs)
-- 
2.17.1

