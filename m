Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A77C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180F120869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180F120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeIHPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38749 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbeIHPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:22 -0400
X-UUID: b2d28c2b56c04f9a8f33a3125d827df8-20180908
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 290265857; Sat, 08 Sep 2018 19:07:43 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:43 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH v2 20/22] pintcrl: mediatek: add pull tweaks for I2C related pins on MT8183
Date:   Sat, 8 Sep 2018 19:07:36 +0800
Message-ID: <3d957d32b5b0f67548f63ae4ba7176dba9e61faa.1536404280.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

This patch provides the advanced pull for I2C used pins on MT8183.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index bd3f00b..9d5aa27 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -397,10 +397,22 @@ static const struct mtk_pin_field_calc mt8183_pin_r0_range[] = {
 	PIN_FIELD_BASE(40, 40, 3, 0x0C0, 0x10, 20, 1),
 	PIN_FIELD_BASE(41, 41, 3, 0x0C0, 0x10, 24, 1),
 	PIN_FIELD_BASE(42, 42, 3, 0x0C0, 0x10, 28, 1),
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 18, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 13, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 10, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 5, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 7, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 5, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 15, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 17, 1),
 	PIN_FIELD_BASE(91, 91, 6, 0x0C0, 0x10, 0, 1),
 	PIN_FIELD_BASE(92, 92, 6, 0x0C0, 0x10, 4, 1),
 	PIN_FIELD_BASE(93, 93, 6, 0x0C0, 0x10, 8, 1),
 	PIN_FIELD_BASE(94, 94, 6, 0x0C0, 0x10, 12, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 20, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 10, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 22, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 12, 1),
 	PIN_FIELD_BASE(122, 122, 8, 0x0C0, 0x10, 0, 1),
 	PIN_FIELD_BASE(123, 123, 8, 0x0C0, 0x10, 4, 1),
 	PIN_FIELD_BASE(124, 124, 8, 0x0C0, 0x10, 8, 1),
@@ -430,10 +442,22 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
 	PIN_FIELD_BASE(40, 40, 3, 0x0C0, 0x10, 21, 1),
 	PIN_FIELD_BASE(41, 41, 3, 0x0C0, 0x10, 25, 1),
 	PIN_FIELD_BASE(42, 42, 3, 0x0C0, 0x10, 29, 1),
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 19, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 11, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 6, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 8, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 6, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 16, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 18, 1),
 	PIN_FIELD_BASE(91, 91, 6, 0x0C0, 0x10, 1, 1),
 	PIN_FIELD_BASE(92, 92, 6, 0x0C0, 0x10, 5, 1),
 	PIN_FIELD_BASE(93, 93, 6, 0x0C0, 0x10, 9, 1),
 	PIN_FIELD_BASE(94, 94, 6, 0x0C0, 0x10, 13, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 21, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 11, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 23, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 13, 1),
 	PIN_FIELD_BASE(122, 122, 8, 0x0C0, 0x10, 1, 1),
 	PIN_FIELD_BASE(123, 123, 8, 0x0C0, 0x10, 5, 1),
 	PIN_FIELD_BASE(124, 124, 8, 0x0C0, 0x10, 9, 1),
-- 
2.7.4

