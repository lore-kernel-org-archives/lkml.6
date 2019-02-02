Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E611C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F13E20856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anv9MMHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfBBO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:27:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37891 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfBBO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:27:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so8215309lja.5;
        Sat, 02 Feb 2019 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxLhzGYwH6iCkIpFvsbVMsVL7rqrkLHnqOAjKH+gy/g=;
        b=Anv9MMHZ2Mca/nqRK8YhYmeM2/UB4vuMHpW2xZOC6RCnELiT2ntOR3hJQBVWHffeug
         r5epGW/KRdpLYsEEgWWe8wkshuLkd3zrVuH59fcLqcMjDF3cmnQSdo4VCNDZRR8hiimH
         fW8NZNs/IY3mtitAF1rcY9z4+AaDQiKb3goXrgPgs9SSABJYnbLBP0wB/GrITQsASqeT
         a9dEf+Ob9Jc5OM+7pXklooqmGlHJc3HqrWuJjv3EfzjGdZIkBgx9I8GcvzsWidND/aEd
         q5drRtPJselzD5RCqVYOZ3U26V1soz/7oj1fgreUw9njwrf1OrlKpQOjnj7rhZ3NEmgS
         2DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxLhzGYwH6iCkIpFvsbVMsVL7rqrkLHnqOAjKH+gy/g=;
        b=ssMyTHG03InUuq+5Le5rtz45hgBgyofG45fCaVC7kY+KNFoTVF1BJiHNQLtqTX5IA+
         5n0SU94kRY2IL4O665Y3FlkklLZFh0MYFRGaqMzUAMTwCE+47Zq5/qhFbMi7Ij7s74HF
         YSl5YB8o59HejbUB0WIuiQWeIlxTUSNsoFjHie69oWaUw45Z+5qz/PuLqHchEgmeoEQH
         VCwSxcjMjuCwNhAIHwMaQmhHOVipAWourD2UfzHbE5kiRcrzJm4bkSA7L/uwy+tjEpcJ
         X7/zCFoydK83cziCPxm/tb+lN2/eJvT8BIRYJN3SCnR3cz1AAFQQ7dAL8QnahCPoZ5kN
         T1nQ==
X-Gm-Message-State: AJcUukfXa0lWiSsMFfYxXtkkjSVMrymOisbv+quWPozFzHWWEeA4U1A+
        z+pRz5QxjnQ3HifrUwT7Gh0=
X-Google-Smtp-Source: ALg8bN63K8JOlQWSJusYzoIFN7MwpnevzzRzoWsWz7uhsXUfG6/jHBNd/NgPihxwrcfDxDGnLXV6Ew==
X-Received: by 2002:a2e:a0d5:: with SMTP id f21-v6mr34634202ljm.98.1549117673310;
        Sat, 02 Feb 2019 06:27:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.googlemail.com with ESMTPSA id v9sm1937963lfg.15.2019.02.02.06.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 06:27:52 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, m.szyprowski@samsung.com, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: drm: panel: Add Samsung s6e63m0 panel documentation
Date:   Sat,  2 Feb 2019 15:27:47 +0100
Message-Id: <20190202142748.6830-1-pawel.mikolaj.chmiel@gmail.com>
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

