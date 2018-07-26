Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA55C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5949020883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hATYiuSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5949020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeGZLaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:30:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbeGZLaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:30:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so428855pfo.12;
        Thu, 26 Jul 2018 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OYy21Ub+xl0Zg1iW2ag5xZ5H/oK96Or3xHERkQ/dQuI=;
        b=hATYiuSJrsLBlqvdOlPuxEfFIgTp9eUyp3b5Tdqbf3TzwAG0YULZAU752HwPi7/s+7
         xqMtbM9LzJnciLKtYqfce4USmn3Js9yUZik0FIokbYZtgsTenxqXf0wZ6qaM9Cm5Ydpa
         0Tu1PwW2pY6QjINwhyfPhUhMcJOR5JWf3zTCJzL6uwl6zKPIIpm3Fv/sFmxk/uXqUNzU
         bXPOwgDZ+fN+2UPccEXw9GYc+E9TtBswrxsIXQrJw9Ox6Nj9IYBoSsGhIdr+xUrJcJO0
         G5j4/EMXoFy9qxopIZWtuFdH25WO6sbuiBWQj/qQYc6L7LRDeneH9OcdnVI6mAfoAlN/
         VbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OYy21Ub+xl0Zg1iW2ag5xZ5H/oK96Or3xHERkQ/dQuI=;
        b=By+8gojdeJbGjt1+ufeYwZXYq2nATRccS4WB52ZXcorp8cXoc7b1UMZfh3+iQhx7fc
         GRopX55G+tjMBLK0hL0EMRc+AS/qzEz5e2hd6uogP1BbnPh8eU1ACgAR3/g7v/ApNDi3
         HVanSSoO7UckEVPlXGRTgpuIEg9UnL9dsDhgvo7gCLIzF0z1NHEK0vPdb3bi+0NFuade
         +gEXBvteYoC6pobMrKRwF1FNBgdyM7JAtQDmAkfu8W6XgqNFzP2RIiuLSC0tHoxeIdTZ
         pr1zSSLPHWU++9BCM1cXDrK0ja4rGYFJWSCQ1Lb8YC08nGNYgFnH+mKZBclm9K8UVGe1
         x5Ww==
X-Gm-Message-State: AOUpUlF78D0qMjRde5Pg/yAVS3ncnllNXELAgsGuncOQxPGYcMB21/hb
        i5cjaPR5lpMvBed4tmQFcoY=
X-Google-Smtp-Source: AAOMgpeHbR52+rg89tQ2/q09D3mkwvhMIGd8I+ljrm5L5+1vbrb/GZYZeVV6iAwMJdmaZtqUNuEIsA==
X-Received: by 2002:a63:5758:: with SMTP id h24-v6mr1330237pgm.432.1532600034210;
        Thu, 26 Jul 2018 03:13:54 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id u11-v6sm3040068pfd.117.2018.07.26.03.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 03:13:53 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2] samples/bpf: Add BTF build flags to Makefile
Date:   Thu, 26 Jul 2018 19:13:44 +0900
Message-Id: <20180726101344.19351-1-treeze.taeung@gmail.com>
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

Acked-by: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/Makefile | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9ea2f7b64869..77f512625b8c 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -195,6 +195,8 @@ HOSTLOADLIBES_xdpsock		+= -pthread
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
 CLANG ?= clang
+LLVM_OBJCOPY ?= llvm-objcopy
+BTF_PAHOLE ?= pahole
 
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
@@ -202,6 +204,16 @@ HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
+BTF_LLC_PROBE := $(shell $(LLC) -march=bpf -mattr=help 2>&1 | grep dwarfris)
+BTF_PAHOLE_PROBE := $(shell $(BTF_PAHOLE) --help 2>&1 | grep BTF)
+BTF_OBJCOPY_PROBE := $(shell $(LLVM_OBJCOPY) --help 2>&1 | grep -i 'usage.*llvm')
+
+ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
+	EXTRA_CFLAGS += -g
+	LLC_FLAGS += -mattr=dwarfris
+	DWARF2BTF = y
+endif
+
 # Trick to allow make to be run from this directory
 all:
 	$(MAKE) -C ../../ $(CURDIR)/ BPF_SAMPLES_PATH=$(CURDIR)
@@ -260,4 +272,7 @@ $(obj)/%.o: $(src)/%.c
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

