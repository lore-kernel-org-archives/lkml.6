Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC89C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCCE20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCCE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeIJRSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:18:35 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:10844 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728493AbeIJRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:18:21 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.eu-west-1.aws.symcld.net id 1D/F5-19953-C72669B5; Mon, 10 Sep 2018 12:24:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsUSt3OpsW510rR
  og7nzmS3mHznHatG8eD2bxZvj05ksulbvZLG4dqyXyeLyrjlsFouWtTJbPFl4hsli6fWLTBat
  e4+wO3B5rJm3htFj06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXABHFGtmXlJ+R
  QJrxuoJ81gKDkpVPF5/mbGB8ZVYFyMXh5DAekaJU5MXsXQxcgI5FRLXJj1mArF5BTIlOjetYw
  axOQXcJd5NOwFV4ybRtHUpI4jNJmAhMfnEAzYQm0VAVeLXjGdgcWGBWIktSyexgiwQEZjEJHH
  j3lNWkASzQAOjxNIdbhALBCVOznzCAhGXkDj44gUzxAIDidMLGsHiEgL2EtPfXwWKcwDZ+hKN
  x2IhwoYS32d9gyoxl5i5eh7LBEbBWUimzkIydQEj0ypG86SizPSMktzEzBxdQwMDXUNDI10jA
  yNdUwu9xCrdZL3UUt3y1OISXUO9xPJiveLK3OScFL281JJNjMDISik4ZbWD8dWK9EOMkhxMSq
  K8EorTooX4kvJTKjMSizPii0pzUosPMcpwcChJ8MolAuUEi1LTUyvSMnOAMQ6TluDgURLhVQJ
  J8xYXJOYWZ6ZDpE4x6nL8eT91ErMQS15+XqqUOO/dBKAiAZCijNI8uBGwdHOJUVZKmJeRgYFB
  iKcgtSg3swRV/hWjOAejkjCvKsgqnsy8ErhNr4COYAI6Yt35KSBHlCQipKQaGPtNmQs+Lezpm
  vtpec12wzNujhMPlSrP2bexw/hC+/pruvwbHln9MGoyldNZz7t+q/Kl04/aF6Vwnai62vfdzf
  jLxV7Lb5arf94IL+Qp8hd+Lx4kPufvzMu2Hmc/HYjTrVE4alObvuiUsUe3/2IZq4tv+46/4OV
  3tb3d/27S6TfrZhjEdblp9yixFGckGmoxFxUnAgBf22qxMgMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-16.tower-302.messagelabs.com!1536582266!6971157!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5464 invoked from network); 10 Sep 2018 12:24:26 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-16.tower-302.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:24:26 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 10 Sep 2018 13:24:25 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 0732B3FB9E; Mon, 10 Sep 2018 13:24:26 +0100 (BST)
Message-ID:
 <b98c58ca3681d18f44359431a1ccec2fa34023d1.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 10 Sep 2018 13:24:26 +0100
Subject: [PATCH v2 1/3] dt-bindings: connector: Add support for USB-PD PPS APDOs
 to bindings
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
Message-ID: <20180910122426.yG1aZIx2Tb7rjGiFPxlbkIreQf32UYKnX0z_l1idYGo@z>

Add support for PPS APDOs to connector bindings so a port controller
can specify support for PPS, as per existing FIXED/BATT/VAR PDOs.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/connector/usb-connector.txt           |  8 +++----
 include/dt-bindings/usb/pd.h                       | 26 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index 8855bfc..d90e17e 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -29,15 +29,15 @@ Required properties for usb-c-connector with power delivery support:
   in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
   Source_Capabilities Message, the order of each entry(PDO) should follow
   the PD spec chapter 6.4.1. Required for power source and power dual role.
-  User can specify the source PDO array via PDO_FIXED/BATT/VAR() defined in
-  dt-bindings/usb/pd.h.
+  User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
+  defined in dt-bindings/usb/pd.h.
 - sink-pdos: An array of u32 with each entry providing supported power
   sink data object(PDO), the detailed bit definitions of PDO can be found
   in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
   Sink Capabilities Message, the order of each entry(PDO) should follow
   the PD spec chapter 6.4.1. Required for power sink and power dual role.
-  User can specify the sink PDO array via PDO_FIXED/BATT/VAR() defined in
-  dt-bindings/usb/pd.h.
+  User can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+  in dt-bindings/usb/pd.h.
 - op-sink-microwatt: Sink required operating power in microwatt, if source
   can't offer the power, Capability Mismatch is set. Required for power
   sink and power dual role.
diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index 7b7a92f..985f2bb 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -59,4 +59,30 @@
 	(PDO_TYPE(PDO_TYPE_VAR) | PDO_VAR_MIN_VOLT(min_mv) |	\
 	 PDO_VAR_MAX_VOLT(max_mv) | PDO_VAR_MAX_CURR(max_ma))
 
+#define APDO_TYPE_PPS		0
+
+#define PDO_APDO_TYPE_SHIFT	28	/* Only valid value currently is 0x0 - PPS */
+#define PDO_APDO_TYPE_MASK	0x3
+
+#define PDO_APDO_TYPE(t)	((t) << PDO_APDO_TYPE_SHIFT)
+
+#define PDO_PPS_APDO_MAX_VOLT_SHIFT	17	/* 100mV units */
+#define PDO_PPS_APDO_MIN_VOLT_SHIFT	8	/* 100mV units */
+#define PDO_PPS_APDO_MAX_CURR_SHIFT	0	/* 50mA units */
+
+#define PDO_PPS_APDO_VOLT_MASK	0xff
+#define PDO_PPS_APDO_CURR_MASK	0x7f
+
+#define PDO_PPS_APDO_MIN_VOLT(mv)	\
+	((((mv) / 100) & PDO_PPS_APDO_VOLT_MASK) << PDO_PPS_APDO_MIN_VOLT_SHIFT)
+#define PDO_PPS_APDO_MAX_VOLT(mv)	\
+	((((mv) / 100) & PDO_PPS_APDO_VOLT_MASK) << PDO_PPS_APDO_MAX_VOLT_SHIFT)
+#define PDO_PPS_APDO_MAX_CURR(ma)	\
+	((((ma) / 50) & PDO_PPS_APDO_CURR_MASK) << PDO_PPS_APDO_MAX_CURR_SHIFT)
+
+#define PDO_PPS_APDO(min_mv, max_mv, max_ma)					\
+	(PDO_TYPE(PDO_TYPE_APDO) | PDO_APDO_TYPE(APDO_TYPE_PPS) |		\
+	 PDO_PPS_APDO_MIN_VOLT(min_mv) | PDO_PPS_APDO_MAX_VOLT(max_mv) |	\
+	 PDO_PPS_APDO_MAX_CURR(max_ma))
+
  #endif /* __DT_POWER_DELIVERY_H */
-- 
1.9.1

