Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845CCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484B920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EAkvvkXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484B920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJPMA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:00:58 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:48919 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeJPMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:57 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w9G4BaCL013832;
        Tue, 16 Oct 2018 13:11:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w9G4BaCL013832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539663097;
        bh=XS6ZEvqi/SFR+XSyuw/XaM4AIaSuo0fwAa2YCyuhviE=;
        h=From:To:Cc:Subject:Date:From;
        b=EAkvvkXzd6EOSBqgzG5hBilS8QEnZaH499hHbyaefY08glayV+iaPDLz0FlmgeI3/
         fUt7NLWNRQ+nrqJZGI9rjKlmFjlubaRkROZj25g9yLoky9l8P1kewJeT4tvWBHe7rf
         pCiFEB3aX46mFsqEn88zsg72NVbZcbhUgrZ0Ou+mnjnNOnFaAr/qqP2/BWHRobC38x
         oHKvNxamPIpaVWM9mvj8ey6Uz7YvkDNCaUphpUWGKGJVtrDOxiUqdCeoYm7HMFdntG
         WKWElRHzfbze7l5fI1ZDQzLIW9A4dRaW4HEdXuCY3n12MS9se3fOvsy1vOiHL0rGRT
         4Y3PL2aHqX3SQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: uniphier: include <linux/bits.h> instead of <linux/bitops.h>
Date:   Tue, 16 Oct 2018 13:11:33 +0900
Message-Id: <1539663093-15923-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason of including <linux/bitops.h> here is just for BIT() and
GENMASK macros.

Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
macros from <linux/bitops.h> to a new <linux/bits.h> file"),
<linux/bits.h> is enough for such compile-time macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpio/gpio-uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 7fdac90..74551cbd 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -12,7 +12,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/gpio/driver.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-- 
2.7.4

