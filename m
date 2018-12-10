Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B76C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF59D2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="SSlONadq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF59D2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeLJSmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:42:40 -0500
Received: from plaes.org ([188.166.43.21]:55212 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbeLJSmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:42:31 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id 4325B41A4E;
        Mon, 10 Dec 2018 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544467349; bh=vgPjZKkLtR2foKSb2/aM4T0Y7TjESGFmLL0vu1Bjlms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSlONadqlrWBkWFxCwIDBGKMqR2fOnLh6DiMMPI1+GERy527ZbbyHi5k2tgL6EiQz
         g+zoaz1Vjz8OauAvYxz4zGpKR6vZD5bhYw3S9Mo7r/cwfnfQ9DEbzoPlntPpcwktPv
         WtvAOoW481at0T+dWPXQ9BQ1+cej9rGiDaYYeggIO8mkw2/gKU63lo+pYXRbyn+B1L
         g6MHz5a7PD/KcYJHTO9Zc79lTStwJnQ/tQci6Rcz5NBlRWg7Kt//IFsGEWBeAvGhKv
         LM79EGbxf2wAksGr7hk1DD3MZ+Km32PjhwJ7BrLnp29YEFUmJkFWPgYJOxo7lGXkLr
         1j5s117nrDs/w==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 8/8] mfd: axp20x: use explicit bit defines
Date:   Mon, 10 Dec 2018 20:42:19 +0200
Message-Id: <2098c0aece09761bf975e72eaa75cba92a4e463d.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The AXP20X_OFF define is an actual specific bit, define it as such.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index c3f3dbd..d183ed8 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -30,7 +30,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#define AXP20X_OFF	0x80
+#define AXP20X_OFF	BIT(7)
 
 #define AXP806_REG_ADDR_EXT_ADDR_MASTER_MODE	0
 #define AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE	BIT(4)
-- 
git-series 0.9.1
