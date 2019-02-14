Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78156222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="PUgJQkRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395350AbfBNK6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:58:18 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:35042
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729628AbfBNK6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLTIyUEjqCv52rT0cLC0y8mSKIdm1H8zAxPeuHxp5SM=;
 b=PUgJQkRLYOcP71dD9W9zSmXLO9EZ+0zj4l1o4kL30IJ5RGXfBGObBUXkUMYtuL5IkNdXDMfHWLasBWdvXCHt9y1yTju+cmEll009Rp+/JYYSb2G7pFFkVkFADEz6+OP3KTOdYZ5PwQedL/auL18EcadEQSNi23VVL/hPiTl8xbk=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6389.eurprd05.prod.outlook.com (20.179.6.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 10:58:14 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 10:58:14 +0000
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
Subject: Re: [PATCH net-next 1/9] Documentation: networking: switchdev: Update
 port parent ID section
Thread-Topic: [PATCH net-next 1/9] Documentation: networking: switchdev:
 Update port parent ID section
Thread-Index: AQHUw+h92CuJ537fXkGD8lJ6Z26G06XfIIiA
Date:   Thu, 14 Feb 2019 10:58:14 +0000
Message-ID: <20190214105811.GA8066@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
 <20190213220638.1552-2-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ade232e6-5e62-401a-9174-08d6926b512a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6389;
x-ms-traffictypediagnostic: AM6PR05MB6389:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR05MB6389;23:B8v/+qK4Jmj4HmlgQoAuhzsjnJtoxk3KCHkNkPoiC?=
 =?us-ascii?Q?yXG8IIdtMP5bSbY0nBIc2Dcz7730z0QR+EYD+30aBu4LIgSzBGJdkkMVnr9P?=
 =?us-ascii?Q?JG7ETjBMAbXuBFOKCN8the+Bwuza31tYD4pvh9gh016ulHZS6pLseIlBzs3S?=
 =?us-ascii?Q?G8S7mHeuwe/b8PsvvvMzPTiUX8fuxppTcqfets88GXF6aNYpOwFAuwwuuDUy?=
 =?us-ascii?Q?ouFGZGoOWnejiWcL180HvUCZENgJ/enCvUjZfIBbccW/1XrKZIu9e5uuS10s?=
 =?us-ascii?Q?dDohFEatFCwENQYOhwsA7EeMrKjiI99/TFOGgUw6sIpEvNXsYA1qEzbz9C16?=
 =?us-ascii?Q?oDnJKkyWBG6aF3sWqQc6y7P6EvI0JUyS6Z6K6xFjcSzbokS3P7EIFNoldp5Z?=
 =?us-ascii?Q?rtGxupy7qFT/YHiU+maJJYzBtiEosBHlRy8i8VLiQMe9ASVGBcO+Cj6ry6TX?=
 =?us-ascii?Q?o/stRTEA9XS3bCHSWHnN1jOgtGu9EgK8x2fVbFnJ2Al6qaict74LXsdrsBdW?=
 =?us-ascii?Q?c7iO/AUDN3GCY1xHS7fx1U8C/ypdIBIRUFjDDL6f8zeyr2jbtVL1HpE3dJ4k?=
 =?us-ascii?Q?PSbUIp9CZH7SjrPOFIGY0GVq6JFHwqI7JWBJCBpbAbZtaM1ECj5vTWn5ZhUD?=
 =?us-ascii?Q?t+7RvuUwLuQpA4XaFf9Kgt7vkPDmvCVZ8Cy95ZlGcR7R+isNounqdnuPl1xb?=
 =?us-ascii?Q?io2NVXhN8dvfJkatSS6vsBT2PUtjH38wah12Sel4c0mg2T7YWR3yQQUh5qh5?=
 =?us-ascii?Q?shnYeuuZE3lm4vc1NFV832NJP35o8D8CTAw8vfSr1axGw5NO0cZK3lnsu4Jx?=
 =?us-ascii?Q?d/WbD+q55q3ljbOG2zoHwwEh0x6ItTjUCPKw1kxinTFGKvT5eCc0t8P+RkJ/?=
 =?us-ascii?Q?y72kvgCG6sazN16IyBwo0v0cmi+EikZWCDHVL3l881PwK9UDI6BJtgU9fbph?=
 =?us-ascii?Q?Qr3X5PZX3OH4YM/cbFssrRj4Mv7DiyhEJaW7urVFgzQpIDswWHrB5hNl/kup?=
 =?us-ascii?Q?P/XxplWMNzzD7teOxwQoPzHu8kXipbdH30jMiXfv0gJSreUuV5ASQyaH7FWe?=
 =?us-ascii?Q?I54NbhxDjZTE2qv0V6IaxtfUtGD6VLJRl5e5DOTMk3dco9trci8Rpc0N9Klq?=
 =?us-ascii?Q?nXR+/lcL1X2LYAUcvBfjMAWVwmhB26dh8zK7pl4pW0hGt70Ortv9VAxW0hh8?=
 =?us-ascii?Q?fVkBEW6h8K8HJL5YD0gNjkB4N77NNEvNg8w9+obCh7wbCr7Y0uAJghWthuBT?=
 =?us-ascii?Q?KEfRtEiblSLijutpNiPbLd45W5IDKXosPYo7K6TP4BsS/gFoJvcTyPvd0G5Y?=
 =?us-ascii?Q?j7acMvvFNr5SUZlPlqS8gU=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB63895CD5AC896FC8F9EF3C60BF670@AM6PR05MB6389.eurprd05.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(6436002)(6506007)(26005)(102836004)(105586002)(386003)(25786009)(6916009)(316002)(33656002)(6486002)(186003)(99286004)(66066001)(15650500001)(54906003)(6512007)(9686003)(33896004)(229853002)(6246003)(2906002)(81156014)(6116002)(4326008)(3846002)(53936002)(76176011)(14454004)(14444005)(97736004)(106356001)(7736002)(33716001)(52116002)(71200400001)(71190400001)(478600001)(1076003)(86362001)(446003)(8676002)(81166006)(4744005)(305945005)(476003)(68736007)(11346002)(8936002)(486006)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6389;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ztZCFdDzHpxbag4gU327Wg6CbGfMf6IItK3AkoQzC7eBJR4LP3FPDm6Y/ScOlN0InIhfHXgRCcvRKWshJIpkHejdfEhNgnD0MzqynyQa/af2OiucmMCDfHEmENrkqb64ASRRdmDQ7J06G7lzQ4thM+8DbMOvQYvhMAN3/9/4nI+f6eQzaSc7TEZeqGLI5o79eEALokQVEXx1+FaePECfMdINoL3s8dB+Fya4LIfu1/0tyGu9/wqGjdqB+ewleuTRWCt2iU+VgAinIewo1BhhoDuwN7YlwT0V7mibfeGJDav1EdgZPlv+gGDinAPCUdGpek5znWxmEKPHXmdjFfwPdcOBTId3j9lioqk1ApzIhUtzI9Klcpcov62sW2WemVq4SGWBv+xn5Tjc+zE/wneNhG0FBqLRFIrDf5qabO/vlB8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BED6534E47F51428BF58087B290D845@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade232e6-5e62-401a-9174-08d6926b512a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 10:58:13.8342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:06:30PM -0800, Florian Fainelli wrote:
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
