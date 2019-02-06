Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8BBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E4F20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="x8KLdCzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfBFOYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:24:13 -0500
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:52014
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfBFOYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPLo4B35+nuAD4lrkkpAvHmzpIKSwvkPv6H2CktBBts=;
 b=x8KLdCzG5EYpq2zieWnDGFpXEpojz0UqtJPJgo73FzxqnPhAIhWU2EuH4aKV9hEm9zQInwepDX9wRLXh/K8WD2jB3CBfnvtlIB13K75GM+d4eVcKSOwlkarqorcj73uDGPd6C07dKhRufVMy3uokKbPHYyDBPKLGTkGJvyWyj7w=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5602.eurprd05.prod.outlook.com (20.177.188.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 14:24:08 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 14:24:08 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 00/12] net: Introduce ndo_get_port_parent_id()
Thread-Topic: [PATCH net-next v3 00/12] net: Introduce
 ndo_get_port_parent_id()
Thread-Index: AQHUva5OxuMdQIeiKEeI1MwbcsUxgqXSZjUAgABtqQA=
Date:   Wed, 6 Feb 2019 14:24:08 +0000
Message-ID: <20190206142406.GA8031@splinter>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190206075136.GA2283@splinter>
In-Reply-To: <20190206075136.GA2283@splinter>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::34) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5602;6:wNgB/pYApaHptTktUrxlvYgGNfPSJwlNocgIFL007M8HQTDSXV1Br23jBRyO1GiT6btx0Gp0+xJ7NBmWZRep+DnfLoHbPej490qImZqwtBb/hNOWd14iU6StjQOXAbSBvZTN/KDknQ/iwWU56i9sJ23HPgK0PbuX/v5Y3iRjC6/w/DfVYDGMdlwr8EUdatosS7RZkLrOXoQgsbsTQUJtbpBOTHfcMYfXJN/joSHbzARDmvoLpBVaKerNOFRDY9cPZmGqCnfq0y71PWdH15lON+lLJiOsnJ+D1cDk/9Ux8BYNIFzsgi54v9ZFXVSZmqhcaz2hsZYAcIfKys8lZtLpGNX88c0f99QKujj5T69oj5hWuRDJYPPA0OlVGw7rIiaZG1RzjZZDjR1/5eXjaZz97+vvyrEjsdBGc1oG2qBHCykO0+Uk407kZx9WxeLzwD6ybkGjnY8c7YbKqZxVbn/Ulw==;5:gds+7JIDy5vgu95WTvZ7oZmmiUuo2oQcu1OYg+bdxXIUFg+DYG/ndx4siaWK/PI1UXvnm/P7TGZnVFKNoRDBTeJQJwIIkiCiCLS+W7X0Y+K5fdEMQH8RRNd6Xm6+K8TX0lXxU9gc7vZpePLlYapKMvHKVjBafek9wW4PAe6vY6DoXD0hAsli5MW+wuHs7ILSfcPcRS4quBgoxxN+90kZvg==;7:XbfVuFOSjpqZwDjOpLTXlFUh7llwjWZnH2jkC801MA1Mu7njkz+ONTstct0JVCqUu1eZQlQFuVT3+FrcD2vWVhAULWVZXlEz5QJgJ8Qb/MJFzXiFAJOLvnRUgTFsnn1V5vH75H/aMtjTy2fWJ35sJA==
x-ms-office365-filtering-correlation-id: dd3744bd-5372-4a89-8a62-08d68c3ec1a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5602;
x-ms-traffictypediagnostic: AM6PR05MB5602:
x-microsoft-antispam-prvs: <AM6PR05MB56027EC47DA4B9DC1488FB5FBF6F0@AM6PR05MB5602.eurprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(376002)(39860400002)(366004)(136003)(53754006)(199004)(189003)(25786009)(14454004)(71200400001)(6436002)(229853002)(6116002)(76176011)(3846002)(6486002)(33896004)(478600001)(2906002)(81156014)(81166006)(8936002)(8676002)(68736007)(99286004)(305945005)(6916009)(54906003)(33656002)(53936002)(7736002)(6246003)(52116002)(4326008)(316002)(106356001)(486006)(476003)(256004)(33716001)(11346002)(446003)(4744005)(97736004)(6506007)(386003)(105586002)(1076003)(6512007)(9686003)(102836004)(66066001)(86362001)(71190400001)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5602;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7sRiVUV+uygEMEjTEbn2/XYEuz81g9jGYt171CEuGYEp2g+B3j3MMnSVeA62be4+xmArjQOG/meEJQZS9l8tV59N26pkKTzt2u1veYLqTJeRdHoeRVqQqJt/V5IWb9CQ1RsrFx45lqa/IcrFqwiAZitrW6CLjDQbvkwFkGQrcZuGndnH0MqREGBASQDAeRQIIaOP8fuuCw7HntXdl6Gmb74AZgFBLtPGv5p2PHCrT9A1XxSLd6aNyPqBm9zCLBLDOfhLlfOlHUxzdx2Uim3PL4lhHyMU3biMDVxXBuXmwlShPJ1OzgBEGZm87igF2HX51R/E9GRNEYR4TPwaewrHubJA7LHNzWHR+g7VzYHDI4k7Jia3fEz/oI+MBC2PvE8i2OVYIMFiAD+D8+eh8vmQzq/A+Uxyo2zswjoGT/PYNcQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <169DE5604288D04D8F08157231B73186@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3744bd-5372-4a89-8a62-08d68c3ec1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 14:24:08.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:51:36AM +0200, Ido Schimmel wrote:
> On Tue, Feb 05, 2019 at 03:53:14PM -0800, Florian Fainelli wrote:
> > Hi all,
> >=20
> > Based on discussion with Ido and feedback from Jakub there are clearly
> > two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
> >=20
> > - PF/VF drivers which typically only implement return the port's parent
> >   ID, yet have to implement switchdev_port_attr_get() just for that
> >=20
> > - Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement mor=
e
> >   attributes which we want to be able to eventually veto in the context
> >   of the caller, thus making them candidates for using a blocking notif=
ier
> >   chain
>=20
> Florian, patches look good to me. I'm going to build a kernel with these
> patches and run some tests. Will report later today.

Ran most of our tests and nothing exploded. Thanks!
