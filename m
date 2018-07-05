Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27112C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD55921525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HZyZgMfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD55921525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeGEDde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 23:33:34 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:24208 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbeGEDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 23:33:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w653XFC2027618;
        Thu, 5 Jul 2018 12:33:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w653XFC2027618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530761595;
        bh=kycmtzOd3HDAYwzBoogmOvRvNV9op4D50v30/qTkts4=;
        h=From:To:Cc:Subject:Date:From;
        b=HZyZgMfjyl9l9ckBHBlmP7YgH0e09oCY4qeZrbhkJo6E+e4rYklzMX9h/UZaunVqp
         Qhole+BqVL2FcVd7Ag7y40fOM0qmDR/AUPnRqQuePEw1xdKS1+ZcFkUAJ7A8VrznX2
         +a8X+BaTy+jxdtfk6tJ9HF5pXaJaHj7/NM1zNP5B+PGfr0sILNbmMkUPreicJD4id9
         u7DyNN7uGzjeq7OptRLWo1Ss/Di3izGDeu1Tunn2Yfrkr5gItn3eGPoFwFU3wdEsdg
         9HRQkwNqnJo2i9ecqVNEaK+5t1oihHUNfU7x8AYgDrtLrjgbz74vBOe9N337mCbw9Y
         nzEnANnIgcEwg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/2] Makefile: .PHONY is not a variable, but PHONY is
Date:   Thu,  5 Jul 2018 12:33:07 +0900
Message-Id: <1530761588-9986-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Magnusson <ulfalizer@gmail.com>

.PHONY is a target, not a variable.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Ulf sent this a long time ago.
https://patchwork.kernel.org/patch/7111711/
Unfortunately, it was lost for some reason.

I am resending to apply it if Ulf does not mind it.


 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 58bd78b..b610cb0 100644
--- a/Makefile
+++ b/Makefile
@@ -1720,6 +1720,6 @@ endif	# skip-makefile
 PHONY += FORCE
 FORCE:
 
-# Declare the contents of the .PHONY variable as phony.  We keep that
+# Declare the contents of the PHONY variable as phony.  We keep that
 # information in a variable so we can use it in if_changed and friends.
 .PHONY: $(PHONY)
-- 
2.7.4

