Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC33ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618BC214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YT2uEH3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618BC214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeIRBdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:33:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33223 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:33:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so8074757pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k/EUF7VmhBSTJxxqmSwmngNlcIJOOfxS5CmPMMG7NJA=;
        b=YT2uEH3O3HxGre6reGIb3IZJt0bzA3FT2Aptmm9ZY9ck36uPLWX9jwD8SpAUErUHPv
         DUROomB4Js909oAhmd9vIfXqeTfnPDlR/D4Ngl04o3hDw3I7ssJneSBwS6mw6mNud9q/
         kelh4BnXUBEj8D/QDGeBq+AyxGjq95fB2ZD/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k/EUF7VmhBSTJxxqmSwmngNlcIJOOfxS5CmPMMG7NJA=;
        b=bxTus8+GGuVkwELYfzypamQFSvFk867AVt5bsyKQNoyKl7apKQsYPrKsnkZyGhSls+
         cRGfiNDpaF4RpwNL7h9HftlVILI0YVxFIWqFpcdrMqARyHvZmB5ZAwv5dt4qM4hbB3wu
         L+uNZ4zajo5o0hlYde5uDHD84b0+dh7wymujHkplK5Mj+3WlN1ib6fBgVLxrtqTMtZX8
         /8JUgO40OeQZRFNSXHrKxLWDn0e3Dgq4Zy3jc1bcuvEki2lj0DKjOypedqdvhtlHRrfz
         pA9TrrbCBenipF2T760Ut77TF1j9iQGKQegxnGDpplHg8/2Xutd2Yh4Y3nvH7o+FcrqY
         LHqw==
X-Gm-Message-State: APzg51B5JBfHYqi+uf1xNdnrWLWAZB4H9THzrQuY6JsLaqfi0xyxYNtZ
        8tAuWdlegKipvpUj2LoHGVdiSA==
X-Google-Smtp-Source: ANB0VdZr79/KikVjfzGSEBLszURWfP/8yHD4OLvGv29rLE/O05+s3bakbelkngNcfSreZ1SwhOgGSw==
X-Received: by 2002:a62:b2d3:: with SMTP id z80-v6mr27918689pfl.79.1537214684796;
        Mon, 17 Sep 2018 13:04:44 -0700 (PDT)
Received: from ubuntu.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id i3-v6sm16965857pgq.35.2018.09.17.13.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Sep 2018 13:04:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        broonie@kernel.org, yuanjiang.yu@spreadtrum.com, krzk@kernel.org
Subject: [PATCH v3 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
Date:   Mon, 17 Sep 2018 13:03:30 -0700
Message-Id: <8a8d31119bc723a0012afa8e517015dbba68fee9.1537214465.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC2731 charger
device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changes from v2:
 - Add reviewed tag from Krzysztof.

Changes from v1:
 - Add parent node.
 - Add some battery standard properties.
---
 .../bindings/power/supply/sc2731_charger.txt       | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
new file mode 100644
index 0000000..5266fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
@@ -0,0 +1,40 @@
+Spreadtrum SC2731 PMIC battery charger binding
+
+Required properties:
+ - compatible: Should be "sprd,sc2731-charger".
+ - reg: Address offset of charger register.
+ - phys: Contains a phandle to the USB phy.
+
+Optional Properties:
+- monitored-battery: phandle of battery characteristics devicetree node.
+  The charger uses the following battery properties:
+- charge-term-current-microamp: current for charge termination phase.
+- constant-charge-voltage-max-microvolt: maximum constant input voltage.
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-term-current-microamp = <120000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
+		......
+	};
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		charger@0 {
+			compatible = "sprd,sc2731-charger";
+			reg = <0x0>;
+			phys = <&ssphy>;
+			monitored-battery = <&bat>;
+		};
+	};
-- 
1.9.1

