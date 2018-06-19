Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6257720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6257720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755524AbeFSEMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:12:09 -0400
Received: from mx.socionext.com ([202.248.49.38]:10657 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbeFSEL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:11:56 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jun 2018 13:11:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5810E6006F;
        Tue, 19 Jun 2018 13:11:55 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 19 Jun 2018 13:11:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C419B40385;
        Tue, 19 Jun 2018 13:11:54 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 92E1612013B;
        Tue, 19 Jun 2018 13:11:54 +0900 (JST)
From:   Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 2/2] arm64: dts: uniphier: add headphone detect gpio for LD11 global board
Date:   Tue, 19 Jun 2018 13:11:53 +0900
Message-Id: <20180619041153.6668-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619041153.6668-1-suzuki.katsuhiro@socionext.com>
References: <20180619041153.6668-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds GPIO for headphone detection on LD11 global board.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 798882cccbd6..e5bda40b3ec6 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -60,6 +60,7 @@
 			&i2s_port4
 			&spdif_port0
 			&comp_spdif_port0>;
+		hp-det-gpio = <&gpio UNIPHIER_GPIO_PORT(15, 0) GPIO_ACTIVE_LOW>;
 	};
 
 	spdif-out {
-- 
2.17.1

