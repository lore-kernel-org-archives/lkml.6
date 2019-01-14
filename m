Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9398AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CE120660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WumxlcBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfANI3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:29:51 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:48887 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:29:50 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x0E8TYWL003366;
        Mon, 14 Jan 2019 17:29:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x0E8TYWL003366
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547454575;
        bh=GBmRKDB8sT4EYoMMy3INKDBKyXzRNoRi4uVKOObqmLo=;
        h=From:To:Cc:Subject:Date:From;
        b=WumxlcBr8YFms4EXI20U2+WsNH4kMUQnuxZFICPSLiulCM1FzagnhUELoC9AAdf6Q
         gxznAv+UfTXOFlp8wSiZ++X1YgryUSLrfLVWB8EqNoLFKdN2dhwORGujewh9s0c8pS
         bxGJXTDuSfksJm84s4MHS5eKJ7p5oehcFuN7b+zbVSgkvQvWFOPS+bHI7dzFdjrxzh
         Pb7VNESksIV7qRNX4Gt6wJxEwKKV1XsrUdd7Sl2BsJISHy6OfKHVOH56mCDj6Aa/JA
         Omo+y+J29Jz1NoUeR0hIMm5VKcYMqSl6JIcpZ+d6YoruqVKu4rdmiqdJHYaFB7zEeD
         hVXrw0Bj+k7rQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: remove unused archmrproper
Date:   Mon, 14 Jan 2019 17:29:29 +0900
Message-Id: <1547454569-27319-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one uses archmrproper.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile            | 4 ++--
 arch/h8300/Makefile | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 68898cc..a9c54e1 100644
--- a/Makefile
+++ b/Makefile
@@ -1360,11 +1360,11 @@ mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
 mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
 mrproper-dirs      := $(addprefix _mrproper_,scripts)
 
-PHONY += $(mrproper-dirs) mrproper archmrproper
+PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-mrproper: clean archmrproper $(mrproper-dirs)
+mrproper: clean $(mrproper-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index 4003ddc..f801f37 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -37,8 +37,6 @@ libs-y	+= arch/$(ARCH)/lib/
 
 boot := arch/h8300/boot
 
-archmrproper:
-
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-- 
2.7.4

