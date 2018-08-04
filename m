Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D0C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FF8217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R3Fpci9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FF8217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeHDGsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:48:24 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64073 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDGsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:48:23 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w744lBUg027764;
        Sat, 4 Aug 2018 13:47:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w744lBUg027764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533358035;
        bh=f+KzLO9Zo8AUTIEcRMJ6Yoats7Pnq6JJJRhdP/HI3cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3Fpci9t8O338kFk3wsstAPl1zn6q9F5GdnEqVgP/Cb59YYwzC8ywvrHgY0q0cSgB
         g69ZYKdCOXNmSoddffKvH4z17AqgKIoi3OZ48Vj0S0v3LgpJW/pXJIJWPn5zFGeMSf
         BdTJuAbKtH74c3JoeMuIVdOIx0RwJeRsH0c0hXCIu802kA0sH/w2FHj3+VSkWg0EQ7
         jyOSvtg+q4L1HDPAataaizmp4aWZ2v5X7Z4u7dTygOj3WpJMKD1n2nUGD48+BL8Ijb
         AT5rdU946DcboVFcpCwhoQelJ+0rh7ordseAafmiTbfzxdnynPgqTmrAUyTEPjS860
         M+I0LyiSc3B2Q==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] um: clean up archheaders recipe
Date:   Sat,  4 Aug 2018 13:47:03 +0900
Message-Id: <1533358023-5801-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that '%asm-generic' is added to no-dot-config-targets,
'make asm-generic' does not include the kernel configuration.

You can simply do 'make asm-generic' in the recursed top Makefile
without bothering syncconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/Makefile | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index de340e4..1a47f9c 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -116,13 +116,7 @@ endef
 KBUILD_KCONFIG := $(HOST_DIR)/um/Kconfig
 
 archheaders:
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            kbuild-file=$(HOST_DIR)/include/asm/Kbuild \
-		    obj=$(HOST_DIR)/include/generated/asm
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            kbuild-file=$(HOST_DIR)/include/uapi/asm/Kbuild \
-		    obj=$(HOST_DIR)/include/generated/uapi/asm
-	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) asm-generic archheaders
 
 archprepare: include/generated/user_constants.h
 
-- 
2.7.4

