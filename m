Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00302C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB996208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WdizzEN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB996208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeJAHPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:48 -0400
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:65184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729815AbeJAHPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXY7zSsUjAwUTHFqry9jwtX4UiftpeHRmSR2gscRr8U=;
 b=WdizzEN4wLNVcBB2IvlsfL8v3vkAsCag7GqY6u4CUWHCJ4rwj+LOLiamwXZBF2ozDjD41dNIpawMs5WiGRUBBL2KoKw4lVjd3J/jDkNXxtM8XJbQw7CqyqUprZbqXz7bGNYdvngon9JpM1pH/h4F/BGiBiPUrcOA8zlXj+kO/wo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Harry Mallon <hjmallon@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 04/26] HID: hid-saitek: Add device ID for RAT 7
 Contagion
Thread-Topic: [PATCH AUTOSEL 4.9 04/26] HID: hid-saitek: Add device ID for RAT
 7 Contagion
Thread-Index: AQHUWR9b9I+rAO/uMkmyrOwrr0iCiQ==
Date:   Mon, 1 Oct 2018 00:40:31 +0000
Message-ID: <20181001004026.147201-4-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:NCNED4nIieptyMME7ADtWieyZUwskGojCHi0oBqw25SjybKwVulge9xrd0LZtry9UM/sA5/wNIztaKOO51THq26o9SOPs+bQAsUxWf95qCApqw1rQUUo5h8k83/127Dpxkdk95mp1JK0oEURGuvaej9rxgNkpkanlKhz9qaTWMVLyS3JOVVJ5TTCodiqHXkWb+wRDdqlX7cVJML1IoXCymdjtxiAQACqqhqOpAnC3CfR4zE5WKZa2jqu4eNfnnPWD73JDEOjyk1PhfzEAWyqcUPS/fY8/9Xprvm8ov6ESyu7la/MOGRxsJxY4bubyioucXA2b8rkyX0tDIlzRjbaMRIc1Br1vZ9CskInukp1jT2P/IQNoj8j81ekyHe3HzFZnhpzWQECi+u4z8SRAZIqsJzdysGgdJYhweOpD0e1QdhlKVJc1V1aukiwun0/Cb5/4a3z5RLwHT2WepOdFTtEpQ==;5:EDm1uJYsYCJn7hpfU7k8ukJLXBsfE+QRf3jwWwuGswsq7LsuPA9IfX4VOS6Hm9/oymtNXRFjhfvuVQWxtmmu0j0ybRaMX9ASuVjRofYC/ICBB4Ii5caC8MFh5NJ77mwegaMAbPsW9FbBUE+5mZIRrrMn3p2suQ9A6uUO4loFxLM=;7:vR4DP7OQNbHY4+pks9jzyKPFjtAvYmfXiINLoimfRB5zb86bMHZ6E0dj1pybE2LanZwP68AD+euUaeGBM2dZe70YU2fBdj7cMn70c3QBOliAweA/mjlY35Ed3kHrVO4dNJiUtMPWdp+qUcXAXCFGBF+LrINMMec9KkZmVIjPCSaieU1XVi0wFw2UyDLv1836786p93cR0gceuLCHz67ibnz8MfHhb6BaAENku0s4Yvut21LwVb60laDP7/J037+C
x-ms-office365-filtering-correlation-id: 74cc5435-652f-4ad9-5c57-08d627367e2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120338B4E145ADB2DA0277CFBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(39060400002)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: gLEZ+1cKeYvrtcNKJQdml2W738VPKxhoM39g3sTbVuPTZIjRzeLAdjv/xkxu5ogWoW0WXp3UsjnAEhG/PoXYWE3J9RXblRQLsZaSRUPeiMiXK9l+5HUCHBmw4WQHIzTWw3spj0P4cH2cpisbd6L3VTyyn7gOarqsZZkR6Tvpo/gABD0YH1Z2qsUQ8OxeAyJtfSlFjBrSZ77ZXR+XwYjc65VBiC5J6uAx+8CWmqbtqJ4oCEXQR4KMF/wAGK3iCLKF2QfvWXHZsVWgcWlfU2U9Kx1oKKQrk2u1C6CcrKwhnro7C95k6f33VBU4Zqld+S2CL4WMErJpU3SYR/gnYlKAUua/O1As0S0EzRYhz9/gKrY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cc5435-652f-4ad9-5c57-08d627367e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:31.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Mallon <hjmallon@gmail.com>

[ Upstream commit 43822c98f2ebb2cbd5e467ab72bbcdae7f0caa22 ]

Signed-off-by: Harry Mallon <hjmallon@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-saitek.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ad5048e6b0d3..8913f357e78f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -890,6 +890,7 @@
 #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
 #define USB_DEVICE_ID_SAITEK_PS1000	0x0621
 #define USB_DEVICE_ID_SAITEK_RAT7_OLD	0x0ccb
+#define USB_DEVICE_ID_SAITEK_RAT7_CONTAGION	0x0ccd
 #define USB_DEVICE_ID_SAITEK_RAT7	0x0cd7
 #define USB_DEVICE_ID_SAITEK_RAT9	0x0cfa
 #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 39e642686ff0..683861f324e3 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -183,6 +183,8 @@ static const struct hid_device_id saitek_devices[] =3D =
{
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_CONTAGIO=
N),
+		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT9),
 		.driver_data =3D SAITEK_RELEASE_MODE_RAT7 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9),
--=20
2.17.1
