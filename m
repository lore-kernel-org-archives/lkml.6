Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0ECC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09BC25CB8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mVo809IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09BC25CB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeFYP35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:29:57 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38862 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeFYP3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:52 -0400
Received: by mail-wr0-f179.google.com with SMTP id e18-v6so14132223wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nSXHzvqybEtdzHkD2l9M3rTvO3mzizZqvz9MLG8cxdI=;
        b=mVo809IEsWDN1tWWxhyMZx5gKTQx0NsQ7jvkJ1G5srpSbntIWP5b+ynW9Lfa87FLXH
         q+IDHYi2YaDe+X/AjV/iwfZqRmv7rFQm4p/rVIUoWrjyJchfa7ia/tXf65iMjw8zgh7z
         tVvYe03aBpSI6X/sbKVB8Woqi+CW+PNZprF6LW/YEr8jT2Jklfk6BrLGt2ZydlLIdjXW
         qiKlnRBHVwLqiSvjdWskbym5uzr6GhFsCY+G2EP0m6buwmv7gPMTUV9uaa1cKDls7Err
         TQ19xP77DOJlp9O93NFlCgHMZOBhHNslAHnr2rzM58O7iObWlbS3XuLRk3uI0Czech8R
         0OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nSXHzvqybEtdzHkD2l9M3rTvO3mzizZqvz9MLG8cxdI=;
        b=uLJb7/UkhM6NU9iDr2YsOchIikOSBwofAui9Y0OxtvfdIU5zLwWwWATnauFDYMoq/S
         EgsmM2dHir9IECHhuNxw+1RxxWMSf3zc1oYxDQZUl93PNefmJFyZk7YzhgX9jV5t51+6
         lWvYYO01a5oZ8j6u1Bt6svCak2XqJHk0wLe0M+/dJw6suKbkkgFn/oKmK2OWiBGBEYw4
         w36+EmjZBU50dHE/9kYk4L7/k2toJqfc1fXeaRj3I7EN2TJYpoHNROYI2CvWg541mN1C
         02+FXz65rSzzjf3AtibJtFV9HP589rkISxUYmmHs0m/bSxCOswX8q9zz4YyxUQTMVSZZ
         gGiw==
X-Gm-Message-State: APt69E08h7+qDSQfQH8KAk/Epp8KrtY9VvyX75KqU/TtxGTbmma72OHL
        Tj+mQRcC3wGj8TwEYiKMXjjM7Q==
X-Google-Smtp-Source: AAOMgpcY3myXzIYQHnqlT/Gt0wG/jbQ/H3Opkc2/pSBY5fPrAPoWn7cWZXjnQi7p8KZOkn4ZnLOzcA==
X-Received: by 2002:adf:ef85:: with SMTP id d5-v6mr1354226wro.195.1529940591054;
        Mon, 25 Jun 2018 08:29:51 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/9] clk: davinci: psc-dm365: use two lookup entries for the aemif clock
Date:   Mon, 25 Jun 2018 17:29:12 +0200
Message-Id: <20180625152920.11549-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625152920.11549-1-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to be able to get the clock both from the board file by its
con_id and from the aemif driver by dev_id.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-dm365.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
index 8c73086cc676..c75424f4ea3b 100644
--- a/drivers/clk/davinci/psc-dm365.c
+++ b/drivers/clk/davinci/psc-dm365.c
@@ -21,7 +21,8 @@ LPSC_CLKDEV1(mmcsd1_clkdev,		NULL,		"da830-mmc.1");
 LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
 LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
 LPSC_CLKDEV1(spi2_clkdev,		NULL,		"spi_davinci.2");
-LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
+					NULL,		"ti-aemif");
 LPSC_CLKDEV1(mmcsd0_clkdev,		NULL,		"da830-mmc.0");
 LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
 LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
-- 
2.17.1

