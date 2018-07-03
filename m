Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E106924ED2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0f8AE7Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E106924ED2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeGCAkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:40:24 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:58781 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeGCAkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:40:23 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w630dLxU015568;
        Tue, 3 Jul 2018 09:39:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w630dLxU015568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530578362;
        bh=isHapNcNvpJ8y2I1Jw2hFJggrS10xWEX9y4kgjXIi0A=;
        h=From:To:Cc:Subject:Date:From;
        b=0f8AE7SyRQteOWbedL4ADMAvEW7HI9A9t8uxPG7nZB1Y86suZwXln1koA7pBGJI9r
         g+qkuLxrDKOv3JuWwtQpn4g9Mx8dQgL4uxebmIIvxECjwAj0Lo5GpLT9T1Djm1e9aK
         mnewALTbqMC/aO1J8jV8XO/s9jmqGmlyfN14rVb+u7qnTHYdix8Xy9JdXiqjbfLrLo
         Uxh+prwriYUIP34XlU5u7glkHT3IrpC6TQeP8h+F0o5adhWFP416VgeEw5mvf0UgZg
         bclsJQJRYfwyprafgiRkuiykSgfPKDSDCsl+z7ADIVAP0gWEnoByIjXHnqxnAFQzdV
         +wb4OEPDPhZJA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        kernel-hardening@lists.openwall.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
Date:   Tue,  3 Jul 2018 09:39:12 +0900
Message-Id: <1530578352-18613-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC_PLUGIN_SUBDIR has never been used.  If you really need this in
the future, please re-add it then.

For now, the code is unused. Remove.

'export HOSTLIBS' is not necessary either.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.gcc-plugins | 3 +--
 scripts/gcc-plugins/Makefile | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index c961b9a..f9942d9 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -19,7 +19,7 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)	+= -fplugin-arg-ra
 
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
 
-export GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
+export GCC_PLUGINS_CFLAGS GCC_PLUGIN
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
 # sancov_plugin.so can be only in CFLAGS_KCOV because avoid duplication.
@@ -27,7 +27,6 @@ GCC_PLUGINS_CFLAGS := $(filter-out %/sancov_plugin.so, $(GCC_PLUGINS_CFLAGS))
 
 KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
 GCC_PLUGIN := $(gcc-plugin-y)
-GCC_PLUGIN_SUBDIR := $(gcc-plugin-subdir-y)
 
 # Actually do the build, if requested.
 PHONY += gcc-plugins
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 3262546..aa0d0ec 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -14,8 +14,6 @@ else
   export HOST_EXTRACXXFLAGS
 endif
 
-export HOSTLIBS
-
 $(obj)/randomize_layout_plugin.o: $(objtree)/$(obj)/randomize_layout_seed.h
 quiet_cmd_create_randomize_layout_seed = GENSEED $@
 cmd_create_randomize_layout_seed = \
@@ -29,7 +27,4 @@ always := $($(HOSTLIBS)-y)
 
 $(foreach p,$($(HOSTLIBS)-y:%.so=%),$(eval $(p)-objs := $(p).o))
 
-subdir-y := $(GCC_PLUGIN_SUBDIR)
-subdir-  += $(GCC_PLUGIN_SUBDIR)
-
 clean-files += *.so
-- 
2.7.4

