Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D493EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2UlIyprc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC2620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeILJ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:28:32 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:32285 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeILJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:28:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w8C4PNLV025631;
        Wed, 12 Sep 2018 13:25:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w8C4PNLV025631
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536726324;
        bh=UrKjS4w0DtVaY1t9GuHe2zcZQugHX0XIU9drYuKoqBw=;
        h=From:To:Cc:Subject:Date:From;
        b=2UlIyprc6ZCHRtbEFdu2aW2u/7lks3sqUjfFz/U3JAS6AJM8Y6SSsh3o3mI04oCYW
         qqcbOAvvSDLOfis/FX6LqidGJ/VjQf6Ub6qd43eK//i4DW73bkeAPRoZjuHLMy4cKJ
         H7qRilyyDoB3bqHt5gkJdVrb7W/wTyOr3JMxPxxfvMbwlPhrV9DB48DfXS3RWpTCim
         zVCbpd0VGUq5hxG454Of+wihxonWwr2w0Q3AIZZym4hmyIQ3X75XwuE35wsYjtvIhw
         k5EV7zLYtFaf9eGgdx6AMrj2hnXyHGmxH3wMhKKduZCOCItBqoMwsL03Ins8YfsnmK
         ghI38/7bK9jUg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: remove unnecessary KBUILD_SRC ifeq conditional
Date:   Wed, 12 Sep 2018 13:25:19 +0900
Message-Id: <1536726319-9645-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can always prefix variant/platform header search paths with
$(srctree)/ because $(srctree) is '.' for in-tree building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/xtensa/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 295c120..d67e30fa 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -64,11 +64,7 @@ endif
 vardirs := $(patsubst %,arch/xtensa/variants/%/,$(variant-y))
 plfdirs := $(patsubst %,arch/xtensa/platforms/%/,$(platform-y))
 
-ifeq ($(KBUILD_SRC),)
-KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(vardirs) $(plfdirs))
-else
 KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(vardirs) $(plfdirs))
-endif
 
 KBUILD_DEFCONFIG := iss_defconfig
 
-- 
2.7.4

