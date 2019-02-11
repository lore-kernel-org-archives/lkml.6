Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2BFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025482081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XSJ62TRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfBKVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:40:49 -0500
Received: from mail-eopbgr150089.outbound.protection.outlook.com ([40.107.15.89]:41328
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbfBKVks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMXcoMtY4tfRD+KIYYini9vBDpBrUAnADMOFbEeoq5I=;
 b=XSJ62TRfDSl3xtQXnI02rGJJ6H3KjZ8/eoU6dpqQjUfS37i/wsieoIjLaWhrAp4/WDDXED11lFW0RNe/344oDTNl4bh9aAIeNC4wX4UMTwB2n+dRcriLSMfyUFjpFgOeq+oMVvsEIxhLI9MHgbCw0DNrbNBP4kIK8XOD+TK8xvs=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6518.eurprd05.prod.outlook.com (20.179.7.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 11 Feb 2019 21:40:45 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 21:40:45 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     David Miller <davem@davemloft.net>
CC:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
Subject: Re: [PATCH net-next v4 0/9] net: Remove switchdev_ops
Thread-Topic: [PATCH net-next v4 0/9] net: Remove switchdev_ops
Thread-Index: AQHUwj1zxqFH0ZbG6U+8BvdVKYhXX6XbCP6AgAAXY4A=
Date:   Mon, 11 Feb 2019 21:40:44 +0000
Message-ID: <20190211214039.GA4947@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
 <20190211.121657.2204380606625115977.davem@davemloft.net>
In-Reply-To: <20190211.121657.2204380606625115977.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0406.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::34) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [79.176.7.115]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB6518;6:gWkVTD/dBaVXBP5l0LMTp8hJsCwqaO9k4Wxoxer7clu9nHcow9Ja6sg7qLbkLtGcsqG7rEgPzS3/QUUmCZmeN+/DAEFKPHX2Q5aDHi5xDkI/cf/c4OuPAHL3ToO44d1iV+RPnAFjD7JsU4gBKgwzUzsjUTlJkAOu3Mnk4/8+IHWaxqQ2yMaMXRzTFm4+5ZnUNjrjw5e7g9pMRH3jQafcGf4l4RihmCBR77uI1UTPp6Hl9OUwK8meXL1T9YeJunqEStveJU4AVddQZtgiViQlcS355JkkPVC3479z7YcxvvxmQK40b+LkqR6RVTjK584QAl5X+GabyRE+QmuDUKmDjfS7yTcs/U4WlF+EWN0FMMkxjBdmyzDKiynP72Slpi6ssw19m7Gs+kGzCpiZPbdIm0E7e6/wKVS+ZthkOC4t1XypPuV8CEW9XcS2m21omtYFpV6zq6usnJQB5j4F8M924w==;5:ocTaK45SE3+rFteHq2+FJaAJJ0L52AoTX80dE+xIZdIR+ethWPAsJJEdtqL/KhJaGG3H7u5i0sWTwcyIv/5wmZBOI4uxeYTjbtyzDaZC304emWOMb8hwgpnB8O3WOXVFcZq6oHClJvzY1bBO5TFlX1R4QD3Diq06GevdcUJGwhRsLdcktY24r1lbtwbd3PODyjqE7XMPnpvOGOODahd2Iw==;7:6Nebpwj7V0BS1Ij8uzKc9yRU1QiejxDHhgfLYYI5WcnsFfJ51nyV5YzhQw9WHC5FqhObA+rmrwq6zjyOtGQCKXc2yhXhu0yHwh6/ptN45rPfWU/8QBgc+YYIoOhR9smVrhoEJASgmOrGavSC1MaYyg==
x-ms-office365-filtering-correlation-id: 65c331c5-8c91-4276-e334-08d6906993eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6518;
x-ms-traffictypediagnostic: AM6PR05MB6518:
x-microsoft-antispam-prvs: <AM6PR05MB6518A39949A9EA84526F97E9BF640@AM6PR05MB6518.eurprd05.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(386003)(6506007)(4326008)(478600001)(486006)(14454004)(26005)(106356001)(71200400001)(9686003)(6512007)(186003)(6116002)(53936002)(3846002)(71190400001)(8936002)(6916009)(66066001)(256004)(33716001)(68736007)(6486002)(6436002)(6246003)(476003)(8676002)(229853002)(86362001)(52116002)(305945005)(54906003)(102836004)(4744005)(97736004)(105586002)(33656002)(446003)(11346002)(99286004)(33896004)(2906002)(7736002)(76176011)(25786009)(316002)(81166006)(1076003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6518;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oF/44Z0bEoAR9rvRuaoXUeY89OQYXBDcjDzGk8ul1o2PQ+Xc9XGAKJO+gnauG34MtdX/aajNNXkGvm6OhWs232YxynEiKG72GwW8DlEmIS8E7SS8ckfDwWzHbHgTXsC2hxCpdcgwC5CERKtUIAQo8OD7thcfOWUJh33MicQsakdtgnXFEIxjJoSPFY+7hk2tDNcrzc17zvl9kNBjlJ/Tf94aM1jf1RdfQd0Ysf+UconlcnDMryDt+UJZK2c26oOl3X8AUzJXbGj5RFvi72BqALhFLrf7LtYYVnGaQihEbbjy/0LDDzMXsr5bogNyOnaBLd6C+DXafcJmEwIC5bOk1q5CBFlRfghMNsWcBJpLPUSdmk72BOlXDhLBskcbFAoRBM0mrwtpDBnVpey7k2cH9LdZmUCbsn76VP8FCvy7eew=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A59CAE415BE5F943B2174DFFA1A0595D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c331c5-8c91-4276-e334-08d6906993eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 21:40:44.4857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:16:57PM -0800, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Mon, 11 Feb 2019 11:09:52 -0800
>=20
> > David, I would like to get Ido's feedback on this to make sure I did no=
t
> > miss something, thank you!
>=20
> Ok, Ido please look at this when you can.

Will review tomorrow. I was occupied with other stuff last couple of
days. Sorry
