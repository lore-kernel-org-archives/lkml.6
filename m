Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC68C65BB0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F65B2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="usE36wC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F65B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLBVmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:42:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34562 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:42:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so5591950wmd.1;
        Sun, 02 Dec 2018 13:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeOCN/JAo8y1dEhko9gXCXdHi5oNb9R1+5af4PRI8Xs=;
        b=usE36wC1QSBP0B1DYhEcAd8f7r/Yfc4gFCFSfvAyfIVxr51piBXILzUiROT/0mg/U0
         So3KN2s7qww3mn6LJPENNwZU/GfCCxdvj3th/WGduyZR0C6D/ruIWwprNF4LG7pZwR4m
         h+pni3yhpso/TE/ZLwqUO3XYBOZ94s2789aawcMsPwTwLUEhR7849FEN/7fyk7o4FmVP
         jpBEUHk0JliUB0THTRkYaQW6pPrS0VSvu6y0SqnQg+iCMTksCiym9e/1flfC1+A0MK+y
         ijnExY6iRy3HTNce/Nll3CJnsfiAovZUcXjMsO5/VUcmkqe+gFFgPLiK0QLbUlljEE9w
         JUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeOCN/JAo8y1dEhko9gXCXdHi5oNb9R1+5af4PRI8Xs=;
        b=BnZzxbHIv0fxX3Q7jIi/UDXH7ulgVamVjFlZ/1vpMEhqZFk+Z+KX31EtXmtMZFjgf8
         2aCmybPD/URPsmMnEssJXvvC9vGux6pI0l9ev+0ihtcaE3JZrj3PqVVwlipbhVR1LD6u
         JakgNi0jCz2LuenDq3BMOTV8hS5KrRxDpHY0Zvv81kOEL0NeGfTGxqrY2COrzdhs+QBV
         wbgUeogWyrezuoWOXafsVD7ouPWt2ZqzPOD5T04kiRrl5ZbLoGuNIzE5XMiD1K17QIfL
         IycgObFjfS7ZFY+egMKjM2lyeJfADRmuP2dx0vo6b+/AbsCUrNqQ3Cwh8Ylye0s+Kje2
         MekQ==
X-Gm-Message-State: AA+aEWa102HoQdK+WHhZT2mbx288en5vS7xJBblRT4tgWsIuwfjWPYby
        oIwDfmF/GpybsIiMAr3R9DA=
X-Google-Smtp-Source: AFSGD/VqM8kY569wrkq0zLSjphTgPsZkNf2DYfQA74MjZjlucQJNpFUZ7Jvhan1oZSUPxm1+O0dB6w==
X-Received: by 2002:a1c:eed4:: with SMTP id j81mr5956177wmi.24.1543786959555;
        Sun, 02 Dec 2018 13:42:39 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
        by smtp.googlemail.com with ESMTPSA id a18sm13073110wrp.13.2018.12.02.13.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 13:42:38 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] clk: meson: meson8b: add the fractional divider for vid_pll_dco
Date:   Sun,  2 Dec 2018 22:42:19 +0100
Message-Id: <20181202214220.7715-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
References: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "vid_pll_dco" (which should be named HDMI_PLL or - as the datasheet
calls it - HPLL) has a 12-bit wide fractional parameter at
HHI_VID_PLL_CNTL2[11:0]. Add this so we correctly calculate the rate of
this PLL when u-boot is configured for a video mode which uses this
fractional parameter.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 5 +++++
 drivers/clk/meson/meson8b.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a4ae9c957fde..0f3f4759fc92 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -137,6 +137,11 @@ static struct clk_regmap meson8b_vid_pll_dco = {
 			.shift   = 10,
 			.width   = 5,
 		},
+		.frac = {
+			.reg_off = HHI_VID_PLL_CNTL2,
+			.shift   = 0,
+			.width   = 12,
+		},
 		.l = {
 			.reg_off = HHI_VID_PLL_CNTL,
 			.shift   = 31,
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 0abb331162ab..e953923792d7 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -33,6 +33,7 @@
 #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
 #define HHI_SYS_PLL_CNTL		0x300 /* 0xc0 offset in data sheet */
 #define HHI_VID_PLL_CNTL		0x320 /* 0xc8 offset in data sheet */
+#define HHI_VID_PLL_CNTL2		0x324 /* 0xc9 offset in data sheet */
 
 /*
  * MPLL register offeset taken from the S905 datasheet. Vendor kernel source
-- 
2.19.2

