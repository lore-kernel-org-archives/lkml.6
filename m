Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D3EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21401213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="P8xnpHma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfB0URD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:17:03 -0500
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:20888
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfB0URC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWLeYgTHudf+ScxMoFpk/HLtra/5XwgLmJImF8CMfik=;
 b=P8xnpHma8QDUTaIzGAki8HNzwatW9jm/BEwgdWItyTRdsrPzROSm9w2/9H08QIiiSD+dwu7kFiG24LPtVKPK3lXEXxJ3CEtyvrKP6PxL5zmjfbKxc4tXrMAUn/XUYk8GrLY3s6nQcmB51Z3Rd7IyHJe1A8YMDhYG+fHUZYRiswU=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6264.eurprd05.prod.outlook.com (20.177.33.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 20:16:58 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::458c:8deb:ca54:1327]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::458c:8deb:ca54:1327%2]) with mapi id 15.20.1665.015; Wed, 27 Feb 2019
 20:16:58 +0000
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
Subject: Re: [PATCH net-next v3 8/8] net: Remove switchdev_ops
Thread-Topic: [PATCH net-next v3 8/8] net: Remove switchdev_ops
Thread-Index: AQHUztUGG1Ats/Dx9Uq7PbSfj6JMVKX0FRqA
Date:   Wed, 27 Feb 2019 20:16:58 +0000
Message-ID: <20190227201655.GB7022@splinter>
References: <20190227194432.725-1-f.fainelli@gmail.com>
 <20190227194432.725-9-f.fainelli@gmail.com>
In-Reply-To: <20190227194432.725-9-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0087.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::28) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.249.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c480ef8d-ba1d-4a8b-3f3f-08d69cf086b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6264;
x-ms-traffictypediagnostic: AM6PR05MB6264:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB6264;23:82hQ9KLmGREhbpdFJqDfbezLfnZjVaAY4nbmJXxRM?=
 =?us-ascii?Q?Ntte7OX3zSUVHS4WXHYll+0J6NRh+RdLkT1IR/9Jse21KiNvQIcJgFGdMFr2?=
 =?us-ascii?Q?cHgCsnNXqD6Hq0mVSzcLRSZLJmtUsECpabOzlK3LbBLdQpBMIrfs7EcCGXk0?=
 =?us-ascii?Q?SHrRooMfWY8CpkkB06Fm4Qhua7BUn4U0u6PwdHMfq1Rna9yfFSQNN6mOx9o3?=
 =?us-ascii?Q?VGJ9lr3/+5hHxCrfRE5kI5y6oAMT1x1ibo6/+JP04toTKePk52Q0bsj1L6t5?=
 =?us-ascii?Q?81FFtrUhKY/wm2MXAA60KqTxc+plWMi3Bp6vQkxiy7AYlDCP9kGgl9FD7cii?=
 =?us-ascii?Q?T6b1iWhJJEECbnRLZpLXT2LO0sRyd/9g4PQ+YrzEg5EDYhkTlEkGzEhQzd8u?=
 =?us-ascii?Q?bgD4hmVLdur2+sFnSOL14nZqYZSxMvznAoxxJqi2QWFSaslWliQFKlPlbbYM?=
 =?us-ascii?Q?FZ4Te4JVHDTKGK7NzziZyagOP1lUXtoRYYE45BXR/Mm+lg7RtjxbrcRXOpaU?=
 =?us-ascii?Q?2+pcs88m/ErXZxRnj98cMfUoOk/aIDF1tMd0llOcSONbCADEbE7nVlz7hJdN?=
 =?us-ascii?Q?KUwBWvyybJqwfNzyZZqUiIuDwcAN1TEmfkkuH2M3Hw/HVO5+RW06zbGKg0Nj?=
 =?us-ascii?Q?3ks2U1QjnqDTDY9U0XxafyaIJmdv95mk6CA+7BEvMYl5w1LvjuO3vLCrNtcf?=
 =?us-ascii?Q?Mw/fTU4xKXkBoB7BlNFm27Xf5LlfwYfMftnZ8KXBwsZqnz7UXK6woULuToHv?=
 =?us-ascii?Q?xunykmevWHlhjc9O41yIZeRHUymR6i+RMGrlMAdPqOTMKatFwYeLFS0NQjgc?=
 =?us-ascii?Q?0E9rTJV9quxZsP4VMe+qXR3057r7uCj2ExCC24w+b9wOZ9FRZEoRkSYTsxfd?=
 =?us-ascii?Q?gWwcwP+UV7bhlukRECMH3eurQf5IZTx+3+8w/dDpkAlpq4OT661N26NODBBM?=
 =?us-ascii?Q?AthHJLY+pQbb3yQStd/EpzWhX3fB6LDaASmK0rYPI2RVObqdPbMCtSIdBHYL?=
 =?us-ascii?Q?ioWvQ7R5IbB4LwlKMgC6jtIr3ZJowhpusAPPozsZNvzbErHkYG5+uYh00F4i?=
 =?us-ascii?Q?Ys6jj/Ouh326MoYjPZJapm/Uf3x6t86e3F2hMVt506TquFtSpcO1YGOr+tbZ?=
 =?us-ascii?Q?Ta91KCPj4mnpiKw1BI3M8y7PaXnqXptJxCQ4Fxe0s4j6bBh/gn0O3h5axKLW?=
 =?us-ascii?Q?+ueUOlx6+g6j4BDaRjVlQRklb4WGM9nu0qnEBVawgZY9g6uPac1wya3ESEKG?=
 =?us-ascii?Q?t17NbLzVBn9pDCaTiA/hH6CRSoVF02rZ1e/yfJjeI9dFJ/4LcEwqw89L71cy?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <AM6PR05MB6264E268D3CD40591BB9BE75BF740@AM6PR05MB6264.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(256004)(6506007)(8676002)(99286004)(52116002)(81166006)(2906002)(3846002)(33656002)(81156014)(76176011)(102836004)(386003)(4326008)(229853002)(305945005)(106356001)(105586002)(25786009)(186003)(33716001)(11346002)(6486002)(86362001)(446003)(6116002)(14454004)(54906003)(7736002)(486006)(71200400001)(71190400001)(66066001)(97736004)(53936002)(4744005)(5660300002)(68736007)(476003)(478600001)(6916009)(316002)(6512007)(1076003)(9686003)(8936002)(6436002)(6246003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6264;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RPTWbuKa5jkLTc0DPGtYlvfTqVq5iMnsc/z92EDtWEB/PZHizC8sMl8ok+yaqaUBi/nZVokfaF1VndqZrx97/3tiUJ7NEIHdf9CaUDVnpJIDctgKx/Te5mEASkBgyMOmV4k9ofuRvq+riXuotlysDHZHtbp/zhfjC3rGprd2a52W+5VHLN9yUiaaWEgZrE1uYxmHqzl52eGMCS8d0r/bmzvvSTdNH06IugQn1RGzOA5Bsopi08o0uKHm+8VsCFBzUZutZFq0OnZBHcsqtriBQVqHrF0Nkb5pGd7uqLlDT5qQ3K51pInoB1PM4dKeNPk9e+UgfvLjTav+DutiBiVhjFwlLPtuxlupVsrSeVNR/hwVdFLg8FpB4B14drxYgE+xpRXyusmhYv6R9TkbqxYnGgkAwXU0P5I4MQ7JDj1EmdQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8399D3744EF47478B9BC47D3C34E2CF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c480ef8d-ba1d-4a8b-3f3f-08d69cf086b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 20:16:58.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:44:32AM -0800, Florian Fainelli wrote:
> Now that we have converted all possible callers to using a switchdev
> notifier for attributes we do not have a need for implementing
> switchdev_ops anymore, and this can be removed from all drivers the
> net_device structure.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
