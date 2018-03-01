Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2399589-1519892361-2-16446829837725930439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enroca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519892360; b=rjMMeNv0gdRo2eWWnwwkUbHZmHZTETmCZDg6qjZ4HPrANSL
    2ATdHE2t8R1jPBj8IyE6vCP+u7Xhp9oYyLj93ySbOjX1qO+8NV0pfo/mDe1wzLeF
    t2j76TzfWZIbbpRREtYbscIqaqd+YBqzXWCfxXtkxJFk131L9zBR4+Ob7ZKG0TX2
    msf6Yn+MtGRupexzKGOkvBqsCqWkJBvz4acd3lE6UkBgqg169xpTAbChI0vlOajR
    084dLD4cMK7UO/1zhd+uL+jUM7mcjCqfhTYyFJCcGIhbtvck7sDW4vO+h/egdWsP
    atKoMl8ECsWe7bm26zIOjgQiRwh4pBrTOAURpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519892360; bh=6pr8cugSgQs5x2COwdHgAc3mRiHyhkZQf6tpZuVOzdM=; b=A
    AmCmPPxp+t0ZGk5arYJlZRNYMhag4nzaam17ZrZbE0XcqplzmnyYKk8UJuWca2ov
    9hKV6+97aBwuUv/mkD92pJgsMdxFWobaHrBXo5LngFGwwUP6+gQpHBaiebVvRqrn
    /sWNNewel9rRC1/UQEAQqwhSPvsIPdQ+Hfb3rsM4le4eoOs3p0QiJzKSUsnOvJrn
    p48oFYeH//IFeNA9B3RAn7TeWRfCMVKwhGG8oQvuIelEcqqHyv3cJpMKNoKvoNrz
    iD3SD0jlMnmr/sqIA6IUUql9MHMqe0Uwi73ryHydp9DVBfbEPs14btwVnH/VN/vo
    tlExtkGGyG7AJyogLHIzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935203AbeCAITT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 03:19:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:9264 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934985AbeCAITS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 03:19:18 -0500
X-UUID: dcb8cd33af694742aed8176349e80ae9-20180301
From: <sean.wang@mediatek.com>
To: <thierry.reding@gmail.com>, <matthias.bgg@gmail.com>
CC: <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>, Zhi Mao <zhi.mao@mediatek.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on MT7623
Date: Thu, 1 Mar 2018 16:19:12 +0800
Message-ID: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
programming on PWM hardware causes waveform cannot be output as expected.
Thus, the patch adds the extra condition for fixing up the weird case to
let PWM4 or PWM5 able to work on MT7623.

v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable

Cc: stable@vger.kernel.org
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>
Cc: John Crispin <john@phrozen.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index f5d97e0..796baea 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -29,7 +29,9 @@
 #define PWMGDUR			0x0c
 #define PWMWAVENUM		0x28
 #define PWMDWIDTH		0x2c
+#define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
+#define PWM45THRES_FIXUP	0x34
 
 #define PWM_CLK_DIV_MAX		7
 
@@ -54,6 +56,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 
 struct mtk_pwm_platform_data {
 	unsigned int num_pwms;
+	bool pwm45_fixup;
 };
 
 /**
@@ -66,6 +69,7 @@ struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clks[MTK_CLK_MAX];
+	const struct mtk_pwm_platform_data *soc;
 };
 
 static const unsigned int mtk_pwm_reg_offset[] = {
@@ -131,7 +135,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
-	u32 resolution, clkdiv = 0;
+	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
+	    reg_thres = PWMTHRES;
 	int ret;
 
 	ret = mtk_pwm_clk_enable(chip, pwm);
@@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
+	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
+		/*
+		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+		 * from the other PWMs on MT7623.
+		 */
+		reg_width = PWM45DWIDTH_FIXUP;
+		reg_thres = PWM45THRES_FIXUP;
+	}
+
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
 
 	mtk_pwm_clk_disable(chip, pwm);
 
@@ -211,6 +225,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	data = of_device_get_match_data(&pdev->dev);
 	if (data == NULL)
 		return -EINVAL;
+	pc->soc = data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -251,14 +266,17 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.num_pwms = 8,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.num_pwms = 6,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.num_pwms = 5,
+	.pwm45_fixup = true,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
-- 
2.7.4
