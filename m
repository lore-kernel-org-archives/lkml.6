Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02104C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0AF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BugiXyKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0AF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeJYPdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:33:12 -0400
Received: from mail-he1eur01on0078.outbound.protection.outlook.com ([104.47.0.78]:47472
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbeJYPdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Tw12xB1ajkqPXg0EQ6CyGxy6i6KHRsX+WOfIzWGsZE=;
 b=BugiXyKcxpMo5ktDgMZxDlD7rzequPIdopunW/SFhys0Imj4Do3Al3KGsF2zXVrYleNCio1/5TBzd4ReO9pN+ROupF6Toi4+Oj8RCj3xXSc1bzVuQv7BK32kc8qtO8/gfWYP0emtK0HZo9eneDbOaO+gb6TAEliXL5q0VL53JiU=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.20; Thu, 25 Oct 2018 07:01:41 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:01:41 +0000
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
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v6 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Topic: [PATCH v6 2/6] soc/fsl/guts: Add definition for LX2160A
Thread-Index: AQHUbDCUExVIB/DJSEqaajKdSla7BA==
Date:   Thu, 25 Oct 2018 07:01:41 +0000
Message-ID: <1540407376-24115-3-git-send-email-vabhav.sharma@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:7InQXxy83fFD8U6GgZNvQCrhxi+y990TpvOKnUYeXJLI5wgMsDeRx8PCDwClmOiwsTBjA8Xb7+FJZZpr+RniJQbUNuuYUry20IymNzqsIB4arYhA6u+v8tukV+KOCMB5p9XYGZj56ivleXr2aTg8AtcbMPdmDApwZK72OCzRWG+KsXjXd4RguYZ8SwgUc9J/+hbjFlAxr1xgDwEf9za47/MEZ2cpLwk3Ke4x3yi/2wNqMF4Ik6GYTttCX6zLUhV7yRhwjxYW4lK8IepCdN4REqmf+C73G2KGH66O/S6/h19y4Xj8OrfLWnanpluUZl9pZZJcGMsQrJ7wC9K3m5BoXSlVW4zIdBqlZdoVKbv3pNI+zeEPXQVWexhP2PTwwx2oLhm0QZnxAHX3bQ2Qe0cEiYzErFV7soAj2liyL85YUwCzo3boQ4mXRCoouUsINvyYpnwXWh/qS/G7nyBDLm2llg==;5:ohNbKfpkR7HMRC2lTmuWEi+lZNkZgZn6cP/iXDDpRjQVzBpPiXM1lbL5wTMCqaTn5TR5ijR3jfxsH4l0BWUJ7Ia19DuKi59+Br4h/LtjXgmn8tXW+dy0BR5otBkMURq5hNRvT+s1CABPv/ePG4v90mEduPtCgqhnuCgUwzDrLcU=;7:4w+sDNllSds9Z5b+bbHMBmDogX/VXXu7OUYD3MIEA+h1pHLo2knCoj90BTzb48CkSqGwkc4EI/5ma09Rs9mLVdMpOQQo/2WbL4taWctDUpLO8fcWX+dfzXeKtPmpz2xTqTAbmma16F3a0DsXTfux9w==
x-ms-office365-filtering-correlation-id: 17a95b87-7509-42a6-7f7e-08d63a47b71f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB3055100EEB0D4E8F21AFEEE8F3F70@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(189003)(199004)(5250100002)(86362001)(2201001)(575784001)(446003)(68736007)(81156014)(81166006)(97736004)(54906003)(4326008)(476003)(478600001)(26005)(102836004)(5660300001)(6486002)(44832011)(316002)(2616005)(25786009)(11346002)(486006)(36756003)(7736002)(305945005)(110136005)(99286004)(52116002)(7416002)(105586002)(76176011)(14454004)(71200400001)(386003)(71190400001)(6506007)(55236004)(186003)(2906002)(106356001)(256004)(6436002)(6116002)(8936002)(3846002)(8676002)(6512007)(2501003)(53936002)(66066001)(2900100001)(921003)(1121003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ozibUYzf5dlAljaiJFYT37nw4MBu6pIAGvsK/nS5+a9Jd5x7Ze6CioQScMlSHKLoJhqK0eYoE7qNrMX0YQc3UTS48giiBZgR+HJylqzD8RwWgaoIjmGbklUwI05scJ9cu5cEXZkHLhsn1eCgffMdRFXzP1V3VAwUIwp49cF1TjTEtiny0ALLWlF3hNS/Sc6bFp/Mz9O8xokqbbGs2wjiGoWAdxjR4WMhtls05BaJ/v3lTflsgw3g61Wt9Vu6skDn9lsRg8jZCQ0zNlC8T8WwmP+eMIlm8Gdtct56e8vGbeJU9uYhvJtd1+kt3NWb35SpZ+t3bu3IzotDuydlQpNEcI3mdABG4vSZXeQUuaJsgIk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a95b87-7509-42a6-7f7e-08d63a47b71f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:01:41.4043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..bcab1ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =3D=
 {
 	  .svr		=3D 0x87000000,
 	  .mask		=3D 0xfff70000,
 	},
+	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	{ .die          =3D "LX2160A",
+	  .svr          =3D 0x87360000,
+	  .mask         =3D 0xff3f0000,
+	},
 	{ },
 };
=20
@@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] =
=3D {
 	{ .compatible =3D "fsl,ls1088a-dcfg", },
 	{ .compatible =3D "fsl,ls1012a-dcfg", },
 	{ .compatible =3D "fsl,ls1046a-dcfg", },
+	{ .compatible =3D "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
--=20
2.7.4

