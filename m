Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1709292-1519874884-2-10865962135440131177
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES da, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519874884; b=qU4djAEp4ReXBjAnbtLSFk78GhSYo754/5BNEGgnxbresaC
    jSb550Wr0E3a1fNxPV0UQULtOplrJtmhXvnITDxoukvB5Pmanmo1Va8D28XQ+4nM
    mfx9ca/Mph+jetScj+/A5vTZlNO67WsyxYamoMcp8PtbUcaHD1Mbct+oeyBPWnz4
    0QKyW5EGS747wYRnIw+9g0iSKDrGTt2x7QZC1lNbA1N8lfdqwIk2kW/lpSKeKqJv
    oPIeLFcXGMnNhti0Z6DBqdiZWaCl+pKgwfpkNr9VAs08ZIhKGdl4YYSQ32aBVcZi
    duUrMdANwmX8Zorihw53IZx4x9vzKj9Uz911S/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519874884; bh=YKCKWp3CFA32tg9YGYvz2+1kzrxbV9MDf77QOmyytJc=; b=E
    0Ic5mSGzDUI0E0LL3Pmv9nWsPVaKZeysEFoMjmmCJnU6n0ThuPr6f5m2n2mn++7O
    g05jYQRRNa8HhxPxi0IxyjgbcsWs2DVPUakwtbstjzG4ggSC11UY4ZI7r/OsN4aX
    P194PaP2QusxU6i89zndS+xcTTZQrxrkHqWtP1SSursmbq1s4T3rOGsuOFv4hHA5
    OY7j+Mf8w6xz0FoaveaeUFrcv6rlgA4ZhNdnMyxoyv6H+Iype+MrbkYUDwOTAjrZ
    8A96OHPMQ19vor2v8nu8gUFyauhcqBe4FOFqcyV8cyX7pTc/q0LY7WxQ2cZKAGZk
    dFCerzAttmyjsIgKniwkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965650AbeCAD2A (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 22:28:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43930 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965572AbeCAD16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 22:27:58 -0500
X-UUID: effa56e159eb40fd9afeddf0a5dcacb8-20180301
From: <sean.wang@mediatek.com>
To: <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <mark.rutland@arm.com>, <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: clock: mediatek: add binding for fixed-factor clock axisel_d4
Date: Thu, 1 Mar 2018 11:27:50 +0800
Message-ID: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
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

Just add binding for a fixed-factor clock axisel_d4, which would be
referenced by PWM devices on MT7623 or MT2701 SoC.

Cc: stable@vger.kernel.org
Fixes: 1de9b21633d6 ("clk: mediatek: Add dt-bindings for MT2701 clocks")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
---
 include/dt-bindings/clock/mt2701-clk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/mt2701-clk.h b/include/dt-bindings/clock/mt2701-clk.h
index 551f760..24e93df 100644
--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -176,7 +176,8 @@
 #define CLK_TOP_AUD_EXT1			156
 #define CLK_TOP_AUD_EXT2			157
 #define CLK_TOP_NFI1X_PAD			158
-#define CLK_TOP_NR				159
+#define CLK_TOP_AXISEL_D4			159
+#define CLK_TOP_NR				160
 
 /* APMIXEDSYS */
 
-- 
2.7.4
