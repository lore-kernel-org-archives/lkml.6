Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB0CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6FD21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hEvMmmB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfBSJdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:33:31 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:52740 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:33:28 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1J9XBkL002572;
        Tue, 19 Feb 2019 18:33:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1J9XBkL002572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550568792;
        bh=XdRtcC+1Mcw++lGM+PLPkwfGmBgVfh6AWmRhE8986rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEvMmmB5m3NMDEiB7kr23gwULh9WWUEQ+qWbY7PSU1maiy2Y9xWdHdGYBMd28loWD
         p+UabPfvYnqp8TQXQfVP9ldu3U7Nz+R6kWLNLfAMHCYBLVq8EH9w8ZYS2AQLA68QZY
         mTVn8M2l7W9zNlTP/6r1AhvteyXO1k74GyxRJl8HhIZfzg4vHI+Y3WFgVm5lvbjyg+
         p1u7xjuz6UoJn1ZV7NqZORWBFnfozk7MgbSshQ/D35Mr51aPQX8RdkRe3VvtbBU9wg
         zQ5vvHS2NXrkW4UcTNX7j1SC3LpfzQTXZxDIpibFUbXrmsudBAaHFvfthA6Cz8Qw35
         7yfII6F+PvTRQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kbuild: remove unimportant comments from ./Kbuild
Date:   Tue, 19 Feb 2019 18:33:03 +0900
Message-Id: <1550568787-18710-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time we add/remove a target, we need to touch the header part,
including renumbering. This is not so important information.

Numbering targets is rather misleading because they are not necessarily
generated in this order. For example, 1) and 2) can be executed
simultaneously when the -j option is given.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/Kbuild b/Kbuild
index 4cebcc7..a07bbd6 100644
--- a/Kbuild
+++ b/Kbuild
@@ -1,14 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Kbuild for top-level directory of the kernel
-# This file takes care of the following:
-# 1) Generate bounds.h
-# 2) Generate timeconst.h
-# 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
-# 4) Check for missing system calls
 
 #####
-# 1) Generate bounds.h
+# Generate bounds.h
 
 bounds-file := include/generated/bounds.h
 
@@ -19,7 +14,7 @@ $(bounds-file): kernel/bounds.s FORCE
 	$(call filechk,offsets,__LINUX_BOUNDS_H__)
 
 #####
-# 2) Generate timeconst.h
+# Generate timeconst.h
 
 timeconst-file := include/generated/timeconst.h
 
@@ -31,8 +26,7 @@ $(timeconst-file): kernel/time/timeconst.bc FORCE
 	$(call filechk,gentimeconst)
 
 #####
-# 3) Generate asm-offsets.h
-#
+# Generate asm-offsets.h
 
 offsets-file := include/generated/asm-offsets.h
 
@@ -45,8 +39,7 @@ $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
 #####
-# 4) Check for missing system calls
-#
+# Check for missing system calls
 
 always += missing-syscalls
 targets += missing-syscalls
-- 
2.7.4

