Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E16C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AD82148D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dNCerd7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AD82148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeHQFji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:39:38 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:47223 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeHQFji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:39:38 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w7H2brZA019439;
        Fri, 17 Aug 2018 11:37:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w7H2brZA019439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534473474;
        bh=CLHxfs9DDX537EEkR1oMSYYl+77vjTZ36vklS8rORjY=;
        h=From:To:Cc:Subject:Date:From;
        b=dNCerd7RZ3j3LER2QKCdaT9ZxhE3q8GC8pqypmxxlY6IeiSJRpsH3aZuC9QHA8Uw+
         KXaOaPEAMT3mpvZWXL1RnNQFsNYiSKQHusYTzWR0yeV773lVnMtUZ1m7Me7Fpu8uW2
         dbIHBJj8mBrGb0k5D0Bc8Is24PIR5nSeicDkEXGJoDprSyLMRoOPwe9c0tQxOSJWrg
         s7RP2DtGJR/kCim9wDuPUDIx29/Mhri5gJH5+IdOesJNA0g+tKyMTAm+m17DrtDDt+
         RoypAGKbjhDe2SyMvUBhBNbq6+3YBbucxoaGpzZlFsy9IHcKe5JptQFvRnDBXe0jeE
         7qYA60RcO4FMQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove "rpm" target, which is alias of "rpm-pkg"
Date:   Fri, 17 Aug 2018 11:37:21 +0900
Message-Id: <1534473441-16755-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit ebaad7d36406 ("kbuild: rpm: prompt to use "rpm-pkg" if "rpm"
target is used") noticed, the "rpm" target is now removed.
I assume people have already migrated to "rpm-pkg".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Makefile b/Makefile
index a0650bf..6833b96 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,16 +1338,12 @@ distclean: mrproper
 
 # Packaging of the kernel to various formats
 # ---------------------------------------------------------------------------
-# rpm target kept for backward compatibility
 package-dir	:= scripts/package
 
 %src-pkg: FORCE
 	$(Q)$(MAKE) $(build)=$(package-dir) $@
 %pkg: include/config/kernel.release FORCE
 	$(Q)$(MAKE) $(build)=$(package-dir) $@
-rpm: rpm-pkg
-	@echo "  WARNING: \"rpm\" target will be removed after Linux 4.18"
-	@echo "           Please use \"rpm-pkg\" instead."
 
 
 # Brief documentation of the typical targets used
-- 
2.7.4

