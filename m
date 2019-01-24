Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C24C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EB7218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="meBCGkOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAXKVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:21:41 -0500
Received: from mout01.posteo.de ([185.67.36.65]:45722 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfAXKVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:21:40 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 957D0160067
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:21:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548325297; bh=+URa6sUp2On8kiz+BpTPKGcS45VMYhhpu+e7ZawrkpU=;
        h=From:To:Cc:Subject:Date:From;
        b=meBCGkOzm5BasDxeziOTQcksTvSJIU6tbtOd+CsbFTcS6O6l/qkQeM8i5PR3V/3Rq
         McD1rBYuNW5hR+5QIeJG1mMTJtpD/rxsdFLGEKjezZsy2Vb9BrBRlsUQp2dKAgP+Kp
         UuC9l43k4iBervySSNlE8b5mL/LgkUdXymDtwHVJmyu4ifnkh3o3O2tHpKa/Ab+ojH
         lCm+8MpCSGI7sOpADzjFjsDSRe/A2Y5sfsSCAJg93s/kne947UwpjSdlA9Z0CV82yf
         2KyEMDQ/zGhX6FUAE1eKjfPcZAy3zDKJawc8q5OlXqOvSPHwH8CS5tlOCn8S7KRMGi
         iuVWT1nf8xJOQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43ldVR60sZz6tmL;
        Thu, 24 Jan 2019 11:21:35 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, chinyeow.sim.xt@renesas.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH v2 1/2] dt-bindings: input: sitronix-st1232: add compatible string for ST1633
Date:   Thu, 24 Jan 2019 11:21:24 +0100
Message-Id: <20190124102125.25458-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

The st1232 driver gains support for the ST1633 controller too; update
the bindings doc accordingly.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 .../bindings/input/touchscreen/sitronix-st1232.txt          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
index 64ad48b824a2..e73e826e0f2a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
@@ -1,7 +1,9 @@
-* Sitronix st1232 touchscreen controller
+* Sitronix st1232 or st1633 touchscreen controller
 
 Required properties:
-- compatible: must be "sitronix,st1232"
+- compatible: must contain one of
+  * "sitronix,st1232"
+  * "sitronix,st1633"
 - reg: I2C address of the chip
 - interrupts: interrupt to which the chip is connected
 
-- 
2.20.1

