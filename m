Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37528C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E460121CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kKUfE8iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E460121CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeGCBw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:52:58 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:20949 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeGCBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:52:53 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w631oqZn012779;
        Tue, 3 Jul 2018 10:50:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w631oqZn012779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530582654;
        bh=hqA5lf2vt9WOsT8uvEDcMBaVtWUE7n2nyAf1Ul9+cbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKUfE8izk/tAIjpDjGUVr/7NCROd1NPJZcJ2OtYlKpEgRl1TuZl/R2AG47WKJIwpk
         Hwo26vLDlavAtkYBE4JpAhQbOxeGjkoZQSWYBwIAc8jTZ0YSgR5x2C3D31wjGo0bYB
         9zcSlHbaQium0Td0z6nAU1GUQ//NzI/RB1oalCr4XUpFTntXQoqoS+j82sfvIylaCu
         xwjoL9R09wNYoBGARovWSOzsMCJUL6dIyLjHg1id+zeoTS4YO/o/siS+cxZSliB/bs
         86yRA20v0vStQORhhf1ErZEEFv7h856eyyEXli8QoO3rIEgRgp7Q5tp4wBTEANcPOV
         HVL4URlU4ORBQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 1/2] x86/build/vdso: remove unused vdso-syms.lds
Date:   Tue,  3 Jul 2018 10:50:13 +0900
Message-Id: <1530582614-5173-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file contains symbol values, and was originally linked into
vmlinux, but I have no idea what it was actually used for.

Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
not even linked.  Now it is completely orphan, and no problem has
been reported.  It is a proof that this file was not needed in the
first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Richard Weinberger <richard@nod.at>
Acked-by: Ingo Molnar <mingo@kernel.org>
---

 arch/x86/um/vdso/.gitignore |  1 -
 arch/x86/um/vdso/Makefile   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
index 9cac6d0..f8b69d8 100644
--- a/arch/x86/um/vdso/.gitignore
+++ b/arch/x86/um/vdso/.gitignore
@@ -1,2 +1 @@
-vdso-syms.lds
 vdso.lds
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index b2d6967..822ccdb 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,22 +53,6 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
 CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 
-targets += vdso-syms.lds
-extra-$(VDSO64-y)			+= vdso-syms.lds
-
-#
-# Match symbols in the DSO that look like VDSO*; produce a file of constants.
-#
-sed-vdsosym := -e 's/^00*/0/' \
-	-e 's/^\([0-9a-fA-F]*\) . \(VDSO[a-zA-Z0-9_]*\)$$/\2 = 0x\1;/p'
-quiet_cmd_vdsosym = VDSOSYM $@
-define cmd_vdsosym
-	$(NM) $< | LC_ALL=C sed -n $(sed-vdsosym) | LC_ALL=C sort > $@
-endef
-
-$(obj)/%-syms.lds: $(obj)/%.so.dbg FORCE
-	$(call if_changed,vdsosym)
-
 #
 # The DSO images are built using a special linker script.
 #
-- 
2.7.4

