Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81592C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8612082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1rCiwPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8612082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH3XZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:25:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37493 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeH3XZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:25:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so8194133ljk.4;
        Thu, 30 Aug 2018 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vTHRVdYBlOTPQeHGmgVrxO2BP86zr2jepwF1VICqGpc=;
        b=g1rCiwPPYarwABy3JoPRPn4jNdrcpvMM6uITbqwfN+BrPrF7tHfQEaPQH/oJGYPlJE
         6DykYN+ZXWZDZ3dXtm1ZHKIJ0FRn0OjVk7VqPy6tSp9AHRukW0dlita4Xm3zxgwvfp0A
         LkyhhiBItsaAwthNjZsA+WI6q8iUK7mDWVaBT5dVvLu+Rc1tMfQKNKc5t/9ZhhUdFA2N
         BDEGdyVV+V5jYbNbM6b2VQSriuTdchrpdWqQtCOW4YVMKu4aoMieLU0OB6lEMfznCqAN
         rlFHCZT3NJUR+jHywXNfqkK0Bx8+LxtBZZzRDslE0MAQ9vrwPu0SIpHUfg21htbnVpnE
         5l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vTHRVdYBlOTPQeHGmgVrxO2BP86zr2jepwF1VICqGpc=;
        b=ZsjwARnJi573R93gYTuyFOdrPVQbg5Aejcd31Pw0Nx2roKL8uXcYzb1DVYCHb2t4us
         TpK1VVkUObFRrZKus1HxgZjMWd24b5yFTfEallx3mr7rhS+9xcSjG4vzQGSSXEmu0VRt
         +PyJMdMArXcGBBntBUep2uQblvs2mMnqvQ2qRb2bgxVdMoy7LNckudj5BSuRgnUSjTMC
         tMW85bAinMuu2hc0JxhJmSzkWDUedjCuhjzfD6KoMsOAj4pJZ2eH3RTFq1y1m3RcgtPD
         zkPtEn8aPVsP6ngqLP1h62fgH+R34ZN7zcVSd4j5RowS/TKBYkeOrACEAZJiTTAFTO8M
         HMCg==
X-Gm-Message-State: APzg51ABouTrsHq7yJQR6XcrjpjwS+Jc6fRvcF4Q+91Em15NqmeXS5eu
        2HPhW35t+ljq/uKx1LTTgMo=
X-Google-Smtp-Source: ANB0VdZNNOq5HJ1i2qtVwySKsAtFrO74UNwok56udSshsZfe9bI4zF/Ge/DpFpAoZkFS9/Rwgt73GA==
X-Received: by 2002:a2e:1609:: with SMTP id w9-v6mr8101967ljd.120.1535656911303;
        Thu, 30 Aug 2018 12:21:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1403291lfl.1.2018.08.30.12.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:21:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] clk: tegra: Add more rates to Tegra30 PLLX frequency table
Date:   Thu, 30 Aug 2018 22:20:44 +0300
Message-Id: <20180830192045.11017-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830192045.11017-1-digetx@gmail.com>
References: <20180830192045.11017-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more predefined rates to the PLLX table, allowing to lower the rate
down to 312MHz. This gives more variations of frequency selection to the
CPUFREQ driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index c4b78316ba8a..0f8797ca39e2 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -342,6 +342,48 @@ static struct tegra_clk_pll_freq_table pll_x_freq_table[] = {
 	{ 16800000, 1000000000,  833, 14, 1, 8 }, /* actual: 999.6 MHz */
 	{ 19200000, 1000000000,  625, 12, 1, 8 },
 	{ 26000000, 1000000000, 1000, 26, 1, 8 },
+	/* 912 MHz */
+	{ 12000000,  912000000,  912, 12, 1, 8 },
+	{ 13000000,  912000000,  912, 13, 1, 8 },
+	{ 16800000,  912000000,  760, 14, 1, 8 },
+	{ 19200000,  912000000,  760, 16, 1, 8 },
+	{ 26000000,  912000000,  912, 26, 1, 8 },
+	/* 816 MHz */
+	{ 12000000,  816000000,  816, 12, 1, 8 },
+	{ 13000000,  816000000,  816, 13, 1, 8 },
+	{ 16800000,  816000000,  680, 14, 1, 8 },
+	{ 19200000,  816000000,  680, 16, 1, 8 },
+	{ 26000000,  816000000,  816, 26, 1, 8 },
+	/* 760 MHz */
+	{ 12000000,  760000000,  760, 12, 1, 8 },
+	{ 13000000,  760000000,  760, 13, 1, 8 },
+	{ 16800000,  760000000,  950, 21, 1, 8 },
+	{ 19200000,  760000000,  950, 24, 1, 8 },
+	{ 26000000,  760000000,  760, 26, 1, 8 },
+	/* 750 MHz */
+	{ 12000000,  750000000,  750, 12, 1, 8 },
+	{ 13000000,  750000000,  750, 13, 1, 8 },
+	{ 16800000,  750000000,  625, 14, 1, 8 },
+	{ 19200000,  750000000,  625, 16, 1, 8 },
+	{ 26000000,  750000000,  750, 26, 1, 8 },
+	/* 608 MHz */
+	{ 12000000,  608000000,  608, 12, 1, 8 },
+	{ 13000000,  608000000,  608, 13, 1, 8 },
+	{ 16800000,  608000000,  760, 21, 1, 8 },
+	{ 19200000,  608000000,  380, 12, 1, 8 },
+	{ 26000000,  608000000,  608, 26, 1, 8 },
+	/* 456 MHz */
+	{ 12000000,  456000000,  456, 12, 1, 8 },
+	{ 13000000,  456000000,  456, 13, 1, 8 },
+	{ 16800000,  456000000,  380, 15, 1, 8 },
+	{ 19200000,  456000000,  380, 14, 1, 8 },
+	{ 26000000,  456000000,  456, 26, 1, 8 },
+	/* 312 MHz */
+	{ 12000000,  312000000,  312, 12, 1, 8 },
+	{ 13000000,  312000000,  312, 13, 1, 8 },
+	{ 16800000,  312000000,  260, 14, 1, 8 },
+	{ 19200000,  312000000,  260, 16, 1, 8 },
+	{ 26000000,  312000000,  312, 26, 1, 8 },
 	{        0,          0,    0,  0, 0, 0 },
 };
 
-- 
2.18.0

