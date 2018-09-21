Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F60CECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154C421531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154C421531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbeIUJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:54:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48966 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389061AbeIUJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:54:39 -0400
X-UUID: ed9914fecdbe40c38fe11fda44eeea3a-20180921
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 346336791; Fri, 21 Sep 2018 12:07:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 12:07:40 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 12:07:40 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4/4] pinctrl: mediatek: add eint support to MT6765 pinctrl driver
Date:   Fri, 21 Sep 2018 12:07:38 +0800
Message-ID: <82d47055aec8e40422eb72568e96bfbaf199d9d2.1537502494.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mars Cheng <mars.cheng@mediatek.com>

Just add eint support to MT6765 pinctrl driver as usual as
happens on the other SoCs.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt6765.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6765.c b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
index 1cae634..32451e8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6765.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
@@ -1056,11 +1056,19 @@ static const char * const mt6765_pinctrl_register_base_names[] = {
 	"iocfg6", "iocfg7",
 };
 
+static const struct mtk_eint_hw mt6765_eint_hw = {
+	.port_mask = 7,
+	.ports     = 6,
+	.ap_num    = 160,
+	.db_cnt    = 13,
+};
+
 static const struct mtk_pin_soc mt6765_data = {
 	.reg_cal = mt6765_reg_cals,
 	.pins = mtk_pins_mt6765,
 	.npins = ARRAY_SIZE(mtk_pins_mt6765),
 	.ngrps = ARRAY_SIZE(mtk_pins_mt6765),
+	.eint_hw = &mt6765_eint_hw,
 	.gpio_m = 0,
 	.ies_present = true,
 	.base_names = mt6765_pinctrl_register_base_names,
-- 
2.7.4

