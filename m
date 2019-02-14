Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D87FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05162147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VDQtMDW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392479AbfBNL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:27:57 -0500
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:3180
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732023AbfBNL14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/CO/KIkZaTcRskSjIOhhlz6gceoT1YOiG0Bz84pdIQ=;
 b=VDQtMDW7pLVicW/Yv8rCOSbu/if5U1Q35VQ1KLZi8l1jEN8tePEG9ZZqPpRVdXlvTD5yOeNv+vRQddTZyPb9xxnHyEnVQGwJ0bTJPWPiIaOJT/5sF0uNejM8UayHTvb9O9Cnxa0aQ2qkYqIWAWi5O6pZES7KgwXMwlmpjn2XQ3g=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4231.eurprd05.prod.outlook.com (52.135.161.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 11:27:51 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:27:51 +0000
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
Subject: Re: [PATCH net-next 8/9] net: Remove
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Thread-Topic: [PATCH net-next 8/9] net: Remove
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Thread-Index: AQHUw+iOxU++dzWJmU2RjnNqH5flMqXfKNCA
Date:   Thu, 14 Feb 2019 11:27:51 +0000
Message-ID: <20190214112749.GA9620@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
 <20190213220638.1552-9-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-9-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::24) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a65dcd20-0de8-4c1c-98f2-08d6926f7485
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4231;
x-ms-traffictypediagnostic: AM6PR05MB4231:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4231;23:yRS1KatdIPGt2s6BSa4nax7Jk0q/HgwDmrByKehXy?=
 =?us-ascii?Q?bnWuJza8Bl/7OzO9NrgTGL7/gMJxSFyZbwGjUyN4I7x3e+/LxxH/d1n6cv8X?=
 =?us-ascii?Q?H5qyLIwKGXDqc7sduGv6cWdw90RL+WSUcDONZwuJUNpgV7PHNYnPx5uogzgt?=
 =?us-ascii?Q?bd/Epyvy2eBajQySBaUuBue2xwAuYdV/2DUNtWaali1bdYiV5SpXDYONnjgr?=
 =?us-ascii?Q?9b/ZV7NI2oLn+AZJibXebPInFG2WyUkEsbLUL4UQOVwGcca49ls1gPeTIkmS?=
 =?us-ascii?Q?9xm+8TI2gBkDVDqcQcftbjD2udA59aXWA7A8i1llvw9kmSm0dWNYf19tSH0y?=
 =?us-ascii?Q?/Kw0ml8nn39idMnTZiqkfcDZlwJSrhWizIhIeXJ3LSqTTrdhDtz1csWcj41u?=
 =?us-ascii?Q?H0oBjCPvi8pFIxlMUdC/uhNYamMIkYgHiMM26/gFCc3/iFweuVU2jPaCuDtR?=
 =?us-ascii?Q?338vV7JKoQJHRcxkUM8RlGJBUV4VKKRrDe6HC1B7yiSPhNxcZZzZaiU4u+nF?=
 =?us-ascii?Q?MAoR8z/xw4Ic9SyIEgvyYDERsIrvJKV9kJhSGsTIsMbESOGkiSVMsmGHmxEF?=
 =?us-ascii?Q?UhzkbGlR5TdxNL8+v8FpH5XssxueANKpokg4E+4pHOtMDFHU9RK6blfrVzXO?=
 =?us-ascii?Q?DGn7VuIYGnsfQ5vYcqTTzdMbWdtXn0vGwEDw6VHLfblHi64c7IYN0XsfytWX?=
 =?us-ascii?Q?IHF7t6iLRsak2wXkIIzhkV2h8Zaq8ppBxcCGeI4t+i1jjiaXjSC2tqn5sppf?=
 =?us-ascii?Q?tTd/rA5cb0zliZScNY+QYkJ4eI14R3CbMIclKHDERrEZWZO3AbYEGt63/+KJ?=
 =?us-ascii?Q?lbzO46SkRDrvvKoeKoWCvDxtLLmrAuKyE0IhBEITYa39xADR3mp5rluCidkq?=
 =?us-ascii?Q?iy815zWJm2bvMbkXgqb1MEk/lX19VRJvZ3SXjftoLeDddagBCOfcJeVa42Tw?=
 =?us-ascii?Q?jy5u6lfh4C0bIDGhy4AEcHrBgD25e67y617UgaeqTgEu7R6fl4H6ilhYfHXc?=
 =?us-ascii?Q?5Vl0gOdpzzAry24707wJRoqa5RYI2ynQlEhASB3DkerAJ+L22dvKN7dDfZOj?=
 =?us-ascii?Q?oK4cR006QhvKC1+NiuFOC0eR6zm6fEHvi+if65SJCg0/iV7rBGuMMtLcT2Zo?=
 =?us-ascii?Q?bIpxbUQRwQTwi5ZU1SYPS1McmzQoBSJ7sTEWucOw0KXJsAHPrAHzevjovxdi?=
 =?us-ascii?Q?DoHkNxpB7xnRqBwSTvCZ8Ambxye1SE58QU6F7xDKz8imxdfEe3EjMpbHomV7?=
 =?us-ascii?Q?Zo856k0lqjGwdmOsfTs4LyYILazDqUIx2Ui44ji?=
x-microsoft-antispam-prvs: <AM6PR05MB4231EE6AC42A40F7688DC9A1BF670@AM6PR05MB4231.eurprd05.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(53936002)(102836004)(386003)(6916009)(25786009)(8676002)(81156014)(4744005)(3846002)(6116002)(476003)(8936002)(486006)(52116002)(6436002)(1076003)(4326008)(6486002)(2906002)(6506007)(81166006)(26005)(9686003)(186003)(6512007)(446003)(11346002)(71200400001)(68736007)(33656002)(54906003)(71190400001)(33896004)(14454004)(256004)(97736004)(316002)(66066001)(86362001)(6246003)(305945005)(229853002)(106356001)(478600001)(33716001)(7736002)(99286004)(105586002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4231;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O1H6/N5PBAuCFQ1s1I4SpesI5sDKhQsv4Qb5K278Tcd3W7Ou7Bcpq+EeeXFqC7Na5oM/OSC4wDc4Dd5TE0pX81Vnto/N7R6CpFu0OvQyAFCSY4f1jULmxm1EFlWD7rpTHs7jc26pj7HMW8GO5CSqr80UdFxNAZUd7AqRN12HecWC0pXzkEHoA+vNAsZS2ZbX2jae7rz7ldsPSQYzkijy7z+8GSblqtXI8LPU80cn+Okg2hnxOwvpPjFdv7wiTbyIy8o2JKLLy8aTaexNy5Fn0/fH42S+LrzQVWQvYkRG6+DOlD7wCuotpI5Yn3d3Zf1LW7eu3PgKdAB0TYXm0u1yUm7hhQi98Kq8DHwKfz7/Gev9ataN5YVDpyc3X5XxN/ZWyLXcarc7Z1V5KrTO+DPbiwJxRBsQp4AbIyEYpjIhjIo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30D75F9BF9B6EB4EA0A9B623D0594868@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65dcd20-0de8-4c1c-98f2-08d6926f7485
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:27:51.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:06:37PM -0800, Florian Fainelli wrote:
> Now that we have converted the bridge code and the drivers to check for
> bridge port(s) flags at the time we try to set them, there is no need
> for a get() -> set() sequence anymore and
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
