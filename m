Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E5FC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D969F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D969F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeIJRSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:18:21 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.131]:29138 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728210AbeIJRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:18:19 -0400
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.eu-west-1.aws.symcld.net id 8E/FB-28791-B72669B5; Mon, 10 Sep 2018 12:24:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRWlGSWpSXmKPExsUSt3OpsW510rR
  og9MtGhbzj5xjtWhevJ7N4s3x6UwWXat3slhcO9bLZHF51xw2i0XLWpktniw8w2Sx9PpFJovW
  vUfYHbg81sxbw+ixaVUnm8e8k4Ee++euYffY+G4Hk8f7fVfZPHZ+b2D3+LxJLoAjijUzLym/I
  oE1o+/5a9aCbqGK3VtXsjQwLuPvYuTiEBJYzyjxdPJy5i5GTiCnQuL2kv9gNq9ApsTNuZtZQG
  xOAXeJd9NOsEDUuEk0bV3KCGKzCVhITD7xgA3EZhFQlZh9bDpYr7BAgsTls4tZQBaICExikrh
  x7ykrSIJZoIFRYukON4gFghInZz5hgYhLSBx88QLqCAOJ0wsaweISAvYS099fBYpzANn6Eo3H
  YiHChhLfZ32DKjGXmLl6HssERsFZSKbOQjJ1ASPTKkbzpKLM9IyS3MTMHF1DAwNdQ0MjXSMDI
  11TC73EKt1kvdRS3fLU4hJdQ73E8mK94src5JwUvbzUkk2MwMhKKThltYPx1Yr0Q4ySHExKor
  wSitOihfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwyiUC5QSLUtNTK9Iyc4AxDpOW4OBREuFVAkn
  zFhck5hZnpkOkTjFacnx70D2JmWPe0alA8s97ICnEkpeflyolzns3AahBAKQhozQPbhwsDV1i
  lJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMyrCrKWJzOvBG7rK6CDmIAOWnd+CshBJYkIKakGR
  t2EQ0GcVmsvmMy7/e3EDYPIXTvSurtLvGrO7bL+VlXaevBHQ8VTaaEIpvCe/awHnq6rO2RxQr
  7Ef01LBduWtd7PHn88PmP11zmZdyw07K8nF4S1fjZ+c2ZKV93Lfc9+G4jMuee4cN7WFQLL5n0
  N3/iDfZX9STavz88M3+43zZPjuLZ/AWtaiqYSS3FGoqEWc1FxIgDmuRdIPgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-9.tower-308.messagelabs.com!1536582267!7045463!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11378 invoked from network); 10 Sep 2018 12:24:27 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-9.tower-308.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:24:27 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 10 Sep 2018 13:24:27 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 0A6FC3FBE8; Mon, 10 Sep 2018 13:24:27 +0100 (BST)
Message-ID:
 <552e94b9a1cf89069be7d36d6476d5df26970406.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 10 Sep 2018 13:24:27 +0100
Subject: [PATCH v2 2/3] dt-bindings: usb: fusb302: Use usb-connector bindings for
 configuration
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/09/2018 11:14:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180910122427.5U-v6WVatBPL7HT3NAln3NYA6wZTAlu6TqYG9c1-Gug@z>

There are now generic usb-connector bindings which can be used
to define a port controllers configuration for USB-PD, so device
specific bindings are no longer necessary.

This update deprecates 'fcs,operating-sink-microwatt', and references
the 'usb-connector' bindings instead to achieve the required port
config.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/fcs,fusb302.txt        | 32 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
index 6087dc7..a5d011d 100644
--- a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
+++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
@@ -5,10 +5,19 @@ Required properties :
 - reg                    : I2C slave address
 - interrupts             : Interrupt specifier
 
-Optional properties :
-- fcs,operating-sink-microwatt :
-			   Minimum amount of power accepted from a sink
-			   when negotiating
+Required sub-node:
+- connector : The "usb-c-connector" attached to the FUSB302 IC. The bindings
+  of the connector node are specified in:
+
+	Documentation/devicetree/bindings/connector/usb-connector.txt
+
+Deprecated properties :
+- fcs,max-sink-microvolt : Maximum sink voltage accepted by port controller
+- fcs,max-sink-microamp : Maximum sink current accepted by port controller
+- fcs,max-sink-microwatt : Maximum sink power accepted by port controller
+- fcs,operating-sink-microwatt : Minimum amount of power accepted from a sink
+  when negotiating
+
 
 Example:
 
@@ -17,7 +26,16 @@ fusb302: typec-portc@54 {
 	reg = <0x54>;
 	interrupt-parent = <&nmi_intc>;
 	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-	fcs,max-sink-microvolt = <12000000>;
-	fcs,max-sink-microamp = <3000000>;
-	fcs,max-sink-microwatt = <36000000>;
+
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		power-role = "dual";
+		try-power-role = "sink";
+		source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+		sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(3000, 12000, 3000)
+			     PDO_PPS_APDO(3000, 11000, 3000)>;
+		op-sink-microwatt = <10000000>;
+	};
 };
-- 
1.9.1

