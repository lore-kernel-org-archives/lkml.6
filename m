Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0020C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B714320652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="qlLPfxaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfBURkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:40:16 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:59776
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfBURkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG5+TQ9SeX0QgJah5U6jSmfZHA0NcDRjjtYvDorFiJw=;
 b=qlLPfxaBmoOCATOlwvSCvu+gD0o/B2TR5vxexX6rpn899dJZa3OOREjf0m0fbpiTctQmTVt6BpUlRRPZV3FGE8XTHfVQOVNT8WzJKp161U8bqMY0W+geqmTmHhRm7oR+VmNAJQkClG3By/ZuWn+90uit1oATA14xlwB3clgGjJg=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6505.eurprd05.prod.outlook.com (20.179.43.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 17:40:08 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f%2]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 17:40:08 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUwpKghnGnnsxrwE6OI0HelaAfeKXcVzAAgAACOACAAeb8gIAADAqAgAv1kgCAAFHKAA==
Date:   Thu, 21 Feb 2019 17:40:08 +0000
Message-ID: <20190221174000.GG17515@mellanox.com>
References: <20190212162003.1aa1ffbd@canb.auug.org.au>
 <20190212161528.GN12668@bombadil.infradead.org>
 <20190212162324.GU24706@mellanox.com>
 <20190213212621.GW12668@bombadil.infradead.org>
 <20190213220929.GO24706@mellanox.com>
 <20190221234716.2144eba3@canb.auug.org.au>
In-Reply-To: <20190221234716.2144eba3@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0090.namprd17.prod.outlook.com
 (2603:10b6:300:c2::28) To DBBPR05MB6570.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9222077-1970-4752-72ec-08d698239f07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6505;
x-ms-traffictypediagnostic: DBBPR05MB6505:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DBBPR05MB6505;23:O51mQVOzfPtRyuf1wQEU8nTBDlHLWoHaBkzrr3weP?=
 =?us-ascii?Q?sISEm3zlSuF6shZ1BYOCgRWmDxYvSzOjlzids3yjQymHXoakBBeKYeldoPGf?=
 =?us-ascii?Q?nPq+SSAPhFHm/8QMv+V9H+jUKeGJyC/taGXWPJYAczP6v2RHePteWJHOzeOZ?=
 =?us-ascii?Q?1xnz1mJ7VGWfRa+GUfSAYatjZed7bLz74nIOdmNqk4KYgX1MavvQrriDd6qE?=
 =?us-ascii?Q?cspVMGZRZFFAykmPBDw0ywX2nbZ/bWsQeX0udbdO02HvRTqRzA/93AugiRZq?=
 =?us-ascii?Q?u5fEmrcSFCApngm+p9LXciBrTB5NW8bPaxHpZRbRlBoscyaUp1hry5V8cczF?=
 =?us-ascii?Q?scL+Wj1A21+aF63wGf8KrPHq4codxx5XNci0VsXiMpyhvzG6XtbwA6A5wycK?=
 =?us-ascii?Q?PTBdknnbIBWsrLKcie/hubEj9/FHftR84OtvMU0Gga8aIWiSV8yhV+ub+i1J?=
 =?us-ascii?Q?ZlmqyUElsInGsnpE/nfRYsOZnyMCEh99zAOMT1N2SvwM7pmRziI+5SFWQJeY?=
 =?us-ascii?Q?B6IFSR1w8MrQ4QrV8xZou3mxzQ8uNP2JAio16nWjzQ1Enb58eCbI4ovzw36z?=
 =?us-ascii?Q?SZ86G1hekbt6z/EOA3kK7F8mcM2UMyxqqoP7mNYaTLKKMJN4+ygSnslo/avi?=
 =?us-ascii?Q?1RPSHiyYTfkVBfBapljtNyxOc9WBUjOTZr+T0/glp22yxb5wr21qKNhMTv8Y?=
 =?us-ascii?Q?mWxzYEApg2XJ4PSGkqIRLTR/zEd+210foBj8NbiCAcah60zKT/+odnLXJpxC?=
 =?us-ascii?Q?NORPJEvDfUh5F1pRjwAZwBa7un7+GR31aQIHWcb6Bq//48fVNPneIS8HcDzj?=
 =?us-ascii?Q?EteEGPP0YJjA1mtveJeU8iwa38D+OlTEa7g7d/eQpmWLGzPdDHVhGqfA9dmF?=
 =?us-ascii?Q?yBTCsSXiKV7A0hMwxg/1IzkMC6XOjg/mPj4RqAwlFaTx44OLgZbqP4HRzsZD?=
 =?us-ascii?Q?teIO8IfwQ7RayFGPgsuk5D3TJt2+ATZA87WmucpP4fM7fn28HD+uHRCBS5M7?=
 =?us-ascii?Q?x2rJHG+ZUiT4Khj9pVEVIpeFZ8FqhbaFx1wLqtwz1Cyk+mDHcwx253SrmG/4?=
 =?us-ascii?Q?5IZmUeGSoWow7/yvxFY2P0Ny3OIjZFhQ3p+eEjxEce0OLvYTHHm3kFiVlr9A?=
 =?us-ascii?Q?oJSu18qgFAsTPJy+c32kicfcGIYJb6pkLZBlv3ZYwehUBIUd2pNBQfAKQbKz?=
 =?us-ascii?Q?kY5m7c4NGxrl1rqB+hD1Ya0h1eZLztUzjc4H5brCEB60+7znJy7xuEXs/mk2?=
 =?us-ascii?Q?FO1YeNphpOeo3edkw48KhMTcGnZicmewMhGcyfgkE/gxjY5UKBcJP/NjVGzH?=
 =?us-ascii?B?UT09?=
x-microsoft-antispam-prvs: <DBBPR05MB6505A92CAA32840C5DCE3356CF7E0@DBBPR05MB6505.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(53936002)(316002)(71190400001)(36756003)(6506007)(99286004)(446003)(26005)(386003)(478600001)(106356001)(66066001)(25786009)(229853002)(6916009)(476003)(4326008)(5660300002)(81166006)(6436002)(81156014)(93886005)(1076003)(11346002)(102836004)(54906003)(71200400001)(2616005)(105586002)(6486002)(8676002)(186003)(97736004)(6116002)(33656002)(8936002)(486006)(86362001)(7736002)(6246003)(76176011)(68736007)(6512007)(14444005)(256004)(52116002)(14454004)(3846002)(305945005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6505;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iVSNSBcL0lHngD+PMWEgYAlxi9weNHVfOqkzzhgB6alq8rIzm+0XjOumkGtcyDMhbkG4I2NqC3RBK0JirI3ESyfOmpa89PzTx+DnwyrMT441cDimZyia9oxhn01hieZYbsl+ByM72XzKofraeMRXODONStCtbmlYcXddUX0D2t7HfTzMtO9tjDf7poXlWaYfpZXY8SFz3C9bXM3bjtFhgAsuK6Mf9MCGwQ5CJuxbJyXFfcY6HJVdpG4lngQs/6kvxq2NPrf4DVeioyOio9q7Leu1U5aZ0/Zat4g0uKt4f/RdJDygyae7pcESBCyb5/ZjLIQ+OsOsiaQlu3ofiE2Wq1G/ZbpPPzAQsPISCTb2Ieg2EDnoZT/aMnsHjuj0oCNlF+eCQIpQ2EcbF/5ztM/v2U3MOSTIfHBsrMSwPqDXcyQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0E23B6138D82145A628566764491D93@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9222077-1970-4752-72ec-08d698239f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 17:40:07.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:47:16PM +1100, Stephen Rothwell wrote:
> Hi Jason,
>=20
> On Wed, 13 Feb 2019 22:09:36 +0000 Jason Gunthorpe <jgg@mellanox.com> wro=
te:
> >
> > I personally think it is not good to put major logic changes in merge
> > commits, so I would prefer the #2 approach for this case.
>=20
> These are not difficult merge fixes or logic changes.

That comment was directed at Matt's correct suggestion to use
alloc_cyclic, this same suggestion applies to this conflict as well.

The mechanical change of the args is not so bad for a merge commit.

> > SFR's tree is just a reference. Who ever takes care to resolve these
> > conflicts has to manually do the fixing up. If you do send your tree
> > early I will fix it up as part of prepping the RDMA tree PR. Otherwise
> > you will have to fix it.
>=20
> Neither of you need to fix it ...

Not quite, I always re-do and verify all your merge resolutions and
send them to Linus as both a raw diff and as an actual merge commit
for him to reference. This way these things are checked in multiple
ways.

It is difficult to run this flow if we don't have an agreed order of
trees, as producing the resolutions for an unmerged tree is not so
straight forward.

Jason
