Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424198AbeE1LMp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423908AbeE1LMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 149/272] dt-bindings: add device tree binding for Allwinner H6 main CCU
Date: Mon, 28 May 2018 12:03:02 +0200
Message-Id: <20180528100253.487681283@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>

[ Upstream commit 2e08e4d2ff488424919d69dd211ac860a019ac1d ]

The Allwinner H6 main CCU uses the internal oscillator of the SoC, which
is different with old SoCs' main CCU.

Add device tree binding for the Allwinner H6 main CCU.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt |    4 ++++
 1 file changed, 4 insertions(+)

--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -20,6 +20,7 @@ Required properties :
 		- "allwinner,sun50i-a64-ccu"
 		- "allwinner,sun50i-a64-r-ccu"
 		- "allwinner,sun50i-h5-ccu"
+		- "allwinner,sun50i-h6-ccu"
 		- "nextthing,gr8-ccu"
 
 - reg: Must contain the registers base address and length
@@ -31,6 +32,9 @@ Required properties :
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
 
+For the main CCU on H6, one more clock is needed:
+- "iosc": the SoC's internal frequency oscillator
+
 For the PRCM CCUs on A83T/H3/A64, two more clocks are needed:
 - "pll-periph": the SoC's peripheral PLL from the main CCU
 - "iosc": the SoC's internal frequency oscillator
