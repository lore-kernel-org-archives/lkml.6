Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477542-2-7701083201241529152
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
    t=1521477542; b=Hmt/ITNbNu7V++HIiMIde9JC0xEOrj8q9ZT28MhQLzv4uM1
    7tcnvbpgRUgDmfRbIh27uQj0ztwRWKAL5CaBj0xPuRhHB26aCe/9/DErasmgy/2F
    fbMaKYhQq3fDtPUT6oWEw4yNDHe4f8B8yMAtb4LB0H3hiLs/5YfqDpAhR5fFG2Hd
    /CDtZg3lQmKef92QwOnFVC8U0KYU3067D1KjC7YSSG8qn2kc39ZLmfW0DkCnWhND
    XXAZzqc3YOwnpweXh0z22Mu5GN8bbuJ0FzWxczmmxhKUoHkpNw5I5Pad8NVg+GAp
    1UbQSxQ59gPGFK3CMJTC8QFMDPZzsVp3s6S321A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477542; bh=a3rnvZ
    2VP2zsWCiz7dzitjQU4KtD8Dy83F6UUeHReo4=; b=YK9CsIY+6+wacik/k2vmDC
    atKC3n5UlKhNqEkg/5BOoGccNAmbPWA2YSYjs+Cm6dOj4AJSXcBGnL8Da3SF7HYY
    3+x+vqvHJ7XEAt7+nWLB0O2c6ZtI8Osq+plgE2IajjGHC2TR5KQjd3e/ZHMvu6gO
    NN4a1oQac2W5DLpW9IR8v6bvyo7gIdMPQUy/jw7z1spHP9rqZ7vmhmIfpVLVMmxb
    9WtMgmMRjVjh9IUidVV9P7tt9lPpoiPyvlZcwnR1YF90FhoqPPcrEtAOGxXXImjI
    go3+87p+szBeGz4OLOb5gz1Ko4RKFrhotRjmNmmgwg9AWjqc79oauZ+R0P8dS/ig
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=at9ijo+z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvfeejnecuvehluhhsthgvrhfuihiivgepgeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=at9ijo+z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeludculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvfeejnecuvehluhhsthgvrhfuihiivgepgeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964858AbeCSQin (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:38:43 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:10304
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935256AbeCSQNQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 055/102] HID: i2c: Call
 acpi_device_fix_up_power for ACPI-enumerated devices
Thread-Topic: [PATCH AUTOSEL for 3.18 055/102] HID: i2c: Call
 acpi_device_fix_up_power for ACPI-enumerated devices
Thread-Index: AQHTv50ZxhmtdkW0f0at88JGwrUZYg==
Date: Mon, 19 Mar 2018 16:12:38 +0000
Message-ID: <20180319161117.17833-55-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:fvR7aMewZJX0JU7EjV5bLTE66o5Zg0p1QqM1LIZtGeQuSSDOfrSAfZ9QLYYZxU2iynReteWPG3AWyoYS1eqLU8pYO6rVJRT7FcAse+V59XgxxOyybFeR2b0b8Wma1TRH543NHpGf8R9T4lk8oxT25sSU+8FJEccuuSQBZ5Sw5Sx4RN01IcNItLqP+Bg7oAsc2/5A3DI/YL+5H//gZl7291S7LXGkCAtXbMsACegQAmZOkVwuwi3os+WyZAS7ShUv;20:lMHE1XzsEFb43v0yb1oSsIGypWP1bIuGLy5jmspeKJLmRgJa+v3NbeznFs2nb07wh2r+9nCTefidNPWL9VWWz3ZMDldmvaWRKpIwJnkK9u12kW2LE2xq/s7W+LAtosZ5zLL0E4u4v5DPa+BD8CHFhcmNGh94hxlm4mh3gx099kY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58c15de6-c380-4621-83a9-08d58db44838
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10324723D77F40AA8892E5BAFBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eCnhWxUf62Hq3axJJZQ9R8TFuBuDGid4s0Q56r48Fc4PbedSQwSi32AGOVWDa7eB8gytLKI3TeqcFLNlAZsUQP4rvM9jr/V3diDxxOWrf8pHCbTZJvtcl2p3tgw0/c1r3q+NNfNdrIn2bFpB4om/jIqjSkkU5gBxLcimAhdRoKkO/gogYWgCLsQNLlbs5cyEpJo6jeCZnYQ0p+ou6+K7CM0RjQTwpc1WYqflEnrs/Y67hzsKPzQ5dOJlNHhoKaiybZBN3vBzXdkjBhXvF1ivWxLheJJFQhnklMABAD/reXO7VMayax0wiImFeuRjDIoc4ph547qSBV52s0p7lVY9wQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c15de6-c380-4621-83a9-08d58db44838
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:38.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index 462b0a383353..8d36b4f551d8 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -874,6 +874,15 @@ static int i2c_hid_acpi_pdata(struct i2c_client *clien=
t,
 	return 0;
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
@@ -886,6 +895,8 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client =
*client,
 {
 	return -ENODEV;
 }
+
+static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
 #endif
=20
 #ifdef CONFIG_OF
@@ -976,6 +987,8 @@ static int i2c_hid_probe(struct i2c_client *client,
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
