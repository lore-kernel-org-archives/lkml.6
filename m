Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04096C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14B620989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HwwT/jZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfA3Na0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:30:26 -0500
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:4416
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfA3NaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+44zd2N88E7g372vp7/pGqImutQ9Of5DsUkkVHJSAUM=;
 b=HwwT/jZlOPG4YQ2yizq4ICIseOWbxJG5/9dhVd3/0ZzTzsJEmRctOn/gHJQMo/xkkKMiU7u+NapemFurlxhhekDWLJWdy0ixetcNi/MPSocM942AJc/HhrmBCQz+ZZyy7UIy1ClU+/ObOlO/Yp9FJHARZlF6fjsL20kN2Zpq9LA=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3805.eurprd04.prod.outlook.com (52.134.16.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 13:30:22 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:30:22 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3] firmware: imx: Add support to start/stop a CPU
Thread-Topic: [PATCH v3] firmware: imx: Add support to start/stop a CPU
Thread-Index: AQHUuJ/zljwGGsgqVEqW1pCa+zHOeA==
Date:   Wed, 30 Jan 2019 13:30:22 +0000
Message-ID: <20190130133005.5732-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::16) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3805;6:hEAbz7+LBFeqVrtlmf5sapoD45lqWWgqXFdw99lQNGFLSkS5zIy4nNNdb+OejPN8V/PPpiIqe9r0Y+gZHh0QTnfDTNszztyZ2KaVlJfaR8LjUIp4SNkfHo5emJEdwanfx/ohMAjxBdGFo63ofA510phPsPNIV0ge9wO4LGDilQs0beFJPpgXu9pDs0wAMlVTEAHGRZDKwH2B6/ZfhFivezBS2sYPXnKE046vgGvDGc/XrSPxB5RL5Kb0mzpkd6yqMrswjlRqulne95cc8wQeVB35kCKlXfKbwwaxR+UCCRJjyrDKWknTnvsjdcF+twECqiiEv1daKFnuUyEhfV566OueupRyvrHgddE1EjuG0KrIB2UvrdVuAUf5s796uklinF1WAWiaFUCAQ4KWAb3MSH9fhWaJ8Nehtuj4eW/ammqvhrkX3N4+liVW71WGLUq3zwkwy3AemD61cQrAe7jXjg==;5:Y5933ZQEISt/aIxLlWE00aQruaf8natQ4QtLy28jeO95warjj6sf9ZNptR8CPC4PypnC3fyBeIb9fg6sOJvhehBvPVlepanzKyTHuDyl1aIzOgKrKtkEhnZjy3lK0sCuQ7MpWwH9Hjoqu07LV62S+/e/tFePnFJij4qFw/ZnC095aFxRTbthsXQP5HVr1hawN7qcSZ9D2glBnwutS1j9/A==;7:noBQ2hheIFc6bN7SsQiAmaMBeTJB6p+bJxhRBcshlhq4Fi4Jdv96RadPEyNcKvw3U/jPVe5gB6baogYWSQuVTO7S9hIqaGLe9M2pi/vFUy9vqRMtIpxnbeE/Y02sdApdq64foDrkooTjyvUVB9lMvQ==
x-ms-office365-filtering-correlation-id: 154e7b1c-0d1e-499a-fbdd-08d686b71584
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3805;
x-ms-traffictypediagnostic: VI1PR0402MB3805:
x-microsoft-antispam-prvs: <VI1PR0402MB38050B7DA8F552B227EF7254F9900@VI1PR0402MB3805.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(5640700003)(97736004)(478600001)(106356001)(6116002)(3846002)(6486002)(105586002)(7736002)(25786009)(8676002)(305945005)(2906002)(66066001)(1730700003)(8936002)(81166006)(81156014)(14454004)(6436002)(6512007)(4326008)(50226002)(68736007)(2501003)(2616005)(54906003)(86362001)(186003)(39060400002)(99286004)(26005)(6506007)(52116002)(71190400001)(256004)(102836004)(476003)(36756003)(71200400001)(486006)(2351001)(1076003)(386003)(316002)(44832011)(6916009)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3805;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RpbCOVrMfi29AyMpN5pgt5ZHHvXYDuAfBKV2C6xG0c9Qtn1yncs/m7MGVJ+9qUpjy2lNw/zchm86M9QXagT7oFJAtHtSCJ7QIYvfZwHZyu3BmgjjI0dlsSwBTLA6C/Z7ZXyBAUCsH0+LRG/j+6zVFf02g4+jTT/2Eeek4bAqO1y3W1K3BYEeaim38nSHI6EKdqPBS7mrkvwCKk6BELetIOdELZqD4TKd4qXAGxbdCtxe8SMz7scE7YTAWqruR0mo0RseHfOfmf+pYLQidm+i/9n8pnqK6g9e/cOkCy/tlGqvtT6ECWqqUZOJ3y1UY1qDGqMKLOgCbG1pd4ozW+3V515sHKk2zA9b89FKQi0uhjOYnyT1JwQlxaxD68vox1WfN9X4h870tpyipeGj+il0IA5Qy1s7toB8egCMOv5Ly3o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154e7b1c-0d1e-499a-fbdd-08d686b71584
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:30:21.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is done via RPC call to SCU.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v2: (as per Aisheng's review)
	- rename address with phys_address
	- remove unnecessary uint8_t cast
	- use 'true' as last parameter of imx_scu_call_rpc to actually
	wait for a response from SCU.

 drivers/firmware/imx/misc.c           | 38 +++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/misc.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
index 97f5424dbac9..4b56a587dacd 100644
--- a/drivers/firmware/imx/misc.c
+++ b/drivers/firmware/imx/misc.c
@@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
 	u16 resource;
 } __packed;
=20
+struct imx_sc_msg_req_cpu_start {
+	struct imx_sc_rpc_msg hdr;
+	u32 address_hi;
+	u32 address_lo;
+	u16 resource;
+	u8 enable;
+} __packed;
+
 struct imx_sc_msg_req_misc_get_ctrl {
 	struct imx_sc_rpc_msg hdr;
 	u32 ctrl;
@@ -97,3 +105,33 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32=
 resource,
 	return 0;
 }
 EXPORT_SYMBOL(imx_sc_misc_get_control);
+
+/*
+ * This function starts/stops a CPU identified by @resource
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource the control is associated with
+ * @param[in]     enable      true for start, false for stop
+ * @param[in]     phys_addr   initial instruction address to be executed
+ *
+ * @return Returns 0 for success and < 0 for errors.
+ */
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 phys_addr)
+{
+	struct imx_sc_msg_req_cpu_start msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_PM;
+	hdr->func =3D IMX_SC_PM_FUNC_CPU_START;
+	hdr->size =3D 4;
+
+	msg.address_hi =3D phys_addr >> 32;
+	msg.address_lo =3D phys_addr;
+	msg.resource =3D resource;
+	msg.enable =3D enable;
+
+	return imx_scu_call_rpc(ipc, &msg, true);
+}
+EXPORT_SYMBOL(imx_sc_pm_cpu_start);
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware=
/imx/svc/misc.h
index e21c49aba92f..031dd4d3c766 100644
--- a/include/linux/firmware/imx/svc/misc.h
+++ b/include/linux/firmware/imx/svc/misc.h
@@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 r=
esource,
 int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 			    u8 ctrl, u32 *val);
=20
+int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
+			bool enable, u64 phys_addr);
+
 #endif /* _SC_MISC_API_H */
--=20
2.17.1

