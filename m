Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C40ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223C20847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UvP620aY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D223C20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJYPdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:33:18 -0400
Received: from mail-he1eur01on0052.outbound.protection.outlook.com ([104.47.0.52]:21305
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727117AbeJYPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g88fk7r3K7OfiwRynUBeicxdrF3GKieQcJWEL6amKlE=;
 b=UvP620aYxyfhFoe0beTZ1NZE4rFOevdpnlJi017OJZMEUVQsQcczYbEQcoOYXydJMl8bL0uEesuj97hhjOsDrjzqui9WBhp4cDMSn/lVtxKDWVhtn7o4hWbi8ycpooT5KQuMd0ToV+GYpaVH88JMsV/SHvDbDvgzT/78gRqDOx4=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Thu, 25 Oct 2018 07:01:47 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:01:47 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "oss@buserror.net" <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v6 3/6] clk: qoriq: increase array size of cmux_to_group
Thread-Topic: [PATCH v6 3/6] clk: qoriq: increase array size of cmux_to_group
Thread-Index: AQHUbDCYC3oxFn5O8EOzjZ4dhKNbXQ==
Date:   Thu, 25 Oct 2018 07:01:47 +0000
Message-ID: <1540407376-24115-4-git-send-email-vabhav.sharma@nxp.com>
References: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540407376-24115-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:MHy1xIw4vkopoaX+cqcsNxM0UCUQEtv84ZLm+R5n33DcrT+HipCpvz+vseLpkW6g7oD4RUdF8yk2H1w9f7WTJkiuw0Rr2HTK8H3znTuJTueNCznCpwk1FtO3IrDuE2fMOzbPhhK/GpA0UxLYCgzjoTYFjqf8B58LrokyoThN2uvSRtavTj+o9YGII5+yTEYzsEJL9EI04hPlSCiB9Iq7wBQ82l85z6lBg0qx8K/ISDsgEBq8BcI3irBb+1KyVvLABMOimMvFTs1PTnbCvrhNoiENVCm1PGHBeZUYvtnWlGTMYkkPJXNGCZfHzN6M44BjLyImGjGE0CHJOhCG07vkHxYZtX4kIDtGCNO0OtHIgkx2CuDWl+d0ykVups6pb7dV9qfJw8b04OxBpXHIjjeL6v/Guj0Lvb6j3AKVMxqztSgbK4ExCUFrfzMEt0LncapMsGTebqJYu2Vpd97LRQ6yGQ==;5:/OHR4CIDN8sJes6RElJlZKAVLfinu62LWUALbfOkuK7Ps6JfdfzL7FUsRrvkP/wWVifMYI9UyRh67F43KKfbB1SElaR/hPLILuuq9uDQdqqo9SKZ+aZ7X+u/MKCMWxr5XiOZtIkguluxFFVZYTUPT01zjtYQ6fJzrnoLWjIcIMY=;7:fPdn3GDsnCGEOAeUWmoPylXXhDtvWbyD7f1PiYy4njyWyhO5XUdXTMOdT7Ptx07b04+PLXEA8xfTVVp1oFmaLxygWW8Jw+6PgRxhSifWkXxblHD/E0Tr5LW6CT0WDVAm2QASOUIQX3c2CcrktUnDQA==
x-ms-office365-filtering-correlation-id: 40e6b7ae-3c41-4fcd-2b23-08d63a47bad9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB3055FE103997A0F0068570B8F3F70@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(5250100002)(86362001)(2201001)(446003)(68736007)(81156014)(81166006)(97736004)(54906003)(4326008)(476003)(478600001)(26005)(102836004)(5660300001)(6486002)(44832011)(316002)(2616005)(25786009)(11346002)(486006)(36756003)(7736002)(305945005)(110136005)(99286004)(52116002)(7416002)(105586002)(76176011)(14454004)(71200400001)(386003)(71190400001)(6506007)(55236004)(186003)(2906002)(106356001)(256004)(14444005)(6436002)(6116002)(8936002)(3846002)(8676002)(6512007)(2501003)(53936002)(66066001)(2900100001)(921003)(21314003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QEGGqWCJVfLFp+mRB+oC/0NaOgF0vQbh1rMl6IcMlJcqXxTkWqyg9/9AHq43k3C9cGO8YmhQ7in4scRUKZdCVUfUiN0dB3Ar1+wdvFVne47M6JEcq3fkJOIX9rmG14C7NOfATBj4JHo8njkEnkpC57idZiyA0OeSpbU2RKNI/40U1oMJ8XOwfN1XR5y4yRiUV8VqsBTy4iCThVpNZv6mv9swglUNV5ZgWek9vV08UwWLBbi2Bk9VlTO+7P7YJBJcl6oG1l+YYLglDqkuNH6U9dSbf3XnAx6n2Wzg3odQlGJ+INYGywx7Qba9GzXAE4Gd49g2mkJul5UFBdUghIXdV6bbQ0JfQ3wRsTR9IlIVA7E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e6b7ae-3c41-4fcd-2b23-08d63a47bad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:01:47.6699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Increase size of cmux_to_group array, to accomdate entry of
-1 termination.

Added -1, terminated, entry for 4080_cmux_grpX.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..e152bfb 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -79,7 +79,7 @@ struct clockgen_chipinfo {
 	const struct clockgen_muxinfo *cmux_groups[2];
 	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
 	void (*init_periph)(struct clockgen *cg);
-	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_CMUX */
+	int cmux_to_group[NUM_CMUX+1]; /* array should be -1 terminated */
 	u32 pll_mask;	/* 1 << n bit set if PLL n is valid */
 	u32 flags;	/* CG_xxx */
 };
@@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] =3D {
 			&p4080_cmux_grp1, &p4080_cmux_grp2
 		},
 		.cmux_to_group =3D {
-			0, 0, 0, 0, 1, 1, 1, 1
+			0, 0, 0, 0, 1, 1, 1, 1, -1
 		},
 		.pll_mask =3D 0x1f,
 	},
--=20
2.7.4

