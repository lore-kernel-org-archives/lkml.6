Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeDTKV4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:21:56 -0400
Received: from s02.spamexperts.axc.nl ([185.182.56.112]:50791 "EHLO
        s02.spamexperts.axc.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754398AbeDTKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:21:54 -0400
From: Pascal Roeleven <dev@pascalroeleven.nl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-sunxi@googlegroups.com, Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [PATCH] ARM: dts: sun4i: Fix incorrect clocks for displays
Date: Fri, 20 Apr 2018 12:21:12 +0200
Message-Id: <20180420102112.2843-1-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.14.1
X-Originating-IP: 185.182.56.82
X-SpamExperts-Domain: vserver22.axc.nl
X-SpamExperts-Username: 185.182.56.82
Authentication-Results: spamexperts.axc.nl; auth=pass smtp.auth=185.182.56.82@vserver22.axc.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00205997689309)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gug3QpvOCQpWMNMcj0zVsJ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOyJdjcti6J0RCGni7o34pMJaNxoI+swKN4OKBxxlpUrIjI/HPNQqquPS+4u1dv03D8yT
 HgXnmMJMKigbOQhSUXL+d1rVz1NDwrOQGxk7mqtiDzCjdvuLlNprJt7sM9U2tvEm1xUk+uitP3zt
 fVUM86qADZEAq6MVvDzVG1eBiMwsxonw6auRGB+OqkfrxZvcAu63p/UbUTcmIpuXtxg/CxlyFZQN
 yGR1xdWr/EMlluN/HaaU/Zb275qB1xqcfpxQM78iXoKuit7KYsvfORRN32/uqqHf0YlM0FoFl5SM
 CrNVm5UrAVUJXWCOkjmLx5rfPZgVK/yuYE/krsmCL6uU3MJd3FLLN5JZzRmnU7SUHT2Pg8CBO1Sn
 vm6qXHQp7O9kdXzJqywiCyRpWLvaQP8TpD1s24tFNcrW2H3oHk7M+t/IGFvlHOQsi9fJrQH2HB7K
 cn7E9n664KB+xMpIjboCH5KLZs4XEHfQdJxMWQNlIJHit1AzVHmN/1Ca6vYbegKN9pDtMXpd47Jk
 uyvi9F/b5Xr+q263SxhPVtF/V2M9L7dcNvokIFGx07bhuY7QrNII/xIn+RMmMo9n/zJo//hfCVlk
 AdhK23InA2zzja5I1riDJBcOl1Sca1tCLiymrRRXBKDkaM024bykcyHR7I4FbmnLRaO3oh2Y+QPh
 zq1ed4hKPsarl5dnGXsBogEFWhbvijo/WtzAwxKxmN+PCLjJS1n9BQ7dDQWLiI0sLYm4yP/7OMye
 V7249X2e1GQHGQCkca9WJmbhekdrgcJsDlHBdahrSlHVtLHaZkFpoXAuc0NSszzIs5JwgEfDLX6H
 GowTU2CijbR5gOtRiEFrJGnSGxi96t0jSpXk/FZ1fwcf7/prCnx4FGUWiONpnHe100SbOuHRfOND
 F4cVqm7lmX5VA+Pwnfs6UYm2Ai3DKHJBJpSzRMpIF9IBzdGcYCSXOfSYlSMSQqwehtcVwrU/hgPN
 NmRy2DNwOgV373pfDhBQ21OdRS1J8Q9o9wsNBuY1VdC8WZCMICylBBeA9ExrvE2k+wP4j3vl9ilE
 NAJdELfMPSIKfhWFL18GAOeh/x4RI75Pxakgsnq2YdHMNQhGOMdLA4kBXtD10+3+aA6m3yQ23IEc
 XNM8K+LjoSSEl2/JdfLG6TwbaO2SDHRS+6qA2mIAaxiySMNG8mWJheziSx58QXxt
X-Report-Abuse-To: spam@s01.spamexperts.axc.nl
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some displays on SUN4i devices wouldn't properly stay on unless 'clk_ignore_unused' is used.

Change the duplicate clocks to the probably intended ones.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 77e8436b..3a1c6b45 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -76,7 +76,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
 			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI0>,
 				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
-				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
 				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_HDMI>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
@@ -88,7 +88,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
 			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_DE_BE0>,
 				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_DE_BE0>,
-				 <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_TCON0_CH0>,
+				 <&ccu CLK_DE_FE0>, <&ccu CLK_TCON0_CH0>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
 		};
@@ -99,7 +99,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
 			clocks = <&ccu CLK_AHB_TVE0>, <&ccu CLK_AHB_LCD0>,
 				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
-				 <&ccu CLK_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
+				 <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
 				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_TVE0>,
 				 <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
 			status = "disabled";
-- 
2.14.1
