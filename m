Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479849-2-16388544843729659780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479848; b=ilmZQLbLObC2iEUiCy8DBC/gKZKoeMEU8dZIhkd4OITz7O6
    kyic+AaWN9rLrerJ4Q/Kg+imj9NSXbJEtJHcdkmMSMDkU7wE9/s7laoKygy2atB8
    XEvb+L9hvOnTjmKNCG7xi+qUynenh6dtcTNH1i7tD5Orsq/odedTfLG0lOrIOJJu
    7R0g5QfSiv2+ntQuGXZOd5fc6Is92YS3GBUGyWmDxRwySfg5pzmojfjdwsPKGihp
    92VMnJhdpSS9VhgXyy6J3PATeN+ywoUSI+gHS/sXY6KxXcZV2gF8UlK/s5LDMu9S
    otqPueYegMT2z3sm1tXM5ftlTW3mJm1M2WITYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479848; bh=yvfO2J
    Av/cu7LvdtAO0W/W4czBeJm8nZ8XP61Yy0Bdg=; b=I2iRmkAr7IGisv2he5O+ss
    vszJnYSPj67ne3Yu7geo2Dau++6abFQhWA4rlLByTAqtemRtK/JMc9w+2AiuVxhm
    4qrjRh5ztna821NDX+/EskPkGkknKOeKpkPiQgywCTZSTrwfgCJLTmmWdKi+rqxB
    /ThOi+OJRR9cF4jtWA1/e6KbHHlIEF02hms3TuDvCTDy3icEgmnUtPUnCU0dbeHm
    +iETMpHrM0xtft0wCoUSP/95MGnlbX3mtNtP8MEb/+sLJeJdymlF5jE23gLfZNw1
    WQZPwValrUU3lI8wTabLMmMlpt7I3+ABLBbghbWacbW0IhbheE8e1XG3L1c4gh3Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PS0D+hoH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PS0D+hoH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvjeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965127AbeCSRRT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:17:19 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966530AbeCSQJy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 098/167] HID: i2c: Call
 acpi_device_fix_up_power for ACPI-enumerated devices
Thread-Topic: [PATCH AUTOSEL for 4.4 098/167] HID: i2c: Call
 acpi_device_fix_up_power for ACPI-enumerated devices
Thread-Index: AQHTv5xeQusU/huPuUuCZ+JHkAQ/oA==
Date: Mon, 19 Mar 2018 16:07:24 +0000
Message-ID: <20180319160513.16384-98-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:XalUcw7pgvN0JwMLyO8qkGxCtGmuiUflJBadVK/5J12lZy9I3KdKZsj5nGdHIIKlg8PC0dXx8KRNX6SVJdO9y4hLEN4XTePLF3xeXk+o5EFYlB+RnCl6MMJxecPGZBp8rXZAeVB0vk1OPcOyENgswyg9mWXAgiiWqIJtOwPUjSKqCS+WatpqCxCeT55E2VrDtBNPJ23zsOCwD9+74ZRzha8wLgB9Y72tx5F4jmDEUIRoNO9Vazqm0S43SUdZlgC9;20:6lBnR8bCCC9WAN5kCQdxfEopDjfxlzcyrBHJj9RO2yCadmUTI0m8srLez2yKaNmURBuJkjo6N1KCcn404edl2QHhkoMp0dft3dXSBtgONfzr/F1qP7Zj0INkGTlDOTbLQHvNKtGmKbb7jHrwQjEZYYUTPrhiWw+4EZDloULAJhc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5869dd8a-8733-4c4c-8be3-08d58db3d5af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10958433E9A696321902830CFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5vdrr7OoT49N1H7s4srntpOBHPWK5Sd52GyOT28ej1w7AYqBRtIW22fmUcRFEi8tOFXyWPXpcJPN05RqvFiGtXg9P1v658WUlIIZKg0m+grVwdOKOdK7JEiovaQ5oUfjTwXCfilMn52ANuUZDAH58L2UMmR8jV5hDhX3ahbdzxOhi6w7LXG4SDmijDN0b31gyTbL6I2IcqyCEerdm9UuSfks6zP0sEqVAglRwRyhWaCAjxvz7zqJZA5iULvbWl/wR499ombfLfm4whDae8ib7syDXcJlf9tY8N9ATYeI7kTPN+Y1lByl1omxN6WLJatZJJh5jSFj1XvNGMcp4HvJvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5869dd8a-8733-4c4c-8be3-08d58db3d5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:24.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f3d3eab667de62572376abb1aa26316191c39929 ]

For ACPI devices which do not have a _PSC method, the ACPI subsys cannot
query their initial state at boot, so these devices are assumed to have
been put in D0 by the BIOS, but for touchscreens that is not always true.

This commit adds a call to acpi_device_fix_up_power to explicitly put
devices without a _PSC method into D0 state (for devices with a _PSC
method it is a nop). Note we only need to do this on probe, after a
resume the ACPI subsys knows the device is in D3 and will properly
put it in D0.

This fixes the SIS0817 i2c-hid touchscreen on a Peaq C1010 2-in-1
device failing to probe with a "hid_descr_cmd failed" error.

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 312aa1e33fb2..1aa82962cf86 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -899,6 +899,15 @@ static int i2c_hid_acpi_pdata(struct i2c_client *clien=
t,
 	return ret < 0 && ret !=3D -ENXIO ? ret : 0;
 }
=20
+static void i2c_hid_acpi_fix_up_power(struct device *dev)
+{
+	acpi_handle handle =3D ACPI_HANDLE(dev);
+	struct acpi_device *adev;
+
+	if (handle && acpi_bus_get_device(handle, &adev) =3D=3D 0)
+		acpi_device_fix_up_power(adev);
+}
+
 static const struct acpi_device_id i2c_hid_acpi_match[] =3D {
 	{"ACPI0C50", 0 },
 	{"PNP0C50", 0 },
@@ -911,6 +920,8 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client =
*client,
 {
 	return -ENODEV;
 }
+
+static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
 #endif
=20
 #ifdef CONFIG_OF
@@ -1012,6 +1023,8 @@ static int i2c_hid_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto err;
=20
+	i2c_hid_acpi_fix_up_power(&client->dev);
+
 	pm_runtime_get_noresume(&client->dev);
 	pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
--=20
2.14.1
