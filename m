Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F92C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2720C253FF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hWmBFWr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2720C253FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932219AbeGBAzs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:55:48 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:40256
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932182AbeGBAzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIa3ox4w5vZwIMLSHn/S7YLnmMe6suzew7H/ZE0xh5g=;
 b=hWmBFWr0+AwdtXwcKsEkVLzLq/22buTSWv8moKeD/3weYLNt/jfmiY8k8X+qRYDXsKhwXwZyytLFVxXp+aiSxK/wr+bnMWikKYG5u4zRASAkhaU6jNP+KBDcLSZS+J3DVFq2Kfr5WuHVR/9TVPun66HgFYaybzBGYyZNa47Rh0w=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1395.eurprd04.prod.outlook.com (10.163.185.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Mon, 2 Jul 2018 00:55:41 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 00:55:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Thread-Topic: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Thread-Index: AQHUDbZSkIiE51TltU+r3rNOQ7jbH6R6ZI8AgAC+WVA=
Date:   Mon, 2 Jul 2018 00:55:41 +0000
Message-ID: <AM3PR04MB1315C55572F4A1B1581CC5B4F5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530062725-25779-1-git-send-email-Anson.Huang@nxp.com>
 <20180701133243.GU4348@dragon>
In-Reply-To: <20180701133243.GU4348@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1395;7:0XohmJjZcfjZT1t8D4ySEo578OHoZzJi7C6FR1XjaxJpsyPFktbOj02iqcpZCmUnymCjCMAQptpwuVZkN4mvULj4ibrgMcB+U3KxKh41k2B9zsYPkQo+rc51rlsccAyGYAl2IBLTf3Mb841mPZ2v7sISuDgbIOEoeT7S0fPoqmKXacobSbz27j8/S462FLSQfVTdlauLUFpQq++Bytvz8203i1XIfSSs7BWpD96hwb5+IAFeXRCNYQfBvycfeQyj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 507066c5-fe1b-4751-2343-08d5dfb688f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1395;
x-ms-traffictypediagnostic: AM3PR04MB1395:
x-microsoft-antispam-prvs: <AM3PR04MB139547376E3B56D51BE67535F5430@AM3PR04MB1395.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1395;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1395;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(13464003)(2900100001)(44832011)(4326008)(14444005)(486006)(6436002)(476003)(53546011)(6246003)(7696005)(97736004)(55016002)(9686003)(446003)(76176011)(6506007)(11346002)(229853002)(256004)(2906002)(14454004)(25786009)(6306002)(6116002)(33656002)(305945005)(53936002)(54906003)(105586002)(8676002)(316002)(8936002)(74316002)(3846002)(7736002)(106356001)(68736007)(966005)(66066001)(45080400002)(26005)(86362001)(478600001)(5250100002)(81166006)(99286004)(186003)(102836004)(5660300001)(6916009)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1395;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ko/WE0vMzpU/oRhi4wpRaELk4S6kJ/T8QGDH+ULL93Kg8Fzlx1JpCuQZ6LLc1J8+t9J68otrTqb2Ep7tXhbJN88cEMOBTePnP7Y20E4PtwBv8qbQvSqVEdAKdozkbx6fJBvUg4k5OT07gUIr9vXvfmZOPYqYS2L/OZUBBidfhgRW9a9X1fgoI8t17TikWHvdiznxBmsPBy+E0EMglXFLTxyRioBNPZkPlDqUcVT6SJVChBgJazNwwuuADMIt72lzuCxDqrOmK1Hh2HhzfBH5BaES7P3HCZHDMd1nB86qq9M4qNQTwHRuaS+6KigT8ctxLLy5Uj+pdySS188mcfa9YTVt89HYQnXAvZFkz6BQNU0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507066c5-fe1b-4751-2343-08d5dfb688f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 00:55:41.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Sunday, July 1, 2018 9:33 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> devicetree@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always o=
n
>=20
> On Wed, Jun 27, 2018 at 09:25:25AM +0800, Anson Huang wrote:
> > On i.MX6SLL EVK board, PFuze100's SW4 is supplying LPDDR3, it needs to
> > be always on. This patch fixes Linux kernel boot up hang caused by
> > commit 5fe156f1cab4
> > ("regulator: pfuze100: add enable/disable for switch"), because SW4 is
> > turned off unexpectedly:
> >
> > [    1.693613] cfg80211: failed to load regulatory.db
> > [    1.700063] SW4: disabling
> > [    1.703973] SWBST: disabling
> >
> > Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
> > switch")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> Just want to understand if we agree to break the existing DTB with v4.18
> kernel?
>=20
> Shawn

The kernel patch will break with existing DTB on some i.MX platforms, how
to handle this case, just revert the kernel regulator patch?=20

Anson.

>=20
> > ---
> > changes since V2:
> > 	improve the way of referencing commit, and add fix tag.
> >  arch/arm/boot/dts/imx6sll-evk.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sll-evk.dts
> > b/arch/arm/boot/dts/imx6sll-evk.dts
> > index 4684ac4..2217c40 100644
> > --- a/arch/arm/boot/dts/imx6sll-evk.dts
> > +++ b/arch/arm/boot/dts/imx6sll-evk.dts
> > @@ -142,6 +142,7 @@
> >  			sw4_reg: sw4 {
> >  				regulator-min-microvolt =3D <800000>;
> >  				regulator-max-microvolt =3D <3300000>;
> > +				regulator-always-on;
> >  			};
> >
> >  			swbst_reg: swbst {
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
t
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&data=3D02%7C01%7
> >
> CAnson.Huang%40nxp.com%7C614a104918884539521a08d5df572851%7C686
> ea1d3bc
> >
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C636660487794141749&sdata=3D1%2B
> EKM%2Bnx
> > egyDGLc%2FHt9cbh%2BARlMSsoJP%2FbD6HlxwVFs%3D&reserved=3D0
