Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE1BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585462083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585462083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeGJArg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:47:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33059 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933379AbeGJAqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:19 -0400
Received: by mail-qt0-f193.google.com with SMTP id l10-v6so17011558qtj.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AfLIOCp1cVP91gT8/+2UX+UobTr3dF7Uk+TAhVnXtf0=;
        b=JL+9DGb6NgrYyq0ITRqRZb8XVnZJKcCmf7RSAYliw1swdDjRx2u/hPnlf+HHG9V5yZ
         ZgPi+su0egJlrqekcmCn8YMIpeuuBWyFaeZpCSiOu6qIsbW6dxgnPgjzIwTwDj8mf3oF
         BOSp+ZwZthTuPp3JJDMw63a3NWXp9ASDlFZ9kipbQK4os+UX2SUme5bkg47pSR9OlHRT
         nl8TVmUH/0OYfMfHOrIEZ9cG+1BbiW+VAO0PxMlwNXRVF7nGOuaSzZoinmOKMpz9DMeR
         lEKHUV9fcuuy5n/Le6Ln3mdmzf/rC9XW9CINeufNPz9eVengL/fH+88IcG4lT6VyDQt0
         0EJA==
X-Gm-Message-State: APt69E00J5iUkbjgWsQTWHICd0aBNnJNVaRJNqDn2Z6GHgjx6U/nK+wQ
        /eCa3+5cHrIgbxdUPlHIn4WEMA==
X-Google-Smtp-Source: AAOMgpfy4h9U1VRLocpnjspmgrLXrpl6WxJQi+v7QqeQeM4ZF6j+j4a4zUOA3NXJp9+5nsR4myyvEg==
X-Received: by 2002:ac8:230a:: with SMTP id a10-v6mr20695155qta.234.1531183579134;
        Mon, 09 Jul 2018 17:46:19 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:18 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCHv2] treewide: Rename HOSTCFLAGS -> KBUILD_HOSTCFLAGS
Date:   Mon,  9 Jul 2018 17:45:58 -0700
Message-Id: <20180710004602.21599-4-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for enabling command line CFLAGS, re-name HOSTCFLAGS to
KBUILD_HOSTCFLAGS as the internal use only flags. This should not have any
visible effects.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Dropped name change for individual files (still CHOSTFLAGS_foo)
---
 Makefile                  |  4 ++--
 arch/alpha/boot/Makefile  |  2 +-
 net/bpfilter/Makefile     |  2 +-
 samples/bpf/Makefile      | 10 +++++-----
 scripts/Kbuild.include    |  2 +-
 scripts/Makefile.host     |  2 +-
 tools/build/Build.include |  2 +-
 tools/objtool/Makefile    |  2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 925c55f2524f..1feec222f3c1 100644
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
index 1303af10e54d..494ef04c56cc 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -164,11 +164,11 @@ always += xdpsock_kern.o
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
 
 HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
 HOSTCFLAGS_trace_helpers.o += -I$(srctree)/tools/lib/bpf/
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
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index aa971cc3f339..09f00dae21fe 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -62,7 +62,7 @@ host-cxxshobjs	:= $(addprefix $(obj)/,$(host-cxxshobjs))
 #####
 # Handle options to gcc. Support building with separate output directory
 
-_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
+_hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
                  $(HOSTCFLAGS_$(basetarget).o)
 _hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(basetarget).o)
diff --git a/tools/build/Build.include b/tools/build/Build.include
index b5c679cd441c..a75fa0b6ffc0 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -98,4 +98,4 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
 ###
 ## HOSTCC C flags
 
-host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
+host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
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

