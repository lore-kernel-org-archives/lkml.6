Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF515C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6301D20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dev13Dkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6301D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeH3WqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:46:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35397 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeH3WqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:46:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id q13-v6so8021523lfc.2;
        Thu, 30 Aug 2018 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JE/W4XMIIuliXbbWxa88UW3vRFU5lzW3geZKbpUNeKE=;
        b=Dev13Dkj+3ioU45hrkFEAzm6/maKKqSrpZGcRGBL9H5jePQwZ6hn7Xg/13ClvDfTtW
         jGKaslSaqtWvBVRXQOSYDSN/ClSlbeOmGHLU5VdAXDEjCeTXymPVTBC6IMJNFxMg4rGv
         HrMST7diesJFJTuyvqElLk9jsPazqFudlTGNm5C+gyoBN7RCr2785RSNDXsJqaIZOTW3
         fXHe2why6S4z2z60yutF0ciqIcbPDVuyS3yGVSJtS8Pp3GU8k4NHjsIJRi9BvWRfjDrT
         2gwGaBTmbTZBYA3SIag1G/l4ZVoATO3qPrr0D7h/rawukyQFakREZ8OXLuBT1VdvkPhW
         UQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JE/W4XMIIuliXbbWxa88UW3vRFU5lzW3geZKbpUNeKE=;
        b=TMPvKIAGWRi99kd3QfyhVWzslWjWydiGvwn2aCL+qwjnMJWwzS9oZeE+pG8oHeTE/p
         XlqdO6STwNaLaZwGBxJX5Jy0C5yy5hEDlZWrYvI3cn1gP4E73rs2CblwZ5G13lp/KmhO
         nl8VJtyiyuLnYfJwqsFpU262ZYcR5wt7/bch/97IceOg2DDvXXJxorxn0Jnwh0LT81OG
         IN4p8naSEXdUUkyFsJukKOhO+AcWV6egKprKTbkTRYEbAwkrlW3L8uXP9OmxsY6hfXxC
         hNN8QU1jam+ixm27FyKkFDssy7DuSjdiy+MzrI9eBN/ZTCVDrMq7priSrrmGFiT7IFRL
         vGZw==
X-Gm-Message-State: APzg51A5xnI0gnAWdye03AJgHCN9fFLdv2atJu7oVTaBbI54llllwQZB
        shR35aGhRnZ/XHqvV2ez4Is=
X-Google-Smtp-Source: ANB0VdbDVcZwgVMVxV73aE+YsJdxGGTVFDwfZRu0AyYVFAz10/bDqUp+FqwOHkz+ZR/Ac+lP4RIDSA==
X-Received: by 2002:a19:2c8e:: with SMTP id s136-v6mr2320130lfs.78.1535654569965;
        Thu, 30 Aug 2018 11:42:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id m31-v6sm1446169lfi.17.2018.08.30.11.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:42:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
Date:   Thu, 30 Aug 2018 21:42:10 +0300
Message-Id: <20180830184210.5369-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830184210.5369-1-digetx@gmail.com>
References: <20180830184210.5369-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all PLL's on Tegra20 use a hardcoded delay despite of having
a lock-status bit. The lock-status polling was disabled ~7 years ago
because PLLE was failing to lock and was a suspicion that other PLLs
might be faulty too. Other PLLs are okay, hence enable the lock-status
polling for them. This reduces delay of any operation that require PLL
to lock.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2:	Don't enable polling for PLLE as it known to not being able to lock.

 drivers/clk/tegra/clk-tegra20.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cc857d4d4a86..cfde3745a0db 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -298,7 +298,8 @@ static struct tegra_clk_pll_params pll_c_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_c_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_m_params = {
@@ -314,7 +315,8 @@ static struct tegra_clk_pll_params pll_m_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_m_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_p_params = {
@@ -331,7 +333,7 @@ static struct tegra_clk_pll_params pll_p_params = {
 	.lock_delay = 300,
 	.freq_table = pll_p_freq_table,
 	.flags = TEGRA_PLL_FIXED | TEGRA_PLL_HAS_CPCON |
-		 TEGRA_PLL_HAS_LOCK_ENABLE,
+		 TEGRA_PLL_HAS_LOCK_ENABLE | TEGRA_PLL_USE_LOCK,
 	.fixed_rate =  216000000,
 };
 
@@ -348,7 +350,8 @@ static struct tegra_clk_pll_params pll_a_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_a_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_d_params = {
@@ -364,7 +367,8 @@ static struct tegra_clk_pll_params pll_d_params = {
 	.lock_enable_bit_idx = PLLDU_MISC_LOCK_ENABLE,
 	.lock_delay = 1000,
 	.freq_table = pll_d_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static const struct pdiv_map pllu_p[] = {
@@ -387,7 +391,8 @@ static struct tegra_clk_pll_params pll_u_params = {
 	.lock_delay = 1000,
 	.pdiv_tohw = pllu_p,
 	.freq_table = pll_u_freq_table,
-	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLLU | TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_x_params = {
@@ -403,7 +408,8 @@ static struct tegra_clk_pll_params pll_x_params = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.freq_table = pll_x_freq_table,
-	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE |
+		 TEGRA_PLL_USE_LOCK,
 };
 
 static struct tegra_clk_pll_params pll_e_params = {
-- 
2.18.0

