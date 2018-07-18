Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDDAECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588E42075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WoBXc+CW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588E42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeGRStd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:49:33 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:48496
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbeGRStd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2DBaWePBy88t0673i+642D7W2kMVkbFBskgXY9qlRE=;
 b=WoBXc+CWrn/RKXiKBANUSSZiMUcsT5tLIilIiKwVdoYQZ3LORfodxKxdG7TS5cJabnFIvFKSalZ68DydsTOt2cpNOJfz9Xq30gtddxMs0Mem05C6W2hRF5lGPvPxLTjdsAEoYMYNWLJO+Stcm8iuLMH2j2gQv/Ch4kn9KA2ruU4=
Received: from AM0PR04MB4867.eurprd04.prod.outlook.com (20.176.215.160) by
 AM0PR04MB5313.eurprd04.prod.outlook.com (20.177.42.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Wed, 18 Jul 2018 18:10:25 +0000
Received: from AM0PR04MB4867.eurprd04.prod.outlook.com
 ([fe80::65ea:cf7f:c76:b334]) by AM0PR04MB4867.eurprd04.prod.outlook.com
 ([fe80::65ea:cf7f:c76:b334%2]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 18:10:25 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Thread-Topic: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Thread-Index: AQHUFJguec14uSA7bUePWN2SnCGRW6SVTIIA
Date:   Wed, 18 Jul 2018 18:10:24 +0000
Message-ID: <AM0PR04MB4867D7E843D3EAFB73EF939D8F530@AM0PR04MB4867.eurprd04.prod.outlook.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
 <20180705194113.16256-2-roy.pledge@nxp.com>
 <119c6fc6-a32d-45a5-96ea-f6e9959b1e74@nxp.com>
 <VI1PR04MB44942CF2B2E5BA1C6CE8D17786440@VI1PR04MB4494.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB44942CF2B2E5BA1C6CE8D17786440@VI1PR04MB4494.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5313;7:+l89a4WscqmdEoVHBnEsGgAx/ew+TCSGGxlcSm6Xto47/d1NvlLEb8koDeRi2zAivWnwg3NMBVy/lbelmMHzJ3kKc0rsHg7MHgRyk3TO9tX+txtwldjWbRVxl6zfLSa2++4QJQMyuBDo7qpO2hq4wdJdZrbCk21xP0FAREte93tTBn5OJ4z+Eu9F+i+VOPqefnXDgSqNBFETiL7my5M/rEVBr/ZlXTO9/5LB5KaYtxZnCbyYUWbvuvnldbnCcVgO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a9ae1b34-0e81-4f69-2a40-08d5ecd9bc24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5313;
x-ms-traffictypediagnostic: AM0PR04MB5313:
x-microsoft-antispam-prvs: <AM0PR04MB53139E483F8433E59822686D8F530@AM0PR04MB5313.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5313;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5313;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(366004)(13464003)(189003)(199004)(14454004)(9686003)(7696005)(93886005)(2906002)(76176011)(102836004)(55016002)(6436002)(5660300001)(476003)(2201001)(33656002)(86362001)(26005)(305945005)(7736002)(2501003)(486006)(6116002)(6246003)(229853002)(3846002)(25786009)(14444005)(110136005)(54906003)(6506007)(4326008)(68736007)(74316002)(81156014)(106356001)(66066001)(53936002)(256004)(446003)(99286004)(478600001)(8676002)(97736004)(316002)(81166006)(105586002)(53546011)(8936002)(5250100002)(11346002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5313;H:AM0PR04MB4867.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1aTjFi4gl+z1DD70nhpYTgbnC2/arDaA0YhbE0Gvv21BgOZCowea27dvl45VH8jD8x8w9avswOKnf9J1EDPG8dpfsHE6Y0Uq0s33c45CPfqUDX6qc/p946BnZRt+kKjTa9z6ST7o+G8t17xjlQEeX8RNaMooLVP5at+S3+Urud4LaYW4FlnJDMrM39zs44I4G0G6fJng/e2uNuqoNGq9bnrrMz4Pya27xoZwGeAqXrjZGR4rFg92/8Dd0AVCiQ0m1xm/x1GeOmjb+HlVIHiTqvz8Lg9ZFGOPHOhOjVYhjMnuZuNqaGs6Kuy8fA7SfvehHtDecxbPMR2g6/eRcoBSYWR4kGzg6gYzPLep33oo6g4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ae1b34-0e81-4f69-2a40-08d5ecd9bc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 18:10:24.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5313
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Roy Pledge
> Sent: Monday, July 9, 2018 10:24 AM
> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> devel@driverdev.osuosl.org; linux-arm-kernel@lists.infradead.org;
> gregkh@linuxfoundation.org; Leo Li <leoyang.li@nxp.com>
> Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>; linux-kernel@vger.kernel.org; arnd@arndb.de;
> catalin.marinas@arm.com; robin.murphy@arm.com
> Subject: Re: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
> drivers/soc/fsl
>=20
> On 7/9/2018 6:37 AM, Laurentiu Tudor wrote:
> > Hi Roy,
> >
> > Couple of comments inline.
> >
> > On 05.07.2018 22:41, Roy Pledge wrote:
> >> Move the NXP DPIO (Datapath I/O Driver) out of the drivers/staging
> >> directory and into the drivers/soc/fsl directory.
> >>
> >> The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
> >> hardware on NXP DPAA2 devices. This is a prerequisite to moving the
> >> DPAA2 Ethernet driver out of staging.
> >>
> >> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> >> ---
> >>   MAINTAINERS                                                    |  2 =
+-
> >>   drivers/crypto/caam/sg_sw_qm2.h                                |  2 =
+-
> >>   drivers/crypto/caam/sg_sw_sec4.h                               |  2 =
+-
> >>   drivers/soc/fsl/Kconfig                                        | 10 =
++++++++++
> >>   drivers/soc/fsl/Makefile                                       |  1 =
+
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/Makefile          |  =
0
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-cmd.h        |  =
0
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.c     |  =
2 +-
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.txt   |  =
0
> > Maybe this should be converted to .rst and go in the already existing
> > Documentation/networking/dpaa2/?
>=20
> I can look into converting this to RST but I'm not sure it belongs in the
> networking documentation folder since it will be used by other non
> networking drivers in the near future - compress/decompress for example.
> >
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-service.c    |  =
2 +-
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.c            |  =
0
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.h            |  =
0
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.c    |  =
2 +-
> >>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.h    |  =
2 +-
> >>   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                 |  4 =
++--
> >>   drivers/staging/fsl-mc/bus/Kconfig                             |  9 =
---------
> >>   drivers/staging/fsl-mc/bus/Makefile                            |  2 =
--
> >>   {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-fd.h |  =
0
> >>   .../staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-global.h  |  =
0
> >>   {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-io.h |  =
0
> >>   20 files changed, 20 insertions(+), 20 deletions(-)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/Makefile (100%=
)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-cmd.h (10=
0%)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.c =
(99%)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.tx=
t
> (100%)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-service.c=
 (99%)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.c (100%)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.h (100%)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.c
> (99%)
> >>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.h
> (99%)
> >>   rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-f=
d.h
> (100%)
> >>   rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-
> global.h (100%)
> >>   rename {drivers/staging/fsl-mc/include =3D>
> >> include/soc/fsl}/dpaa2-io.h (100%)
> > I received feedback in the past on mc-bus that a driver should limit
> > to only one public header and one private one. Would it make sense to
> > do the same for dpio too?
> Looking at this the dpaa-2global.h file should probably be integrated int=
o the
> dpaa2-io.h file.
> The dpaaa2-fd.h can be used by devices that don't need to used DPIO - the
> definition of a frame descriptor isn't DPIO specific so I would argue it =
should
> be kept in a seperate file.

Hi Roy,

Will there be a re-spin of the patch soon so that we can probably catch the=
 next merge window?

Regards,
Leo
