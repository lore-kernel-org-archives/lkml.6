Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9091CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA92219FC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Lm6CbpCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392308AbeLVQyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:54:24 -0500
Received: from condef-05.nifty.com ([202.248.20.70]:63170 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbeLVQyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:54:23 -0500
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-05.nifty.com with ESMTP id wBM9pSs8018189;
        Sat, 22 Dec 2018 18:51:28 +0900
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wBM9p7DP014613;
        Sat, 22 Dec 2018 18:51:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBM9p7DP014613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545472271;
        bh=ywKL6nYK2qqIQOak83JQGAxzZALy6S+6T9IKsECXqpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lm6CbpCDnAe/nEnWFqAx6+sGNtiwaYMR3NeWWWMaMWqg0atIjEoZAw9JB8UI67X/E
         fmMno7TrRkl7DxHXeE2e1RpwLheepNBDULu6qmFvgT0F43ROWe/4tnkYQBjtgcuxYK
         6AColvaoUoSgQGuA/R56yNbYxGXBnA/Grknbaxu+n+lWg3M4leJmdJGpKMUQgS3RWB
         gERhwwRye2fETS6cVRa2909p/5Qsz7GhfGjebDMRNSltZ6XyNER4ca06ylGF7zRnam
         Bp2FcKW/kKJJRAdRziK8z+prYvMhFVQ1a9h8ab0QzRB4y8iYdwVM83uxBxSC+ZbMuH
         VYBezqfg+k6QA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: remove $(obj)/ prefixes in ./Kbuild
Date:   Sat, 22 Dec 2018 18:50:35 +0900
Message-Id: <1545472235-12782-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding $(obj)/ to file paths relative from the top objtree looks
a bit redundant to me. This commit has no functional change since
$(obj) is '.' in this file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Kbuild b/Kbuild
index b24210c..03cb8ed 100644
--- a/Kbuild
+++ b/Kbuild
@@ -16,7 +16,7 @@ bounds-file := include/generated/bounds.h
 always  := $(bounds-file)
 targets := kernel/bounds.s
 
-$(obj)/$(bounds-file): kernel/bounds.s FORCE
+$(bounds-file): kernel/bounds.s FORCE
 	$(call filechk,offsets,__LINUX_BOUNDS_H__)
 
 #####
@@ -34,7 +34,7 @@ define filechk_gentimeconst
 	(echo $(CONFIG_HZ) | bc -q $< )
 endef
 
-$(obj)/$(timeconst-file): kernel/time/timeconst.bc FORCE
+$(timeconst-file): kernel/time/timeconst.bc FORCE
 	$(call filechk,gentimeconst)
 
 #####
@@ -46,9 +46,9 @@ offsets-file := include/generated/asm-offsets.h
 always  += $(offsets-file)
 targets += arch/$(SRCARCH)/kernel/asm-offsets.s
 
-arch/$(SRCARCH)/kernel/asm-offsets.s: $(obj)/$(timeconst-file) $(obj)/$(bounds-file)
+arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
 
-$(obj)/$(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
+$(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
 #####
@@ -70,7 +70,7 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 
 extra-$(CONFIG_GDB_SCRIPTS) += build_constants_py
 
-build_constants_py: $(obj)/$(timeconst-file) $(obj)/$(bounds-file)
+build_constants_py: $(timeconst-file) $(bounds-file)
 	@$(MAKE) $(build)=scripts/gdb/linux $@
 
 # Keep these three files during make clean
-- 
2.7.4

