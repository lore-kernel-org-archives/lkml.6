Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E97C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC7E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPwqLYyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC7E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeIDKBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:01:08 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:23104
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbeIDKBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB4GvK3V23cm5VeHGiY0ZqM3HXOEEFzKe9uVj2Cjozw=;
 b=gPwqLYybxi+2lNTs14IPMuhzVw39wuU41/cjZSdVgG6agCUCP4kVdiCRhP7/gq6k6MZXDxZGEqSjAua2YVKs53NkVtxZW0XvDTaeDdIcOkXzzpZ/cH01i8Boo3FmKG6JeJpAXNReIniOsH3hW1xfu5ZBBRxDAHGnGS67Qnud3jY=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1503.eurprd04.prod.outlook.com (10.163.167.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Tue, 4 Sep 2018 05:37:30 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5%6]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 05:37:30 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Thread-Topic: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Thread-Index: AQHUQRXjtJmUoZazkE+eX5g7E2y7gaTeVfEAgAFITdA=
Date:   Tue, 4 Sep 2018 05:37:30 +0000
Message-ID: <VI1PR04MB10382327ECE8B1004B4E983E99030@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
 <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1503;6:1BzIui7Ih8548lWmIARlnVWxc6jhVOu0gnCMtrDD9ie0r4qzEd8YgAIpfuG+Jbose5s8RAkvl2fvZSFsYvx43gGNQ4bHXIVml67n1sIIMM/lDz+NPoqY1OIjxIGQRjs+dPHvfv0UfL4EANBemRILARhCETfsCKFClqs9rLLlg0nXOM9lqynPskqRV0eoObY/B16o/ERkgjQ4T7OSCF3VADHADWtKAZP1c0QXS6MoHT/M5jbcxtxHV4YBGSn2niU/H9EBKPtOm2rBI4xoLGYUS1mg0S6tsYqzY2CvcZ5wydZxcf2Pxl7Pd9LIWHUXqA7Pt+eCXpWu6Sr4zM14IKb6HFB3w7UTtXmOHONFbaSZSKU54MjBpAHDAgMAK0RdIkyPWNP1tjaRvowF0ftrRzly66zgZjWTEXZzhG+RfD3Ku2GN0PVT6pDQbAqNkPCeZBLw3D0jHIor+Sy18cbrO7aw4Q==;5:L1wezUQPKCu6KfWpt2FgwrjcZR3fvFKrW+KKmENXCBBuofSF9LJY4Oo7OA+WArzUHbbg20tB0CY/cV/8TvasXrsCTH6RQVUpwoTGwb2hN52EP2ZUThoxC2VxhjhPT5belHD48+iNKjQdNqAigXhs/ovgwjJCVAA+UWhZBnHBCU0=;7:VTxNDM3piJOnU3dlo5g8PhU2CxbU7YLD/fx2kV5byuTrEuZwYTNHSy2/NsQug2WYm3IGdBwUZ8SteutpbjH69xWDHX6QF3I885j7tX6XjBcq+uLX0w4zSZkH/XEABubBfYxKYVvaQ/uE78afbybUfahySPR0n4s2H4XJlg7Ftw0mrckuRTk0qW5ONwXmcdlPSe+sILuQbR9aet6Pz/OTbHO+XREBDZjmm88p91tZG0iG1vD3Gn7v3WfxurVeEvpf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 377201db-43c6-424b-bb3b-08d6122881ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1503;
x-ms-traffictypediagnostic: VI1PR04MB1503:
x-microsoft-antispam-prvs: <VI1PR04MB15036AC96F1A56C5C4FB7B6799030@VI1PR04MB1503.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR04MB1503;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1503;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(13464003)(14454004)(4326008)(54906003)(110136005)(8676002)(39060400002)(25786009)(55016002)(229853002)(81156014)(7696005)(316002)(7416002)(6116002)(81166006)(3846002)(33656002)(6246003)(53546011)(6436002)(6506007)(102836004)(5660300001)(26005)(76176011)(256004)(99286004)(66066001)(478600001)(5250100002)(53936002)(7736002)(2900100001)(305945005)(11346002)(476003)(446003)(9686003)(106356001)(486006)(2906002)(105586002)(8936002)(74316002)(68736007)(86362001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1503;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NSO6Z0S3+4gmah6kdiMa2C73+vY8gy/IHgNw0Sd6BoKdHNxbdWSREjuJ6rumhZUsOjcZ5OKCTrUcPQi3RWru5vaoTOBwMSEFzdV/UTRBFXeM9WYMUp7NrGxlmwe2GInaSpLyjV5Zx/F1naYPGQ5scM++LyY0of4dsKUp9mJ+GAyuWU/h3ckCPdn7k4O/nIRAgA349jdgyE/d9T52cmKTxEwe7JSA/LNwgAxrEAvi/HIEbdEEuFRkpflCAMuPO0145i7ycM/G6dI5rSO+ItA5RDwHxRDARNRuZ7LXHGqGBwQbhlbMlwC6LiO8N0KGBnz2ufIHYGSrzpp2n804DxWsbnqH1TmmckVYDup7wcVUoq4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377201db-43c6-424b-bb3b-08d6122881ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 05:37:30.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

> -----Original Message-----
> From: Prabhakar Kushwaha
> Sent: Monday, September 3, 2018 3:24 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; marek.vasut@gmail.c=
om;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh Narayan
> Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: RE: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexS=
PI driver
>=20
> Dear Yogesh,
>=20
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Yogesh Gaur
> > Sent: Friday, August 31, 2018 4:00 PM
> > To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> > arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh
> > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP
> > FlexSPI driver
> >
> > Add binding file for NXP FlexSPI driver.
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> > ++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> > fspi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > new file mode 100644
> > index 0000000..9f07116
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > @@ -0,0 +1,42 @@
> > +* NXP Flex Serial Peripheral Interface (FSPI)
> > +
> > +Required properties:
> > +  - compatible : Should be "nxp,lx2160a-fspi"
> > +  - reg :        First contains the register location and length,
> > +                 Second contains the memory mapping address and
> > +length
>=20
> Why are we overriding reg property.  Is there any special requirement.
>=20
> Can we use "reg" and "ranges" property in device tree.
> Here "reg" represents controller registers and "ranges" represent the mem=
ory
> address of flash.

'reg' property is being mentioned in the file './Documentation/devicetree/b=
indings/spi/spi-bus.txt'
No mention has been given for the 'ranges' property.

Shawn,
Please suggest, did we add different property node 'reg' for the configurat=
ion register address space and 'ranges' for memory mapped address space.

--
Regards
Yogesh Gaur

>=20
> --pk
>=20

