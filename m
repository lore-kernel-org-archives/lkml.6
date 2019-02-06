Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B39C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B82075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mDqFTmDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfBFTEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:04:45 -0500
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:26616
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfBFTEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua9OYuKaqBv59B7FaQeIa2i2qm/guFe03LFjWKpL8uw=;
 b=mDqFTmDNJ3DF4qluHHR5EGjceaRUHkq5BXKERDKTpuLPMtza422AbuGm+kkyqbi3aECv2toQxWSp3WuuJhQTj7TYKfJWuCNuOg4V8h/ndY0U7GVHqqtnyJg6209TS1X6YTWzKo3Eode3pT3JQVHdvRz/mCAscnxHFBcxQlRQRUM=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5016.eurprd05.prod.outlook.com (20.177.36.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 19:04:41 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 19:04:41 +0000
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
Subject: Re: [PATCH net-next v4 05/12] mlxsw: Implement
 ndo_get_port_parent_id()
Thread-Topic: [PATCH net-next v4 05/12] mlxsw: Implement
 ndo_get_port_parent_id()
Thread-Index: AQHUvkPcubgaoLXsz0uPXoY60kyO4qXTIRAA
Date:   Wed, 6 Feb 2019 19:04:41 +0000
Message-ID: <20190206190434.GA14340@splinter>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
 <20190206174546.23597-6-f.fainelli@gmail.com>
In-Reply-To: <20190206174546.23597-6-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::26) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.229.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5016;6:Agb4loeOqFz2BNCRRZk6S9Rja7LcbTfnU4OgbeKGlDgsXCch80Z7Fy87Yowih3FeKVUuVKOd9qII4Iq8ghdvXBdSiARJxmsTSwG8U6KeKM743r5o85Q+c0sfDrk+axrLvXASqT88Emn18RFpAiqNhRgdJoSLpX/QfcLi9G48CnlJFNyBEWjdnGRvGm6YYdBX7NAt7d/escEnj5eyo34tRRLPmcGMDRMoPakfUDU/6fyXtOhFbMztERaVFfeGsJBVEV4QckgmbTfGsqhCMzJbwmsdWUQaNzLF5SeX1Fy/sEFQxYitvTtrLs6GSPjLrm5zYLWPqL0qPHAHFT1FV5tAqEc9m9R+ZIk4M6MjcP5U3jxRmTmhA8f7u/l1nd3xsaRWW/uI0IlsZ8EUoGUmJBXrMUXpg/M+P9alffY3g++1D7aBmIMqB40JQpmwM2zBN8zwnkLp1KNa8bDghBGGxtXF8g==;5:TyhRn0IwRRGKYc/64R9tB2ZOANVLxeBZBDLiq/Vk6aLSklOWLUHvvET5BmBC06HIYcqCTbOOZJKQoEKTsz+USqdju6hv3/etR6oRNe1JLvar89qz2yb0RPdCTZeCHpM6aPYMJDwZtM9yw+V+nq2clXt/nBhHK+nEF2POqkk9hTHu2gznYltJ1bYq5hAR4cAmB3aBK6K7aCuxSe+pvYB1Jg==;7:xSOoXC+IX7Qf9qXA1KG/Cxd8cCICDXo7WlGKrOaBLpwXS43tXi4w0peD5s9VHeu4/Uc3XMGRQPGZEFt+6ZPXSgHcUdn1Um//yslZxcqzgDDeKQn7FJC1n8W9qy85/PqzYVslMSA1XWnV4bGtgSB/dQ==
x-ms-office365-filtering-correlation-id: ea04d3f4-fe11-4982-ad16-08d68c65f25f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5016;
x-ms-traffictypediagnostic: AM6PR05MB5016:
x-microsoft-antispam-prvs: <AM6PR05MB50164EE3A1485A6A9A1EE219BF6F0@AM6PR05MB5016.eurprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(396003)(346002)(376002)(39860400002)(189003)(199004)(7736002)(66066001)(8676002)(6436002)(478600001)(86362001)(105586002)(6512007)(9686003)(486006)(4326008)(446003)(386003)(476003)(6916009)(1076003)(52116002)(6506007)(4744005)(53936002)(81156014)(81166006)(33656002)(106356001)(316002)(6246003)(33716001)(102836004)(229853002)(6116002)(256004)(54906003)(305945005)(71190400001)(71200400001)(26005)(3846002)(25786009)(97736004)(76176011)(14454004)(68736007)(8936002)(33896004)(11346002)(2906002)(99286004)(6486002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5016;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8VnsC8H3ZFD133t4qx/7P9bqhyGgXLpzwNmhtz74lgIDRjxYsxyLpgXidTwbf2AX5nH+Nh92/sc4PWmPWCxvJPhI/1UfZN2geC50AeHEghW/NqwQM+FMG18xcptuLAPDvT6iATqK5BpAyG15FGR+li9TXYX7MR4CuT+5d9uhddCN4MW7/H0xI3CpQdkabQo1l+bKjpp06//BPn2DFzooedxoe1fIh+a7L5OKwTOFNIpKwqcjUaCHDmrE/9t5lyzbSgyW5GvZBpnRWZY6dlnPdKaReAYdv3+uMZcfRKOp6Xd9P0gxbKzAdH69s+3+AJz/Z9GpjFfhcqwsdoWur7h++3J+dbzzHGk+gDepuxHQ5Fw8pdz//HF6++GWHxvmi22emeGUzqKS+C2N+9sF5d8JshVOFT/9N6XXXyIho0srdQE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4EC5A764CE1EA4D9DF8CA9C5BBB1C95@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea04d3f4-fe11-4982-ad16-08d68c65f25f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 19:04:40.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:45:39AM -0800, Florian Fainelli wrote:
> mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
> of switchdev_ops eventually, ease that migration by implementing a
> ndo_get_port_parent_id() function which returns what
> switchdev_port_attr_get() would do.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
