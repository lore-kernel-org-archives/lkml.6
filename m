Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C468C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80A821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Pt43+34g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80A821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeITIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:36:20 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387959AbeITIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSJj/+iXv2DUnq6CmsV2cGqNnloWZZLVPY7EiwtslZc=;
 b=Pt43+34gjUwKtAyVYtyj8LbsGYkadrdQe0GV+vw4KyyL4MuXE1b0dt4J/OBcEg3YBN6Yufj63yT3gtxrIx8MQFz4fzv5F/VcCVPmfxYDlnnawGWLEqAMt6RJNBh0M9Am8GFKN7olzRsAn4oViU3GI6MZT3WTn2lu2uslgtCZ7+Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 50/56] ARM: dts: omap4-droid4: Fix emmc errors
 seen on some devices
Thread-Topic: [PATCH AUTOSEL 4.18 50/56] ARM: dts: omap4-droid4: Fix emmc
 errors seen on some devices
Thread-Index: AQHUUIxZuJ+dWvDZikizZdyEpuPj2Q==
Date:   Thu, 20 Sep 2018 02:48:03 +0000
Message-ID: <20180920024716.58490-50-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:dDC/0Nd5x6kITqlX1QmnVjLn0eeoluaCsSfB6kLy5TxfBD4SoisQMS/lwh3tei/rc4bj3RD/7xrOyJT74npBGoldBtNNOKAp4s54r0KoFuqp/wBBxtGjNrStE03R5TtX0N8stlJdX8gZZjnUmmTJ1uY8wUGDSu78kKEoMxNU47+KEPGclaH9x92fqaSItf1PFjDKns+NSxD90rCxGiFYo5wRCGEbqd+2qCBp/DXAfnYdxTDthqEDM4WXFEDCGM9l67F8WI4Y3bK8ma2OO44wygFUFyKxqukzuVgNrXSRLUFb89sWaJFiF6noUtYrauGbJMAtJfLfQ4DjQrO3J58ZNKny51HPT5girrOOqDaJUSCVYrRuMSJfhjPSTAOqcKw33eZ96LyrQ+JxFFnBlCTIB2NorwhlZAQej0X+u0qG9tuODnKrekGHrEtWI3u3Nuvvuw8r+Kjzdr6h3ZhOHskDWQ==;5:6kOpqj62Ht3onNwm4UhfgF5REcXHVmKYZPCNniafSmozX8IguCAVMVz2aElEX9xF9UGkWZK7uRABMewR6XpM3HKCm+UDGx76snpuxOpcLAKsNrdsnXLzuLjCRzc4IRP7XqSt97RClLsyenB3U3qQh2042rZjVNMIs2DxgWuDrv0=;7:vwwoG3dJyV4iKtV4MKCTRYZHfuRHxScb3l/dMxlriSHdIa5yOuNoCYr8o5uq6FplXyp+VbC29tKlLLNrR+X9QteSZGyLXAgGv0vImzJPwWLVHPRSby5jqQunHrubpF5480e6bDq0dSGP5P4TDmQcC2I730rIuy0EmJyBnAQY2eOCvf7COvPWd0Xdb7MabceSpVZADzGcP70yfD/6A0NUbjlu5xWz7t5Gqso76LlQ2slSKH9I0mg4oMEQGPSjRU+3
x-ms-office365-filtering-correlation-id: 78c8f0e2-7348-496c-d053-08d61ea38bfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01196F542B843AC4F61C5C3FFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(248736688235697)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(39060400002)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u2wSgizGwbTIb78fdnx5WsE3bsjwjaifwm7nYB/YDJgWZQfjaYh/T9C7GKON22p9Ekli1Bkqmor2xj2d5GzJ4atxKNwtGMpa6jkaIj+0lbdkXcbypK/Pl96u6svWmSclwWrbgJ8/mMuVI4mMol9Fn72pHhnydqZPaicwvClI4MgIHK93RNLZSp0Sx2u68fwlmf6KuaHP5TiWwxmtrra9DHMFSl49ZvLU3j0KmMvtHDcjMBDEtBxLHb5wIE5rCp34C/UlAQTBhcst72OU8xQq7t5yhXWOyJL3vUkw5j7+jQGxRaL/WdmIP07IlkL30nmo287We0VYzLFgfrfhSNW2ikn5zefascs1qv2z3yisb1w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c8f0e2-7348-496c-d053-08d61ea38bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:03.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
index edc97f89fae4..5f27518561c4 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -351,7 +351,7 @@
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
