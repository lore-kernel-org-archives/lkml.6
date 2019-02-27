Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC22133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="m9JXNtQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfB0MaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:30:07 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:43495
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfB0MaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or7E6o4x/BXPv5VY/2W1hq1f1T7cef/UQnIQznquiWw=;
 b=m9JXNtQAhlMG1SxHO8ypz2glUE9u9DR54pDs386K9b34u2S3yB0xKAqU9cWDVK+XZjzRHsCtj2peRlmQ+zyP2nqgVdOEo4KSntDvDOMvom54snnxUU+CSjOGtOUh8PPIEytxz7KM4gKk6McmCl4zhCYC+yBwzKlUG6XRT0Tijek=
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com (20.178.42.15) by
 DB7PR05MB5209.eurprd05.prod.outlook.com (20.178.41.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 12:30:02 +0000
Received: from DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23]) by DB7PR05MB5243.eurprd05.prod.outlook.com
 ([fe80::2df1:2e11:a3f7:ef23%6]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 12:30:02 +0000
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
Subject: Re: [PATCH net-next v2 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Thread-Topic: [PATCH net-next v2 1/8] switchdev: Add SWITCHDEV_PORT_ATTR_SET
Thread-Index: AQHUzjnTPBDUgJ1CLEGHcD7GtaZP+6Xzk9wA
Date:   Wed, 27 Feb 2019 12:30:02 +0000
Message-ID: <20190227123000.GB13567@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
 <20190227011427.16487-2-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0062.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::39) To DB7PR05MB5243.eurprd05.prod.outlook.com
 (2603:10a6:10:68::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d3a1403-f348-46ae-20b6-08d69caf4bce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB5209;
x-ms-traffictypediagnostic: DB7PR05MB5209:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB7PR05MB5209;23:w/Ld2SQMS25ju6SuEFXNVDO52zwQpxq4ePNUmdutl?=
 =?us-ascii?Q?g0i5kAi9JVrVChEyxECpeg3y84aT6IRUGlsmWqSdfBChDsDXygnEcDuiOkte?=
 =?us-ascii?Q?RxHprY4fb5yaSYGbHnclENBRoxV/Ohhi5HRWCm/9z4slif+WyWxtqMnvUqih?=
 =?us-ascii?Q?2z1EQXOgoD76P3vDLdfS8CyzPo317I7KLymqp+Xgh+YCkTQ2RkQSn/Eg2RQd?=
 =?us-ascii?Q?8xRgO26XZPLlqC00nbn6/81BallScjWHO7rEZDidTAB6AhMO72Lw641V+7yN?=
 =?us-ascii?Q?on6ZWSKrE/PA6voEchtmFL6iSk/N+iQ1QhYTavn680ardNj6mNl1Y03QxyPf?=
 =?us-ascii?Q?yWAfqss18BpxlsbDSj0BauhL3Iyx+DIqIpf2r03gvPD7quM7q7ylDt+d3xLS?=
 =?us-ascii?Q?44cF1yFZg83rxUyB48cHQROYFrsmuAtb7X5ySxa9vONq3Za2FcXDfYN+aMG+?=
 =?us-ascii?Q?UD09Z+nm1DWXqbIoVjT6RKIA8krWLDTNIABBkKGAU9xF2MJHDs1UrO6Qi5t2?=
 =?us-ascii?Q?4mxSOn7QykuAtaR4enlFcU/qDYlFP8LkatdQwtixNrijAexACnoBXvXD0ypX?=
 =?us-ascii?Q?3Mo22AFqBdSJi43lLYpYSEe8fg+ZtMy5DysCsTsrEZVskFPNjFvFDO62A407?=
 =?us-ascii?Q?qrclZsf0RGTCQpSW4Cn40IBr+b7SuFhEOV2kG2vPSOQgZ8tbao3O7xhbRxb9?=
 =?us-ascii?Q?Kn5iJxQgcQXteaXbTs9e4CuwJQxniYjZya5o0N2rko3/DKEJxvKB1SJ+SMMq?=
 =?us-ascii?Q?6i95qYLtJIy2LJgkFYRAuJLttiZHrM5sopBhy7N1iC2Mp1ho5ohZEcI/Ab/9?=
 =?us-ascii?Q?mmPW2CzTicZNHNPesQ0ISwv0pzis3qidbZgKdhkhnGV9f82+LGPQggQOOexK?=
 =?us-ascii?Q?McF0G6A7pdZVbICvZoBF5lZu1ZnGpGMSGWW9qKa+8TxzIQcZtDN3ZMmalPX9?=
 =?us-ascii?Q?KoWAln+gcsib+ZZ8KlNF4H0CEZk43iUcZkaLhC0Mx4j75mqFywTinNzyiZor?=
 =?us-ascii?Q?SUuSNJNcf6sgmxZ87bVUxPNGJMUryGP4g3HqgAZANEp8gzrtWU5kC/aqQwlw?=
 =?us-ascii?Q?E9wCrh5uFpR5WTzFLKtT4LFY4EUONUJ1WrAA+9xjMc8WoRsfln9ZhGlxw3RF?=
 =?us-ascii?Q?H6eNs8tOe6hEdYcDnO+1XLU/VhDdpVUGfUOdZNIlSpUoeDVeQIgBOSysU0zw?=
 =?us-ascii?Q?Ptk6JCCaqlPKj//ndwkG/8OB6QoN0klblgeHyzqOB2KDFZqiiAU0ftu3DoQT?=
 =?us-ascii?Q?TGflhv+VR0rQvMERiAC7JmjB2+wusfsIIDg33Ts1DkV7XGNQpeD0NRkefJR+?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <DB7PR05MB520975749F30D93CF8209476BF740@DB7PR05MB5209.eurprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(3846002)(6246003)(256004)(2906002)(478600001)(4326008)(99286004)(71200400001)(71190400001)(68736007)(4744005)(6116002)(33716001)(6436002)(76176011)(52116002)(102836004)(316002)(7736002)(54906003)(25786009)(33656002)(1076003)(14454004)(186003)(9686003)(6506007)(66066001)(386003)(305945005)(6512007)(8936002)(86362001)(81156014)(81166006)(6486002)(486006)(106356001)(6916009)(105586002)(446003)(53936002)(11346002)(476003)(97736004)(8676002)(229853002)(26005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5209;H:DB7PR05MB5243.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vySaACNKzEr4Aughvn6j+3vCCU+9j7C4TTPfsl5cNHfOpUJe6VWbWxYChmHPUxKGHeMI/V33EQ4KOlGJjqXBH+gyysYEH4BTNGgaqMtM95/936cEz61c1/k990j7DcqkPSjkJ5osA9RuHkFAVNBBFNKcTnRrvHg/xanZmiOKvkkkgm7tar40YUREBBC8PRRvBHzD0/KzTdP6p5EHhDRTAZRxyHog8p7RwkAxQHAwxpG8sJgAPsC7YqlKIoV6VSQEyfvPzDJMCPYjDUV9GG/cc2ZwRGfVU414FahPnMtdw4/X9lqS/+yRO9s/ICeuRFYlB/fif6DvySgRjDjiKrOpkRhjBA11+B2PbOT9nOlMVhrq7sYXPtUVIgeCZI7xw0rc5FtjUsWqTlVyqLTxc0R0l5Pk+zzW2bN/1zQsqc312Q0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5D53723AF23E940BAAB5A4EE31F7839@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3a1403-f348-46ae-20b6-08d69caf4bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 12:30:02.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:14:20PM -0800, Florian Fainelli wrote:
> In preparation for allowing switchdev enabled drivers to veto specific
> attribute settings from within the context of the caller, introduce a
> new switchdev notifier type for port attributes.
>=20
> Suggested-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
