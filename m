Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493455-2-11185992699072379788
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
    t=1521493454; b=D4EltWoYvy4452qU3NCCBlE8/+wvwWw3IsLWuJTgFDJHOlf
    w2GYLFhOp0fg8e5SqGAiaw+J9rdCZo72ggRYPP29ILQY4QslDNH6sUixgISBadTa
    KunM0cUFdXEVUQCw52hz1ZIMVD3G20vndUTTJnXJn32d3OCARHKAdb5mNMxJncw8
    vrRComu4lHL+tBQ6BdH4ekMOLp4PU5bWHXV03Aogk+WIhF4pkkHnDI0mnuvAnDU3
    sgSwlL0qxICre8Rm/IR+DJn3QvF+NEUu2DaSgFMSxTvlOG0oJ0y2MfAzN8kUQnH4
    YxwrTwL7dtop9/+leUnrEHYXZlfLPbQiSSIXGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493454; bh=Ok9Ecl
    bvHzltjJa8wzTlBewdHZSrUfe+CzzaYV8iY6w=; b=SO97zuLhZZCb/qc6A7G1W3
    ZfI1+ZaHr3PMDI7X+OKtuRKyI7CNq5ruN9VekhScx6nJVvrtx/i5B5OJHK30JM9Z
    c+1voE8u72B+snPJdrL+/w6CQfmP2xxGLbV9fvIomXZ/7Pwl9E+xTA5rcms0ucLu
    RLyxizabFXuse57jvQD4wfY4vnD+D5bm9A4bpLSiJTHNYjjULbPcncPeFS2l4ki6
    3qB3CXsvvWlzwXoBwyF1jhJ6tEiSSAIJHKX1ftJb0avqV+NMVsgwECKyJY/m34WV
    hUCThj2eQMELgSpdMVBawiDmxdARYTIfSLTNcUbizd/KSQupoBLYYI4aiK8QwB8Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ETaFZBHF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejheenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ETaFZBHF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejheenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967147AbeCSVDd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:03:33 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934489AbeCSQCl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 155/281] HID: i2c: Call
 acpi_device_fix_up_power for ACPI-enumerated devices
Thread-Topic: [PATCH AUTOSEL for 4.9 155/281] HID: i2c: Call
 acpi_device_fix_up_power for ACPI-enumerated devices
Thread-Index: AQHTv5t3JTljixWEdUWtWCAl+bocTQ==
Date: Mon, 19 Mar 2018 16:00:57 +0000
Message-ID: <20180319155742.13731-155-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:V69ULoVwolaRq7JIWbyozUwNAUtPAUJ4x4AjeV/p2i1V5BSAUQDDrgtIKoFEF83lT2p9GNHfuj9nxkxUs2pwSRCF7ej+3Y0BKJ7e6VnJQ3SWvL5rCK6kDdS99uyYjkxiMEqQAYX2GYLbzftXMUrywlODgbn/0ePthdThRe4+YmXMiFFY6Kh85efadFx6ZG0ZbFpVlKvnaBSEYi5BcqeY8vzUxt/R7whYTeXY0aeNiSM7+r7K3i+XFcx5QSWb+D2y;20:pJVZpBrSmzxFBvxQ6KPziPYkWGE292pB0CXdNInHrguMvFgURiOBm1DwTgAlgNEfwlI9DBRUHZkMMFjMiIOrSxI/Lbim8VguF55lk4uSRBf6k+AH2fWKGeYUzJt3gfngSOx926agYGPTi7g/iGGIjGEgyopI26zJ46TUXidG8uU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1647d55-7eec-4075-acb8-08d58db2d604
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10620DCB91F5C80292399D9CFBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(8676002)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wjESFkfadk1QairbEd9otVaqN91n4qMaroxRDGqOXq/nfkDBIrzb3CGbr/mU45iR/3tSx1b1en24kSPNhYkhfYZbPplRs+jdKE1spkNGj9zh4GiPojLXUjKjIZb49Aa1uQBojEf3Fab1iItKJtKRVLPAODT7lrqsFUhTpE1b6yWVxfe6v0BOYVaA6Kj09q/3AKpTnGLVJ4OgyVzQRKN8Dx+HTMo8ZeXGUbJDlGITc1DsS64BAA7HYHeHYTCeGNBB9SEQdxQ15dinmXpm5ARcVeMWA3RCj/XTUKDo7dKeBK/ItsloUCk8RH0P4UbKdowEdDBNEO3mnyGn/ENS0cMg1Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1647d55-7eec-4075-acb8-08d58db2d604
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:57.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index 865e7c262322..7d6da9b43dab 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -968,6 +968,15 @@ static int i2c_hid_acpi_pdata(struct i2c_client *clien=
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
@@ -980,6 +989,8 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client =
*client,
 {
 	return -ENODEV;
 }
+
+static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
 #endif
=20
 #ifdef CONFIG_OF
@@ -1082,6 +1093,8 @@ static int i2c_hid_probe(struct i2c_client *client,
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
