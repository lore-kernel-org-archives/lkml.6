Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEE7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83A82177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="nJwp9grW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfA2KYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:24:03 -0500
Received: from mout02.posteo.de ([185.67.36.66]:44919 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfA2KYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:24:02 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4C1722400FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548757440; bh=DY6aMhdu6hrdcEZWqhPjCrorr3VltracxCXw0bMyUpc=;
        h=From:To:Cc:Subject:Date:From;
        b=nJwp9grW7woHb4P5dl+vYp89xaWZB2pYUxQ59KG5+Ylv36gG1OmpveMLEP/3k8FTt
         W/FaDFRvdhohueyoj0/cv/2OtTWVMBkR+OgjjDrA1xN4AvJsPFOxOOV3ct208sTLpG
         5ppJ0a9JPs2PfehuTq3wRjbcjELLo7iJA2XckW2y/oL8S5MXFO0Et3RM7XuTOLtfDC
         ZwUwAQU37InU8GdkpWM16rpB/vq2Y9Mdl6fHc1b4Z9JEEcRZqBwnQseg0iZOd2lU6O
         HEu2mJdrc+nJ1FYe91GikK5unZNwT1K106ll9u1z5nMxqz6LuRfH0n0z5YGeuQi2OX
         IYebUhXyoPFug==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pjJv0JCNz9rxd;
        Tue, 29 Jan 2019 11:23:58 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 1/2] dt-bindings: input: sitronix-st1232: document optional reset-gpios property
Date:   Tue, 29 Jan 2019 11:23:46 +0100
Message-Id: <20190129102347.27754-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

The st1232 driver reads this via gpiod.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 .../devicetree/bindings/input/touchscreen/sitronix-st1232.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
index e73e826e0f2a..365b32d30d4b 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
@@ -8,7 +8,7 @@ Required properties:
 - interrupts: interrupt to which the chip is connected
 
 Optional properties:
-- gpios: a phandle to the reset GPIO
+- reset-gpios: a phandle to the reset GPIO
 
 Example:
 
@@ -19,7 +19,7 @@ Example:
 			compatible = "sitronix,st1232";
 			reg = <0x55>;
 			interrupts = <2 0>;
-			gpios = <&gpio1 166 0>;
+			reset-gpios = <&gpio1 166 0>;
 		};
 
 		/* ... */
-- 
2.20.1

