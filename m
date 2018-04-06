Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeDFMqv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:46:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39726 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeDFMqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:46:47 -0400
X-Google-Smtp-Source: AIpwx4+pfXxAM6+5I1y/M6dSR6DNJudzg9L2pQt9ZT7dJ1c6GvSbqOBP2otqE1doSbei08SQ3JeA7w==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: netdev@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Manoil <claudiu.manoil@freescale.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Esben Haabendal <eha@deif.com>
Subject: [PATCH] ARM: dts: ls1021a: Specify TBIPA register address
Date: Fri,  6 Apr 2018 14:46:35 +0200
Message-Id: <20180406124635.12319-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180406123836.12019-2-esben.haabendal@gmail.com>
References: <20180406123836.12019-2-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

The current (mildly evil) fsl_pq_mdio code uses an undocumented shadow of
the TBIPA register on LS1021A, which happens to be read-only.
Changing TBI PHY address therefore does not work on LS1021A.

The real (and documented) address of the TBIPA registere lies in the eTSEC
block and not in MDIO/MII, which is read/write, so using that fixes
the problem.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c31dad98f989..728e206009ea 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -587,7 +587,8 @@
 			device_type = "mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0x0 0x2d24000 0x0 0x4000>;
+			reg = <0x0 0x2d24000 0x0 0x4000>,
+			      <0x0 0x2d10030 0x0 0x4>;
 		};
 
 		ptp_clock@2d10e00 {
-- 
2.16.3
