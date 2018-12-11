Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5333FC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ED52084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EHkXMpXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ED52084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeLKMsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:48:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51339 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeLKMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:48:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so2094299wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 04:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6+XGQxF1M0YbsuzVX9nWRsvC5OlvjeQt28ui753cWI=;
        b=EHkXMpXckqku1EiWXfzvqfyINTdg8l2dBTCB4cvD9cmQ9jf/w8DzMVWluXzDk8SLMg
         WuPaqMSQA/Up9WZT01efQZKbKtWW7mY08nSGQKkJCHJUu7upE664KBV9f5WGs1SATT6z
         8nf6JrTGJGxwbCOmRnWkGd8U0brA4cm4AbU9av6TZPb+mYxUVGZXjYLVNSrsCD4VfUkS
         SUdrOrXf9gwFqgl7VAEJw2af8/bzkd+iRHNEd5sLb2OJFQ2Slkg0gOe+Udny7fY+CARk
         pZlyMOVjuiMQ4I80Ll/k4kDM0h/hZsJlg1CXeavbYFuQAsZR/CZJqDxKkcMNytvseXNl
         HHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6+XGQxF1M0YbsuzVX9nWRsvC5OlvjeQt28ui753cWI=;
        b=GyM5xzNmDsaH4m9qnJH1xdqQTj2l50gh/iLRB2Z4QkZwHdqLewJyqkyRo3DHG1w9Sr
         Yla8ha5ce5ltYqrTCXo8KUOUxD1AXg59w4/IMW/sZKzCuBMvW+Pd9iHFK/GFu+VPROW+
         ptOOcZNwTdqxMQgz5jNRKAzWord6kZUZgGvESwfUkTLcb3w6dic+yPV3BlYg+BxRAQyY
         6cBw/LB/ShQyNO/dvMX6o9QrrKej/sthtvmC8Mdwb+NUEOP9jvn41zOI8ooUKGwowo0b
         D/WdmPhHwAO1MrtihubHlirBkj799izST+UTPW/qRy1oj/GPruTv3Aarpi++2hlh6T/8
         yV0A==
X-Gm-Message-State: AA+aEWbB66HZBk7rxT3l1O9kH6tPTYfAPrZax7nJNz4d0GApnIyOa0Fx
        oOjia6GerJlqmN30KDowTyFYrw==
X-Google-Smtp-Source: AFSGD/UECDTCl14T9opPngcd3qbUVg+oqqoZ03PmcnI8tsJQfxwtQr3ghdLjY7+QdXIsGDV6zFAf4w==
X-Received: by 2002:a1c:18c:: with SMTP id 134mr2108554wmb.88.1544532478851;
        Tue, 11 Dec 2018 04:47:58 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w18sm10620406wru.54.2018.12.11.04.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 04:47:58 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] clk: meson: axg-audio: fix input clock name
Date:   Tue, 11 Dec 2018 13:47:51 +0100
Message-Id: <20181211124751.30108-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of input clock is not aligned with the rest of the tree
Because of this, the audio peripheral clocks are orphaned.

Fixes: 1222ab89328f ("clk: meson: axg-audio: use the clk input helper function")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Neil,

 Feel free to squash this with commit 1222ab89328f if you prefer

 Cheers
 Jerome

 drivers/clk/meson/axg-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 72b717e61a68..8ac3a2295473 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -752,7 +752,7 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 	}
 
 	/* Register the peripheral input clock */
-	hw = meson_clk_hw_register_input(dev, "pclk", "audio_pclk", 0);
+	hw = meson_clk_hw_register_input(dev, "pclk", "axg_audio_pclk", 0);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 
-- 
2.19.2

