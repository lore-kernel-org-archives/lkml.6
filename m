Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA63C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5B8217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lUOHoTvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBZHIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:08:16 -0500
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:21797
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfBZHIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ruERQqTuOXuHFDgyQM4iBb5WWNMfL9mvlnlwamFQ0Q=;
 b=lUOHoTvlSTlS2A2UW3lBn3HXimOgDZhS+4qTa3zcxmew0B4pUZ/4N0nLFMpWJijh+U1cLA42tb7udsdwsgfmuqUpmIxdUNWo8gOojNhOLETpfLxtNjH/pzM3L0MvCOOUZMC38BcvLzFOfmDjoW3n+5jPd1i7SlrbWUiaJzxCRBw=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3741.eurprd04.prod.outlook.com (52.134.15.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 07:08:11 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 07:08:11 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
Thread-Topic: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
Thread-Index: AQHUzaIIT88cE3xLDkC5V2BVcwNH0g==
Date:   Tue, 26 Feb 2019 07:08:11 +0000
Message-ID: <20190226070742.30551-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06a5ca2f-5890-4548-0506-08d69bb92abd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3741;
x-ms-traffictypediagnostic: VI1PR0402MB3741:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3741;23:oxjEWml1F3De+AUtQMK4A4mu90X1kqf36H2F4?=
 =?iso-8859-1?Q?esjmnKyE7aodq5zF7YbJzF4fVZOye3jw74tulNLhjMs0otSEJ60wPa4qgz?=
 =?iso-8859-1?Q?V2qmmEUmrUoPG15AZH5glmi6gwz88MF4XLJNKREfOta+MBBFVuob+/djnB?=
 =?iso-8859-1?Q?gluu3OlSneg6vpQV41biqp486Tm2LoXHsw2pJ0m15QvBF91PIIlvnubP/J?=
 =?iso-8859-1?Q?CuLISf33bAzdDReK/BPWC2Hu8YzL85cXMggKHCFbPDnNAy3D1bncK+1QyI?=
 =?iso-8859-1?Q?idwvue2nZEfq3OddTlr9tp0BOO/Sk1uoxO608ofQSV53SEshQ3nWwIukmC?=
 =?iso-8859-1?Q?hEuat54p5ocXiC812RrWAyHx0e2R7MGbtdoR8nCzc4lPo3+KD/6JT7khdF?=
 =?iso-8859-1?Q?K30BiBAryafnh+AtsdtZE3e1ryjqXEi95yEC6O4U5w3Rz+jKwAS4Gmnoga?=
 =?iso-8859-1?Q?BVlCDpeRBeA9PehzEh9L892W1w36SbL7vOi+XGnXvS8ZHl6RxROn/eJgTU?=
 =?iso-8859-1?Q?kqoOstYfYwRqHi+XnoKiCjwO6IcmW6jfzz7F5+TNl8XZuVu/XdCDVpIND6?=
 =?iso-8859-1?Q?UfleHVcUoxrshyjT7jedOov57hWypazuJa+PQgqI1hDXviz5cRt6WzVij5?=
 =?iso-8859-1?Q?j8IbBu4fjeI42aci2OnA7xYMq0FIgW4Vml/P35fxtyeIubeioH/GqGiBl6?=
 =?iso-8859-1?Q?TyX21qtz3BEgtORrHERApWQ0rTR+6r5oYS5NmiWExUf4ducCiKjyn9w6IT?=
 =?iso-8859-1?Q?hxnbDn2TLnSvLQZW33wnzjapxLTnylo0VKAIRfX9Y4LPUOEuqal9Y6pigz?=
 =?iso-8859-1?Q?ZCmmphpwa3saH40iia03mhDWI5D2ip428dmzEptuUVJECqa15qGqd9ykDt?=
 =?iso-8859-1?Q?RvJwMc4Cg70IexMNvoISJO2c4C+X7uLlH/WOEHHM9kGutKImz6KS7cf19u?=
 =?iso-8859-1?Q?PRW7wgCgF/hNIqzJT8Zz0WRd2hRHBsOSPumXCS6Wo5sHIINT9clIfvwfqJ?=
 =?iso-8859-1?Q?RkRfbLYPDdWoaTN3VhaBDNvhSkjlp5+qjAGunC7f6dDIVYHoVB/Ls81ZnU?=
 =?iso-8859-1?Q?u1T44dbJklqwAcOeBzcTMcziPIL31d1XUrbcI9MXA1g9bBr5DO63U3RxIh?=
 =?iso-8859-1?Q?n4sRv0jXizOAoFIkLVOaLTQ8LX2ec8xz2k5WCxGRq9Yb641okaBOVPXjyZ?=
 =?iso-8859-1?Q?+TrJankjkglesVcK/r9SdLMAXGJO7/s4IkwHtkjERbe96PPVqWOJ/aRdpR?=
 =?iso-8859-1?Q?AXq49gmy297KyyiJt48Y1lKAvzHZp9FxJkThLp3Rwmp1rPuChMvqnFmkc6?=
 =?iso-8859-1?Q?JxOtCAFAFdsr0hbI+81E+B61ztwXeQ4ue2RNWQ9enUMViFrGTDbPcJo1W8?=
 =?iso-8859-1?Q?4m2TbnOkxQ=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB37413F8262EC96E5305A2D5BF97B0@VI1PR0402MB3741.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(4744005)(3846002)(6116002)(305945005)(7736002)(6486002)(6436002)(1076003)(2906002)(71200400001)(71190400001)(54906003)(8676002)(1730700003)(50226002)(316002)(8936002)(81156014)(81166006)(6512007)(53936002)(5640700003)(66066001)(478600001)(486006)(7416002)(14444005)(68736007)(6916009)(6506007)(5660300002)(2616005)(386003)(476003)(2501003)(2351001)(97736004)(36756003)(86362001)(99286004)(4326008)(186003)(106356001)(44832011)(105586002)(26005)(256004)(14454004)(25786009)(52116002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3741;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Ji0rAwYB1jZkFD7y7vyFEk1LclyR127cricxpy8UJvXdI0doubYsVVHttUNx3e8Mky27UaTNto7Bk/gl82cVc4WpEs7vDqps6nfvJ4BZ54F6YPRVVCBByeR3PgJCrHD+HOusAUHhVi3i/jf/Kr9ejqnr4Hqpi4m9AxGsdFAExqi1GxcWGxZFcsAImGn9ZhUsE0pRXx+LRyUFXUkVP+rboa+4qlJ4sWMBruWXZW5HrDLzAF/B08hEOipfpaJcbfSVej/Np868CU3ykZNWKfjWGQQm7a9+TFYQigdt/xsOCSZuqk3LJR0yZkVVzsy84jeAN5OVkXZ/ygwE6h5fQDI6rWkPmNo3zqtSzp+C07dNkAMLtUasLdxKNWXHZivs5Phc7131zydNGGEf5BrnF+urcTQHdwD02REe49tG2mvuWc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a5ca2f-5890-4548-0506-08d69bb92abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 07:08:09.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MQ we can start the party using the wm8524 codec
which gets it's data through the SAI2 interface.

In order to make it work this patch series enables the SDMA nodes,
sets the correct pinctrl configuration and uses the simple card
machine driver to put everything together.

Changes since v2:
	- s/QM/MQ after Chris comments

Changes since v1:
	- added cover letter
	- remove "fsl,imx8mq-sdma" compatible for sdma.

Daniel Baluta (5):
  arm64: dts: imx8mq: Add SDMA nodes
  arm64: dts: imx8mq: Add SAI2 node
  arm64: dts: imx8mq: Add SAI pinctrl configuration
  arm64: dts: imx8mq: Enable SAI2 for wm8524 codec
  arm64: dts: imx8mq: Enable wm8524 codec

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 48 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 38 ++++++++++++++++
 2 files changed, 86 insertions(+)

--=20
2.17.1

