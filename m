Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372DFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1ED20857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1ED20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeIBOZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:30 -0400
Received: from mout.perfora.net ([74.208.4.197]:51331 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:29 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LsAe1-1fla9u0AJj-013pci; Sun, 02 Sep 2018 12:10:09 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 28/37] ARM: tegra: colibri_t20: simplify model and compatible properties
Date:   Sun,  2 Sep 2018 12:08:57 +0200
Message-Id: <20180902100906.25792-29-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:g4p6nmuyYhjSBZg5aIG6XobmQ0fFQm9madx3osLLX/x4HaRl+G1
 H47o4149opL4B6yBiJc5sTftTRRPON1MkNndVvAhr8gBMKZwGGps2nOEk47pAbLG95bx0d4
 HfwHQKOOSLb1r+bo9gtapuwdAEXHY7Yzyt4U+WqYt4ew2BL3GK+Uv0R62p/AzYhoa+ZXatA
 G6TXF2SwuwkJo9o942fdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sao88or5CLo=:vT9080wXfg1UWoGIG6umef
 fA1hrYc89EyPBPdB8xeQC6RB+ie0S7g/EJA9fcQXJmp55xt+Z7fcRxU02CYBtWBsIp2finP24
 rO8RFPp5rdJJBtl3XcxZjZCRlQpjI0nHJzg0PRQ+2mRN2FmAeJi8V6N0kYQeibiqy+OprJUlP
 OiW1C9ksNHw2rej/6h5UOJ8W2acVN/pwyeZsje2Ov7z73PJFS6ARaKm3ONzHXfcugsL3Nh6G5
 fX/3mefgZ+tEgRhoOogUGmNtGOYfsfRvqfE2nxGGwRQhlrlscHulAtb9wPBKqaUlW7ftSgElD
 4vBLq1I03G3Qroq8fjvPqR5Y+mckbg2AGiov+39BeJ+I3kFQ5X17tDxsgtp1zblJgYzXMj75F
 sOaKdZJHCu8qgv2Pewn9iMQf2qvlsKzOVbh0lzMrRQZfccZodOU1sh6j94bN28XCNn9GT8L0+
 bAe1t5ptZ+rI4s/5nGSV/VzxPBBwTnSzrgCb+0gA60PfDdLF6pLuGuqXfHtq48tA5JVQo1jeP
 rcSDu+XS2Tu4j89Gb2NG/rHxkkgh+ktrxgLjmpP2iuOF94COlTmFc8dHzb/tMvFLISXquKgQt
 O8v1BtbK/m6j8D2Z9hV1eWVassEGQISnPwP94rqMVs3AcgRcXKf79JvZjerDrVgjtBh82TJ+u
 znJf48cEDMQ9ojPDfjy7y1TbQOT2sPR1IOyTAzxAR0ZIbkd+AHaLnqr8qq75LYQq5mOA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Simplify model and compatible by dropping the 256/512 MB from the model
and -512 from the compatible properties to be more in-line with all our
other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also reflect this change in the Iris device tree.
- Also reflect this change in the device tree bindings documentation.

 Documentation/devicetree/bindings/arm/tegra.txt | 2 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts      | 4 ++--
 arch/arm/boot/dts/tegra20-colibri.dtsi          | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 1c90cb32da19..5e1b0b30ece2 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -53,7 +53,7 @@ board-specific compatible values:
   toradex,apalis-tk1-eval
   toradex,apalis-tk1-v1.2
   toradex,apalis-tk1-v1.2-eval
-  toradex,colibri_t20-512
+  toradex,colibri_t20
   toradex,colibri_t30
   toradex,colibri_t30-eval-v3
   toradex,iris
diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 1583d5118302..cd47ac5b528f 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -5,8 +5,8 @@
 #include "tegra20-colibri.dtsi"
 
 / {
-	model = "Toradex Colibri T20 256/512 MB on Iris";
-	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
+	model = "Toradex Colibri T20 on Iris";
+	compatible = "toradex,iris", "toradex,colibri_t20", "nvidia,tegra20";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index ea785f65c89f..53e06f31dbea 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -8,8 +8,8 @@
  * Colibri T20 512MB IT V1.2A
  */
 / {
-	model = "Toradex Colibri T20 256/512 MB";
-	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
+	model = "Toradex Colibri T20";
+	compatible = "toradex,colibri_t20", "nvidia,tegra20";
 
 	memory@0 {
 		/*
-- 
2.14.4

