Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D4F20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Zh9RI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfBVRwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:52:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35844 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:52:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id q11so2377579lfd.3;
        Fri, 22 Feb 2019 09:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jacprPBn05l4R8g5qgw4GNE3Kp5hDAm7FHtawGYUnlI=;
        b=L/Zh9RI0ssQR0EALwGYzQ6gixFIncXnJ56+pyjy/JOGI7m1dzGaH2IFkpZw2kM5uu/
         W6ZjpaEbc63jAXc+AaDM1TNfqYemYXtsAA6l6Ep8Dm+0TnND/E/ns+o7fQnLrouFrtxM
         /WIJZPuvCmN0B1xLkwbs6RxlgWvbgXL/qTOxtB98NWBYAKo9vDLFfECpFyVQAiQyYQnq
         TefYpQpj5WMmm34sOme9aPm19dJQOXG/4go06abNQSWUKRJyKc84NNoLn6XavhCo3iIt
         6jAUXiZkyjPXdSIhZefhAK6zV5j6cozExNm5XPUswhJB6YWTA9Ozs7m0TRuyNeVSEvUP
         8pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jacprPBn05l4R8g5qgw4GNE3Kp5hDAm7FHtawGYUnlI=;
        b=sR6UQZ50hh227KS+Pqpv/eRmt3xmjtbXVBzX8k5N3li8FQp5fhoMW+HSdalTrLxaPB
         8GxgbCK/LxYqjwLQ9VTyfiSvDFW50K7uVlR3odSj8GK6JioucmGs+a4dd9AfgTvEUpJE
         0+DrLJJ10NncDDe+lIQbSMO1PLVeasXSzEaS+8LHfsU+XEDUKjlvWYLGj+XxX0Yv10q6
         V3gxvfAFVfKRx21r8wMnToQHov86UOp0rb6rgdC9MqZVHqoFg0iFeIeIBXYt6sxDSr+p
         +k+0WV8DHcL44jyiDyDDdEuh/vATVDCwIPgf2mGYWwrMAxjYjfJdM7Z1FotOuBjfcRo6
         vE9A==
X-Gm-Message-State: AHQUAubM1o+9UkEZZb6VpL6vudb+Oj258woZ4WaTcDrn+j/qlUaTGUqi
        0YFga+r302yHjuh5TVbykcQ=
X-Google-Smtp-Source: AHgI3IZp4dQ0T/awzVKVjT0BKOvaT9cQcNh1KeJ7L3lASnBBO5UL32AuGvM5eueAnq2CPXJEpzZ6lA==
X-Received: by 2002:a19:9c87:: with SMTP id f129mr3170169lfe.77.1550857919037;
        Fri, 22 Feb 2019 09:51:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:b16d:ecd7:a81b:d059])
        by smtp.googlemail.com with ESMTPSA id v65sm655958lje.77.2019.02.22.09.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 09:51:58 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, m.szyprowski@samsung.com, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: drm: panel: Add Samsung s6e63m0 panel documentation
Date:   Fri, 22 Feb 2019 18:51:52 +0100
Message-Id: <20190222175153.20567-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

This commit adds documentation for Samsung s6e63m0 AMOLED LCD panel
driver.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v2:
  - Added Reviewed-by

Changes from v1:
  - Add missing subject prefix
  - Rename reset-gpio to reset-gpios
  - Add link to spi properites documentation. They're required
    for driver to work
  - Removed delay properties, which are now hardcoded in driver
  - Removed display timings, which are now hardcoded in driver
---
 .../display/panel/samsung,s6e63m0.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
new file mode 100644
index 000000000000..9fb9ebeef8e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
@@ -0,0 +1,33 @@
+Samsung s6e63m0 AMOLED LCD panel
+
+Required properties:
+  - compatible: "samsung,s6e63m0"
+  - reset-gpios: GPIO spec for reset pin
+  - vdd3-supply: VDD regulator
+  - vci-supply: VCI regulator
+
+The panel must obey rules for SPI slave device specified in document [1].
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in [2]. This
+node should describe panel's video bus.
+
+[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
+[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+		s6e63m0: display@0 {
+			compatible = "samsung,s6e63m0";
+			reg = <0>;
+			reset-gpio = <&mp05 5 1>;
+			vdd3-supply = <&ldo12_reg>;
+			vci-supply = <&ldo11_reg>;
+			spi-max-frequency = <1200000>;
+
+			port {
+				lcd_ep: endpoint {
+					remote-endpoint = <&fimd_ep>;
+				};
+			};
+		};
-- 
2.17.1

