Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB77ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1D520671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1D520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeGSHBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:01:15 -0400
Received: from mx.socionext.com ([202.248.49.38]:35894 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbeGSHBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:01:14 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Jul 2018 15:19:46 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 65EDD180D69;
        Thu, 19 Jul 2018 15:19:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Jul 2018 15:19:46 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id B8D491A11BB;
        Thu, 19 Jul 2018 15:19:45 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     p.zabel@pengutronix.de, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] reset: uniphier: add reset control support for SPI
Date:   Thu, 19 Jul 2018 15:18:53 +0900
Message-Id: <1531981133-25881-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Add reset control for SPI controller on UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-uniphier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index e9030ff..5605745 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -202,6 +202,12 @@ static const struct uniphier_reset_data uniphier_pro5_sd_reset_data[] = {
 #define UNIPHIER_PERI_RESET_FI2C(id, ch)		\
 	UNIPHIER_RESETX((id), 0x114, 24 + (ch))
 
+#define UNIPHIER_PERI_RESET_SCSSI(id)			\
+	UNIPHIER_RESETX((id), 0x110, 17)
+
+#define UNIPHIER_PERI_RESET_MCSSI(id)			\
+	UNIPHIER_RESETX((id), 0x114, 14)
+
 static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
 	UNIPHIER_PERI_RESET_UART(0, 0),
 	UNIPHIER_PERI_RESET_UART(1, 1),
@@ -212,6 +218,7 @@ static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
 	UNIPHIER_PERI_RESET_I2C(6, 2),
 	UNIPHIER_PERI_RESET_I2C(7, 3),
 	UNIPHIER_PERI_RESET_I2C(8, 4),
+	UNIPHIER_PERI_RESET_SCSSI(11),
 	UNIPHIER_RESET_END,
 };
 
@@ -227,6 +234,8 @@ static const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
 	UNIPHIER_PERI_RESET_FI2C(8, 4),
 	UNIPHIER_PERI_RESET_FI2C(9, 5),
 	UNIPHIER_PERI_RESET_FI2C(10, 6),
+	UNIPHIER_PERI_RESET_SCSSI(11),
+	UNIPHIER_PERI_RESET_MCSSI(12),
 	UNIPHIER_RESET_END,
 };
 
-- 
2.7.4

