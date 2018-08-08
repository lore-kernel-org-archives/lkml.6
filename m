Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83050C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308F5216EE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 04:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iL9+KKIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308F5216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHHG0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 02:26:54 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:57737 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeHHG0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 02:26:53 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w78475Hh002928;
        Wed, 8 Aug 2018 13:07:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w78475Hh002928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533701226;
        bh=+aEN0ZYITifTQKPqjWdlYZaoxzIXggS7GbtP0zYZY4g=;
        h=From:To:Cc:Subject:Date:From;
        b=iL9+KKIB04++aI7aXh6mh1oL1PIYOk03PhK3y24oWNkRZh/NwHDP7BbQ5uAZDvdI4
         RnUoB3ysWZRgf9PRIPCo0hW5IlYVeNgLkJi0Iwkv86Cx4K7m864+tULLAFoJpy+RPI
         23xH5qRvN0cMyaRuRjdDnKb5zpsRl6Ud7q76wHZTo4uaInoUCxPJVJuQQX9w/OeOh1
         T7Mt98HMobwd/vDbJ8mmIQDd0SE3kI2c1+vkBtlReZ+1tmL94KrlBojkdZeq8DgZGR
         Ql3RYnbOAcn9KlbNU3dDBGuC8b1gMYvuGmcxyM6+ltvzh1AhEkXFpPSTJB0uxjltMQ
         ptU3E/pXwg3uw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Rob Landley <rob@landley.net>, Ulf Magnusson <ulfalizer@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RESEND PATCH] init/Kconfig: Use short unix-style option instead of --longname
Date:   Wed,  8 Aug 2018 13:06:43 +0900
Message-Id: <1533701203-31019-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>

Avoids warning messages with the latest release of toybox, which never
bothered to implement the --longopts nothing was using.

Signed-off-by: Rob Landley <rob@landley.net>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This was sent to the trivial ML some time ago,
but not applied yet.

I will apply this to kbuild tree for v4.19

[yamada.masahiro@socionext.com
 Move the patch description under '---'
 to the commit log body.
]


 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 794a1b1..944b1fd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2,9 +2,9 @@ config DEFCONFIG_LIST
 	string
 	depends on !UML
 	option defconfig_list
-	default "/lib/modules/$(shell,uname --release)/.config"
+	default "/lib/modules/$(shell,uname -r)/.config"
 	default "/etc/kernel-config"
-	default "/boot/config-$(shell,uname --release)"
+	default "/boot/config-$(shell,uname -r)"
 	default ARCH_DEFCONFIG
 	default "arch/$(ARCH)/defconfig"
 
-- 
2.7.4

