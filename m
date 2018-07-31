Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B78C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634242083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="APx7tREG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634242083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeGaWyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:54:21 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:36412
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729761AbeGaWyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KVlB2aF3H7LvktcYe0A7y2YG7zktiII/hatIGn1RbU=;
 b=APx7tREG21U/MT1b2blAzxtNmocmZstuq5oB/0Nfpwu5NkV7uhbrLxJMRsjQ70RWBYva2T+n/AMpIQxV0uDR2XQ3MnPT9lZSvscHqBc9wVAa/k3sOFQW+0vWuYnBwQbku5TQ6W+2hCz+VhERrM9EsqQGdotyT+VIDQt6kPenclE=
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com (10.175.21.22) by
 VI1PR0502MB2893.eurprd05.prod.outlook.com (10.175.24.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 21:12:01 +0000
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786]) by VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786%7]) with mapi id 15.20.0995.020; Tue, 31 Jul 2018
 21:12:01 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Topic: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Index: AQHUJVRUTB8GmjpwI0+ZUp6KP0x+UKSiaTKAgAAYRACAAAPAgIAHVegA
Date:   Tue, 31 Jul 2018 21:12:00 +0000
Message-ID: <VI1PR0502MB3008076016496152D4898D8ED12E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
        <20180727024832.GA30023@mellanox.com>
        <20180727132847.2be8563b@canb.auug.org.au>
        <VI1PR0502MB3008702AFA64F44DE57DC9F5D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20180727150903.0f2816ba@canb.auug.org.au>
In-Reply-To: <20180727150903.0f2816ba@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB2893;6:vjVFiDAptYfca5H6AB3MF83XS2g1n6ik0fIqRpFM1s/67lLWRSglWJnZF0OQqCcq/XVJGfI3qRBHFWHQDoVmuIBVe+f2jrnbMEgr6QOfMbTWwyGSlQp18/BugVOVxVKX02OyL7KhkEns54RvXjPhfCyIJGfAeHHVXCSXspQMdx1sjSCFXkqTJ2MlSBG0VHtj+0nl/BomQbP+hpvj5SFjBqZXr/intABpffi4uJnU8vstQBqvCUuYViNnNu/6aMwi/rWeXVhWKCfJhhjVCl1DDa35bowi57oqUheWAZSdgkI1MTcmaIxq3huCr7t8UNoYF7NOAOjAvvz6yySuZkMpYpGFluaqBXaMlUQekO+qcykYx3K2dC2r+MVuWMP6phk7hbYatPoJL0wvEbn6MyD62LmL0DBlAXFi5AwEjJrLsum4FuKIQ/o3K9vTIRte3GPN3nxgF20xB720pmCvNlgqCQ==;5:7pb4oi2rfF5yFi8R+DSK/uBUlyjeGKWWlRN33EEdjWbFJBykaabVVFre1aHH/L1yyGsn1QIxg+jonNhjRm3OVOTjfGbN4WPbjAcWw78QSnY9PaQwuoUWFG4AfY3QGr+XBpUKk+e47PHwV2z/osAz5EdsvHrA6Zp1Y+Zf9hDxbLM=;7:bsVC41oD24X45o8vCYinT3YZeooCxPWYLn1MIh62+r8RX5bsV3fZF85qa14ZPu9lbjmhFnzbwyqhCnzkzU27TXFrwGA4nMRJHEUjcV3keV6f+TFyQJJpa2wP1UMHmZkQ2FvDccbMUinfBvecSwE4g6HNtNSq7Y5kuRiXJoY8l5Sh2FFXZDjnKM8qyq65clnBOdO1LGXurs/AWbzCz6auF/ydeYw1ND1ClyI0ChIZQh+WFe2n0/56vORXwdgfmEUS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d86144b1-45a2-44c4-a341-08d5f72a420a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB2893;
x-ms-traffictypediagnostic: VI1PR0502MB2893:
x-microsoft-antispam-prvs: <VI1PR0502MB2893F04642503B6FD7C93CD9D12E0@VI1PR0502MB2893.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(84791874153150)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0502MB2893;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB2893;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(13464003)(9686003)(68736007)(76176011)(93886005)(966005)(105586002)(97736004)(25786009)(2906002)(186003)(305945005)(53936002)(74316002)(7736002)(66066001)(26005)(486006)(446003)(102836004)(99286004)(476003)(575784001)(14454004)(5250100002)(6436002)(256004)(6306002)(55016002)(53546011)(6506007)(86362001)(7696005)(54906003)(4326008)(316002)(8676002)(6916009)(5660300001)(6246003)(6116002)(3846002)(11346002)(106356001)(478600001)(8936002)(229853002)(81166006)(81156014)(33656002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2893;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eD+/3CWfBJTwbng5JOP5U8fvA9O56y10P5bXfCdjunr09iyCZSKZwysGL5//eutZt6BONmWmJSTaDPLjv5/w7wxixNgsKA+bzPw76n3DlNGMeuvjGhxsv3hS9Dp4K+vYgc7Rj3CdvrbELeeSVJqwGn2SBqGCLER3HLD2XDmW7WVNWGbow4GaNOuZ9/SlitGZy2KbVi9SXl5nqwDu6FN83TNDMYIkdqIUaDbm7iaS5OrbTzHXK2sWN7cAOUiFf6Tdcfk+H48kUNlgQocb9tbLsu1ebtIynen0ObVwauCikOhHU2lABi4GC5Y6bkzHyZa5DKo5KyaBmDBW1MDNhtViciD15tZl8LIT1XwdGgXvyIc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86144b1-45a2-44c4-a341-08d5f72a420a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 21:12:00.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2893
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-owner@vger.kernel.org>
> On Behalf Of Stephen Rothwell
> Sent: Friday, July 27, 2018 12:09 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>; David Miller
> <davem@davemloft.net>; Networking <netdev@vger.kernel.org>; Doug
> Ledford <dledford@redhat.com>; Linux-Next Mailing List <linux-
> next@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Ursula Braun <ubraun@linux.ibm.com>; Leon
> Romanovsky <leonro@mellanox.com>; linux-rdma@vger.kernel.org
> Subject: Re: linux-next: manual merge of the net-next tree with the rdma =
tree
>=20
> Hi Parav,
>=20
> On Fri, 27 Jul 2018 04:57:41 +0000 Parav Pandit <parav@mellanox.com> wrot=
e:
> >
> > >  	for (i =3D 0; i < smcibdev->pattr[ibport - 1].gid_tbl_len; i++) {
> > > -		memset(&_gid, 0, SMC_GID_SIZE);
> > > -		memset(&gattr, 0, sizeof(gattr));
> > > -		if (ib_query_gid(smcibdev->ibdev, ibport, i, &_gid, &gattr))
> > > +		gattr =3D rdma_get_gid_attr(smcibdev->ibdev, ibport, i);
> > > +		if (IS_ERR(gattr))
> > >  			continue;
> > > -		if (!gattr.ndev)
> > > +		if (!gattr->ndev)
> > >  			continue;
> > This requires a small fix.
> > If (!gattr->ndev {
> > 	rdma_put_gid_attr(gattr);
> > 	continue;
> > }
>=20
> Thanks, I have fixed this up for Monday.
You might want to consider this compatibility patch in Linux-rdma tree to a=
void a merge conflict of smc.

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=3Df=
or-next&id=3D7aaa1807e698f73094b78f0ef25b1a37a4409a55
