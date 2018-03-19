Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475162-2-9036411824801991016
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES rocaen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475161; b=pYPXUVNjVrLeFPLrGdl44wTpdA7q4KoCRvjoiadLBt1NoPv
    Z5OK3qrnfl4RCKdN7i5kbCJYx1sV5PNLn59Tgb3iJcQnS451rIShReSNy9xMiIwn
    /YSNOpRD4sDW/wcYiO9JIjLBLMdvW3y9V91w6vJ2B8IL0GyBB4iGdQe4ySdTYY0L
    5T+SPHl69VQmAiznj/471M44reICFPdmvCZMhvc9qIuu5shqbVynOQ5FN9kioy48
    Lgj6nlIuT8yemzCH37oaC6NMGZBjC4eUTLa+abVA4pOA/cRvV6XN476qstBxrrDb
    SsP15AcYeYiOdysMcVC9TcHgU+dMdIoX237irAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475161; bh=d6EY2I
    dttPr6/ywpMT2l6aA+OEN3POmgoZ9agPewZWk=; b=Qm/8WSkbQ/2ZUJdaP7P/Mc
    i4VyHWcpyk6g62rFbjHe/9g1y6+oAAI5nA24jfLJ9qdh7if3csNsHv8igPsNWLBv
    xRIBqQADtrafd+XYlCdXnbvrWalYvN/dmgsOMOlzpvgCDNzaOnk9ZNSQGM33r1CK
    DfZ2t+ahw2Kygnps0ehJXdrcOIU2iTrKWWwZyAfNBJiIBjTUAStZAOl35ul1CGk1
    tA6YDQBJVZtTqO5NZ4ZKEvyml8R/gpMUpXhcbXf4t9PWxEA2dxeFR3hBE34POyta
    CZzorFtSlfIFwK9fdpNEmk5Yi22iY/yBHF7szcQbaV7nBkYn1rlUAaHSeK+BXYwQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZdBQROaP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtjeekvdenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZdBQROaP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtjeekvdenucevlhhushhtvghrufhiiigvpeej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965084AbeCSP7S (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:18 -0400
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:23168
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965040AbeCSP7O (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 042/281] bus: brcmstb_gisb: correct support
 for 64-bit address output
Thread-Topic: [PATCH AUTOSEL for 4.9 042/281] bus: brcmstb_gisb: correct
 support for 64-bit address output
Thread-Index: AQHTv5slC/EdcMfHhk+PrFvRQDudCg==
Date: Mon, 19 Mar 2018 15:58:40 +0000
Message-ID: <20180319155742.13731-42-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:992n1l1V2b6DTT01yI8L2Zx6SY0Pj94R99m0GbHMPge830VBcIwdkJDXsYZr4I/350OLifnw+DgioVkkRYCvu5+CE0sJBfGSb/qw6XnkEUDqPtVPn9l9A8NGJ1GD3luVNTFNkdC03VFWRrpDxxTG3fQl6wNbX/X8bjLvTDzM0NT3B3fmy43oRNt0v4rzEDK4L9G6VL8lU98IrpjyghDZXX70Mx8e6hqrx0mlT/k5nGsv78zlaMbNI/7Iyji656D2;20:RbOmVCRJIC77TFb+HDOn+34g7relwzNuZwxOK72CHJRqC7J+a2mfR+JYEXLy1+ivXNg1zBQZRD8X8bIdnWKrSSh0LYVhE9rF5MQL+ftpc4opZofteCo+9cXGbLl9RJBit2DtxCSDsk6JFn8/YSPuj4udtBAZI0Eb/LNCj0URMOA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 349fc62d-65ea-4647-88da-08d58db2571c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101500BCE6A3CD4B41067E93FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(39060400002)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ojUre84ufjJahTNrVcQ8Es2I8h3IvCqndVKdCy7CYKrz/Rzqv2oZTH5iPHiJummStGAKEHRkcmJZf6MapDHd/Ot7KPaCsL4ixCYwKQ2EBgaaNl3gj07hAIBAm1yVQSmDwPeZTPwo5se4ki9EMCHVlCXxp5+wYy8hhkjYIZAsVxwffq22mwUEZdpgkBYsXBbCqDsMjC4H6hc0LZ3cxOR9GINtyS651nMXMpAxNz+p5jb4e21zfokLPlnTD2U/ryVBwF1lySkSZEHQ5xzFFRAuIEVXVKirZXr9ZnuAQBBIKspqxuHK+KT3lHutPDR1D7yGXkcSI1xVzC3Crev+r35jtQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349fc62d-65ea-4647-88da-08d58db2571c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:40.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 0c2aa0e4b308815e877601845c1a89913f9bd2b9 ]

The GISB bus can support addresses beyond 32-bits.  So this commit
corrects support for reading a captured 64-bit address into a 64-bit
variable by obtaining the high bits from the ARB_ERR_CAP_HI_ADDR
register (when present) and then outputting the full 64-bit value.

It also removes unused definitions.

Fixes: 44127b771d9c ("bus: add Broadcom GISB bus arbiter timeout/error hand=
ler")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bus/brcmstb_gisb.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index a94598d0945a..017c37b9c7c1 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -37,8 +37,6 @@
 #define  ARB_ERR_CAP_CLEAR		(1 << 0)
 #define  ARB_ERR_CAP_STATUS_TIMEOUT	(1 << 12)
 #define  ARB_ERR_CAP_STATUS_TEA		(1 << 11)
-#define  ARB_ERR_CAP_STATUS_BS_SHIFT	(1 << 2)
-#define  ARB_ERR_CAP_STATUS_BS_MASK	0x3c
 #define  ARB_ERR_CAP_STATUS_WRITE	(1 << 1)
 #define  ARB_ERR_CAP_STATUS_VALID	(1 << 0)
=20
@@ -47,7 +45,6 @@ enum {
 	ARB_ERR_CAP_CLR,
 	ARB_ERR_CAP_HI_ADDR,
 	ARB_ERR_CAP_ADDR,
-	ARB_ERR_CAP_DATA,
 	ARB_ERR_CAP_STATUS,
 	ARB_ERR_CAP_MASTER,
 };
@@ -57,7 +54,6 @@ static const int gisb_offsets_bcm7038[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x0c4,
 	[ARB_ERR_CAP_HI_ADDR]	=3D -1,
 	[ARB_ERR_CAP_ADDR]	=3D 0x0c8,
-	[ARB_ERR_CAP_DATA]	=3D 0x0cc,
 	[ARB_ERR_CAP_STATUS]	=3D 0x0d0,
 	[ARB_ERR_CAP_MASTER]	=3D -1,
 };
@@ -67,7 +63,6 @@ static const int gisb_offsets_bcm7400[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x0c8,
 	[ARB_ERR_CAP_HI_ADDR]	=3D -1,
 	[ARB_ERR_CAP_ADDR]	=3D 0x0cc,
-	[ARB_ERR_CAP_DATA]	=3D 0x0d0,
 	[ARB_ERR_CAP_STATUS]	=3D 0x0d4,
 	[ARB_ERR_CAP_MASTER]	=3D 0x0d8,
 };
@@ -77,7 +72,6 @@ static const int gisb_offsets_bcm7435[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x168,
 	[ARB_ERR_CAP_HI_ADDR]	=3D -1,
 	[ARB_ERR_CAP_ADDR]	=3D 0x16c,
-	[ARB_ERR_CAP_DATA]	=3D 0x170,
 	[ARB_ERR_CAP_STATUS]	=3D 0x174,
 	[ARB_ERR_CAP_MASTER]	=3D 0x178,
 };
@@ -87,7 +81,6 @@ static const int gisb_offsets_bcm7445[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x7e4,
 	[ARB_ERR_CAP_HI_ADDR]	=3D 0x7e8,
 	[ARB_ERR_CAP_ADDR]	=3D 0x7ec,
-	[ARB_ERR_CAP_DATA]	=3D 0x7f0,
 	[ARB_ERR_CAP_STATUS]	=3D 0x7f4,
 	[ARB_ERR_CAP_MASTER]	=3D 0x7f8,
 };
@@ -109,9 +102,13 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *g=
dev, int reg)
 {
 	int offset =3D gdev->gisb_offsets[reg];
=20
-	/* return 1 if the hardware doesn't have ARB_ERR_CAP_MASTER */
-	if (offset =3D=3D -1)
-		return 1;
+	if (offset < 0) {
+		/* return 1 if the hardware doesn't have ARB_ERR_CAP_MASTER */
+		if (reg =3D=3D ARB_ERR_CAP_MASTER)
+			return 1;
+		else
+			return 0;
+	}
=20
 	if (gdev->big_endian)
 		return ioread32be(gdev->base + offset);
@@ -119,6 +116,16 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *g=
dev, int reg)
 		return ioread32(gdev->base + offset);
 }
=20
+static u64 gisb_read_address(struct brcmstb_gisb_arb_device *gdev)
+{
+	u64 value;
+
+	value =3D gisb_read(gdev, ARB_ERR_CAP_ADDR);
+	value |=3D (u64)gisb_read(gdev, ARB_ERR_CAP_HI_ADDR) << 32;
+
+	return value;
+}
+
 static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int =
reg)
 {
 	int offset =3D gdev->gisb_offsets[reg];
@@ -185,7 +192,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_=
gisb_arb_device *gdev,
 					const char *reason)
 {
 	u32 cap_status;
-	unsigned long arb_addr;
+	u64 arb_addr;
 	u32 master;
 	const char *m_name;
 	char m_fmt[11];
@@ -197,10 +204,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb=
_gisb_arb_device *gdev,
 		return 1;
=20
 	/* Read the address and master */
-	arb_addr =3D gisb_read(gdev, ARB_ERR_CAP_ADDR) & 0xffffffff;
-#if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
-	arb_addr |=3D (u64)gisb_read(gdev, ARB_ERR_CAP_HI_ADDR) << 32;
-#endif
+	arb_addr =3D gisb_read_address(gdev);
 	master =3D gisb_read(gdev, ARB_ERR_CAP_MASTER);
=20
 	m_name =3D brcmstb_gisb_master_to_str(gdev, master);
@@ -209,7 +213,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_=
gisb_arb_device *gdev,
 		m_name =3D m_fmt;
 	}
=20
-	pr_crit("%s: %s at 0x%lx [%c %s], core: %s\n",
+	pr_crit("%s: %s at 0x%llx [%c %s], core: %s\n",
 		__func__, reason, arb_addr,
 		cap_status & ARB_ERR_CAP_STATUS_WRITE ? 'W' : 'R',
 		cap_status & ARB_ERR_CAP_STATUS_TIMEOUT ? "timeout" : "",
--=20
2.14.1
