Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521474902-2-1912308373860042759
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
    t=1521474902; b=JfQqwarOwDD93kFSkZGPf7wGPoVZ8PRBqX4QTHGFQJanMob
    +YIijTZjyDxqg5RxD+iXiESSKVLOU5lDw/2Doe35UVgHaU9CCI80kv3K0xX2QeGi
    XyS8zwdih2hay/HRbkdJDsGiqhZs7TyuIi24KysERKmvzrupREnOIAbmImmc/4tL
    kNGIV5UPcNZeNrGTtai/8OVMDOVDyVCvR70UvPtVOzrWJ/1H2zR7zwkDQ4OAq/lJ
    Z/NYjXHNfe43J9CaLkkmZ6M3vcChe2JqZEn3ut+C2mukEuX1LsrYEx7q6IAA/2zT
    Uls9ZQ7EnKxSztL1/T3SXbvwWapeDA58iC5bmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474902; bh=txxx+L
    Wgpbp10dYyJujSOkFgSIwXqZKBh6NHFTj2tyc=; b=HKATNqjZF9Gt7Vx6Sl51a+
    A8BdTVKldB9C/owsIgzNtmONCQ9tUagEKflen8yqVMPEHrYn9/CQxUVtpMRSxINH
    hdpdWDVI5leCTyb2xngV/o3whPwX7M8wUCqMjShXWx+6/535yokeknPFR8bbvP3z
    s+f9dcY9unWUwa9mClDoNaWehnXMXVDSFeX3W0PwCQ+TaVfhwfLG7gu0xk0lyGqL
    6iJ4WES8x3UEwqFHWVQg+M2f7QyBPj7V/0iPhdtviB3lcZz5WE8ZBAmIWENoj4L+
    HgcelLgJrGB1F7FcYpGd9K0OLQfrFj0wsxI8JSB399SqTZ43/XHOt5eM55cMRPdA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EUzYYkYz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelieefgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EUzYYkYz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheprhgvughhrghtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelieefgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964778AbeCSPy4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:56 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934319AbeCSPyu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 16/97] ACPI / video: Default lcd_only to true
 on Win8-ready and newer machines
Thread-Topic: [PATCH AUTOSEL for 4.14 16/97] ACPI / video: Default lcd_only to
 true on Win8-ready and newer machines
Thread-Index: AQHTv5qWHTJeQMnKJ0mxqbTy4niLyQ==
Date: Mon, 19 Mar 2018 15:54:40 +0000
Message-ID: <20180319155411.12348-16-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:5ckL6Bdx8u/ZUEkU0bMB/6kq8L+IqtI3WxkL3g0R7E3pY2/rh26xXIeXQONPBms0QDbnn5kqsRA9qj1rLn5N+ESYGEia8GevAKsPR2j5u6gmxZ7D+1OS6lBFGUAW0XwXgbe7bbi3dbfwvf/vmAGO12sQ2mjFbOmUOZCwhjMJlmKJ0sp4n9iG2COwoSlSbFxlYKkkWgO+NVqYa6QGtUjlKwavvU3WipD6enCe+5j096MVEjFPB/Sw9Ygnt8ou7mRh;20:GHT5JWwFDxeuLhc3csZrVwiUYAIs368iq1DtjXhym8/CKtiXEkX9JS9Ca0KxJHf1NGkmfkTthM4KfF28OVjIBIH9j0Dzb+80zpHORA1EOBMBunv/f5Br+4U5mXqiFR3ZIg27yHw5rjl1h/1qTaSKU2cks95T9aVFjSfGrTT39NQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 100382c5-43e6-4d1d-8994-08d58db1b998
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08060F18F3E04379CA657531FBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(83566789882024)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6306002)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(575784001)(2906002)(25786009)(966005)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: R1r8eXK8VOzs4yux6oqkm3bpG6umoZrL0eiMjlJazWQ3psq6s6s1MAhSY57pSCrkkVKaNRzB5OaNQ6kEuHqkBE09E6rIdtCFNmpfYOpKmQ/IG7EYAHJFRYMAxis0a9CGjBey+iPYZQIiuaUPOV7FjOVSVyeC9F8BAMNWzDOQpQpu4xdYKMcZ9bBkFR1C8CT4uyprDQdFOvkXEB2hL90fUmROvSIvhuQhRr3j4Zs22KweFyZKvwDCNMKCxxtxYXIuGH+78eH08L7ttehkwpHepXceq2HgAxhwXbifkyfZ8Ik5sg8CQDgzjwOJvZ385z4AeV5A8FK8ip68X5Jisn5o2w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100382c5-43e6-4d1d-8994-08d58db1b998
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:40.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 5928c281524fe451114e04f1dfa11246a37e859f ]

We're seeing a lot of bogus backlight interfaces on newer machines without
a LCD such as desktops, servers and HDMI sticks. This causes userspace to
show a non-functional brightness slider in e.g. the GNOME3 system menu,
which is undesirable. And, in general, we should simply just not register
a non functional backlight interface.

Checking the LCD flag causes the bogus acpi_video backlight interfaces to
go away (on the machines this was tested on).

This change sets the lcd_only option by default on any machines which
are Win8-ready, to fix this.

This is not entirely without a risk of regressions, but video_detect.c
already prefers native-backlight interfaces over the acpi_video one
on Win8-ready machines, calling acpi_video_unregister_backlight() as soon
as a native interface shows up. This is done because the ACPI backlight
interface often is broken on Win8-ready machines, because win8 does not
seem to actually use it.

So in practice we already end up not registering the ACPI backlight
interface on (most) Win8-ready machines with a LCD panel, thus this
change does not change anything for (most) machines with a LCD panel
and on machines without a LCD panel we actually don't want to register
any backlight interfaces.

This has been tested on the following machines and fixes a bogus backlight
interface showing up there:
 - Desktop with an Asrock B150M Pro4S/D3 m.b. using i5-6500 builtin gfx
 - Intel Compute Stick STK1AW32SC
 - Meegopad T08 HDMI stick

Bogus backlight interfaces have also been reported on:
 - Desktop with Asus H87I-Plus m.b.
 - Desktop with ASRock B75M-ITX m.b.
 - Desktop with Gigabyte Z87-D3HP m.b.
 - Dell PowerEdge T20 desktop

Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1097436
Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1133327
Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1133329
Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1133646
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpi_video.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0972ec0e2eb8..f53ccc680238 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -80,8 +80,8 @@ MODULE_PARM_DESC(report_key_events,
 static bool device_id_scheme =3D false;
 module_param(device_id_scheme, bool, 0444);
=20
-static bool only_lcd =3D false;
-module_param(only_lcd, bool, 0444);
+static int only_lcd =3D -1;
+module_param(only_lcd, int, 0444);
=20
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
@@ -2136,6 +2136,16 @@ int acpi_video_register(void)
 		goto leave;
 	}
=20
+	/*
+	 * We're seeing a lot of bogus backlight interfaces on newer machines
+	 * without a LCD such as desktops, servers and HDMI sticks. Checking
+	 * the lcd flag fixes this, so enable this on any machines which are
+	 * win8 ready (where we also prefer the native backlight driver, so
+	 * normally the acpi_video code should not register there anyways).
+	 */
+	if (only_lcd =3D=3D -1)
+		only_lcd =3D acpi_osi_is_win8();
+
 	dmi_check_system(video_dmi_table);
=20
 	ret =3D acpi_bus_register_driver(&acpi_video_bus);
--=20
2.14.1
