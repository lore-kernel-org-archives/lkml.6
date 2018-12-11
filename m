Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD422084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Nn/amUGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD422084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeLKOQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:16:29 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:5755 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbeLKOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1544537778; x=1576073778;
  h=from:to:cc:subject:date:message-id;
  bh=5a8oGUomlONxYXp5vnFXmGGsI+vXGPfLoQ0LOLOMbWc=;
  b=Nn/amUGFIZVw3WK201ep3/aNSelZCkg4VCRSrkJbB2IkDj/PdaJz9vpp
   smhZ2JvV0iyWq/Cx9+q0eEJVZQ6A8mzIPvpn6DhqFWXIRSz/WLiRxwo8n
   Qj5xAY0jMlWn+LkS7U1SiQss919Ce29fSgLkDJ6xO/OrjvGb8aJ2qfFJi
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GFAQBUxQ9chyWd50NlHQEBBQEHBQG?=
 =?us-ascii?q?BZYNsJ4xzizGDCZhRCwEBhGyCbyI4EgEDAQECAQECAQECEAEBAQoLCQgpL4I?=
 =?us-ascii?q?2JAGCZRYVUikmbxMign+CApkYPQKBEIlYAQEBgWoziiuHfIQ/gVc/gRGCXQe?=
 =?us-ascii?q?Bb4kbAok7hwGQPwcCgiIEjysCFpE/AZkMAgQCBAUCFIFdgXhwgzyCJwwCCY4?=
 =?us-ascii?q?8IQExi2gBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GFAQBUxQ9chyWd50NlHQEBBQEHBQGBZYNsJ4xzizGDC?=
 =?us-ascii?q?ZhRCwEBhGyCbyI4EgEDAQECAQECAQECEAEBAQoLCQgpL4I2JAGCZRYVUikmb?=
 =?us-ascii?q?xMign+CApkYPQKBEIlYAQEBgWoziiuHfIQ/gVc/gRGCXQeBb4kbAok7hwGQP?=
 =?us-ascii?q?wcCgiIEjysCFpE/AZkMAgQCBAUCFIFdgXhwgzyCJwwCCY48IQExi2gBAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Dec 2018 08:16:17 -0600
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBED4Vu056376;
        Tue, 11 Dec 2018 09:16:27 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2pab5q173m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 09:16:27 -0500
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Dec 2018 20:16:10 +0600
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.56,342,1539666000"; 
   d="scan'208";a="293934597"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        anthony.wong@canonical.com,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] r8152: Add support for MAC address pass through on RTL8153-BND
Date:   Tue, 11 Dec 2018 08:16:14 -0600
Message-Id: <1544537774-4370-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All previous docks and dongles that have supported this feature use
the RTL8153-AD chip.

RTL8153-BND is a new chip that will be used in upcoming Dell type-C docks.
It should be added to the whitelist of devices to activate MAC address
pass through.

Per confirming with Realtek all devices containing RTL8153-BND should
activate MAC pass through and there won't use pass through bit on efuse
like in RTL8153-AD.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/usb/r8152.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f1b5201..60dd1ec 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -129,6 +129,7 @@
 #define USB_UPS_CTRL		0xd800
 #define USB_POWER_CUT		0xd80a
 #define USB_MISC_0		0xd81a
+#define USB_MISC_1		0xd81f
 #define USB_AFE_CTRL2		0xd824
 #define USB_UPS_CFG		0xd842
 #define USB_UPS_FLAGS		0xd848
@@ -555,6 +556,7 @@ enum spd_duplex {
 
 /* MAC PASSTHRU */
 #define AD_MASK			0xfee0
+#define BND_MASK		0x0004
 #define EFUSE			0xcfdb
 #define PASS_THRU_MASK		0x1
 
@@ -1150,7 +1152,7 @@ static int rtl8152_set_mac_address(struct net_device *netdev, void *p)
 	return ret;
 }
 
-/* Devices containing RTL8153-AD can support a persistent
+/* Devices containing proper chips can support a persistent
  * host system provided MAC address.
  * Examples of this are Dell TB15 and Dell WD15 docks
  */
@@ -1165,13 +1167,23 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 
 	/* test for -AD variant of RTL8153 */
 	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
-	if ((ocp_data & AD_MASK) != 0x1000)
-		return -ENODEV;
-
-	/* test for MAC address pass-through bit */
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, EFUSE);
-	if ((ocp_data & PASS_THRU_MASK) != 1)
-		return -ENODEV;
+	if ((ocp_data & AD_MASK) == 0x1000) {
+		/* test for MAC address pass-through bit */
+		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, EFUSE);
+		if ((ocp_data & PASS_THRU_MASK) != 1) {
+			netif_dbg(tp, probe, tp->netdev,
+				  "No efuse for RTL8153-AD MAC pass through\n");
+			return -ENODEV;
+		}
+	} else {
+		/* test for RTL8153-BND */
+		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
+		if ((ocp_data & BND_MASK) == 0) {
+			netif_dbg(tp, probe, tp->netdev,
+				  "Invalid variant for MAC pass through\n");
+			return -ENODEV;
+		}
+	}
 
 	/* returns _AUXMAC_#AABBCCDDEEFF# */
 	status = acpi_evaluate_object(NULL, "\\_SB.AMAC", NULL, &buffer);
@@ -1217,9 +1229,8 @@ static int set_ethernet_addr(struct r8152 *tp)
 	if (tp->version == RTL_VER_01) {
 		ret = pla_ocp_read(tp, PLA_IDR, 8, sa.sa_data);
 	} else {
-		/* if this is not an RTL8153-AD, no eFuse mac pass thru set,
-		 * or system doesn't provide valid _SB.AMAC this will be
-		 * be expected to non-zero
+		/* if device doesn't support MAC pass through this will
+		 * be expected to be non-zero
 		 */
 		ret = vendor_mac_passthru_addr_read(tp, &sa);
 		if (ret < 0)
-- 
2.7.4

