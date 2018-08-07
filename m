Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8075C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DEE21A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="i6KGAbCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DEE21A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeHGFCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:02:46 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:40171 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeHGFCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:02:45 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w772nfCt017143;
        Tue, 7 Aug 2018 11:49:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w772nfCt017143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533610181;
        bh=3dvDfMBLbfUVQMc1bfMbXYqvmMlmHIp7smQykdbiObo=;
        h=From:To:Cc:Subject:Date:From;
        b=i6KGAbCoaEWZ/OudD1IGjn+J9R8Ym/fAGXB1OxgFoJ42m2qhVwhiQ6nf7yGVQBw4U
         O5YNkqKHtaQNZuMCad2J0fA0QbP9t10kcpfGnLXlcxrtmszKVBrDmGIFqYqZ8EDxTO
         GEzCNqzKvEGp/ieEXIIQi9HEz3lub2s4tbc+8YKeX4b33Xzx7Dcu0uBmmREzsJKJCl
         zsw7RUuTCFhuXpSiGbnd0jDLikPA9uAEOhCjVKxkPGrfmW5V/pfoOlBurzANRHpltR
         38OCAaBsv9Ajqk0KljAGpitFS3hpqW94iGQ24+zk9GUD/3+PhmO/u3/fc0kTDsk/po
         vVDJvmv832AWg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: uniphier: drop meaningless pin from SD1 pin-mux of Pro4
Date:   Tue,  7 Aug 2018 11:49:39 +0900
Message-Id: <1533610179-13885-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin 327 was supposed to be used as a voltage control line for the
SD card regulator, but the SD card port1 does not support UHS-I.  It
only supports 3.3V signaling, hence this pin is pointless.

Just a note about the background.  At first, hardware engineers tried
to implement the UHS for this port.  Then, they needed to shrink the
silicon die size, and gave up the UHS, but forgot to remove the pin
assignment.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 24788a7..b2c1ffe 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1047,9 +1047,8 @@ static const unsigned nand_cs1_pins[] = {131, 132};
 static const int nand_cs1_muxvals[] = {1, 1};
 static const unsigned sd_pins[] = {150, 151, 152, 153, 154, 155, 156, 157, 158};
 static const int sd_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
-static const unsigned sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326,
-				    327};
-static const int sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
+static const unsigned int sd1_pins[] = {319, 320, 321, 322, 323, 324, 325, 326};
+static const int sd1_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0};
 static const unsigned system_bus_pins[] = {25, 26, 27, 28, 29, 30, 31, 32, 33,
 					   34, 35, 36, 37, 38};
 static const int system_bus_muxvals[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-- 
2.7.4

