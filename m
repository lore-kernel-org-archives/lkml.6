Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4154BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7602082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7602082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeLEHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:49:40 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41852 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeLEHtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:49:40 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gURw9-0005jJ-Sa from Jiada_Wang@mentor.com ; Tue, 04 Dec 2018 23:49:37 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 4 Dec 2018 23:49:34 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <vladimir_zapolskiy@mentor.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH linux-next v3 7/7] clk: renesas: Add binding document for ADG
Date:   Wed, 5 Dec 2018 16:49:47 +0900
Message-ID: <20181205074947.28151-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Audio Clock Generator (ADG)
of R-Car Socs.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 .../clock/renesas,rcar-adg-clocks.txt         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt
new file mode 100644
index 000000000000..76fc4f8964e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt
@@ -0,0 +1,24 @@
+* Renesas R-Car Audio Clock Generator (ADG)
+
+The Audio Clock Generator (ADG) is part of R-Car Audio module, it
+selects and supplies the necessary clock for the SSIU, EAVB-IF, SCU,
+ADSP or DTCP module. It also divides the frequency of the selected
+clock and sends it outside the chip.
+
+Required Properties:
+
+  - compatible: Must be one of
+    - "renesas,rcar_sound-gen1" for the R-Car GEN1 SoCs
+    - "renesas,rcar_sound-gen2" for the R-Car GEN2 SoCs
+    - "renesas,rcar_sound-gen3" for the R-Car GEN3 SoCs
+
+  - reg: Base address and length of the memory resource used by the ADG
+
+  - clocks: References to the parent clock S0D1.
+  - clock-names: ADG refer to its parent clock by name "adg".
+  - #clock-cells: Can be 0, 1 or 2
+    - When clock-cells = 0, ADG registers one fixed clock out
+    - When clock-cells = 1, ADG registers 3 fixed clock out
+    - When clock-cells = 2, ADG registers 3 fixed clock out and 8 AVB clocks
+      second clock specifier need to be 0 to refer to fixed clock out, need
+      to be 1 to refer to AVB clocks
-- 
2.19.2

