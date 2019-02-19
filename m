Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A78E21904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+PG89+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBSHXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:23:24 -0500
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:58769
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfBSHXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFyMd3wRAe5F+r8FSZ6dkpOyu1ydRElYDyPyzoM9se0=;
 b=g+PG89+cZcoS0Vva0XiCsY3vPNHsLdZ2NxvpKTSvLm3ER6r1bJzffAz6yFZuszx5ACtUljGzobgGEMViiEJsfrz4P4iaVHMjQ9MxOvKx5n5kjuYZZQogDvQ9OuOgi/bqV6FIZ5WPdHWlaiViKOD9+BhSuK6Fo4TRqYh7LfM9ZnE=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2867.eurprd04.prod.outlook.com (10.175.41.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 07:23:17 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123%6]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 07:23:17 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Topic: [PATCH v2 2/2] usb: dwc3: Add workaround for host mode VBUS
 glitch when boot
Thread-Index: AQHUyCP7Q8ykT1GH70SnZGQkOrdM8w==
Date:   Tue, 19 Feb 2019 07:23:17 +0000
Message-ID: <20190219072358.43493-2-ran.wang_1@nxp.com>
References: <20190219072358.43493-1-ran.wang_1@nxp.com>
In-Reply-To: <20190219072358.43493-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0021.apcprd04.prod.outlook.com
 (2603:1096:203:36::33) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee2c3be0-d045-430f-cc01-08d6963b1e31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2867;
x-ms-traffictypediagnostic: AM5PR0402MB2867:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM5PR0402MB2867;23:4Ftkq33/Flk5wpF4nUEulY0ho/BUOe7Zr3o5c?=
 =?iso-8859-1?Q?ZKxR71LukPqEGr9P641Zr7cHE9rw+0zZQt2A//gB4QyuqBnOIwZcfSaojV?=
 =?iso-8859-1?Q?zEvhWX62A+vWsFLr/nBXnm97z+PngHLY1+zY590nen5eI6XL7Eq41iMRuB?=
 =?iso-8859-1?Q?RzjPOMlsMnKIlJV974AErYOPAHWFuYX+eFgHBv8eN/6cS2vY0YxiaawFdG?=
 =?iso-8859-1?Q?3/FDvHD5ymbZhxG+QGpeFo02+nOxUtecPQNdvf2yuPdsHVDHd23oo6IsfZ?=
 =?iso-8859-1?Q?A9pH/rMUiaxd8p+j1ZkOgSrYI+Ajc0D65Lgf86SPOgPBw7G1xN0URTiybL?=
 =?iso-8859-1?Q?mK6ZS84F8H2VB0BQW4tmDy8YSsRqzhXtqpdsfFhmsDHp9o4M8LeohitPj+?=
 =?iso-8859-1?Q?eA4cZHQNDDIwnxDDKxXZ9AQtaySMJFO+Ebod0dF0nMWjq21LM5TY6E5jAX?=
 =?iso-8859-1?Q?vYZfpiyBsRpog8of2SJse2RQHUnFNn2GWGLvs8ZRs0lCT9lO/sfQaHQL0+?=
 =?iso-8859-1?Q?Jacp/Mjqcmj5giQha4PTUPz/qTxumJKcZowS2AVHE3KS1N5f/5O8N/IIC5?=
 =?iso-8859-1?Q?HwRUe+uQbTbV1UlhL07oXzYlLs+EmVKoHnONUTP5Zmt3MKW0OPRIlS0D3R?=
 =?iso-8859-1?Q?/ukR184W9zFO+qfF61tKYsXcfcRpN5tYnKVl+lNQcCfBBm6Ut7qlRgJbyu?=
 =?iso-8859-1?Q?rox4iTM7pMmdJM10QxZ5nxnu3+M3jICUAe+31plMFJP8cBDIpADCWB6weR?=
 =?iso-8859-1?Q?3PitOSuNzEz6Yug53anNIG9unLdaVlhkROkJqVv6pGSReEltMUdA6EOZVZ?=
 =?iso-8859-1?Q?OAwbdwmcxhxzxABV4Pe0Mvqgze1ViBIk2OabmuGVbVfs5E0Hg3fJHw/YQ0?=
 =?iso-8859-1?Q?LSGxde1djGg8JGS0n8TkUfTHvd+rdVuXO8fAZATJNaeRsWDmxIj3afYzu0?=
 =?iso-8859-1?Q?hHB1t128Y2hLqhxYUBs6KVJaIdCXkVKoqiGOIvVTZ5Gu0xEvLTaJNNbMRA?=
 =?iso-8859-1?Q?4O9ujoFvCUfYagFBeFLlia/cMldwlre6Ib4jmphppn+pstu5V5ylUXPI2h?=
 =?iso-8859-1?Q?CTy1RssTMeMNsWzfqpJDvFQxst/eKljlA4AFoSrEldnVeq5t81jVVwoAZR?=
 =?iso-8859-1?Q?5NUvTtgUt1RAVXeX7/KveuJ0S5C7DYN0q272MxWB/B7JdrM5OzWxEDVj55?=
 =?iso-8859-1?Q?CI3uBdXL//ph6gLSjiXQE+vC/YxAgbZnDLYh5hCSsHDhrVwKsGL15l+Oe+?=
 =?iso-8859-1?Q?as/v3IGs3C6nfVZX3at?=
x-microsoft-antispam-prvs: <AM5PR0402MB2867C5A9736DFF1A1C97C319F17C0@AM5PR0402MB2867.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(81166006)(81156014)(71190400001)(71200400001)(50226002)(8676002)(256004)(2906002)(68736007)(476003)(2616005)(106356001)(8936002)(66066001)(97736004)(1076003)(105586002)(478600001)(6486002)(186003)(14454004)(99286004)(110136005)(316002)(25786009)(3846002)(26005)(6116002)(6512007)(86362001)(4326008)(486006)(36756003)(5660300002)(7736002)(446003)(11346002)(305945005)(53936002)(52116002)(102836004)(76176011)(6436002)(386003)(6506007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2867;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q8iM7lxM9116pgk1tbHCEajRP8HieDo+oDaqHtvEcQ/Xxc7e0QQSJATOV5Sk98R9Hl1j+T+dTGi+FOGJwAp57BJlbYRSUonauhI3tNvQ3DFUPHBvgGzWnOFzUyysnLWSc0xU1W1pcfw9FdkEh7vQeiupO0wCickw2fa/287mupVCkdmmokeoKi41B5+wkNE7SpopnZ62jSAfmwmcPOjo+S0BgjlmW5CDXEfAJYskj3EF6qsECFM1Jqq0KrX/QNeeTLzLm2Tf7cYOb85kI7p/HOrQiP4QDKYpZw3eaniTCsb4DEGzMk64IIiULUCnq49wv+o0TccpIMQoaTrxAAW5vdFr0NiuWV/wD4Attmq6ZlLUiRxCnVvmn4XEy8FcVKWaNI6yAMdDuZbA8IPDne8Di8mtUI/s33N6dTLAda15SL0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2c3be0-d045-430f-cc01-08d6963b1e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 07:23:14.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
(or its control signal) will be turned on immediately on related Root Hub
ports. Then, the VBUS is turned off for a little while(15us) when do xhci
reset (conducted by xhci driver) and back to normal finally, we can
observe a negative glitch of related signal happen.

This VBUS glitch might cause some USB devices enumeration fail if kernel
boot with them connected. Such as LS1012AFWRY/LS1043ARDB/LX2160AQDS
/LS1088ARDB with Kingston 16GB USB2.0/Kingston USB3.0/JetFlash Transcend
4GB USB2.0 drives. The fail cases include enumerated as full-speed device
or report wrong device descriptor, etc.

One SW workaround which can fix this is by programing all xhci PORTSC[PP]
to 0 to turn off VBUS immediately after setting host mode in DWC3 driver
(per signal measurement result, it will be too late to do it in
xhci-plat.c or xhci.c). Then, after xhci reset complete in xhci driver,
PORTSC[PP]s' value will back to 1 automatically and VBUS on at that time,
no glitch happen and normal enumeration process has no impact.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - Rename related property to 'snps,host-vbus-glitches'
  - Rename related dwc member to 'host_vbus_glitches'
  - Add member 'host_vbus_glitches' description in 'dwc3'

 drivers/usb/dwc3/core.c |   47 +++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/usb/dwc3/core.h |   12 +++++++++++-
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f..02d11bc 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -100,6 +100,41 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
=20
+/*
+ * dwc3_power_of_all_roothub_ports - Power off all Root hub ports
+ * @dwc3: Pointer to our controller context structure
+ */
+static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
+{
+	int i, port_num;
+	u32 reg, op_regs_base, offset;
+	void __iomem		*xhci_regs;
+
+	/* xhci regs is not mapped yet, do it temperary here */
+	if (dwc->xhci_resources[0].start) {
+		xhci_regs =3D ioremap(dwc->xhci_resources[0].start,
+				DWC3_XHCI_REGS_END);
+		if (IS_ERR(xhci_regs)) {
+			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
+			return;
+		}
+
+		op_regs_base =3D HC_LENGTH(readl(xhci_regs));
+		reg =3D readl(xhci_regs + XHCI_HCSPARAMS1);
+		port_num =3D HCS_MAX_PORTS(reg);
+
+		for (i =3D 1; i <=3D port_num; i++) {
+			offset =3D op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
+			reg =3D readl(xhci_regs + offset);
+			reg &=3D ~PORT_POWER;
+			writel(reg, xhci_regs + offset);
+		}
+
+		iounmap(xhci_regs);
+	} else
+		dev_err(dwc->dev, "xhci base reg invalid\n");
+}
+
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -109,6 +144,15 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
=20
+	/*
+	 * We have to power off all Root hub ports immediately after DWC3 set
+	 * to host mode to avoid VBUS glitch happen when xhci get reset later.
+	 */
+	if (dwc->host_vbus_glitches) {
+		if (mode =3D=3D DWC3_GCTL_PRTCAP_HOST)
+			dwc3_power_off_all_roothub_ports(dwc);
+	}
+
 	dwc->current_dr_role =3D mode;
 }
=20
@@ -1306,6 +1350,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_metastability_quirk =3D device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
=20
+	dwc->host_vbus_glitches =3D device_property_read_bool(dev,
+				"snps,host-vbus-glitches");
+
 	dwc->lpm_nyet_threshold =3D lpm_nyet_threshold;
 	dwc->tx_de_emphasis =3D tx_de_emphasis;
=20
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df87641..9b3a7ed 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -606,6 +606,14 @@
 #define DWC3_OSTS_VBUSVLD		BIT(1)
 #define DWC3_OSTS_CONIDSTS		BIT(0)
=20
+/* Partial XHCI Register and Bit fields for quirk */
+#define XHCI_HCSPARAMS1		0x4
+#define XHCI_PORTSC_BASE	0x400
+#define PORT_POWER			(1 << 9)
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+#define XHCI_HC_LENGTH(p)	(((p)>>00)&0x00ff)
+#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
+
 /* Structures */
=20
 struct dwc3_trb;
@@ -1024,6 +1032,8 @@ struct dwc3_scratchpad_array {
  * 	2	- No de-emphasis
  * 	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @host-vbus-glitches: set to avoid vbus glitch during
+ *                      xhci reset.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
  */
@@ -1209,6 +1219,7 @@ struct dwc3 {
 	unsigned		tx_de_emphasis:2;
=20
 	unsigned		dis_metastability_quirk:1;
+	unsigned		host_vbus_glitches:1;
=20
 	u16			imod_interval;
 };
@@ -1217,7 +1228,6 @@ struct dwc3 {
 #define INCRX_UNDEF_LENGTH_BURST_MODE 1
=20
 #define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
-
 /* -----------------------------------------------------------------------=
--- */
=20
 struct dwc3_event_type {
--=20
1.7.1

