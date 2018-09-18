Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E331ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B4420880
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B4420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeISC3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:29:43 -0400
Received: from shell.v3.sk ([90.176.6.54]:55201 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbeISC3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:29:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CFA8FB9486;
        Tue, 18 Sep 2018 22:55:18 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ycmeRM13sAFi; Tue, 18 Sep 2018 22:55:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 573A1B9485;
        Tue, 18 Sep 2018 22:55:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qw1UVS-M0d-9; Tue, 18 Sep 2018 22:55:05 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D78F7B9483;
        Tue, 18 Sep 2018 22:55:04 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 1/4] dt-bindings: mrvl,mmp-timer: add clock
Date:   Tue, 18 Sep 2018 22:54:52 +0200
Message-Id: <20180918205455.25464-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918205455.25464-1-lkundrak@v3.sk>
References: <20180918205455.25464-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer needs the timer clock to be enabled, otherwise it stops
ticking.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Made the clock optional, to keep compatibility with DTs without it

 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
index 9a6e251462e7..b8f02c663521 100644
--- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
@@ -5,9 +5,13 @@ Required properties:
 - reg : Address and length of the register set of timer controller.
 - interrupts : Should be the interrupt number.
 
+Optional properties:
+- clocks : Should contain a single entry describing the clock input.
+
 Example:
 	timer0: timer@d4014000 {
 		compatible = "mrvl,mmp-timer";
 		reg = <0xd4014000 0x100>;
 		interrupts = <13>;
+		clocks = <&coreclk 2>;
 	};
-- 
2.17.1

