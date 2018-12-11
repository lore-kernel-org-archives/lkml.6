Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D79C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TpCMKpVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D79C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLKLDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:03:52 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36640 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeLKLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5n017210;
        Tue, 11 Dec 2018 20:01:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5n017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526081;
        bh=IcgexvJt38ljGJvWC/WL37DAl0lX6I5rv6Nx+cZ8BoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpCMKpVQu6uoOgsl2+dJOlS6AOqf77CrWSP3g4VykvNco1bqMVvyZTWwEHXU7kYug
         DgRf8oEUZpP2RInI4I1ob1HQsSB83VwTE66RIvVeTUEZ56ugH9bj9CS0MLsJsCpT2n
         jwzyuXILeblIN9gZWBMBE6OB++8m7uLktDmsxF5kViY3PIIBWfJMHbzLu5+rsElxn4
         ro9kpgV6Zb4UG646p4oxyXma4oWBxbARg23JGuUBDmQfiWc9AGHLREmeAJss1CsXdj
         Oss1IVYe9Zw7u7l4K15DcXMoqYIuHPKSiPX7e6J1t589bS5QrSRZht+4dsSN43hJ8m
         J3lVo0QNUW7+g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 12/27] kconfig: remove redundant menu_block rule
Date:   Tue, 11 Dec 2018 20:00:55 +0900
Message-Id: <1544526070-16690-13-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code block surrounded by "menu" ... "endmenu" is stmt_list.

Remove the redundant menu_block symbol entirely.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index dcbf643..eeb449b 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -354,14 +354,7 @@ menu_end: end
 	}
 };
 
-menu_stmt: menu_entry menu_block menu_end
-;
-
-menu_block:
-	  /* empty */
-	| menu_block common_stmt
-	| menu_block menu_stmt
-	| menu_block choice_stmt
+menu_stmt: menu_entry stmt_list menu_end
 ;
 
 source_stmt: T_SOURCE prompt T_EOL
-- 
2.7.4

