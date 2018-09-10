Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D1120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D1120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeIJQYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:24:20 -0400
Received: from shell.v3.sk ([90.176.6.54]:35838 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeIJQYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:24:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3000DB82ED;
        Mon, 10 Sep 2018 13:30:41 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vKJvX6XQVGds; Mon, 10 Sep 2018 13:30:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1E744B82E9;
        Mon, 10 Sep 2018 13:30:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bzYGiW-mOwgV; Mon, 10 Sep 2018 13:30:35 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 447F2B82D7;
        Mon, 10 Sep 2018 13:30:35 +0200 (CEST)
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
Subject: [PATCH 1/4] dt-bindings: mrvl,mmp-timer: add clock
Date:   Mon, 10 Sep 2018 13:30:28 +0200
Message-Id: <20180910113031.42634-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910113031.42634-1-lkundrak@v3.sk>
References: <20180910113031.42634-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer needs the timer clock to be enabled, otherwise it stops
ticking.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
index 9a6e251462e7..a2ede0bd12ca 100644
--- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
@@ -4,10 +4,12 @@ Required properties:
 - compatible : Should be "mrvl,mmp-timer".
 - reg : Address and length of the register set of timer controller.
 - interrupts : Should be the interrupt number.
+- clocks : Should contain a single entry describing the clock input.
 
 Example:
 	timer0: timer@d4014000 {
 		compatible = "mrvl,mmp-timer";
 		reg = <0xd4014000 0x100>;
 		interrupts = <13>;
+		clocks = <&coreclk 2>;
 	};
-- 
2.17.1

