Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495417-2-12818804877645599319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495417; b=Ccc0kQQYG1X1h+cYngd7oGRvIeGkHL2/2Ow3UGcRcg9+dh9
    wQ1/QcseULwcrkuvnUPaOKay3j+GDeGIWWISHF+YgKV8Ep5dp7CeRmjta9zIAobk
    k0ldY5rkqonBMjKUbk/Fzk+rS/rfUsqCCR5aRIhwVL1sgrdZYw6sVs8f+Rh/Vsqz
    aLDntYqcUaF8yDjk5zrSePUoZV5AlGiwZHMsr8b1KkkeZ50HP6y8ltSdyzuQbJ7B
    BvYuyMd08VRh2I7+LiqM48rXdvjAixARZTQVAvuqCiPFYZR4CBHYYA/tfxytqmE8
    1Pen92AR7Rnnn/K7qaXfnqiT4Y3O1HkSck/5f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495417; bh=391g0p
    IWF0QHDnGKd/x052NnSieAbr47FQRs6NtUBJ4=; b=XBG+O2b67NLnaQnczmjCZl
    QzOechAgcvUQx8IP2ThrM/cnU+MG3+nB50LoFsSmzzU291BWOanGtBHgL3IuwTZo
    izk+kQ+Uqke/6PfWutNMCkMaBjfxsBrU5QuaeYQUIha4umcu+VaRMAZ16+nlxums
    zePh/xKrpfH6Z+ZBg73Opxfj4OAQv1dqZZ4lXXw3a8f7L/v/Zg5OkQw23An1oPzp
    +qtCg9JXbRgcx2T0JTI6HcXvutKbuwCJvgZCanN+PSXyx8nPZ8zsF+BPBSm70PK6
    7gvSsFpaSVTb1U/EekblykKV6w7MXgB85h0++3b5ppoeSZzp1qYV8CG/DFtrlCfw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aQUfBgnY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekfeejnecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aQUfBgnY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekfeejnecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965112AbeCSP7Z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:25 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:52960
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965087AbeCSP7T (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 047/281] clk: renesas: rcar-gen2: Fix PLL0 on
 R-Car V2H and E2
Thread-Topic: [PATCH AUTOSEL for 4.9 047/281] clk: renesas: rcar-gen2: Fix
 PLL0 on R-Car V2H and E2
Thread-Index: AQHTv5sp1qTyHhGHtU+TjFyOSvCjfg==
Date: Mon, 19 Mar 2018 15:58:45 +0000
Message-ID: <20180319155742.13731-47-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:6Zi2YL6yYnFIPo/4jOBMuWIvPXqiG/z/gV4qANtxWdJKna4gsqP3HdXrahxcnBMqIlPW5+BFJup0V1syrRGkBg8kwbqnU1jCq81o5/qKW6ZQT4TFz8zvu4Fcm098RuODVuRPS3AhZP2Yma6oDedNvOLTfhumIliPgmvVUAUmKeYu1gSo//KHrwp1g43OSh3cdXtN2JZVcmt8ki76YfB+yR6rY3NL7DMUinIw2uzIMyjLbrxrOQcF1txMUpJyZAs5;20:aYOcejLiat+EF+Lhsww68855lzOfZT3oLqJAYlZ7VssobJO2XoeRbWtVs5E5Lqwg71s6+vCypqVZNwwfFdpesmDCVdT85KpkUrWGJea0dHq67EdUaEo+J8coHM/9K/cy++SvQlyZWjcUCPBvx6owTPUtlaj1L+JwKCqcDxC9y6E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d43ff060-8dd7-4b4a-8d3e-08d58db25d75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11092B9BBF37FDBB80E9F6D5FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(575784001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iH7jzRb6OdX5+hsfRbb2mSlO3J0jL8op0wImBPCiD71ZJGP8LeK9EfKmywPI/+mzDbMIegfM5E27XAxG94pvzI1RaCPKfwgKNxH8gm1wPDboMNRTJ/tK+X+rCNIirh7HaeuiTghhQ8lLwcl3i7XSKOPK2iJjFBAeBPNTlPu9OxCGLpfA60TXO8rTR9cKvMTqa8RxhuGgGivQlatYJ+CKMNYmeigtd4Cg8LV8Arj2uU/NiV9PIAFk6Xrnj8p4MIVT72UNg+soImpHBMzQmz4cMM6MNRO2EQUwxUGIcjThFVLFMUaUkddTcQcm8Y0jst/AIa61QmsETtaSFcTT1Vyk1w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43ff060-8dd7-4b4a-8d3e-08d58db25d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:45.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit b7c563c489e94417efbad68d057ea5d2030ae44c ]

R-Car V2H and E2 do not have the PLL0CR register, but use a fixed
multiplier (depending on mode pins) and divider.

This corrects the clock rate of "pll0" (PLL0 VCO after post divider) on
R-Car V2H and E2 from 1.5 GHz to 1 GHz.

Inspired by Sergei Shtylyov's work for the common R-Car Gen2 and RZ/G
Clock Pulse Generator support core.

Fixes: 7c4163aae3d8e5b9 ("ARM: dts: r8a7792: initial SoC device tree")
Fixes: 0dce5454d5c25858 ("ARM: shmobile: Initial r8a7794 SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/renesas/clk-rcar-gen2.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-=
rcar-gen2.c
index 00e6aba4b9c0..c55d5fe116d6 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -271,11 +271,14 @@ struct cpg_pll_config {
 	unsigned int extal_div;
 	unsigned int pll1_mult;
 	unsigned int pll3_mult;
+	unsigned int pll0_mult;		/* For R-Car V2H and E2 only */
 };
=20
 static const struct cpg_pll_config cpg_pll_configs[8] __initconst =3D {
-	{ 1, 208, 106 }, { 1, 208,  88 }, { 1, 156,  80 }, { 1, 156,  66 },
-	{ 2, 240, 122 }, { 2, 240, 102 }, { 2, 208, 106 }, { 2, 208,  88 },
+	{ 1, 208, 106, 200 }, { 1, 208,  88, 200 },
+	{ 1, 156,  80, 150 }, { 1, 156,  66, 150 },
+	{ 2, 240, 122, 230 }, { 2, 240, 102, 230 },
+	{ 2, 208, 106, 200 }, { 2, 208,  88, 200 },
 };
=20
 /* SDHI divisors */
@@ -297,6 +300,12 @@ static const struct clk_div_table cpg_sd01_div_table[]=
 =3D {
=20
 static u32 cpg_mode __initdata;
=20
+static const char * const pll0_mult_match[] =3D {
+	"renesas,r8a7792-cpg-clocks",
+	"renesas,r8a7794-cpg-clocks",
+	NULL
+};
+
 static struct clk * __init
 rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg =
*cpg,
 			     const struct cpg_pll_config *config,
@@ -317,9 +326,15 @@ rcar_gen2_cpg_register_clock(struct device_node *np, s=
truct rcar_gen2_cpg *cpg,
 		 * clock implementation and we currently have no need to change
 		 * the multiplier value.
 		 */
-		u32 value =3D clk_readl(cpg->reg + CPG_PLL0CR);
+		if (of_device_compatible_match(np, pll0_mult_match)) {
+			/* R-Car V2H and E2 do not have PLL0CR */
+			mult =3D config->pll0_mult;
+			div =3D 3;
+		} else {
+			u32 value =3D clk_readl(cpg->reg + CPG_PLL0CR);
+			mult =3D ((value >> 24) & ((1 << 7) - 1)) + 1;
+		}
 		parent_name =3D "main";
-		mult =3D ((value >> 24) & ((1 << 7) - 1)) + 1;
 	} else if (!strcmp(name, "pll1")) {
 		parent_name =3D "main";
 		mult =3D config->pll1_mult / 2;
--=20
2.14.1
