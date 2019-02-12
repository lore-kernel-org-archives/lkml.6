Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2805C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F31214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ycxlXRoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfBLOKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:10:54 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:19232
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbfBLOKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JcylOc1PrbrvW0pRPoXxMBtiYFEbeheosmI20DLP6g=;
 b=ycxlXRoSD8YzzGW8KHYr60jO0JXNj/UYyW08DGW9RYQ/LUfuzfynSib6LNyE7J88z9aIvx2mJYSiRNy6FOD4MYufMyII9gxdbG+3M+xhzhbIY6pJeRr20Qtc+eVakKISRjV+THtRR5bCy3vjcQ2bZ/TNH+LmORTlXHfVo6hfB0Y=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5492.eurprd05.prod.outlook.com (20.177.119.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 14:10:50 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 14:10:50 +0000
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
Subject: Re: [PATCH net-next v4 9/9] net: Remove switchdev_ops
Thread-Topic: [PATCH net-next v4 9/9] net: Remove switchdev_ops
Thread-Index: AQHUwj2NmpycfGF5hEOklgf8fvlTIKXcNQYA
Date:   Tue, 12 Feb 2019 14:10:50 +0000
Message-ID: <20190212141048.GC16850@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
 <20190211191001.8623-10-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-10-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::25) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5492;6:3qgmd7IIzj2ENRkO7QX6l8iLlpby7Vr8qzoVf7oLAWqGhH8Iz5R56hNMBbk8QJceoBZDEK3cKEEp6FB7cMyw6yXceHZcqJoByYX7gQRr1gMhndIkQZWz6UJ5r5BEVdE0SL/BkCSvdXzgltsBU+mvj1xwVhZ5j7Mdr/bsxjO3yLsM4j3cClrDm9k676aeAdvrTPh38n6MicFpeCv3dwHbxTaJKQCk216LSmfNcVI1+2zQHKlTzCSIGIBejpoU3UDfbxcJuuP8Se15y9KHVstrzTLORyOZ4G8X3FjeHLQRh7pZd4yUwqrQfTU9eXuyonVFm4zZ6tk3l0qfvV4+v+FVkmB27nwxQGKvYB619qLg7pMhe4/plsI0+J4sLLTvgIIeFp0pKc4+k8SoOH8P3oPvnnx6MxquzO0wY2Twy6FgajrzDWwW9Sx0Q9TbksdNGgMdD6EvkLZbaPYqFg46ir4pvQ==;5:/kkN5egNbunzwECcC2mwYLpdl+SfNasGBVreemNM1qgXEAiigvj2Uj3n1UXA4S06CIxYgpKMndMbUORvztIEWmRo5gFlYmYnW7VKfUt3TwyVte4VYSmuGD57qUpxq+IqMhlWGzvT0qub24BaFkRZNivniXolmrh+kWc/zJ/4oXgi1OKdxVcL488QEArISI1dMr5ZpotKdB74XizMBBdYQg==;7:AYvYRHa2o3Lp/jiZX2G7QEduH0ruMj+W1nrkF1qg7VqAZJXM3Fk7xcWLOrTf19OcD6lQS7ZjWwNmJ6rJp0xcvqTuAhO1VDO4e7qoN+ygr86mJz/XxLh1/s7vaSjmwwY5djVmaviWuLV4GaKbkhGBUA==
x-ms-office365-filtering-correlation-id: b8b885a6-50fc-44ac-3ce5-08d690f3e462
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5492;
x-ms-traffictypediagnostic: AM6PR05MB5492:
x-microsoft-antispam-prvs: <AM6PR05MB54927D8E297D2AACE7880F5BBF650@AM6PR05MB5492.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(6436002)(9686003)(6512007)(6116002)(33896004)(76176011)(229853002)(3846002)(6486002)(52116002)(81156014)(81166006)(1076003)(7736002)(6246003)(305945005)(8676002)(53936002)(68736007)(66066001)(8936002)(33656002)(6916009)(316002)(86362001)(54906003)(14454004)(99286004)(478600001)(4326008)(4744005)(106356001)(25786009)(105586002)(186003)(97736004)(33716001)(71200400001)(476003)(486006)(2906002)(446003)(11346002)(71190400001)(6506007)(386003)(102836004)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5492;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C16u/eCQFAgAZYfAFXTDTFLsMJ9lPEudqem942yRKFJAIaGtZosMIrAYb+Dgw2KgKjfyLdx0z8XiJBBR3AypTXdKVqNWAHBJ1YUVVhzlksS0QwXi8QLGbJ/a6vMcfqOGH/HcaTCcARM1CCTPm26X7ts6wOBuyqUmUx7OfcY3OUTBwV4T4Nyo2Xn0T0+0wExPo8u5djx10AG1sUsZ+Yn7xgnMVI4Ox3pkvJv7cpPf8kE6uch63xQjl3frmJOg/fi2V5VQ/ZzBIsh+sqqOGEl6Q1t67Jb4Mo7kc+0sEw859Y5cBkjinyH9MSG/WBavaVnCFo3Cjtbg5mnT26fr2SA/mJQKOXNttIWux8LwSujHrKg8NH6KAb5935aRvjx8yQ8gpV9s4IguUxCTJ0QdPacCI6KLZn8W8aThMK9ibTvTFPQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4168D19CAE06654188B5C3B6607D2D85@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b885a6-50fc-44ac-3ce5-08d690f3e462
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 14:10:50.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:10:01AM -0800, Florian Fainelli wrote:
> Now that we have converted all possible callers to using a switchdev
> notifier for attributes we do not have a need for implementing
> switchdev_ops anymore, and this can be removed from all drivers the
> net_device structure.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 12 ------------
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.h |  2 --
>  .../mellanox/mlxsw/spectrum_switchdev.c        | 13 -------------
>  drivers/net/ethernet/mscc/ocelot.c             |  5 -----
>  drivers/net/ethernet/rocker/rocker_main.c      |  6 ------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c        |  6 ------
>  include/linux/netdevice.h                      |  3 ---
>  include/net/switchdev.h                        | 18 ------------------
>  net/dsa/slave.c                                |  6 ------

There's also this line that can be removed from the 8021q driver:

net/8021q/vlan_dev.c:34:#include <net/switchdev.h>
