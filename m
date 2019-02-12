Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D833BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEFB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="M4Zfl5Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfBLQXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:23:36 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:27296
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfBLQXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS4Rd/k377S8qTQeDtidqY5K+qcYephBYXskgKXqLx4=;
 b=M4Zfl5HyAM2pkVyGqfjv8zj4Jol0jRg6KTAvFDO2jtwritqi43Owp/HLWy2KI7c18RWoMLt4Ww2kf+TbEPf9gqa58PGNO5uMYZKVS8T7aGrQzdLHB1v1AH9pizmZJqMHzX8DAY+wYTzAQWb+vBmJpHxKOlMIbNLOKG0RfKK0kJY=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6314.eurprd05.prod.outlook.com (20.179.40.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 16:23:31 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::34e8:76a2:998f:581a]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::34e8:76a2:998f:581a%7]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 16:23:31 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUwpKghnGnnsxrwE6OI0HelaAfeKXcVzAAgAACOAA=
Date:   Tue, 12 Feb 2019 16:23:31 +0000
Message-ID: <20190212162324.GU24706@mellanox.com>
References: <20190212162003.1aa1ffbd@canb.auug.org.au>
 <20190212161528.GN12668@bombadil.infradead.org>
In-Reply-To: <20190212161528.GN12668@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0044.prod.exchangelabs.com (2603:10b6:300:101::30)
 To DBBPR05MB6570.eurprd05.prod.outlook.com (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6314;6:nNTI9Ty3zChPBKjf/lt8zI8B6spxg21/EVGVnuxFD9a+WSxCabFcnZ1bH2rK3LRuW1vQ/o00Xssg73uRiuJHN+8XkPWeMoNwJzqtaNNaRp6vkfPk6KN023/He/7rBbbeEBtODd/pwovWQNPDxlqvRidrCl9Pusw9CL/dPy+IC84f3OarXDiMgB4BCEyT+UeXMTDSnVB+FBGGozu5kwGV3T7tZrwfZzLY3ONdZNfxvYarP6DP0djOVkmEUPJJoymSBvqABOApoLLBmW1USvLX90qvl640h+OjCxt4BO/fIB28clZpm6UERvOhhGc6JPttfKN6/7VoLMVyhGORk767kSCjhRIOrfX9preXLAxj0vX0GmQk49n7DcyAGOo63MBoPFNgocV74rZktq3NGM89OMSo2iTogS3bEhMuFHnyl6tBIfS68Lywhav9ctQK7Ew7wvxr/pB+Sx6JC2fcz8rpeA==;5:jgy2YnKHBQ3hmhqYZTUDUmN0kjau+x4U4/z674H4OoYhB2eJSVh0fDtYY245U+DCRDL9CJNYTQoxSVX+A2CgQbx1KeIcMLrlpMTyooNO7EpZz5LOnivaSWH86oCt/FqDvpqNcH59tmb0V483NDlHscMllJGg0Rq35kRoSrN04XIXi1ZsmRJrkVYETSEsJ94OXlCEfu/oGeS4N7E+4r+vZw==;7:YjmFQuAjbf6nuzpcizlNYj/SXQwX1YwVlgvnntq+FNl/hxf0FGqCPqrVysooFGm7Qr8zznFEE+AHr6JzKd6TrFVQmUgXB66HCUP6VbOixnW0nhPqu8n6NmFNYLLiQ6BCpRbKUyUv2wq3QiPmXPrQVg==
x-ms-office365-filtering-correlation-id: 3db25def-942b-4911-e505-08d691066d74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6314;
x-ms-traffictypediagnostic: DBBPR05MB6314:
x-microsoft-antispam-prvs: <DBBPR05MB6314317CD870987CDA66B795CF650@DBBPR05MB6314.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(86362001)(6486002)(486006)(71190400001)(71200400001)(6436002)(53936002)(6512007)(36756003)(6246003)(25786009)(81166006)(8676002)(81156014)(14454004)(476003)(97736004)(68736007)(2616005)(3846002)(6116002)(52116002)(76176011)(229853002)(4326008)(256004)(14444005)(316002)(7736002)(478600001)(99286004)(6916009)(54906003)(446003)(8936002)(11346002)(2906002)(33656002)(66066001)(106356001)(102836004)(386003)(186003)(1076003)(26005)(6506007)(105586002)(305945005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6314;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NMLOgsf4VO34OfnpDwUflVnPSIb+DP3IuLypw4wlFzovivcB30bVjOuW971As4IbZBucbC+ygMo1U/jk/UqHYQ+Khxl31iE3y5Rg5C7xTpPfqQBy7SCfePX6AYfehzLILQolRM1fDRxQSlqQ+WTLG2q5Bs54vcqx2KTG7XcuHnlX9M+iVSXsN904rH8t929SG0mMlh9a0JT6is7K5c6by+rcaIMKyre259nuuDWYC7AAZ4+MkA6mmBSmaCjm2IqSuue840ZnSzgfoC/rkaSzLaDYjIJXXWxaUtdZOgNicMLQxVhbESQ5TRGM10q11Fi3ttJjOuoHyYwji/bEY9tpp6pC9WQGFclJzLngwfS1XTtaUlAQdkW/d2rYbVYyCgsmd+7mhCtM2lJ7d9VpZurTAAYpN+mblhkm0O5O95UF1g8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE745D5970C34D44855AEF1CD75FDD55@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db25def-942b-4911-e505-08d691066d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 16:23:31.1702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:15:28AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 12, 2019 at 04:20:03PM +1100, Stephen Rothwell wrote:
> > Caused by commit
> >=20
> >   a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")
> >=20
> > interacting with commits
> >=20
> >   e59178d895af ("RDMA/devices: Use xarray to store the clients")
> >   0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
> >=20
> > from the rdma tree.
> >=20
> > Its a bit of a pain modifying a published API like this :-(
>=20
> Yes, it is.  I wasn't expecting people to actually start using it ;-)
>=20
> Seriously, there are several defects in the published API which do
> warrant a change.  The most severe one is that it's really easy to
> forget to initialise the start index.  And while I'm making that change,
> I should fix smaller things like the errno at the same time.

I hope you will send your tree in the 2nd week of the merge window
with all these merge fixes in it..

I think Linus will not like it if he has to fix this when merging
rdma.

> > I have added the following merge fixup patch for today (I assume some
> > of the assignments are also now redundant).
>
> I think the first of these should be using the alloc_cyclic API, like thi=
s:

Yes, it is waiting for you :)

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 283ecc2aee89..d0b56c70a553 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -586,20 +586,8 @@ static int assign_name(struct ib_device *device, con=
st char *name)
>  	}
>  	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
> =20
> -	/* Cyclically allocate a user visible ID for the device */
> -	device->index =3D last_id;
> -	ret =3D xa_alloc(&devices, &device->index, device,
> -		       XA_LIMIT(last_id, INT_MAX), GFP_KERNEL);
> -	if (ret =3D=3D -ENOSPC) {
> -		device->index =3D 0;
> -		ret =3D xa_alloc(&devices, &device->index, device,
> -			       XA_LIMIT(0, INT_MAX), GFP_KERNEL);
> -	}
> -	if (ret)
> -		goto out;
> -	last_id =3D device->index + 1;
> -
> -	ret =3D 0;
> +	ret =3D xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
> +			&last_id, GFP_KERNEL);
> =20
>  out:
>  	up_write(&devices_rwsem);
> @@ -750,7 +738,7 @@ int ib_register_device(struct ib_device *device, cons=
t char *name)
>  	int ret;
> =20
>  	ret =3D assign_name(device, name);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;

This <0 should be near the xa_alloc_cyclic, I don't want the unusual
'1' to propogate.. Far too likely that someone will forget about
the special case.

Jason
