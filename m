Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B19C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736821BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="y8XYs7mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C736821BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeHIHnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:43:45 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:35798 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeHIHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:43:45 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w795JkSn011102;
        Thu, 9 Aug 2018 14:19:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w795JkSn011102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533791987;
        bh=jKSf+jpdtHLcyCSwRX+grJ4F8y0gPvMGuOo1S5Bylcc=;
        h=From:To:Cc:Subject:Date:From;
        b=y8XYs7mFlS5jBCHQZ6fYbnPWTmFMGUqDUZKXxT9v4Oz3GgPK/Fj2d1vqSyl28XoDS
         wN6ySgzNJ0x65rhF4a1M14Fz9CZKx1qkS65fpbKK5xPV/vTOhym9BXiCwpt0wOKnZ5
         TkbocQCF6ZPaH7ojZph6ZgzR8Y3DFtH+nVIj9JeezwZvPOF4Y+hxzF0Wqxe9m+P3RY
         jQLOBi6R+6M+jpgsCO4+gaMxtSbRU1nLCx93Edh8o/jefSTzbEqWby3wxrA4whijfK
         hRf1Ypgle07XWh1PFLCZkiRkttNutSH5zV5RlBOtzu3wm7EbeSTqEjNAl5xQAf2oiR
         DqxdRZf8Cy5AA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] kbuild: remove deprecated host-progs variable
Date:   Thu,  9 Aug 2018 14:19:31 +0900
Message-Id: <1533791971-27504-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host-progs has been supported as an alias of hostprogs-y at least
since the beginning of Git era, with the clear prompt:
  Usage of host-progs is deprecated. Please replace with hostprogs-y!

Enough time for the migration has passed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/xtensa/boot/Makefile | 3 +--
 scripts/Makefile.build    | 7 -------
 scripts/Makefile.clean    | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 53e4178..dc9e0ba 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -30,8 +30,7 @@ Image: boot-elf
 zImage: boot-redboot
 uImage: $(obj)/uImage
 
-boot-elf boot-redboot: $(addprefix $(obj)/,$(subdir-y)) \
-		       $(addprefix $(obj)/,$(host-progs))
+boot-elf boot-redboot: $(addprefix $(obj)/,$(subdir-y))
 	$(Q)$(MAKE) $(build)=$(obj)/$@ $(MAKECMDGOALS)
 
 OBJCOPYFLAGS = --strip-all -R .comment -R .note.gnu.build-id -O binary
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ba1c83b..b134b37 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -53,13 +53,6 @@ endif
 
 include scripts/Makefile.lib
 
-ifdef host-progs
-ifneq ($(hostprogs-y),$(host-progs))
-$(warning kbuild: $(obj)/Makefile - Usage of host-progs is deprecated. Please replace with hostprogs-y!)
-hostprogs-y += $(host-progs)
-endif
-endif
-
 # Do not include host rules unless needed
 ifneq ($(hostprogs-y)$(hostprogs-m)$(hostlibs-y)$(hostlibs-m)$(hostcxxlibs-y)$(hostcxxlibs-m),)
 include scripts/Makefile.host
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 17ef94c..0b80e320 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -38,7 +38,6 @@ subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
 
 __clean-files	:= $(extra-y) $(extra-m) $(extra-)       \
 		   $(always) $(targets) $(clean-files)   \
-		   $(host-progs)                         \
 		   $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
 		   $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
 		   $(hostcxxlibs-y) $(hostcxxlibs-m)
-- 
2.7.4

