Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17AC46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBBA219C8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1vToH9cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBBA219C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHKEth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:49:37 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:57711 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeHKEth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:49:37 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w7B2GHNx012458;
        Sat, 11 Aug 2018 11:16:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w7B2GHNx012458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533953778;
        bh=mr/OYl9eZMqHjnSfpYf/Wkx0flsgam/LzKfXAJedaM8=;
        h=From:To:Cc:Subject:Date:From;
        b=1vToH9cn1IdP4LpOlbxOZDsJWBEm5H1gYbxYfICLZJuF0HEKmela19s6f31iPUMeG
         4o/Q2QKM3EwH/+1C2MuVRULpO7sq9ouJhgn8A+5isxnZeqDOL2S/QQOjqSB7XN67lG
         ttITv0/iAYRCmQGHkITW5mIpwiqWT3J0ADQPhAW+UXieeykrn61szLgnglG1zm2Qvo
         riGgK0KlnG0UhEMV+GMHlEikuuvss7AyOQRKrshcx0+DhEd2eYFQj/Wm+aMo1Iz7sb
         X90rjrGixDK+MXzBZB7FINBEjbztgjwjCvXDfyeekLG3+Yl+kMrqVN2uRD2a2FRjPA
         wg5Ag1rSbMvxg==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: uniphier: drop meaningless pin from SD1 pin-mux of Pro4
Date:   Sat, 11 Aug 2018 11:16:13 +0900
Message-Id: <1533953773-29424-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v2:
 - rebase onto linux-pinctrl/devel branch

 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 89148f8..6fca8d5 100644
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
 static const unsigned spi0_pins[] = {199, 200, 201, 202};
 static const int spi0_muxvals[] = {11, 11, 11, 11};
 static const unsigned spi1_pins[] = {195, 196, 197, 198, 235, 238, 239};
-- 
2.7.4

