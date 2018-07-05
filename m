Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D30C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0107E241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FZri1uVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0107E241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeGECl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:56 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:44271 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753419AbeGEClt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:49 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZi028145;
        Thu, 5 Jul 2018 11:40:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZi028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758406;
        bh=HPg1BTuEoSm+fgZpkkuu/EIbOF9VVMU6RAq5/wJ8UsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZri1uVyN8JKa0VRWZJUrz544w9WQ/POH1lATc7T++8NFLf8YbDDfIDQJeQbsb8Bh
         2S/3i5IvTzUMnh1tVaMl7RxxJbX8hXk9v1KAku6qiDJAvi4TkpCU/fK1Az3ryjv/no
         HHUnIzfNHhtolsQKxkp6RoomNwMPoNMUu6dhvs+DkFIcbSpMx2TdVDhvGZfaii4cDP
         yqWNzXHQvFRnSTaR5j8PXqLPEr6YSrv0T7wVOQ5CqPNrSVIdujbXzFl7DcYD+xuTrG
         qyw70QR1DSnJRE4o4KZRmYR1HFZfaGkgZYEn37os/PW437d5glTHfasJbq9eAAjFLs
         /LdQYOvYJcFgQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/12] kbuild: replace include/config/%.conf with include/config/auto.conf
Date:   Thu,  5 Jul 2018 11:39:49 +0900
Message-Id: <1530758389-30862-13-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that include/config/tristate.conf does not appear in the top-level
Makefile.  Replace the pattern rule with include/config/auto.conf .

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c6ab38c4..58bd78b 100644
--- a/Makefile
+++ b/Makefile
@@ -631,7 +631,7 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
 # The actual configuration files used during the build are stored in
 # include/generated/ and include/config/. Update them if .config is newer than
 # include/config/auto.conf (which mirrors .config).
-include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
+include/config/auto.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else
 # External modules and some install targets need include/generated/autoconf.h
-- 
2.7.4

