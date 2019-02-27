Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC108C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76FE213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="v26y3mWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfB0USm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:18:42 -0500
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:37580
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727240AbfB0USl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV7+2Us5MX0jWcHBUmnmyOktFkmTrCCo80oKhp9NNxU=;
 b=v26y3mWmNFUlQM7cQD4LfRUiHlgjDN5On3xrZ5/WqEU6rqxf+VqDJNQRdpAq1lW/sFxGnNfbCxs2lbuqEyfD6yNeaMeHuwxDuBPNm3KLylT02vSLqeViqst3Q7QKuaMW7jk0wad5329sFhAjaImPLheWHp9QfcFDkUvgY24XDgk=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6264.eurprd05.prod.outlook.com (20.177.33.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 20:18:37 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::458c:8deb:ca54:1327]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::458c:8deb:ca54:1327%2]) with mapi id 15.20.1665.015; Wed, 27 Feb 2019
 20:18:37 +0000
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
Subject: Re: [PATCH net-next v3 0/8] net: Remove switchdev_ops
Thread-Topic: [PATCH net-next v3 0/8] net: Remove switchdev_ops
Thread-Index: AQHUztT/yQEhWdhXyUuwVlyvWBFVnaX0FZAA
Date:   Wed, 27 Feb 2019 20:18:37 +0000
Message-ID: <20190227201834.GC7022@splinter>
References: <20190227194432.725-1-f.fainelli@gmail.com>
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0078.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::19) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.249.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e3f77f-672c-4afc-86a8-08d69cf0c187
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6264;
x-ms-traffictypediagnostic: AM6PR05MB6264:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB6264;23:C0VGycCmwyUWCp5ux9dph++d9w3pM1SwP1c1ikPMz?=
 =?us-ascii?Q?0A53zGkEFh7cGH7WzXl8ZEWIX/Io1AS6duafq+YK7HDSgW7m9lQGgGXi2YZO?=
 =?us-ascii?Q?tYhZrkhSbj5rxwu8N0ea+PCr8SO9Nl/pBQCHBolL0UXpyWK+PZTFTnpMvSxU?=
 =?us-ascii?Q?MAir88NjjLvkoVg/z7o3v4NUv/e37cR7OHudR3KFpCZxz93Fp55aTRBcdMTr?=
 =?us-ascii?Q?vB4uQexcCVxPHhqzjVHcO9pGpA0hxnZ4tOgFiw01sp9VTHLG1k2zGXz8BTxs?=
 =?us-ascii?Q?207gc4juCBJZZbiWQCHEzDeltA0dCyJZoZd7/CHOBuFvsUE5g/WUD13Ihpq2?=
 =?us-ascii?Q?U0u81AlPHTqkczrfEmwaJin7LA6tonXBVxM3WdOiovhRXZ65FbpoTFw0a3xA?=
 =?us-ascii?Q?13efvkAJhInLvE8ttl5ugNxYMFKcVDoQFkSIa6xfdx+rhApWfSduT6gJ5EsR?=
 =?us-ascii?Q?iTLIiGUwoxmtg2wQLViu4H1mlM5rzoDDnAYyiOmH0MmpQTBhxKgJPHmA38VP?=
 =?us-ascii?Q?syGE5S3B8kNuyiiq+8GHgonsEGNIXawqdYWyDoy/N4OZQYvpruh2v63493JH?=
 =?us-ascii?Q?vC9iyoUGxWGZA/pv1rcttU/7TdV7SvQnZs5dv2rObiNrwO0jhT/Zjhq/lcdt?=
 =?us-ascii?Q?3c5K+CqXK3h7/Fsc4kCTuQHDc2l9VyjCFrNwT58MmvPwhEU1Y/ElQt3stmnj?=
 =?us-ascii?Q?WeyQkr2dBbfuxBEoAGQTZcf7zulACbQu0D7dYGyfR65vE/ZTQr/kab3/tMIi?=
 =?us-ascii?Q?BFQamvF9g71WxJYADYhOAmom1tPIgLpkSWDI1p6qsKzb0NNbCGJ8z8U7eOeN?=
 =?us-ascii?Q?op7VI2viRwneaIZuEpu6SCUvVG7TfOpCg3uzymo/J37/tAs0H6fjEJjHTFEl?=
 =?us-ascii?Q?+54tMaoLrXOZHGjKba8PYMf/X9S5cUKLhGdLxFujTF0tc++BcYojMwZf03UJ?=
 =?us-ascii?Q?dkBugZIcSh0pw8U0KDO2Jvf2PKGL4F42tjChNV2+jeGTGuaUDLzveWyov+Hz?=
 =?us-ascii?Q?/bX9flA6W4CTmNk+S732zDuDWft3HK87T6Qw+FUO+y+1JrFfswIiWpuMLPjk?=
 =?us-ascii?Q?HRrUbQqdmuRhCjVCQ3qk+cV5EQnuGexcgwYCQhvm3PVyQ5bxTAAD0l/keaPb?=
 =?us-ascii?Q?pT0WQN0P33sb+a1J+m0VINNscify9XD9lQPvFZkAt47BVUXyRad/ek4+LEzV?=
 =?us-ascii?Q?Wt3JKtNNAFTM44KqoFcHTpz/pOGL02rwG2KnQPeBKlzDsP3dTRyjLmMOSgyK?=
 =?us-ascii?Q?RBXDx3UVSTZ5UROQ7Q04KpMQ7ITYT9JNo7QLwsunfKEqTQwtAVBRBQ/Lws90?=
 =?us-ascii?Q?rOcAcA0pmHLy0q6tdnXbok=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB6264F4471019BBC1525E200FBF740@AM6PR05MB6264.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(53754006)(256004)(6506007)(8676002)(99286004)(52116002)(81166006)(2906002)(3846002)(33656002)(81156014)(76176011)(102836004)(386003)(4326008)(229853002)(305945005)(106356001)(105586002)(25786009)(186003)(33716001)(11346002)(6486002)(86362001)(446003)(6116002)(14454004)(54906003)(7736002)(486006)(71200400001)(71190400001)(66066001)(97736004)(53936002)(4744005)(5660300002)(68736007)(476003)(478600001)(6916009)(316002)(6512007)(1076003)(9686003)(8936002)(6436002)(6246003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6264;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IVYx2RNKjwzuHFq1tOr1T9wlU7R69t/UKlI/w4wa2KdJ6cTZshhYbn8/9MdCgQQy71poONUtriI11EKZdbTivxwrTzIFSTg1M1xfpvMjFgJbwmFxhLN0d8ti4AK3IAijkKJbZGdrLdmYC+75MduzF0wija1Upf6mam8QE1t6iBpAW03v8VOnVnW/BXu8A4dqGNlEN2CjqeypXaxNueWFJyUEWIr4QJbNHy8SO+jZZ6Z919J9X49045U/KO5PBe7m7Ujb27PJw1XzT0itLtKDzC32+oYFNRR7ChYQG5Zm5PQTh8t0czWGsjEexSkdc4oac4yc3WE2PWUQPUujJxqGtkh/0pagUtDBJiOsaD3si5Vwze3bKtlPm5NdJD4eiXaZSIllQ03HhqI9yuSMxvJ6I+IroSFEeAiYlmVJ+hCp1wY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79D9B29DFDC8E74EB688890A300AC9A3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e3f77f-672c-4afc-86a8-08d69cf0c187
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 20:18:37.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:44:24AM -0800, Florian Fainelli wrote:
> Hi all,
>=20
> This patch series completes the removal of the switchdev_ops by
> converting switchdev_port_attr_set() to use either the blocking
> (process) or non-blocking (atomic) notifier since we typically need to
> deal with both depending on where in the bridge code we get called from.
>=20
> This was tested with the forwarding selftests and DSA hardware.

I ran some basic tests and nothing exploded :) Thanks, Florian!
