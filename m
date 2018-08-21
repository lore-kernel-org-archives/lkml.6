Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E603C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BCA20896
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BCA20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHUPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:48:24 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:18776 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbeHUPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:48:23 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id C2/31-19263-7650C7B5; Tue, 21 Aug 2018 12:28:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRWlGSWpSXmKPExsUSt3OpsW46a02
  0wd+TIhbzj5xjtWhevJ7N4s3x6UwWXat3slhcO9bLZHF51xw2i0XLWpktniw8w2Sx9PpFJovW
  vUfYHbg81sxbw+ixaVUnm8e8k4Ee++euYffY+G4Hk8f7fVfZPHZ+b2D3+LxJLoAjijUzLym/I
  oE1Y/v286wFDwQr+lcfY2lg/M/XxcjFISSwnlHi4fnrTF2MnEBOhcS31TtZQWxegUyJSzMnMo
  LYnALuEg8eLWSEqHGTuLz5JDuIzSZgITH5xAM2EJtFQFXi4oMJLCC2sECsxNI/79lBFogITGK
  SuHHvKdhQZoEGRomlO9wgFghKnJz5hAUiLiFx8MULZogFBhKnFzSCxSUE7CWmv78KFOcAsvUl
  Go/FQoQNJb7P+gZVYi5xZNt9tgmMgrOQTJ2FZOoCRqZVjOZJRZnpGSW5iZk5uoYGBrqGhka6h
  pbGukbGeolVuol6qaW65anFJbqGeonlxXrFlbnJOSl6eaklmxiBkcUABDsYz3xLPsQoycGkJM
  p7Lq06WogvKT+lMiOxOCO+qDQntfgQowwHh5IEby5LTbSQYFFqempFWmYOMMZh0hIcPEoivKE
  gad7igsTc4sx0iNQpRkuObw+6JzFzzDs6FUj+eQ8khVjy8vNSpcR5l4A0CIA0ZJTmwY2DpaFL
  jLJSwryMQAcK8RSkFuVmlqDKv2IU52BUEuadCjKFJzOvBG7rK6CDmIAOYmerBDmoJBEhJdXAm
  LXv0A2L270aKTPnFq48L8HKqpO6ZG5UrP2dAMt/XK/KVyx5pdc3tSxr1dbOvX8M0vOkWssXnb
  +Q9ak35PMxEY2Ny/kcQ5uCN51L/6kxO2z12fZXPpO3b9i4rdiB7WOZsgyzYGNkUmhiNfubuk+
  N2g5z9Gb0rL7H/mN1J/+miJKjByI+XSssU2Ipzkg01GIuKk4EAJVzpOc+AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-24.tower-268.messagelabs.com!1534854502!5799296!3
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12401 invoked from network); 21 Aug 2018 12:28:23 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-24.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 21 Aug 2018 12:28:23 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Tue, 21 Aug 2018 13:28:22 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 3D40D3FBC6; Tue, 21 Aug 2018 13:28:22 +0100 (BST)
Message-ID: <6472fd66d20df31165f9645eb49f4f30a0a51468.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1534853047.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 21 Aug 2018 13:28:22 +0100
Subject: [PATCH 2/3] dt-bindings: usb: fusb302: Use usb-connector bindings for
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
X-KSE-Antivirus-Info: Clean, bases: 21/08/2018 10:54:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are now generic usb-connector bindings which can be used
to define a port controllers configuration for USB-PD, so device
specific bindings are no longer necessary.

This update deprecates 'fcs,operating-sink-microwatt', and references
the 'usb-connector' bindings instead to achieve the required port
config.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
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

