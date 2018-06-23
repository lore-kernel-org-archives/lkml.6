Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69885C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215F224C8B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="re2my31u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215F224C8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeFWQn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:43:59 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:56975 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeFWQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:43:58 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w5NGgBU5024126;
        Sun, 24 Jun 2018 01:42:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w5NGgBU5024126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529772133;
        bh=Tq+ihuRFKS2KJB0zTsioIiuEW99Wj4YG1jqp6VL+k2k=;
        h=From:To:Cc:Subject:Date:From;
        b=re2my31uD8pymaxDdFYUCB0lNiwPBt18UifM36afqJ1xEd1aS7YGHO8+ehRBOyCf/
         fBeHCxUSwvnKp62jK5H/q+zei53u3R8fHKTHy2v6AjjPZj4bKeG9L1kBx0rbOg2RHH
         wEwps7qGJwR2KoWiFcHzTMN5HlXa5HRtGsdguTExgOuDxRHioEWbA9sAs3ANmGUqLl
         lf/i6sVVDk5ZaNCsFCORrs4usjsKVBmrxNv6NZ3q/jpZz5Y0CtNnlZSgJk2W8Nv7SJ
         9fAEPLts+5xEfGdhzpmY9Jlu6MLousZaiBPowMX1f9CeNeJGp1pUFI8298Alrqaedt
         cvsHAXBRoz7fw==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] kbuild: reword help of LD_DEAD_CODE_DATA_ELIMINATION
Date:   Sun, 24 Jun 2018 01:41:51 +0900
Message-Id: <1529772111-5780-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5d20ee3192a5 ("kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION
to be selectable if enabled"), HAVE_LD_DEAD_CODE_DATA_ELIMINATION is
supposed to be selected by architectures that are capable of this
functionality.  LD_DEAD_CODE_DATA_ELIMINATION is now users' selection.
Update the help message.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index fde3d09..041f3a0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1051,10 +1051,9 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	depends on EXPERT
 	help
-	  Select this if the architecture wants to do dead code and
-	  data elimination with the linker by compiling with
-	  -ffunction-sections -fdata-sections, and linking with
-	  --gc-sections.
+	  Enable this if you want to do dead code and data elimination with
+	  the linker by compiling with -ffunction-sections -fdata-sections,
+	  and linking with --gc-sections.
 
 	  This can reduce on disk and in-memory size of the kernel
 	  code and static data, particularly for small configs and
-- 
2.7.4

