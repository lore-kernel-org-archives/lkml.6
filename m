Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86305C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572CC22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572CC22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeKMMEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:04:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17341 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730501AbeKMMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:04:24 -0500
X-UUID: 609499254eff47c6b7dda40278bfca0d-20181113
X-UUID: 609499254eff47c6b7dda40278bfca0d-20181113
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 411292590; Tue, 13 Nov 2018 10:08:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 13 Nov 2018 10:08:25 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Nov 2018 10:08:25 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [resend PATCH 2/3] pwm: mediatek: add pwm support for MT7629 SoC
Date:   Tue, 13 Nov 2018 10:08:23 +0800
Message-ID: <9043534495d49c532bdb0b904344b77faeb41359.1542074855.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7B6235E71CB4494122C6E7559D4D939F6DC7FC353EC1D7AD5884B1A19BE16A312000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds pwm controller support for MT7629 SoC.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 9400c41..4ed95e5 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -292,11 +292,16 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 	.pwm45_fixup = true,
 };
 
+static const struct mtk_pwm_platform_data mt7629_pwm_data = {
+	.num_pwms = 1,
+};
+
 static const struct of_device_id mtk_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
+	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
-- 
1.9.1

