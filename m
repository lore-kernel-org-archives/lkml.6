Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6ECC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA1420881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA1420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJPWz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:55:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:55726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727263AbeJPWyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:54:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23AE3B073;
        Tue, 16 Oct 2018 15:03:59 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, tiwai@suse.de,
        nsaenzjulienne@suse.de
Subject: [PATCH 6/9] ASoC: dt-bindings: bcm2835-rpi: add onboard audio bindings
Date:   Tue, 16 Oct 2018 17:02:25 +0200
Message-Id: <20181016150228.16994-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016150228.16994-1-nsaenzjulienne@suse.de>
References: <20181016150228.16994-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a device tree binding file for Raspberry pi's Headphones and HDMI
audio output devices.

Based on raspberry's downstream kernel implementation:
https://github.com/raspberrypi/linux/blob/rpi-4.14.y/arch/arm/boot/dts/bcm2708-rpi.dtsi

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bindings/sound/brcm,bcm2835-audio.txt         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt
new file mode 100644
index 000000000000..ee6fa085aaa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt
@@ -0,0 +1,15 @@
+Broadcom BCM283x audio device
+
+Required properties:
+
+- compatible: Should be "brcm,bcm2835-audio"
+- brcm,pwm-channels: number of PWM channels, they are behind RPi's Video Core
+		     IV, not actual Linux PWM devices.
+
+Example:
+
+audio: audio {
+	compatible = "brcm,bcm2835-audio";
+	brcm,pwm-channels = <8>;
+};
+
-- 
2.19.1

