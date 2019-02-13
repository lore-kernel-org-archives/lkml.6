Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1377821872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LgW9saob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbfBMWJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:09:41 -0500
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:63396
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404076AbfBMWJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwvkMDHX0X9RGtvdpu2ZEZwe658974f+ygwhlR1hsyM=;
 b=LgW9saobROlLwnbRsruUUqvEJ0gk694mTpi/9Zmds+Ab7DCLKoEQvAvi3+9TCiq90RSONTbt3EsbM/Xi4JSJ5Uc8UsQkybRmAZYtJJdZN6u7q/6mSsHB5y3crul3cmAgNFtJafl2YjS4yJFkW9G5tQnp/NF6IjKjhf033gCdoMk=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6524.eurprd05.prod.outlook.com (20.179.43.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 22:09:36 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::34e8:76a2:998f:581a]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::34e8:76a2:998f:581a%7]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 22:09:36 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUwpKghnGnnsxrwE6OI0HelaAfeKXcVzAAgAACOACAAeb8gIAADAqA
Date:   Wed, 13 Feb 2019 22:09:36 +0000
Message-ID: <20190213220929.GO24706@mellanox.com>
References: <20190212162003.1aa1ffbd@canb.auug.org.au>
 <20190212161528.GN12668@bombadil.infradead.org>
 <20190212162324.GU24706@mellanox.com>
 <20190213212621.GW12668@bombadil.infradead.org>
In-Reply-To: <20190213212621.GW12668@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0080.namprd02.prod.outlook.com
 (2603:10b6:301:75::21) To DBBPR05MB6570.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3eed5f1-a68d-4251-a5c0-08d691fff0da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6524;
x-ms-traffictypediagnostic: DBBPR05MB6524:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DBBPR05MB6524;23:vKLlirWEJ2VIcbs7h2vAKeX6SPd1BTx+rcPbzVbJH?=
 =?us-ascii?Q?hL5QaXlXGMaOIW/IVHkkjaDojEPPGhEjkloDJknvhZXthFA1Z/eb72P/PrgX?=
 =?us-ascii?Q?/4+3nTnQQr7+wJQ/7T3f0ZlSVWEtlRNs8xjMM1INz7Wk9ck2sPLYNHPhVZYJ?=
 =?us-ascii?Q?1zrTGBlAJCWlKd1OO2qgH1fkU2dssQu2KhNY+AMi8DOMjjHICg96D9tkng17?=
 =?us-ascii?Q?FKkrs3/fWe4qx0ZKJ8uaqm2qC3ojFz/AblnJon8mnaO9REvjH0012rIqWtTj?=
 =?us-ascii?Q?/blOu8Hu4oQ+KhMc3mQr7RoN5dhv44XJD3PdXuCgzRDSzfW4ls+JLgigsVb3?=
 =?us-ascii?Q?NLXGoTsppoxMleKwgLHn0gwtVo1S+HCNEHmnutsRCN0JqILO+BSMzbZjgAJw?=
 =?us-ascii?Q?gJ8DODeJRejSuapn1lLXNPBaYIQEFQwIIgwZ7Km5CVLRAnnrZ4IkuOwpNpsN?=
 =?us-ascii?Q?TahUP9yept0FAU1808oKz3p8JID1tFvwsYJwRZiRkxcgFF/hthfnj4P5qcGj?=
 =?us-ascii?Q?HGLWijV033u+fS2Vzu/uw5hLBthWkmLqzns+RYdeoO9ZfZRlRIN8sDt6WdBJ?=
 =?us-ascii?Q?29OoMw+0v1WVz6CVq4Hd+CPA3P56b0LOQiaU45tMAJwRmBTYkNYTNJsEgsyF?=
 =?us-ascii?Q?3PkPwSXTWtPOs2aQv5gM1drDBiXlZdUTx+9xAhqXGR0jnJF2KTtsLG98OucU?=
 =?us-ascii?Q?ZevxbgoMBhko6iAlgFvWIKk9Yu315wa3nNi6d5Ps3jp7X4g7hi38vOuufvXJ?=
 =?us-ascii?Q?+8q4WjsmtgcCQWuyFx6f2BMaXFqQUGh+U29MRZ6RCn4OPOXY58iOBoRfi875?=
 =?us-ascii?Q?GcaAQQw63uM7H1ttF6MYSJpng3cX3VlEivWIWYhchqsVvzwNpqNEA+WAJem3?=
 =?us-ascii?Q?EbxkHn7B329RSkNIsQv0HtPH4VlM1LtDPyydOMbRvSnXgvZ2mgOH8IaDaG7/?=
 =?us-ascii?Q?nwRNAdL/Z8r0qHXdacPGspZz5ZeIZm9f8MYSbXcr4sCcmoxwVhSqmCGQ34zo?=
 =?us-ascii?Q?ZVTs5D1Fdi6MCpLR9I2FR9XFqK2WrCOcxtOM/4d6Q81lJkWfjVUQvGVNX2so?=
 =?us-ascii?Q?8BssGPh60e0dKV5eIEkHLY6ucvHzCjXNkyWslpNjqgqXvQYDFe4t8MfvebdP?=
 =?us-ascii?Q?YRV9pmb3tgzcQyrxMAIBzpDmcQibDX7niGJ9maWJV7Cyk4gOHxkePqXAAjdQ?=
 =?us-ascii?Q?Aj8/KudBfuxycS1008WaV6WarL6Scf3O8XrAAq4k+9Yo65nsmHbU5Bx8rECV?=
 =?us-ascii?Q?Hrv5QRo7EqMn8XP2FIzzrzOQPqr3rc7Cuf7t8mbjKthMTJ43qNBMYCwdRyVN?=
 =?us-ascii?B?UT09?=
x-microsoft-antispam-prvs: <DBBPR05MB65245780DB437DA9EFCE1211CF660@DBBPR05MB6524.eurprd05.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(52116002)(99286004)(68736007)(478600001)(8936002)(81156014)(8676002)(966005)(81166006)(102836004)(76176011)(316002)(305945005)(7736002)(54906003)(33656002)(86362001)(14454004)(6116002)(3846002)(486006)(11346002)(2616005)(446003)(476003)(4326008)(36756003)(71200400001)(25786009)(71190400001)(53936002)(66066001)(6246003)(229853002)(256004)(6916009)(6512007)(106356001)(6306002)(97736004)(186003)(105586002)(14444005)(26005)(386003)(6506007)(1076003)(2906002)(6486002)(6436002)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6524;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eoCg+bWkq/2CUH8g7pbCBgH6g2PqZqcJnThmDekgbzHhZU0flpZjYSxSet4BeCHcaKn90bSdvHSR9O6Zk3v4Cj2Jrg4crVlViEAwvCcuV+FQjoK8LLBghB+duGXrMCWY+8Jm1Ma38tmoBcUjMyYcQLuelfy8aHIbE/wKR5r677e6VU6uugsGU/sjQzDA/NELd02U67MGSTQm/tkjND3HoN8CFvNH5/SMSJcm4DpGild1lpdJrO+tsyHN3Cjo8xtZiEhY6pd1tUv/5KfxyPKPGq6hVYf7/Lz+fakc3gyPdnmx/qwciJ0ye43VkP3b12rO3PWFaCTBR1ppM+alZPA1OBDnnVVlSEFhHOMy5GrFumPTq4BXcIil3qlP9rR3xW90mG+ZWSJpradGF+T4AZF0evDX33L/4aKhdoM4IgYsudY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8529BD425F11A841A0C9B902E24867A5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eed5f1-a68d-4251-a5c0-08d691fff0da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 22:09:36.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6524
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:26:23PM -0800, Matthew Wilcox wrote:
> On Tue, Feb 12, 2019 at 04:23:31PM +0000, Jason Gunthorpe wrote:
> > On Tue, Feb 12, 2019 at 08:15:28AM -0800, Matthew Wilcox wrote:
> > > Seriously, there are several defects in the published API which do
> > > warrant a change.  The most severe one is that it's really easy to
> > > forget to initialise the start index.  And while I'm making that chan=
ge,
> > > I should fix smaller things like the errno at the same time.
> >=20
> > I hope you will send your tree in the 2nd week of the merge window
> > with all these merge fixes in it..
> >=20
> > I think Linus will not like it if he has to fix this when merging
> > rdma.
>=20
> Ahhahhahhah.  No.  Burned once.  Not doing that again.

I'm not suggesting you should do that - basing on the nvdimm tree to
avoid conflicts was a terrible idea.

There are two sane approaches you can do here:

1) Base on -rcX and Merge to Linus's tree and resolve all conflicts
   before sending the PR. The PR should ideally go in the second week
   as it is a tree wide API change.

   You can read Linus's comments on handling complex merge resolutions
   in PRs here:
    https://lore.kernel.org/lkml/CA+55aFzcp=3Da2sNOVR7DTEY9dehYamXaJ1bpSfF0=
FZir_9MhsVg@mail.gmail.com/

2) Rebase on top of Linus's actual tree in the *second* week of the
   merge window and resolve all conflicts in your rebase, then
   send the PR.

In both cases coordinate with conflicting trees to have their PR's
sent in the first week so Linus sees no conflicts.
 =20
This is basically the same advise Linus gave you:

https://lore.kernel.org/lkml/CA+55aFw+dwofadgvzrM-UCMSih+f1choCwW+xFFM3aPjo=
RQX_g@mail.gmail.com/

Linus talks here about the trade off for #1 and #2, with a preference
to #1.

#2 is good for "you just want your series to make more sense on its
own" - which I think is where tree-wide changes tend to end up.

I personally think it is not good to put major logic changes in merge
commits, so I would prefer the #2 approach for this case.

Also, the general philosophy that the person doing the tree-wide
change should do the work :)

> > > @@ -750,7 +738,7 @@ int ib_register_device(struct ib_device *device, =
const char *name)
> > >  	int ret;
> > > =20
> > >  	ret =3D assign_name(device, name);
> > > -	if (ret)
> > > +	if (ret < 0)
> > >  		return ret;
> >=20
> > This <0 should be near the xa_alloc_cyclic, I don't want the unusual
> > '1' to propogate.. Far too likely that someone will forget about
> > the special case.
>=20
> Feel free to propose an alternate fix for sfr to put in his tree and we
> can both include it as a proposed patch in our respective pull requests.

SFR's tree is just a reference. Who ever takes care to resolve these
conflicts has to manually do the fixing up. If you do send your tree
early I will fix it up as part of prepping the RDMA tree PR. Otherwise
you will have to fix it.

What I don't want to see is we send both trees at the same time and
neither gives merge guidance to Linus.

Also, FWIW, there are two more series in the RDMA patchworks adding an
xa_array call.

Regards,
Jason
