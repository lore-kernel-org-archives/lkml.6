Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2316C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A9120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V69wUMG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A9120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeLFPSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:18:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54015 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLFPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:18:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so1342180wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9D+IWNIkzvM4lr5AWVEe/1dPuYwCLo7SNBs7kvA6F/o=;
        b=V69wUMG28wtoJtdJvClt8+e4MNUFCgT9w5PW65OzLv56uK4D54BydOiREZ0QqqI6Yj
         nk587zOLB50DozkpeJgAVwuTXyfanIIiYzRWAk0+RmO0G77yvCTt1HQe0oF4D4U4gIX/
         K+tH+Ei85fXP/cer2qzJ+E+nrrcsr/el3V1DRlWJ76S8dnjfpxCG1leb++zeQUGNt0sg
         6XjfvIOLWDRXhd5mRCAZ1phYICvS+rKtgvMdf5InGSXVlZ4+w+CAg0FQjtIbn43RSCj6
         QUOHKIBu5tWVUobolT9ZHj29k1SSP8jzn7rFngmbZFLolMiGJnzHhBVriKGiMENPrSFY
         Jnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9D+IWNIkzvM4lr5AWVEe/1dPuYwCLo7SNBs7kvA6F/o=;
        b=VSQEdXb1Bc25AO0IA3k4kdVeaXZyd1Ynt9+AWtNlylDnqUpw+Hx39HtrKrW6e1LpQW
         ZRLEs0Ziy/2t3kPOGvGg7f04BqiYwK7iqJKpRxdc6gstkTQ91+KZoZXLBYuoeFMZtX/P
         s3xaNp7PtcNSqMOiKAH772FgZ9uJYhIce+VYRQnNE6z2J5eiTqUo+4BD9hSgIvNm1s3j
         HIdUqTUfWvTd2SLm2yJe9KMm2lRnA22AqPbKd3dImQdN+IrclsCwvtO5iR38/+H6icBS
         9ihcIaq5ep8rHW0oF9hIF6WNYMhNfev1VWrxzm2tCjIQCNtA06ioS38MC3n6jx2QRs9T
         dWJA==
X-Gm-Message-State: AA+aEWY5mvLp78se5Fn0dQY0FjpD9k7U0YrzIw5N6Hj+kY9V8zEaI2Wz
        scdeT8vTofT1YghsdNPUHNxCXmXmQysHPA==
X-Google-Smtp-Source: AFSGD/WZLKmAh/mxiuXK9Ct6fORvClnB6EooPxfPYwnm5i979312KWaCMeM6NJhlv80pX5rsGOOQTw==
X-Received: by 2002:a1c:9d97:: with SMTP id g145mr20578555wme.152.1544109520556;
        Thu, 06 Dec 2018 07:18:40 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j33sm939652wre.91.2018.12.06.07.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:18:40 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 3/4] mmc: meson-gx: align default phase on soc vendor tree
Date:   Thu,  6 Dec 2018 16:18:27 +0100
Message-Id: <20181206151828.24417-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the default Core and Tx phase with the SoC vendor tree.
Even if the Tx phase is different from what the documentation
recommends, it seems to provide better results.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5cc31e434ca1..837bed0b8c01 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -634,14 +634,8 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	if (ret)
 		return ret;
 
-	/*
-	 * Set phases : These values are mostly the datasheet recommended ones
-	 * except for the Tx phase. Datasheet recommends 180 but some cards
-	 * fail at initialisation with it. 270 works just fine, it fixes these
-	 * initialisation issues and enable eMMC DDR52 mode.
-	 */
 	clk_set_phase(host->mmc_clk, 180);
-	clk_set_phase(host->tx_clk, 270);
+	clk_set_phase(host->tx_clk, 0);
 	clk_set_phase(host->rx_clk, 0);
 
 	return clk_prepare_enable(host->mmc_clk);
-- 
2.19.2

