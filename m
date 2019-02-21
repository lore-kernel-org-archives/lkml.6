Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99BB2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="W99B4j1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBUJ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:56:19 -0500
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:51225
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfBUJ4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzXltSBfV14hJNRUm2MwRcMR04TZ2GhQV+gjuGqmuAQ=;
 b=W99B4j1aG8T7EqswKL2ciKCs6iwI+P73dOVX1kCa0bKxfi/ZpYHUY2df5YrZyW1XRZCV+ju7BX+oknd5QDdFrsyk5++XhgYb9P2klmzyVyVfefaigyCcoXIKU9VwCt9Scc0Pq+9AQFyrOcNZ2YltF49q6a9ZbJIT/G8U+Oefpe0=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5475.eurprd05.prod.outlook.com (20.177.118.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 09:56:15 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 09:56:15 +0000
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
Subject: Re: [PATCH net-next v3 2/8] mlxsw: spectrum: Handle
 PORT_PRE_BRIDGE_FLAGS
Thread-Topic: [PATCH net-next v3 2/8] mlxsw: spectrum: Handle
 PORT_PRE_BRIDGE_FLAGS
Thread-Index: AQHUyYCa5650v1PvKEy/+pa1ScqWoaXqBFqA
Date:   Thu, 21 Feb 2019 09:56:15 +0000
Message-ID: <20190221095613.GB26289@splinter>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-3-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-3-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0016.eurprd04.prod.outlook.com
 (2603:10a6:206:1::29) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6dbe354-4c8c-4921-f377-08d697e2d142
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5475;
x-ms-traffictypediagnostic: AM6PR05MB5475:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB5475;23:JwGGuDRg7XjSRW+KF8ukzSis6m7SfCcsxo/Fo2v1R?=
 =?us-ascii?Q?fIQ85/srYaomVSSnX94iNdpn8AH9EFnoFCTroP0pC9u5A+Yp8UgjMPPcQ+gb?=
 =?us-ascii?Q?bhTY9+TLga0vQvqfTGm5WUzcEuVpZVG+gNPYX7ovXIOU41niLb7MtdC+qPo3?=
 =?us-ascii?Q?p87+1E4xMNoLYhxPP2DDBKWFDNsvjIPzSU1NI5B2/znrBgPF6l9u9OwlPr+E?=
 =?us-ascii?Q?n8kER8GZCAxeeKRt4JL2pPg4CmVVxBd9X4Tj4ef303Bv/uiExEH76U7tRMfa?=
 =?us-ascii?Q?RsH4noO4wDJsnILo3qPOxuh0Qpj9Jp5UMRBCohyQPYrD5ndQxEiG4Algd2SU?=
 =?us-ascii?Q?bpsdguuLgLU8bqkEeIXkXmKwxyoNgkDKAk3DnYBXgp2CK5f8tcd2Kw+xvw/S?=
 =?us-ascii?Q?EAnIckNOdhNjY0MHCwj7AQB3fozK1bESonZC5bxa3aqN0OQDhBEcbTUp0Hap?=
 =?us-ascii?Q?WY19NY7oAhVsBRzuVAcW2uMln5ibNbQYEgdfDmkmp/f7p1JNqtzFA0PLGB9X?=
 =?us-ascii?Q?H97yS3zkkDTeBaX9wyHwao7L+n5M2xiv18uCUpJQohll5KrwJiEoQapm9kae?=
 =?us-ascii?Q?LPirrn8R5xe0RVfBujF6cTgrxtLKPLA6BicqrHu9ufcnNjAvGpHk4ASvuPsQ?=
 =?us-ascii?Q?4+Eu8788MGaNjr+L7SWKfx8Ijz4pVgbnDvZkJZ9VVoTUrueYgUBaug9MeV+7?=
 =?us-ascii?Q?mK2E+zsfVyzHvueNojIaOxn/gr5VIjQT74RP5s1hwGuT4jpZU2MkKVBXF+dh?=
 =?us-ascii?Q?s2z1nvsH/+xKGBGz17yIYkWFnLOoqyQ0x8Ty8cNf1gyo8MIwHtmD6HA/OiDd?=
 =?us-ascii?Q?7eZvOrQhzeILiFiv03qCFxz16T0LsKsiYxsqY69iwcJwixwLJW/yM/Un0xTQ?=
 =?us-ascii?Q?aoKxFSCHeIJzkvI7f1tuE+LcXpaDiN9dzN7EV/SkGnQnpqK/IWu5CkhUFw0Q?=
 =?us-ascii?Q?saCCTnm3eeXTz14xF/AvLzE2Knbl5UYkXgMpGGpKtoDwzZ4AmgnBXmGgldAB?=
 =?us-ascii?Q?xCYR/c32nThgu9DvFn9DNRDJLtIlYeKP1JcoBYfi1gkITogNwDLYerr9226c?=
 =?us-ascii?Q?BnqK+BFvEzZqDrqYEEJQXFc9Dlx8lGFnPEGqSbMCdtJADSEFMt68DiQG7EOw?=
 =?us-ascii?Q?Yp1Je8sRXRq1SUJ3su+0JUrdpyVFH65xXKa84EJeYOIxl/4VA1fBGqhEIxgb?=
 =?us-ascii?Q?o9fnL3BDQyXQD/0yS+t16/apOZIvto/cdk9S4lGCxo0MUSkqCGojr1Fb//3o?=
 =?us-ascii?Q?t8l5PNdqb5DPRdRTBc8Y6kRNp32iEtmS9lB33TWY+D+E+SbleczAEd2FPfg8?=
 =?us-ascii?Q?PWbjMS/VUeRlpBQyogTd9M=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB547583A474BFF18BFA436EA6BF7E0@AM6PR05MB5475.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(2906002)(97736004)(66066001)(1076003)(6916009)(52116002)(33656002)(4744005)(102836004)(7736002)(33896004)(33716001)(86362001)(305945005)(5660300002)(486006)(81166006)(8676002)(8936002)(68736007)(81156014)(6512007)(6486002)(4326008)(106356001)(446003)(9686003)(316002)(229853002)(186003)(6116002)(76176011)(53936002)(476003)(11346002)(478600001)(3846002)(6436002)(256004)(71190400001)(54906003)(99286004)(71200400001)(26005)(14454004)(105586002)(386003)(6246003)(25786009)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5475;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XpYcHsKOYcgwoN7AkdD3UpUq9zU7wjR31C+b05eYiryEgtiP30jDeAFMG4EcpIeBIFymECLR528e1ce7pJhvG1Qis5LR3R2czdOwHe3uEmSDsK9eVwxApeGb+kMqzEv/RSGhk2a6DLXL73g+s8YYQRGi8XXBypYRdBGZO4ShukShPFbfN9g05obTGP618JgWXTufbEDkYG+phSiVztaPzFVL3MaOIVqEjkfilzSyLyBlyxJO/o/rsOENlWo7Nhd52cBZGKI4OmQLEDRYavlsiUhBkNOf6s+HsTEdjTlTzIySvkuzWlGw3kPcXX2OjFZ8OJLTeUWqchOZ305Q1FF0PztAfG3Lxk4BYA3jFaamwo7jt6WsVrvBeqawldmYBKA1R8nUtMDjV2qkLrR6lmxUNG8178K7klGRGE/Fz2PzsZg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <906D3CC0BAD2974C9A5603E6B0454184@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dbe354-4c8c-4921-f377-08d697e2d142
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:56:14.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:58:20PM -0800, Florian Fainelli wrote:
> In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
> check for the bridge flags being set through switchdev_port_attr_set()
> when the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier is
> used.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
