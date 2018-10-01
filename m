Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477CBC64EB1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DC6208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NUrdlZaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DC6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeJAHNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:18 -0400
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com ([104.47.36.116]:27216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbeJAHNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mki7xrQFzA+repzxJPvhu//J+acDAy747X785FRnUxU=;
 b=NUrdlZaQ2jV8mTyqYQIfVdeEfDqX9RyVNyJe1J53nqHlj1Bbsu3dAbtesJ0tosLYzutTERVYwQjq5Ax7OuJLkvOL47zA7GmyAS3PEm/p2SPQDPb5t9XnyYKUHCSJ53mpX3GmZmTjwSLnSpffJ04PYJvD52A73nlWB4gbBeV0nqc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sean O'Brien <seobrien@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 04/65] HID: add support for Apple Magic Keyboards
Thread-Topic: [PATCH AUTOSEL 4.18 04/65] HID: add support for Apple Magic
 Keyboards
Thread-Index: AQHUWR8D9QkJiEAORkizBKuH38nwZw==
Date:   Mon, 1 Oct 2018 00:38:04 +0000
Message-ID: <20181001003754.146961-4-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:J5x0VzejdXQQMzkGrzH02dfu5sIdOr3XR1w6eVvFG7NHNuEjNK/+NgnIIX/2dYeDcB7haHT2Zhf+Hrha+wTDdOZrbIrNLYMdXg4LSH5T9/bH7RCwwxuizuiAhAQL2JpnLJd8ce3I+Zh2Y2peqFNeNMYym+qjH99KpRq+j0wY2clPxmEhef2qfTbhjywCJ7rUApU+c88iwZsUt4IyRK+gBrXSlg6UWsBgGYRZNlnzx7xzJkZHDfs2or5IuMvq0Ip+ysDyO1yoOyXZ0l0OAcy7FV3vDLsY2C6alXjTjVVo+HxQKFKzjztvdHpMLESwJMVoqnDtuS5fLF9OjlqCfH0NVesQw9LySFWtekv9s4leZk1YRr2Bf8ZzBFL38RNZ0JDVitHxqbKAnZRK7IepDOwVmvM+KUtStvrNamF5BzeBedcsJdIQJ8fZXFjSALyWJoy5byxn5azroWa9eWBYQnsxFg==;5:5an6FZDnTSSWAJiDZdFH7sU4oq6EZS5lA15tm4cDCoxJ3qyubRY89MCGwrVH9fsGxuL1v/yX7fY8BqFjbyW4t0H3pbJzCUecgtwHQCuAeNa7sx4Yit4Hll9cZ/WIpURqkUBoYBBwQeZR5xVvlcjIc9WJsq03v1uRcqDfMNdIjCI=;7:LRhc362H29eYlYSKMjIdFitXJBswYWrGjJUJaE+beZHHhiJg9NJAshbSxWgvhVR8OTTJZMQpBc09CUw/IQex6s3psyj0ZKoyavqKa02OzOZX49EaFEdT53ey7zVQcFKafBdYhXzw6inxxMdSnJwvkZL4yW8/JWz99AjejSrXfZniIfyavocVJ5g00Pv5EZj/OM8nTIqcjsWQVw0+Oe3Gk6VyVlsLo1uteSZvNgneJieprURMG8llxLfsMOLh09F4
x-ms-office365-filtering-correlation-id: 208b03d8-ac34-47ce-044d-08d627362664
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469891773BCBF549D6C18E9FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(47660400002)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(34290500001)(6506007)(2906002)(7736002)(86612001)(575784001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HAYA8cJ58b/dVX+x2hYN7JzAR0KEjdKjFHevCAXgwCrqQvorLAjfEo5lL5qmLo4OQ8FOD0oihb2WQ00GixXvZGiIIuKwByXcLbf0HCrAMDNDJ6aHDBJAsMF4fkTbkesSY0W+kMzmVR15HkgOt49uu3/+n2SJ7XfJGD+tr07vWwDo6EOdESkNMKOcRCN76GNrQeFAU7M6f92j5L55HG2Co+3uJhuijG3K9e9gg/WGsdLsrlYcPScVhUMnl/8zmS0ZIUMKFBBQN6EotOxfwDQkZKSp+Mb9wVAcKoFCUhdA/hJTvzjdyNEFtdZuN59c4JoinkAQ4JJn7kgb/1u3pLYN2DcQs8DbJNFaqcxdAKbegKs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208b03d8-ac34-47ce-044d-08d627362664
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:04.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 25b7bd56ae11..1cb41992aaa1 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -335,7 +335,8 @@ static int apple_input_mapping(struct hid_device *hdev,=
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
@@ -472,6 +473,12 @@ static const struct hid_device_id apple_devices[] =3D =
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
index e80bcd71fe1e..251e184f3f7e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -88,6 +88,7 @@
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
=20
 #define USB_VENDOR_ID_APPLE		0x05ac
+#define BT_VENDOR_ID_APPLE		0x004c
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 #define USB_DEVICE_ID_APPLE_MAGICMOUSE	0x030d
 #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD	0x030e
@@ -157,6 +158,7 @@
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
--=20
2.17.1
