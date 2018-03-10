Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCJLFd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 06:05:33 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42505 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeCJLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 06:05:25 -0500
X-Google-Smtp-Source: AG47ELtrZiiK12HbJyXaFUqhw6VNWnlrcFMgDqsBkPkyi+fqMEzxpwU3mxPv4ldgvKOdAEfNx01l1A==
From: Neil Armstrong <narmstrong@baylibre.com>
To: broonie@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RESEND PATCH 1/2] ASoC: Add DT bindings documentation for max9759 amplifier
Date: Sat, 10 Mar 2018 12:05:15 +0100
Message-Id: <1520679916-13517-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520679916-13517-1-git-send-email-narmstrong@baylibre.com>
References: <1520679916-13517-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings documentation for Maxim MAX9759
speaker amplifier.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/sound/maxim,max9759.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9759.txt b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
new file mode 100644
index 0000000..737a996
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
@@ -0,0 +1,18 @@
+Maxim MAX9759 Speaker Amplifier
+===============================
+
+Required properties:
+- compatible : "maxim,max9759"
+- shutdown-gpios : the gpio connected to the shutdown pin
+- mute-gpios : the gpio connected to the mute pin
+- gain-gpios : the 2 gpios connected to the g1 and g2 pins
+
+Example:
+
+max9759: analog-amplifier {
+	compatible = "maxim,max9759";
+	shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+	mute-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+	gain-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>,
+		     <&gpio3 25 GPIO_ACTIVE_LOW>;
+};
-- 
2.7.4
