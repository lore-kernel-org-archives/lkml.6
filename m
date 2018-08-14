Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB6C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABC12170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABC12170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbeHNPVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:21:09 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:44819 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731909AbeHNPVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:21:09 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 14 Aug 2018 21:34:08 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 9909E68DE5;
        Tue, 14 Aug 2018 21:34:08 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,238,1531753200"; 
   d="scan'208";a="288116196"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 14 Aug 2018 21:34:05 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] serial: sh-sci: Document r8a774a1 bindings
Date:   Tue, 14 Aug 2018 13:34:02 +0100
Message-Id: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
HSCIF ports, so document the SoC specific bindings. While at it,
update the RZ/G1 and RZ/G2 family specific strings description as
outdated.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index eaca9da..1994ab8 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -20,6 +20,8 @@ Required properties:
     - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.
     - "renesas,scif-r8a77470" for R8A77470 (RZ/G1C) SCIF compatible UART.
     - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UART.
+    - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART.
+    - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
@@ -55,13 +57,13 @@ Required properties:
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
     - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
     - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
-    - "renesas,rcar-gen2-scif" for R-Car Gen2 SCIF compatible UART,
-    - "renesas,rcar-gen3-scif" for R-Car Gen3 SCIF compatible UART,
-    - "renesas,rcar-gen2-scifa" for R-Car Gen2 SCIFA compatible UART,
-    - "renesas,rcar-gen2-scifb" for R-Car Gen2 SCIFB compatible UART,
+    - "renesas,rcar-gen2-scif" for R-Car Gen2 and RZ/G1 SCIF compatible UART,
+    - "renesas,rcar-gen3-scif" for R-Car Gen3 and RZ/G2 SCIF compatible UART,
+    - "renesas,rcar-gen2-scifa" for R-Car Gen2 and RZ/G1 SCIFA compatible UART,
+    - "renesas,rcar-gen2-scifb" for R-Car Gen2 and RZ/G1 SCIFB compatible UART,
     - "renesas,rcar-gen1-hscif" for R-Car Gen1 HSCIF compatible UART,
-    - "renesas,rcar-gen2-hscif" for R-Car Gen2 HSCIF compatible UART,
-    - "renesas,rcar-gen3-hscif" for R-Car Gen3 HSCIF compatible UART,
+    - "renesas,rcar-gen2-hscif" for R-Car Gen2 and RZ/G1 HSCIF compatible UART,
+    - "renesas,rcar-gen3-hscif" for R-Car Gen3 and RZ/G2 HSCIF compatible UART,
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
-- 
2.7.4

