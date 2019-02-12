Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA8DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A02214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ewb5+6qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfBLNOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:14:52 -0500
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:4416
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfBLNOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ROmE+gPd7kZTop7sn7HvSN8xkg4m3mB+3z4099cZZQ=;
 b=Ewb5+6qjE6OA5DC9aneYLBjdzbF4kwfll5xC5EIX4zfd7/+tNBIKpJmAkr9WswriLYb7VQw4kE1VxRjCz+wglbGt/NAcISU3ZtAsTkD26m5dkudOY3nOLP+ZdQJbGEb6pHIbCF1SCrLO+J2EcGiCK8LR+T+K98bti+CUTEO2sUw=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5368.eurprd05.prod.outlook.com (20.177.197.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 12 Feb 2019 13:14:47 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 13:14:47 +0000
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
Subject: Re: [PATCH net-next v4 0/9] net: Remove switchdev_ops
Thread-Topic: [PATCH net-next v4 0/9] net: Remove switchdev_ops
Thread-Index: AQHUwj1zxqFH0ZbG6U+8BvdVKYhXX6XcJVqA
Date:   Tue, 12 Feb 2019 13:14:47 +0000
Message-ID: <20190212131443.GA13819@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5368;6:Q0sgKTiSGo7WdqUj068gqqorBndBlwiMHsDVAyt6dl2EPj3t2IyS7osA/Vokc5f12MdDWy2n2NhDXM1eXzd8mwQFWAKHIjv7eDj+hBDYXR0INWmUl7it3bverEDfBGPARYUzeE1hI5t0SQGk9ImVO7kjThnGlDi7wjH/3r/lUq0IOQieIs1EdXVqnD0CJl4CnS3YzW8Hba7LLWXJd3e0Vt/sj5YhLJ92NqXEk6DXsbRXhz5Dt7sLQ8D9/JfUtsAzzZQrNFH618gxsgrtCnh7rFXViUoglAkWil5PG8DoXxDuGYI7r7XuMWlbOhA1xmnyTUjjvWoEBW3eViK9DsQtqHzEtXsTubwsWCAiE5FS9H1zvnbNV9D1fR4cmoePi6M4BGeRwEy1LfXUvFO+zVA6yQprUSMvmLPvj2l6iP5qCLHsjoy9TyaPo0H8F4JesRD4f9PVb87OxzKlv1wvMQVk4Q==;5:4TVfmpxAVNdf0sovy5MTKFabL+kGDp+ceyuDGRrkrS2uauYpo5dboXcNrQOVd7Jqc3rOxxR5J2zN+U168NKRC766iK4MvidNpzDQZCXR8k0AshrXzwNWOnvaEjm4NW6W1QjgWkSDIKH6kA69cgNVkx8SrfNOJL9uLOe5Q3gwFsty86FnnFjeZwkEaLHS2ciT4UV3NvHR8tkhJqAX/SkMFA==;7:t+hFK7VeuW7LXdSvTg3ycArhwMYA2paufVKDPhWJ0IQKTz0TQ24PwxLqf11HVo5+cLitfcKPsPsQ3zA7N+6qH2OP3qtOpE3a/fIKMw/bTfdqNuM57qgrJGXjrmnHdGpX5nNDzIq8ehIkSDo3AWNJig==
x-ms-office365-filtering-correlation-id: 150599c3-c4e9-43ce-b730-08d690ec0fae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5368;
x-ms-traffictypediagnostic: AM6PR05MB5368:
x-microsoft-antispam-prvs: <AM6PR05MB5368AA976F3B5D2C6D08A636BF650@AM6PR05MB5368.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(53754006)(6246003)(478600001)(106356001)(11346002)(66066001)(446003)(99286004)(33716001)(33656002)(2906002)(8936002)(105586002)(476003)(25786009)(86362001)(14454004)(486006)(6116002)(3846002)(6512007)(81156014)(68736007)(229853002)(6436002)(7736002)(81166006)(102836004)(8676002)(386003)(316002)(14444005)(256004)(33896004)(9686003)(53936002)(6506007)(76176011)(54906003)(6486002)(1076003)(186003)(26005)(52116002)(4326008)(71200400001)(97736004)(6916009)(71190400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5368;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NfFAAnXxzwhpnDVFmKdEDg2OEnTM5xyXIWT7/1RgzZzVFsR8VcIUOZ1SX5y7GTZiSK4g9VAiCv2sBXpZlfLiFlQyBzWzbQpjsaH6wyLNCRhXMJv+yDWrm+vZTn2ZRL6fr0rI4HXuLDbDiH4O3puHpBKZVZJTTm+p3ewc6r8bKsOjgCT7n6ct0j5vVB/N/tr//copV4kDSs02JgFmegJKEfKBRmQreXd4bfkglGszLd7pjv2Lk/G+X7iarQ/emd+2gRe0is3QUhtyDhhJ0ebxxXi3w9YBNgWeKZjVT+hBBdLqpRYyEzToPI8jQnSv/t0EOnB1JREGeV36vNOJLeNRLlWVQeRnoxdxncJflUO15c+TOym7kisbCogrEggMir+BFid89mUnHEPtlv615ij8+KanR8zBsKj85/HGDDoEidQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3987C19D0F710243BE2B3F07927F03AB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150599c3-c4e9-43ce-b730-08d690ec0fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 13:14:46.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:09:52AM -0800, Florian Fainelli wrote:
> Hi all,
>=20
> This patch series finishes by the removal of switchdev_ops. To get there
> we convert the existing switchdev_port_attr_{set,get} switchdev_ops to
> use a blocking notifier, thus making it consistent with how the objects
> are pushed to the switchdev enabled devices.
>=20
> Please review and let me know what you think!
>=20
> David, I would like to get Ido's feedback on this to make sure I did not
> miss something, thank you!

Hi Florian,

Why do you still keep switchdev_port_attr_get()? I believe we can remove
it and simplify things.

After your recent patchset to remove 'PORT_BRIDGE_FLAGS', the only
remaining user of get() is 'PORT_BRIDGE_FLAGS_SUPPORT'. It can be
converted to a blocking set() with 'PORT_PRE_BRIDGE_FLAGS' (or a similar
name).

I would like to make sure we're in sync with regards to future changes.
After this patchset to get rid of switchdev_ops we can continue to
completely removing switchdev (I believe Jiri approves). The
prepare-commit model is not really needed and the two switchdev
notification chains can be split into bridge and vxlan specific chains.

Notifications sent in an atomic context can be handled by drivers
directly in this context. Similar to how FDB/route/neighbour are
handled. It will really simplify things. No need for the defer flag
anymore and tricks like 'PORT_BRIDGE_FLAGS_SUPPORT' and
'PORT_PRE_BRIDGE_FLAGS'. In the atomic context the driver can veto the
requested bridge flags, but program the device from a blocking context
(using a workqueue).
