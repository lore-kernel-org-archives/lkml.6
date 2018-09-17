Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7718DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A938214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aM1gA7Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A938214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbeIQIaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:14 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:30720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728467AbeIQIaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKaA7yf5iFKhVip937Dnk0AfEJeQjV8UwGpmz8heHA0=;
 b=aM1gA7XyN6ttWGIBKHDDKahWuywZ8XhWBt7zTtL1WfZbBYD0X3rGAW2mY9vOJ+4k3XUIxWViTOk3Q+VEJcJz4b+NfejzzlaW+Co2EViKr/QTbOJ6PkOGyvQ+hx3dDRdOmZpyhCk5JpimTFVpHl+4qAMR60D+iuQ3m5S/ImikuXM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brandon Maier <brandon.maier@rockwellcollins.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 62/87] net: phy: xgmiitorgmii: Check phy_driver
 ready before accessing
Thread-Topic: [PATCH AUTOSEL 4.14 62/87] net: phy: xgmiitorgmii: Check
 phy_driver ready before accessing
Thread-Index: AQHUTjLza43vwl6Zok2g5TWhWlJiNA==
Date:   Mon, 17 Sep 2018 03:03:04 +0000
Message-ID: <20180917030220.245686-62-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:39viEfwAd+7cyTrR4EcRffNCDa/HmFZ3IUKsEfdUmQjluU8Nwk2JCCsA/VEx3f8xM5wgRiNOGKdUltu+1wlyGuADPp8BQY4CujxkAT9ORGDVNsPr/+8d6zlGxjtR3QReP6JWwOAVrJmPBRL5WqqEFX6s4tDKxhEILVlurcCYnlgX2fl57SjVNAhvoMZl5erbOY/Fpf9NwYbwyQ/VeJsn5LdoSe9PAKKLMSfp/SjOMFQsNB1QmvRVP+GhdBSz7vmYsAh6ikiV3f76ZIcfvkM200QfrLW3+WNq6LH5BPq1W6fcG5z4/eFpu7Uw75DtqgUfqQBW2lUfVYqo5dQNY1VIuBgTDQ1aYXCFdUqbkdv4RqrJX8dP1hFyRAR12mwOH8rK8MRC4PiFnXwJlKbrpZBaSjuFc0IIqKrzhIPplSx092nZbMVK67PhZDTt9uMILALg76Q0uzXM8rL9DrOBfQIGcw==;5:7G79Sov5x1g3mnudFasXjs4s08TbmT3CYaZJAdkfybm8d+MNafLD5hCHKKbqVCo/b97xZVzSHoDpJGPtSOoW4uXf+dVZCVhWxbe12syj7kEYYTKaX8zjQtrQhPlB0Q7F6nVUDGWVhgPf9njaNCEUEy6cg+TiY8Znc2wx+YL7jWQ=;7:diIY04fI2a3Zwoif8EqOl7bM5hGTsNGwUNyZ2gQNETM58xDKKDyKOtZH8F3ZkkcM6768Wle1JgcWTDO9xUNCF/CFred7nTjBPlmMat8/Oh41hKe+/cP0DvwvsY8Hkb3CNaHUPcN8x2lsqXDWUB9K6acNIhg2okQhIDVCZtwF2kmiqMkf9HtjRuOzEztbEcrGc7FPjE3Z90wnQQwRciA2b+voW/c/wNvGaWnMekpzbUFeditSTTVD+SWCB3dbz81O
x-ms-office365-filtering-correlation-id: 1a5ec1f5-7b0b-4e57-8ee8-08d61c4a57dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774C0FFF66997610E76B54DFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(5024004)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: /7TVzZg8gksPNCTH4Lru7w1NcVEuVyssdFYlzUjrtgv0vhGQyZvZz2v+qLRivk2WGF4TvXGDfcfyiy1X/b73NgR5eo2O3Vo2uGWj8SxAroAlBQt9G4BAH7TjoqYyCKeoE4gMAVTvj3IUyKIgB4QZY0Xhr8CknLyNfr2dkMrwvMnN4wTrvzHdneqCSNDvHctCjX+E2j41zSS+y5hicx42q8qAYgJtSTaUGGBCYds5eI/Qrq36M4WdxLoXAPcFIBhv8KJsAOJ9IhFgogWrR0B/PQzDx1KL7jvdDdTkgT0bGAkTqgNqg9JzK1YnVY213/bYX/yuaJmFYqh7BUh5KOUGmI0ji1weZW3ONqtaHSZ4MM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5ec1f5-7b0b-4e57-8ee8-08d61c4a57dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:04.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Maier <brandon.maier@rockwellcollins.com>

[ Upstream commit ab4e6ee578e88a659938db8fbf33720bc048d29c ]

Since a phy_device is added to the global mdio_bus list during
phy_device_register(), but a phy_device's phy_driver doesn't get
attached until phy_probe(). It's possible of_phy_find_device() in
xgmiitorgmii will return a valid phy with a NULL phy_driver. Leading to
a NULL pointer access during the memcpy().

Fixes this Oops:

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.40 #1
Hardware name: Xilinx Zynq Platform
task: ce4c8d00 task.stack: ce4ca000
PC is at memcpy+0x48/0x330
LR is at xgmiitorgmii_probe+0x90/0xe8
pc : [<c074bc68>]    lr : [<c0529548>]    psr: 20000013
sp : ce4cbb54  ip : 00000000  fp : ce4cbb8c
r10: 00000000  r9 : 00000000  r8 : c0c49178
r7 : 00000000  r6 : cdc14718  r5 : ce762800  r4 : cdc14710
r3 : 00000000  r2 : 00000054  r1 : 00000000  r0 : cdc14718
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 18c5387d  Table: 0000404a  DAC: 00000051
Process swapper/0 (pid: 1, stack limit =3D 0xce4ca210)
...
[<c074bc68>] (memcpy) from [<c0529548>] (xgmiitorgmii_probe+0x90/0xe8)
[<c0529548>] (xgmiitorgmii_probe) from [<c0526a94>] (mdio_probe+0x28/0x34)
[<c0526a94>] (mdio_probe) from [<c04db98c>] (driver_probe_device+0x254/0x41=
4)
[<c04db98c>] (driver_probe_device) from [<c04dbd58>] (__device_attach_drive=
r+0xac/0x10c)
[<c04dbd58>] (__device_attach_driver) from [<c04d96f4>] (bus_for_each_drv+0=
x84/0xc8)
[<c04d96f4>] (bus_for_each_drv) from [<c04db5bc>] (__device_attach+0xd0/0x1=
34)
[<c04db5bc>] (__device_attach) from [<c04dbdd4>] (device_initial_probe+0x1c=
/0x20)
[<c04dbdd4>] (device_initial_probe) from [<c04da8fc>] (bus_probe_device+0x9=
8/0xa0)
[<c04da8fc>] (bus_probe_device) from [<c04d8660>] (device_add+0x43c/0x5d0)
[<c04d8660>] (device_add) from [<c0526cb8>] (mdio_device_register+0x34/0x80=
)
[<c0526cb8>] (mdio_device_register) from [<c0580b48>] (of_mdiobus_register+=
0x170/0x30c)
[<c0580b48>] (of_mdiobus_register) from [<c05349c4>] (macb_probe+0x710/0xc0=
0)
[<c05349c4>] (macb_probe) from [<c04dd700>] (platform_drv_probe+0x44/0x80)
[<c04dd700>] (platform_drv_probe) from [<c04db98c>] (driver_probe_device+0x=
254/0x414)
[<c04db98c>] (driver_probe_device) from [<c04dbc58>] (__driver_attach+0x10c=
/0x118)
[<c04dbc58>] (__driver_attach) from [<c04d9600>] (bus_for_each_dev+0x8c/0xd=
0)
[<c04d9600>] (bus_for_each_dev) from [<c04db1fc>] (driver_attach+0x2c/0x30)
[<c04db1fc>] (driver_attach) from [<c04daa98>] (bus_add_driver+0x50/0x260)
[<c04daa98>] (bus_add_driver) from [<c04dc440>] (driver_register+0x88/0x108=
)
[<c04dc440>] (driver_register) from [<c04dd6b4>] (__platform_driver_registe=
r+0x50/0x58)
[<c04dd6b4>] (__platform_driver_register) from [<c0b31248>] (macb_driver_in=
it+0x24/0x28)
[<c0b31248>] (macb_driver_init) from [<c010203c>] (do_one_initcall+0x60/0x1=
a4)
[<c010203c>] (do_one_initcall) from [<c0b00f78>] (kernel_init_freeable+0x15=
c/0x1f8)
[<c0b00f78>] (kernel_init_freeable) from [<c0763d10>] (kernel_init+0x18/0x1=
24)
[<c0763d10>] (kernel_init) from [<c0112d74>] (ret_from_fork+0x14/0x20)
Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
---[ end trace 3e4ec21905820a1f ]---

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_g=
mii2rgmii.c
index 449b31319010..7a14e8170e82 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -84,6 +84,11 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiode=
v)
 		return -EPROBE_DEFER;
 	}
=20
+	if (!priv->phy_dev->drv) {
+		dev_info(dev, "Attached phy not ready\n");
+		return -EPROBE_DEFER;
+	}
+
 	priv->addr =3D mdiodev->addr;
 	priv->phy_drv =3D priv->phy_dev->drv;
 	memcpy(&priv->conv_phy_drv, priv->phy_dev->drv,
--=20
2.17.1
