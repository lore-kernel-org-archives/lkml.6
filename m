Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4912C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2DC21A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xpWegG5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfBOSH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:07:26 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:62496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbfBOSHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64Gbv8mTZGwTjFXBT/zoc1XYi7GaCuv8nqQ1pUo5SAo=;
 b=xpWegG5K+jVzY9cCn+9oej3X6/ONidYOcrCic8t9gYDnL5nWuPO6pz3ripRYZTBFcHeDjKAP4H9/Ysc6D6Gwe73C+WY/ynCL37lrGA4lwRxUJ2MmF0QdufZO7PzQGqunzJ+a/YWBsKyEmq9JQ3tpSsT9ypxv/0yFrgupJAT5lRs=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4385.eurprd04.prod.outlook.com (52.135.149.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 18:07:21 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 18:07:21 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 0/3] arm: dts: imx8mq: Add cpufreq support
Thread-Topic: [PATCH v2 0/3] arm: dts: imx8mq: Add cpufreq support
Thread-Index: AQHUxVlLLuk9EJmTZE6fTpC+AJHATA==
Date:   Fri, 15 Feb 2019 18:07:21 +0000
Message-ID: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0043.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5faeb1e7-7254-4e34-8ff7-08d693706dee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4385;
x-ms-traffictypediagnostic: AM0PR04MB4385:
x-ms-exchange-purlcount: 2
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4385;23:pN1+kmkyCf6qpK6cjrqocajXbnqolZUikx+04dJ?=
 =?iso-8859-1?Q?0FIGmmoHs0q+Sqv6ra8L/IXElqzQA//aNCe4GKZQYcpj574kmeistwh3tB?=
 =?iso-8859-1?Q?y92Negh2sx0fciOqU5H2lmgyWzhDxoO3qh9lY9EFgvV1x7ufPuGxYZPZsp?=
 =?iso-8859-1?Q?eTsv5PTdOty7oOsIHbNWkuv+tMACrnxkUBejQov5op9LgfoPqokvUwuzQS?=
 =?iso-8859-1?Q?E2tULl9DNpxrGgtHWIUZ+E8dFgUylzZtVwgmJmvqxOSUAek7U9yEkQwr0U?=
 =?iso-8859-1?Q?zJHph9a5DoCVgFk1oTrci2aoNyOHU61XCSiHIePRsM2goMB+O+LuB9LdAS?=
 =?iso-8859-1?Q?kBfYJazzc0CQVgGCOZOPaYTNS33TjrH6rM+vblKTuC5bV45KMpd82b1Np8?=
 =?iso-8859-1?Q?OIEu6t4by0ih7r0Xa3KX3H30O71PyyI6kzNKPVr+lGpXXqfdJmV4JKQROa?=
 =?iso-8859-1?Q?DjrD0BguEiwORF6r7BgAmJczykEIKVfOzKDuIVuWwrMtdRimo8UX6+7niL?=
 =?iso-8859-1?Q?um+njDbMVAG6v3jmM9Y4ZlVinlhBek0pJjOL8b52fmOeHoU/GmMNjHEj2t?=
 =?iso-8859-1?Q?6W/fpf7ek+7mTs2+tdMD4IeFm38aC9YgGIugVGicFJ44rump3YYgtN2kGs?=
 =?iso-8859-1?Q?RVsAhCj7KPBjL0HY/xm1pNRwxTEvkmSuH0QLKKd1oKGFuvCg/2d0L4NomO?=
 =?iso-8859-1?Q?xbDgxOO+VoJOXBhxTDBZJdjsRHWsb83LZD8XaReHYevsHnBwbOhjXqTEM4?=
 =?iso-8859-1?Q?niPE9tSriqEdWG6GU0p2XFCLPR51+/ZEQWZH6b3JCxgfL5lF88vNRc10+P?=
 =?iso-8859-1?Q?uKjZx1KToJThNwefWvoblgSIIQltHlKIZiSkuuEx2UgkLOblztIgDv73v8?=
 =?iso-8859-1?Q?ApUE7Btus6Z1NF+X4Uxs5frickuinJRIv9QL4dVfcFoetp4tKo9v6fH+JB?=
 =?iso-8859-1?Q?rOqZnfnvyjK1Vu8XCVc0Aut/5OtHUHxh47w5qERUppM8LBxxP420YMpRYv?=
 =?iso-8859-1?Q?6xw3qBYG0wbFcjE1dn6MDo4hcxJivDMmfoSooX5V+SZ7rrmAxILRvlHRSC?=
 =?iso-8859-1?Q?79v+kJbGYVFxnajhYWENqGW2XvmQjzAfgtMyX2+VJ+J1K5wKovl20QUEkH?=
 =?iso-8859-1?Q?q2fRFrJ+qqY2s24zGm7O5eH5lkXXXUMUjDBq79+kw1+onetSsKAuetXCCY?=
 =?iso-8859-1?Q?0rTWu30u3IKyWgFI44y//0f6xIDbcS+DJwsBDOCPI79oW0LOKQ/YcNaGON?=
 =?iso-8859-1?Q?LH74JNoFLQuOR/MGEhMatigEGJwl4A1BkielOFA=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB43852DA1F6E96FC612257E53F6600@AM0PR04MB4385.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(189003)(199004)(305945005)(86362001)(97736004)(71200400001)(71190400001)(966005)(102836004)(14454004)(66066001)(478600001)(6506007)(6436002)(386003)(2906002)(7736002)(106356001)(105586002)(4744005)(44832011)(8676002)(6116002)(81166006)(36756003)(81156014)(3846002)(476003)(486006)(99286004)(52116002)(2616005)(8936002)(110136005)(14444005)(256004)(54906003)(316002)(26005)(53936002)(25786009)(6486002)(4326008)(6512007)(68736007)(186003)(50226002)(6306002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4385;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I4IwllaUP1+2iNhNia26X5v/QB5aYEpBWeOXC9CU3RI9ChjXSaZy5s+QbtgvVbv24Z4ABaW7dFzHZao0/RTsy3Lp9nMd9n1UryR7+k5FT51ofzfExpmMHv86IPy2A5PzWc+PyG+VeRVArAwNbDWpakertvFBNDRnO/OPXpXJJF9Qpn7WBHOSvwS5ZcsvriMvjo+4RhkNKgw19wPprSeqjRoHuCen6feG8tNGNgoO7Vv5P1/cTIdIWkQK11g+xJMv9+DvHgImElzr5Rzcdt3oQwI4+jUlBtAz+uwdkdIoTAwxJXnN0I0At2EeXQJbYDwHk8GA9udL8WVsOu+GYffjpueHHm5wSC/E8zCSYwJjpY3EePIAZu8e8dK8DDupJTRUibOb/3Ka7K/RmFvyljJLjWt5khTe8h+R+mKogXyvOKw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faeb1e7-7254-4e34-8ff7-08d693706dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:07:20.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for this to not break the build, the following patchset will
have to get in first:

https://lkml.org/lkml/2019/2/15/695

This work is actually a second version of the cpufreq related part of the
following RFC:

https://lkml.org/lkml/2019/2/13/1111

Changes since RFC:
 * added the gpio-regulator for cpu-supply as suggested by Lucas Stach
 * split the patch for opp table and the cpu supply nodes in two
   as suggested by Lucas Stach
 * changed the voltage for 1GHz opp as suggested by Angus Ainslie

Abel Vesa (3):
  arm64: dts: imx8mq: Add the clocks and the latencies for the A53 cores
  arm64: dts: imx8mq: Add the buck vdd_arm regulator
  arm64: dts: imx8mq: Add the opp table and cores opp properties

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 36 ++++++++++++++++++++++++=
++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 31 ++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

--=20
2.7.4

