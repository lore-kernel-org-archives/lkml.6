Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7516C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2F420657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eO0JWB2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfAQHgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:36:35 -0500
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:15136
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730036AbfAQHgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luKRMKglQCS7fx8r4jYL1f29H69Jr2x9enVGcdIXla4=;
 b=eO0JWB2rczWx48aWhZbH1PUFTddXII1GMB/+8nLb1dVY0ipwNPz/GhcwrGfMMgjCgGmhS7G7cWpq3KUXqugc7WjmqpRkR/JbMBNvWumQzAHONUkJqKPoIdECRK/hu1E0Mr66afBfwvV04GEU7xVTFfhXsf9azkgnph6SXjkXr3g=
Received: from AM0PR04MB4788.eurprd04.prod.outlook.com (20.176.215.21) by
 AM0PR04MB5028.eurprd04.prod.outlook.com (20.177.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 17 Jan 2019 07:36:18 +0000
Received: from AM0PR04MB4788.eurprd04.prod.outlook.com
 ([fe80::ac51:7ff:ea6f:17c7]) by AM0PR04MB4788.eurprd04.prod.outlook.com
 ([fe80::ac51:7ff:ea6f:17c7%2]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 07:36:18 +0000
From:   Camelia Alexandra Groza <camelia.groza@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>, kernel test robot <lkp@intel.com>
CC:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "oss@buserror.net" <oss@buserror.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@01.org" <lkp@01.org>
Subject: RE: [net]  b8154ef682:
 WARNING:at_drivers/net/phy/phy_device.c:#phy_driver_register
Thread-Topic: [net]  b8154ef682:
 WARNING:at_drivers/net/phy/phy_device.c:#phy_driver_register
Thread-Index: AQHUrXnSihv6dEhp4E6y2VpqH2cjt6Wx50UAgAErXIA=
Date:   Thu, 17 Jan 2019 07:36:17 +0000
Message-ID: <AM0PR04MB4788C34E53855955E07ADB6AF2830@AM0PR04MB4788.eurprd04.prod.outlook.com>
References: <1547555719-13541-1-git-send-email-camelia.groza@nxp.com>
 <20190116085858.pfl4vuutel3b5kgb@inn2.lkp.intel.com>
 <20190116134058.GA24229@lunn.ch>
In-Reply-To: <20190116134058.GA24229@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=camelia.groza@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5028;6:ygBqdD79lirBS514uaG2TYRqhNvktaMZzcHAf7k4ems9zpHIHCaSFJdRVvUzz3wt8Rt4p/PVjR2ukaDtqszklWmgco7Y4ZujZB+r8FGKiJQPHbmD4f+Oqo2b5KHuNvbIlQrOVXHOeAOCGJu1Hq2G6F9ycOTcamS/jAwl5SeGB0Me5IgrvLzehViySfGSq9Key8IwK29o/9qWsq70WN5FJMPdev6vQ9+owHwrP5cw5qD1tT2/rm1Tdo5RIvM8cl2lqM4cfBPWaVV5d7s2a/5jm/dAkIEEOwBsMiVg471OMNDebwR6TbxX0UBRjiNHaCvwfAB6IMPatTFuU1HYpADnIkOez/Ez/dc4iV6KyVy9lfbmRBi/qMqxULG5pJleAHzt/F+kmN/ZLajwDuM/F9m3RTzzl9hGOa/laTL+6QucpFkzaVsJClYZ0Y0G5EOpOaVu5F8esv/PHr2F2m/q+swVZg==;5:MBlN23gkZRx5J8fxU/OhCe4vgB8X75O/LZZ2pSIpv17IxVnVVXEZ60dPfsnEbdGI9DpCSidyJ000YOheVL+otBQvEpT9B3tlt6dE17y7srBDpwsjeMdQIkuBKKbjv2b5HVTNZWrXT4CTRPZdg9HFJ9w2EpUlLGh0m4xre84HQ1sY2V5/v7CytqImTDbX00VnvngFdX1lErMrPt8FEiMmOA==;7:kVgB7v+6uwJmugZRDkQflFLxNlB5/1U2VvIf9pAGCSnhVWIckBgr9Zoy2SVzsE8iI57Kj5eYwP4t+vL3ubAlKffIMzWUTmNHhANcA9g0gz/2nxMIVoqq2dl6qACSr5UblFFRG+p4Cyx5m5v2+zQlCg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 18b46b82-dd96-44da-0e69-08d67c4e77eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5028;
x-ms-traffictypediagnostic: AM0PR04MB5028:
x-microsoft-antispam-prvs: <AM0PR04MB502851061A9B0E94EF246C20F2830@AM0PR04MB5028.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(199004)(189003)(69234005)(13464003)(86362001)(53936002)(9686003)(74316002)(14444005)(256004)(5660300001)(6246003)(478600001)(14454004)(966005)(4326008)(5024004)(97736004)(486006)(39060400002)(2906002)(71200400001)(71190400001)(6306002)(305945005)(7736002)(316002)(66066001)(102836004)(229853002)(33656002)(25786009)(54906003)(110136005)(26005)(186003)(53546011)(476003)(55016002)(68736007)(76176011)(7696005)(105586002)(81166006)(6506007)(106356001)(99286004)(3846002)(8936002)(11346002)(6116002)(8676002)(6436002)(81156014)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5028;H:AM0PR04MB4788.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N7sW0UJw+Jqk7agtPyAu5pBry3Mct2zS/9CDCCKaHk6DrOGEyr9US6lagaxRVOYGYuxylRHn4QBgKJiHk/zq5pp8P1mJFy9qD0jJ07qFPh4hKczF4UOFdX9xN94lEKLiEfMeY7gU2JK1182EqwENngdNt2pBHueDS49TVqd6KADvt/EqfB9ZUN25W853k4lMcv1scyXoA3uhAwI/xChn7OR4LhDB9p4pWAg5RHznzywVNHnMZhjl9iFIadSG2H079uTjrtCx17d3T5XpOBB+jPuxtcQ4YXRRFBYaMQlCcuj8fQzjiBwfeaHVL9TueSnzenGTQKgyRpTVfvHCTZrNzOLI130JYtY1i4k1ACp7QczOEMMGL9Cfszrc/Toky2soRHL0vOHV2R8en2KUnJtQMsE5b9KRstSmuw28P3xScVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b46b82-dd96-44da-0e69-08d67c4e77eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 07:36:17.9849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, January 16, 2019 15:41
> To: kernel test robot <lkp@intel.com>
> Cc: Camelia Alexandra Groza <camelia.groza@nxp.com>;
> f.fainelli@gmail.com; hkallweit1@gmail.com; davem@davemloft.net;
> oss@buserror.net; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> lkp@01.org
> Subject: Re: [net] b8154ef682:
> WARNING:at_drivers/net/phy/phy_device.c:#phy_driver_register
>=20
> On Wed, Jan 16, 2019 at 04:58:58PM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: b8154ef682a9a745880ecbb2ee26b16297c9bfd0 ("[PATCH net] net:
> phy: phy driver features are mandatory")
> > url: https://github.com/0day-ci/linux/commits/Camelia-Groza/net-phy-phy=
-driver-features-are-mandatory/20190116-004308
> >
> >
> > in testcase: trinity
> > with following parameters:
> >
> > 	runtime: 300s
> >
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >
> >
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2
> -m 512M
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> >
> >
> > +--------------------------------------------------------------+-------=
-----+------------
> +
> > |                                                              | 2f960b=
d056 | b8154ef682 |
> > +--------------------------------------------------------------+-------=
-----+------------
> +
> > | boot_successes                                               | 45    =
     | 0          |
> > | boot_failures                                                | 1     =
     | 4          |
> > | BUG:kernel_timeout_in_torture_test_stage                     | 1     =
     |            |
> > | WARNING:at_drivers/net/phy/phy_device.c:#phy_driver_register | 0
> | 4          |
> > | EIP:phy_driver_register                                      | 0     =
     | 4          |
> > +--------------------------------------------------------------+-------=
-----+------------
> +
> >
> >
> >
> > [  458.251512] WARNING: CPU: 0 PID: 1 at
> drivers/net/phy/phy_device.c:2246 phy_driver_register+0x90/0xe0
> > [  458.260864] CPU: 0 PID: 1 Comm: swapper Tainted: G                T =
4.20.0-
> 11080-gb8154ef6 #158
> > [  458.260864] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1 04/01/2014
> > [  458.260864] EIP: phy_driver_register+0x90/0xe0
> > [  458.260864] Code: 5d 89 7b 08 89 03 89 d8 c7 43 14 02 00 00 00 e8 06=
 d3 e1
> ff 85 c0 89 c6 75 39 83 c4 0c 89 f0 5b 5e 5f 5d c3 8d b6 00 00 00 00 <0f>=
 0b b8 38
> 5b 2e 5e c7 04 24 00 00 00 00 31 c9 ba 01 00 00 00 be
> > [  458.260864] EAX: 5e2e5b50 EBX: 5e1a8fe0 ECX: 00000000 EDX: 00000001
> > [  458.260864] ESI: 00000000 EDI: 00000000 EBP: 4010defc ESP: 4010dee4
> > [  458.260864] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS:
> 00210246
> > [  458.260864] CR0: 80050033 CR2: 00000000 CR3: 1e43a000 CR4: 000006b0
> > [  458.260864] Call Trace:
> > [  458.260864]  ? phy_drivers_register+0x37/0x90
> > [  458.260864]  ? phy_module_init+0x1b/0x1b
> > [  458.260864]  ? phy_module_init+0x19/0x1b
> > [  458.260864]  ? do_one_initcall+0xd9/0x24b
>=20
> Hi Camelia
>=20
> I think we need to extend your patch and print the name of the PHY
> which is missing the features pointer. I don't see anything here which
> allows me to determine which PHY caused the warning.

Hi

Sure, I'll send a v2.

Camelia
