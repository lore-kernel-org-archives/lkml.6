Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1794019-1519874895-2-8638164221950236558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519874894; b=vxj9U12ARPlG0zzlxDQFpKxWYHMKGODVMFZ6YztBXJn7zWk
    KBuOT5newIWe5oqvBkpOb7LMbFGR2cA7PAl3/4WIBkjMkGvHYRjqFAVz6P77pXQa
    IU7LOcFHZJxtPjFQev9U1kP4iyEF9COuoBI7vUL633BsKp2WtQpHrp1gWSHWDJ/E
    t65NYnOhUlrNOE5mjQVjp8Vr4536m16e02K5yK1GHc70iMBUoQFiSAd7/kRbVnbf
    rOKx6xDbF0ptKIHJO1SyPjxVOUyiGPPXesH38ndCu8UZrewStuqcMwwfohRX9us9
    D8Znt81svfa06rbTJrakWwGdZZ980TwMH/6o87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519874894; bh=bpbWqZgEW6/lRrd7nRK6A4x0w5
    TYDkra4X+3VeZcD0U=; b=FnYk/MkcwDDpvaj1sjQlMhzwFdM27YTfjCYy2mrBxS
    /AcblG4/zkWq0+TPnZqdpmz6KGPM24uXVFlec2q/zzETHE7gy20MxoCPUJXlIixm
    YvD5B4Al+kGAC/sYtwDsvC3q0puMVvnwQs3b3uK2QoqIES9zwkJZHU7vjcUASMCB
    9QzAwBkAJB3Z9N3b7bg6IGpjzmzdzeRqUWv1J68+cdl3JzY96ZA16+xAOFpB0AAd
    +jJld3oyNzMKNbxvu7LrhkiBX90UslZak7ZEAx9E2mTjqyyTKJE91lQkaALxa9A/
    G3movP1qZXxpkfVvv0WQhS3RL4m+vC9KKLeElr8DiXEA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965572AbeCAD2M (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 22:28:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41244 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965644AbeCAD2A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 22:28:00 -0500
X-UUID: 4c70ceb87bcd48bfa738cb7738f0245d-20180301
From: <sean.wang@mediatek.com>
To: <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <mark.rutland@arm.com>, <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 2/2] clk: mediatek: fix PWM clock source by adding a fixed-factor clock
Date: Thu, 1 Mar 2018 11:27:51 +0800
Message-ID: <b6eafb38f8d697bd8d00c8d86a0b22be809f8062.1519874655.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
References: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

The clock for which all PWM devices on MT7623 or MT2701 actually depending
on has to be divided by four from its parent clock axi_sel in the clock
path prior to PWM devices.

Consequently, adding a fixed-factor clock axisel_d4 as one-fourth of
clock axi_sel allows that PWM devices can have the correct resolution
calculation.

Cc: stable@vger.kernel.org
Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 8e7f16f..deca752 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -148,6 +148,7 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	FACTOR(CLK_TOP_CLK26M_D8, "clk26m_d8", "clk26m", 1, 8),
 	FACTOR(CLK_TOP_32K_INTERNAL, "32k_internal", "clk26m", 1, 793),
 	FACTOR(CLK_TOP_32K_EXTERNAL, "32k_external", "rtc32k", 1, 1),
+	FACTOR(CLK_TOP_AXISEL_D4, "axisel_d4", "axi_sel", 1, 4),
 };
 
 static const char * const axi_parents[] = {
@@ -857,13 +858,13 @@ static const struct mtk_gate peri_clks[] = {
 	GATE_PERI0(CLK_PERI_USB1, "usb1_ck", "usb20_sel", 11),
 	GATE_PERI0(CLK_PERI_USB0, "usb0_ck", "usb20_sel", 10),
 	GATE_PERI0(CLK_PERI_PWM, "pwm_ck", "axi_sel", 9),
-	GATE_PERI0(CLK_PERI_PWM7, "pwm7_ck", "axi_sel", 8),
-	GATE_PERI0(CLK_PERI_PWM6, "pwm6_ck", "axi_sel", 7),
-	GATE_PERI0(CLK_PERI_PWM5, "pwm5_ck", "axi_sel", 6),
-	GATE_PERI0(CLK_PERI_PWM4, "pwm4_ck", "axi_sel", 5),
-	GATE_PERI0(CLK_PERI_PWM3, "pwm3_ck", "axi_sel", 4),
-	GATE_PERI0(CLK_PERI_PWM2, "pwm2_ck", "axi_sel", 3),
-	GATE_PERI0(CLK_PERI_PWM1, "pwm1_ck", "axi_sel", 2),
+	GATE_PERI0(CLK_PERI_PWM7, "pwm7_ck", "axisel_d4", 8),
+	GATE_PERI0(CLK_PERI_PWM6, "pwm6_ck", "axisel_d4", 7),
+	GATE_PERI0(CLK_PERI_PWM5, "pwm5_ck", "axisel_d4", 6),
+	GATE_PERI0(CLK_PERI_PWM4, "pwm4_ck", "axisel_d4", 5),
+	GATE_PERI0(CLK_PERI_PWM3, "pwm3_ck", "axisel_d4", 4),
+	GATE_PERI0(CLK_PERI_PWM2, "pwm2_ck", "axisel_d4", 3),
+	GATE_PERI0(CLK_PERI_PWM1, "pwm1_ck", "axisel_d4", 2),
 	GATE_PERI0(CLK_PERI_THERM, "therm_ck", "axi_sel", 1),
 	GATE_PERI0(CLK_PERI_NFI, "nfi_ck", "nfi2x_sel", 0),
 
-- 
2.7.4
