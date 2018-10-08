Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA15AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8330D2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mum4P5jY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8330D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJHPBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:01:23 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:33248
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeJHPBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFsPItfDRPavSdED9wral92X5uMlhl/SbPSQ/O5KjrA=;
 b=mum4P5jYLqrI7uCdKfBXuObv9nQ4LC3oTZEj0MAAYYvRIwd5tf7EXm/eemWt4PjZODuqdvGPucLxno4KHeFaMN6qL+rIFQnV+VMY0sJUdm1Mmjeyzw04RqbOv4nSkwg/SD+ONp3MZDL6QVz5wei6AOPn5+CZRsUvzLnXADu4Bgo=
Received: from DB6PR0401MB2232.eurprd04.prod.outlook.com (10.168.54.22) by
 DB6PR0401MB2246.eurprd04.prod.outlook.com (10.168.54.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 07:50:15 +0000
Received: from DB6PR0401MB2232.eurprd04.prod.outlook.com
 ([fe80::2988:b6e2:44fe:4311]) by DB6PR0401MB2232.eurprd04.prod.outlook.com
 ([fe80::2988:b6e2:44fe:4311%8]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 07:50:15 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Topic: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Index: AQHUV8ZPKu1tHExVGkqxDRFy68gG36UHqp4AgA0Nd0CAAE8acA==
Date:   Mon, 8 Oct 2018 07:50:15 +0000
Message-ID: <DB6PR0401MB22324A6ABEA3846585B3E1B6F8E60@DB6PR0401MB2232.eurprd04.prod.outlook.com>
References: <20180929072645.20027-1-yangbo.lu@nxp.com>
 <20180929194616.GA11532@lunn.ch>
 <DB6PR0401MB2232FA836E1C9139309D43D1F8E60@DB6PR0401MB2232.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0401MB2232FA836E1C9139309D43D1F8E60@DB6PR0401MB2232.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2246;6:8dLfM5wge9xDq31DcPwM7pO7yL/2fmlSeVgXAm9+ogmtYsQ8ljLaOKFLMrRfCHmYzeQU1uIz662XSv+MRg6wVtpMUZaibDUhSF5zP3e69SyY6YMd0ykUL71wTEO0Jj0hmr9mMZ7E0XYQ96nPtl70B4Pbg3ZHd7ax7k1YnPhs2tO14c4dOw5CyM+QYbtvhgxn7vdlE7lq3pYjnDSQRzG12aqDGfmz4iHc6EwcBtnGq4ITUl85spJh+fQsSnyNikmTMRKxHItpugn2GLxjX6yO+koFVh4rLvGCLFfYE04X2wizfgH2TK/q/UamxF4FdGx8su45Tq7OanCDydbAU47eloLamM41kngYqsQ2/HJ9AuVv3Eda65NPEN+aHIKABcoNNx/C+1zR9ApfHosCxtOGxWIvtHVwc+mJVlMMVt+eLSDFuEQq1Dy24lzUhZDpm0xxR93WSLZZwAU6DRUAvOfIgg==;5:7YmaPETgEILi1PDxnsx1Q0nUnjjvD9R5wAdGdqt36z1rfAE9ZQWad7pbpJ9njyyHo2p1AcrbjyLkyEdbepDHaGYPfPJopuxiVRF6fLUPxbxcEJJ9XUjuObCCUO/ZnAFuepdVrmFx8+k27SWfGXzA1gb41KkCMXfdQG7FuSG/Xcc=;7:bdeEyu1uB1RXgDLWflyuMouQFMgCtTtkQmkiBT1Wn+lH6wGtPJTf1JmaaqXLgWnlOVb+4EkQFz1cxgw+AwRkLd3yLQXrF/xW05n4APP6VX+oJH5IfQJ1b6gmWXZ01uag60771HuwOF/oItRxQ5MirR2wODSrSABWLecjfHVwoS/8GVgJbQBuWEJ0PkcY9ue70eMoaop2bHc7MC6ZuRsoJsLxJSFsf36Jc7a3LM3ohMzQC+HXinvJM329/fv1xYfx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 60c8144d-3848-4dba-d3b1-08d62cf2af74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2246;
x-ms-traffictypediagnostic: DB6PR0401MB2246:
x-microsoft-antispam-prvs: <DB6PR0401MB2246DF03F10038270314F91DF8E60@DB6PR0401MB2246.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:DB6PR0401MB2246;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2246;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(366004)(136003)(13464003)(189003)(199004)(86362001)(305945005)(14454004)(99286004)(316002)(68736007)(105586002)(5250100002)(106356001)(9686003)(3846002)(229853002)(55016002)(6506007)(53546011)(6436002)(93156006)(7736002)(74316002)(6116002)(2940100002)(5660300001)(7696005)(186003)(76176011)(446003)(486006)(11346002)(39060400002)(478600001)(26005)(476003)(4326008)(81166006)(81156014)(110136005)(54906003)(2906002)(8936002)(33656002)(71200400001)(71190400001)(256004)(66066001)(14444005)(8676002)(2900100001)(97736004)(6246003)(25786009)(6636002)(53936002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2246;H:DB6PR0401MB2232.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8h6jUx6cPEZb0Z83s4I3S5/yhHTpjfFy8phB8GMfS6X8utvqVouMYlU3ELRE/4dpswEHs5YnD9NJ0pF08KccAbTX6470zHy6FdRPhNKiCPKlgMn4FyYwmMNIgciV+ThThqMEyTczSXtG0FuCY4gf4V8k+cm8tDOqh3hrIbqr1FVUAxHQFLZ48oXKnhE/nb6uFp/D2ddpyqDsuaFAky3LxbPYapy/NH5c2NAXH9xOC1D5j41fz7hppWNlBJUo+8kkiTdiFORfyFMPOunpkyWXYXkmGysXdRiOFJD7SfQOft1HkVLNE3jYtq+w2rSyMNAYaZGu0ai4GS8eqyMMHbtvoHWBDTyjAeEeNE9O28/AUlY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c8144d-3848-4dba-d3b1-08d62cf2af74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 07:50:15.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me just add an additional patch in v3.
I had sent the new v3 patch-set out. Please help to review.

Thanks a lot.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Y.b. Lu
> Sent: Monday, October 8, 2018 11:11 AM
> To: 'Andrew Lunn' <andrew@lunn.ch>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>
> Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: RE: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
>=20
> Hi Andrew,
>=20
> Sorry for late. Just come back from holiday.
>=20
> Hi Ioana,
>=20
> Could you generate an additional patch for dpaa2_eth to address Andrew's
> comments?
> There was also a warning when checked patch. FSL_DPAA2_ETH needed more
> description.
>=20
> WARNING: please write a paragraph that describes the config symbol fully
> #66: FILE: drivers/net/ethernet/freescale/dpaa2/Kconfig:1:
> +config FSL_DPAA2_ETH
>=20
> Thanks a lot.
>=20
> Best regards,
> Yangbo Lu
>=20
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Sunday, September 30, 2018 3:46 AM
> > To: Y.b. Lu <yangbo.lu@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> > netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> > David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> > <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > Subject: Re: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of
> > staging/
> >
> > > +++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> > > @@ -0,0 +1,15 @@
> > > +config FSL_DPAA2_ETH
> > > +	tristate "Freescale DPAA2 Ethernet"
> > > +	depends on FSL_MC_BUS && FSL_MC_DPIO
> >
> > Could you add in here COMPILE_TEST?
> >
> > > +	depends on NETDEVICES && ETHERNET
> >
> > With the move out of staging, i don't think these two are required.
> >
> >      Andrew
