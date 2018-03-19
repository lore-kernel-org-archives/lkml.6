Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480556-2-2205088128709365856
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
    t=1521480556; b=Qepr/LrLQQLCYD+nvtLJncF1UoVbxIfhsBteGIyYUJDKaY2
    wV62MurtQVs55ZLlRCrKtq/6SZl69ngC1mlM/rnhfIjcATNzTnB4UFmlM5x7fAKk
    8QPF14qLT34iIk1uVnF422JxPsuTCT2Lv4Dj1VogShLuIaxWcSd0z7wHjaDNCBNj
    SHCMMqpDggnj98ZlrrvnZDT7c5TCUKKIAu9+elMyKBtXsitdetwl4mGMW4I/ZuI3
    3NVXrAi041Bpqs3q8ovL4CIUl42P1iRa6Rba/bDiuOrnNBq50iskw0swKHPUd1S6
    vRPoIG33M/KRds5Rf4oBPHAHf4QyUbGgRcioOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480556; bh=E8oTKg
    QJIh9cqw0mlOGw6quihwOcplt8XJoQwiAYoZc=; b=Qt+1Ze/LLZUaq1yvlgXVH2
    pC5od2NQby8rUIRexaFzb8eafCc7E+MqSpALMzyiu/ZcTSDfCHhjyTEovydnhO6R
    YEz7SexSwbeJTBDcscc62sJ62KbVqFhs+z0n85awxaFQtUF1kOEg93XNxf0oSiTS
    qNILTXpJh2DKcgVZ2uZdrfgXaYfT0eN0m4RUbI+kS2re2w6RjLxzI9WPaGbqnzfp
    rhl8z+2nbGeCLE/FDXnMNkSuTjODRgXcCVns4kWkBcI5Qa2qXrK4eQHmPjHUrsun
    poo9Q92wxXXe5v77DZPpy8E0IhMVlZJvZ1tY2G1R6GwUA6mmK1Ag9Y0hqPmneRDw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OgTZApFS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdejjeeknecuvehluhhsthgvrhfuihiivgepieel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OgTZApFS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdejjeeknecuvehluhhsthgvrhfuihiivgepieel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966178AbeCSQHi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:38 -0400
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:6170
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966174AbeCSQHd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 031/167] bus: brcmstb_gisb: correct support
 for 64-bit address output
Thread-Topic: [PATCH AUTOSEL for 4.4 031/167] bus: brcmstb_gisb: correct
 support for 64-bit address output
Thread-Index: AQHTv5wscpwp/djUpk+/9OFJVmSRRw==
Date: Mon, 19 Mar 2018 16:06:00 +0000
Message-ID: <20180319160513.16384-31-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:oeZrYl3En+Oy8xhm9CS7NVmhbzvfwu2Il/dxfFqtoNvsW+XBeA/fwLVN6tLv6YlOUCrmy4voNrQq/irBCMqMQrgEh3muASZHT4kGLE30Vb5aAuNKJels1kYuWYadA/y8ewKwilq77g4brzQmWAR3pM1d2f7GybhWRwaL/ZPoIRl/kxcAIGThH4nmMVmMyWdFDLJWYjIijx+lLSO/9s+2FsdjtoJpJjdTDGmcFqn/mRl6JUqd5EUNy+BTb+AukH5d;20:l7wRbkdMq96cZO9+oz2LvOmozymyOt530GkTRR27DwO7aeCgzfqeY67mm/Q1fTzGzWS/fpDyvQ/DjfTonqyws/Xj8th4Ytn1Sr5ISzKHnnp9eE1/ekkLezZCR39r/dHmy4A9xMRccjdE2TSPZE1rwGn8w2nDhELdDFoE5w1BiIc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10fa1d35-0893-4f8b-e5de-08d58db38200
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10934A7BA028910EA9AC9624FBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(39060400002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(575784001)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Q7tOflHKOx6uR10bwnhj3Pxt1xvNmQ4r6c/7F+MIkeJRHl7jYYN6JSUNq190Useg63CZ429sHXbCmc0+jxJ9urLz7E6ylSUOyBABZI7MLk9moieSF9TcegWaUzJdFQwIlgzk47OLUGMuB0KPYzda3PO18FbktPLCPzgs3NCBiEbTppkfOV2DeKu2hF0pO7LyuJ36Abf8kMLqUvywpYFrxa33ltmBuejstbIvVLNX473odrR/r2t7JhvRqaVv/DSc1+t77LrYIFCBkMeWhKnE9xveCbdLlYKjCzc6FIjcTTL5onZxagamnAl4bVlDtM1k+C/cKwuvz7IX9xTkCW2FLg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fa1d35-0893-4f8b-e5de-08d58db38200
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:00.2072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
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
index 4917d649fa41..f59183018280 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -33,8 +33,6 @@
 #define  ARB_ERR_CAP_CLEAR		(1 << 0)
 #define  ARB_ERR_CAP_STATUS_TIMEOUT	(1 << 12)
 #define  ARB_ERR_CAP_STATUS_TEA		(1 << 11)
-#define  ARB_ERR_CAP_STATUS_BS_SHIFT	(1 << 2)
-#define  ARB_ERR_CAP_STATUS_BS_MASK	0x3c
 #define  ARB_ERR_CAP_STATUS_WRITE	(1 << 1)
 #define  ARB_ERR_CAP_STATUS_VALID	(1 << 0)
=20
@@ -43,7 +41,6 @@ enum {
 	ARB_ERR_CAP_CLR,
 	ARB_ERR_CAP_HI_ADDR,
 	ARB_ERR_CAP_ADDR,
-	ARB_ERR_CAP_DATA,
 	ARB_ERR_CAP_STATUS,
 	ARB_ERR_CAP_MASTER,
 };
@@ -53,7 +50,6 @@ static const int gisb_offsets_bcm7038[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x0c4,
 	[ARB_ERR_CAP_HI_ADDR]	=3D -1,
 	[ARB_ERR_CAP_ADDR]	=3D 0x0c8,
-	[ARB_ERR_CAP_DATA]	=3D 0x0cc,
 	[ARB_ERR_CAP_STATUS]	=3D 0x0d0,
 	[ARB_ERR_CAP_MASTER]	=3D -1,
 };
@@ -63,7 +59,6 @@ static const int gisb_offsets_bcm7400[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x0c8,
 	[ARB_ERR_CAP_HI_ADDR]	=3D -1,
 	[ARB_ERR_CAP_ADDR]	=3D 0x0cc,
-	[ARB_ERR_CAP_DATA]	=3D 0x0d0,
 	[ARB_ERR_CAP_STATUS]	=3D 0x0d4,
 	[ARB_ERR_CAP_MASTER]	=3D 0x0d8,
 };
@@ -73,7 +68,6 @@ static const int gisb_offsets_bcm7435[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x168,
 	[ARB_ERR_CAP_HI_ADDR]	=3D -1,
 	[ARB_ERR_CAP_ADDR]	=3D 0x16c,
-	[ARB_ERR_CAP_DATA]	=3D 0x170,
 	[ARB_ERR_CAP_STATUS]	=3D 0x174,
 	[ARB_ERR_CAP_MASTER]	=3D 0x178,
 };
@@ -83,7 +77,6 @@ static const int gisb_offsets_bcm7445[] =3D {
 	[ARB_ERR_CAP_CLR]	=3D 0x7e4,
 	[ARB_ERR_CAP_HI_ADDR]	=3D 0x7e8,
 	[ARB_ERR_CAP_ADDR]	=3D 0x7ec,
-	[ARB_ERR_CAP_DATA]	=3D 0x7f0,
 	[ARB_ERR_CAP_STATUS]	=3D 0x7f4,
 	[ARB_ERR_CAP_MASTER]	=3D 0x7f8,
 };
@@ -105,9 +98,13 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *gd=
ev, int reg)
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
@@ -115,6 +112,16 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *g=
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
@@ -181,7 +188,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_=
gisb_arb_device *gdev,
 					const char *reason)
 {
 	u32 cap_status;
-	unsigned long arb_addr;
+	u64 arb_addr;
 	u32 master;
 	const char *m_name;
 	char m_fmt[11];
@@ -193,10 +200,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb=
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
@@ -205,7 +209,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_=
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
