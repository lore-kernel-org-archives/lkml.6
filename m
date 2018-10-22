Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E406C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6C920658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6C920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeJVSvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:51:31 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.211]:14093 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728614AbeJVSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:51:30 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-west-2.aws.symcld.net id 3C/65-11344-A77ADCB5; Mon, 22 Oct 2018 10:33:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRWlGSWpSXmKPExsXi5LtOQLdq+dl
  og3dLOS3mHznHarFx820Wi1VTd7JYbHp8jdWi69dKZovLu+awWSy9fpHJonXvEXaLv9s3sVi8
  2CLuwOWxZt4aRo9NqzrZPDYvqffY+G4Hk0f/XwOPz5vkAtiiWDPzkvIrElgzHqxqZy+4z1HxY
  F0bSwNjB3sXIxeHkMBqRol9fx4ydzFyAjlrGCWubkuESGxhlJi/5TkLSIJNQEdiyv7DYLaIgK
  TE2pWLmEGKmAWmMEmc/raLDSQhLBAqcejrZ0YQm0VAVWJi715WEJtXwE3i1r0rYM0SAnISN89
  1gm3jFHCXWHz/JivEZjeJ9lOP2SDqBSVOznwCVs8sICFx8MULqOuUJbasuMAIMUdBYu2B80wT
  GAVmIWmZhaRlASPTKkaLpKLM9IyS3MTMHF1DAwNdQ0MjXUNjc11Dcwu9xCrdZL3SYt3y1OISX
  SO9xPJiveLK3OScFL281JJNjMB4SSno3LSDccqK9EOMkhxMSqK8icano4X4kvJTKjMSizPii0
  pzUosPMcpwcChJ8KYuOxstJFiUmp5akZaZA4xcmLQEB4+SCO9EkDRvcUFibnFmOkTqFKMxx7X
  //6czc7Q9vT6DWYglLz8vVUqc1xSkVACkNKM0D24QLKFcYpSVEuZlZGBgEOIpSC3KzSxBlX/F
  KM7BqCTMmwkyhSczrwRu3yugU5iATrmufgbklJJEhJRUA6N1/BZ23YyamV6tn1cwvN4yX5nVz
  OZX39OtHEF/F3i/efEgecHjxT9EK2f+bP5Q9z3rnp/AWe/j7Ct2Xws632pjFBvZr5z9/auf+I
  oPqQnh3SI1Af8LN01Nypm+4+PBJ9GuFT+/3Oj97nQkcI7u7Tdx5oFnz+6e17S8Vf5ydwNnltM
  V7UfPbzoqsRRnJBpqMRcVJwIAubdTaCMDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-7.tower-365.messagelabs.com!1540204408!974579!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32006 invoked from network); 22 Oct 2018 10:33:30 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-7.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Oct 2018 10:33:30 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct 2018
 05:33:28 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 22 Oct
 2018 05:33:28 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Oct 2018 12:33:26 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH 1/2] ARM: dts: ccimx6ulsbcpro: Add support for AUO G101EVN010 display
Date:   Mon, 22 Oct 2018 12:33:18 +0200
Message-ID: <1540204399-12982-2-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
References: <1540204399-12982-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index 11966d12af76..ac9ae4ac77ba 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -111,7 +111,32 @@
 		     &pinctrl_lcdif_clken
 		     &pinctrl_lcdif_hvsync>;
 	lcd-supply = <&ldo4_ext>;       /* BU90T82 LVDS bridge power */
+	display = <&g101evn010>;
 	status = "okay";
+
+	g101evn010: display@0 {
+		bits-per-pixel = <16>;
+		bus-width = <18>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <68930000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hfront-porch = <120>;
+				hback-porch = <0>;
+				hsync-len = <8>;
+				vback-porch = <10>;
+				vfront-porch = <0>;
+				vsync-len = <6>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
 };
 
 &ldo4_ext {
