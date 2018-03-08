Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488995-2-12030392034086755553
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
    t=1520488994; b=LT1LHiyI+MMVIyG7Ye5aVbEOxPMzPOAt0G0JfQG7hiypBZa
    4G+Eaa/qqtJOZmAee/YWRLQEU73NfBtECSkO49BdxzhGoAdlLCEK8u4Uq3DXzdLy
    coM6de4EPFO+seCFDSVY0RiEYRFoKkPE8IFgnFbhqPpCK4smPlD6t036rDIvVwGq
    MqgVHqB0byFWipeee1rz0kWvVLmdDn/VEeNqxJxQrzreeeAPLaOR5OzVsSrok22u
    EM5UBONem+5cFrX6JHDNbBMRqTVip8NviPuWKorNR7Wxw0y/aYfYb6qicWst4lAt
    phUy+Hz6/PaNsQxVSxYnpff8q5yvLDnZp9tfwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488994; bh=vmfHId
    RYAB33aJD6teeBFdY+lwEazhtC7zke105KyPY=; b=hKjhyapq/ZjV9JYAJuF1yb
    v1zPMJ7o0ymr2q5x5BdUz2+THGtO/ZYCO4GpkCpvKUpiKQxsUsTy2Qx6jK/31fK2
    2JIEu+BqOLXx0fN8Qmyf4x8wIOp83+H3xT/9LnamVgS5s3JD/8CW2yz6ISGBcnHy
    aX+pAwQY7jt/cowXiQa6UJxV8YROzxR6mCah/Hya3kTHtSDXoitVo/ExJoYDbY5n
    4jhVsW9grTpnhtbsgzza3v3wzxGUPtVjXkRKZQk84MysdOV6Dervh9EHpGttlLsz
    ZKsGEUzMeYfFuD4+RyBK/35EgL7+cyPOqkJoMpAeID7nw5VrSBywxuckCRHjZX/Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bEv6GUjs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bEv6GUjs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965942AbeCHGC5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:02:57 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755369AbeCHFCb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:31 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Oleksij Rempel <linux@rempel-privat.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 114/190] platform/x86: asus-wmi: try to set
 als by default
Thread-Topic: [PATCH AUTOSEL for 4.9 114/190] platform/x86: asus-wmi: try to
 set als by default
Thread-Index: AQHTtppEc2Ov79EDVEqx8hTNZ+GNfQ==
Date: Thu, 8 Mar 2018 04:59:42 +0000
Message-ID: <20180308045810.8041-114-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:eZWv1bZTG6rF2rcYRQi1IWx1qvE/SbEo5VGYY1pTbOVdhmDFU84QIgz0Dx1/tHEvmIiBbwD4QCD+Vmju63MENJMDzJSYTQ66vspzOemL3vgHzsruGt/6sTBEpLWZY210nenS1vsk8w+I+qeHrRpUhpdTeZCWoWydtL84uKV59cK3ngjtZ3h+4XzOkWEG/CS7UUUV8p/iEPaYZHtuq9LdMdTdiwGQEwlLZRG5BIJysDIAGXj1UctbygwB9tF7ZxjY;20:KTDxU46AULaiOvoei6cpug4xozvnlg9tzA/nESbTwvZtN0ymMfTvhTNI17O5nRo/XhYo1Vo8CIyxr6prSos4yKUOGdGY5H+oZLsALMvwIHTH3JmtGbtq9ngWEgjeyWUF6uKHNeXfds+cY48HmMA0dD632oRLd+8SGcH+bNAwBEY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0751686-464b-4965-ef97-08d584b1c3d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09976BFB1A15B9DA44B87EEBFBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 6+jYRguWmRdyXStYVr9W5fi8KwsO/f1MEa+3c+LfC8/Eod9xIqyACbM6GoveB1FPVgyU0omeOi4fvVf7GC/47LrcLZBsZC1ZihP/+OAYOtoKxcENbtVv4E+DAfqR+4xicbW/fHJG5ScrS5eGGrhOdWAHoXB9yM0AVL8UkK+py7//20Sj0K2LK8VaGIDhiMWtwfFJLZYOUGqNsK14xkESW2T+J1fqUewGwc3fis9M2sZVVik3C+LpxwtnPSjgC1+BfX1Z9Y9GEnCE01ZEISLy4n++75DojqPF92Wy1I7kT8HTZNy9PFyXwWNqk5CLN8eePnewqDcNUU1T6tPij6S84w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0751686-464b-4965-ef97-08d584b1c3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:42.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Oleksij Rempel <linux@rempel-privat.de>

[ Upstream commit e9b615186805e2c18a0ac76aca62c1543ecfdbb8 ]

some laptops, for example ASUS UX330UAK, have brocken als_get function
but working als_set funktion. In this case, ALS will stay turned off.

             Method (WMNB, 3, Serialized)
            {
	    ...
               If (Local0 =3D=3D 0x53545344)
                {
		...
                    If (IIA0 =3D=3D 0x00050001)
                    {
                        If (!ALSP)
                        {
                            Return (0x02)
                        }

                        Local0 =3D (GALS & 0x10)    <<<---- bug,
                                                    should be: (GALS () & 0=
x10)
                        If (Local0)
                        {
                            Return (0x00050001)
                        }
                        Else
                        {
                            Return (0x00050000)
                        }
                    }

             .....
                If (Local0 =3D=3D 0x53564544)
                {
		...
                    If (IIA0 =3D=3D 0x00050001)
                    {
                        Return (ALSC (IIA1))
                    }

                  ......
                    Method (GALS, 0, NotSerialized)
                    {
                        Local0 =3D Zero
                        Local0 |=3D 0x20
                        If (ALAE)
                        {
                            Local0 |=3D 0x10
                        }

                        Local1 =3D 0x0A
                        Local1 <<=3D 0x08
                        Local0 |=3D Local1
                        Return (Local0)
                    }

Since it works without problems on Windows I assume ASUS WMI driver for Win
never trying to get ALS state, and instead it is setting it by default to O=
N.

This patch will do the same. Turn ALS on by default.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
 drivers/platform/x86/asus-wmi.c    | 12 ++++++++++++
 drivers/platform/x86/asus-wmi.h    |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus=
-nb-wmi.c
index ab44326ea3e7..687cc5b922ee 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -120,6 +120,10 @@ static struct quirk_entry quirk_asus_x550lb =3D {
 	.xusb2pr =3D 0x01D9,
 };
=20
+static struct quirk_entry quirk_asus_ux330uak =3D {
+	.wmi_force_als_set =3D true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	quirks =3D dmi->driver_data;
@@ -420,6 +424,15 @@ static const struct dmi_system_id asus_quirks[] =3D {
 		},
 		.driver_data =3D &quirk_asus_ux303ub,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "ASUSTeK COMPUTER INC. UX330UAK",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX330UAK"),
+		},
+		.driver_data =3D &quirk_asus_ux330uak,
+	},
 	{
 		.callback =3D dmi_matched,
 		.ident =3D "ASUSTeK COMPUTER INC. X550LB",
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wm=
i.c
index 8499d3ae4257..8a1bfd489c26 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1108,6 +1108,15 @@ static void asus_wmi_set_xusb2pr(struct asus_wmi *as=
us)
 			orig_ports_available, ports_available);
 }
=20
+/*
+ * Some devices dont support or have borcken get_als method
+ * but still support set method.
+ */
+static void asus_wmi_set_als(void)
+{
+	asus_wmi_set_devstate(ASUS_WMI_DEVID_ALS_ENABLE, 1, NULL);
+}
+
 /*
  * Hwmon device
  */
@@ -2120,6 +2129,9 @@ static int asus_wmi_add(struct platform_device *pdev)
 			goto fail_rfkill;
 	}
=20
+	if (asus->driver->quirks->wmi_force_als_set)
+		asus_wmi_set_als();
+
 	/* Some Asus desktop boards export an acpi-video backlight interface,
 	   stop this from showing up */
 	chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wm=
i.h
index fdff626c3b51..5db052d1de1e 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -45,6 +45,7 @@ struct quirk_entry {
 	bool store_backlight_power;
 	bool wmi_backlight_power;
 	bool wmi_backlight_native;
+	bool wmi_force_als_set;
 	int wapf;
 	/*
 	 * For machines with AMD graphic chips, it will send out WMI event
--=20
2.14.1
