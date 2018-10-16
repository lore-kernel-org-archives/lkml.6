Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FCDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CE320869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s6IkLnVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CE320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeJPL7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:59:24 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:60996 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJPL7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:59:24 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w9G4A3US006243;
        Tue, 16 Oct 2018 13:10:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w9G4A3US006243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539663003;
        bh=Y7nB0A+WIP9fssvCRjk/kQT9YLZFFjDyU5jx8T7xl38=;
        h=From:To:Cc:Subject:Date:From;
        b=s6IkLnVHR4O85HFA/xc5A3smH/PfcP0mC72r0/u1rEytYN9Wab3/pEkYrfuvYwXLU
         cNtqK2dt7vmMYfpgTWhYgPA3KE4MVqEAMrOADB5CHyEokdjULAWm/MdIpJY38ZqZRk
         6Vn+5EVbmvxlA3bm3aQImg7c3V5isyOLFsjvVuPKXei/doug1lsU0poRsdZWfMIWgC
         BWafygfpOG3UYcVupUFoEwzIjRtVri2Wmjz+MPbmR1vY+Qg4TsoNkbih4PjUvQm2Rv
         5KTxo5ZZ9RhIHmhOj8CtJnWyrDVkHCuS71cpKf2GG30yU2qtoRkATjBllRkGxzAovA
         1KVXUT6EjChSA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: uniphier: include <linux/bits.h> instead of <linux/bitops.h>
Date:   Tue, 16 Oct 2018 13:09:58 +0900
Message-Id: <1539662998-15467-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason of including <linux/bitops.h> here is just for BIT() macro.

Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
macros from <linux/bitops.h> to a new <linux/bits.h> file"),
<linux/bits.h> is enough for such compile-time macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index 0a3d2ac..c63e3c8 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -16,7 +16,7 @@
 #ifndef __PINCTRL_UNIPHIER_H__
 #define __PINCTRL_UNIPHIER_H__
 
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-- 
2.7.4

