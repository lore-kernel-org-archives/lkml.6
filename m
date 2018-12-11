Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75F6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16D2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mlAhdcX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F16D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeLKLDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:03:49 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36645 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLKLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5q017210;
        Tue, 11 Dec 2018 20:01:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5q017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526083;
        bh=hQqCTjoRIjLqoLUmPlZgKJ2ZaiAFSXArnm21e+xMC34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlAhdcX5/vK0XuWn+Ja+5hV04zdTzvpvxDr7o4JTTLWF6dgPcx02hC9pr9oDYMUfz
         oCkF+BlAz4JPKJEYFLPYOlI2/PhTl4pqcA2Q5en90tdWBmwmO82aM1EMncNvC/1OOc
         irMHgTqaEuEpX+cOU0goJBTQqTwroIAMg+/lcMLBT0y/CFcvMwYtCeToEv0FW7LUsz
         80/UnAmnGz5jFBuuow9Iktz9WgwRNaxm34klyOK66kpchyGJRJgLDpnM2IZw7haIsH
         lN4lXnc1jJjchlQF3qQlPm5tNG0b9DmAMAi/m9kBC2DS9BT7E+qy0a67ISmZcUclR+
         j0bfQpU4i6DLw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 15/27] kconfig: remove redundant token defines
Date:   Tue, 11 Dec 2018 20:00:58 +0900
Message-Id: <1544526070-16690-16-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are already defined as %left.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 7a4bc58..020454b 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -69,11 +69,6 @@ static struct menu *current_menu, *current_entry;
 %token <id>T_ON
 %token <string> T_WORD
 %token <string> T_WORD_QUOTE
-%token T_UNEQUAL
-%token T_LESS
-%token T_LESS_EQUAL
-%token T_GREATER
-%token T_GREATER_EQUAL
 %token T_CLOSE_PAREN
 %token T_OPEN_PAREN
 %token T_EOL
-- 
2.7.4

