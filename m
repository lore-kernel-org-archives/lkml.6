Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272DA2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="jZJsg06b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfBZIy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:54:28 -0500
Received: from mail-eopbgr1300092.outbound.protection.outlook.com ([40.107.130.92]:48255
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfBZIy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uut/mGcHBmUignsXLibSdvC+dsW8jFf3zzkJ1KrOEW4=;
 b=jZJsg06bJtniUApGLhCHHujuPF9Qp30CIevEbnLUQRXAYD6kh48NTJaM5yL3EJ/GsfqFjyawtTUxrDnvL2CCjhv9rL3EvM0CIJFjuUQu0F7VlfWpZ/vE2Z7UPFnUcBw53hn6WnCj20TxmXNn8J60suD63nJBlD2UnZnr51IPa5k=
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com (20.179.170.147) by
 TY2PR01MB2843.jpnprd01.prod.outlook.com (20.177.97.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.19; Tue, 26 Feb 2019 08:54:21 +0000
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819]) by TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:54:21 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Sergei Shtylyov (sergei.shtylyov@cogentembedded.com)" 
        <sergei.shtylyov@cogentembedded.com>
Subject: RE: question about drivers/phy/renesas/phy-rcar-gen2.c
Thread-Topic: question about drivers/phy/renesas/phy-rcar-gen2.c
Thread-Index: AQHUu458FqHVOGKcBkGy/69gWAAvIKXx6Sww
Date:   Tue, 26 Feb 2019 08:54:21 +0000
Message-ID: <TY2PR01MB4812FA6549BA23233D9670CBD87B0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <alpine.DEB.2.21.1902030759010.19281@hadrien>
In-Reply-To: <alpine.DEB.2.21.1902030759010.19281@hadrien>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed22f04a-a458-427d-05f8-08d69bc80032
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2843;
x-ms-traffictypediagnostic: TY2PR01MB2843:
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2843;20:GgUj5dQNli3MXbESXWT0qIZCeIV6TVdtFzIwhUC52UDvuDRjAIj+2I/FKEc2o/iZ68pFz8NvxNhUI8RflBRNz3VZ+CHqtM/D0FIx+9XOLXKbzq0u6mVpBKaq8UCenvGwMFN3yX0RKIab5Y8Q8CpxSECZQ4Qbq6bHLaRFX1++9t0=
x-microsoft-antispam-prvs: <TY2PR01MB2843A4C9FFFCF80ACA182C8DD87B0@TY2PR01MB2843.jpnprd01.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(68736007)(76176011)(305945005)(4326008)(54906003)(7696005)(5660300002)(476003)(71200400001)(2906002)(71190400001)(53936002)(8936002)(25786009)(186003)(26005)(66066001)(105586002)(6116002)(3846002)(99286004)(106356001)(486006)(33656002)(6916009)(316002)(55016002)(6246003)(6436002)(11346002)(86362001)(446003)(52536013)(14454004)(4744005)(229853002)(7736002)(9686003)(6506007)(8676002)(55236004)(97736004)(256004)(74316002)(102836004)(478600001)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2843;H:TY2PR01MB4812.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E2T3VHwxUQYATau63VTlhkhNsWvMb4kaxYY1EvnS+O0oRD5R82BamjgCZVMEf2oWJYLOs6sS97xDA2zs/ayDBLHQ3tn+T7VeuY+OjcvP4UXQUOPpPhY8KvRpFIIPwh3cLoNQBWhDHFvThKqIg4IrpPQ9m1dxpg7sC4ZndWcTCWKw6dQ6w6Akr1Uz3hvyE8HZbSY87Fh0KDR/wuGYjkRsHcKYeKeUhA48HMLA7iohys6S00ad9nPPKQkJCnp7it76nhx2rbBV6CUqvI+odEUGddDIAkDaJllheu8TnXNlheVyoj/WuHwssiJM1/X5OzWdAx5Nlj+JSh/Msdi2x0uqwAizuFFf5zbyZUFgKrHChWGpOpAmkqbwLekvEdrO+oVE/EI0EgAoBmi6bOC1PCKIgvZ1vIsocfq5OduaLM3Vo8c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed22f04a-a458-427d-05f8-08d69bc80032
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:54:21.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
(Sergei made this code, so I added his email as CC)

I'm sorry for the delayed response.

> From: Julia Lawall, Sent: Sunday, February 3, 2019 4:03 PM
>=20
> Hello,
>=20
> I was wondering whether phy-rcar-gen2.c would use dynamically allocated
> device nodes?

I'm sorry, but what is "dynamically allocated device nodes"?

Best regards,
Yoshihiro Shimoda

>  If so, it looks like the following code could cause a
> use-after-free, due to not incrementing th reference count:
>=20
> 	for_each_child_of_node(dev->of_node, np) {
> 		struct rcar_gen2_channel *channel =3D drv->channels + i;
> 		u32 channel_num;
> 		int error, n;
>=20
> 		channel->of_node =3D np;
> 		...
> 	}
>=20
> On the other hand, if the reference cound it incrememnted, preventing
> memory leaks in the case where the probe function fails would entail some
> complex rewriting of the code, so I thought it would be better to ask
> first.
>=20
> thanks,
> julia
