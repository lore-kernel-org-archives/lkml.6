Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40845ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10522147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dTaiRHe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10522147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeIQI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:26 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:6704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbeIQI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKaA7yf5iFKhVip937Dnk0AfEJeQjV8UwGpmz8heHA0=;
 b=dTaiRHe6tJqYxJA4caupylj+Qtjy/7S2bjbTrZqL2sRO0w912k3qOOnieBqBO6h3ZR2cDnKzko2N4CU6XE/Om8VXlVsS2fxPWLA5QnbDDheED+JvmE7L+BvNqRQV8WuI+06Ka+8WrL0NNZBusSMTPFgnzJJsPxjMlzm2s8vxz5s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brandon Maier <brandon.maier@rockwellcollins.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 088/136] net: phy: xgmiitorgmii: Check phy_driver
 ready before accessing
Thread-Topic: [PATCH AUTOSEL 4.18 088/136] net: phy: xgmiitorgmii: Check
 phy_driver ready before accessing
Thread-Index: AQHUTjKu1zPnUgEgjkGwfngTvheUGQ==
Date:   Mon, 17 Sep 2018 03:01:07 +0000
Message-ID: <20180917030006.245495-88-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:OjiddHrMq3TAh8mssKrKQ9qz5E3caJEbgwL1EnSbDcFyq6O5hF5xvqGeDntCr8CxqkJsy52Drt/LCe7xBXqnI16vKo3yBp4pRPW0pJeMP/3dJn5IDabDyuTxbzQ40bNEXbqJLnuR9OSLeecfvxaeEzVvUihRRrIVvMUgTOQEuQVesXL+hExs0XbHW0fp1zip3NZZ0hDkZfnlVwhfnxoP4PiO/VhZYJtQvCcS3GW2kftJpJHviWyGU9OwmVL/rbX82DHq4cmkHbRa36FcIZw/MUoyBi6Lh9GB1VT/Deml1fr6EqD49YzbjmO+BbAPGMKjVGOLZNnrqeEyhZOUiIWzfZSS/wmDgz+7cRdwdFj+dWJGf7csdmHqkmSKhKreMjVhaLTDrdp5ruQT7sReFEI5As4tfuAZSMponF8AY3nOct5tShNzp5UuR6QQRihhx5MzCToHdOOe9ywZieUKXZvWEA==;5:abeuyFsJmcU4vz/4Q+4Dh2WiAAn8GI4ukAQ8vrdmaMs0OqsPSxdQt8US3QQPSKipl0IsKNx3ys3rOTIT7ROaGNGvQxjpKSvGd4g2vzOXD2OFsy97xqvls2vsf3czqiy9ZwYZyIs+b4bHrwfs8mZo1LI23juANdpMBnfbyVEu+qQ=;7:FPB7xfdEBQ+xLPVfXn1DwobHhinsemYBx3/qwRRc72f9SzCXS+8fC5GBZvXHclvkzJNvS2koEdA1VIs5SlTQLLe1c34OHwnNVa5RrfohrB3bDmaPbPbLi3+KLgLN5r+JcPWE8W1SmDBxIPI9I01ZAzIEII5fzEeYxKMNwHFCFedfipSgbwrxHAZ30pBbCZCQA8X/Cq1pEi9rEC9ZZZOODyNn4QuiDjI2/dtmVVWBD3UbNu9i54KbD1wFTlh/tgYW
x-ms-office365-filtering-correlation-id: 87d3033c-6ec5-48b4-b54e-08d61c49f196
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB07904B08366280700673F22DFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(5024004)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZvYAUMcDlLLcioQ8ZDqEwN+6l+ZBb9HCCUZ+GJsQ4B2BEvdkopDQ+ZpRrkUTKeJYU56GdKl2YzZvJVJ/T+h8z+VPeXu0jOluOynoNKw4Aeb7j2EtsipPqmfMkK5OVAOpIWWGlUUM/+FjMmGFvn4Hfiudz3fmKtlxHio/WNDrSSL4XAVHA1B98XtwZeHbEt+lleQtwHgpQPJzlzXipc9Y9mOX/ph/0B9Efd5ZAoxPj64GXi4DyI0I6iBduvEFh7cIPWW6+tOA7VkPbUQfcStOxaJ/hLcLcxOdZPjtrhRwqz/NUEXrdZRQsAtscvukBcTd1d7PmztuIrlfyffp9GEtyCORkVfIx4GZ/6FI09AG/KA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d3033c-6ec5-48b4-b54e-08d61c49f196
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:07.6980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
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
