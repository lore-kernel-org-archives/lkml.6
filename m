Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6124CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AF021735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xC4uWdk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AF021735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeH0GN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:13:28 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39332 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeH0GN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:13:27 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w7R2SIW7018677;
        Mon, 27 Aug 2018 11:28:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w7R2SIW7018677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535336899;
        bh=RQt8XGarQHrdI24EZgxunoPdnuXMQ6n80w7QzG/VQNE=;
        h=From:To:Cc:Subject:Date:From;
        b=xC4uWdk6reh+QtqUX8OBa1CmsEB+ifAY8L7I+w3suddlItgz74mdUZGWedkrmVyUZ
         ca2W78b+AG1VN7d/y4m276y9mN2q0qgJE8dL37Mel2I910O4vLG2nV+Fe5JRUfkrX/
         WEw6auBAz/Q+wZ6ONFtD6V1YT5YyGjP8xdsc00avW1XkHmLe3fq3Co/OZPKqlf4p1w
         2ygIvwOZOof63GjWaXWYMsY3qqXqY7TObjk2zRw6zcbebkrh/lBYT424ULRvrqLp4o
         bSsb5l4S20htF7d4VYAkq4h3JENw4sxQidiX7O0inP8zJ55BvGied08O10b/SWSzP9
         3fYQFxkZj4M8g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: remove check for minimum required GCC version
Date:   Mon, 27 Aug 2018 11:28:08 +0900
Message-Id: <1535336888-12183-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

The version check in arch/parisc/Makefile is obsolete now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/parisc/Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 5ce0302..d047a09 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -156,12 +156,3 @@ define archhelp
 	@echo  '		  copy to $$(INSTALL_PATH)'
 	@echo  '  zinstall	- Install compressed vmlinuz kernel'
 endef
-
-# we require gcc 3.3 or above to compile the kernel
-archprepare: checkbin
-checkbin:
-	@if test "$(cc-version)" -lt "0303"; then \
-		echo -n "Sorry, GCC v3.3 or above is required to build " ; \
-		echo "the kernel." ; \
-		false ; \
-	fi
-- 
2.7.4

