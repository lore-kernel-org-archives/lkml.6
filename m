Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E33C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D132120874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ikV8k/qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeLQKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:03:22 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:43568
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbeLQKDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYzqpICJz3ahsHGGgeFF17cbJE1DKntRp+0H80TpJMo=;
 b=ikV8k/quT1kynxkLFoRCixCztO6+oVlbRfLiH5f6yosHBpRb1b6gVMSGHHG02UuawJxaMA9vkChKDC3zwiR3FG+myy1gIy380q/cPvRFZqUYCIaj8ninIkiqiu2Cs0z7/ltSsQmw71+1BRMNL9NgslUHuufXGnjUcy6O6mL/Vzs=
Received: from VI1PR05MB5630.eurprd05.prod.outlook.com (20.178.120.87) by
 VI1PR05MB3229.eurprd05.prod.outlook.com (10.170.238.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Mon, 17 Dec 2018 10:03:16 +0000
Received: from VI1PR05MB5630.eurprd05.prod.outlook.com
 ([fe80::70a6:66a5:1421:bbcf]) by VI1PR05MB5630.eurprd05.prod.outlook.com
 ([fe80::70a6:66a5:1421:bbcf%4]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 10:03:16 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Thread-Topic: linux-next: manual merge of the net-next tree with the net tree
Thread-Index: AQHUlZ/QY3DlGWmBn029rBKBaFDWlKWCtDMA
Date:   Mon, 17 Dec 2018 10:03:16 +0000
Message-ID: <20181217100314.GA12765@splinter>
References: <20181217113106.32d98f30@canb.auug.org.au>
In-Reply-To: <20181217113106.32d98f30@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0002.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::15) To VI1PR05MB5630.eurprd05.prod.outlook.com
 (2603:10a6:803:c9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR05MB3229;6:ASKP7x3Cuys8WYKZTuuEcBDqWyYUKOCSQKvBgk4+LmwK0FY6+xN9IBWOZyUpi8EdhAfcFHILHSrz0mJqBIpX732eQuZePkonTDRlIoexlbCqbcNRxb7WvjtL3HAsViFkRGOM8W2hVDZdimayrjWSH2IiG5HkXRU69+vj3NVjGbDLXwk0wH3gYAyugqGVWapqcnNk4nc8VKrL68Mjp4duV6eb0K3cOH4W5Oj8czlTvgsvHPz8Y5GQZ8KkRaxRPLsUqLLP0ejx2/IQ0NiRhJed/ADjisT+y70uAXZrFIoM0CxoT2x/eot+kAvLk6d+vaXjlxmvjZeif6hkoBTz73A5p7eiZjtvPcexVP/d+a3Ogp4nlVUztMa/NpFN0Q7awQozVSL29HjBCRuiDwRftSHL68hhmIyBjuh9/K+DxBTvEGw0MLGjS1/Esh8xEuiInIb6A63tBFVsgn919aOqgZcrWw==;5:3tVVneLLz5PvhuHbURViJbpqpJI6CzOLCe1vNhOD3YpsgUeOUS304qnvtCShB9n2A3hlfeLuvn3SU2dO2te/1EI54vgp6ofCsq7F7+JYNWSeuGFBPIIQ1FLZTfZXT4Trq94QuYw7WyW+9oiWmjXKDq+jvTfCiDF/yDULZCYTXIU=;7:puntS02gjcRcJGsi+CwE/GojYJhgXuPWIx4Gey7zz+5/nezSYTwcR2TWP2QeyM8NEfmXBkfyh+s7KLa1sORCUFVUt87sy7abfviO6+uQZAniA/d/BHseV5RMRe46qyFQ/zQO5unCKUet7OLjx93pcw==
x-ms-office365-filtering-correlation-id: 2dfcd97c-b88f-4447-70ac-08d66406dcf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3229;
x-ms-traffictypediagnostic: VI1PR05MB3229:
x-microsoft-antispam-prvs: <VI1PR05MB3229F0EAB2D19BC433745640BFBC0@VI1PR05MB3229.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR05MB3229;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3229;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(53754006)(199004)(189003)(186003)(6116002)(4326008)(97736004)(229853002)(26005)(71200400001)(71190400001)(2906002)(33896004)(7736002)(305945005)(6246003)(6506007)(386003)(33716001)(25786009)(76176011)(5660300001)(102836004)(81166006)(6512007)(52116002)(9686003)(6436002)(478600001)(106356001)(6916009)(105586002)(68736007)(6486002)(1076002)(53936002)(14454004)(11346002)(446003)(81156014)(99286004)(66066001)(476003)(8936002)(486006)(33656002)(3846002)(316002)(54906003)(8676002)(256004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3229;H:VI1PR05MB5630.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /y0OoHT7FYqwzhi5uCRd2spKXatLJt2vf6x2CmkSIAQxVCdE3rz+c49T5BnPFYPk+qzprP7gjomIFXvlH3i8ywpWG05YO2Suu4opI0505J2qtBuzO+llEEg6U1SZs8Vn4GDBlF7sziIb7tmKfULSuzG8Qg2aec0IWmMkNpQz9JMv3QZNgh9wRXi0yIwHBmatDVMGCn7SBZ6vpF30h8OdHWRSqYwpEOJg8P9H+/98h3O5u+R1awuFFVJiE63FBB8emhzeggmWKyyHbG1QW2DwkEHUsfM6xfo9+2Vry5dNnnu4dhRnzsRSEPn7Or98adx3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1058BBAFD2F2C408E138972080919AD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfcd97c-b88f-4447-70ac-08d66406dcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 10:03:16.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:31:06AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/ipv6/ip6_output.c
>=20
> between commit:
>=20
>   8203e2d844d3 ("net: clear skb->tstamp in forwarding paths")
>=20
> from the net tree and commit:
>=20
>   f839a6c92504 ("net: Do not route unicast IP packets twice")
>=20
> from the net-next tree.
>=20
> I fixed it up (I was not quite sure of the correct ordering - see below)
> and can carry the fix as necessary. This is now fixed as far as linux-nex=
t
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Looks good to me. Eric?

Thank you!
