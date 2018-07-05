Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB921525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JRiLvJQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABB921525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeGEDdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 23:33:35 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:24207 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeGEDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 23:33:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w653XFC3027618;
        Thu, 5 Jul 2018 12:33:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w653XFC3027618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530761596;
        bh=IANHPbqmw1K/oc5+0chUQP2Js5dYNN/niFfNZHG5Hg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRiLvJQLti3osbyJmj2Ph8bGen1WLRHqgF9kfxrrDt6zxlwQVmSiFeeyLwB3SpGX5
         ygYos76I2eK5h9Zrv8+KqBNkUKgTuhMnNEhPN3wit+7EIB0NvtcROau5pmE8yR+FKs
         LaLx7rs6HLKaJlDWmjpPpqZ8dUN3jm8pSKHsi911CSoLRLQjcQ5CiWHsdYSsyI01qS
         bLg7k6GMeFRdOvsybW1GyvmnF34JJ8IelbV4YVd8aocialnSDyGI+giogWCZiORl17
         XCeSJpAaOKl5ytfinYQQ5lndFUs0vU09BuR8YAFL3H0DUr346WuwE4ZUMHKS2+s2/L
         dnGIDc0AWRnbQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/2] kbuild: remove duplicated comments about PHONY
Date:   Thu,  5 Jul 2018 12:33:08 +0900
Message-Id: <1530761588-9986-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530761588-9986-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530761588-9986-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is the same as in the top-level Makefile.

Also, the comments contain typos:
  - the .PHONY variable  ->  the PHONY variable
  - se we can ...        ->  so we can ...

Instead of fixing the typos, just remove the duplicated comments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build      | 3 ---
 scripts/Makefile.clean      | 3 ---
 scripts/Makefile.modbuiltin | 4 ----
 scripts/Makefile.modinst    | 4 ----
 scripts/Makefile.modpost    | 4 ----
 scripts/Makefile.modsign    | 3 ---
 6 files changed, 21 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e7889f4..514ed63 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -590,7 +590,4 @@ endif
 # We never want them to be removed automatically.
 .SECONDARY: $(targets)
 
-# Declare the contents of the .PHONY variable as phony.  We keep that
-# information in a variable se we can use it in if_changed and friends.
-
 .PHONY: $(PHONY)
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 808d09f..17ef94c 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -88,7 +88,4 @@ PHONY += $(subdir-ymn)
 $(subdir-ymn):
 	$(Q)$(MAKE) $(clean)=$@
 
-# Declare the contents of the .PHONY variable as phony.  We keep that
-# information in a variable se we can use it in if_changed and friends.
-
 .PHONY: $(PHONY)
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
index a763b47..40867a4 100644
--- a/scripts/Makefile.modbuiltin
+++ b/scripts/Makefile.modbuiltin
@@ -54,8 +54,4 @@ PHONY += $(subdir-ym)
 $(subdir-ym):
 	$(Q)$(MAKE) $(modbuiltin)=$@
 
-
-# Declare the contents of the .PHONY variable as phony.  We keep that
-# information in a variable se we can use it in if_changed and friends.
-
 .PHONY: $(PHONY)
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 51ca024..ff5ca98 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -35,8 +35,4 @@ modinst_dir = $(if $(KBUILD_EXTMOD),$(ext-mod-dir),kernel/$(@D))
 $(modules):
 	$(call cmd,modules_install,$(MODLIB)/$(modinst_dir))
 
-
-# Declare the contents of the .PHONY variable as phony.  We keep that
-# information in a variable so we can use it in if_changed and friends.
-
 .PHONY: $(PHONY)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index df41744..dd92dbb 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -149,8 +149,4 @@ ifneq ($(cmd_files),)
   include $(cmd_files)
 endif
 
-
-# Declare the contents of the .PHONY variable as phony.  We keep that
-# information in a variable se we can use it in if_changed and friends.
-
 .PHONY: $(PHONY)
diff --git a/scripts/Makefile.modsign b/scripts/Makefile.modsign
index 171483b..da56aa7 100644
--- a/scripts/Makefile.modsign
+++ b/scripts/Makefile.modsign
@@ -27,7 +27,4 @@ modinst_dir = $(if $(KBUILD_EXTMOD),$(ext-mod-dir),kernel/$(@D))
 $(modules):
 	$(call cmd,sign_ko,$(MODLIB)/$(modinst_dir))
 
-# Declare the contents of the .PHONY variable as phony.  We keep that
-# information in a variable se we can use it in if_changed and friends.
-
 .PHONY: $(PHONY)
-- 
2.7.4

