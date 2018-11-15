Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B706C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCA3208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vOmpGsXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCA3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbeKPEPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:15:37 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:10243 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKPEPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:15:37 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="23189118"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 15 Nov 2018 11:06:45 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 15 Nov 2018 11:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWfef/xC8Z2IlQuIcIiB5TSeYjMgSc7kCoivPjLVE0k=;
 b=vOmpGsXnJYYIHtJjNGuRXCq0fWDVxCqQXUUqVaotcupl8QYXHPN4iPDsTeF72iRstgVI2F8QZWUHFpAjGaEfBhyUwV+25SPUqRtzzLKPux7J3LQJVZ1PJAz5UlQXHP20dphOgS3MwEx3+d5qCM1YeoaO5x2ZjRNUaRTnYA7U9XE=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2164.namprd11.prod.outlook.com (10.174.112.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Thu, 15 Nov 2018 18:06:40 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::f5d4:4591:7e11:d6af]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::f5d4:4591:7e11:d6af%3]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 18:06:40 +0000
From:   <Woojung.Huh@microchip.com>
To:     <ben.dooks@codethink.co.uk>, <netdev@vger.kernel.org>
CC:     <oneukum@suse.com>, <davem@davemloft.net>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <steve.glendinning@shawell.net>,
        <linux-kernel@lists.codethink.co.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: SMSC95xx driver updates (round 1)
Thread-Topic: SMSC95xx driver updates (round 1)
Thread-Index: AQHUfBBaSQgglam0NkS355RoguHeTKVRIugg
Date:   Thu, 15 Nov 2018 18:06:40 +0000
Message-ID: <BN6PR1101MB213051FC6843BE3B1973AD93E7DC0@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [110.170.235.6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2164;6:LDmR3XO1CEYiFMnhFuNQNf1FpBtW7BbYO//9VKzuGw77SvTbKXpflXoUn54SxeZw1HOkPUYVNjRZfb+hwAT0vfHXv/pody2fX/XkEMFNhiURDDaIc45aCT3lNT0NynkGub2QpeWpGjgUHB8btiZe96AxdC630L2kchBtfodo4zJC97l2LqKoc7s37gbOerWkC3CB3FYRHgK/0JWZllMuygtZ5dcPnir9vubMp8YbJh44kBYSGWRXpPXWWUSx58o6DX9m10X91wL0g6dMbJ9ii7I0w1Nz2lc2+9P5O5y510072PLjoMwIWXOu6o0AW3wn6f2Ntd86VoJmsGkGYSypylIhWkBKwq4Kt+4QqC5tmausat4bVDVqmLiPFovsqO0b7tFoj2BBc9bdfxkFi3fwkr530/FA9YiZ6DAuBwfC0bbnYKVliFZmqEvO429mpQHZ/L/KnFlnx3FKD+Z8vBB6nQ==;5:y9H1XA7P0bzeHcgQOUvpiv9DM2cEAnS9Hs6YHxTDE4MkX+R+F3Co5Aa2GmFO6U3VSTMw5gwiZLstFQKcZZ693uHwd+D/3mYcHmQDLvBVn3bzh2ecLFfWxFnt80wiAWpPFb6ml6PzXE0hTZGAQua36drtWOIrZPDsY+oz/dzF1Qw=;7:h2WtA2vvR4iv81BPBSrrIC1vHpXNBSeAuKpK96stkvqVKAQ0JoD6VZWYJCNnYkeoBdYRarObJYI4IyIbY565hOEKs15PAQvDaqfc2Opmhjzz3tjWJQ0x5ZYJVOImH8T5nAjihkvInc1HhDcDKJ6GVw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bfce1f5d-9e02-4254-7bc5-08d64b2517e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2164;
x-ms-traffictypediagnostic: BN6PR1101MB2164:
x-ld-processed: 3f4057f3-b418-4d4e-ba84-d55b4e897d88,ExtAddr
x-microsoft-antispam-prvs: <BN6PR1101MB2164454EE5A01D755365DF93E7DC0@BN6PR1101MB2164.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2164;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2164;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(13464003)(189003)(199004)(229853002)(55236004)(53936002)(102836004)(8676002)(54906003)(105586002)(110136005)(76176011)(6436002)(86362001)(5660300001)(9686003)(7696005)(53546011)(6506007)(99286004)(316002)(8936002)(55016002)(74316002)(25786009)(81166006)(14454004)(4326008)(97736004)(81156014)(68736007)(106356001)(6246003)(26005)(114624004)(107886003)(7736002)(72206003)(71200400001)(71190400001)(66066001)(15650500001)(305945005)(2906002)(186003)(33656002)(478600001)(3846002)(11346002)(6116002)(446003)(476003)(2501003)(486006)(256004)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2164;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v+AmFq1ijWlwK9IWshWXyPo2BTILg3LNW7pC8vZAYfyLB3e4RY7JuLer504pAUkMorqI7mY1T13i95YJHGeAnXGtIb+QK6zwVDZzkH4PTSnHfP7FLerff2LJYfRdwaIDBc97/ZEkzX11PnyaAVVnD4pkAPEb3Xpf4cQvdQ6PmTexFFPIvYUFUK/Zg9UaCMDJH6EymwdQcJYqMzxUkIOZZem5gNCanbu91xpewDdWT1lPEhPqApscajLCagADabbCO6f3AhMoHIjwm1MpXfUKvjJXRgVIh9UXRl2gGfkVVpPgmswXyLbNOvUbmmYrnOcrGiKYHZY6xc+BYzYFOEsotzPVBui2zi+syR1/79+wxD4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bfce1f5d-9e02-4254-7bc5-08d64b2517e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 18:06:40.4857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2164
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> -----Original Message-----
> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On Beha=
lf Of Ben Dooks
> Sent: Wednesday, November 14, 2018 6:50 AM
> To: netdev@vger.kernel.org
> Cc: oneukum@suse.com; davem@davemloft.net; linux-usb@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; steve.glendinning@shawell.net; linux-kernel@lists=
.codethink.co.uk
> Subject: SMSC95xx driver updates (round 1)
>=20
> This is a series of a few driver cleanups and some fixups of the code
> for the SMSC95XX driver. There have been a few reviews, and the issues
> have been fixed so this should be ready for merging.
>=20
> I will work on the tx-alignment and the other bits of usbnet changes
> and produce at least two more patch series for this later.

Some reason, maintainer email of UNGLinuxDriver@microchip.com is NOT includ=
ed in CC.
Please add it in following patch series you are creating to have a chance t=
o review by
proper reviewers.

USB SMSC95XX ETHERNET DRIVER
M:	Steve Glendinning <steve.glendinning@shawell.net>
M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
L:	netdev@vger.kernel.org
S:	Maintained
F:	drivers/net/usb/smsc95xx.*

Best Regards,
Woojung
