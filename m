Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F25C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A23D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AsHWlDLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A23D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeILJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:22:54 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:35161 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeILJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:22:54 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8C4J8bN016547;
        Wed, 12 Sep 2018 13:19:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8C4J8bN016547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536725949;
        bh=4kjbvxWJBpmQ6poDCtCAZrgx0SF1BBgDQWTx8o+LB20=;
        h=From:To:Cc:Subject:Date:From;
        b=AsHWlDLp/mSbYytMoIFDt5HWuvUapXDMgc/3LP0dZg65oqibYsqbc8ms4C/Xr7WSw
         58iL/prz7JwkaseipTntw8gcWabhUR6nYJYnq9fEEcZN7BPSFusuYB0s8/HNi99/Yn
         oqmN37GoLe338BmBxWe6QLckxOKEiWJIM0QnPCVVVxzGkAJAaSQERMoKNY2kNsF3gC
         G4xQRpI8xH17wMRDicGmDwtvEF6CNJE8KB7fYf1zQQM1rCnx2zNctMYTY9i9b+DUTL
         J066pEbZCa0oM7y78dzIoWlZ6QIMK1vEgfm1s4GREOYNiemnbZ2+ECvFLN7qyD0SAm
         sh9yVWlHVFOwQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: remove unnecessary KBUILD_SRC ifeq conditional
Date:   Wed, 12 Sep 2018 13:19:02 +0900
Message-Id: <1536725942-9206-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can always prefix machine/plat header search paths with
$(srctree)/ because $(srctree) is '.' for in-tree building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: v4.19-rc3


 arch/arm/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d1516f8..06ebff7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -264,13 +264,9 @@ platdirs := $(patsubst %,arch/arm/plat-%/,$(sort $(plat-y)))
 
 ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
 ifneq ($(CONFIG_ARM_SINGLE_ARMV7M),y)
-ifeq ($(KBUILD_SRC),)
-KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
-else
 KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
 endif
 endif
-endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-- 
2.7.4

