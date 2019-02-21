Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE52086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="miNq4e55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBUJTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:19:46 -0500
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:39384
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfBUJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Da+RigcDRDdGgupq4mb9P1vw4Cg4RdnkzYDEVmDy/o=;
 b=miNq4e55vwJoyTbEZ1KfYi6fTCuNmwpdgeBV0z2AWVDSJJajGl9LEmmbpZc9IRXIxMWP8xQAIgbl6d6rF73JI5D+Fti1kgogaBK1jk6fpkstncVTBqiEiqPMluiJ3pz7kOqVTrIYwNfyjvZYTs9PswCobbZHTA6oMBC8aMajP8Y=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3543.eurprd04.prod.outlook.com (52.133.19.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 09:19:40 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 09:19:40 +0000
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
Subject: [PATCH V4 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V4 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHUycaSSBGV4IHDo0u9TJiC3cxIgw==
Date:   Thu, 21 Feb 2019 09:19:40 +0000
Message-ID: <1550740354-2701-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6f903219-1e4e-47c1-60d3-08d697ddb4df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3543;
x-ms-traffictypediagnostic: AM6PR0402MB3543:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3543;23:Wo79WVs3ivvcjHSAb8LhAp6GIstqOdyHkRT/j?=
 =?iso-8859-1?Q?NkH+I/q6Jz0cmzHz3NCJKR1mwTs0rfjtr0VKd5zleTP0fN9hpH1JHR+vXe?=
 =?iso-8859-1?Q?6gwUk/xa/u3/zWyOZnThepbDVF4VkoYIWaoe6cHZlXhZW/LaIlAbxQI5J7?=
 =?iso-8859-1?Q?oD97gqwYNT370RJy3Y52uTEFSfSR/QBFG4rJKAocLiyJpuc6vIxe9z299A?=
 =?iso-8859-1?Q?SviqgSdiDscR8wYUpIZlqNwJvoOleBNeFn9+P5u19SBW4xXd0Y2ApEzK+M?=
 =?iso-8859-1?Q?Rum3Dj8mNdu8PgKiGdP1WSkR9p4ddaU51EODMBScsRigjLsN1B5bD8tXO6?=
 =?iso-8859-1?Q?KQ2oXepz/8SzoHcvJhJ/HwwNf6c8sRjWSKj6u9dNsNec5yWJbY4p3r+kfA?=
 =?iso-8859-1?Q?ggTdxK5ifaMdg1XwU9Z88I7HtVrUfkj5UjEW69+PJtPjobIjveBotX6me1?=
 =?iso-8859-1?Q?Lc0IeHuJwuCEYAfLENanOZGbvhJ1gVzRE1INLJftaCOT+wb+FjBwYK+wd2?=
 =?iso-8859-1?Q?TmBe+CbQ1UvPS+UoVUCJvrhaSdZAMsGA6V3G+tbrhq5MtVo+UHmTPQeu9J?=
 =?iso-8859-1?Q?9B6DmvgV2N9XWFMCUT96wk1WFME4fJ4sV1I56CVVOzY9OduaU8fMU6lCyd?=
 =?iso-8859-1?Q?BPuXbMPUtY6hskFVWOk8XIMrR0pGA1bkLXdmXG0ZcJRDSo8wQtmOBnuto2?=
 =?iso-8859-1?Q?rJSc5axuSVdtXPgGxYPhBzwLSkjtKJ7NVewalGC6xutl8BBlSiBnI7xgEL?=
 =?iso-8859-1?Q?idnO9T3ANrb/WnfkO5ZmtevM372T/cTS7Hd3KFypn53J+npEqttl6TMe3m?=
 =?iso-8859-1?Q?ojzL9I5HH34hawlUX1ZhxwLpxi8iSqW/lXGO3NE7a22BDugacYfmobmr94?=
 =?iso-8859-1?Q?3b/bA4IYXIYVlZQHP9NT0S5Ewa9/ykTWbaPfno0cOXUuaDLK2JXlaET6m6?=
 =?iso-8859-1?Q?2tv/T2JLJofXFjzfsoBTn1TYbUeOxGxFqzDTO5zhkoKTHrjNdKNyE4UVgZ?=
 =?iso-8859-1?Q?GThJslWWFSPZ1QcX7y0jiWznUOTvgfd7X918SemtNTxJKWZpeWg+lVFR69?=
 =?iso-8859-1?Q?GEWR9encCbU2GdPICeQmGK0KGtk6BOu67i78gX4w3iCRtWWxrs+J8R+HZ7?=
 =?iso-8859-1?Q?Qt4uMYniNQoA0GYcrB2hdkuLOdZaM/1+qQ0+NkqIDOqqkuQZqLQval4E//?=
 =?iso-8859-1?Q?WPSuJoYCRB1n24x0WnZRi+gtuZbJzoWhC2IoY2yQ8aRLV6rIjZyfte8RCU?=
 =?iso-8859-1?Q?tHMC/W4Odcty09oJC8WW6+sFXLbWcjyPCNVN+vIf6960OM53UUrnGdW44x?=
 =?iso-8859-1?Q?1uAP9byfmgduAvt1jNoZgQvDg?=
x-microsoft-antispam-prvs: <AM6PR0402MB354363B19A38C44CD6925547F57E0@AM6PR0402MB3543.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(6486002)(6512007)(6436002)(97736004)(8676002)(8936002)(256004)(99286004)(50226002)(81156014)(2501003)(52116002)(81166006)(7736002)(305945005)(14454004)(36756003)(66066001)(76176011)(14444005)(5660300002)(71190400001)(71200400001)(105586002)(106356001)(478600001)(476003)(2906002)(2616005)(4326008)(11346002)(446003)(486006)(110136005)(86362001)(68736007)(6116002)(186003)(53936002)(102836004)(3846002)(7416002)(6506007)(386003)(26005)(316002)(25786009)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3543;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Toj1cKAR9Sh5sPojA4fgyCH2LHp7tenuwsXG6B4HHSfaCneiESSC9dGO6o8xnM/iLV+XMDI1zLgAO+RIfCBTt8gepcz0GPb1Eh5IJrAwuQjOLQ0/5FGEs0Sjre1ZS3ti1aVJmyxb6/Z6LePDEVOYFNflnyF1dRhy8zDtdRf3G4ELgMnqv1hyQpZyzK/CAjdE14QsqVdNj3fGzBAF2H2wm3Roh9ZA4IIbsnTIKrucojpt369FEIGoT5jZPFKtB+b32zkWeWQ7I7L71bqJuvsSrc8V6P3yLn9+tbQqey00zpol9iBPtB+ORZPzxO3nwY/pgSQ4H7aSRskZDiX92zWCwwA+Iu9jxRU5dWe2DDKl5r6D/VtJp/hdwCY+44YORVub58mtly5iqOprZZqKvmaEuLzlP0nwNl0+I/fVOvG2Xo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f903219-1e4e-47c1-60d3-08d697ddb4df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:19:35.0046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX system controller RTC alarm support, the RTC alarm
is implemented via SIP(silicon provider) runtime service call
and ARM-Trusted-Firmware will communicate with system controller
via MU(message unit) IPC to set RTC alarm. When RTC alarm fires,
system controller will generate a common MU irq event and notify
system controller RTC driver to handle the irq event.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V3.
---
 drivers/rtc/rtc-imx-sc.c | 112 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index 60570a2..3557f12 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -3,6 +3,7 @@
  * Copyright 2018 NXP.
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
@@ -11,11 +12,17 @@
 #include <linux/rtc.h>
=20
 #define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
+#define IMX_SC_TIMER_FUNC_SET_RTC_ALARM		8
 #define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
=20
+#define IMX_SC_IRQ_FUNC_ENABLE			1
+
 #define IMX_SIP_SRTC			0xC2000002
 #define IMX_SIP_SRTC_SET_TIME		0x0
=20
+#define SC_IRQ_GROUP_RTC    2
+#define SC_IRQ_RTC          1
+
 static struct imx_sc_ipc *rtc_ipc_handle;
 static struct rtc_device *imx_sc_rtc;
=20
@@ -24,6 +31,24 @@ struct imx_sc_msg_timer_get_rtc_time {
 	u32 time;
 } __packed;
=20
+struct imx_sc_msg_timer_enable_irq {
+	struct imx_sc_rpc_msg hdr;
+	u32 mask;
+	u16 resource;
+	u8 group;
+	u8 enable;
+} __packed;
+
+struct imx_sc_msg_timer_rtc_set_alarm {
+	struct imx_sc_rpc_msg hdr;
+	u16 year;
+	u8 mon;
+	u8 day;
+	u8 hour;
+	u8 min;
+	u8 sec;
+} __packed;
+
 static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct imx_sc_msg_timer_get_rtc_time msg;
@@ -60,9 +85,92 @@ static int imx_sc_rtc_set_time(struct device *dev, struc=
t rtc_time *tm)
 	return res.a0;
 }
=20
+static int imx_sc_rtc_alarm_irq_enable(struct device *dev, unsigned int en=
able)
+{
+	struct imx_sc_msg_timer_enable_irq msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
+	hdr->func =3D IMX_SC_IRQ_FUNC_ENABLE;
+	hdr->size =3D 3;
+
+	msg.resource =3D IMX_SC_R_MU_1A;
+	msg.group =3D SC_IRQ_GROUP_RTC;
+	msg.mask =3D SC_IRQ_RTC;
+	msg.enable =3D enable;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		dev_err(dev, "enable rtc irq failed, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_sc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *al=
rm)
+{
+	return 0;
+}
+
+static int imx_sc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alr=
m)
+{
+	struct imx_sc_msg_timer_rtc_set_alarm msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+	struct rtc_time *alrm_tm =3D &alrm->time;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
+	hdr->func =3D IMX_SC_TIMER_FUNC_SET_RTC_ALARM;
+	hdr->size =3D 3;
+
+	msg.year =3D alrm_tm->tm_year + 1900;
+	msg.mon =3D alrm_tm->tm_mon + 1;
+	msg.day =3D alrm_tm->tm_mday;
+	msg.hour =3D alrm_tm->tm_hour;
+	msg.min =3D alrm_tm->tm_min;
+	msg.sec =3D alrm_tm->tm_sec;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		dev_err(dev, "set rtc alarm failed, ret %d\n", ret);
+		return ret;
+	}
+
+	ret =3D imx_sc_rtc_alarm_irq_enable(dev, alrm->enabled);
+	if (ret) {
+		dev_err(dev, "enable rtc alarm failed, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct rtc_class_ops imx_sc_rtc_ops =3D {
 	.read_time =3D imx_sc_rtc_read_time,
 	.set_time =3D imx_sc_rtc_set_time,
+	.read_alarm =3D imx_sc_rtc_read_alarm,
+	.set_alarm =3D imx_sc_rtc_set_alarm,
+	.alarm_irq_enable =3D imx_sc_rtc_alarm_irq_enable,
+};
+
+static int imx_sc_rtc_alarm_sc_notify(struct notifier_block *nb,
+					unsigned long event, void *group)
+{
+	/* ignore non-rtc irq */
+	if (!((event & SC_IRQ_RTC) && (*(u8 *)group =3D=3D SC_IRQ_GROUP_RTC)))
+		return 0;
+
+	rtc_update_irq(imx_sc_rtc, 1, RTC_IRQF | RTC_AF);
+
+	return 0;
+}
+
+static struct notifier_block imx_sc_rtc_alarm_sc_notifier =3D {
+	.notifier_call =3D imx_sc_rtc_alarm_sc_notify,
 };
=20
 static int imx_sc_rtc_probe(struct platform_device *pdev)
@@ -73,6 +181,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev=
)
 	if (ret)
 		return ret;
=20
+	device_init_wakeup(&pdev->dev, true);
+
 	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(imx_sc_rtc))
 		return PTR_ERR(imx_sc_rtc);
@@ -87,6 +197,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev=
)
 		return ret;
 	}
=20
+	imx_scu_register_notifier(&imx_sc_rtc_alarm_sc_notifier);
+
 	return 0;
 }
=20
--=20
2.7.4

