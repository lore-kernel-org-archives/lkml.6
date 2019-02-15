Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D1CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2CA2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405933AbfBOOMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:12:00 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44667 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbfBOOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:11:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4CDDFFB02;
        Fri, 15 Feb 2019 15:11:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BYd1oskSEwld; Fri, 15 Feb 2019 15:11:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4566848DC0; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/3] dt-bindings: input: Refer to touchscreen.txt for goodix ts
Date:   Fri, 15 Feb 2019 15:11:52 +0100
Message-Id: <99085b90c327193f6bdb9b0a505daa6a9848e1c6.1550239328.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
References: <cover.1550239328.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to touchscreen.txt for generic touch properties. This avoids
duplication and we're using the generic code to parse these in the
driver. While at that add touchscreen-size-{x,y} which are respected by
the driver as well.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../bindings/input/touchscreen/goodix.txt           | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 57d3d8870a09..8cf0b4d38a7e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -19,11 +19,14 @@ Optional properties:
  - irq-gpios		: GPIO pin used for IRQ. The driver uses the
 			  interrupt gpio pin as output to reset the device.
  - reset-gpios		: GPIO pin used for reset
-
- - touchscreen-inverted-x  : X axis is inverted (boolean)
- - touchscreen-inverted-y  : Y axis is inverted (boolean)
- - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
-                             (swapping is done after inverting the axis)
+ - touchscreen-inverted-x
+ - touchscreen-inverted-y
+ - touchscreen-size-x
+ - touchscreen-size-y
+ - touchscreen-swapped-x-y
+
+The touchscreen-* properties are documented in touchscreen.txt in this
+directory.
 
 Example:
 
-- 
2.20.1

