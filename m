Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA9C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DBB2064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OIpKCCqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DBB2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeJAHPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:46 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729766AbeJAHPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Povx272nTczXYtN+i3ciFQ+RClsJWtjqJi5k3uwNgO4=;
 b=OIpKCCqxGKtismHhgj2/37FQDoJ/PwcijfGJW4CDajP6D0rEskQ7iFxPlosjnE4UpPSF98AwqiQOQ+bMoyBJ/36sC2v7bdVQMrt987gVBocxOlpEaAgOEo99bvD7rgLcGo+wC8XSAG4jFIhdc8fM6wWS5FQo8hIB2k9pLl7+1DU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sean O'Brien <seobrien@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 01/26] HID: add support for Apple Magic Keyboards
Thread-Topic: [PATCH AUTOSEL 4.9 01/26] HID: add support for Apple Magic
 Keyboards
Thread-Index: AQHUWR9aRoG9SUMqlUu3OnS0P5ZOKA==
Date:   Mon, 1 Oct 2018 00:40:30 +0000
Message-ID: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:iLvCDxe83bZ029BYZK0zh+zQGed5hBpEU7GH9P0RSEmptXIkkvch7ocHNPvOxPICz1uhYwRHk5UbOcDYnv8M0AC45xdqom/cdET+KTi2DjaOaePKenleZdX2eIRP5y6w1Jx3qqF1PMoZ/qDLEOK72xN5Pg9CESs5r5h4aGRisp8tc/64iIIXWPzIeb/bfcZC9HDghkQ6LrrGGaSxhIV2pAZUHzx0iX91TMoonxtAlFae9v5v85AKoSeUR4dwzTbeYA62b8TTdjTfX8KkgNvUvSZtTSPXTPglbSLM4DMhKbP/8TrJdB+ERDXKSI7ZEWULjAh6+Tc6PJiLaYPMy+o2UVuBDP2xZ+qfA0QYNq/03jpdQR/qsJJd7tITDHMHmu2pW4+rTxDBK++A1VEOKQbOds9knUbqy500Frv3vpM5l0Q+JTuPgzYHSVYhyMEmy0KGtxnOpfI5yXOekx4VnSrluw==;5:yQKkAFEUfmtqQIOO5XWR4he69vop9S9dQORscZHAhiJXXJCCIiWBSmPUwCi08WJ9J661GFJeWzks8IxbkXLpOHS6c71958WIXomYkeFM/KopiEf9DbyD+UXwANhkrNJtnzjeNurxm3BMxLVEHUas371W4f/39aLRdQ9yrjjf2f4=;7:fmtsptruS/DKIxca9oXu3nhr5LGe3s4AsaX6A4qASEkbYhp5xZNEagjCFTMe+IDEZUTPqGrAdmaGX+tsTcNPu2ngEJ8XknXMpOCatR1Cn0YBMIQ/3TZlAMQ/PklhrcF1fThIA0wRZx0JhoHRJQ4snpTdQLXP3t70wnUzCB9eTYM9IUsW1WajsXsJBW5GaLc1QduMEqAQ5KRnJL9pKo3uFwUGLZsMR+uU5b30kHM/9Wi9gJli5GiC2vvJiskypL/B
x-ms-office365-filtering-correlation-id: 85ad96d1-60fe-48ae-d2c0-08d627367d32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120A8595D9ADC4F653BEDADFBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(47660400002)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: bE7gzuVuLoT6XWDZq9DF3fP2cDrkOTzTTatAZHQ7+YHSYGRXA88wUeFMUL/kCNQBUVQ+33EZTqUmAXR+g7QtlHKMRTVfTueq/nhQS7Li5uxUwEyMHN2xAfnVTOTS+31FzpP1vGYLxBFw2/NHv0oJS2W9tEhEigsxScWYZiAAWIC+rJanA3bZrM7VvCAwMAabow0DH2Z/3+DTmQrv5yIakbCMwsMd1+VcHOYFdHwRmUpPuFOEDv3EYNvp9YytzKaPWWUelZI6HwaYsUXfblj5L2At18wIOVJvEyL9xqjw37ZbuPEm8rJ4uF9CXnklz8uqTvdvC5GEWKOYpikxjIJgxJFw+bNBz8pcVRh5NW//wt8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ad96d1-60fe-48ae-d2c0-08d627367d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:30.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean O'Brien <seobrien@chromium.org>

[ Upstream commit ee345492437043a79db058a3d4f029ebcb52089a ]

USB device
	Vendor 05ac (Apple)
	Device 026c (Magic Keyboard with Numeric Keypad)

Bluetooth devices
	Vendor 004c (Apple)
	Device 0267 (Magic Keyboard)
	Device 026c (Magic Keyboard with Numeric Keypad)

Support already exists for the Magic Keyboard over USB connection.
Add support for the Magic Keyboard over Bluetooth connection, and for
the Magic Keyboard with Numeric Keypad over Bluetooth and USB
connection.

Signed-off-by: Sean O'Brien <seobrien@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-apple.c | 9 ++++++++-
 drivers/hid/hid-ids.h   | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 2e046082210f..65a0c79f212e 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -333,7 +333,8 @@ static int apple_input_mapping(struct hid_device *hdev,=
 struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	if (usage->hid =3D=3D (HID_UP_CUSTOM | 0x0003)) {
+	if (usage->hid =3D=3D (HID_UP_CUSTOM | 0x0003) ||
+			usage->hid =3D=3D (HID_UP_MSVENDOR | 0x0003)) {
 		/* The fn key on Apple USB keyboards */
 		set_bit(EV_REP, hi->input->evbit);
 		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
@@ -476,6 +477,12 @@ static const struct hid_device_id apple_devices[] =3D =
{
 		.driver_data =3D APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_=
ANSI),
 		.driver_data =3D APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYB=
OARD_ANSI),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_=
NUMPAD_ANSI),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYB=
OARD_NUMPAD_ANSI),
+		.driver_data =3D APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI=
),
 		.driver_data =3D APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO)=
,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index de64cd33590a..ad5048e6b0d3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -83,6 +83,7 @@
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
=20
 #define USB_VENDOR_ID_APPLE		0x05ac
+#define BT_VENDOR_ID_APPLE		0x004c
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 #define USB_DEVICE_ID_APPLE_MAGICMOUSE	0x030d
 #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD	0x030e
@@ -152,6 +153,7 @@
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
--=20
2.17.1
