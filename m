Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493533-2-458001618544439256
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
    t=1521493530; b=qkh7RziQrDwk/1e6BrAOjVxRCefBKoyWGGzO0oA+TYAX6OG
    /STOB9bsSdrJDHsjZchKmGDz7u8ruPXRxJlPGrJSFsQpmIoOVpoa7eeRjqlDt8gJ
    GoK0KKSLvEVEuodny/9Bvn5jvn4lwraxQGPtA0xa+wNw6oxroCM6Oa31YvDw0gdQ
    OX7Le+oREjF+adJoArtur0J8ftYMpTQIT2W2XCCBwXOOaGMQqb6Bpj0ru4bGafcY
    C/uVEG1HFnsqVAxBOktt1KfCN+OFAH0Rxhjt6KxTXIEFLhwLNUjMNDD89XdINpbA
    ITdROIqqBr3t3oQEF0ANGzR5LeT1nckPiyzMGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493530; bh=pgrk+X
    gzF6RsYVpVWp3nVQ6fQU7ytcFYrE8E8TTqMJI=; b=rzGigH4k6BmRO+nXuNTTbZ
    QjVwYDdGhv+E3wMiprI5X7cngDtpBx0osvFjMbBOuEgy60gb7PHev5f9lh/CmZkZ
    AmkGlJfryMwWU+CkuJSrOr8LjHDGTAU9QVRLRVrClQ1w9FKJy6bZRioxTpJ0v9yO
    1z6HGSb0r+H3Xumn+IFrHl5y4BHyJaR/Ar2woVuaiBHfl7iK1CQ7BYBLRqMYxHeu
    rvvQLju5aV/bwqpQNseowoX5TCP1di2pVRGv2CeH0Xve9NwAnRNS64Im41fmcmuf
    cAOJGB3yyk3zjMBAfGOwDB9K8dQ540YQjBcLS30sBP2oLH1or4tFip9lNpPZZmXg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=luxhZajJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhitghrohhsohhfthdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehvddunecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=luxhZajJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhitghrohhsohhfthdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehvddunecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935253AbeCSVFM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:05:12 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:47488
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965405AbeCSQCK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mario Limonciello <mario.limonciello@dell.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 142/281] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.9 142/281] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5tu+TfSdJYQukyWkUaVlqLNmQ==
Date: Mon, 19 Mar 2018 16:00:41 +0000
Message-ID: <20180319155742.13731-142-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:PkaR4Wnm4MUWfAjfmq68isk7CEihsgg1//loB8itNiut1Krsolmxj2sJhXteuv6c/gLx6o4GJ+L00K6EkZFHlgw84KNu+Eh2y+MENfl69ybK3N1awDAcAzpktT7GXzZuYag72Qk0P+gEHJe/ch9redu28vLrqwaTyKWRxRfZ3XpAF1HsmCRBzwFJVv+dpjWhXhKW0xRoPmf7dKkGd6UtB07x8FmYpyR84lRyJFkZ/5oZWO3zp5rL4fnwOaPWHhRU;20:JclSGlckubyzrTyvAr16vPLJuEnJdSnrooAGB9LeF3mBNTX7QXKOljr9l3mZ/OEyHrMMB2qOh1oejbEHdhT22JJWCN+4jUENhZyjznd38dBE96+WNWY6Vp/TM+68QPqLow7zjoW6pIVuLB8zclJrJgxG9tvBFp0/TO6DdDCQdjs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4280014-d92a-4e5f-f0dd-08d58db2bc31
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919F1EDF5D3FFEA130F9E10FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(166708455590820)(233534484880143)(56004941905204)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6306002)(6512007)(99286004)(102836004)(8666007)(966005)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yp/fPkJ3u62g//euJcXKLtNHczCsK09ZkEb2PjZdCfmAdOLsGiURMcg4bcFYPgqvIjwKobVvTeTfib8gg2a83eN8/J2E/hdz4ZAeu+Jcyyv9svUPXGlWfWT0/WsYj3UYTlXhcx+1irvGAgwglPudzmeVWu+eYobbXeLmI8IiOoU1korWUh78UREZyou+8PaGFwEX/SJ26Ag0e3RDF34ahfAWOke4wdKfFnJXPC7frY9Vk81Q05RkT+jwpF47R7NSEW9zOuyF9kF2TjH98QBrYip49AyXY//0jbK4nWA5sgcyVgD7Sonr32lLUfzE72q4x92QuZPg6g4xoYqOA6j+Ug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4280014-d92a-4e5f-f0dd-08d58db2bc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:41.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index f0484b058c44..9a5812d60040 100644
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
index 1d798abae710..5f72a1c24c0f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1285,6 +1285,8 @@ typedef enum {
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
