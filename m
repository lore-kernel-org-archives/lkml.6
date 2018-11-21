Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D763C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0186A214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O5YgsCGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0186A214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbeKUVx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:53:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45542 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbeKUVx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:53:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so5238592wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osUMdjyiqZHaxg9ZCTFb55GNgDuiJBgZzn8UF7ivm7I=;
        b=O5YgsCGNL8cRP26lIoemeEArBDVVxsUEXr3LT/ypeiqltkHJs1u7pV638sE+eKZECL
         I5814vPtbn8Qily52oHUpmNgIpJEbsQJiOfyBVDjsApsgmt8QennIPPPIjeIl0QB/98u
         zFmHtgrH3xY3cFxvNUPWhnd+7Dm5/EEin15ozI3qpmy5S4UOkzdcV3aKmy1KYEQ4Ip9F
         1MIPVdMMaN3N6Rq+G67oZZD2KQ6E4ZXhj0T36C1sngdN0Pq6XgHB+qXLY8tiv3ohFhxy
         KqJaqcUZsiuVhim5z1blxajXQ0NGLAI8/S9DAO4s9VrysS+eDTjlpxy+LBlDfsdVbj6h
         BNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=osUMdjyiqZHaxg9ZCTFb55GNgDuiJBgZzn8UF7ivm7I=;
        b=cod2DP2/laz+A+lUzu/uUpQ0GlPSj3C8Os3XO6edtOJAlnbvZ6l4uy34FnQArRAI+y
         T5U+hwtw1F1U2YuTwNtYsqXrONCmG9gJuNQI1D/Z0ZC5eyVmcoMwl4pTAle3Hrwmf5f/
         Q9s7rHNgO7zYV2pETIdLKxUiuow5pwVAhXjoOFf0FCwB3KlkOkO888PJWj55+387waCE
         ws27Eef1UjUszQYV9SX7vVL2kbZlNAKY0L3N/CXKdfqhbOSSFwjfW6WGvNQAyo8DSvV5
         CFWSbk4ROa8RW/D2rSLNhoSjPRxH8XWUsUKszoOnfAisUGFoKmfM0vVoqUZWo0/VZNPl
         R0sw==
X-Gm-Message-State: AA+aEWY1fM1y9ruwK5SYBkGd5G2dedghdbbdXh9QEEB0BjfRXVLfzygt
        gu83eloYel8uqJ0K/Mt2yJtqEg==
X-Google-Smtp-Source: AFSGD/U4ToPWDhWMIVfrCWEO39Ct1Sv+O/F6p/hdz5gjgRQ12IjRK1mw/Zv8tw8qQdwMkZyfGaTTyQ==
X-Received: by 2002:adf:b453:: with SMTP id v19-v6mr5215814wrd.47.1542799166710;
        Wed, 21 Nov 2018 03:19:26 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f2sm4109201wru.14.2018.11.21.03.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 03:19:26 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: Fix GXL HDMI PLL fractional bits width
Date:   Wed, 21 Nov 2018 12:19:22 +0100
Message-Id: <20181121111922.1277-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GXL Documentation specifies 12 bits for the Fractional bit field,
bit the last bits have a different purpose that we cannot handle right
now, so update the bitwidth to have correct fractional calculations.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 30fbf8f1f190..aba59aa64d2b 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -219,7 +219,7 @@ static struct clk_regmap gxl_hdmi_pll_dco = {
 		.frac = {
 			.reg_off = HHI_HDMI_PLL_CNTL2,
 			.shift   = 0,
-			.width   = 12,
+			.width   = 10,
 		},
 		.l = {
 			.reg_off = HHI_HDMI_PLL_CNTL,
-- 
2.19.1

