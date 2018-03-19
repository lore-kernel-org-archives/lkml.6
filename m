Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493227-5-18213748419383670589
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
    t=1521493227; b=bP/i2Jh6DmxZJt9DmDH5dBmm+VuGEi4SdGRiL2y46twisv9
    eJOCA3oFcpvvkZff44x1a0l5HaEG09pBgwv7rjxuAKCX5xZZ/t5qnFACo0iDrNei
    4PceM5sh1Zmqs4EdrOXr00sX45lmXzUIfeB2Pobr0uEqGp3BAtJ+QJZwCttbd2Qq
    +JDgG86l3hSIR0gpiRr4IqnivLw/9ARHC6PChmmlvj2WyrEUZpNnRNSB0F6tGW+N
    NLWFpwMKu0vBWYVwZ7WjjjOLQ4rO3VBbr4kgyW1DwC2yLF8S8cASOGhJjupW1e/4
    Ucc6UtRGBR4/OvXv/j+twKrYcUmZaRphS687A0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493227; bh=p6821A
    1kGZBOIU1MitjWFXUGNMyNi7Buop/cBms7ThA=; b=hQLajegMn8BSoNhVvSNUCk
    XXDqvB5yB8LyiW7v7OvfML+jM+eocHRd0QhZdrLYG9+yRvlQP4ZovghhqbBFaUBz
    mnm8QjkiriJyYP2CNAr52f/106E92mMURLFsR0Csrmg229Iy1JSsa6Cd5OaWvDzr
    5g+rGQmyrPSgI8vCsoIh8oK+KA2rWg0x9o2URmAww+s6y/ojodPPT/DTzdHj5yey
    IqrgQtVV/C7dTKQqmy3M8mS8O3bpgGBsru0BKi+wMHZu9t7v6aBj+75H8bDqwhB/
    xHDMeAqSpaU0m5MFGBxfsC62talA19H+q8nA+XL0pjFM+cm8SwMJvys71iHnPkOA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AOPmBqOM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeifeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AOPmBqOM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeifeefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965501AbeCSQC5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:57 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934977AbeCSQBr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 128/281] ACPI / video: Default lcd_only to
 true on Win8-ready and newer machines
Thread-Topic: [PATCH AUTOSEL for 4.9 128/281] ACPI / video: Default lcd_only
 to true on Win8-ready and newer machines
Thread-Index: AQHTv5tkZBIjBXM+/E6dOgBt5gPh5g==
Date: Mon, 19 Mar 2018 16:00:25 +0000
Message-ID: <20180319155742.13731-128-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:yZGCtmnb1ExF3e4uQ0FZaD9iV3ZHcZfrbriHrK+uef9KW5OToW8Q5HC6KokVbml+8pQF8dNZhNB0l6JywUi2uwx2wyK6AemliOLkwZXLC0t85uGz0fV+NtQxjjhLULLcmIqsXErbzP7uyNpesVYDcnl549s6G+JBpZaJt/CIORYXN2vM/PvRey4BF4TlFTzdGWSrrI6D6Ywt1S+K7cBcL2WWghz4OlzFZ8bq5LaO7MrCoML9vb2WQn62r7dG84Gq;20:TJScX91iKXSTN9iFfwt81EnfYPyn4tbmlJZrFqjERbTm3s1GSojgGbxpnjfQPjb7ENQssa3DSK/PvJqhHG2ZCE4nQdc2529qqrC7P/XgO3CUtsT7p+BG5vzGJseLqHL9YQSWYYibhlIMeyHt3h8Xy68VdggoBiLnAphfagi7awg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22754e1e-50cd-42aa-3be9-08d58db2b69c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919F9782F9A96CF268EDFF3FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(83566789882024)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6306002)(6512007)(99286004)(102836004)(966005)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9cwqCPnCoobcM4nOL9n+oVM/+hfl3gh7gWVI2ZeuD3Oqgnzp95jNlvq9Xjo94q+79GdFoKW9eQWoPnxKbj7ctq6x4LbyFh4tUfdSAZPq4JYNTDROpeLE2/oMwkwybuzLw5YVRK7gfoTRSmBlt+hc8uAr2E9OVih2W6+07WduoexVsSCrLty4UXWjGQLOWS0DCeYt1+C1R3E/9Mg4n8NHTVxAGRB1ZqSdBS74+MUm2u7dfTsod9H0BAFmH5CzkZka3zFRqg3x+Z4HlTq1Zay+VbhuFUfz7sOU2wspS12DSRBmKUz2vAL0AzItNCgnXqP0GprFkAt+xJCyciIiACOssQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22754e1e-50cd-42aa-3be9-08d58db2b69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:25.3448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index c5557d070954..94e04c9de12b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -87,8 +87,8 @@ MODULE_PARM_DESC(report_key_events,
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
@@ -2082,6 +2082,16 @@ int acpi_video_register(void)
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
