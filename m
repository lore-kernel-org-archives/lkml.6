Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120685-2-18396723376415689368
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120685; b=B5Sr9ktAYOmaax9rQ8i6Lp13nz0wgLQnNkMk1aKx/6kgXKZ
    iYB1JfRkyF8I2LGumSfZ5bjCYwHNMTQm02YHzWndlOHpG+mmI8TeQQCKPFbOMSTE
    3AzsuXO6vaGQEVVgbDR4LOAN5RHl2e7XRPJdJ3K1zJ1vzjXQmDPKeewcryVENH3P
    7IvgsI4C24z7FBTf1SoC3lM39LGBnLad+UkzjA+Qw9tvXtcpsE5JKe7O9Msag9dN
    f2CnCT2R+23HDPgzO4Jlmhyhn1c2xaAz5zslyl1NRluDcjx5uDteBakdoHRNt/CM
    rPBhoJfoMrMYjF1ir/LAplb2z1CPMUO6sy29V9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120685; bh=O529Xt
    F33TkuWOUGy+QMRIvYuh+4ipHKmhcFt9Ha7ng=; b=bb9iD1/KQne9/e1tvWw9a9
    jH0D8KY8oCxvoKTae+x23RsHOm61jUdSHC3Jkd8iBpwy+ujI70ACP6VEjVVkOwJk
    SQnk57DfJBVwiAESJa7fEM8+2njPC6utrGQfnltsVVYV/dbTocRzbehWF432hADc
    iqkTYSIRF+H3b+MFrxjNfCB+M97U0ohYKlhg17NWBp3O3tKNz+ihCnv6i2tv6qeG
    ju3sBCqweqsbP5X785nc54N3pt3oQy5aTQJKpGx5p0IHh1yq4M9pORPb+wYmY4A5
    1cvpWgTIBLPEOc4CZugxGsU1vsY+pupJdEXOM+KGgg5vNyGAx979wJNSCRL1Q4Dg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iiDwkHOs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iiDwkHOs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeCCXob (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:44:31 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:36491
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934170AbeCCWeM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset and
 minimum value for DDR1 PLL N factor
Thread-Topic: [PATCH AUTOSEL for 4.9 109/219] clk: sunxi-ng: a33: Add offset
 and minimum value for DDR1 PLL N factor
Thread-Index: AQHTsz8G8OCjc/NOiUqTqMNb2h8hGA==
Date: Sat, 3 Mar 2018 22:28:59 +0000
Message-ID: <20180303222716.26640-109-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:SczGIWDLfWgNLorxHb2nmiiQn3QORgRSh/c2TJUmMP/TGnzX4aiVgY7roqPDtzF9G87BmuDftm1/SAeFr6SBPlnJCyjxS70Uo80G3w7X1/jxFi0J9Tl6u/iZgsFZ5lCw4BCmBIbEms8VXDIKx1r1dzpGwd639m/UAX6CM71V2JR5QPgTJo2dBI0zZLBbjd/p9oqh0wMus+3akvAV2wEsDjczdRrtJAv6dke35Vcf/ztRrj9iUqhMuz0TzNOpeekHdoKmLvxXRtXGMYjOSg3Y2XsOIxBKtHqVt6vX6kpRtvrGcuUgUWMWmHHZv2sJXyygmnVLgzXjh1bwgInd9ONzIzEBIL0xtrdNlm/8u91IKUcqYCKB14H20zx5T8/cJXyo;5:HWJazv8LMffA8xDg3/gjWjK9QlYajFcXumZR3LX62v0qxtQoPYjyeXSsMimE/vP4XCBKuvB76ERjzVysCVhUr6movuml2zQ8aypNkQ+Z3ltXa6LZ/d8quvfFIDhwM9wbJkMkx7/6ZTFGNRI2kb/6gQF8rBaQQ4yg7K5rGxHYVWA=;24:EPEkeVIFDMz8wBKLip67to3X9fXTcx1f9u9njpKC0kePaSnBDBdXkd31wce46EY+p6Yx51Bhb9LkD2+g2szd6iPbS5Bp6OuJm3PADsl58J8=;7:wrlXQTweULjNbdXtNp80Yd0fXI/JAK3YkWhnIhmRj2Q79oTkQ1woFLmDYGTztv0SpFIZe1nv3KGTcscqMy4MLStUmExvEhpD1f/4IPGU0bb3M5pAb+JAAokH+bPsLyRPhpRqA9GWbDuo5OWrTRTazk92RIrZBslvjjKjBBviCs13CtaADEbGX+KYHoDIHorLxSvfCSMSxtEIhsqcIyyMR0EkA79XwUzU6AzsqF/r10nBdN1V0zIGp0Wm8A7awDpW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86b42c90-7da9-4b70-8a17-08d58156df19
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065B7F9A76141A58EE35A2BFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ETWtXy4jDzxeVUSglk1RZn0tlnc1Ytqqj/I+pzaw9Jx+Crf8jd8DL52n/oryP25/PCYlLE/4QENoXf11APaCLnIratSH/Dag9CppIjrAVlSHxIYJZyKCCyKcaVMeYBF/gvxlwYkxxSqbdE25MlzMy/KwERpc0BaW3mS0KBGSCw8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b42c90-7da9-4b70-8a17-08d58156df19
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:59.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 68f37d862403e8f95337b2eca90af15d0b8cd5d7 ]

The DDR1 PLL on the A33 is an oddball amongst the A33 CCU clocks.
It is a clock multiplier, with the effective multiplier in the
range of 12 ~ 255 and no offset between the multiplier value and
the value programmed into the register.

Implement the zero offset and minimum value of 12 for this clock.

Fixes: d05c748bd730 ("clk: sunxi-ng: Add A33 CCU support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/cc=
u-sun8i-a33.c
index e1dc4e5b34e1..bdbaf26f551f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -159,13 +159,17 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "=
pll-de",
 					BIT(28),	/* lock */
 					CLK_SET_RATE_UNGATE);
=20
-/* TODO: Fix N */
-static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
-				  "osc24M", 0x04c,
-				  8, 6,			/* N */
-				  BIT(31),		/* gate */
-				  BIT(28),		/* lock */
-				  CLK_SET_RATE_UNGATE);
+static struct ccu_mult pll_ddr1_clk =3D {
+	.enable	=3D BIT(31),
+	.lock	=3D BIT(28),
+	.mult	=3D _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 6, 0, 12, 0),
+	.common	=3D {
+		.reg		=3D 0x04c,
+		.hw.init	=3D CLK_HW_INIT("pll-ddr1", "osc24M",
+					      &ccu_mult_ops,
+					      CLK_SET_RATE_UNGATE),
+	},
+};
=20
 static const char * const cpux_parents[] =3D { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
--=20
2.14.1
