Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C31213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jyS5wJAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfB0Mag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:30:36 -0500
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:43279
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfB0Mag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nefKtGd1lTx7FGEQHTFoenGmZJG4TN1iB7Skq9dqYME=;
 b=jyS5wJAof7icuGGSK2AJFfh0g8mRP6Xsf+9/wAK7pZ9Ymh/TgLozxw+RfQhUxCKS1GUWZlp94iwRYZ3lM21o4xKSXOuL4t7eKDPONAqhda7T2af+RACrVCg9Wm8ncH+QrzzcG1VRmNybHdh5PrhTor8o++crVAzr6CP+A1BhsTE=
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com (20.178.42.15) by
 DB7PR05MB5209.eurprd05.prod.outlook.com (20.178.41.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 12:30:33 +0000
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23]) by DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 12:30:33 +0000
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
Subject: Re: [PATCH net-next v2 4/8] mlxsw: spectrum_switchdev: Handle
 SWITCHDEV_PORT_ATTR_SET
Thread-Topic: [PATCH net-next v2 4/8] mlxsw: spectrum_switchdev: Handle
 SWITCHDEV_PORT_ATTR_SET
Thread-Index: AQHUzjnbO0YMgzhWQEekNZmAXVL0hqXzk/8A
Date:   Wed, 27 Feb 2019 12:30:32 +0000
Message-ID: <20190227123030.GC13567@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
 <20190227011427.16487-5-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-5-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::36) To DB7PR05MB5243.eurprd05.prod.outlook.com
 (2603:10a6:10:68::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca8e719f-6a8a-4c96-7602-08d69caf5dd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB5209;
x-ms-traffictypediagnostic: DB7PR05MB5209:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB7PR05MB5209;23:m5nTAhzeemSJN2ye4hAJxTrU9wjy4kQhXqB2ygNqp?=
 =?us-ascii?Q?g/ioqkBG2jOXjcOcNA37brbL0oMLn14zTFB8ZVE0szYRGBzbC4pKuYAJlwSR?=
 =?us-ascii?Q?TDorDjWL09rQ3oljDbNgAaNg5vQSXSFRl3uKCLUTAe6Czfxo92IS7F6PLFxI?=
 =?us-ascii?Q?8u57sgRg2P2X1dMdCm9tdDPaU/OVu1zn8MU+Ai15LqqCjIzIVJuOcNzSIqPX?=
 =?us-ascii?Q?OpvD1yhb0EXc0nxb4+5EaTw1TJdbtlXssRv57OIA88j7HEc0nYD7CVdCPuAC?=
 =?us-ascii?Q?a5EbQxHBLHgVXCSDlL6JN0GHTc7yOa9wxGc+M7J5yq54BBv5MBEeZk+iNaYi?=
 =?us-ascii?Q?CinJg+CV6fozPYWaDwEcj46oTsYIgAxlBSlNbYPdNffs8LJdPrvsXRzBaIsz?=
 =?us-ascii?Q?mRmEKPWjJ2qhNnN8mSE9dp57QWWqf64id5yxWCJPqbvSor5i0w+OkyPacHcW?=
 =?us-ascii?Q?SQ381Om9ANEjDjqgJ78Y/uGn4NdTjkMf3cTdY8c5sKLVD2QMYjpCgj2q2Xr6?=
 =?us-ascii?Q?OlEj5bhbbF4ppVY9L/5G2TrmIP7hU+z7f94Ao2dMX6M5rsqVflPN9fneF2IF?=
 =?us-ascii?Q?kDfCYM0xANjE+tx1sw05WAnoFkrnA/9BoJ3HHdGYnur52/YbjtdvPhaDXrFJ?=
 =?us-ascii?Q?QvR+huvIqFe3mKkTqoyd1B0EpapyrejKIy0gBZVhW9KCdN+/V7fmzq+YfODM?=
 =?us-ascii?Q?JOQoO5puRuR7ENAoubcK3I6ZTJBMOsOaoVGhAgbi7rHTl75jPkXkDHto6XNg?=
 =?us-ascii?Q?s1EdiWKfEIn5llf4G2k1T9y3aJLCks2oTFLUTdMuC+rWzMfj706Bhl2EjYaL?=
 =?us-ascii?Q?WgkGOti1pPv5Yrr9yET7hcCNIXKe8NRHx5xZT9QTVAAvaJ98o3HjI+tJnfLd?=
 =?us-ascii?Q?/0LoPY+qPZj04+VYLZd7uReRcVdZSFfAOJJEKD6XFySVcr9BpZLTRZeDNovl?=
 =?us-ascii?Q?kpGCZ2VTuMwXeQ+2hM0S9WcX1Y0lGNxoVrR65qRL2qQbU9xebnRtvVqpSZ9Y?=
 =?us-ascii?Q?54GA3jtZn5Owf1PKkja5LEnfkY7kWQFSXZnfE4yYUUUxhoywg7yB14y5u9un?=
 =?us-ascii?Q?ADiH70sJukThX12lzsPi5bCgNgvWW9Od+AEn45eDUcnggjX2DJebYulCKic7?=
 =?us-ascii?Q?EGuDDJx8H6s9kVsknG9Nc+qIPonLAsTcCpXX8Vm5gWtbaFHQNg5TBRblDEYu?=
 =?us-ascii?Q?6S/HqFHhckp1tkh9zXQ9Dgj6PD0f/2r0Z51E1o1v+GOfjH711lqrXaYNT9fW?=
 =?us-ascii?Q?RK3J1s46JKlEvGLtdZBrH6o+FdOZ40nCDPzK9gkQTmttYh+fKmHQ39cGAo5D?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <DB7PR05MB5209594FBA1A631E20AEBA28BF740@DB7PR05MB5209.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(3846002)(6246003)(256004)(2906002)(478600001)(4326008)(99286004)(71200400001)(71190400001)(68736007)(4744005)(6116002)(33716001)(6436002)(76176011)(52116002)(102836004)(316002)(7736002)(54906003)(25786009)(33656002)(1076003)(14454004)(186003)(9686003)(6506007)(66066001)(386003)(305945005)(6512007)(8936002)(86362001)(81156014)(81166006)(6486002)(486006)(106356001)(6916009)(105586002)(446003)(53936002)(11346002)(476003)(97736004)(8676002)(229853002)(26005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5209;H:DB7PR05MB5243.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: re6j49QcpAjTi7C2dTtqVjcnSiGJM4EnBKrkEf3pcVTE1fEqcwDVGBJsW+mbgAIvoU+Yx94gHp5B0VQPQ5MrygOCGTBBb4afOf89xWKACFpTEysPhDrqc53+m0Q3yUPiG0LBUcVl5yF27XxvloC0my0q4YcT0j5BN0YeNXQnQONurgS5FHTDHWpE/4J+BwR0ZAN4+8gAORwHlo5JWig/Vj2PqAMuF7jfpLWONvMbWKe0Q6fFsjyXcB2QVkVhxUx1N6bAyyYxJJ69NmZdSkWnFMDtBqaZ80UZIGdTcD16SkrmgWM/cPLssXrQS1xcAOwBHvWs3CXTu/R/SCsrgAeiEzF6KHo22JRw2L/z6nsvX5zxF9SIQm1iKkRUWiW5MUB+VjZlR2333vNlj5ta+CG5oEFs8BaE0qheEcgB0RSSfBU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C72971248486524A8025347723E5D21F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8e719f-6a8a-4c96-7602-08d69caf5dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 12:30:32.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:14:23PM -0800, Florian Fainelli wrote:
> Following patches will change the way we communicate setting a port's
> attribute and use a notifier to perform those tasks.
>=20
> Prepare mlxsw to support receiving notifier events targeting
> SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
> to handle stacking of devices.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
