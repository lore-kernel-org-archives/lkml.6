Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AA0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9F42184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9r7wCYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeLRX1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:27:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33870 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeLRX1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:27:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so8543503plz.1;
        Tue, 18 Dec 2018 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9zV85iRBEXyKYhhvHhomoMCUhpP+aUy4hQv59ca9b8c=;
        b=M9r7wCYEM4gZEAQpfXNMw9V5Y9/mEb7mFpQHN4xBfQGjuyV17mmPanby2QSae27W/L
         jPTQlUuguzPMdr73tBVIjzmtkU1ZB1xDDj4pi100N2cppWGX3YJyHTui8Pjruv69jL+I
         5O+9wxwgj2BoXnoGoaK+tUAWRcpfqto3zIoh8DRvJFt9CEl1TLlv54/c8S7WPUpAYHm8
         RBIDUD36jTm2p0TufP36fAR39dZ67+ZBoQamMywMMybBVsEVKzW+HwNCsCS5aoFxUK94
         mbLzBVmkR4ddSFn0SrNRwskMlAuA9F9J6rieTXxgt8x8KrxG+4s72m95k2PJYgkZ0N/q
         vrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9zV85iRBEXyKYhhvHhomoMCUhpP+aUy4hQv59ca9b8c=;
        b=Bbo+ba2KWyOgMbUhHvNU/NEpbVgLjskK86y5UBN/ryrMod2t30irSohU9wZ1KYOTpE
         E+b4g2iwSkGAcrPd20ieeNekhJCEo0qCpUZdf5gci+4Di+OcAI+glWggGRcrv3yP0dpn
         EqkK3vZEOaY8EE4XBHv2bqeWU5ri6Mx7+iyaV3qGvqgBikg7FloFo6QE4NSWXOMvtI48
         bECMvzXkY/3ujI3vsH199Ch/Zgt304GXfWqx2nU3zZl5aTtg/Apt0ORllIEknA/VBBwC
         ytZB+FplsWwX7WiOfBfWcZuvRIvg4TTa4YU+5ZCuC62m6afxhvAtu/bnyZy5TCZbOY3K
         EKcA==
X-Gm-Message-State: AA+aEWab3/tiwYJHNzivaCi0sbnR7SUs7m2555RoGBL+gO4cqxKh2Qkz
        t1M1/I2ylfYCPXrxeWQyq1ohrb0U
X-Google-Smtp-Source: AFSGD/UEook8JNKoReqhyOzf2OYxvf83hGPi2sLmSlgwLQSsZqm9JditM7VOqa/YGrlV+VXDxypCfw==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21mr18630097plo.183.1545175631407;
        Tue, 18 Dec 2018 15:27:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id x19sm28094359pfk.14.2018.12.18.15.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 15:27:10 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-esdhc-imx: Constify driver data
Date:   Tue, 18 Dec 2018 15:26:52 -0800
Message-Id: <20181218232652.12700-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variant specific driver data doesn't change at run-time, so mark it as
const to reflect that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f44e49014a44..39ace4f1036b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -148,38 +148,38 @@ struct esdhc_soc_data {
 	u32 flags;
 };
 
-static struct esdhc_soc_data esdhc_imx25_data = {
+static const struct esdhc_soc_data esdhc_imx25_data = {
 	.flags = ESDHC_FLAG_ERR004536,
 };
 
-static struct esdhc_soc_data esdhc_imx35_data = {
+static const struct esdhc_soc_data esdhc_imx35_data = {
 	.flags = ESDHC_FLAG_ERR004536,
 };
 
-static struct esdhc_soc_data esdhc_imx51_data = {
+static const struct esdhc_soc_data esdhc_imx51_data = {
 	.flags = 0,
 };
 
-static struct esdhc_soc_data esdhc_imx53_data = {
+static const struct esdhc_soc_data esdhc_imx53_data = {
 	.flags = ESDHC_FLAG_MULTIBLK_NO_INT,
 };
 
-static struct esdhc_soc_data usdhc_imx6q_data = {
+static const struct esdhc_soc_data usdhc_imx6q_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING,
 };
 
-static struct esdhc_soc_data usdhc_imx6sl_data = {
+static const struct esdhc_soc_data usdhc_imx6sl_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
 			| ESDHC_FLAG_HS200,
 };
 
-static struct esdhc_soc_data usdhc_imx6sx_data = {
+static const struct esdhc_soc_data usdhc_imx6sx_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
 };
 
-static struct esdhc_soc_data usdhc_imx7d_data = {
+static const struct esdhc_soc_data usdhc_imx7d_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400,
-- 
2.19.1

