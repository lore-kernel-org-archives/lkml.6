Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D407AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907AD21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="h+3MnqGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbeLUKjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:39:48 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:52599
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731585AbeLUKjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCmM4RHHKomzSpDkHu0CdKjitNmgO3f6zhJXiKRPvFA=;
 b=h+3MnqGrxEeNwNE7cAP+BoSMUdT++7f6PtE/fhZBNJPFzxmhSos8I24TtU0Di3seMbOt3pq07d4UM9JeYG/N4qTUhvFs1HdtXbQOju8s9Ew5dmFYyhoPhSxd5eszqldrZ9Faw2tM9RuCN2skEXMYtUwvtISGn5qTJ0K1y/9Jnr0=
Received: from VI1PR05MB5630.eurprd05.prod.outlook.com (20.178.120.87) by
 VI1PR05MB3167.eurprd05.prod.outlook.com (10.170.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 10:39:42 +0000
Received: from VI1PR05MB5630.eurprd05.prod.outlook.com
 ([fe80::88fb:90c6:bac3:9761]) by VI1PR05MB5630.eurprd05.prod.outlook.com
 ([fe80::88fb:90c6:bac3:9761%5]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 10:39:42 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Petr Machata <petrm@mellanox.com>
Subject: Re: drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2547:
 undefined reference to `vxlan_fdb_find_uc'
Thread-Topic: drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2547:
 undefined reference to `vxlan_fdb_find_uc'
Thread-Index: AQHUmPT82tqIjJuhEkm+36BCkE3yuKWJAQkA
Date:   Fri, 21 Dec 2018 10:39:42 +0000
Message-ID: <20181221103940.GA14915@splinter>
References: <201812211441.RKzjHjl9%fengguang.wu@intel.com>
In-Reply-To: <201812211441.RKzjHjl9%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0045.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::22) To VI1PR05MB5630.eurprd05.prod.outlook.com
 (2603:10a6:803:c9::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.180.15.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR05MB3167;6:t5E1+pFmSsQBtYJeOxqWIWNdFvnbjgfYOExhylXrGrdE12l7ZAVdcH3Q4Pu3j8iraThrdEEgpYmZzYrZMWmQJEFSgbJqA/t0V8I7ChmC1QywwMlDAhREhe9YLld45BiFIX3cqWUELOKB1ACheCAJzElVJ1HdtMnbr7UeVacwdZaIRtNs/3FZQo099cek8QNy9mjKaYOyDdKzZBH8HgrjCR/X0oT7qXu6c5+5uomb1u5s3XTtYoZ37EmIuKm+F2lGA1BOxQ0NlLM4jEo6CVnlXV4rq/P7pvQOHJjSFxOHfDTcqfARswXLefrlsZ1T+8b1g24nqzI9PFCHOTJGWLshdiDSbP/WQAgVtIy98537JhZRW16GW6StHvEpA51LwyVkNFwL1FvjZ3IKXL8F7ctpUGa9FUKwb7HBOMceo3AiqpUGy3Z+KhaJ4zJ2IvYD/MbzNpQCNlfFhXMoVCAlDN7G7A==;5:4dKm0D9i4N58IKSSEfNVlwG8sOMSfxrNG/EYsHJYKjApZ14Wy4pZvtMVIags6yfTEWz0ucZl7VSfQ+gHm6iOYPkfkwbjH4rxHKdyopObIR3cmZbyMm1OlXfVi08OXPB/H9xmacRP8QmlLZ7ObkkOhJs6oCR4BujVOMmIhUzYVWc=;7:dVLT/cfXpS4Tni3IddWnHfH6/q8nca1MzZ8nYOHmY1HdMJ2n3ElqTuAkGZvkV4CtdJ8uddUgO/TBZz+P1btXc+DLEv0PpG5MyusZXHV0D+6OubaXM6XNcnukpICRlaAWqWActc0FnbLTtQJJAzUlYw==
x-ms-office365-filtering-correlation-id: e042f359-8af2-46de-70f9-08d667309db8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3167;
x-ms-traffictypediagnostic: VI1PR05MB3167:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-microsoft-antispam-prvs: <VI1PR05MB316712912FCEE52723E4B974BFB80@VI1PR05MB3167.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR05MB3167;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3167;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(376002)(39860400002)(366004)(346002)(189003)(199004)(52116002)(6246003)(14454004)(1076003)(2906002)(53936002)(54906003)(256004)(6506007)(186003)(11346002)(446003)(386003)(5024004)(107886003)(4326008)(305945005)(33716001)(8676002)(81166006)(81156014)(229853002)(9686003)(6512007)(68736007)(8936002)(6306002)(966005)(76176011)(478600001)(71200400001)(66066001)(71190400001)(3846002)(6116002)(316002)(97736004)(102836004)(575784001)(25786009)(33656002)(6486002)(5660300001)(105586002)(6436002)(476003)(486006)(33896004)(86362001)(26005)(6916009)(106356001)(99286004)(7736002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3167;H:VI1PR05MB5630.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UUJ15bTa4mNd/q0HqwwSE1emhKOqFWubRE/8VIGluCXpRVrBmHAAsayVmXu1fTIWAhrBVI2ZK9lNYpckekiuyRI09OaRU9SX5PWXOi0rVt6vQhi02NT4RIrUZGfIK60oXhmmbX71EIE61kiNzOAHHjbTY/5H0uZuj27fQTTN4NLj4WqkohA540n0WABI24XmcLSVXHaMBkUcwccGWAY7xm+tLPQusLjMj7D55sf9RXWkHuaCfekbsKnjtZJI+XT+2c7QAJ68spYDuaIjrTETtv0f2i4dFCPFTpCihBozDXaH8GvZw/UI6ECQYhahhVpP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DC4205A06BCF0418B1CE999C41A70EB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e042f359-8af2-46de-70f9-08d667309db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 10:39:42.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:13:03PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   9097a058d49e049925d8da72db07fffcee24efa0
> commit: 1231e04f5bba47f87d0b690a2d58c771a59f93aa mlxsw: spectrum_switchde=
v: Add support for VxLAN encapsulation
> date:   9 weeks ago
> config: x86_64-randconfig-s2-12211040 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout 1231e04f5bba47f87d0b690a2d58c771a59f93aa
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.o: In function =
`mlxsw_sp_switchdev_bridge_vxlan_fdb_event':
> >> drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2547: undefin=
ed reference to `vxlan_fdb_find_uc'

Problem is CONFIG_VXLAN=3Dm and CONFIG_MLXSW_SPECTRUM=3Dy

I'll send a fix.

Thanks!
