Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65363C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292772173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NJRLoGGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfBZIes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:34:48 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:35265
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727115AbfBZIeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUwFwSIdfiDEo6k9YkpeFTU6ChkELgnRTCdvU3pJ+DI=;
 b=NJRLoGGOmiauh45GmNweuHQQ4gotoKGeg/Fx8yusmnNxagJEANk4SI6DJT2iJZ0FPD1HU5HaGBcVW7mY/lo2OoqCk0Da2h/29SdWbyk+Lkss1O/o9FHoxabDlORpSZHWp/oLeaXE7/l2MiBvBCg3dZ4gyoLQ0FGO08lnv5Vc5jM=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB1645.eurprd04.prod.outlook.com (10.164.84.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:34:41 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:34:41 +0000
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
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 3/4] clk: qoriq: increase array size of cmux_to_group
Thread-Topic: [PATCH 3/4] clk: qoriq: increase array size of cmux_to_group
Thread-Index: AQHUza4d/teqfsBUD02fLzxmh9m0lg==
Date:   Tue, 26 Feb 2019 08:34:40 +0000
Message-ID: <1551126463-5341-4-git-send-email-vabhav.sharma@nxp.com>
References: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::23) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eb8fd5b-19bf-49db-f87a-08d69bc53ffd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1645;
x-ms-traffictypediagnostic: VI1PR04MB1645:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR04MB1645;23:FOITSOP/sx5kluSzQvBtgK2T5t9QsxbLIbU2Drg?=
 =?iso-8859-1?Q?Fsgx+sfzlan8r9EWXku1PD6gVvHI9Dt06kT1aCrofOPT5luFgsuAo5/RMg?=
 =?iso-8859-1?Q?77+voetuQHKuaPMyFPeUlJdxP+0pvUvTydP+jIZyFBF8FhQ+epgv/Jcgb0?=
 =?iso-8859-1?Q?3gp9yw/11TOsNWk3ZSdFTFAi7Nq/GaFMgdsVGrynx47HZfO1oLFXyquSBy?=
 =?iso-8859-1?Q?MpZsHTtfFKYimQzzct/MRMPw2J+/zXv/pvQnv5ABb87+5sLTAgdVXifYe+?=
 =?iso-8859-1?Q?/zNgdV3AgsBNGF2Ix9GN2W23hlgfDM25hZc8Rgp20oCtvWbfQGJKKt/1gJ?=
 =?iso-8859-1?Q?OoPb46Sexg5PSCgtxZaJ7Sa5V8RpVLjW3Sg/FTP773ghXKFpuluEWqYtuq?=
 =?iso-8859-1?Q?SOEkw9yECXQmOSip/p5GlAJ2XU27189+xS5f3LAYYg/GaO9edJYbVFGJm4?=
 =?iso-8859-1?Q?6PqW6hlcTFDPf/Ymws0NOYwAMeaqcWGnPMSrvJVsb8FcKTQTny5OayGiPH?=
 =?iso-8859-1?Q?GJMEahjAOjin9SEEpEvM1nHIHJ15QI/P0GR+dbHIhTZPUrh6WYx2caX404?=
 =?iso-8859-1?Q?h685aKb39AolDHe07FDYw5Al9f+mHaWdMpA5VjwG/idb+y/6gNT9zvj+Kz?=
 =?iso-8859-1?Q?27JTGS3Ggzt881yVxmZXFL0KQClDDbjtMA83wIK6QlMNOcMMAEp+0R76nR?=
 =?iso-8859-1?Q?Yfam5Hf+DZgTau9rnfbaYo1fSg4/GAkyWl8AGabUKUHfH8cguz478pTcZF?=
 =?iso-8859-1?Q?Q2uwiNTUFwYwSp0e20KJ/mnAtHedaoJK19lTcC7tzio3aEMDqu/4pkVoCb?=
 =?iso-8859-1?Q?nlapWSQyeAVyP100efDuZGdS48FS6LzJrSRap+SMdjAt5lZP2jVbp80aLW?=
 =?iso-8859-1?Q?1O1fiJWnYwEXwHp36+TLoMo/5WO6MPK4FwRbQBOAmLYNyI0NQO/xk9j/dj?=
 =?iso-8859-1?Q?NekrP7Xubj+X/+TuOv7qNl4vNAZBwNlMDh1j8WqND1XzABZ8cB7BQf4aos?=
 =?iso-8859-1?Q?FPNbVAwePympOXOuRBkOVH5WuHNtEgc+/8YlCcBWRdeqBQmLxsgP3oJL+R?=
 =?iso-8859-1?Q?cTL1YeVMELn/Ybz/dkv953pTzuBwETi5ftU0aqANKY6qHFmEWRx2PrFIG5?=
 =?iso-8859-1?Q?h2+GqitVPw+Gk+WkptRRWU1uwNsfQ+/BbMhDkHcurvUn56msSRRoDD+VIs?=
 =?iso-8859-1?Q?8fJRlOl14T2VnuShibOzeNkCMulMdFB5u5v796mLrk+sdAwyRjItik/tLa?=
 =?iso-8859-1?Q?c9mpzPCvcsvMn5u8qBSp6tk7i1EgKuc51ummiX7q+gP1RHDvnO5l/JGXwd?=
 =?iso-8859-1?Q?uvYe+IWEtN+ReUelfHg2H7Eh0IGCqf1yQVxIzxNcgSSTSxpZB4a0lSuVmE?=
 =?iso-8859-1?Q?BQQfohLWAFCmy0aSE3BbEdJZkBj/x?=
x-microsoft-antispam-prvs: <VI1PR04MB16456F2AE8EB30AE3EF4254CF37B0@VI1PR04MB1645.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(71190400001)(446003)(11346002)(25786009)(476003)(2616005)(71200400001)(7416002)(2906002)(97736004)(316002)(4326008)(478600001)(6512007)(68736007)(6116002)(6486002)(44832011)(3846002)(6436002)(486006)(2501003)(105586002)(5660300002)(106356001)(81166006)(256004)(14444005)(386003)(52116002)(6506007)(7736002)(305945005)(50226002)(102836004)(2201001)(86362001)(26005)(53936002)(110136005)(8676002)(54906003)(14454004)(81156014)(8936002)(186003)(99286004)(76176011)(66066001)(36756003)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1645;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NKM055rnnlpxMvned1tUegnb37oaO9qx50EwolmvlIELgPpstyf/I3mAF5/wwNYOndFK9ppcunBF+gXFTrZi0pIPx5obLzC5R7xrgLaC4xc3XUPRJ23mEkldwW+p43Y9bCFEglh5+DqMP9ZnBZgYQ7y5UWz9FuByb8CZlGVXtHKvcnPbJuykT8DgUq8RQ5UkE6qfBAcle5UJyHzvdbjQIniTEhSAGE1Dqvz/ww0FNcqCDnnETDcVCHzjluFWQG2vWc51dBmhWWOGQNjWJ4yNrLX7Jny9qaDdLWcbFI0aoKY0qcl5X74LDORAMu/fQuc/Qmu92M+e+QE32XRoB0e1RN8G4SzrAKLnuhlmByAY8j5GGTjjYz6F3COv3rZ87xQVVUQdQw0ffaIump2MHNL+vkwgFQr+a/qqUlohiProdPY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb8fd5b-19bf-49db-f87a-08d69bc53ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:34:35.3255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1645
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
index 5baa9e0..e75194a 100644
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

