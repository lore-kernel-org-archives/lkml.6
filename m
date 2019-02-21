Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF90C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A722086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ffcLtZ1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBUJUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:20:17 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:61856
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfBUJUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu4PNXxo2gJ4Ree8EspoH9hSKGaHGCP967+bedKiMlM=;
 b=ffcLtZ1kMxqpZ8jLdg/gyHPwMdNxUrhYifTXJwxZPRdhax5h/uj40IIUJCA8ZwGli7YlPWsDDWpChM36KWgnATgLSic1kx5bocvgFjZQPeFtap0zAbHBRXBYhyvzQcwccCbx0UpBolwPzMf3AZqEEMt24wsrD0W+Oe/vYurdoac=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3784.eurprd04.prod.outlook.com (52.133.9.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 09:19:28 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 09:19:28 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V4 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHUycaLw3da++dFN02n8A3i94XTEg==
Date:   Thu, 21 Feb 2019 09:19:28 +0000
Message-ID: <1550740354-2701-2-git-send-email-Anson.Huang@nxp.com>
References: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:2f::13) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02913f12-f9fa-45cb-bcbb-08d697ddadf8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3784;
x-ms-traffictypediagnostic: AM6PR0402MB3784:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3784;23:Oc4nKSXNSo8llC7VHI85wPizIq/Q8g62rRFNt?=
 =?iso-8859-1?Q?2Z9ujhGeDBU+8sKgFif7Z0AL5N6uZURXk9JZW18Urz2htvxPSPWqa+ym07?=
 =?iso-8859-1?Q?K3EUQaG4bEEZaY0RznLkdvEyc7aFs6q0DjcqJgGC7eG7S8Q6RvNjxIpQcO?=
 =?iso-8859-1?Q?10wr/IjNnTr5ej4MxfG09U59HM1OTCh/g3oC9AEXeF5LfgyXf/Yvfe8qMM?=
 =?iso-8859-1?Q?LgihT0VjbWN8/uI11/jd/Da8vM/4mOUZd+R4T9EAixBi1LksqQ9sh6Dux2?=
 =?iso-8859-1?Q?lN+xgH2FbYi20kRUdBmnzQBAL1YFHW6FVPpG++tYa6dKmdtFXbp1YpRMLf?=
 =?iso-8859-1?Q?mDh/BtzGd4SQkJMjjZRbq9zfQ/Bdg+lUlxpgZbztpobu7MjA2GkdVk4j7Z?=
 =?iso-8859-1?Q?KJUVOLXFnJSRh0tz3Ib0hC6JRkloJra/ue0sCnJrnbKYwr5MUOIvbMrpba?=
 =?iso-8859-1?Q?xXDqTHdHOLjnpQVVZ6UYO7ziDHFYWXKRyD51TnNGy0RAq1aK3sCHGDYClj?=
 =?iso-8859-1?Q?w0FcA5a2nEXH9jzfL3xrBqxXo2yqHvYm6KKSMVyRy/Sfa6Ilpj4l4UpgM5?=
 =?iso-8859-1?Q?BvvkH8/v25i0Ju2DB7tegNVRPiGB+ohV5JPjarZVXEd0SdpoDkkjEsBm2t?=
 =?iso-8859-1?Q?Izzyt19y7GNlmfETRgtGl0Z240X6c2+/rzS6Zgla+TYS98TmL0u4Ux3BGN?=
 =?iso-8859-1?Q?tXboaQuZ/Js3JyfRkSGegcwr9pSDWMcgzrFNJDA0faHAk/PZ/iEAL/m0EP?=
 =?iso-8859-1?Q?wRFu4sQjlioW6JevKvkbwGAOEYM8yM0hett3Ii5we59H6seB6kv01bK3lz?=
 =?iso-8859-1?Q?Z/qiL7TCJh8vGSKhKYgBOLPO9r+SukmrVJXeXzfszmv/Ep0JCmfZ6LCUx2?=
 =?iso-8859-1?Q?llP+Rw1A2+NeKRsOyqJUejrgOY2y0fdc1jfLiv7gVXxDzjVXfKCfUW76wX?=
 =?iso-8859-1?Q?dZv22V5LowF1C87cCA3FlO9jDp4S9FJCOv4iW2SofQY5Eu0LtktxgPRMr2?=
 =?iso-8859-1?Q?eE6rXUWbZMrD7OERi+dWWqVXsGFIJlk7JIOzG5Ig+GWbn2laS0X13Okn/k?=
 =?iso-8859-1?Q?a7Y8SRcn8Bzrn1CLx3Pu2yb7eENAbmbBTNdRrLkbhx8efIRGSjVavf/ENe?=
 =?iso-8859-1?Q?VtZUSi5+0vQ8IJ2DQlLBHAm3wTL6Vr+GSXBW9F8wNf9Hjcpm+CX509prV9?=
 =?iso-8859-1?Q?VG16hpEe1K0arTXWPaI9mIlO+xYcF05tDxLdMpUc+AgVaOEk+RXcSGAuQ2?=
 =?iso-8859-1?Q?G4q39qV+1QgwHbTAc2cCg6umlHd19fJk0IvJJLs5BeooTG4cpJrG/glM4A?=
 =?iso-8859-1?Q?YFxZ/5Pz49MVbmoq99ShG+Yq1?=
x-microsoft-antispam-prvs: <AM6PR0402MB3784D4594D8A03CC42DFE826F57E0@AM6PR0402MB3784.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(71190400001)(68736007)(71200400001)(14454004)(66066001)(26005)(386003)(102836004)(6506007)(186003)(86362001)(2201001)(316002)(6512007)(14444005)(36756003)(256004)(76176011)(99286004)(305945005)(2501003)(478600001)(52116002)(97736004)(7416002)(106356001)(50226002)(8936002)(3846002)(53936002)(6116002)(7736002)(105586002)(11346002)(5660300002)(2906002)(4326008)(8676002)(81166006)(6486002)(6436002)(476003)(486006)(81156014)(2616005)(110136005)(446003)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3784;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SxnSO+OfMDOgsua1ZOZO5W8gwKoDsBymFDii7zQqrzocvhOwf/M/rWF410ivKmD0atoiRlxqZL8t06c8OKN70nC4G3eGDw4psmXTvveCTomENj1cmla6QaQZKpzNeVr7bB+PglJL02K241LDxjI2c2WbCJhw8t8HjdS2dCh1Iw1Fv+Vv50yptzlIuG52OODdTKep/x36gcboE6MPYNmNUqbYszaqNWr2TdtMvSw+JucLh/h1/eEKznTPOCTDo5LQ1ZXqfz4cqvZxYQaTSePAV0Lo3vAeaeEKmMepWZ06g6AZyGY1ot/JDYek/br3PRJnBHO6I/Gb52VPT2WXWRkctyydRVdPB5BfbtxQo/0U+vKKxr86BOJQE/HEHiMCQ/+4fTGSwGG7rHEFCBasX65Lqv9v/WC2w7QBj/2/9fqGjHA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02913f12-f9fa-45cb-bcbb-08d697ddadf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:19:23.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3784
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
Changes since V3:
	- use alias to get general MU interrupt channel id and then get resource I=
D,
	  this is to support different MU instance;
	- add return value check for imx_scu_enable_general_irq_channel().
---
 drivers/firmware/imx/imx-scu.c   | 116 +++++++++++++++++++++++++++++++++++=
++++
 include/linux/firmware/imx/sci.h |   3 +
 2 files changed, 119 insertions(+)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.=
c
index 2bb1a19..1dcd7b3 100644
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
@@ -41,6 +44,7 @@ struct imx_sc_ipc {
 	u32 *msg;
 	u8 rx_size;
 	u8 count;
+	u32 mu_resource_id;
 };
=20
 /*
@@ -77,7 +81,23 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] =3D {
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
+		} __packed req;
+		struct {
+			u32 status;
+		} __packed resp;
+	} data;
+};
+
 static struct imx_sc_ipc *imx_sc_ipc_handle;
+static struct work_struct imx_sc_general_irq_work;
+static BLOCKING_NOTIFIER_HEAD(imx_scu_notifier_chain);
=20
 static inline int imx_sc_to_linux_errno(int errno)
 {
@@ -194,9 +214,90 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *=
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
+		msg.data.req.resource =3D imx_sc_ipc_handle->mu_resource_id;
+		msg.data.req.group =3D i;
+
+		ret =3D imx_scu_call_rpc(imx_sc_ipc_handle, &msg, true);
+		if (ret) {
+			pr_err("get irq status failed, ret %d\n", ret);
+			return;
+		}
+
+		irq_status =3D msg.data.resp.status;
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
+	ch =3D mbox_request_channel_byname(cl, "gip3");
+	if (IS_ERR(ch)) {
+		ret =3D PTR_ERR(ch);
+		dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);
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
+	struct of_phandle_args spec;
 	struct imx_sc_ipc *sc_ipc;
 	struct imx_sc_chan *sc_chan;
 	struct mbox_client *cl;
@@ -246,6 +347,21 @@ static int imx_scu_probe(struct platform_device *pdev)
=20
 	imx_sc_ipc_handle =3D sc_ipc;
=20
+	ret =3D imx_scu_enable_general_irq_channel(dev);
+	if (ret)
+		dev_warn(dev,
+			"failed to enable general irq channel: %d\n", ret);
+
+	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
+				       "#mbox-cells", 0, &spec))
+		i =3D of_alias_get_id(spec.np, "mu");
+
+	/* use mu1 as general mu irq channel if failed */
+	if (i < 0)
+		i =3D 1;
+
+	imx_sc_ipc_handle->mu_resource_id =3D IMX_SC_R_MU_0A + i;
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

