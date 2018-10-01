Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DEC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95602083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IDkIoyBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95602083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeJAHOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:52 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729418AbeJAHOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0lP4qstX/60/aMPCYEfKJtq49FnUvJOdkpwg5S+1HA=;
 b=IDkIoyBN1PGF8/Ul6sTJymiefwaxiP415s9VHMePw6La9eJrIZspm7w9bXpmE/bC1Li3fhkrV/TWOTQovnYg6LarBiz4YscIzGOh2TBzKmGbdmUVZruAaYPEMCtElqJymbr7W00Giy9Qxnxj8/nuy1mJnK/hmmTKDTyOV9Z+UP8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sean O'Brien <seobrien@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/37] HID: add support for Apple Magic Keyboards
Thread-Topic: [PATCH AUTOSEL 4.14 02/37] HID: add support for Apple Magic
 Keyboards
Thread-Index: AQHUWR8hK+HSwKUh0k6vzjJ7x3ImHw==
Date:   Mon, 1 Oct 2018 00:38:53 +0000
Message-ID: <20181001003850.147107-2-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:ACcCx8nlJEUfmQw9aN61+pkLadl8K2XWIs2of+dAc1UrCs2OHZSLVKcBqcf8dESjLJOGjhtT1eG/0RevMvnLTBfUe65fioPyNoQ2CWHup8rEzPEhY23x/ZkHUZj0b8vUcC6fqr6Fz4xbNcOklTkqI8gZ6QReN0+SWlh9LSdK+dGn2swvXbScg6eURtHW0r4xKhsfMkrYLZ2lwNvt3Wv3o+qz0i0GHlGIrFEajrWiNQrwcv29uFEeukD/ZJhS6GJumT3a5s4292T2wtOq3tw8OD1XZn2ior2nyCpnFw1XFeZ9RerwIiiBnZnV3YX/jASa7qxfxxSVAL46Wjfn3stKTAII5W9XyvrbVzZ5vhNdsBfJ7CxHi8rLE60P0yI1ZzYgV9Bp5kMEPCXys3y01RErgq8KqB27SR2Ari9zt10/31/TNtcx9VSi+GDoNni+CebWcVBl7DbXoXKU5iLX36Udyg==;5:P8vP3wZTLV6pDnK7YHMC4Yv6kAvtOXDeaz7xYWX7UVWaoBJV95q6Up9z8ZaM7JGp+QlZNaQgOG2Ms73eiIj4poUTNOyHKbg/Gi9Q77yKtJtjEn67zM0kJccSLqjycdVp0eRjNU+BcfNRLuZtESuId65U3FkFi5nVDR8PT8hL3s8=;7:pSAJFgZZR2QLUWWgslcE6ES0nn7eA3AX8GpoVsQKIiJ5HDELqRuP+pUrX8WRgmvilKTbWhzSiQ3Xy2DGeb5saIRN6xmPtV1Tmb0i3+DvQHF9x4Jg3jkgmZYR+8mr4kmGRc0ViJ9RAg/PS3lSGMvtH2/gW47Zi80NHIdN3lAptrVkxepsQSCxB/hpzw0jH5gsbYql5DXRLND/Zr7vi1e5kMLbSksa7fZhxVnuhwjkIikeryKd6GSot/opIc7vI7MS
x-ms-office365-filtering-correlation-id: 5ac387bb-b460-4042-0782-08d627365e56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06969C217F880921F160E679FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(47660400002)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(99286004)(11346002)(26005)(86362001)(575784001)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uH9YIqPlDH8ozvDptLZS2hZ2o6ectlKgBdJCD3gWMqKuhGZqgG9TJc/lDY05EqpdsYjakM9LfBRoVjSaewQFIelLiw+py6b5Xvn2pUeClGcfZWpb4ILsAGPL6tM1MBTD6oz9KfSpB+IYJgFGdF+Rz2nVxUX/9hwf+wORuTRnhL4gejAv4GoHlRgoRRfCP0WAkMRXr+g5hE/eEa+wIallbGMQ39+VYZsVcxo1mnRYcF8zKxVbuw3ajthir5jJbPf+C7N75hepTzo8kcrHHcGAYT0H+emPa6XAE6QbhWT5boSbWvTRvFPnPMs04xUPlpqzABm1jlaUqly6BAom3PuhFMlBCvribaApggNHau1MMJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac387bb-b460-4042-0782-08d627365e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:53.8948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
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
index 81ee1d026648..431e88960af2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -85,6 +85,7 @@
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
=20
 #define USB_VENDOR_ID_APPLE		0x05ac
+#define BT_VENDOR_ID_APPLE		0x004c
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 #define USB_DEVICE_ID_APPLE_MAGICMOUSE	0x030d
 #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD	0x030e
@@ -154,6 +155,7 @@
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
--=20
2.17.1
