Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F4A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="N4vXk5n7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfBLMSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:18:05 -0500
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:56832
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfBLMSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktt0uq+qJWs3fnLXZAd4ICa5yDhWQBM56n6poc80XTM=;
 b=N4vXk5n7bZPWMndHxtTWAy16WLzIv5Z2dVFDjXDomSPWSI+s69qohsb2Lpbxazw0OmOnwpEAmL0VEPcYccKee8KQvZYeCI4KlHRum4enwEMihX59A3BnMMDEQvuS7dC2a69cjFYImEScUJbnDAT9/AU9Xa0qyOSA7PVtzXc/xhs=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5080.eurprd05.prod.outlook.com (20.177.36.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 12 Feb 2019 12:18:00 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:18:00 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
Subject: Re: [PATCH net-next 1/3] mlxsw: spectrum_switchdev: Remove getting
 PORT_BRIDGE_FLAGS
Thread-Topic: [PATCH net-next 1/3] mlxsw: spectrum_switchdev: Remove getting
 PORT_BRIDGE_FLAGS
Thread-Index: AQHUwk9U8MSlZzLd30ixNq6Bjp0oiKXcFVwA
Date:   Tue, 12 Feb 2019 12:18:00 +0000
Message-ID: <20190212121758.GA12774@splinter>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
 <20190211211749.19847-2-f.fainelli@gmail.com>
In-Reply-To: <20190211211749.19847-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:209:1::20) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5080;6:/wIri3Ob1vAZQKMghFEb8chDuHTUYX0+EPFlLJmfTRGyJQ3B1v7as0WRvod6GGLFYNkjRU9qP5m8oczjSRgc6LQ6+PIjF8MDY54mB8UhHB7gSRDoV/Cs4LSTlU+PzMCwoo+GyymKsZ8GhfGl849L3/G9jhsShRBPjjn4WT4jJOTP/JvzvzB+aJm8yhFlYvlnhGkVr6HX7V1IX3zZWzWo6uRbzavDDv/4CNv2f6eGyqIIV795s0/QgGnmIqBuW/79zBKmhJJIQhvuBmhRUCXEHLS2hsCD8k+B06z/pdtHsK63W6SAfEFDyGQvZodgx2BSdMLyP7K6WrPddM8kTq5GCwky5QeKECEUeSVU/S4sHDY9oKflu/++v3YZZu6+cmoKk5c5SXqZoMghu5WaNl8TOZ8WHblcDM6F1wBcMNFhPVecOY6nVw1IUtNB5eIS162HtmyX3tMUMW+ISg1cqtORHg==;5:V0P1dsT394qQHxjrFr3GC6NrkHb1iqInslqzTmpyVLJ9S5KExmKk824iPmUaqR2rGwoWpLqRuXXAVWbZshU4BBRMNg5zU4KyHJ+ja6dYXMjjeKh6Sx5QP5slipv0V+i0wku5nHrnNGE0NOG6IxMMaIfc3ExUmJPo4Q8h/FsE0awb/reyYjt4Sf+Ny0BjOqnJo525s5lFj+7dt0ct5jN9Wg==;7:3d0I42dstQw4xNuoLwhSAjgwm0rT8wtC9I458W+kDF8xjdQ5BItaez9NpNaDCR2Rl/tUXdv5twAx5gqXc5GOTBGjbhJ0mp9d7e00Le5uEL95rg3KSXpynDiVQGMf+Z+VIiSqlXdgZS7akdRPD/Z9Lw==
x-ms-office365-filtering-correlation-id: 80fdf12d-c2b7-4b50-9624-08d690e42131
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5080;
x-ms-traffictypediagnostic: AM6PR05MB5080:
x-microsoft-antispam-prvs: <AM6PR05MB5080C6A4CC5EB371BCB735A2BF650@AM6PR05MB5080.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(6506007)(99286004)(66066001)(386003)(33716001)(86362001)(186003)(102836004)(26005)(6116002)(3846002)(76176011)(6246003)(256004)(33896004)(52116002)(7736002)(558084003)(53936002)(33656002)(54906003)(8936002)(25786009)(316002)(305945005)(8676002)(4326008)(68736007)(478600001)(81166006)(2906002)(1076003)(71190400001)(11346002)(14454004)(486006)(71200400001)(446003)(6486002)(476003)(6916009)(229853002)(6436002)(106356001)(6512007)(97736004)(9686003)(105586002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5080;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aT+OeRuS4ng1NkiuWkD9Z6l09lDGVTgtY6y3zw+4TLlSJ2nTV9xGkohGVV+Op2Hsm52Ye5bR0x/oJ41Jt+BVcUDUJf8lGMavr+Otbu7PBqO4bOrhor4GBQ82yzu83jNNQAu2zBL2SMbtr0WjcY+zDCZvuMlE3ymGgFbtFFXLjxels3QSvk//Iz/k7kzdoIammFiL4qejd07hEWQj4jiErbNFcHEcthInCeQDBh6TUn/GslKp44tKaZ70S4dQspH+Y1WFBJWP4eY/4eI3/hUsBHWveIui7LqfpRy8VA5KQj58WfOqTf36D1BVAlBFcuBhkZYlNwmoJ1M+QBI3HRm8bZRCJ2/13rP2Zdr2PuQ6+hdHXDH7p2hQOox6ix8ujHn5yaSaRzzFHSdnhU8BTkzED1GsJW5TfZ7uaE9qrt+Gg/s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C44DEB3C518E4049AE6A045E639E28F5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fdf12d-c2b7-4b50-9624-08d690e42131
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:18:00.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:17:47PM -0800, Florian Fainelli wrote:
> There is no code that will query the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
> attribute remove support for that.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
