Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE2121531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE2121531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbeIUJyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:54:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36103 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389132AbeIUJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:54:40 -0400
X-UUID: 1793ccdb406248d493b3c8de302151fd-20180921
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 293481097; Fri, 21 Sep 2018 12:07:41 +0800
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
Subject: [PATCH 2/4] pinctrl: mediatek: add no eint function for pin define
Date:   Fri, 21 Sep 2018 12:07:36 +0800
Message-ID: <554196e837f622eea62d11602b7c88721d6a776d.1537502494.git.sean.wang@mediatek.com>
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

Add NO_EINT_SUPPORT back to pinctrl-mtk-common-v2.h as the alias of
EINT_NA to indicate that some pin not capable of being controlled as eint
and that is required by pinctrl-paris based driver as old
pinctrl-mtk-common.h already had.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index b618042..991c1c5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -19,6 +19,7 @@
 #define MTK_PULLUP     1
 
 #define EINT_NA	U16_MAX
+#define NO_EINT_SUPPORT	EINT_NA
 
 #define PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs,      \
 		       _s_bit, _x_bits, _sz_reg, _fixed) {		\
-- 
2.7.4

