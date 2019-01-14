Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB9EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDAE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RSxemRxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfANDQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:16:54 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:30387 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfANDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:16:54 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0E3Gm99012581;
        Mon, 14 Jan 2019 12:16:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0E3Gm99012581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547435809;
        bh=BkYj0l8nnCiXjiQPBDT7Zh7zPAzUieILg/MXy6Z6nmE=;
        h=From:To:Cc:Subject:Date:From;
        b=RSxemRxi5ONOm4tMl7mE+UfugVGQ6F7x1SF/CR1TPa30FmyYNOaTXbg1uiwfIrvfx
         nTLcHlC3ulhLdjXcVQeXtPjzlyHMM05P2CPQqGli5EUUBmw57/GNhrRWTKJGP6Jv1S
         T8cAvThq3jggxE89in+lV/eoHrOB67EtTr5aapjN0IRYmySNofEJpB/jWc2CCCesCd
         n93680nSy5+/uW+lBzCbeQb78+WIE84ZRAizW9I5VTQibskaxgcrOyDYPNW9Fz8GkT
         nrtVV0AD3r6iJ9Fj/0PPZexO688vlGRacL3eYAqbsadNtqsaOcUSBiHq1g/S0oIUOq
         btLhwRa5Y/0vw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove unused baseprereq
Date:   Mon, 14 Jan 2019 12:16:45 +0900
Message-Id: <1547435805-8110-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit eea199b445f6 ("kbuild: remove unnecessary LEX_PREFIX and
YACC_PREFIX") removed the last users of this macro.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 525bff6..3081603 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -24,10 +24,6 @@ depfile = $(subst $(comma),_,$(dot-target).d)
 basetarget = $(basename $(notdir $@))
 
 ###
-# filename of first prerequisite with directory and extension stripped
-baseprereq = $(basename $(notdir $<))
-
-###
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
 
-- 
2.7.4

