Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17315C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C091C20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C091C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeIHCBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:01:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbeIHCBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:01:32 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13E45DC4;
        Fri,  7 Sep 2018 21:18:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.18 104/145] ARM: dts: am57xx-idk: Enable dual role for USB2 port
Date:   Fri,  7 Sep 2018 23:09:30 +0200
Message-Id: <20180907210912.370351752@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 5f3cc16483d40bbc609a828511ff851296fc62b6 upstream.

Dual-role support was added in v4.12. We should be using
it for USB2 port on the am57xx-idk.

Cc: <stable@vger.kernel.org>        [4.16+]
Reported-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am571x-idk.dts         |    4 ----
 arch/arm/boot/dts/am572x-idk-common.dtsi |    4 ----
 arch/arm/boot/dts/am57xx-idk-common.dtsi |    7 ++++++-
 3 files changed, 6 insertions(+), 9 deletions(-)

--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -66,10 +66,6 @@
 	};
 };
 
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &extcon_usb2 {
 	id-gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
 	vbus-gpio = <&gpio7 22 GPIO_ACTIVE_HIGH>;
--- a/arch/arm/boot/dts/am572x-idk-common.dtsi
+++ b/arch/arm/boot/dts/am572x-idk-common.dtsi
@@ -57,10 +57,6 @@
 	};
 };
 
-&omap_dwc3_2 {
-	extcon = <&extcon_usb2>;
-};
-
 &extcon_usb2 {
 	id-gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 	vbus-gpio = <&gpio3 26 GPIO_ACTIVE_HIGH>;
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -395,8 +395,13 @@
 	dr_mode = "host";
 };
 
+&omap_dwc3_2 {
+	extcon = <&extcon_usb2>;
+};
+
 &usb2 {
-	dr_mode = "peripheral";
+	extcon = <&extcon_usb2>;
+	dr_mode = "otg";
 };
 
 &mmc1 {


