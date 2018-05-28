Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162341AbeE1KiY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161220AbeE1KiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:38:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Puschmann <pp@emlix.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 270/329] arm: dts: socfpga: fix GIC PPI warning
Date: Mon, 28 May 2018 12:03:19 +0200
Message-Id: <20180528100304.394502386@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Puschmann <pp@emlix.com>

[ Upstream commit 6d97d5aba08b26108f95dc9fb7bbe4d9436c769c ]

Fixes the warning "GIC: PPI13 is secure or misconfigured" by
changing the interrupt type from level_low to edge_raising

Signed-off-by: Philipp Puschmann <pp@emlix.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/socfpga.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -759,7 +759,7 @@
 		timer@fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xfffec600 0x100>;
-			interrupts = <1 13 0xf04>;
+			interrupts = <1 13 0xf01>;
 			clocks = <&mpu_periph_clk>;
 		};
 
