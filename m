Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D0ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AD2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0AD2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJYXnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:43:03 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:57896 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbeJYXnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:43:01 -0400
Received: from [67.219.246.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id A0/53-08438-DBCD1DB5; Thu, 25 Oct 2018 15:09:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRWlGSWpSXmKPExsXi5LtOQHfPnYv
  RBjP3mVr0njvJZDH/yDlWiytf37NZbNx8m8Vi1dSdLBabHl9jtej6tZLZ4vKuOWwWS69fZLJo
  3XuE3eLv9k0sFi+2iFv83DWPxYHXY828NYweO2fdZffYtKqTzWP7twesHve7jzN5bF5S77Hx3
  Q4mj/6/Bh6fN8kFcEaxZuYl5VcksGb0nZvMUnCTo+LiwtvsDYwL2LsYuTiEBFYzSjQfPMEK4a
  xhlNjTtxsqs4VRYtPXCUxdjJwcbAI6ElP2H2YBsUUEciV2P94B1sEsMIVJ4vS3XWwgCWGBYIl
  vl26wg9gsAqoShy9eZQSxeQXcJG5f3cwMYksIyEncPNcJZnMKuEtcmTqfFcQWAqpZcOkfO0S9
  oMTJmU/AljELSEgcfPGCGaJGWWLLiguMEHMUJNYeOM80gVFgFpKWWUhaFjAyrWI0SyrKTM8oy
  U3MzNE1NDDQNTQ00jUGsoz0Eqt0k/RKi3VTE4tLdA31EsuL9Yorc5NzUvTyUks2MQIjLaWAOW
  0H49X29EOMkhxMSqK8iSkXo4X4kvJTKjMSizPii0pzUosPMcpwcChJ8CbdBsoJFqWmp1akZeY
  AYx4mLcHBoyTCGwaS5i0uSMwtzkyHSJ1iVJQS5+UGSQiAJDJK8+DaYGnmEqOslDAvIwMDgxBP
  QWpRbmYJqvwrRnEORiVh3iUgU3gy80rgpr8CWswEtHiGwgWQxSWJCCmpBkbHm7JKZpv21RSaW
  126o/e3952dS//aKfOOTXrMcNprwcLu1uOr5tZ93CLavKJ2/tLQJx7JV05e9nmXv+9inOuSxu
  kf1sWzvyzVeNip581fXcEqemTZ9blOmixLrm6SqddJ+bXCr8nh1O8Lxye8sbgV/2DJj+Botke
  B7V/XHky69TlGuftP3c14JZbijERDLeai4kQAAsRX+i4DAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-23.tower-385.messagelabs.com!1540480188!1321267!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28992 invoked from network); 25 Oct 2018 15:09:48 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-23.tower-385.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Oct 2018 15:09:48 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct 2018
 10:09:48 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH03.digi.com
 (10.10.8.197) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct
 2018 10:09:47 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 25 Oct 2018 17:09:46 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v1 2/4] ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif panel
Date:   Thu, 25 Oct 2018 17:09:31 +0200
Message-ID: <1540480173-12009-3-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for the AUO G101EVN010 lcdif panel for the
mxsfb DRM driver.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index 11966d12af76..f6e6b2cf780b 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -24,6 +24,18 @@
 		status = "okay";
 	};
 
+	panel {
+		compatible = "auo,g101evn010", "simple-panel";
+		power-supply = <&ldo4_ext>;
+		backlight = <&lcd_backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+
 	reg_usb_otg1_vbus: regulator-usb-otg1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
@@ -112,6 +124,12 @@
 		     &pinctrl_lcdif_hvsync>;
 	lcd-supply = <&ldo4_ext>;       /* BU90T82 LVDS bridge power */
 	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 };
 
 &ldo4_ext {
