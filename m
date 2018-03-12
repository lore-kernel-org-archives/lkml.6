Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3579367-1520832381-2-12717620861761512865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520832381; b=g9hApWYsJENCACpnl1sbbnJAyYLDkN7ftLqnY3oDr9+ELRM
    c28az9C1nemXkde2qGJYrAvz8cmif5FOGMv9kY3hTXTOq8owM9KjJJoSdLYlkr54
    xe5U7jsyGQoj9ruAkRJwc2TE65TotnC0IjWDSc7M0bdB3ZbAAZm+YaxJLg0VlRjz
    092VLTcv5NJEftkIPUICbur0l1UDZhSNsjYzumJ1EA7/h2ny/2RmEtBujzlcV+IP
    wS8gIImgAdPUSijMcQMGPOFt9ojnOsrKGkFemYQ3sdAw4W0LK6m/HMKv1wOSWNEK
    8Nbai0Yx1IGdLnIdYpbpE9qlPRncvsvq85ncB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520832381; bh=ilwpkXeDgJLvjeZequq8rMO25k
    y+E3rlCq+5PRhuViE=; b=wVNCPKBo28qNL8O/S44aFaysZI+0UmAkZM6B8oOxKz
    uYdebm1vA2WI5HBpdGT0lQ1fPb/o5uq3pGvwOqG4v9X2pjwVTkkSf/7xPLCvg8sv
    6K2Lz+PU6qfUl2f8AKU/5z5TMYKvXuaD5fmzKpSRDu4WC6eoExyOlB12d7XfeEuL
    rCYks9So4JxhHvU+WAKxUqmrOLvjCWTtif2P3mAhpjTIIfHyi6mfJQXU1kmt2oyj
    4WGRbVXJCOQx79yICeFmlNCfMjpiM1JU48jq0talpeyvp4LguPwxPk9V1PJpoVnc
    d/tyaOW25JjSLQLXoFzKng+Pk6+Z+AI+mdwXOGy0U/0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeCLFZu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 01:25:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36082 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750790AbeCLFZs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 01:25:48 -0400
X-UUID: f7f78dbdda1843dc8975c4f642e9ee56-20180312
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/3] phy: phy-mtk-tphy: add configurable parameters for slew rate calibrate
Date: Mon, 12 Mar 2018 13:25:39 +0800
Message-ID: <123d1a24659be168d0b040de4a67612acacf66f1.1520832210.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23714.005
X-TM-AS-Result: No-5.648400-8.000000-10
X-TMASE-MatchedRID: RZGtuGBMNjXT8bI3kykaU/SG/+sPtZVkAWQaZTMSP85d15Kx2hUn1PlY
        oV6p/cSxhVmF9kz2wxKE+/1bNiTZfG5/NyTKlG69yeVujmXuYYVXLUapz6y7gZsoi2XrUn/Jn6K
        dMrRsL14qtq5d3cxkNdP6HoL1bB0v3bsfrFOkvbJNhN8QxBlnsWz9AG6WDepGlr1oe/64dxKXmU
        /FzSSM1Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.648400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23714.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are two parameters, ref_clk and coefficient, for U2 slew rate
calibrate which may vary on different SoCs, here allow them to be
configurable

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 6073c25..38c281b 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -306,6 +306,8 @@ struct mtk_tphy {
 	const struct mtk_phy_pdata *pdata;
 	struct mtk_phy_instance **phys;
 	int nphys;
+	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
+	int src_coef; /* coefficient for slew rate calibrate */
 };
 
 static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
@@ -360,16 +362,17 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 	writel(tmp, fmreg + U3P_U2FREQ_FMMONR1);
 
 	if (fm_out) {
-		/* ( 1024 / FM_OUT ) x reference clock frequency x 0.028 */
-		tmp = U3P_FM_DET_CYCLE_CNT * U3P_REF_CLK * U3P_SLEW_RATE_COEF;
-		tmp /= fm_out;
+		/* ( 1024 / FM_OUT ) x reference clock frequency x coef */
+		tmp = tphy->src_ref_clk * tphy->src_coef;
+		tmp = (tmp * U3P_FM_DET_CYCLE_CNT) / fm_out;
 		calibration_val = DIV_ROUND_CLOSEST(tmp, U3P_SR_COEF_DIVISOR);
 	} else {
 		/* if FM detection fail, set default value */
 		calibration_val = 4;
 	}
-	dev_dbg(tphy->dev, "phy:%d, fm_out:%d, calib:%d\n",
-		instance->index, fm_out, calibration_val);
+	dev_dbg(tphy->dev, "phy:%d, fm_out:%d, calib:%d (clk:%d, coef:%d)\n",
+		instance->index, fm_out, calibration_val,
+		tphy->src_ref_clk, tphy->src_coef);
 
 	/* set HS slew rate */
 	tmp = readl(com + U3P_USBPHYACR5);
@@ -1041,6 +1044,13 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 		tphy->u3phya_ref = NULL;
 	}
 
+	tphy->src_ref_clk = U3P_REF_CLK;
+	tphy->src_coef = U3P_SLEW_RATE_COEF;
+	/* update parameters of slew rate calibrate if exist */
+	device_property_read_u32(dev, "mediatek,src-ref-clk-mhz",
+		&tphy->src_ref_clk);
+	device_property_read_u32(dev, "mediatek,src-coef", &tphy->src_coef);
+
 	port = 0;
 	for_each_child_of_node(np, child_np) {
 		struct mtk_phy_instance *instance;
-- 
1.9.1

