Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D9ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFA721521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UeVtJ7Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFA721521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbeITIea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:34:30 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388311AbeITIa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGrW0k9n85kk+1e/xiFKCquTT+ORpVwd9DBNuhf6ctU=;
 b=UeVtJ7WlOpgSmhyQ5VG/gQQtK06R6st0NyDlOf75vE0Yg/v5oLNQjIJj/VhSIFZO1kgvnylGBkYBYOhfhDmg9lYhWd+Ldois6U1x/FrkWuosGfN45qymV6On4JgdI1YlFyRx/zSTIcyq+kaYt6C2/gGiV4xxileVEGs53CXu2eY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/25] ARM: dts: omap4-droid4: Fix emmc errors
 seen on some devices
Thread-Topic: [PATCH AUTOSEL 4.14 21/25] ARM: dts: omap4-droid4: Fix emmc
 errors seen on some devices
Thread-Index: AQHUUIxqUGNz0MMpSE2xPeoikGAZvA==
Date:   Thu, 20 Sep 2018 02:48:30 +0000
Message-ID: <20180920024810.58594-21-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:MMnzCYPopgqiT2X87oEe9UB0sXT0GR+esBQGx7/BLBC6fW45voSNbrZsZyMFyz3Tr5tRqXpd5etoBa/xsh9FPQzVxS9t6azwjCM5ki58Wi7Jti/zGBlVbC3seVF7JrfJQeO5ztoDDa8CyUI8J7QrmykrCc6mtAG6tS3+Wu0d5uiT0PNjg45M4ntTEf9ySgaQyJM3KYHqUiEMO4xgzUHcFDjLcUeXQX06Gzk8P4NRZjuYVAu35lfBI3LyuQdVXk7EBPWZoDE++cqaoSXeG3WGxN+aDJgKawmACQajn6KrnFTW5iGNQCi6PaJY2siaVLDzH70RA8OcBG00XB7lltYD5VcWdqPx5uT6DloNPSo34u9gSuBMhICXDCcP6J45bcWN/vMNUnneSJBhAf75rvQqvUbg/LO/ko6zjshNEgvZm9N/PcyC3aOjHTA/+p3AjklC4s7Dod496O8QF/WsVea35Q==;5:L7ysVCvOtyLgXNew25ujVivnO+k+v4iFWy8FC6/ZvLBW91BouqzvmSRdzNqs6t7u4U7YnoFM34RvfdC6ozNLuRCwHrsIjCyaKQmF0HqZwIViD/TsyjO6u4kcNC35DUtn2zzb2rzRX6k5GemYBqSPin1iS+Fja2rDlkFN2frpK6U=;7:W51My8ee1/8j3cvm4w9Lyl3w+b/2IJrUX3YHUKbINpCjluX7DXl24lro3Jjw6HzrnwRMCPZxRFjEEk/yag0hY0CNfZQ0W0NxNv+JC4cEHU2X5ZhOdhVmGVhiIzlkybcoZj3kz59B7sUdZXOYiFzXl/WZZvULa6juqzL7qZ+AFg9TWvV4sElVa40XiT67qX9ko8y1YqxRpkF7FyrAlOuFRZ+NshsZ+rYqAjqI0QWJPKrsHvdR5COaK6BZbNFOM53W
x-ms-office365-filtering-correlation-id: 825e09b0-9235-4017-4e21-08d61ea3a915
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07445C813D2E050CC2D337ACFB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(248736688235697)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(39060400002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CDDNlfzJ+qVWDIZDO5xrU/ocG5RW1oiA5nwBeUzdlc8eUIQKHz6FA7+uLHeoGg5YgSUJrsIpZSGrXGFiqh6Ql7oo3Yr6t8cxXubPZkW6PR1b0c8UKhUXO+/8y5+dzoX2HllECt4E0iWK+1fZxH7mk50ezeD6VXris9mSAiNK+tBjZ73mQf+tKg+QcKkw9FvXYPCZMXO//cYvbynF5oigT7gZ+lUvPdh9Ff6VdvpAWqumpBh1KKxzb14yokR0Q9Th7WE62Blv4H8jlS6jqtl+eByMz6Rc5Q3sZ6puGgstWXFVi9+ifJiO7ZgjuO68QpIoxGAcdv+iFoyr9jEHQyE1o880xpv+s2fSh8Z36MOsQME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825e09b0-9235-4017-4e21-08d61ea3a915
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:30.5851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 2d59bb602314a4b2593fde267734266b5e872dd0 ]

Otherwise we can get the following errors occasionally on some devices:

mmc1: tried to HW reset card, got error -110
mmcblk1: error -110 requesting status
mmcblk1: recovery failed!
print_req_error: I/O error, dev mmcblk1, sector 14329
...

I have one device that hits this error almost on every boot, and another
one that hits it only rarely with the other ones I've used behave without
problems. I'm not sure if the issue is related to a particular eMMC card
model, but in case it is, both of the machines with issues have:

# cat /sys/class/mmc_host/mmc1/mmc1:0001/manfid \
/sys/class/mmc_host/mmc1/mmc1:0001/oemid \
/sys/class/mmc_host/mmc1/mmc1:0001/name
0x000045
0x0100
SEM16G

and the working ones have:

0x000011
0x0100
016G92

Note that "ti,non-removable" is different as omap_hsmmc_reg_get() does not
call omap_hsmmc_disable_boot_regulators() if no_regulator_off_init is set.
And currently we set no_regulator_off_init only for "ti,non-removable" and
not for "non-removable". It seems that we should have "non-removable" with
some other mmc generic property behave in the same way instead of having to
use a non-generic property. But let's fix the issue first.

Fixes: 7e2f8c0ae670 ("ARM: dts: Add minimal support for motorola droid 4
xt894")
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/o=
map4-droid4-xt894.dts
index 8b93d37310f2..bad690b23081 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -314,7 +314,7 @@
 &mmc2 {
 	vmmc-supply =3D <&vsdio>;
 	bus-width =3D <8>;
-	non-removable;
+	ti,non-removable;
 };
=20
 &mmc3 {
--=20
2.17.1
