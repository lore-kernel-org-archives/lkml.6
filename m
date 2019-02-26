Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6EEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DAE213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bm2bgd4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfBZFST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:18:19 -0500
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:28112
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfBZFSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdG4fpdIqcF7kNKFaEbKoo9Qzhi8tF1AwxgmkSX7Wj0=;
 b=Bm2bgd4fgJX9LbTUKd0CayzevDSPwYZ854JsufOqLsq++S2f5b01+X8HkZfs3u9vXKRbg7iVJgTlBDX52FlKgcnlURzjMVRamASRo3kB/DCuYAtk0T1JwST6wAt84iNYTnJNeBzsTBGdgD+aJ7+EZAul860z15EwTKcitWjUPfo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3849.eurprd04.prod.outlook.com (52.134.71.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 05:17:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 05:17:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V7 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUzZKWDxpx7VRUrEmeH+eTWwjydA==
Date:   Tue, 26 Feb 2019 05:17:36 +0000
Message-ID: <1551157967-30925-2-git-send-email-Anson.Huang@nxp.com>
References: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fce1026b-800d-4c4f-cff1-08d69ba9b86b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3849;
x-ms-traffictypediagnostic: DB3PR0402MB3849:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3849;23:C3GI9+8qGDAvbm1dRcPq13fUD4xJypsmsym1l?=
 =?iso-8859-1?Q?Dgs4O3iLfbEvUL0fjRLQbcmmFV2VTusIsg7dsbwT/D9WMLZB0/kVqzM7gu?=
 =?iso-8859-1?Q?AcPMUqyM5u7qZHSqnGEvB7VJGnXnzvUps90hFrAFENSWp0MrSSfnw4ThHh?=
 =?iso-8859-1?Q?qRTkS29VjX157KDq8xPYjjSc3HxabGgFAXCxwpgWo7AisN2oWYdNLwMg90?=
 =?iso-8859-1?Q?aBtY3EXGr3nxfnpGDRgXngJmPTabGqZ7Ch4vTk4nIqdihrxP7IVFNZPTDs?=
 =?iso-8859-1?Q?9ygRaHVk+wMUQZVUDtNeJor0seGG7kNLuSequwzxq8taPD0EvQfkAeUsS0?=
 =?iso-8859-1?Q?bXSnCdcuo886ynvKUkQfdoN/TFNI4JupacOVeLLx/NoP1FUV2LAhiY6/NZ?=
 =?iso-8859-1?Q?VIqOwRTBztemQOnDafGV9+7NsumLn7TMj1N+HImGz5hwt4k6Qcdvj9HOzi?=
 =?iso-8859-1?Q?3LcOPx0ryiPGo53NJlNRyLV1x/x4u2+FF3GlBIR83pThW2jNtItekm4waP?=
 =?iso-8859-1?Q?1wv4J1svlzubsNZhZJDXIUhrpL/m6I1+IoQe2LaBsWP6M32jfpUxbnEgHB?=
 =?iso-8859-1?Q?rDrCFC5cR+Kq+rKcRn/hNeDouJYTIIcsVYzKgsUCqXCekdtCO3CudWvGPx?=
 =?iso-8859-1?Q?BbnalpZYGHStHFKOggRuB72AvD6IAJOlKyVIwfM0nRqHomtCjB6ucOHlDl?=
 =?iso-8859-1?Q?UMXkIgexGFIEdMV5aLhpfhyYX1GkXZjETEvRcOp/vaf8AqmdLt52Qosy66?=
 =?iso-8859-1?Q?ZVIdwbXAnngU4X+qAW6KnbkiTdAEf1JgupGqKKXr3APyqwkOhMYzTmy1Om?=
 =?iso-8859-1?Q?P0kVEfnjJTIPxIkP0rxXszJPZgYLA5J38LmrbbJQtQ0nEx/R21uuv7p/A6?=
 =?iso-8859-1?Q?NFHby+UQgZsmET2YYzT4tDMfkDXm7Y/sKuabfjANR7ca4y3ETVV2hU3HsV?=
 =?iso-8859-1?Q?PKZqj2HX3IKSwyJP7dKcTyEBpBeJK0KHHXfhWV2yFCXAAnjG4sq+GlEeOa?=
 =?iso-8859-1?Q?xjiedWByWaBUpG3FodFhRB4b8K3Da7fIcghXAuAD5u2m7Cv8kFAh1s2jtm?=
 =?iso-8859-1?Q?OK8f41xyFmHvJs67ST3OJRXtN8s7L59m/3tBCCvMGpzuQ5lEVOdZ8Db2MZ?=
 =?iso-8859-1?Q?atNpyos/jBWcbB/YGnvO8WLirM6xDage0BN0DPbAk8exgM33Dvjac7GogE?=
 =?iso-8859-1?Q?tELFrkHMWFbJ0uEEoD7HfuiEId6IDK6b8VSff6vlK8UQv08XAstWux4PSd?=
 =?iso-8859-1?Q?ZSfWMGVcZedy15xHsVJdBL6hvZ0C+w9t/k1YDqT1VrVzQq760KA0OcKz00?=
 =?iso-8859-1?Q?oSjkORWq4NXLlbqqSj/aEtPuu?=
x-microsoft-antispam-prvs: <DB3PR0402MB3849109879177DCF0FF55511F57B0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(6512007)(476003)(6486002)(186003)(2616005)(102836004)(26005)(76176011)(52116002)(4326008)(446003)(2501003)(86362001)(14454004)(11346002)(81166006)(6436002)(8676002)(81156014)(305945005)(2201001)(5660300002)(106356001)(97736004)(71200400001)(71190400001)(7736002)(105586002)(8936002)(486006)(7416002)(110136005)(99286004)(50226002)(36756003)(66066001)(68736007)(386003)(6506007)(478600001)(3846002)(6116002)(53936002)(14444005)(256004)(316002)(25786009)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3849;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jRhZHiVdPNmhKA1SNHTxRjsb70N4mhuC3cOqDZUuWsHfsP+lhru6F6Z7jYp+2KKU/3P+BAfRwC+TlT/CeQ9IaTUZd2YNBjZ1p/CnOWq2iZHOamhBrr9ijUEGIaR+BfVYPb5Zl+agm8Ziq6b0q5m00enjM79qMDhhu3rjdJJVP/TcZ3xHt1kYq7b7P5PZLYjjqx7amxXtpDFGK3hNkDKcF6nhd2Ih+eZUSntl5xmF6xCY41FfZ+0+h4uD+Ml9QTZL4I3ZH2pVLvqCLFgOY0+O4K179xI5guSJdVPPchzBQfQqQ8chmdzwC/fRU0CCx4VnfPe9o8JmUIZ6bKCaJLwgSz77JL6b6XV1fARUsWJLp4PejeLEq/XbcRBRVME0QEXkUelWjfw5CNK+23LkgjJ+4ZGahh9z0sIDExot+MxyCUo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce1026b-800d-4c4f-cff1-08d69ba9b86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 05:17:31.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NXP's i.MX SoCs with system controller inside, CPU frequency
scaling can ONLY be done by system controller firmware, and it
can ONLY be requested from secure mode, so Linux kernel has to
call ARM SMC to trap to ARM-Trusted-Firmware to request system
controller firmware to do CPU frequency scaling.

This patch adds i.MX system controller CPU frequency scaling support,
it reuses cpufreq-dt driver and implement the CPU frequency scaling
inside SCU clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V6:
	- add return fail to clk_scu_atf_set_cpu_rate() when the resource ID
	  is NOT expected, this is to avoid warning of uninitialized data usage.
---
 drivers/clk/imx/clk-scu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index f460526..fbef740 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -4,12 +4,17 @@
  *   Dong Aisheng <aisheng.dong@nxp.com>
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
=20
 #include "clk-scu.h"
=20
+#define IMX_SIP_CPUFREQ			0xC2000001
+#define IMX_SIP_SET_CPUFREQ		0x00
+
 static struct imx_sc_ipc *ccm_ipc_handle;
=20
 /*
@@ -180,6 +185,25 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsi=
gned long rate,
 	return rate;
 }
=20
+static int clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_scu *clk =3D to_clk_scu(hw);
+	struct arm_smccc_res res;
+	unsigned long cluster_id;
+
+	if (clk->rsrc_id =3D=3D IMX_SC_R_A35)
+		cluster_id =3D 0;
+	else
+		return -EINVAL;
+
+	/* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware */
+	arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+		      cluster_id, rate, 0, 0, 0, 0, &res);
+
+	return 0;
+}
+
 /*
  * clk_scu_set_rate - Set rate for a SCU clock
  * @hw: clock to change rate for
@@ -312,6 +336,14 @@ static const struct clk_ops clk_scu_ops =3D {
 	.unprepare =3D clk_scu_unprepare,
 };
=20
+static const struct clk_ops clk_scu_cpu_ops =3D {
+	.recalc_rate =3D clk_scu_recalc_rate,
+	.round_rate =3D clk_scu_round_rate,
+	.set_rate =3D clk_scu_atf_set_cpu_rate,
+	.prepare =3D clk_scu_prepare,
+	.unprepare =3D clk_scu_unprepare,
+};
+
 struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents=
,
 			     int num_parents, u32 rsrc_id, u8 clk_type)
 {
@@ -329,6 +361,10 @@ struct clk_hw *__imx_clk_scu(const char *name, const c=
har * const *parents,
=20
 	init.name =3D name;
 	init.ops =3D &clk_scu_ops;
+	if (rsrc_id =3D=3D IMX_SC_R_A35)
+		init.ops =3D &clk_scu_cpu_ops;
+	else
+		init.ops =3D &clk_scu_ops;
 	init.parent_names =3D parents;
 	init.num_parents =3D num_parents;
=20
--=20
2.7.4

