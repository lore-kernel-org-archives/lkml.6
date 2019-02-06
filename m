Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D82C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D0A217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fgoDr6/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfBFALc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35234 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfBFAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id b17so322229eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDZEl1XFH0T8SREVjbYvB1a+jjmkgaWU05OzUhyRFUw=;
        b=fgoDr6/ELbI1o1FYuezTg2Iwh4qP12IsrCvDs47ajAOeudLdW6n5P64AXmzuxSgguN
         2vT8cwNvu7uoTebb1AyVhtjrNUb1TovF12TvaCqjUcGyHiQflPTASnJHkJZQmJgQnZP9
         lwHLHhd57Oz4g6Q3t+X4SN5qj1EluOI0t1oNEiMpCFpX2MfHVGI7cACICNHYo+dYh3hV
         lG+g4vzGbK7Fl/GxQnDMxb3+ml2JYxfNEE8v2LZ9VEZa+qVqrf/anXCnzUtwNYeCZhFW
         QH1sEnbjgYrrqgio6v6fruaftUv83df3XvEzQEZtcIVAHdOlPD617hWbaNWkZYkpN3sD
         wgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDZEl1XFH0T8SREVjbYvB1a+jjmkgaWU05OzUhyRFUw=;
        b=JASNc0tfIA5EvTnHPFRPcEH3zPCLMceGVVg6GQb9a53COj12JrOtZhkuorus9dMDyT
         qVGDDfiBlsceZ/X67CdPworw8jAtPxYHoTXUMrAhoc0HnBSgl0hRmGzx6utVeU8JDg7b
         bmEQW/zkLNj0FEZ4BGoziCbr53Yga3qBbaP11TZft/6AYYgeYNcrh2oR0R+A7Nu44oPA
         Nq0i0d0FqsxgLrmYd3TofIROz62Pe/06T9u73MjcYu5owU/DajJAre4V7GHlZ3vA4O+s
         YNZgSmQEbUJHAA3wHNJcDUJYpGEBPeIbtrYiL0+SkkKdRiL4NqgZteWIBNih4x2jcJMV
         GqcA==
X-Gm-Message-State: AHQUAuaHZ2NEMPmfYoUeMRIC0CE4nPg1I8oKo6RBOl2/pVfnAtuVhtxn
        99p49GSFEW94S12v+Xj0Yxdyxfi8BeU=
X-Google-Smtp-Source: AHgI3IZZ31JGn14ucfNBGgj6eEBj7SeBo9K7g+iA7LPUOTePY80yNztnXiIhaR4JZ/zgTvrmFFOjsg==
X-Received: by 2002:a17:906:a40a:: with SMTP id l10mr5265882ejz.248.1549411887090;
        Tue, 05 Feb 2019 16:11:27 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:26 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 13/32] x86/vdso: Build timens .so(s)
Date:   Wed,  6 Feb 2019 00:10:47 +0000
Message-Id: <20190206001107.16488-14-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

Addressing those problems, build two VDSO images instead.

At this moment timens is unsupported for x32 binaries (only x86_64 and
ia32). This may be added on top afterwards.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile                  | 28 +++++++++++++++++--
 arch/x86/entry/vdso/vclock_gettime-timens.c   |  6 ++++
 .../entry/vdso/vdso32/vclock_gettime-timens.c |  6 ++++
 3 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vclock_gettime-timens.c
 create mode 100644 arch/x86/entry/vdso/vdso32/vclock_gettime-timens.c

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index bc0bdbf49397..2433ed9342fd 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -17,8 +17,12 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vgetcpu.o
+vobjs-timens-y := $(vobjs-y) vclock_gettime-timens.o
+vobjs-y += vclock_gettime.o
+
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
+vobjs32-timens-y := $(vobjs32-y) vdso32/vclock_gettime-timens.o
 vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
@@ -30,15 +34,21 @@ vdso_img-$(VDSO64-y)		+= 64
 vdso_img-$(VDSOX32-y)		+= x32
 vdso_img-$(VDSO32-y)		+= 32
 
+vdso_timens_img-$(VDSO64-y)	+= 64-timens
+vdso_timens_img-$(VDSO32-y)	+= 32-timens
+vdso_img-$(CONFIG_TIME_NS)	+= $(vdso_timens_img-y)
+
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
+vobjs-timens := $(foreach F,$(vobjs-timens-y),$(obj)/$F)
+vobjs32-timens := $(foreach F,$(vobjs32-timens-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
-targets += vdso.lds $(vobjs-y)
-targets += vdso32/vdso32.lds $(vobjs32-y)
+targets += vdso.lds $(vobjs-y) $(vobjs-timens-y)
+targets += vdso32/vdso32.lds $(vobjs32-y) $(vobjs32-timens-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -53,6 +63,9 @@ CPPFLAGS_vdso.lds += -P -C
 VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
 			-z max-page-size=4096
 
+$(obj)/vdso64-timens.so.dbg: $(obj)/vdso.lds $(vobjs-timens) FORCE
+	$(call if_changed,vdso)
+
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
@@ -81,12 +94,14 @@ endif
 endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs-timens): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
 CFLAGS_REMOVE_vdso-note.o = -pg
 CFLAGS_REMOVE_vclock_gettime.o = -pg
+CFLAGS_REMOVE_vclock_gettime-timens.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
 CFLAGS_REMOVE_vvar.o = -pg
 
@@ -132,6 +147,8 @@ VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
+$(obj)/vdso32-timens.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
+$(obj)/vdso32-timens.so.dbg: asflags-$(CONFIG_X86_64) += -m32
 
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
@@ -152,6 +169,10 @@ endif
 endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
+$(obj)/vdso32-timens.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
+
+$(obj)/vdso32-timens.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32-timens) FORCE
+	$(call if_changed,vdso)
 
 $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso)
@@ -198,3 +219,4 @@ PHONY += vdso_install $(vdso_img_insttargets)
 vdso_install: $(vdso_img_insttargets)
 
 clean-files := vdso32.so vdso32.so.dbg vdso64* vdso-image-*.c vdsox32.so*
+clean-files += vdso32-timens.so vdso32-timens.so.dbg
diff --git a/arch/x86/entry/vdso/vclock_gettime-timens.c b/arch/x86/entry/vdso/vclock_gettime-timens.c
new file mode 100644
index 000000000000..9e92315f83db
--- /dev/null
+++ b/arch/x86/entry/vdso/vclock_gettime-timens.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BUILD_VDSO_TIME_NS
+
+#include "vclock_gettime.c"
+
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime-timens.c b/arch/x86/entry/vdso/vdso32/vclock_gettime-timens.c
new file mode 100644
index 000000000000..9e92315f83db
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime-timens.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BUILD_VDSO_TIME_NS
+
+#include "vclock_gettime.c"
+
-- 
2.20.1

