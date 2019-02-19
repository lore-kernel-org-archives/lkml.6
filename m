Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B575C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476782075A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fIS/iRzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfBSDKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:10:55 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:39810
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbfBSDKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPsEGZKEudmn/jpPTPfPqX2jm+yilQMSWcbjAaDIygg=;
 b=fIS/iRzj9KAxHSXrtBoBuio2ZyXrMR7HO7tNr/RCyn/uahMV0ES63vyXWoJ3y6G/+yRKRFVenvP4MErwiag9S7w6sjazr7vFOCxlf8++dGxdfKXwA/KuNX20SDWisP9IFWO/rI46DP499h9E0fWV3o8xVLVdKzFBKCQl2WjrNWw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 19 Feb 2019 03:10:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 19 Feb 2019
 03:10:48 +0000
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
Subject: [PATCH V3 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V3 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHUyAC2xKu7JB/kS06igQ6HPY46jA==
Date:   Tue, 19 Feb 2019 03:10:48 +0000
Message-ID: <1550545569-7197-2-git-send-email-Anson.Huang@nxp.com>
References: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6c99419-9a7e-4024-676e-08d69617d8b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3916;23:dhXvHi0ZWajIPnGpwOEXgPblt582JKHSXlLj7?=
 =?iso-8859-1?Q?9rgnru5tF1uRPkvD551xA5u/0fxL3AUoznZw7LqIWha9W4A0M4yC7JMzNl?=
 =?iso-8859-1?Q?xfRFTngUmn+BhzhNu7GXUibNCmLvcg1lxmQU5Pco1bjQQ8S24tYlT7WGnV?=
 =?iso-8859-1?Q?NVX0bZ6cQKZWGwYeTiK4kqtNM/Qesh9WwbQYjp5tyYEGTdhxshL8fsJM4F?=
 =?iso-8859-1?Q?IJCn+zjh3LrsRxPLxRFFTE6bofw8WcCgxD29BuoauNGK6WW/6iJy4CVRcr?=
 =?iso-8859-1?Q?fGZ2hSZ9OIhBel6aLiFHxxo0l+U1a3a6WAwCXu2zGO4x37B4NR4pp+CdC+?=
 =?iso-8859-1?Q?CCaxilFHKk+Dy5Z4Lu5Yykijx+1IFrpvbHK1Tc3uHOVch94jBrhSi4a6KF?=
 =?iso-8859-1?Q?XPrfdO45BnpWgTAFl0cXYR+9EYbiMtH1Yj5kLLlsunOXQJPD+CXR8w6xmu?=
 =?iso-8859-1?Q?i9z86ogRzLcv/i7ZGtsDmh/FeF3A0DtQB8+DesqQU8DCnfB4jJHWkLRNB6?=
 =?iso-8859-1?Q?Xt6peWf4vWmq5hkpSUelLHxPRuGAMKy5TWfzqcVP3guqE9hdvd4jiyv9WT?=
 =?iso-8859-1?Q?owAzW4M1uH74pBR9kYX69jJvzol1J9OktbMPhchDkSz7g06PCmh2oLpqxb?=
 =?iso-8859-1?Q?skTkUYRfrkIJ34owrFQ/GzF3ux/tUY+eKU9jQv4QaoQyy3RQPQH1oDROnA?=
 =?iso-8859-1?Q?+ujt4t4goFrpigspjFO3qVRNhzVii3h7iUPq69UTpgyxB8/6qrkjoffu7e?=
 =?iso-8859-1?Q?C5tn0siXdywDqozjn7nYHp3MyK4vQyMlmOPpyAUtUe7Qo3h0J6z+FH0N/p?=
 =?iso-8859-1?Q?CmroEErFlSrCHvZgW+QLL2TGVi27fTF/kiQPbihuamJwj8vKnVUmWUaOfE?=
 =?iso-8859-1?Q?S0PyEI6IO2AJuidRBIUzlvDkqvS1Qdqs7d/jQg8JvH3FQRQ50WUxz0R6RT?=
 =?iso-8859-1?Q?5vCdQD9c1qALt6SVc+FmJZJdoyjN06BsScZl5YF/GI5kfVkPtsibEaJE4Y?=
 =?iso-8859-1?Q?wFHVcuzdp68XytVFQJjqGU8BwCZ+PzZr+jFln0ONpShIFMHG3s1GGI9Ik0?=
 =?iso-8859-1?Q?ySXfauq02NAkY7t/BDbJeBkexh12snAIzd0Q9XX64MVVLD8+1hBTKraVlI?=
 =?iso-8859-1?Q?0a4xHLQmmSzcgm/m38POvUNzyIdc4ZBEVdK67hU5ptGGnX9LOu2wosIIIQ?=
 =?iso-8859-1?Q?7dc4q+bCGeKVYemEP3wwzhnPVm6bnVQfHY84isHrVuKKQx8icEhvnDUsQa?=
 =?iso-8859-1?Q?SWMvocFxP9FXVRsAHlU8YKin+PDnPS6PvzapM7X/nyLZxKVEw/DK+68pQw?=
 =?iso-8859-1?Q?kgJoNr/IGUrOSPa/mlbw5Bbaz3/1X23D3s+yxPeoavxK1Aw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB39163B6BCCD4409CD109BD57F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(376002)(346002)(366004)(189003)(199004)(14444005)(26005)(6512007)(25786009)(68736007)(256004)(6346003)(478600001)(486006)(3846002)(6116002)(6436002)(7416002)(2616005)(186003)(14454004)(446003)(11346002)(476003)(6486002)(4326008)(52116002)(316002)(8936002)(81166006)(50226002)(76176011)(99286004)(7736002)(81156014)(53936002)(305945005)(110136005)(8676002)(2906002)(86362001)(102836004)(105586002)(2501003)(2201001)(386003)(6506007)(71190400001)(71200400001)(97736004)(106356001)(36756003)(66066001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZjA2+gkxtOb7BXOs4tyGour+VU40ry4zBvaQmuIoOn5cb9Ps8dk1jxYe00xkRu2DR4e8qmClDgi9Pb3HdLXTTXF/kPTBwdRYPgqCICT/C9WtZo90/Zr8pJyNvzM6qiiFMIH9sO/7GcaaxGNdnU6t1LmOsInytYrzkmbleAUsseGju7hJjSM5MAhljtxZ2OAr//M/o1HM/8mAd189SBwkPNVOFr93n/eLJQtSjba1c1JjcqWPLE8T7EL239TUEvZSTXYwkFmnjI10843tS7gaCAT6KhtNFP1o3B8A623aXPyQV+zujaP6KB+amM47ZA2vWaM9RQ/9bOmxoT4uhwQVE/WCA6+adyMm3wgfNAoYGCIBURZJjJFSTPzJHMLDOqwciPFS1nZwXVmyxp7033xuPdA8tVekBAXsnhCs8RHHdnI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c99419-9a7e-4024-676e-08d69617d8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 03:10:42.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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
No change since V2.
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

