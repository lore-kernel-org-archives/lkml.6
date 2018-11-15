Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C1D21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1XUlQo/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C1D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbeKOSgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:36:14 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:52245 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbeKOSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:36:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHoY022794;
        Thu, 15 Nov 2018 17:27:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHoY022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270440;
        bh=LcE9BN1a5DuG2wOq3e8fyNB+oCKI7v/kfDfDv2Oxnmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XUlQo/x0kZUUITUMIjno5BW8ae7vqNHV9Bv9MuK8KG7e50dk2WjCjcqs/DGwB77y
         u8yft67gs28JseS9C/W+YOcE/wfDzJK1jtMlc34eI+G0ouT9T44xkwlLNl4OBdlxtH
         CxlSI60Ndwk+e30xH1KvdyolSfjAY4+z/pyDA6uOSmQeLpM+mzARIrX30BKzyVOOsv
         U2/lQJbGfTzGMEs5cYRSebYsKWZZM4IWOHGEI1g2jGiZ7bpBsw7Fv2vvIirR/JHXlM
         YlXTleUBQdAesuembsyN6N9xI9tjEo8Wfao8r0t0vxjkGgc4X+vAOkBlyW5ZnZXZ6k
         Cus/pGpNxCD/g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 1/8] kbuild: remove redundant 'set -e' from filechk_* defines
Date:   Thu, 15 Nov 2018 17:27:08 +0900
Message-Id: <1542270435-11181-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filechk macro in scripts/Kbuild.include already sets 'set -e'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/Makefile     | 2 +-
 scripts/Makefile.lib | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index ab1066c..71ff3d0 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -152,7 +152,7 @@ $(HOST_DIR)/um/user-offsets.s: __headers FORCE
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um $@
 
 define filechk_gen-asm-offsets
-        (set -e; \
+        ( \
          echo "/*"; \
          echo " * DO NOT MODIFY."; \
          echo " *"; \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468..ae3ae97 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -406,7 +406,7 @@ endef
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
-	(set -e; \
+	( \
 	 echo "#ifndef $2"; \
 	 echo "#define $2"; \
 	 echo "/*"; \
-- 
2.7.4

