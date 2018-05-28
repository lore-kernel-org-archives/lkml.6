Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163441AbeE1Ksz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034131AbeE1Kso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:48:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 168/496] ARM: dts: bcm283x: Fix unit address of local_intc
Date: Mon, 28 May 2018 11:59:13 +0200
Message-Id: <20180528100326.944066513@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 808b7de86a0c19582a7efce4c80d6b4e1da7f370 ]

This patch fixes the following DTC warning (requires W=1):
Node /soc/local_intc simple-bus unit address format error, expected "40000000"

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm2836.dtsi |    2 +-
 arch/arm/boot/dts/bcm2837.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -9,7 +9,7 @@
 			 <0x40000000 0x40000000 0x00001000>;
 		dma-ranges = <0xc0000000 0x00000000 0x3f000000>;
 
-		local_intc: local_intc {
+		local_intc: local_intc@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
 			reg = <0x40000000 0x100>;
 			interrupt-controller;
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -8,7 +8,7 @@
 			 <0x40000000 0x40000000 0x00001000>;
 		dma-ranges = <0xc0000000 0x00000000 0x3f000000>;
 
-		local_intc: local_intc {
+		local_intc: local_intc@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
 			reg = <0x40000000 0x100>;
 			interrupt-controller;
