Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE3EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EFC20821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="udlinu8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfBLN4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:56:01 -0500
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:61632
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729880AbfBLN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BppXVa/dmDTUOKLFEo7WizMgmZk4QhbPlPOeKYW5Jk0=;
 b=udlinu8HytGMN8j4vt8WUaiewdodpHbBJO106bjRBAxSlPn+fQuwxnqAWdPNBf14EsUimk7O+DgV7+r3SnZzj+4cxRfNSRQFjOX3NQBoCLKdo2Nd9iO6iKIlbfXHDaxYHKTZzFa1nTsFrZ4zodXlSMnOsyqfkAn01iH0j/A9dMA=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6518.eurprd05.prod.outlook.com (20.179.7.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 12 Feb 2019 13:55:54 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 13:55:54 +0000
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
Subject: Re: [PATCH net-next v4 2/9] switchdev: Add SWITCHDEV_PORT_ATTR_SET,
 SWITCHDEV_PORT_ATTR_GET
Thread-Topic: [PATCH net-next v4 2/9] switchdev: Add SWITCHDEV_PORT_ATTR_SET,
 SWITCHDEV_PORT_ATTR_GET
Thread-Index: AQHUwj15ybMSUjRir0mKrueVt2XNHaXcMNiA
Date:   Tue, 12 Feb 2019 13:55:54 +0000
Message-ID: <20190212135551.GA16850@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
 <20190211191001.8623-3-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-3-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB6518;6:PTziuAOErc9aINkuHZRoZoS5uJ+KEScP5zDgePqx7Dn3sd3VToSvihFwg+EwLQjg3pR5u6POqiyQYYR87EStvhE1e92VYGHF6djjRr/IRvPSrQKFUJ4CMsoEs5LDLRPEUmOrwXK6wEP2uNcnJ7+IOChl8U4ZDbCmE4QHzK5FeIkJCUdKr4UCzMk5J2xU3eYcP59rlhWgE3ID0Thv51OJGhTxJlsH/95BZpPaR0FsQND59GWsZ+QJ2GXwjNwKbhqGPeqmdYSOglfVfhPdpMzX+Zmdl2Qw4ZzR0VzdIq1zsojN9RIBJSomdDCBzy03pDMm7BFsMqN0LH0D43P66sM/DopuR2/x8zs7a59hrmu7mIYfOyARaqiunsPCNNyuAS1b8hSKzi0k60HNiu0wvFhxVUuvJFOyvvgqt7SihVnJpgC7YF//w31r3AQOS0da5pseRcpj7qjCgOc/5c3hHy+NUw==;5:as9UjAjWmPdyPsArTK8oTo5b/Eb/KnCNIRNQE4ytCyRPlJb8Qk73T+PTx1yoPy7PhXdQxE7HOyTIG9dVzHKA4CwdCjt68OvV1BE+6yZjl8xqUxBeUBanpwDKVdeXSbjj0AkWbVyWOc1OGhSJGPj/dYnfXTdyOk30clz/xNutar1dj+8FFEva8dwbS6r3Nlg2aG5G4F9avm66h9b4fYeuZw==;7:QpT/+cCYl4MyeQef+cXGIWJeL4E5NmsIk2awS3/2/207Wf00/INqd0SqTjK7cWuf4Z8dwqEsfCF7vmX/8BKIGBLto0v/YNsyxi9SlkIKIcMQE38crj4iRD2buA72xl61DlQJ8RujcNT47oTh/ks6tA==
x-ms-office365-filtering-correlation-id: 72a76268-5c80-41dd-f296-08d690f1ce3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6518;
x-ms-traffictypediagnostic: AM6PR05MB6518:
x-microsoft-antispam-prvs: <AM6PR05MB65182787A8BF4767E4728677BF650@AM6PR05MB6518.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(1076003)(81156014)(54906003)(102836004)(305945005)(476003)(8676002)(229853002)(86362001)(52116002)(2906002)(33896004)(11346002)(99286004)(76176011)(7736002)(81166006)(316002)(25786009)(446003)(33656002)(105586002)(97736004)(26005)(106356001)(71200400001)(14454004)(478600001)(9686003)(6512007)(4326008)(386003)(71190400001)(6506007)(486006)(256004)(33716001)(6246003)(66066001)(68736007)(6436002)(6486002)(3846002)(53936002)(6116002)(6916009)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6518;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3mZRFQLlNCWYyL91WCjoL0+A0KC94BqmTtVLoHtNZLLH2Eou2fOUT7HKKfupoVzwTPFSey1cr4LiO9dpEBad3ftb7MJNHwWPuBG7KoMqi/wEIGEopKJ7naRwsQEZsrNXmWSooHY2XQSIe9TIzLMWFqwp4aZihM+KYi9FTA/HhWi189qTXzs05pmbYer24rhE65ab8p/jT7J6mVfxZX0jWodQ5Wv82NjBSIhjo+oG2Z2gt7THJhf8+UF7OiBLLoZEth4LUgAAvUi3MRBp1igPneLenu+NTVdwaw51GVGwYNuwlixY6FARPnyrwqvzHk/S9CN56Ea7sHiIOhO+v8111tkPXgKBTjrSMN1T9XobPM8+/3bA/9BnRfx50j4W1zdIt5gs5BqbevPiD6iB+OCxHgVmCZhhWrQKg5jLyt+ZfkE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1194120A8552E7488A4F91C5FFD590AF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a76268-5c80-41dd-f296-08d690f1ce3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 13:55:53.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:09:54AM -0800, Florian Fainelli wrote:
> In preparation for allowing switchdev enabled drivers to veto specific
> attribute settings from within the context of the caller, introduce a
> new switchdev notifier type for port attributes.
>=20
> Suggested-by: Ido Schimmel <idosch@mellanox.com>
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/net/switchdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index 5e87b54c5dc5..b8becabbef38 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -143,6 +143,9 @@ enum switchdev_notifier_type {
>  	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
>  	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
>  	SWITCHDEV_VXLAN_FDB_OFFLOADED,
> +
> +	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
> +	SWITCHDEV_PORT_ATTR_GET, /* Blocking. */

As I wrote in the cover letter, I don't believe GET is needed.

>  };
> =20
>  struct switchdev_notifier_info {
> @@ -165,6 +168,13 @@ struct switchdev_notifier_port_obj_info {
>  	bool handled;
>  };
> =20
> +struct switchdev_notifier_port_attr_info {
> +	struct switchdev_notifier_info info; /* must be first */
> +	struct switchdev_attr *attr;
> +	struct switchdev_trans *trans;
> +	bool handled;
> +};
> +
>  static inline struct net_device *
>  switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *inf=
o)
>  {
> --=20
> 2.17.1
>=20
