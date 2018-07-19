Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6412084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2NouOKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6412084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGSJMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:12:07 -0400
Received: from mail-he1eur01on0041.outbound.protection.outlook.com ([104.47.0.41]:59008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730304AbeGSJMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYeyZQZbxn6iLxdfM62in7ji/wOlYoWFVuQE9RPHmLg=;
 b=G2NouOKw3oKFE1N86m/sCCb4rkykGbEOUXe7MxRCxJV1pSZa36KKf8/5Gmx57fm7zVpdGJEe5G6XrHJXv9H8m5xpdRvQmwnsMtQZnCr6/kE3QVXKH+35L1HSElN+EWhs5KOs49t/EX0+YZf5uI2DJmICKnWIuMXBYrmRQ8NGT2M=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1217.eurprd04.prod.outlook.com (10.163.6.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 08:29:59 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0952.021; Thu, 19 Jul 2018
 08:29:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
Thread-Topic: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
Thread-Index: AQHUHmToF/izjBQy+kSrG+ej95VoyaSV4fqAgABSCLA=
Date:   Thu, 19 Jul 2018 08:29:58 +0000
Message-ID: <AM3PR04MB1315A99663BCB53A09733015F5520@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1531896889-21377-1-git-send-email-Anson.Huang@nxp.com>
 <20180719032002.GT4576@dragon>
In-Reply-To: <20180719032002.GT4576@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1217;6:JOdPLzjsxGwteJiiv1edAjNHupbTddLZJ3hJ08ed25hqBQQRO87GlfjDEz5nlhVlUhOR6ph2+X3AkhXbwMJ/Qf9LBUX2IkqYPEy5iJQtSbRR/jiOMM9y1ogKnC8+t72HzNjzXuqNHrvpahA1Z0nH9jIyXe2/tn3hChVh10NhGU2UPCqfqY2gzew5sbxJAEqeRNi3YTdtugenblzqmZiB0ob8uJFBGJnjQlhLYqGp1IWclJSnJx7li0WjhEhyFyAlJhf+mU1WPsLDwQh+5p5DWxqP+NFuvk9e8z3YSKpUI3l3JdFv2zLY14b2Svnu9s3rFzz4X1KRvP2IqenfP7SDc+mjdDgNPp/WUqw6OLl513Frckmqefq+qk/88WdSmGBv0apH8mP8r3MT8OGYYtzi1Dii1SkbQ/BiY4D27+wnx3859rmIKoupIz6Y+AciThazA3jQ6fEHir4W8ltPahVCVw==;5:AYAZc6+dU8nHAAQwyh3JWMAKMOU7JXWisfB/pyDudlcOEKBSpbnyGvXTyip+oRGGXT040nus3htvKZBk7kY3GoQ0eTjD1B2HFvGavauRgUdVmNVCa5NDDp/gTjBnK6dQBoaVUYph1P1njH+FAlPQ7NmL9JGuwa6yOigvnHdeyzQ=;7:A+H0juVHKBf3S4cUf6zlKlQyDkpuG8zOc3AwfwxhbJ+YfbVncuyedzmQLKmPc2QDzMFKk5M12qCPbb/5awGCs4xj5dIAZ4ZHMy5qo4MtXopyCVcrx5XDJTOEaKIhKVi248C5C5xt+52BLRx1Q2Qjoi4fyND0UuluVg7/gFaFXVAko1tI4Sq7rB2QZinrhEMQwJproomSzgqMOuu4umMCxnRBMekQRBGjj3YD27Ov7dc0VPqxL+KL2A45Je+Q0aOT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3ca22a48-d67d-4db9-4e48-08d5ed51d081
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1217;
x-ms-traffictypediagnostic: AM3PR04MB1217:
x-microsoft-antispam-prvs: <AM3PR04MB1217EA945CC82FECAFBF0898F5520@AM3PR04MB1217.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1217;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1217;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(13464003)(199004)(189003)(55016002)(7736002)(305945005)(66066001)(44832011)(9686003)(110136005)(54906003)(2900100001)(86362001)(316002)(74316002)(99286004)(476003)(106356001)(81156014)(6116002)(3846002)(7696005)(105586002)(81166006)(6436002)(486006)(102836004)(6506007)(11346002)(2906002)(229853002)(33656002)(8676002)(446003)(76176011)(53546011)(26005)(5660300001)(6246003)(5250100002)(8936002)(97736004)(478600001)(186003)(53936002)(14454004)(256004)(4326008)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1217;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aD/+w6mrNPsdml4yxdEcodIDqihJBZR2tZPswJrywbHeHb7N1t5FkiQUTSE7HXgChR+ieSIn3WvaNRzhOxmhPaYL3LUoykxRH2WFdWoyCBnVvuXubFrBjphwtkt8z3b6+EE22i4RKdiCJrAyGR/Nqh3z2DXiOGUR9PaSgkBw7y8xY9/kqSdDb4OPt4+D3eHpGITW8dY/IAcovW57dTJxEN8398NvJZOEFeywuQEknxRhAL8VchddWOh8pELHJkiT6Asrbaogjn8wjkJcfIKozc2cmoWQ8hpNXlJPPMEo81B9hxN8Bv8nQcDmjUWhLY0qrTh8ZofLnglu+SB0bUuK+WX+jR38Ox6EtCvxezUw2As=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca22a48-d67d-4db9-4e48-08d5ed51d081
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 08:29:58.7520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Thursday, July 19, 2018 11:20 AM
> To: Anson Huang <anson.huang@nxp.com>; Viresh Kumar
> <viresh.kumar@linaro.org>
> Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
>=20
> On Wed, Jul 18, 2018 at 02:54:49PM +0800, Anson Huang wrote:
> > Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for
> > CPUs") added "operating-points" property for all CPUs, but missed
> > i.MX7D's cpu0, this patch adds it.
> >
> > Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for
> > CPUs")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>=20
> In general, when you send a patch fixing a commit, you should have the au=
thor
> of that commit copied.  I added Viresh here.

Thanks, I missed it.

>=20
> It looks like a wrong fix to me.  It seems that commit b97872d4eb22 shoul=
dn't
> change imx7d.dtsi at all.  So the correct fix would be reverting the chan=
ge on
> imx7d.dtsi, @Viresh?

Agreed, I think the arch/arm/boot/dts/imx7d.dtsi should NOT be changed, as =
it already
had operating-points-v2 on both CPUs, I sent out another new patch with cor=
rect fix,
please review it.

Thanks.

Anson.


>=20
> Shawn
>=20
> > ---
> >  arch/arm/boot/dts/imx7d.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d.dtsi
> > b/arch/arm/boot/dts/imx7d.dtsi index 9a772fc..30a1a73 100644
> > --- a/arch/arm/boot/dts/imx7d.dtsi
> > +++ b/arch/arm/boot/dts/imx7d.dtsi
> > @@ -9,6 +9,11 @@
> >  / {
> >  	cpus {
> >  		cpu0: cpu@0 {
> > +			operating-points =3D <
> > +				/* KHz	uV */
> > +				996000	1075000
> > +				792000	975000
> > +			>;
> >  			clock-frequency =3D <996000000>;
> >  			operating-points-v2 =3D <&cpu0_opp_table>;
> >  			#cooling-cells =3D <2>;
> > --
> > 2.7.4
> >
