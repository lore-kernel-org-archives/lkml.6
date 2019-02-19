Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148752075A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KAZQYf2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfBSDLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:11:18 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:6062
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfBSDLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVZ8TJutkgbCKuIfd9EbprLsCKT7utXYkYfdz9qPrlw=;
 b=KAZQYf2arFmAQrZkiCA2gvEoh5PHED/pY1IPBuWBK/Vh5LMOMHEV6fVMfI7+FXSv26bcuSXaOwyFe9NJ3W7eSAUNzQ5WzDmt8rMtzgv74kROkWvBN99yL337BvioFd92tTh/5s4UhnnNEkTn+Sj1w2AHdp+hxIjudxDvQhQdSEE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 19 Feb 2019 03:11:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 19 Feb 2019
 03:11:03 +0000
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
Subject: [PATCH V3 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V3 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHUyAC/VPD3R7bpGk2QAb69kCjKRA==
Date:   Tue, 19 Feb 2019 03:11:03 +0000
Message-ID: <1550545569-7197-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: aaf72e5f-9717-49c2-fa6c-08d69617e19f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3916;23:2oF6Bl5O0QeBLxlG6thDvreqP1plqeZDRWAaL?=
 =?iso-8859-1?Q?0Y1C9N3Yn09LdHEYuvJmxGWNJM845779H7hSKIKufrEiZIa5V6xSsFg6AX?=
 =?iso-8859-1?Q?4Q6FtDP+ZwURP9l47/0ZI+Z3mafu9ILkCm30oD9ennVmoBvquEPiiPmLo5?=
 =?iso-8859-1?Q?+qg0n3sfsd1sevn/8xP6jip0CuM89q6S3gRlIFBWAc8+e+W2B7uouqlyfA?=
 =?iso-8859-1?Q?+/dHygeDi7YiULKBfsADeTNFrNfaMdZTVWYQuvfFFW4aZ/ddsGD/MiUWgp?=
 =?iso-8859-1?Q?CLEZxXVyPJpVxCiggStZl1OvHxjeK4k0Mgpor8xfwexDa1R1P1g559Ztfg?=
 =?iso-8859-1?Q?hs/dGslPkG16E6ycsXG1fDGi5kz6eC2/Xiw69hVW5K6/eKNBkC6BKDfirC?=
 =?iso-8859-1?Q?WoEte7ePtWrmd4wFKW6TB8kkG2WslJhHV+t1+YQmqQZbpo3qoCIMXFpls/?=
 =?iso-8859-1?Q?cZZddmGp4cRyM2jbQ/szzWgovGCVmFAYZLqf2qAsHHR4rCy/r/i+8bfnNb?=
 =?iso-8859-1?Q?LwWEzLFo5L+ucv+O1cg080ht1cwpZnSk5MAyrIg1KTG6yWn5B766sx7K1b?=
 =?iso-8859-1?Q?0ahvmSGHTmAP2jQodK1N+y6aVe7UHjcgfQGx/s+hAZhXD1jHoBUZezOQCk?=
 =?iso-8859-1?Q?DkcfUFzmNQyVAiJwtvwAXlcGSpVt8AUJEchlpmwVXVd7I3Mifwo6mRFhEU?=
 =?iso-8859-1?Q?ECDa7Ttbb5PwWITNlPD3Zf90xYwC2UePx7P7bU+7n+Koy+zFu7Gt7HPeUO?=
 =?iso-8859-1?Q?WBxey/PnJ3/YbgfJlOf44gxQaN2HJGXP6AGwbGtFEXCyeBXtAdvSZDCiBa?=
 =?iso-8859-1?Q?3e9xZEtvdQvMpKJ2Ks7maQWwLo5JNYOUwJaQM80DOAQux/LEJPEny5fke6?=
 =?iso-8859-1?Q?lgHAvHYwlXhS/QaeyeyFG0uaXdRtdBhXGgiFH5UkQF4Od0X6+J2NvPISIX?=
 =?iso-8859-1?Q?hXQ5bY2RI8OG8z5LD8rpCD7mIQzMr5qW58ez+6/jPsmxZjiae0ZjQqqDgJ?=
 =?iso-8859-1?Q?4FZSdr3RYzyQ6h1tH6M4j7tSO3JT/1T5q34MpNk2Z0RVMMHYIPeE6pP7WO?=
 =?iso-8859-1?Q?t3UDUl0fhytdR+7aVsWCnd1+BNNFjFSi2YEeX5lRD1q7644eBAIJw6tjQC?=
 =?iso-8859-1?Q?o97B0l2DZxZfqXTSF057rNtgMXVvsrnKFJ/tsaEjM3GwF2G35aRePK6ppq?=
 =?iso-8859-1?Q?9O+RnaFlEQCJV1u9YuxanvgTfDDk2gm15sUk6B8yPyJQ9rlw16eiV4J/aY?=
 =?iso-8859-1?Q?jeULqoq2rDEEEJLXGdMpMd55jjMyFfREdargi9za/K2NNUZ9lY7CWLl4KZ?=
 =?iso-8859-1?Q?kyvqpMMJo3W+uib0oiapALmu+KqCUxVWHC4GzqDTUulbqiQ=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3916842E3E1DA923E03FE97EF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(376002)(346002)(366004)(189003)(199004)(14444005)(26005)(6512007)(25786009)(68736007)(256004)(6346003)(478600001)(486006)(3846002)(6116002)(6436002)(7416002)(2616005)(186003)(14454004)(446003)(11346002)(476003)(6486002)(4326008)(52116002)(316002)(8936002)(81166006)(50226002)(76176011)(99286004)(7736002)(81156014)(53936002)(305945005)(110136005)(8676002)(2906002)(86362001)(102836004)(105586002)(2501003)(2201001)(386003)(6506007)(71190400001)(71200400001)(97736004)(106356001)(36756003)(66066001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eKFb2B2qd4UR577QI/iM8Tyl0n8EaCmN4r0+h4m4HvWOrciHaPRZmnfGNHYSD1nR3l0n8QXBf9O15iQJUMf/DJdnJGYZpAXZWIOQzzC/P3n5jGqv9KkaFWA0TXhD9fYlv2a17+DkdBKGFC6yh4Rc4lZ+W/fxHZ6LJnIcUAtlHIZreZIhQtju831HsLc84EHZ/Tc3G+Z2njwrVaGpMgvSyzs5wDoP7T9iw2PVENo8ZidrEzU1C+3hKFnwv0f3SIVswdXkt3xUpdoG2fIsmsoPVzZYljcH2SmVqeLj74bbQOa/QkUNiAAxQNXcJiSvoNPWtraMY7UMJfch4U6VYTGcxHaB/MIQ6ZDE4flW90IO57x5bOE8UwotUJWBTyOKX54jb2Fuet/Hag77ZVAjl88qpLZzl3b1ezmnVVWIeSCtil4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf72e5f-9717-49c2-fa6c-08d69617e19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 03:10:57.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
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
Changes since V2:
	- add .read_alarm callback to make sure RTC set alarm work, system control=
ler firmware does
	  NOT support read alarm, so simply return 0;
	- add rtc alarm enable setting in .set_alarm to control RTC alarm status.
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

