Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3954714-1521499139-2-14486698225493867614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499138; b=DPniYCC0CvdJlNtarQR5CFWMebPd0dQ6yB4VTYLEuM/peAV
    TB1kwWgWyfOd80fZJTzxIbuU3As7KX5NhAd5vRJTKvcJZbTBK79l3oV98oUsJ2wA
    jzl7ggPjHqovk7LxVJuVq+GJJ+Yow9C+7mWx7b8NHzs0BVV8uR9i5YGQUmJzAEGy
    GR3Edvxpm2UeIXQQzyjuQSE5oyikCeJa6yBR8Fckf8C0hrQwHMIlf0Dm6fk9mSk2
    wkOcBF1LjGXMcm2dVKD0X9ON8ZWShhoWlob167RSvX9t7TRGaCvHxka6MpCerJhl
    DIpyPgVsbEbMrw5VEMlDpcE6XWy+5+BfWiLhmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499138; bh=DCBVMs
    Mw//Gdt/8M57LnVssVIvYys2kQfkg8NtAXa3g=; b=YT8ku/v/ZIM9zcYQ6AC5ni
    EavW5ZLJw0PYmmDBv7TXaRqFVxhYdJE1YkV6mT2OgBeIIiHKaMjqVlU0jqCy4WQr
    fEMCOGnwPLoDcO2gvmHpSig1JNPI6uA2ly3oIbXd6bFdYYRU625eZcaSil6OQM/y
    2LGsl8pqAabv/TrEsmP4t9Vigh2tYRzIvilC3lZ8T4Mgn3XBbq9LI/L/NZZ/IejL
    Fy/VcNLv+Zq1CGbqcC53hvKs8sG6P6KA3wyN+h9wwPW4l8WdaxKTOR/nJss4FZyM
    KM3THRPMRz12nGywrS6l5ZhM0xRV+9Vj/2SLO5Wq3GxuBwKyM0YNg70yn4crKXVw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e5I3X6xb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedufeduvdefnecuvehluhhsthgvrhfuihiivgepfeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e5I3X6xb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedufeduvdefnecuvehluhhsthgvrhfuihiivgepfeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936521AbeCSWir (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:38:47 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:59200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933400AbeCSPrb (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 023/124] clk: divider: fix incorrect usage of
 container_of
Thread-Topic: [PATCH AUTOSEL for 4.15 023/124] clk: divider: fix incorrect
 usage of container_of
Thread-Index: AQHTv5mSP2zHaZ4cq060CURoHsqBPQ==
Date: Mon, 19 Mar 2018 15:47:22 +0000
Message-ID: <20180319154645.11350-23-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:t1miwE1ZjwpwO2E2FJJLXOJnxN+zuf2kPEnHJQYOI2SqnV7i1Teqex0sm4oK20iPnFMl82DMmYAcg6wdY/rMtcIeGYHyrFaM05f7eflHip1kgzMH10SJX57L+TaxGBMiNUTzYiEV1JN1EAqfVDh3jSDtbosUnAn6sHFHznQedjVnwzvqhb88FbllTXxxAQ3TZCadSh2V1NE9WRNuGLyyf/TvrUZjbXUn65VtsGygGTovsR8kH+AkdtK0U16JZhA/;20:wWuNg7qLTd/F/+mUio+NTMkkQPRLd1kUvMvt+IP3qgtJUcHluyQAqehBI7XI4LMWUzyDjJp536FG9JLiTFHSuWjhVujqbUj/grNczxVFflN68RSFttYAzj4VnhMITOR+ndesnBaYwcapse+mNutEy8doI9XF4dKEmib+BYTJm+M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5916d68-80cc-4c36-38ef-08d58db0b791
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09985190540393AA515292D6FBD40@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(3846002)(6116002)(8936002)(6486002)(102836004)(68736007)(6506007)(2900100001)(22452003)(25786009)(3660700001)(7736002)(76176011)(6512007)(72206003)(86362001)(53936002)(8676002)(81156014)(6436002)(81166006)(305945005)(478600001)(99286004)(2950100002)(14454004)(6666003)(10290500003)(186003)(107886003)(2501003)(106356001)(26005)(86612001)(97736004)(5660300001)(10090500001)(110136005)(54906003)(316002)(2906002)(66066001)(105586002)(4326008)(36756003)(3280700002)(1076002)(5250100002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7xYmSaJ3f8UxD+2gU56PcfgdVO+Cos0EnseA84lBwWDhyFiVM5oDxeXTzlC5KYRYv2g5zgwdZA2FWbrmxv2frA7FNxdex7yZXdJFNOFFRHiUDf41qO8JwBhZNAhMKmgns0LoaIUaH1Qszyl2N9LrlMpXDLK8gjtxA6KgH5pM3/yqXkJ62YXs6ydBm42fq7h82dxt3uNwh7KlUEAFWs9+UnJEeYVTgvJtcJ+cKLkEy+QuFu0xcuGCnYKRkPbavc+JX66K0ZmcU13P8b8gwglPMTnbGc/CfQ+R1n0ie3eNOlaReqEEcxGMavPbF9wYBBOK04OeKqY4WDy5sclm7MDwqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5916d68-80cc-4c36-38ef-08d58db0b791
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:22.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 12a26c298d2a8b1cab498533fa65198e49e3afd3 ]

divider_recalc_rate() is an helper function used by clock divider of
different types, so the structure containing the 'hw' pointer is not
always a 'struct clk_divider'

At the following line:
> div =3D _get_div(table, val, flags, divider->width);

in several cases, the value of 'divider->width' is garbage as the actual
structure behind this memory is not a 'struct clk_divider'

Fortunately, this width value is used by _get_val() only when
CLK_DIVIDER_MAX_AT_ZERO flag is set. This has never been the case so
far when the structure is not a 'struct clk_divider'. This is probably
why we did not notice this bug before

Fixes: afe76c8fd030 ("clk: allow a clk divider with max divisor when zero")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-divider.c                  | 7 +++----
 drivers/clk/hisilicon/clkdivider-hi6220.c  | 2 +-
 drivers/clk/nxp/clk-lpc32xx.c              | 2 +-
 drivers/clk/qcom/clk-regmap-divider.c      | 2 +-
 drivers/clk/sunxi-ng/ccu_div.c             | 2 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c | 2 +-
 drivers/rtc/rtc-ac100.c                    | 6 ++++--
 include/linux/clk-provider.h               | 2 +-
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 4ed516cb7276..b49942b9fe50 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -118,12 +118,11 @@ static unsigned int _get_val(const struct clk_div_tab=
le *table,
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_=
rate,
 				  unsigned int val,
 				  const struct clk_div_table *table,
-				  unsigned long flags)
+				  unsigned long flags, unsigned long width)
 {
-	struct clk_divider *divider =3D to_clk_divider(hw);
 	unsigned int div;
=20
-	div =3D _get_div(table, val, flags, divider->width);
+	div =3D _get_div(table, val, flags, width);
 	if (!div) {
 		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
 			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
@@ -145,7 +144,7 @@ static unsigned long clk_divider_recalc_rate(struct clk=
_hw *hw,
 	val &=3D div_mask(divider->width);
=20
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
-				   divider->flags);
+				   divider->flags, divider->width);
 }
=20
 static bool _is_valid_table_div(const struct clk_div_table *table,
diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisili=
con/clkdivider-hi6220.c
index a1c1f684ad58..9f46cf9dcc65 100644
--- a/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -56,7 +56,7 @@ static unsigned long hi6220_clkdiv_recalc_rate(struct clk=
_hw *hw,
 	val &=3D div_mask(dclk->width);
=20
 	return divider_recalc_rate(hw, parent_rate, val, dclk->table,
-				   CLK_DIVIDER_ROUND_CLOSEST);
+				   CLK_DIVIDER_ROUND_CLOSEST, dclk->width);
 }
=20
 static long hi6220_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate=
,
diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 7b359afd620e..a6438f50e6db 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -956,7 +956,7 @@ static unsigned long clk_divider_recalc_rate(struct clk=
_hw *hw,
 	val &=3D div_mask(divider->width);
=20
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
-				   divider->flags);
+				   divider->flags, divider->width);
 }
=20
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/qcom/clk-regmap-divider.c b/drivers/clk/qcom/clk-r=
egmap-divider.c
index 53484912301e..928fcc16ee27 100644
--- a/drivers/clk/qcom/clk-regmap-divider.c
+++ b/drivers/clk/qcom/clk-regmap-divider.c
@@ -59,7 +59,7 @@ static unsigned long div_recalc_rate(struct clk_hw *hw,
 	div &=3D BIT(divider->width) - 1;
=20
 	return divider_recalc_rate(hw, parent_rate, div, NULL,
-				   CLK_DIVIDER_ROUND_CLOSEST);
+				   CLK_DIVIDER_ROUND_CLOSEST, divider->width);
 }
=20
 const struct clk_ops clk_regmap_div_ops =3D {
diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.=
c
index baa3cf96507b..302a18efd39f 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -71,7 +71,7 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *h=
w,
 						  parent_rate);
=20
 	val =3D divider_recalc_rate(hw, parent_rate, val, cd->div.table,
-				  cd->div.flags);
+				  cd->div.flags, cd->div.width);
=20
 	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		val /=3D cd->fixed_post_div;
diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu/drm/m=
sm/dsi/pll/dsi_pll_14nm.c
index fe15aa64086f..71fe60e5f01f 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
@@ -698,7 +698,7 @@ static unsigned long dsi_pll_14nm_postdiv_recalc_rate(s=
truct clk_hw *hw,
 	val &=3D div_mask(width);
=20
 	return divider_recalc_rate(hw, parent_rate, val, NULL,
-				   postdiv->flags);
+				   postdiv->flags, width);
 }
=20
 static long dsi_pll_14nm_postdiv_round_rate(struct clk_hw *hw,
diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 9e336184491c..0282ccc6181c 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -137,13 +137,15 @@ static unsigned long ac100_clkout_recalc_rate(struct =
clk_hw *hw,
 		div =3D (reg >> AC100_CLKOUT_PRE_DIV_SHIFT) &
 			((1 << AC100_CLKOUT_PRE_DIV_WIDTH) - 1);
 		prate =3D divider_recalc_rate(hw, prate, div,
-					    ac100_clkout_prediv, 0);
+					    ac100_clkout_prediv, 0,
+					    AC100_CLKOUT_PRE_DIV_WIDTH);
 	}
=20
 	div =3D (reg >> AC100_CLKOUT_DIV_SHIFT) &
 		(BIT(AC100_CLKOUT_DIV_WIDTH) - 1);
 	return divider_recalc_rate(hw, prate, div, NULL,
-				   CLK_DIVIDER_POWER_OF_TWO);
+				   CLK_DIVIDER_POWER_OF_TWO,
+				   AC100_CLKOUT_DIV_WIDTH);
 }
=20
 static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7c925e6211f1..48171b349b88 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -412,7 +412,7 @@ extern const struct clk_ops clk_divider_ro_ops;
=20
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_=
rate,
 		unsigned int val, const struct clk_div_table *table,
-		unsigned long flags);
+		unsigned long flags, unsigned long width);
 long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 			       unsigned long rate, unsigned long *prate,
 			       const struct clk_div_table *table,
--=20
2.14.1
