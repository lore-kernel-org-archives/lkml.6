Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00940C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC44F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mr3omYuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC44F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeKQEJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:09:11 -0500
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:27157
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbeKQEJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mAjRe4Z35tN1W2NbyApsJotGysNbkUrhpUNupym72g=;
 b=mr3omYuk00ruC1geJiE7jmeB1TX45kGsC3YYsZnH57MkWUIiy9yJQahI2/p9C9qkVvcP55gdgBT8Xrw/1SAXMBTk8LJC8bhNYU51HtRqLPQXhYdzZ0prBWkX+r9c+DFlWjBKuCk5eXKDeLiIxBl6WgZifNk+jhiZVkGBwd/VYdU=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3712.eurprd04.prod.outlook.com (52.134.15.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Fri, 16 Nov 2018 17:55:40 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 17:55:40 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 1/4] bus: fsl-mc: move fsl_mc_command struct in a uapi
 header
Thread-Topic: [PATCH v2 1/4] bus: fsl-mc: move fsl_mc_command struct in a uapi
 header
Thread-Index: AQHUfdWW5MmYQT8qGU2eb0rNL23dnA==
Date:   Fri, 16 Nov 2018 17:55:40 +0000
Message-ID: <1542390890-3270-2-git-send-email-ioana.ciornei@nxp.com>
References: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::49) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3712;6:TkHpZkq702KlVO8VF/E2Zl5NPtgN1rCjkUszsYPcz0UuDG59DiMcVtzESo/3ISZjL5D8U5UjEdqAty3IbfOAM/SLSi6hVLgOI0ShzMq7eCvpyQoSkVEzACbRjmUBSUgcLhuY+qeamf+pE+ohC7fgsEP3y3XTay3sHjCjWslp/zT0W34r5EOtnLBiwBScDchDiWrQVcv8tl4rGTnysHVr/w4Sl8WwFbwutxMYYa67HGuwha5YBXLznpwFFBHRKNKBEN9/Wu8Vn4V2JdarcfDQwGHEqKRwnwQn3dEyGp1L+gXAGOoSKN+bdBP4qzX1093EsH3UoDjd0yxe11xCffTqYcW/EGDV9/CAIPNfrHRD9U0/3w2c+smkzPnCdKoDxPOHjPDxVInccHWnc5GkEZdQuDagxj1Um9Qfbj8wtxqEQa0JY4fs0tABhsCdamgO4VIxDtU3y6ehf/hwnFsG+DA0VQ==;5:vh7azA6UTizzvKD9T2NrMtS3JhpxOjq9nZJl2othjYYm5fBDuCC/3U6Ba1VLhavGj37ZL6h3sal30dDkBf+iMU/sOqpzdl4BVRmfG7nAIpyN+fm/AN3bdJQOaY7PWfJdqfY1mowyBnDbhBaxzeV9qY/pjPrnu9gpqbKaWx+SW8k=;7:5mrA4mawz+ybnCdmWnIjtrpPCfYjgR3tl2p48xpWvc+KyjRPUdsuEAz7xS1rmWYTkFCjmrJmw0VyUqJgI/RMXHxJ2zFJ+R5r50/gXuByFECg/IE/XLnaeTLvQkWguOlag3SDu9MhOSCK/+7VRE0Ejg==
x-ms-office365-filtering-correlation-id: a769619e-57f0-44fa-d45b-08d64becb8d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3712;
x-ms-traffictypediagnostic: VI1PR0402MB3712:
x-microsoft-antispam-prvs: <VI1PR0402MB37126E7A7670658DACDE42FFE0DD0@VI1PR0402MB3712.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3712;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3712;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(6486002)(71190400001)(71200400001)(25786009)(14454004)(6436002)(44832011)(6512007)(36756003)(2616005)(105586002)(99286004)(2906002)(68736007)(106356001)(478600001)(256004)(575784001)(86362001)(3846002)(54906003)(2501003)(8936002)(316002)(102836004)(26005)(5660300001)(52116002)(6116002)(386003)(97736004)(110136005)(6506007)(76176011)(305945005)(8676002)(6636002)(7736002)(81166006)(4326008)(81156014)(53936002)(2900100001)(476003)(11346002)(486006)(186003)(66066001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3712;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UvUGCbBeJLdbz9M1hm71Os0t9TKDHz7er9CODQnKwP5tnsqkK5RI2/l4hhp3fv1ZRKH/PAxxAC7sylSR79SYdn9JbR8oFtep6LCdZelvnSxvXXEDHPY6bOEYQAjvLWgT/eTopzwRyzhXuFMwTFi/RpoGcVCoRiNQ3BkN8G3OxNFwC9jwSemNDK38khMX0+bNI7ffZXaqSRLtreVEXEYiji1J+m9emOik7JK49quCUkvbvSz0BXiWV68SvUcVYVHxlgWEmuMdbVaYVOMOkLNb0mI2aEfOtty+hh6lEvAmErPIJuyY6uz5DyKvlPbiTwHEHGU3MIQycKyllWRIpvFxhlH8ctZVaN7Hq/TdyROLvyE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a769619e-57f0-44fa-d45b-08d64becb8d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 17:55:40.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3712
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

