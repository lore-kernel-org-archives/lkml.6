Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01429217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHPycQ3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfBZTgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38348 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbfBZTgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id g37so3911355plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICgFrTld9JRHTgnIIEzO9Y6X45uTsmJMMuA3yPbCJ84=;
        b=HHPycQ3kzU+Y2D8FPejN9JFINOdXQLaHw64LcLJD2HuungpnukAEhQMSynAGX2zfII
         L0tK0ZXwYH7oIjlor8PlP8fkIcC2Ar6tbmksTaRRCIoegXUIpLMvtMW8fAzcyCJXWYk7
         Yn0EwA4nrM0P4JQhE0Kmef5cLfpk6Aa7DxlbT69NI3cLL0fRAn9z8ab8ZWKDpwCFNH9X
         3yRMQFHQxqYAhqyR51a0cxUMLnx8v606OTDuMkThmdB0oBwaXXdDhGK0DA7r44vbtCyI
         kDBKUE7jSPQyMX+18+YHhc8Sy4dk6bD4ubV3dipOUMXpCQ3H078T7MbGppXq0CrmC4Ix
         a8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICgFrTld9JRHTgnIIEzO9Y6X45uTsmJMMuA3yPbCJ84=;
        b=IQVB8pPEcWRGefrn9bTgvFOSZxF0rlm0y8u8SCzAawCOTDVCRnHLAvJmdoGWR2e/y5
         jOBRvA04j/PRrMn4MlAT45oSL2rnMleArj6tpmekJQ7vLGFHWQLA63V2GGYRPnvSnRK5
         nXw4hHqUrWrM+W5D0EIhNj/4ASM0IgZv0c80p3W1Xr1bCTaADQUNyqa0NRF1LtEmJYvS
         06hXQKWwbzXgZmAkqxX3hRVB5aHhIiBElRFdIU10C1MM4JnLVrUrSTdVAGiVcEfB5wPR
         Ihb1t+l7dsOyrxarPqaPt9eTxfLtmjsPPRB6xfkIduyjozAAN3pxVi4oXq2wmnZFxhKT
         OXfA==
X-Gm-Message-State: AHQUAubtIGg2TzKLOR8oprWf86+/3iGBOEBLAkv9tqed5fuYxDEgjefk
        jQaZ5jpVuk9r4FsDmw2NkXc=
X-Google-Smtp-Source: AHgI3IYrdozcRXu7rccU9mHllRR136wgVElc55P0euzyBFsvrKiwM8g/8mNo4n1Wzi6cXG/2Qagarg==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr28310371plt.188.1551209792387;
        Tue, 26 Feb 2019 11:36:32 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:31 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
Date:   Tue, 26 Feb 2019 11:36:04 -0800
Message-Id: <20190226193609.9862-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling loop with equivalent call to
regmap_read_poll_timeout() for simplicity. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index c85468fcc157..6455e6484722 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -882,15 +882,11 @@ static int tc_main_link_setup(struct tc_data *tc)
 	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
 	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 
-	timeout = 1000;
-	do {
-		tc_read(DP_PHY_CTRL, &value);
-		udelay(1);
-	} while ((!(value & PHY_RDY)) && (--timeout));
-
-	if (timeout == 0) {
+	ret = regmap_read_poll_timeout(tc->regmap, DP_PHY_CTRL, value,
+				       value & PHY_RDY, 1, 1000);
+	if (ret) {
 		dev_err(dev, "timeout waiting for phy become ready");
-		return -ETIMEDOUT;
+		return ret;
 	}
 
 	/* Set misc: 8 bits per color */
-- 
2.20.1

