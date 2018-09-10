Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6C1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5CA2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5CA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeIJRNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:13:38 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:54149 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728123AbeIJRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:13:16 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id D8/F9-12985-C41669B5; Mon, 10 Sep 2018 12:19:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRWlGSWpSXmKPExsUSt3Opsa5P4rR
  ogzPXNC3mHznHatG8eD2bxZvj05ksulbvZLG4dqyXyeLyrjlsFouWtTJbPFl4hsli6fWLTBat
  e4+wO3B5rJm3htFj06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXABHFGtmXlJ+R
  QJrRt/z16wF3UIVu7euZGlgXMbfxcjFISSwnlFiRedqli5GDiCnQmLJSv0uRk4OXoFMiZtzN7
  OA2JwC7hLvpp0As4UE3CSati5lBLHZBCwkJp94wAbSyiKgKvF0YwxIWFggVmLpn/fsIONFBCY
  xSdy495QVJMEs0MAosXSHG8R8QYmTM5+wQMQlJA6+eMEMMd9A4vSCRrC4hIC9xPT3V5lB5ksI
  6Es0HouFCBtKfJ/1DarEXGLm6nksExgFZyGZOgvJ1AWMTKsYLZOKMtMzSnITM3N0DQ0MdA0Nj
  XVNdA1NjPQSq3ST9FJLdZNT80qKEoGyeonlxXrFlbnJOSl6eaklmxiBkZVSyNK3g/Fje/ohRk
  kOJiVRXgnFadFCfEn5KZUZicUZ8UWlOanFhxhlODiUJHgjE4BygkWp6akVaZk5wBiHSUtw8Ci
  J8OaCpHmLCxJzizPTIVKnGC05vj3onsTMMe/oVCD55z2QFGLJy89LlRLnzQJpEABpyCjNgxsH
  S0OXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzrgeZwpOZVwK39RXQQUxAB607PwXkoJJEh
  JRUA6ODo8IJq9CXlza7VHtffP4hWOFmyhk1/pAOE6O6fO+fRbONZv9QjUmL2r/ZtrtBeoPVoQ
  DJxjoTPqMj0fxT2K/8vfVi9k+G/a9nz/7iO0le6vE/9/ZvkaXukgLsey+2y3p3ulmdOXlVcOZ
  aI61tBZK2u6UCM/b5v1+Z22FSEf3sTOQOlft1W5VYijMSDbWYi4oTARRjpeE+AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-239.messagelabs.com!1536581964!4704541!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25451 invoked from network); 10 Sep 2018 12:19:24 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-18.tower-239.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:19:24 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 10 Sep 2018 13:19:24 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 1CE8E3FBE8; Mon, 10 Sep 2018 13:19:24 +0100 (BST)
Message-ID: <552e94b9a1cf89069be7d36d6476d5df26970406.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 10 Sep 2018 13:19:24 +0100
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
X-KSE-Antivirus-Info: Clean, bases: 10/09/2018 11:14:00
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

