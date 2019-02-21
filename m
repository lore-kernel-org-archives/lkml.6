Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17103C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48CD20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Oi6Vp2dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBUJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:57:27 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:2489
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfBUJ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9Zxo8/04s5PWo0X5pqxgfblSWtMI6yu4jJeHLLMm6I=;
 b=Oi6Vp2dYQR4Y7qEIQOjkKii2moRT7za3Y4esvhbFUiIP+7a5FbDMjXBhT35x7eNNgx1E0hWfixY+g9oNbWIEsPWWxc6/mnu+pGfcMphhKLRjh46ahISmqV80dghcs5KAcKXKg7NpLGp1gt5aJAgWZ+BRDW84mMILsrDwm858IsU=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 09:57:17 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 09:57:17 +0000
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
Subject: Re: [PATCH net-next v3 8/8] net: Get rid of switchdev_port_attr_get()
Thread-Topic: [PATCH net-next v3 8/8] net: Get rid of
 switchdev_port_attr_get()
Thread-Index: AQHUyYCpGSJm2vzrck2IBioYWBIHfKXqBKOA
Date:   Thu, 21 Feb 2019 09:57:17 +0000
Message-ID: <20190221095715.GD26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-9-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-9-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0009.eurprd04.prod.outlook.com
 (2603:10a6:203:90::19) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c125f46c-931b-4b3e-1815-08d697e2f690
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4472;
x-ms-traffictypediagnostic: AM6PR05MB4472:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB4472;23:RKc5aWtU+9o78LaX8sJey9U27hnz23kRDqZYwlTxP?=
 =?us-ascii?Q?F1zY0qoKxWdPBSbXbZhj8tQQrVglaIfW8BmYOE9mCJr2ode/ppWB4YirQl1m?=
 =?us-ascii?Q?3TWP+kGIslSE5DGLEMohGlM0Jjle0vB/gPbcnVtNqAqO3iqMkeKCne3FBuTl?=
 =?us-ascii?Q?wmA7BMmsNcTEdiAEhGbZArwiPRoHbZmWGOnbYftrAs6gWZLuHD1n/VcEk1Eu?=
 =?us-ascii?Q?HsmniTaeNSPQnV4txppwAtUNtnzNPCs1U5eJZEyEhsUH1mScDNCFGg3cscDr?=
 =?us-ascii?Q?4KApm3ZRP8Za8HaQNy0jp2JeOYk7XaB2EMOxwDiuDgtyqIQRTtjtlYPa7gDr?=
 =?us-ascii?Q?l05Hh31jSgsbnrwXyztmmf/1N1anIJ+HfyApsn66lEKOtlgru6cHO4gkq7hh?=
 =?us-ascii?Q?F7xPfW7utySTZLf2MWmO2q2dipvlpl5rqmZ7NfmhgyPVUaFgGSoPWxzZuixl?=
 =?us-ascii?Q?eoQ/SvO1dKyh9vUV9L2sRJdpLBo0ItgXLMjYZi2GqTlDcKgpkfIU19A+tC7n?=
 =?us-ascii?Q?ZWhedygQozEmLzl2Gzk5Sut3UFoTl6GeKjM4SbEhGl0jrr5eHWjnjDkWFjIH?=
 =?us-ascii?Q?T7xIsYRCVsaOp6W0RcjShWbALbXE9UB/uXcilJgImWruVeYrH9BqLJN0LBBK?=
 =?us-ascii?Q?fit+SX1SO5XMtWCX1elp3LLdpjiKbyK1mtFjL1BBNq3y6zR2EpcOQIhdcA6Z?=
 =?us-ascii?Q?H2paeEbS5BMTv7urLFrufBCwxUykHAI01jVFtzvOa6rC8wWP5ctRYiHNsUh+?=
 =?us-ascii?Q?/u9e6ScEy27tvTp84RuImNIhegUhCUWJbRQcq0t7OxMa/+oQGHRTeYwVyjha?=
 =?us-ascii?Q?EHgpHfJtycdyTRlJbKLO/Bsei9dAlMOuIGKl/OifO2wcC3+t5OQjaK0tvnLa?=
 =?us-ascii?Q?bRwmxL5lwjNLNUHnq7RNr6M3zd0QbvCLDSrnWU8PZu62GWyzH1eRyZbXVd1p?=
 =?us-ascii?Q?y9oI1REH0Z1VHPINteksReji9+9zw8AGmKREpy6IBfP8ar9NULjHzw23Pqxd?=
 =?us-ascii?Q?2sCQV+0PXYgSfEH07rLml7AgJlR8axIsXtYd2o0ZK6dBGNWB2CnmCuMR+ZxE?=
 =?us-ascii?Q?D4FDd82U4WtwQOT2hXIKr6u6B+Q/TFLUvPvxiOxDcDrIIGboyEeXVpEAfaRZ?=
 =?us-ascii?Q?81q6zGGCu4IvmrnQhAHLlB9JOdjpl84c4ghN3cVq1Kgm8nl3Q8KF5rrbk7uI?=
 =?us-ascii?Q?gqno/4WYOcjPPiM53I89TnagbdSORyndJRq71zHx9bgxu9gYe54F4yaRea01?=
 =?us-ascii?Q?gxpHUCMSbd0wKcA9MkT48fbhWmRW67TcpurQraXT3A4jcoQd/gDeYH4IvSv2?=
 =?us-ascii?Q?LNEUJBr+W57V4z5hrF/iJSnd8RWDLhp05YXfGG85YAu?=
x-microsoft-antispam-prvs: <AM6PR05MB44728F955B2935FBBD664FFFBF7E0@AM6PR05MB4472.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(53936002)(71200400001)(33896004)(6486002)(71190400001)(52116002)(4326008)(1076003)(6436002)(6512007)(76176011)(99286004)(9686003)(66066001)(54906003)(97736004)(14454004)(478600001)(6246003)(33716001)(33656002)(256004)(186003)(316002)(476003)(229853002)(6916009)(5660300002)(486006)(11346002)(6116002)(86362001)(8936002)(68736007)(2906002)(81166006)(81156014)(4744005)(7736002)(446003)(8676002)(25786009)(305945005)(3846002)(106356001)(102836004)(105586002)(26005)(386003)(6506007)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4472;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mnBKoQO4q48sRlcEFLh2VWjDYK/kmCmKaGs5/5bScAZyPrB60CFjrpOdanyyLtg/7McNQq6ro05vOxa/AqXVV8PFWRSsbiLsxqpNnS3SqvfPjg3gaTlWPvWF//KPHRpTKPFLeMBGfgh1Mg22MI30zh8OX7cQTVp7tnlRSR3xhfROopUl9Ee5nq8ZtkM23bP8NGPuyh1IJ2tO54Z+6QdQmgEkFKTjhgeRt6m6lzXSOeIKXZhsfa/FwBeILvkv6KDcNYUq1IxBhYqvOBT+gakH/HXsy41Vjcfnr4aRzttmuyLVvHtnPcuN7+/I2VSDVs/ivkgGQ5af9RVAZi32NYpVqauRlv1h7kHpDEugCDTMxxWaV+2CIbT1mZLqTZVcRhgMzr9u7w8oH1/+LVD849Bf4b/7pu286/x8QNj9rLkg+w4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F024D7D78F736F4CAE7F412BF6094966@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c125f46c-931b-4b3e-1815-08d697e2f690
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:57:17.2554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:58:26PM -0800, Florian Fainelli wrote:
> With the bridge no longer calling switchdev_port_attr_get() to obtain
> the supported bridge port flags from a driver but instead trying to set
> the bridge port flags directly and relying on driver to reject
> unsupported configurations, we can effectively get rid of
> switchdev_port_attr_get() entirely since this was the only place where
> it was called.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
