Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67941C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AAD223A6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="up7x8hz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AAD223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHKMWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:22:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49586 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeHKMWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:22:43 -0400
Received: from trochilidae.toradex.int (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 958BA5C0487;
        Sat, 11 Aug 2018 11:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533980940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=/SDwhWFSOzX2hOzrJWVw2MFpLo37GY2aoRJuslWjDAs=;
        b=up7x8hz4QKi6EGR3K46UFMdr1e8mc07jYyan+l6de/O6d0f3QX6ugpQdUTUc/rYvbkOE7K
        kGZhDOmCMPu8NktcE1ld/H/fuV+58HiiTLD7EeM330C9HJVqNgDrANKNxHKqBZwBmj9PV6
        1dLHaKsxUHQ3OR+/UIJEBxREERBMGc0=
From:   Stefan Agner <stefan@agner.ch>
To:     keescook@chromium.org
Cc:     yamada.masahiro@socionext.com, ast@kernel.org,
        akpm@linux-foundation.org, jbacik@fb.com, re.emese@gmail.com,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] gcc-plugins: require GCC
Date:   Sat, 11 Aug 2018 11:48:53 +0200
Message-Id: <20180811094853.32167-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unsurprisingly GCC plugins require GCC as a compiler. This avoids
GCC plugins being selectable when using clang.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1aa59063f1fd..8c693a837ed7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -422,7 +422,7 @@ config HAVE_GCC_PLUGINS
 
 menuconfig GCC_PLUGINS
 	bool "GCC plugins"
-	depends on HAVE_GCC_PLUGINS
+	depends on HAVE_GCC_PLUGINS && CC_IS_GCC
 	depends on PLUGIN_HOSTCC != ""
 	help
 	  GCC plugins are loadable modules that provide extra features to the
-- 
2.18.0

