Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DC7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0635020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0Pb9XlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0635020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbeGYRnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:43:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38382 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeGYRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:43:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so5657139pgq.5;
        Wed, 25 Jul 2018 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EcCkkK5jsnvFBGgi1WS8CaoabYsER2v4TZV/naQNXK4=;
        b=S0Pb9XlByRTtgm406hIySBhJUA6F5gwnSzkKfoIyl1kP0ZqUmmPfbt8mlhVFkas4As
         iDV+Pacwks5VG9tI+j/qbXEBdaFLUSAwWLxpmKqzo7/jSaswCqQDjcJsspiro3fbzRZM
         Fsoet+I024LIeGREd0g7vmiIflRi8f29TRsdHOVzQNgr5rjFxciq/lCYK8ZHN2dgKSvV
         mv5WDzSsrj3lMqzTTIM+rxBAnRSImqvkdxGtw222gP6wliCtfuHIxcz1/U58au9/sg/2
         MuENdc94BZSGXAKSbmw4AGs+2y6VbW7oWYVyJYQIsZlqJflFvTPeHQQA7FavWA78WIUx
         BI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EcCkkK5jsnvFBGgi1WS8CaoabYsER2v4TZV/naQNXK4=;
        b=DbP8nxsMhVb9FJFWrtiIqqbYTIqYqY/6dttzQ8PSSvYNWzN/irqxCWbFxwky7tCoAz
         /yBJhs7JhYfNd+3CArdP9Pi9A9FvpBfDM3NTgAuvVMx0cFycxC2XYL/RD3Qd8Rh0R6pC
         vT+7+UvlyGwwbYlb38o8oVghePCM+WMY0CxPtxLl2wSN/UKURkaSo8mUB0LoG+yPz3dV
         FnzVhQ8bHOqfI4aWhaV0ms4XouNvcdZ9Qa2uPvCvQhvlSvS7VoGF34qSyhFZo76kkVIl
         zqqcM5DqSz5cTBZA5EQ/j7NUP0zlEXsoL9PnB4w2ZniwVI2KktKpmD1yPH8gjBhxHJL9
         ldow==
X-Gm-Message-State: AOUpUlG6GnX8WOQNhm03jvKrLbXDPKe5P8YYfPIRUCD2D4h2eX2rUTbX
        o8abcX2k3iytTGfOWiavUHA=
X-Google-Smtp-Source: AAOMgpfNYFaZ/qfWS/+7BLmJmJNbG0yXYtZox0lQxS7I5rVXQvAcjNAiMTUKaGHm8XEmb6ZKMTOBBA==
X-Received: by 2002:a63:5463:: with SMTP id e35-v6mr21537049pgm.115.1532536249640;
        Wed, 25 Jul 2018 09:30:49 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id 14-v6sm25294764pft.93.2018.07.25.09.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 09:30:48 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH] samples/bpf: Add BTF build flags to Makefile
Date:   Thu, 26 Jul 2018 01:30:39 +0900
Message-Id: <20180725163039.2838-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To smoothly test BTF supported binary on samples/bpf,
let samples/bpf/Makefile probe llc, pahole and
llvm-objcopy for BPF support and use them
like tools/testing/selftests/bpf/Makefile
changed from the commit c0fa1b6c3efc ("bpf: btf:
 Add BTF tests")

Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/Makefile | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1303af10e54d..e079266360a3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -191,6 +191,8 @@ HOSTLOADLIBES_xdpsock		+= -pthread
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
 CLANG ?= clang
+LLVM_OBJCOPY ?= llvm-objcopy
+BTF_PAHOLE ?= pahole
 
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
@@ -198,6 +200,20 @@ HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
+BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
+BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
+BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
+
+ifneq ($(BTF_LLC_PROBE),)
+ifneq ($(BTF_PAHOLE_PROBE),)
+ifneq ($(BTF_OBJCOPY_PROBE),)
+	EXTRA_CFLAGS += -g
+	LLC_FLAGS += -mattr=dwarfris
+	DWARF2BTF = y
+endif
+endif
+endif
+
 # Trick to allow make to be run from this directory
 all:
 	$(MAKE) -C ../../ $(CURDIR)/ BPF_SAMPLES_PATH=$(CURDIR)
@@ -256,4 +272,7 @@ $(obj)/%.o: $(src)/%.c
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
 		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
-		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
+		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
+ifeq ($(DWARF2BTF),y)
+	$(BTF_PAHOLE) -J $@
+endif
-- 
2.17.1

