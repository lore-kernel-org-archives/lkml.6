Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09032089F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R6Cepmj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405326AbfBNDow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:44:52 -0500
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:55461
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391237AbfBNDou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDCwze7MSZ/0VU4jDuhIzch9cw/tNFuydaj2r0ScsoA=;
 b=R6Cepmj76lRPTBD/W97uPfGUn5sQKWj1ogyKY9xaRGfNdgBcHRrzagjtkxLrqrWl/FHUMPO91OvYs2tXWBDtwFL8p+YY7bNtyU5L3th5w9N+XWko3ITv7sTAZ6VMiyVH2DoTuNTheEpIv3tbY7NyzccM8nYtCGKpmkjFy48ahqU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 03:44:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 03:44:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V2 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHUxBeY1ru6LM154k6AIjlXsKZZtA==
Date:   Thu, 14 Feb 2019 03:44:31 +0000
Message-ID: <1550115535-14488-3-git-send-email-Anson.Huang@nxp.com>
References: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 380b0b78-e477-4849-e53b-08d6922eba4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3659;23:pWUaDS72ji8SLC7HohfkmRlvBcU0VXpmcX+t9?=
 =?iso-8859-1?Q?9WLnyYTgve7vgHj2BGAbDFt2kcjD6fa8MU3yeKzDEfKpjFf7M3pAXsGQuy?=
 =?iso-8859-1?Q?mD30DOPf4uHfGlSTeKuDaHWZrMsVvqyHEEMGdA+x2m2lfakeW7Kmyxkb1k?=
 =?iso-8859-1?Q?lxopMQ1CFNBmiOyjXMXnFixWR9mGS/LEMFjMN21q9NkVtYCM9OOvp2xz11?=
 =?iso-8859-1?Q?qWsQl/jPfs63iXfODsWGMsOyy1yeSXnDbR/WsEcRt3SWBvZ1w9WEVdFMiH?=
 =?iso-8859-1?Q?vZP84teAZjeXevkbCpHTUYx+IHkfwReMuW2bC39oNtlQ7TWwMaCjElJ3Cy?=
 =?iso-8859-1?Q?c9EaGGsUUhmjN0WzDSp/MKxPjkylcNtMxmjcBdPKYPOCoVjfd5zYOYAPar?=
 =?iso-8859-1?Q?OJiDF0OzDAHWYnPCIx4N8SPn3PGiDffJEVYFAK8TN1SNT4jUpg5IIsUO3A?=
 =?iso-8859-1?Q?H0vVTe1vCmx+/G8+cLKWIu2RvOHsPXqSSH/cUq7qgParuE8zapGGTh8nfV?=
 =?iso-8859-1?Q?o5/r/f97ikviOOOvToi1C8+NpkIKSxO17aEg63PoxJ7MzEdfM90JfAABHV?=
 =?iso-8859-1?Q?WF8JFcb+XS+gPomB2xt02U2MtUBBb0utjSMJdls6GNe4DwbjpcviLUI0jL?=
 =?iso-8859-1?Q?/v22TJftN9Z0rXZ0EvAL4vN/niyAVeKIbnMW54U95tUvVrKPXyajQ/vxgN?=
 =?iso-8859-1?Q?+EdU775N4b/s+CqQCNmWRkIx7gD0TaayvGiCT4ABgWVMP57DXoneOCTrv8?=
 =?iso-8859-1?Q?KHmBCd8uRUnsmefy2xKVYK2IKA7FI/HoloV+A0DdkY4XrJxJx6Kt85w8x2?=
 =?iso-8859-1?Q?8NXUAAoj4XGqg/bmBPpZu2e9TmPz7v98hToNbRddKugIcdz9XzJQikNh81?=
 =?iso-8859-1?Q?vYSnktpfXxxm1Ad6T6C+uqbR6GMQNhuLDoHZbymVJ84hsR8BXMEh9U0Hef?=
 =?iso-8859-1?Q?Zk1y2nDfFoHIN9AmwjwmcwbSy5AnuNKNWDXnFmT/1F8QKAdSnl1Yjvw/zq?=
 =?iso-8859-1?Q?H1D7LYRekLomLFdgigXEBvBEDB2COkyNwCveAzT61gt8gMWy5nHy1P13hs?=
 =?iso-8859-1?Q?OZ+ORBJK0TVZUhA5/yw770XuzQalRWGLQgQbTg7XjQRQDY5ZvSammapU2X?=
 =?iso-8859-1?Q?JPnogkWc8o1PKMbchoN82MKteGQXRT2+OyZtnX5zNYCkkr8wH3ai53T5Ec?=
 =?iso-8859-1?Q?5RK6xstG7m6+4JyKgU9h0B3eQ2Oj+uByYdKEq1BLSuMYXJiSp3CAePN8cK?=
 =?iso-8859-1?Q?NmCiXmf7j5zMWYvubU7NShzPq0uBXEnsZiEEgVhsTuygrjZVaQr85YOEM1?=
 =?iso-8859-1?Q?D/ibeOhVzAgU6Nz9e5hy8Nbv0Tx56+A6ps29Wl3o5lC1SiYLcWq2UPCz1J?=
 =?iso-8859-1?Q?DRhHY3XrvORmW5GF8HAXMtlJ2409sQB4Gn3DxQJY6KBhw+hkxpVCw=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB365963338780784444B7786DF5670@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(476003)(2616005)(68736007)(53936002)(52116002)(66066001)(14454004)(76176011)(486006)(86362001)(50226002)(4326008)(26005)(6512007)(2201001)(478600001)(71200400001)(6436002)(8936002)(6486002)(25786009)(446003)(8676002)(71190400001)(81156014)(81166006)(11346002)(186003)(2501003)(105586002)(3846002)(6116002)(386003)(6506007)(99286004)(102836004)(7416002)(316002)(2906002)(305945005)(110136005)(97736004)(7736002)(14444005)(106356001)(256004)(36756003)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LmYLh770MDOwOpkLWlNODWE0VBI+aOg5JonEmMXhELdmjdC7B3CsD3eZLmXQN1l57UcK6mWjko6DFu8FLYlwPiBNiwb8YHVkgesImb75TgEGAHyB5Z1b/ACKxT3wahtq7CD99aBFCVWyC4FtV1QeqJV2ov2UgItiXJdEYWnfUOn3IrV+SNQGlkvLmhHDP44Ly15C+ipjPqF53aNrisVU0bLGyPpzWSXAr2zxmjvaH2pxzV0Y4S/cMRAp2Z7LaVL4EW2GyYjHcz3Sd6uxYfPiKIprQCXDSu2Hcb7vI6BzS/wbyAvuhJrZEiYGSOCXH+kISZPGVk/QKPu7ktgxRH34DVkN2BZ7awkGxmV34IMSnum80KGHeNi3UMeAs6tI5nGxITHeRaaLMk252vQSb2cvqAT94cTljBRsn4za3clf6s0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380b0b78-e477-4849-e53b-08d6922eba4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 03:44:25.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System Controller Firmware (SCFW) controls RTC, thermal
and WDOG etc., these resources' interrupt function are managed
by SCU. When any IRQ pending, SCU will notify Linux via MU general
interrupt channel #3, and Linux kernel needs to call SCU APIs
to get IRQ status and notify each module to handle the interrupt.

Since there is no data transmission for SCU IRQ notification, so
doorbell mode is used for this MU channel, and SCU driver will
use notifier mechanism to broadcast to every module which registers
the SCU block notifier.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V1.
---
 drivers/firmware/imx/imx-scu.c   | 101 +++++++++++++++++++++++++++++++++++=
++++
 include/linux/firmware/imx/sci.h |   3 ++
 2 files changed, 104 insertions(+)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.=
c
index 2bb1a19..e93bea5 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -7,6 +7,7 @@
  *
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/err.h>
 #include <linux/firmware/imx/types.h>
 #include <linux/firmware/imx/ipc.h>
@@ -21,6 +22,8 @@
=20
 #define SCU_MU_CHAN_NUM		8
 #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
+#define IMX_SC_IRQ_FUNC_STATUS	2
+#define IMX_SC_IRQ_NUM_GROUP	6
=20
 struct imx_sc_chan {
 	struct imx_sc_ipc *sc_ipc;
@@ -77,7 +80,23 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] =3D {
 	-EIO,	 /* IMX_SC_ERR_FAIL */
 };
=20
+struct imx_sc_msg_irq_get_status {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u16 resource;
+			u8 group;
+			u8 reserved;
+		} send;
+		struct {
+			u32 status;
+		} receive;
+	} data;
+} __packed;
+
 static struct imx_sc_ipc *imx_sc_ipc_handle;
+static struct work_struct imx_sc_general_irq_work;
+static BLOCKING_NOTIFIER_HEAD(imx_scu_notifier_chain);
=20
 static inline int imx_sc_to_linux_errno(int errno)
 {
@@ -194,6 +213,86 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *=
msg, bool have_resp)
 }
 EXPORT_SYMBOL(imx_scu_call_rpc);
=20
+int imx_scu_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&imx_scu_notifier_chain, nb);
+}
+EXPORT_SYMBOL(imx_scu_register_notifier);
+
+int imx_scu_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&imx_scu_notifier_chain, nb);
+}
+EXPORT_SYMBOL(imx_scu_unregister_notifier);
+
+static int imx_scu_notifier_call_chain(unsigned long status, u8 *group)
+{
+	return blocking_notifier_call_chain(&imx_scu_notifier_chain,
+					    status, (void *)group);
+}
+
+static void imx_scu_general_irq_work_handler(struct work_struct *work)
+{
+	struct imx_sc_msg_irq_get_status msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	u32 irq_status;
+	int ret;
+	u8 i;
+
+	for (i =3D 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		hdr->ver =3D IMX_SC_RPC_VERSION;
+		hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
+		hdr->func =3D IMX_SC_IRQ_FUNC_STATUS;
+		hdr->size =3D 2;
+
+		msg.data.send.resource =3D IMX_SC_R_MU_1A;
+		msg.data.send.group =3D i;
+
+		ret =3D imx_scu_call_rpc(imx_sc_ipc_handle, &msg, true);
+		if (ret) {
+			pr_err("get irq status failed, ret %d\n", ret);
+			return;
+		}
+
+		irq_status =3D msg.data.receive.status;
+		if (!irq_status)
+			continue;
+
+		imx_scu_notifier_call_chain(irq_status, &i);
+	}
+}
+
+static void imx_scu_rxdb_callback(struct mbox_client *c, void *msg)
+{
+	schedule_work(&imx_sc_general_irq_work);
+}
+
+static int imx_scu_enable_general_irq_channel(struct device *dev)
+{
+	struct mbox_client *cl;
+	struct mbox_chan *ch;
+	int ret =3D 0;
+
+	cl =3D devm_kzalloc(dev, sizeof(*cl), GFP_KERNEL);
+	if (!cl)
+		return -ENOMEM;
+
+	cl->dev =3D dev;
+	cl->rx_callback =3D imx_scu_rxdb_callback;
+
+	/* SCU general IRQ uses general interrupt channel 3 */
+	ch =3D mbox_request_channel_byname(cl, "gi3");
+	if (IS_ERR(ch)) {
+		ret =3D PTR_ERR(ch);
+		dev_err(dev, "failed to request mbox chan gi3, ret %d\n", ret);
+		return ret;
+	}
+
+	INIT_WORK(&imx_sc_general_irq_work, imx_scu_general_irq_work_handler);
+
+	return ret;
+}
+
 static int imx_scu_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -246,6 +345,8 @@ static int imx_scu_probe(struct platform_device *pdev)
=20
 	imx_sc_ipc_handle =3D sc_ipc;
=20
+	imx_scu_enable_general_irq_channel(dev);
+
 	dev_info(dev, "NXP i.MX SCU Initialized\n");
=20
 	return devm_of_platform_populate(dev);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/=
sci.h
index ebc5509..9d608db 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,4 +15,7 @@
=20
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
+
+int imx_scu_register_notifier(struct notifier_block *nb);
+int imx_scu_unregister_notifier(struct notifier_block *nb);
 #endif /* _SC_SCI_H */
--=20
2.7.4

