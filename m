Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20F0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D44206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnO1Uh+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D44206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeLEJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbeLEJgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:18 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ABFA20850;
        Wed,  5 Dec 2018 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002577;
        bh=F/JuTopHfKY0BMHxqEx58wDTMyovheJvcxZcsPh11vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnO1Uh+RTp/16ZTbAkGxlvAiG3nPuZN7YHNGRah5enKwO9m3pqdLNu8ILSaTiDnAe
         kpl+mfE2mW5R0IWexcCahYw8i2ohw0NU9oVyWGLlgR8yzQMpRhAK6/fojQweZ4eBoi
         GfDqz37IDrxf3w61GrucOn0k0kMMO27IoUhNr7Kg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 005/123] ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask
Date:   Wed,  5 Dec 2018 04:33:57 -0500
Message-Id: <20181205093555.5386-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohit kumar <rohitkr@codeaurora.org>

[ Upstream commit 112b57fa737445b2361be332ce8cc0fd3e2b994e ]

SD line mask for MI2S starts from BIT 0 instead of BIT 1.
Fix all bit mask for MI2S SD lines.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 000775b4bba8..829b5e987b2a 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -49,14 +49,14 @@
 #define AFE_PORT_I2S_SD1		0x2
 #define AFE_PORT_I2S_SD2		0x3
 #define AFE_PORT_I2S_SD3		0x4
-#define AFE_PORT_I2S_SD0_MASK		BIT(0x1)
-#define AFE_PORT_I2S_SD1_MASK		BIT(0x2)
-#define AFE_PORT_I2S_SD2_MASK		BIT(0x3)
-#define AFE_PORT_I2S_SD3_MASK		BIT(0x4)
-#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(2, 1)
-#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(4, 3)
-#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(3, 1)
-#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(4, 1)
+#define AFE_PORT_I2S_SD0_MASK		BIT(0x0)
+#define AFE_PORT_I2S_SD1_MASK		BIT(0x1)
+#define AFE_PORT_I2S_SD2_MASK		BIT(0x2)
+#define AFE_PORT_I2S_SD3_MASK		BIT(0x3)
+#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(1, 0)
+#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(3, 2)
+#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(2, 0)
+#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
 #define AFE_PORT_I2S_QUAD01		0x5
 #define AFE_PORT_I2S_QUAD23		0x6
 #define AFE_PORT_I2S_6CHS		0x7
-- 
2.17.1

