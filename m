Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F9FDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BBB208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NtCaVCao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BBB208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeFNKhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:37:34 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43052 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754870AbeFNKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:37:30 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5EAaqEg008870;
        Thu, 14 Jun 2018 19:36:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5EAaqEg008870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528972614;
        bh=goAfbsPn8A6cA25Q2KrraItR1mxigSL66ldGLXQ9+HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtCaVCaocq7rOiSf2J9Xm6NgfVGTQocCMXp608QGGe4WvjWetLMpOYNPzCTwNdPQi
         3gz2EbcbdroYST8tbRHemg10V8MPkgqBO2IToddbAf9GWltCKrpeCI+KREy8ANLSwD
         9T8JyAOAN4MAXwyID/QRiVDKtpLX/qXD7mxhsTwQnx9tAjXeBFau5tzjHK5vDJvLsa
         /mtwav34TFptcH3+FMaWQbFjFDbrHYTgW4T5GFI+cFwzYzyPflvQZL1o9SoIc96biQ
         L/iqMQmQm51JgdNbIQUKqMVS70WeUT3GcSriPHomkkTtpUHZ+3MS5MPPfl9nd65DFG
         ETt6pmf9VVe6A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] kconfig: tinyconfig: remove stale stack protector fixups
Date:   Thu, 14 Jun 2018 19:36:44 +0900
Message-Id: <1528972605-24264-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528972605-24264-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 2a61f4747eea ("stack-protector: test compiler
capability in Kconfig and drop AUTO mode"), the stack protector
was configured by the choice of NONE, REGULAR, STRONG, AUTO.

tiny.config needed to explicitly set NONE because the default
value of choice, AUTO, did not produce the tiniest kernel.

Now that there are only two boolean symbols, STACKPROTECTOR
and STACKPROTECTOR_STRONG, they are naturally disabled by
"make allnoconfig", which "make tinyconfig" is based on.
Remove unnecessary lines from the tiny.config fragment file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 kernel/configs/tiny.config | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index 9bfdffc..7fa0c4a 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -10,7 +10,3 @@ CONFIG_OPTIMIZE_INLINING=y
 # CONFIG_SLAB is not set
 # CONFIG_SLUB is not set
 CONFIG_SLOB=y
-CONFIG_CC_STACKPROTECTOR_NONE=y
-# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
-# CONFIG_CC_STACKPROTECTOR_STRONG is not set
-# CONFIG_CC_STACKPROTECTOR_AUTO is not set
-- 
2.7.4

