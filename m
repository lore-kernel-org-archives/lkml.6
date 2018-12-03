Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C13C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F3E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F3E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLCVeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:34:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37585 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeLCVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:32:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so12373757oia.4;
        Mon, 03 Dec 2018 13:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoLiDVuqvYANZ1flcAwjENqg+ADf2CNBEHOQ2CuYDWM=;
        b=RB3mdpB5veUBWpO/ECaQpvoz4vrkgW6IT4NYIlz8hTXT+RQf+u+fXOaz/D9C00KxpT
         57/EmFHH6vLIPLyatedU3xfkW6vE3KvwZVbyuJ7munDSlaotI3YoBArm8gF9ZB2zvOKa
         qCk3VT3ivqshbCuBI9VamCTyD/Rf5WxNAq5Ao/8+N4syTKNViwWCPJU+aiUkTDPVliFS
         ioUsqbfC3S5j3txegFoaULvY5DLhHQqrX6EL1GVg5nrOxgcHjkzhgJhFPAgj0SiW83XQ
         uEZDqOiquKf3L27Ju524DvQojlI+cY+VZ6BdiMXVlsYTpS3dFdzrj6q2Dte+XYg8WWMM
         vaqA==
X-Gm-Message-State: AA+aEWbWrHmXAmS3JTy5WB4XzPeve9wPahjBScPZXL0cAsHKObrixymN
        Asx55ZSOs4dLl9JSe33gNpBbQAc=
X-Google-Smtp-Source: AFSGD/VJlx1PDBZmcmB/SGQ6RsJ+otqbwoIYa3j7R2bskbvkocxhm0ynECKqW7DVQTmQOycr/0tgTQ==
X-Received: by 2002:aca:5bc3:: with SMTP id p186mr10568213oib.130.1543872776478;
        Mon, 03 Dec 2018 13:32:56 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:32:55 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 25/34] dt-bindings: arm: renesas: Move 'renesas,prr' binding to its own doc
Date:   Mon,  3 Dec 2018 15:32:14 -0600
Message-Id: <20181203213223.16986-26-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/renesas,prr.txt   | 20 +++++++++++++++++++
 .../devicetree/bindings/arm/shmobile.txt      | 18 -----------------
 2 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt

diff --git a/Documentation/devicetree/bindings/arm/renesas,prr.txt b/Documentation/devicetree/bindings/arm/renesas,prr.txt
new file mode 100644
index 000000000000..08e482e953ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/renesas,prr.txt
@@ -0,0 +1,20 @@
+Renesas Product Register
+
+Most Renesas ARM SoCs have a Product Register or Boundary Scan ID Register that
+allows to retrieve SoC product and revision information.  If present, a device
+node for this register should be added.
+
+Required properties:
+  - compatible: Must be one of:
+    "renesas,prr"
+    "renesas,bsid"
+  - reg: Base address and length of the register block.
+
+
+Examples
+--------
+
+	prr: chipid@ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 58c4256d37a3..5f18ce9cdbb8 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -149,21 +149,3 @@ Boards:
     compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat (RTP0RC7792ASKB0000JE)
     compatible = "renesas,wheat", "renesas,r8a7792"
-
-
-Most Renesas ARM SoCs have a Product Register or Boundary Scan ID Register that
-allows to retrieve SoC product and revision information.  If present, a device
-node for this register should be added.
-
-Required properties:
-  - compatible: Must be "renesas,prr" or "renesas,bsid"
-  - reg: Base address and length of the register block.
-
-
-Examples
---------
-
-	prr: chipid@ff000044 {
-		compatible = "renesas,prr";
-		reg = <0 0xff000044 0 4>;
-	};
-- 
2.19.1

