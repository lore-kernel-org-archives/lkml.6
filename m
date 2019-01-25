Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19653C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D931F218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc692FDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfAYQq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:46:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40545 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAYQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:46:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so8905310lji.7;
        Fri, 25 Jan 2019 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/Orv3a49mHdt2En2NviO/VS3JHy0Qqr765jzlm9HW4=;
        b=Gc692FDq7HwMDdrlzW2vOulpMfNRTn0r1nVNet89vjypSiCqBv/eVk6E6442KS/xTe
         FaZyYtjWy8IuR0J5bn3Er3cXSVI+lFpZOhqW8Q2ibiVchk1Scmy8zqsiNMfV01gNaWXf
         jAy7Omqm0usHSl4Ux/l6flBo6X3eMcrXkib6pASQcL0GFuJRvRfKaP+k8fnam3l19QTK
         Z/Qjo3ghbB0Q7CRsN0KnD5j6ER8efZsx2jqnXpUekJ+BQCKe92EAzLzEcoJO+F8df+x/
         6yBHw/yjiH6t+7WWTMkovn8oQ7uIVX6Gl55iL8S0m2hVvn6NCEtohRqXn+m669K0N0TL
         cKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/Orv3a49mHdt2En2NviO/VS3JHy0Qqr765jzlm9HW4=;
        b=qzmj7HUfUVgcmTxTxNktkWcd7CBCZpA6NoktH53Gdw3ELbtTDZ3W/72wWyDCxjsNnD
         gi6Rf4J8iskVeXcIcQhXC72VKvwZiIt3lupk2+OqFKvUY23tuOIOFJBvha/cEdl7gU+3
         bGMymMR/HebuPauGkl0jC8e8Mfsbkk0Ec8neddhSIEHAx725rDeDg3dGpmfq96UITieo
         r3HUyqEeJ02DVxV48nJqDeCqYO9Kiev9vYwV4gCbdhKvseew29e5RZVD/PPKtXLeit4H
         pVGS/GB3JHVbe7Afcs+Bx8Vpi3uQ1jD0kkKDRzvImR9/WQy9IU0gqD/pgsPui2aK7052
         UDnQ==
X-Gm-Message-State: AJcUuke+GDj23Lk6s7y11PrHjBNs5KzdZ3DjuuRS4rb/2DxSmku2aX3O
        55cfCxvc5t+MWAFiPCfpL9c=
X-Google-Smtp-Source: ALg8bN6YQRbKph6ym/t/YT0eEOpv14zlkAUmJpgrxNwOwP34veJzcZm/al/vCWychbQgweUfdp70aA==
X-Received: by 2002:a2e:8256:: with SMTP id j22-v6mr9544116ljh.40.1548434816639;
        Fri, 25 Jan 2019 08:46:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id b25sm1531540lfa.96.2019.01.25.08.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 08:46:55 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, m.szyprowski@samsung.com, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/2] drm: panel: Add Samsung s6e63m0 panel documentation
Date:   Fri, 25 Jan 2019 17:46:44 +0100
Message-Id: <20190125164645.19208-1-pawel.mikolaj.chmiel@gmail.com>
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
---
 .../display/panel/samsung,s6e63m0.txt         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
new file mode 100644
index 000000000000..4979200e2dd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
@@ -0,0 +1,60 @@
+Samsung s6e63m0 AMOLED LCD panel
+
+Required properties:
+  - compatible: "samsung,s6e63m0"
+  - reset-gpio: GPIO spec for reset pin
+  - vdd3-supply: VDD regulator
+  - vci-supply: VCI regulator
+  - display-timings: timings for the connected panel as described by [1]
+
+Optional properties:
+  - reset-delay: Delay in ms after adjusting reset-gpio, default 120ms
+  - power-on-delay: Delay in ms after powering on, default 25ms
+  - power-off-delay: Delay in ms before powering off, default 200ms
+  - panel-width-mm: physical panel width in mm
+  - panel-height-mm: physical panel height in mm
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in [2]. This
+node should describe panel's video bus.
+
+[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
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
+			spi-max-frequency = <1000000>;
+
+			power-on-delay = <0>;
+			power-off-delay = <0>;
+			reset-delay = <10>;
+			panel-width-mm = <53>;
+			panel-height-mm = <89>;
+
+			display-timings {
+				timing-0 {
+					/* 480x800@60Hz */
+					clock-frequency = <25628040>;
+					hactive = <480>;
+					vactive = <800>;
+					hfront-porch = <16>;
+					hback-porch = <16>;
+					hsync-len = <2>;
+					vfront-porch = <28>;
+					vback-porch = <1>;
+					vsync-len = <2>;
+				};
+			};
+
+			port {
+				lcd_ep: endpoint {
+					remote-endpoint = <&fimd_ep>;
+				};
+			};
+		};
-- 
2.17.1

