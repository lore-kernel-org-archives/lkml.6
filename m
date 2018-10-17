Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E671FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D6E2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D6E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJRBCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:02:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeJRBCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:02:39 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCpGg-0003Ud-5x; Wed, 17 Oct 2018 19:05:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, linux-kbuild@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-sparse@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/3] kbuild: Add -Wshadow to sparse
Date:   Wed, 17 Oct 2018 19:05:52 +0200
Message-Id: <20181017170554.18841-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017170554.18841-1-bigeasy@linutronix.de>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I remember that `sparse' used to warn about shadowed variables but it
seems not to do it by default anymore. It was useful.

Enable `-Wshadow' while invoking sparse.

Cc: linux-sparse@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bf3786e4ffece..0160c6b5dd45d 100644
--- a/Makefile
+++ b/Makefile
@@ -390,7 +390,7 @@ PYTHON3		= python3
 CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
-		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
+		  -Wbitwise -Wno-return-void -Wno-unknown-attribute -Wshadow $(CF)
 NOSTDINC_FLAGS  =
 CFLAGS_MODULE   =
 AFLAGS_MODULE   =
-- 
2.19.1

