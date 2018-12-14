Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD1EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A25A20870
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A25A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeLNCEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:04:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14396 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728130AbeLNCEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:04:37 -0500
X-UUID: 19ee1892613e45daa65a7b9c047d64a3-20181214
X-UUID: 19ee1892613e45daa65a7b9c047d64a3-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 744815289; Fri, 14 Dec 2018 10:04:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 10:04:19 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 10:04:19 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [resend PATCH v1 2/2] clk: mediatek: update clock driver of MT2712
Date:   Fri, 14 Dec 2018 10:04:17 +0800
Message-ID: <20181214020417.2871-4-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181214020417.2871-1-weiyi.lu@mediatek.com>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EF4EB2EA208F57F3D0056F890733E7F6D5DC0C35D23C0A7444B93812A9D9DE842000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to 3rd ECO design change,
1. Add new fixed factor clock of audio.
2. Add the parent clocks for audio clock mux.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2712.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 991d4093726e..e36f4aab634d 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -223,6 +223,8 @@ static const struct mtk_fixed_factor top_divs[] = {
 		4),
 	FACTOR(CLK_TOP_APLL1_D3, "apll1_d3", "apll1_ck", 1,
 		3),
+	FACTOR(CLK_TOP_APLL2_D3, "apll2_d3", "apll2_ck", 1,
+		3),
 };
 
 static const char * const axi_parents[] = {
@@ -594,7 +596,8 @@ static const char * const a1sys_hp_parents[] = {
 	"apll1_ck",
 	"apll1_d2",
 	"apll1_d4",
-	"apll1_d8"
+	"apll1_d8",
+	"apll1_d3"
 };
 
 static const char * const a2sys_hp_parents[] = {
@@ -602,7 +605,8 @@ static const char * const a2sys_hp_parents[] = {
 	"apll2_ck",
 	"apll2_d2",
 	"apll2_d4",
-	"apll2_d8"
+	"apll2_d8",
+	"apll2_d3"
 };
 
 static const char * const asm_l_parents[] = {
-- 
2.18.0

