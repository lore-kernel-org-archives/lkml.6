Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE733C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D01E20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NUS4GQCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D01E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeILLr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:47:26 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:52579 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeILLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:47:26 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w8C6i7nl032726;
        Wed, 12 Sep 2018 15:44:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w8C6i7nl032726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536734648;
        bh=fCMh7OEfW756buq9MDgJm2d4nDy7HXvGyXS6ALQbgtc=;
        h=From:To:Cc:Subject:Date:From;
        b=NUS4GQCFm7HJb2SQoGnh7OxH21et1ox1d7DABBW8r084JKbvwrlRRLQLztCVPa0SJ
         tzHC3DZwBWvKMXNDOXM5f50PHLq+sECUKHYFKmnOGruZ+vNez4Wij2oI8oCm8UUkfd
         iq953tcLxBHLjtguPJM7PoH2rssGsWrhfE0kDIh9Ykd6pi7+79yzg+gxWFgAUnIZxK
         wChTvyxLfDL7seHMcKlcS/RLjUEzK5cA35h4H3FMlJQzPxct/kwwxWNKCcUwORfJFq
         BqtLVsG7gUowNyU+54VSKetg4dDF21cLX059aHiCtxVqbOTZNBC90MTLm0WQrIN0iW
         86MeABqiWJyHA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: hide most of targets when running config or mixed targets
Date:   Wed, 12 Sep 2018 15:43:29 +0900
Message-Id: <1536734610-22173-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mixed/config targets are being processed, the top Makefile
does not need to parse the rest of targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4d5c883..4b76e22 100644
--- a/Makefile
+++ b/Makefile
@@ -1615,9 +1615,6 @@ namespacecheck:
 export_report:
 	$(PERL) $(srctree)/scripts/export_report.pl
 
-endif #ifeq ($(config-targets),1)
-endif #ifeq ($(mixed-targets),1)
-
 PHONY += checkstack kernelrelease kernelversion image_name
 
 # UML needs a little special treatment here.  It wants to use the host
@@ -1732,6 +1729,8 @@ ifneq ($(cmd_files),)
   include $(cmd_files)
 endif
 
+endif   # ifeq ($(config-targets),1)
+endif   # ifeq ($(mixed-targets),1)
 endif	# skip-makefile
 
 PHONY += FORCE
-- 
2.7.4

