Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED5BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C58F218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfABTps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:45:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33452 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfABTps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:45:48 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gemSX-00082i-UF; Wed, 02 Jan 2019 20:45:45 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, jbx6244@gmail.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] ARM: dts: rockchip: fix cif1_pdn pin on rk3188-bqedison2qc
Date:   Wed,  2 Jan 2019 20:45:42 +0100
Message-Id: <20190102194542.15579-1-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The powerdown pin for the second camera is gpio3_b5 not b4,
so fix that. We don't have a working camera setup yet, so this
is not really critical, but nevertheless better to have fixed
already.

Fixes: 36ead9149916 ("ARM: dts: rockchip: add BQ Edison 2 QC devicetree")
Reported-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index a7477a09fbe8..2b5abfb48dd0 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -526,7 +526,7 @@
 		};
 
 		cif1_pdn: cif1-pdn {
-			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <3 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
 		cif_avdd_en: cif-avdd-en {
-- 
2.19.2

