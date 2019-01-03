Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48139C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FAC2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oLfInPnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfACBrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:47:18 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:28990 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfACBrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:47:17 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x031l8nr026792;
        Thu, 3 Jan 2019 10:47:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x031l8nr026792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546480029;
        bh=dsf3rRiRpMxw5hf9jT1tQkAWOaQPbUuapZclvlO9tjc=;
        h=From:To:Cc:Subject:Date:From;
        b=oLfInPnCzHTDHq7VkHeMAX5QmluZo7pIR3NPZ/Cde80pRqUWUIs1TC53fbH/XagFh
         FHsXRpjMD+Y4KTGEe9NbqmvqkYrNZjNbuuyPXK+NYN3+Qx2kBWelFmzFeZvE5VgjQ2
         dFsRRdO+sUGDvYFX1sPYrgOToDY+d5kO+bTrpJMAaYdH2kXmExfLbSAFzj2FzKrJ08
         7Uyx2qDd3y5/EyNnQAiS7KhH4pJ14IRTH5hJwSZxWCBY82PQW22gYNOW3DY+yMm4RL
         dNxMP2yONk8toWj2jzbSmkyZcNnrDcKAvdaYUeQVUv/BdlTAIBFrs4gcZwqU61hbiL
         FUewTGTv3vI+Q==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unnecessary stubs for archheader and archscripts
Date:   Thu,  3 Jan 2019 10:47:05 +0900
Message-Id: <1546480026-13337-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make simply skips a missing rule when it is marked as .PHONY.
Remove the dummy targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 62c9890..0f0f689 100644
--- a/Makefile
+++ b/Makefile
@@ -1159,11 +1159,7 @@ export INSTALL_HDR_PATH = $(objtree)/usr
 # If we do an all arch process set dst to include/arch-$(SRCARCH)
 hdr-dst = $(if $(KBUILD_HEADERS), dst=include/arch-$(SRCARCH), dst=include)
 
-PHONY += archheaders
-archheaders:
-
-PHONY += archscripts
-archscripts:
+PHONY += archheaders archscripts
 
 PHONY += __headers
 __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
-- 
2.7.4

