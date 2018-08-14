Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DDFC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328512170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328512170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbeHNPV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:21:59 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:14278 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732188AbeHNPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:21:59 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 14 Aug 2018 21:34:59 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 33D3368DFE;
        Tue, 14 Aug 2018 21:34:59 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,238,1531753200"; 
   d="scan'208";a="288116224"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 14 Aug 2018 21:34:56 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] mmc: renesas_sdhi: Add r8a774a1 support
Date:   Tue, 14 Aug 2018 13:34:34 +0100
Message-Id: <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index c434200..8315fb5 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -17,6 +17,7 @@ Required properties:
 		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
 		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
 		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
+		"renesas,sdhi-r8a774a1" - SDHI IP on R8A774A1 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
 		"renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
 		"renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
@@ -34,7 +35,8 @@ Required properties:
 		"renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
 		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
 					   SDHI controller
-		"renesas,rcar-gen3-sdhi" - a generic R-Car Gen3 SDHI controller
+		"renesas,rcar-gen3-sdhi" - a generic R-Car Gen3 or RZ/G2
+					   SDHI controller
 
 
 		When compatible with the generic version, nodes must list
-- 
2.7.4

