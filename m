Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D4C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4562020868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Oe8dzJ8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfAWBd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:33:59 -0500
Received: from mail-eopbgr800122.outbound.protection.outlook.com ([40.107.80.122]:30022
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfAWBd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNL2w/my1u4pUB21oqqtUaFo9SwxMVu5/7+w/koSO88=;
 b=Oe8dzJ8svmNvsE2ptk/F7tI7NwCRCmmW8gqMnJgBgvLupm6D5VBKV0VHwGgvhrNqbMfziGPnCgms6YAjWiiK9e3UQff1QQ4yFKT2xIaRk9T+E6raIh7cWK8UnAE7iDLMPCl05wC9vXSmCl+ApIWJgkSwXDiv1yxSpYKyRZH9/xk=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1287.namprd22.prod.outlook.com (10.171.216.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 01:33:53 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e%7]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 01:33:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v1 00/11] MIPS: ath79: move towards proper OF support
Thread-Topic: [PATCH v1 00/11] MIPS: ath79: move towards proper OF support
Thread-Index: AQHUqbk0Ej4bV0JclkWslPsx18q2iaW8I/CA
Date:   Wed, 23 Jan 2019 01:33:53 +0000
Message-ID: <CY4PR2201MB1272251B8C9F4235284FFB4AC1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
In-Reply-To: <20190111142240.10908-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1287;6:KQ/FrcZkHvHrtDi4OlaHYFzgqxeOm6otcnyeNot3nQ/SsM1Q5SeaXgK+YDxCPrUwrYFvo3q6n7Bo+Mznkdj5Lq4BJg7WrM9OoeG8aDl6FXb3gE7nWby61/T0kwxTWa1VZDRyNc9XLtGE0nkEGXvQ98Kb8ph5Og7QX6yqvzTnS6f1mVN4cv1B1qwDUya/XQebTdxDrLAAjsI2dErxe2sqRx5E3e0kYbIz4ox01QxklIKyYhot/McAl8OPqYJb0tvitB/cGHh3TNUzlchaCWipoHnbcSRMgbesfNxYMbnGXH0meU0Oq1HmX0ZUFOI+Lz0aObNJk7cBxb7OfhzF4aEqMBI23otfC+WK4BOH1MjoXKExWaDcoRm9rf1HF/xFmj03100+mbt0VaHgqG71Le78FAkJjAebY8qT9rcD/qcoTgIPR+bxPeESFO77hr/XreVWHmbmQf31HJRGLExtdIZlhQ==;5:eDzKKxdPlJMFsSolnm7aC8pV45je9G3bgM3YhtilgZVLs1xF5ugJNBHhZxPxh+fWukXFTKttmCBO19yxcMzID7fATURAvPzmsq9pjK1ohFNfaVijmRsfutYIW7Ybwhd8rncMo9pskgAQWqKfh3vIWPxKntWmZItuu3I4QMCBBjCWuUxLegBvtbGVsUZ38KY0dOdcIpq3xWn0ooiiH9vo9A==;7:DSqqmxvTmNOBbUVkxpIC4P419Vxlcfi8/Guzltde6TbQhczdReKcLWSWUieOl6zRsmYVSy6sT9X1LSaP53S0xkbiGIeZRcf4qVIibGCcKQBsMwvWziEzRAu4Qr7X5tV9w/nXRv0FY1edUyYn203UZQ==
x-ms-office365-filtering-correlation-id: 27f7759b-e79a-4244-b0b9-08d680d2d53f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1287;
x-ms-traffictypediagnostic: CY4PR2201MB1287:
x-microsoft-antispam-prvs: <CY4PR2201MB128787713E600860630442CFC1990@CY4PR2201MB1287.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(189003)(199004)(11346002)(478600001)(102836004)(8676002)(386003)(26005)(7416002)(25786009)(97736004)(316002)(81166006)(8936002)(186003)(81156014)(14454004)(6916009)(229853002)(7736002)(71200400001)(71190400001)(6506007)(305945005)(6246003)(446003)(2906002)(33656002)(476003)(53936002)(44832011)(74316002)(486006)(4326008)(52116002)(7696005)(105586002)(6436002)(106356001)(99286004)(9686003)(76176011)(66066001)(3846002)(55016002)(256004)(68736007)(54906003)(42882007)(14444005)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1287;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5kWVXmOKtivDTymv5h1sHohP6tR49O4RVFl00TRectsqrdChdYnOnAGjRGNp4gjLEvs4X+e60u0iXmSpzslA1ggQTTSG9dHIKLaMZHT+PMS8Gq3F94V07uRTNKZsBsv/aGi7N52VR73MaJ0v6Vk2sa3bjhTgwFHaFG3uM34pgYy7MEhon+zJ3mHk6hhV4eDr3VgLoww5MSHM7OQMIO67f0GJIkqjZC8lrbyqJlgnBi9BLTCEybKhvldwSTIHao3pH+L1EdvRkyRyjQ5N9+Pbb+Xokh/A/BcubThccIwGmUyWPGL4Bzfzl34vlPtb4L2QazAHWMb8qxZcN2O1/zW1IPFBd4AKSJYGEmwdaEJT68x3lInU9iBtq6Ob6/NlTfqpQ9Nu7Gu/c3Mp/o3oeywEPqzmP+Ty9xsPNcPV8AL1CF8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f7759b-e79a-4244-b0b9-08d680d2d53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 01:33:52.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Oleksij Rempel wrote:
> This patches are take from OpenWRT, rebased and tested with kernel
> v5.0-rt1 on DPTechnics DPT-Module (Atheros AR9331) by me.
>=20
> Since one dt-bindings header is touched, I added DT maintainers to the
> TO/CC.
>=20
> Felix Fietkau (6):
> MIPS: ath79: add helpers for setting clocks and expose the ref clock
> MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc
> init
> MIPS: ath79: pass PLL base to clock init functions
> MIPS: ath79: make specifying the reference clock in DT optional
> MIPS: ath79: support setting up clock via DT on all SoC types
> MIPS: ath79: export switch MDIO reference clock
>=20
> John Crispin (5):
> MIPS: ath79: drop legacy IRQ code
> MIPS: ath79: drop machfiles
> MIPS: ath79: drop legacy pci code
> MIPS: ath79: drop platform device registration code
> MIPS: ath79: drop !OF clock code
>=20
> arch/mips/Kconfig                        |   1 -
> arch/mips/ath79/Kconfig                  |  73 -----
> arch/mips/ath79/Makefile                 |  23 +-
> arch/mips/ath79/clock.c                  | 342 ++++++++++-------------
> arch/mips/ath79/common.h                 |   5 -
> arch/mips/ath79/dev-common.c             | 159 -----------
> arch/mips/ath79/dev-common.h             |  18 --
> arch/mips/ath79/dev-gpio-buttons.c       |  56 ----
> arch/mips/ath79/dev-gpio-buttons.h       |  23 --
> arch/mips/ath79/dev-leds-gpio.c          |  54 ----
> arch/mips/ath79/dev-leds-gpio.h          |  21 --
> arch/mips/ath79/dev-spi.c                |  38 ---
> arch/mips/ath79/dev-spi.h                |  22 --
> arch/mips/ath79/dev-usb.c                | 242 ----------------
> arch/mips/ath79/dev-usb.h                |  17 --
> arch/mips/ath79/dev-wmac.c               | 155 ----------
> arch/mips/ath79/dev-wmac.h               |  17 --
> arch/mips/ath79/irq.c                    | 169 -----------
> arch/mips/ath79/mach-ap121.c             |  92 ------
> arch/mips/ath79/mach-ap136.c             | 156 -----------
> arch/mips/ath79/mach-ap81.c              | 100 -------
> arch/mips/ath79/mach-db120.c             | 136 ---------
> arch/mips/ath79/mach-pb44.c              | 128 ---------
> arch/mips/ath79/mach-ubnt-xm.c           | 126 ---------
> arch/mips/ath79/machtypes.h              |  28 --
> arch/mips/ath79/pci.c                    | 273 ------------------
> arch/mips/ath79/pci.h                    |  35 ---
> arch/mips/ath79/setup.c                  |  78 +-----
> arch/mips/include/asm/mach-ath79/ath79.h |   4 -
> arch/mips/pci/Makefile                   |   1 +
> arch/mips/pci/fixup-ath79.c              |  21 ++
> include/dt-bindings/clock/ath79-clk.h    |   4 +-
> 32 files changed, 185 insertions(+), 2432 deletions(-)
> delete mode 100644 arch/mips/ath79/dev-common.c
> delete mode 100644 arch/mips/ath79/dev-common.h
> delete mode 100644 arch/mips/ath79/dev-gpio-buttons.c
> delete mode 100644 arch/mips/ath79/dev-gpio-buttons.h
> delete mode 100644 arch/mips/ath79/dev-leds-gpio.c
> delete mode 100644 arch/mips/ath79/dev-leds-gpio.h
> delete mode 100644 arch/mips/ath79/dev-spi.c
> delete mode 100644 arch/mips/ath79/dev-spi.h
> delete mode 100644 arch/mips/ath79/dev-usb.c
> delete mode 100644 arch/mips/ath79/dev-usb.h
> delete mode 100644 arch/mips/ath79/dev-wmac.c
> delete mode 100644 arch/mips/ath79/dev-wmac.h
> delete mode 100644 arch/mips/ath79/irq.c
> delete mode 100644 arch/mips/ath79/mach-ap121.c
> delete mode 100644 arch/mips/ath79/mach-ap136.c
> delete mode 100644 arch/mips/ath79/mach-ap81.c
> delete mode 100644 arch/mips/ath79/mach-db120.c
> delete mode 100644 arch/mips/ath79/mach-pb44.c
> delete mode 100644 arch/mips/ath79/mach-ubnt-xm.c
> delete mode 100644 arch/mips/ath79/machtypes.h
> delete mode 100644 arch/mips/ath79/pci.c
> delete mode 100644 arch/mips/ath79/pci.h
> create mode 100644 arch/mips/pci/fixup-ath79.c

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
