Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C2C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4032084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="odRMov8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4032084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeJEXqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:46:31 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:37568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728515AbeJEXqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taLyTTU6p6aX6fiJhylc41eg1676KTxn7puQ+Gq6u48=;
 b=odRMov8MJ9lgxlOHxwUp+0euT4uChBZFKECOC9IU95PNndOgdXbD/NYQi8eNJmC2YEdSIiArIH/afCoE+8wy0xszgT1/ELoyupeYkkgBO3ubNomvtCzpc3scdKiCghW62dRlFx9VJF31GgH83ndwEmcHaSDOK3FRcL2rNaSJDUc=
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com (10.165.45.135) by
 AM4PR0401MB1940.eurprd04.prod.outlook.com (10.166.130.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Fri, 5 Oct 2018 16:46:53 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72%7]) with mapi id 15.20.1207.018; Fri, 5 Oct 2018
 16:46:53 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/4] bus: fsl-mc: move fsl_mc_command struct in a uapi header
Thread-Topic: [PATCH 1/4] bus: fsl-mc: move fsl_mc_command struct in a uapi
 header
Thread-Index: AQHUXMsFdCkV89146EqV66+wLFhJ+w==
Date:   Fri, 5 Oct 2018 16:46:53 +0000
Message-ID: <4451dafc0622cc5d22fe732a792cb00bb52b8ab0.1538757337.git.ioana.ciornei@nxp.com>
References: <cover.1538757337.git.ioana.ciornei@nxp.com>
In-Reply-To: <cover.1538757337.git.ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0049.eurprd09.prod.outlook.com
 (2603:10a6:802:28::17) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:51::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1940;6:p1UUyBccC2qf3+XqkhDaqzjCufnff35N6BgoKzEaE/tXyZWeC3WPVuTT5186khZCtrY8VpR4jUDYZwvz9C/JV5Vmjqm1IypJnFd5YGaXRPCqd3VjRe2bFdYMiskL+4wyKFQR39I9xLmbtPDVlZZnO5NeAuQkOLpL4ltyAEz+CNCrna3Z++83UJ3W7Te3u6eGhKQ1lGv45Yjiq12P0wjftG12eLvAm6E6WS3VVmGwXkso6TAmWB9kom5o+VSMA755Pe9S8jAy9g4/qLxcJASTZLAXUWaksN5mYJoaEpHA20UwVNKFPhBbdcCH/mBT38VeCDGoX7Q7LCSxZYl+imKK4S639cx7ZBWP9OREgUtC6j+TV2F76zvJr1AxucZ+YwTop3JrzIMybp5a3Lxqq4qtJki4mwTFeKgPFDKjtUv6BA4eftFs4jK3qS/B1M5ijhQvqvOfWqE6RZQ9Jrnx9vwd2Q==;5:5ZAon71m6N2RmNt60xNdQwM0XTThcqwu054QVDAAo8u8n/XPpN+Xn0T9HBhuWsxvE00u+j7iPNn8hWgknekUPrzXodmz3zLtNlo9zs8aCMNY9c4pciVwoyyM8Ch6llPF/MMlRTuT4H4yjt54otjUAv3P99jzalNblYqbUcAqsp4=;7:EPK5T5LvDDDW25DTJ0Sq0gQCSDwofgyishpNnhWBjz0Lv6CRhNAskPfUXJapcZV3NVQr5464YzNaypsZ4AdWlHeDEaM3RrvZRlHNVWlC92eqP82HBW79UFl9C0HiU4V8QyOXTz7bxyPDRroSZE4/n2Un4wdVqYFc22AlIPDV2mr7MQQ+Hiktms+R3o4ufUjaFmu0z4lezPDw/+WE4w0KgC80IGPIDV8xAJN7N7aEappEHXZl9ScndgeYDwYwyWJD
x-ms-office365-filtering-correlation-id: b9bd2873-2ccf-4182-03c3-08d62ae2275e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1940;
x-ms-traffictypediagnostic: AM4PR0401MB1940:
x-microsoft-antispam-prvs: <AM4PR0401MB19402B3C74BC590DBF26DB44E0EB0@AM4PR0401MB1940.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM4PR0401MB1940;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1940;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(575784001)(97736004)(316002)(6512007)(6306002)(68736007)(53936002)(81166006)(11346002)(86362001)(8676002)(186003)(446003)(476003)(486006)(2616005)(44832011)(102836004)(5250100002)(8936002)(6436002)(81156014)(26005)(7736002)(305945005)(256004)(6486002)(2900100001)(2501003)(105586002)(966005)(106356001)(52116002)(6506007)(2906002)(99286004)(76176011)(71200400001)(71190400001)(54906003)(110136005)(14454004)(6116002)(3846002)(386003)(4326008)(25786009)(5660300001)(66066001)(118296001)(6636002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1940;H:AM4PR0401MB2354.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lhFnd+hKuuJ2HWz0HvZj7SiLHfbFXKGZ+WU7nrw/CWMESLi973KtQiMUCP7/f8dS+1/KfBp3/IADJxMWwtBL0ZyAUEUKND7bLxRmJAcUvuWM9WBV1uTM094X7oEiIjUOF76hrIEixSE4yZHe1K6XGjkeNm205bzlA/iEjrt4eq+fcXQAodvElx+K+Gc8Bh+t9IAPcpjgXjx57F6sne65Euway9S4UAmek4iYFN8ruT6fdqbAtdOxDgow0zdv684taC+auy6zoZLloBH4p99vd4qk8q9UAG+3RP8CP6Mu+4VczFHyhSYYfF0aK6HAzJofoHiuHACdufQq0/FBrx6HurQtJmnU+4VWl+/ogs6rMuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bd2873-2ccf-4182-03c3-08d62ae2275e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 16:46:53.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1940
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define "struct fsl_mc_command" as a structure that can cross the
user/kernel boundary.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Depends on:
 https://lkml.org/lkml/2018/10/2/593

 MAINTAINERS                 |  1 +
 include/linux/fsl/mc.h      |  8 +-------
 include/uapi/linux/fsl_mc.h | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/fsl_mc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b22e7fd..0ee7e17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12022,6 +12022,7 @@ S:	Maintained
 F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/dpaa2/overview.rst
+F:	include/uapi/linux/fsl_mc.h
=20
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 96c54bb..c015bed 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
+#include <uapi/linux/fsl_mc.h>
=20
 #define FSL_MC_VENDOR_FREESCALE	0x1957
=20
@@ -198,8 +199,6 @@ struct fsl_mc_device {
 #define to_fsl_mc_device(_dev) \
 	container_of(_dev, struct fsl_mc_device, dev)
=20
-#define MC_CMD_NUM_OF_PARAMS	7
-
 struct mc_cmd_header {
 	u8 src_id;
 	u8 flags_hw;
@@ -209,11 +208,6 @@ struct mc_cmd_header {
 	__le16 cmd_id;
 };
=20
-struct fsl_mc_command {
-	__le64 header;
-	__le64 params[MC_CMD_NUM_OF_PARAMS];
-};
-
 enum mc_cmd_status {
 	MC_CMD_STATUS_OK =3D 0x0, /* Completed successfully */
 	MC_CMD_STATUS_READY =3D 0x1, /* Ready to be processed */
diff --git a/include/uapi/linux/fsl_mc.h b/include/uapi/linux/fsl_mc.h
new file mode 100644
index 0000000..6c19cfc
--- /dev/null
+++ b/include/uapi/linux/fsl_mc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Management Complex (MC) userspace public interface
+ *
+ * Copyright 2018 NXP
+ *
+ */
+#ifndef _UAPI_FSL_MC_H_
+#define _UAPI_FSL_MC_H_
+
+#include <linux/types.h>
+
+#define MC_CMD_NUM_OF_PARAMS	7
+
+/**
+ * struct fsl_mc_command - Management Complex (MC) command structure
+ * @header: MC command header
+ * @params: MC command parameters
+ */
+struct fsl_mc_command {
+	__le64 header;
+	__le64 params[MC_CMD_NUM_OF_PARAMS];
+};
+
+#endif /* _UAPI_FSL_MC_H_ */
--=20
1.9.1

