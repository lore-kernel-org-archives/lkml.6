Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497049-2-201598055049910680
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
    t=1521497049; b=OT1ppMOTHh7odY+K0H0oj8m9y85EZMeVU6trXBu382GOfiI
    +1GXuoJ5VNrEr3GYvc/16GmfyTIVQiecyjjTVuybXArmCweF5BvbFFUSpfFE51rg
    xOjGie3ikemU7kWofYh7B3z4vC/Ym76eip9XByoafWBWPEKjGm7pYHuzJeS/7pwk
    7u5gphAPinQ7Zv+5PLQ7PX7XZBNc9EjvkLN1usgB9tzJiN5LdY9K268ze2UN12Da
    zpyAq6Q+tg6pw/95eBrBhVAINYeZ6lIfuPdPNiVOwY9e7WcsnnCmLN51P1IIDIK0
    yj2nE0KwzcPxQ126ZsX9ILBKS8viI0rc/StpX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497049; bh=bxJY+0
    6jQ0nFykrabnB6CoakGvKOxeLrOQzPcCjJGdk=; b=NsnWRaioVpuznD/halM5mo
    PbJJhv2wWz6GMycCvcPSaCRKSdQ7CcG0C9A3C1Q+HVb54hXC1Ud58ZJMRO2EEW6O
    0eKY2oogBuKWwJDZjjglZcm3JRSR/xv16yaa/e6Y5olVzVusntAaGvV+l1188Cgg
    K7FtfYWzbxef+uDVyPtE6jNElx/ntoq8juS1TTKi33ktPmIx/+q4yWYWSf4st6zW
    3IAKnahnxGk7qw/D6dfJssZqjVliKCZTLe16uht4GQb/bQ5iUg3no48gJ0z+RQ5t
    +rRq/n0e0kOyv1EIbkbcbphAYdlqN+xyCFWCvhUnvYsf0BUr8LrjGyDd/gW2MGhg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=apXe167k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhitghrohhsohhfthdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehudejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=apXe167k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhitghrohhsohhfthdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehudejnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934414AbeCSPzx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:53 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934388AbeCSPzp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mario Limonciello <mario.limonciello@dell.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 38/97] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.14 38/97] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5qrQFBRO+bsskCRDzLg1PsdJg==
Date: Mon, 19 Mar 2018 15:55:14 +0000
Message-ID: <20180319155411.12348-38-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:7RtoTQUON+bgahlaN+6/++X8TVwiOY0YOq0Ixgk4B2KumPqVtUUf/Oq9tp1A94Iku+d/wIPgUrXETB4/NCoN7efHTsq8HmadmRwUjbGpfs+6CpMUCPfYT7tHn8mngEQVm27rXg1yb0e1F1hAEXIQgPe2MALmP/qFMBuLLe8qBhhbxM+h+fZ+D5wAW56PDds/++jbIa14H4K/GOy5a2h0QA8/gJSnczhHanOjYg+XCPHSU7zZTzHB1SSSrXQwuFnp;20:rVI6DyP8KUWaijVBSjANLIXxsPZ09N9386bfykLRFLOKbX74lE6LZDJKQJHoCWLiHmxG85ltCMB5/rTTgNQJagRw1Z1agbDe9adFC6az+HeIlsickkY5DZjCuwvFCK6BFf3T5EJUH/2oi9YSzKuRmJcaa+3K1Tjb0njHNn/mYEo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef016a2e-2ee7-4af2-8452-08d58db1dee0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967786A6EE99C92FD113505FBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(166708455590820)(233534484880143)(56004941905204)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(966005)(107886003)(106356001)(53936002)(8666007)(6506007)(6512007)(6436002)(6306002)(86362001)(575784001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: VXt1AW0nUJSyd4XavRRhote+5/0iZ+s3XpGi6xGsTgngeXVYS2Y3gPsginVQZgvVZtxpkLv8P/m4VnspGqOdMCPCQSQQ41SkibXCnqUJ0dXiZWDJTjVkDJo7UmaZ6MBlw01xdcTee1tX30SYsln2iCfP0Od0ycG2H2VZiAGpb1QkeMtEIVouDlj7hsjTQMpx4efn2BYFa87W25wUYsRlAgVVJ2l/mf81TY4B1N/S+axXxkaSBzt17bpUpeYiM83OYet6yoh45HY1cHAZSxiPnCihd3N7WxMSUV1/7OVrZtwaGxjCQeei1lbJk3To3EtXd90zvN3hyXbJRX4+xZVADQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef016a2e-2ee7-4af2-8452-08d58db1dee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:14.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mario Limonciello <mario.limonciello@dell.com>

[ Upstream commit bc4d413a819f9d0764a80a55875a5d7e1f4efed4 ]

ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713

The public Microsoft document listing recognized OSI strings [1]
shows that these two strings were introduced.
version 1607 / Anniversary Update / "Redstone 1"
version 1703 / Creators Update / "Redstone 2"

[1] http://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-ce=
7ce0d98dc2/winacpi_osi.docx

Link: https://github.com/acpica/acpica/commit/35a4a3ea
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpica/utosi.c | 2 ++
 include/acpi/actypes.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 3175b133c0e4..f6b8dd24b006 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -101,6 +101,8 @@ static struct acpi_interface_info acpi_default_supporte=
d_interfaces[] =3D {
 	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server 2012 -=
 Added 08/2012 */
 	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and Server 2012=
 R2 - Added 01/2014 */
 	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 - Added 03/2015=
 */
+	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10 version 160=
7 - Added 12/2017 */
+	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10 version 170=
3 - Added 12/2017 */
=20
 	/* Feature Group Strings */
=20
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4f077edb9b81..bfc8a814379a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1299,6 +1299,8 @@ typedef enum {
 #define ACPI_OSI_WIN_7                  0x0B
 #define ACPI_OSI_WIN_8                  0x0C
 #define ACPI_OSI_WIN_10                 0x0D
+#define ACPI_OSI_WIN_10_RS1             0x0E
+#define ACPI_OSI_WIN_10_RS2             0x0F
=20
 /* Definitions of getopt */
=20
--=20
2.14.1
