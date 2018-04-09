Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeDITcA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:32:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32905 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeDIT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:29:50 -0400
X-Google-Smtp-Source: AIpwx49ntUwkZbVhlxobik/B+A59hdNwhUqXXID8TcYGHPtkTsPyS6LYXsmTpFa/MzPapJ1vi+AgRg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/15] dt-bindings: arm: tegra: Remove duplicated Tegra30+ MC binding
Date: Mon,  9 Apr 2018 22:28:23 +0300
Message-Id: <1ac41372c213e96871df1e02cada2e1899f03a7b.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two bindings for the same Memory Controller. One of the bindings
became obsolete long time ago and probably was left unnoticed, remove it
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/tegra/nvidia,tegra30-mc.txt           | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-mc.txt

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-mc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-mc.txt
deleted file mode 100644
index bdf1a612422b..000000000000
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-mc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-NVIDIA Tegra30 MC(Memory Controller)
-
-Required properties:
-- compatible : "nvidia,tegra30-mc"
-- reg : Should contain 4 register ranges(address and length); see the
-  example below. Note that the MC registers are interleaved with the
-  SMMU registers, and hence must be represented as multiple ranges.
-- interrupts : Should contain MC General interrupt.
-
-Example:
-	memory-controller {
-		compatible = "nvidia,tegra30-mc";
-		reg = <0x7000f000 0x010
-		       0x7000f03c 0x1b4
-		       0x7000f200 0x028
-		       0x7000f284 0x17c>;
-		interrupts = <0 77 0x04>;
-	};
-- 
2.16.3
