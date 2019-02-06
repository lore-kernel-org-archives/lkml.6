Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C04BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E9420844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="cYoZ7GuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfBFTLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:11:01 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:46464
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfBFTLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WUrlRyTPx9ms/obiKo4Y3M+wr2OosRYgHONM+0vVlA=;
 b=cYoZ7GuN8Xg2/H+O0pJU+9G8QvSe9DKDHK4CZ8qatjZ6zC5Eggk8BdY7Hfs/r05Z688CZStiNjlKYQbMf+XMsf5ihRZy/1tVeR+05UO1KhSuwSa7UBDQY9IMiJ58ZKEzD9TkjiFpSJeZF+Hu61LQ1otJzP1HVivqImkzHsS8sO8=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5016.eurprd05.prod.outlook.com (20.177.36.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 19:10:56 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 19:10:56 +0000
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
Subject: Re: [PATCH net-next v4 01/12] net: Introduce ndo_get_port_parent_id()
Thread-Topic: [PATCH net-next v4 01/12] net: Introduce
 ndo_get_port_parent_id()
Thread-Index: AQHUvkPXEtsdn4gDAUWZIN6ALGcZ+KXTItUA
Date:   Wed, 6 Feb 2019 19:10:56 +0000
Message-ID: <20190206191054.GC14340@splinter>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
 <20190206174546.23597-2-f.fainelli@gmail.com>
In-Reply-To: <20190206174546.23597-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0012.eurprd04.prod.outlook.com
 (2603:10a6:203:90::22) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.229.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5016;6:/hnBOOZcxK1yM5L3UgWuFjY/qZFXwmqLWADkapzjG44A0UI4wHUA2UonMg1qFgLfcyZgUG2OdYjiZPSZHCPND+M1OX3RllVeme7nXpHLmvVyj3J+4NcT3lCnlj3q6RJr4QGqaWRmq2bnalCUIShxx/JQDfTkM+r4+W45WEIBjF7JBtBXALDHNLt9ZiC2Lhd2lrpMpM/pceuthnbIsJ1KV9XwBov7pghmb1kO/1Mji7HBiPsVpiwMj8LCwIXed8/z7DYDmCX1jzOfyt4X+k0rY6FEjiCsA45IreCXxaSdzNXpJPiWrcqqYaC7pEwvjyAI9ws7ejXG8ntQHimExmA+ZT6adANS2XRFMxjfuf+K31zPH+ZAVCcDbfS2NlkKimwyqqy8GCZwdoSPOlTDTPqZHfWxJAGG4401+xryWQfpflmSo2V9/ZfRwBHnOvoNLjaFZiv2jlXt3RjBsyn8iAEEvQ==;5:7R+VjXWOl7pylLrGj4DiLJ1k3/Hofx/7m/OK+OWpa0futY0nsGaLNSrjSOzZqrPX4e0UdPyynkUT/VIKhfM22LuaqpXrPVjsTEySKKuEu9F2W/bNANC/cVT5Veg3AT2sy6spEB9BzOiE0VY2k5fnARObNGxVQqqqZTNewV1DKtxrfhsIJiGeJph0sC0ox82ntro3Ik21JO706EdnKNV7QQ==;7:c1VtRztTEUseEbOYh5xd4daJC6Z3Vkr9EfVzTwDNTxp5bi2Ks2wSiWIN9xwX+pIAzyKVFsFQz9krkRPBUpxInUZArwOC2Rg4VQODiWx8GgBB91M9sYPdUNmgZjhN/DTZiOw4MbGal+sTy+Yf4EwLSQ==
x-ms-office365-filtering-correlation-id: 3ca506ab-1ff6-4ad3-7ba5-08d68c66d26e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5016;
x-ms-traffictypediagnostic: AM6PR05MB5016:
x-microsoft-antispam-prvs: <AM6PR05MB50168B3AC627CFD4278BA452BF6F0@AM6PR05MB5016.eurprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(305945005)(256004)(54906003)(26005)(71190400001)(71200400001)(33716001)(316002)(6246003)(102836004)(229853002)(6116002)(3846002)(2906002)(186003)(6486002)(99286004)(97736004)(76176011)(25786009)(11346002)(14454004)(8936002)(33896004)(68736007)(386003)(446003)(4326008)(6916009)(1076003)(476003)(8676002)(6436002)(478600001)(7736002)(66066001)(6512007)(9686003)(486006)(86362001)(105586002)(81166006)(106356001)(33656002)(81156014)(52116002)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5016;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ncgsErdinSL5bm2UpYhDIY+9HzRs4oZKBHL7ndQNE+QButh7HBi6/u1uUcnUewqDeFowfsgeDVe5WPvnyj/SHG6f7/KUv7p7X9aMtW0klCW5XLgwZHmRQGCcCgWwGoUhZfMNJYqqMD/Yo46sKrDEzqyJCRFp0cNL02E2hQ8kYi2Jz/gYRZ6hdUkBj7F39B9/VBfxuDSp5L1GxvnOP+vpg6bFHhPSTAptIjD7I8ANDu+XtC0WLm8ewtfY8F5m982uPmQuS+kA00IV0YVbwHC6VZHILCJJd1NTtS//p4v92kvi15/7b3KwM/Aal0/BwVm3IgWB5s1dLoH9Kq0ilaSDplgFLDWhSw/O8TMiQGSrPzJPl7oT6vSfIrVEeBaj2U0bG3d5CeAM/YFGjXArR0u+FLyvgxTTo3xSJUUeXtB0n5k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9E0D70EE9EB1A47BA821502865FCAE1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca506ab-1ff6-4ad3-7ba5-08d68c66d26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 19:10:56.2221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:45:35AM -0800, Florian Fainelli wrote:
> In preparation for getting rid of switchdev_ops, create a dedicated NDO
> operation for getting the port's parent identifier. There are
> essentially two classes of drivers that need to implement getting the
> port's parent ID which are VF/PF drivers with a built-in switch, and
> pure switchdev drivers such as mlxsw, ocelot, dsa etc.
>=20
> We introduce a helper function: dev_get_port_parent_id() which supports
> recursion into the lower devices to obtain the first port's parent ID.
>=20
> Convert the bridge, core and ipv4 multicast routing code to check for
> such ndo_get_port_parent_id() and call the helper function when valid
> before falling back to switchdev_port_attr_get(). This will allow us to
> convert all relevant drivers in one go instead of having to implement
> both switchdev_port_attr_get() and ndo_get_port_parent_id() operations,
> then get rid of switchdev_port_attr_get().
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
