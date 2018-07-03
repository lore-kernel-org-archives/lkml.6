Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB00C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878F52472E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8mb+lBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878F52472E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeGCHoS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:44:18 -0400
Received: from mail-ve1eur01on0083.outbound.protection.outlook.com ([104.47.1.83]:37146
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754542AbeGCHoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWW+8sw9Vnx8E/kKA9SO0xPvI8seXKBtYV7m7phs5lg=;
 b=Z8mb+lBDyU6I+rN7UP3bNTvjp/XB6V/DvoygbS7HMkviLei2MVpQUvb4n5rNVXjh9GaoVjT7bAU8SWlVWEfHmc52Q2Gfs0ZURkju49Lx6KIuCW2B2oO+UQ/l0Bb28u/raSMkO7tm/OnljlrOjnHvx3b9apuF3UmBgvq+2zKyhfo=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB0647.eurprd04.prod.outlook.com (10.255.248.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 07:44:10 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 07:44:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Topic: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Thread-Index: AQHUDD3lRelNZaT6s0KCSbdeyjhmZKR6JNEAgADqWICAABYs4IAAAL2AgAAAQsCAAAFKgIAAAEyQgAABDACAAACgsIAAAsCAgAAPigCAAcvbgIAAH2vg
Date:   Tue, 3 Jul 2018 07:44:10 +0000
Message-ID: <AM3PR04MB131542D42FCD798FDBBA54BFF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
 <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
 <1530526335.15665.13.camel@nxp.com> <20180703053843.GC4348@dragon>
In-Reply-To: <20180703053843.GC4348@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0647;7:oQbilIoc8sw16yXPARUuLqFsi95hm9I8uNbkjKbEw/wYFME+wsomT+Gx9rueLoPUN+0zRr+sJCX3aYvImaclIagdweceWXosfCk6MA82HbXQXiQl4r4lN0+w3VRLNXjEk+F0gO3JFB6lS3GuohH3dKebRNmFMJAEbPNqO8cXwZ+cMtxu3AhmVRcovjUBRc01lBQBpSZygy5qwB3hlQtXG8Ru2ndE6+BlDDRQGJyWrRzIKck7rKUg6M4hysMgKF80
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f9c7bd00-5092-42b9-1d06-08d5e0b8c3b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0647;
x-ms-traffictypediagnostic: AM3PR04MB0647:
x-microsoft-antispam-prvs: <AM3PR04MB0647FE4B7339F7F38013B1E3F5420@AM3PR04MB0647.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB0647;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0647;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(346002)(396003)(13464003)(189003)(199004)(5660300001)(14444005)(93886005)(6116002)(3846002)(2906002)(68736007)(99286004)(110136005)(54906003)(66066001)(316002)(97736004)(5250100002)(105586002)(74316002)(6246003)(53936002)(4326008)(39060400002)(106356001)(14454004)(478600001)(33656002)(256004)(229853002)(86362001)(44832011)(81166006)(7736002)(81156014)(6636002)(305945005)(486006)(6506007)(186003)(25786009)(446003)(8676002)(26005)(55016002)(9686003)(53546011)(76176011)(7696005)(6436002)(102836004)(8936002)(11346002)(476003)(2900100001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0647;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2HBOGENunR7dBSNNTPAkiFh3hc9zAAwQLRXhFWxuFWZVBDrElYp9HbgZRky3NlKgiMyRdipm4Eyl2P+eOqM9TYJ9qF0eOZjTXca3xMyB1PYyjmOpE9fD4Gcr0u/Um3eqdhX0as10YwcPH/6VSk/V33ZhjEeV1b/j/3T+o7vyxAFLdRFO53teYKIvXjyhZpj+evVzhme4eA5igcXw/94oXPt9DiZxZdA7cD34nQG8IucLTZatdYaXLKDhb8LUA8NVvj6i91lTlZt9oIMdEAiI5suT7aKEIMn9+165A3hfK9d3Eps5BDv6Cz+vwFa1C9RJqce7rt/BlhtczfkPKseY7B645fnUmRWnolv5huEHZJo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c7bd00-5092-42b9-1d06-08d5e0b8c3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 07:44:10.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Tuesday, July 3, 2018 1:39 PM
> To: Robin Gong <yibin.gong@nxp.com>
> Cc: festevam@gmail.com; Anson Huang <anson.huang@nxp.com>;
> mark.rutland@arm.com; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; robh+dt@kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
>=20
> On Mon, Jul 02, 2018 at 02:12:52AM +0000, Robin Gong wrote:
> > But in fact, the original dts is not correct without
> > 'regulator-always- on'since SW4 is the critical DDR power rail,
> > although, it's kept on in the previous kernel by no switches
> > enable/disable interfaces provided in pfuze driver. Adding new
> > property which can be done totally by the common 'regulator-always-on'
> > is not a good choice. Keep the dts patch adding 'regulator-always-on'
> > ahead of pfuze driver pach adding enable/disable interface is enough fo=
r such
> case I think.
>=20
> We can not just break the installed DTBs like this.  If patching regulato=
r driver
> with a new property is really difficult, we could migrate the existing us=
ers in a
> 'soft' way:
=20
Patching regulator driver needs to add property for those regulators can be=
 OFF,
it will make users confuse with original regulator framework knowledge, NOT=
 a
good idea.

>=20
>  - Add required regulator-always-on for regulator nodes in DTS.
=20
I & Yibin already sent out patch to add " regulator-always-on " for regulat=
or nodes in DTS,
so they can be applied first?


>  - Patch i.MX platform code to check the presence of regulator-always-on
>    property for critical regulators, and give a big warning if it's
>    missing.
It is NOT easy to identify which switch is critical or NOT, and different p=
latforms
have different board design, it will introduce many platform specified code=
, so I think
just revert the pfuze100 switch enable/disable patch should be OK for now.=
=20

>  - Wait for a couple of release cycles for users to migrate.
>  - Add regulator driver patch back and break users who keep ignoring
>    the warning.
After a couple of release cycles, add the pfuze100 switch enable/disable pa=
tch
back to support this feature, I believe users should switch to new dtb with=
 "regulator-always-on"=20
existing already.

Anson.

>=20
> Shawn
