Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8145C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K5j2VoZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D55520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeLFEUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:20:33 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:45600
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727695AbeLFEUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkiAerso3SISe6IO9T+oN9MlYBBB/cc+dzG9eq2NSGI=;
 b=K5j2VoZ2dnNwbS9yw0Pm440kzcskf0/s2e2yA4z3tdvYUqa3FA2VqBu/WtJeLAsC0h+QH1OQvTExBiFzH2HIY1L5aQS3MscqXK4j3vdnTK2keCqcGPpbOSehqW+BxxYD15NhihifmwOMCRfOPLpTQAGoqri4JZj9ANnt+In1Lr4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4590.eurprd04.prod.outlook.com (20.177.55.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 04:20:26 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.019; Thu, 6 Dec 2018
 04:20:26 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vignesh R <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v5 0/7] spi: add support for octal mode
Thread-Index: AQHUiuOjeSgB/5zRPUqi536teiWNPKVsvNiAgANQIQCAAA5HAIABBArQ
Date:   Thu, 6 Dec 2018 04:20:26 +0000
Message-ID: <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181203101937.7b01a0ad@bbrezillon>
        <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
In-Reply-To: <20181205134618.56223758@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4590;6:GxZhfaZBIFSFWwJoIbhf8Uux1eTSJNzoGYL6QjXX6T/A2hki3MlqIexSOWiqryw/v5iN2SIO1ctqu1XF5yYWp81/Ov2a72diIG4LJY3FHguRAxTkGV6KeirhtFVBTDEbTNmEh92D6Dj4NuyrLkN+ohr4cLg6tGntGFs7v+HRxacM2V1Y3cz1bkXDMkXhQNlfuNKHxiE4VEAm0CHAWAXBIPMmZhuSIwypUoKiht2TCmDl/QnHMJrBKbSah5zWYHUz0Uz9iq6U7DHA7jhRv+Z1CPSVLr1rAp+hoVBoTyJqVKzjJ+WE3CLMsUoUK5QM2AITm4lgzcrgKvRL4bgmJ/WSvOVm/iXm6F/EtbaQopbfzegPF6LPtFI4hYKKaNKwg1pyqlzEA+yhsA73nH5i4Aq0DrL/hb7r79pIzCP8O+y9b1uEgJYfSTH1tXNSRtR34e6ycjR1sifONKMy+6A7wVgjqQ==;5:GVUQoIbptRhlXGeIUObI66h1dg0cUG/V4YesXoAK/TxGmMSsTvKh7H/syHJrngKxghMxCMdKik/aKCruOn1QUKvUw15B55T8m6iNBAgHXWB1A4PeTr2VtwEDqKWLgfGYWPZpi/iYaFl603HiH6lo0R33iFnJUPtCFvT1gPWKa5o=;7:nHLBC2JNbx1SXJp7H5SzSqj217SQyX8RCkgILNMLj66w6FAei3rEQTbarWM7jTrKAiN8VPv42qXmfo0lptYQV88ZuEnDtkUbrzNidhvBmlBXLA3sf8U5CZRJdO+Qt/GTPqB7+6rFBRJqKkReWySNkw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9e5f82d6-25d8-4cf2-abe8-08d65b3225f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4590;
x-ms-traffictypediagnostic: VI1PR04MB4590:
x-microsoft-antispam-prvs: <VI1PR04MB4590737CDBB183ED0AB9E98599A90@VI1PR04MB4590.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4590;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4590;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(13464003)(55016002)(6306002)(9686003)(81156014)(110136005)(66066001)(54906003)(7736002)(8676002)(81166006)(8936002)(4326008)(68736007)(39060400002)(106356001)(229853002)(7416002)(5660300001)(476003)(33656002)(11346002)(53936002)(6436002)(446003)(105586002)(74316002)(6246003)(305945005)(256004)(25786009)(2501003)(14454004)(71190400001)(7696005)(71200400001)(486006)(93886005)(6116002)(3846002)(99286004)(97736004)(966005)(102836004)(53546011)(2906002)(478600001)(186003)(316002)(76176011)(26005)(86362001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4590;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yenkgwlACf10D26bBjb1VSQl6pwPe+PruN3eg2IDhBbGoLtr44mtftGVKhepr+Glgs1DFj4uPhi6RkRBdAdVJk9NJrjym7BMh92vwjUVQMvg3Ujf3mjOgOIWw1OWAPpxkyxjgXXHe9FlrXkwD70CnDFLo7mC/UafRq2st8N6HfVwr4q48X4KNM2Uy1ld7R519wrh442gZp7yB4oixVQ5T1IlZRSfhRDfEDHlrcczwBTAXbITs2QilbQrPYh4IPOKMQHwiLkcnh6SePoDSkiD5FMhCg+0LmlRBHDCoWMqSHF64zPfxPg0ZEXBmzNcc2teiKBgi5oWpmv+gLO4N3EpLsjo2obGMLpHh0ESmN+3tqA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5f82d6-25d8-4cf2-abe8-08d65b3225f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 04:20:26.1305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4590
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Wednesday, December 5, 2018 6:16 PM
> To: Vignesh R <vigneshr@ti.com>; broonie@kernel.org
> Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org=
;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
>=20
> On Wed, 5 Dec 2018 17:25:12 +0530
> Vignesh R <vigneshr@ti.com> wrote:
>=20
> > >>   mtd: spi-nor: add opcodes for octal Read/Write commands
> > >>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> >
> > Could you consider merging these two patches alone for v4.21?
> > These can be applied independent of other patches in the series and
> > would allow supporting OSPI flash at SPI NOR level with Cadence QSPI dr=
iver.
>=20
> Yep, I'll queue them to spi-nor/next.
>=20
> > >>   spi: nxp-fspi: add octal mode flag bit for octal support
>=20
> Mark, I think you can pick this one too.

This patch is dependent on the series [1] which is yet to be applied by you=
, please apply.

--
Regards
Yogesh Gaur
[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D76402


