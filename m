Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEADECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D61420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Sqt+Mxp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D61420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeGRLcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:32:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36235 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbeGRLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:32:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id d14-v6so2030993pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sV/39YA3QCHIRLw1HmNxYPmPzaLGwJIzgHc45M+ChjM=;
        b=Sqt+Mxp22RgBnh254p/dWFYG/HtciS/YiPLU1LAGGKzaS8O0Kw50elyAsdhoewkfP9
         XD8qWpbowBrtFP0eXmzb4NrmcGgL2cDv43kEW/aDk2Ds3ij2vT/FXS4hcGvKmCrPDFv5
         Qm6Z6Nygih50ZDJCQa7LrOuEfJiEa3Y8rNHqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sV/39YA3QCHIRLw1HmNxYPmPzaLGwJIzgHc45M+ChjM=;
        b=OlnrrlaMIrGRwMIdCbsrv07nNAXXX/VUneZhMSZsnaDA9TM+Ub/0QOmitO7wH9mWd2
         nb5AYaVDJz0qrz0HaZZRsUXGPQilpuGiOBubcXCvRxuQHkhdg/238MHZc9BAiTAYhKXm
         6zhtrsmkv87DrJ9Y9JjTGA5W3fyyFisCMoOyAoSSIlMGJcp5807pVw9f06yEh5tfWYLg
         S3rqzr2owPc3AykNwsbrMwWzLHnweXhXgNhOvfpYGgATPDarEvLzYpP6hF/qjs1I+S50
         dJ79fHF+qEH2VvfY9cKJywtH0z8zWCXUC1usJyUD4/KhcmJEVJNxhYI+TswhCfBhtAvL
         32iA==
X-Gm-Message-State: AOUpUlHjzBAgnjx9TCV68h6oDf6rNB93x77Yv0GtyRVLuVmOp/fjCsBI
        PrXIO78JpAKOymgpdrWmFIsxyg==
X-Google-Smtp-Source: AAOMgpeCGaoXVchdb79cJ5FxWwsI2cEkREfM70d/Re7hCKNJQPHBdtU3KzOj32Uzr0xL28GIifjwcQ==
X-Received: by 2002:a62:23d1:: with SMTP id q78-v6mr4636611pfj.179.1531911328527;
        Wed, 18 Jul 2018 03:55:28 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:55:28 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 02/18] drm/sun4i: Add support for A64 mixer1
Date:   Wed, 18 Jul 2018 16:24:42 +0530
Message-Id: <20180718105458.22304-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixers in Allwinner have similar capabilities as others SoCs with DE2.

Mixer1 has 1 VI and 1 UI planes and supports HW scaling on all
planes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none 
Changes for v2:
- New patch

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f76a5576c0e6..756280194f94 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -578,6 +578,14 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.mod_rate = 150000000,
 };
 
+static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
+	.ccsc		= 1,
+	.mod_rate	= 297000000,
+	.scaler_mask	= 0x3,
+	.ui_num		= 1,
+	.vi_num		= 1,
+};
+
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-a83t-de2-mixer-0",
@@ -603,6 +611,10 @@ static const struct of_device_id sun8i_mixer_of_table[] = {
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-de2-mixer-1",
+		.data = &sun50i_a64_mixer1_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_mixer_of_table);
-- 
2.17.1

