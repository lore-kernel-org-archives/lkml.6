Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D4DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98693218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="SWhbt6cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfB0BGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:06:36 -0500
Received: from mail-eopbgr1320121.outbound.protection.outlook.com ([40.107.132.121]:11200
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729464AbfB0BGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTRPpZLEKZf76WNKRgAoenVeyK3JPPj1f01vcF6vDZ4=;
 b=SWhbt6cBYyXQEQNLKXy9JlpY+7sDexDuYNrHqjZtr2vpMqGzy77kOlgVWamd+bk2rr92OIBvHauij3iwC9MUi0bwBd6BSiHmnOqyG6MXLqrnm1FFZK0fZwyrocOS2rUR0GpQg4/JIzcVmYhf4WS13j1cHf5QG9kzbGtSEfb3D+U=
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com (20.179.170.147) by
 TY2PR01MB3097.jpnprd01.prod.outlook.com (20.177.99.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 01:06:25 +0000
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819]) by TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819%2]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 01:06:25 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Sergei Shtylyov (sergei.shtylyov@cogentembedded.com)" 
        <sergei.shtylyov@cogentembedded.com>
Subject: RE: question about drivers/phy/renesas/phy-rcar-gen2.c
Thread-Topic: question about drivers/phy/renesas/phy-rcar-gen2.c
Thread-Index: AQHUu458FqHVOGKcBkGy/69gWAAvIKXx6SwwgAADUQCAAQwzAA==
Date:   Wed, 27 Feb 2019 01:06:25 +0000
Message-ID: <TY2PR01MB481259F0AFBF6DEF9565792CD8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <alpine.DEB.2.21.1902030759010.19281@hadrien>
   <TY2PR01MB4812FA6549BA23233D9670CBD87B0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
 <alpine.DEB.2.20.1902261000420.3499@hadrien>
In-Reply-To: <alpine.DEB.2.20.1902261000420.3499@hadrien>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cb4f592-66f3-45d7-3d8f-08d69c4fcbff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB3097;
x-ms-traffictypediagnostic: TY2PR01MB3097:
x-microsoft-exchange-diagnostics: 1;TY2PR01MB3097;20:/C/1XZtvCzyptpF4aZPBsdL7AOZLijckE/FAdOeebuEHYiQMp939VClmmre39bsEWP8iUnurqoqCkufqflqz2LEGpcCh7yj7sj6SH8fVJ97mcwzBN1fGDad98n6BHb3n98qaBHsmH2yqSYsgxb6s7vcOslrepH8PkxxG6hQ7QWs=
x-microsoft-antispam-prvs: <TY2PR01MB3097DC32B0BE1A50094CF43CD8740@TY2PR01MB3097.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(74316002)(256004)(2906002)(55016002)(71190400001)(71200400001)(9686003)(25786009)(33656002)(53936002)(7736002)(8936002)(305945005)(66066001)(316002)(97736004)(106356001)(26005)(105586002)(54906003)(186003)(476003)(6246003)(68736007)(6916009)(52536013)(8676002)(5660300002)(11346002)(446003)(14454004)(486006)(229853002)(4326008)(7696005)(86362001)(6116002)(478600001)(76176011)(3846002)(81166006)(81156014)(55236004)(102836004)(6506007)(6436002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB3097;H:TY2PR01MB4812.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qLn2Skq0AV5eIafC2TTuUQkkukTQQVnKpL5y6tA4COOdvGlGzOI9HchO0MB7Y2q73GE9Knf2rrKYWYL88Mf+/2zuv+HCDOPy5C9ZHouE1hIWH6XVDGvXqNz9DRn5utYlHY4cXwgFDEiOLU9QEzqH6aAYxWPG+p34lhWEBLJCZVEUO1xNhpC3VbPKOJn+xc83lV8LD3bfpc316Xy5clS6MHbX1Cpz/iBv3Q/4+LIWQuQAbL2+Sn9+/HelaGpjE9yz7gBvscuBXrFJvBe7dBfuPB1ij4qJwTOu0T5RC9PfOz+yRIveCHpP/5fKOjbSJkjFBuic1FDL9y2pqytzb56lY2l90TmA49bDSwtMitJ59l7wgXH3ABFNJJmjO5DyftLkwrLVPm/qwKtXF0Ni0J6q6RlkL1O3qZoTp0jku2wGqCs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb4f592-66f3-45d7-3d8f-08d69c4fcbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 01:06:25.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> From: Julia Lawall, Sent: Tuesday, February 26, 2019 6:01 PM
>=20
> On Tue, 26 Feb 2019, Yoshihiro Shimoda wrote:
>=20
> > Hello,
> > (Sergei made this code, so I added his email as CC)
> >
> > I'm sorry for the delayed response.
> >
> > > From: Julia Lawall, Sent: Sunday, February 3, 2019 4:03 PM
> > >
> > > Hello,
> > >
> > > I was wondering whether phy-rcar-gen2.c would use dynamically allocat=
ed
> > > device nodes?
> >
> > I'm sorry, but what is "dynamically allocated device nodes"?
>=20
> Device nodes for which there will be a meor leak if one doesn't put
> of_node_put.

Thank you. I understood it.

> julia
>=20
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > >  If so, it looks like the following code could cause a
> > > use-after-free, due to not incrementing th reference count:
> > >
> > > 	for_each_child_of_node(dev->of_node, np) {
> > > 		struct rcar_gen2_channel *channel =3D drv->channels + i;
> > > 		u32 channel_num;
> > > 		int error, n;
> > >
> > > 		channel->of_node =3D np;

IIUC, since the channel->of_node will be used for comparing the pointer
in rcar_gen2_phy_xlate(), it is not use-after-free.
However, the for_each_child_of_node() in rcar_gen2_phy_probe() will return
without of_put_node() at error paths. So, I'll submit a bugfix patch later.

Thank you very much for your report!

Best regards,
Yoshihiro Shimoda

> > > 		...
> > > 	}
> > >
> > > On the other hand, if the reference cound it incrememnted, preventing
> > > memory leaks in the case where the probe function fails would entail =
some
> > > complex rewriting of the code, so I thought it would be better to ask
> > > first.
> > >
> > > thanks,
> > > julia
> >
