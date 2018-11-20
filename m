Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017BC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B4E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OFnQ6w5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B4E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeKUCJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:09:33 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:58502
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbeKUCJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qolzIFWMmqhqEJ13MoBWlKD8aFLEm/w/LICD+6So+0=;
 b=OFnQ6w5eWs8tQGrGlwXu//ACi3Z9wYunc7n0x5XovN0mMYkDk8iN7dFumLumNK43XQYUvIHA99ruLutUkb67LOKJI5yu5I9mE7D9rB83I9Mk7hmg7x7W4gXOT+4ilSHyzNQAGkt/EmgtJfFzPdDQXJyL5sFehh/jlvmmRTO58Pw=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3501.eurprd04.prod.outlook.com (52.134.4.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 15:39:44 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Tue, 20 Nov 2018
 15:39:44 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 1/4] bus: fsl-mc: move fsl_mc_command struct in a uapi
 header
Thread-Topic: [PATCH v3 1/4] bus: fsl-mc: move fsl_mc_command struct in a uapi
 header
Thread-Index: AQHUgOdCV19djCicYU2ZFw+Lr5YttA==
Date:   Tue, 20 Nov 2018 15:39:44 +0000
Message-ID: <1542728371-6972-2-git-send-email-ioana.ciornei@nxp.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:800:90::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3501;6:1z0INavYRq26qVxKAKDnt7E/rDmFB7eXo5dXZ1RJubiNEByeAOVfEr1RvShMUIpu4nt3j2vq6P7tMjRL9rT3mLAI2fEMcZxoFKWFhL/Az/XIlRrqdZwh07FeIfolF5n3ym/M4JABG7KZ5/gnRnufjrnUuF8mWts0PdQpucNljkxNj4LSRF28wrYaD5bHP/xEOESY06xz/2Be9llIZ35B4VKlCVJuVNZ/cmTD1XQRmwycTC9Z23Zvh3P2v+ZK3FGzdsTENOZ1nLa5Ansub47yY4j1LvFpbyc24DKxAlZDENFnUlJ8KqG9w1Yg/KtShbf8o4L1fgBQ4NpwMPUaqxmniU3o7BOTs0/HNsuR86JM1n1qJvueEoufaEOUjUWTSDN1npvcRG+GsK6buWnOpigz++EhVXyyQjzyRT/K6nJ0G9IbwGVCoNAjJXznGWAm27yDDHm2ZVPUogblqwK7YzEJqQ==;5:vhNX6UswR+VLZZ1dc7bwD1/mXAmxCbW46pb5xO8EcdGB4UCNTDaLNxLbUHw/v3aRBJMbHHmp5en55WZC0QcPPdbWdQjjA3kndMlu5WM5sgnxx2SO3M+H3rT/auDQkNabPHpNNjkKZZ6y5FE0Nnz8FpFgXj6KL59O9emzpxxXOrA=;7:HKlp9kK/kgu1iUAWZLjiTFblbEvqYPCcY15jY/aHvyeqmiItOtmcBQKTTG1nv9ZU1QtZ+ZSfTvQeqvcM0qTxV1LS4mrh0ub/V5s1fTDf0jLdJZGDg8Rfcju+lCL6m9MDhGWJwPHW3zuEY+QYOjhIgA==
x-ms-office365-filtering-correlation-id: c1aba6e9-8327-4c4d-c28f-08d64efe64d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3501;
x-ms-traffictypediagnostic: VI1PR0402MB3501:
x-microsoft-antispam-prvs: <VI1PR0402MB3501D7E87BD47AADBC93C26FE0D90@VI1PR0402MB3501.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3501;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3501;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(2906002)(97736004)(256004)(102836004)(2900100001)(71190400001)(2616005)(11346002)(71200400001)(52116002)(44832011)(6436002)(478600001)(186003)(26005)(68736007)(76176011)(4326008)(99286004)(486006)(2501003)(6636002)(6512007)(316002)(6116002)(7736002)(3846002)(6506007)(54906003)(110136005)(8936002)(476003)(5660300001)(86362001)(575784001)(6486002)(305945005)(66066001)(53936002)(36756003)(14454004)(446003)(81166006)(8676002)(81156014)(386003)(106356001)(105586002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3501;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oQYkrgvt5d4y2OJjvQBUQmSPcITd2AU9VFgR0W7QQFQEVAwXdvHKClCglSN5JhUNtF3uuJmi7NnZcgRoXyf16M64tfdgzD6YajQ/Zn+l6YLA5hn1wv3uq5FgeZPAYEDLHi70Tu/jo3hT2t7Y9u5JSxxb7FfAVdEjUMkx6IuSYgRIFVIvvJPxF+LPMyIONehzocFMdpZqrTNbgqmKoT8ryUkByhy/AIpqYNaEs3w88DROuJO58PI2hG1g2B+gds9fluBPYwXCkedW9GKLmqqI7Psjme7+SveOc25IFZHqJ7TbQlsoLMuqjPidPC18dxlY+/Cd02A5WPqRxqy0iggPAXW2iGwG1viLFht4C4opZLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aba6e9-8327-4c4d-c28f-08d64efe64d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 15:39:44.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define "struct fsl_mc_command" as a structure that can cross the
user/kernel boundary.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - none
Changes in v3:
  - none

 MAINTAINERS                 |  1 +
 include/linux/fsl/mc.h      |  8 +-------
 include/uapi/linux/fsl_mc.h | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/fsl_mc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..e841cc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12282,6 +12282,7 @@ S:	Maintained
 F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/dpaa2/overview.rst
+F:	include/uapi/linux/fsl_mc.h
=20
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 741f567..64fc9f8 100644
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

