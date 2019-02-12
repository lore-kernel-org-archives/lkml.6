Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA0CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CF2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="iLxtpj78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfBLMT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:19:56 -0500
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:8433
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfBLMT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHnjX7Zu9JhmFCi1CiJcp4wiH8pXYYXHBrJn9ioQEzU=;
 b=iLxtpj78X8PxqlZALF6Ry/WAG4BH8FSR883I/vlxqMfOB0DcgzPr8/FCgoNlhgXQFRsqFQ6cQ4k83E05EqfiqkEUG6TUMDrui5fot4XJLmG4lRokPxq5FhRQJoUoFaYvpE3ad/VFMpkLq/8FOzk3gKjYc79BYXNCBcwD36+/VXQ=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5507.eurprd05.prod.outlook.com (20.177.119.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 12:19:51 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:19:51 +0000
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
Subject: Re: [PATCH net-next v4 1/9] Documentation: networking: switchdev:
 Update port parent ID section
Thread-Topic: [PATCH net-next v4 1/9] Documentation: networking: switchdev:
 Update port parent ID section
Thread-Index: AQHUwj11wPuvW3r12UmuI5DBpSCIDaXcFgSA
Date:   Tue, 12 Feb 2019 12:19:51 +0000
Message-ID: <20190212121949.GA13138@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
 <20190211191001.8623-2-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0030.eurprd06.prod.outlook.com
 (2603:10a6:203:68::16) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5507;6:qdjjrMex+iyg/3h+1LiF5Gwgg+ucbnwrBdka5wV/DRUyyWUlDOw8Izls9gB4KsZepVerRg/p5UiOPFDq+4YdCgEcjKhVCV6c+VXHYGKANl9m68uSEWcDkPMZ+LvtKu9vRe/UOAPEERaQqNuCyISve5E9heAld2JHkasGoI4RsJnm6NTjjad6Ozb7RMD1xxN3PV0NS1iq7VGeYQmiTFwztAy6R9zvc0foJ5ziq7SYHQBXSie2fS8Px/ixRlLWX0SUjAM2HpPBdnM7l8XKFN91cViwF9sZEMSHAtrSZx8KazPBywqZPwSUdi0dn1oJgxx42lJQkQbDOYSHeNVcCk0dokCDFvCeVpcAkwK33dYYciRvNWhVz8ZdHAA8cSnTqAFiRdjVjqB2UPyRNvSXP4eopH1MpRyTN7RNgajAGS2a+kep7zYKUSdQOVVF/+u/5x/XT5BRcip8kw6AqbvGuzykdw==;5:Ab3bnQdOHzsyWyjVD05wmgrX2V11ro/qQjiAKdg+IoE4oe6ifuG73DfBFOhCUtwU6Y5z0/N4OpedELVwn8hTLyIRQ6UsaSxx/V6nvUXnr7MxcfZtHPxMoYyubun7jQOVboV6H/IX4HPEHm/K3VcVndhH7t+nwu3hEC8D0C6zSUFvu6eJ6UYbZLv7/5T0aO8tWfhvRV5lnd1RPs7U83CDAQ==;7:1wauOX2d6c6dhzBcR6OqYGDY7+YObbyCiZaA3KXx3gaDl3lIVNQOyaTXcRph6/kPQtyjTmwmY29bqd4lUhRq3+CnYhXZEYPD4FK7QuEvPQr8Z3u1q4hsnVztCdu87o0oi2FVFu/Bs69dQ/elR7CLRQ==
x-ms-office365-filtering-correlation-id: 9711d989-d256-4b4f-6218-08d690e462f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5507;
x-ms-traffictypediagnostic: AM6PR05MB5507:
x-microsoft-antispam-prvs: <AM6PR05MB5507CAD4A05C9781E5135634BF650@AM6PR05MB5507.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(33656002)(386003)(6506007)(99286004)(8676002)(4744005)(81156014)(81166006)(446003)(316002)(476003)(486006)(6486002)(14444005)(71200400001)(71190400001)(53936002)(102836004)(11346002)(106356001)(14454004)(105586002)(256004)(15650500001)(6436002)(25786009)(1076003)(9686003)(33716001)(6512007)(6246003)(68736007)(86362001)(97736004)(66066001)(2906002)(76176011)(186003)(54906003)(52116002)(26005)(7736002)(305945005)(33896004)(229853002)(478600001)(4326008)(6916009)(8936002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5507;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J3eG126obxOjJwIMrvR3oI8a+xAOzhNtcVweaReTC4/wrSVQP0Vrh9/uIy+adWb3lYgn8I12ulf/RHqr65YKynY7UtNdG77qB93wZIlmjKav9ofLHvl6CgrH+7dfuqyj06ZASgVlPBr3wwCSNu4lMkuYVbDOJG5ISbAJyGNPUWNAFtx3l42lhu8z6eiCvWa+ali6+Kb5muu7czPk8etJEHOdJt49Hwl6p/tK1tHGpIQbh9BW3YU9FhkMQ/Rrr3WotIGD+H9nJxhEoCrYcR7psc0IWAdmGLJ1MN7SZl5a2Uit4ktg0PZZrTMulOyaEqMpAia1Pd+5duJSrryhjjjqLplGPqoEupvRbNkWnilfQvd2gfAWjDBZjt+0X0CbUK535v+VIiMml7WPN3RmUX6mzCEVyU91onPqMAwjjR8c40g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14994EC13F27AD4B937AB755CEE199C3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9711d989-d256-4b4f-6218-08d690e462f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:19:50.4970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:09:53AM -0800, Florian Fainelli wrote:
> Update the section about switchdev drivers having to implement a
> switchdev_port_attr_get() function to return
> SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
> commit bccb30254a4a ("net: Get rid of
> SWITCHDEV_ATTR_ID_PORT_PARENT_ID").
>=20
> Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
