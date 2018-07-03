Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96188C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4984821CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vOnzzUKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4984821CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeGCBwF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:52:05 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19502 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbeGCBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:52:03 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w631oqZo012779;
        Tue, 3 Jul 2018 10:50:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w631oqZo012779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530582655;
        bh=VbCZMY0C7DVro1YuP64OjVlSpvjYaELzQXFfwxjPWro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOnzzUKyzdi2IL7p9N13AE4BXkOvZzFEl5FYsF6g5kFq8yOqogKw6KJGi0zau+gPP
         r/ZXj90F5FPg20P0feMhd36YyRxqeF9oj8E8x0Hs5ZL16JrLyXKjCVclDMpWVA6avt
         U+COus0G2+y6ca9tw416bb/BhNcg4ryFrrQwgqUZ1cRKW2ziDiH3Il+rre/AWE7sFt
         hODXXC2sGOgN5IkDbvNYYynunTy23swA00xRIBhiasMC/k7iZX6yUHaP3JVYVxoSfI
         VDG0GLLWxTeG8boGMilSakMDLWF1Ss7fCHpexvfYMTQaaqSK1jlYLj9/u+D1niuUuC
         b+DR8MiUH30KQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] x86/build/vdso: simplify cmd_vdso2c
Date:   Tue,  3 Jul 2018 10:50:14 +0900
Message-Id: <1530582614-5173-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No reason to use 'define' directive here.  Just use the = operator.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/entry/vdso/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 261802b..b9ed1aa 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -58,9 +58,7 @@ HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(src
 hostprogs-y			+= vdso2c
 
 quiet_cmd_vdso2c = VDSO2C  $@
-define cmd_vdso2c
-	$(obj)/vdso2c $< $(<:%.dbg=%) $@
-endef
+      cmd_vdso2c = $(obj)/vdso2c $< $(<:%.dbg=%) $@
 
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
-- 
2.7.4

