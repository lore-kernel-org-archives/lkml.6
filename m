Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521497201-2-10250519932077965088
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
    t=1521497200; b=K4+eiE4YS6Q9K8B5eWx0NelgB9nP4hGggrMF7rP4THCTnBV
    W8DqMXbUUrDD+8TwSwap7ezjCHpA9oRyvvYR0H7rOsSbzh5lPfWOewzPh426h/0Q
    CQrMtd0d029griLfXacU6W5Ej1GNtmm/F6tJGJhUfm+OhDftc64Fzvk+Rp7m/CHU
    ZBtF2Ox/w8vot1fzWH3fdDm8WOVZZMHd7hNTy94WOhHpwLFqYgQSWjC4OH4f5JMS
    b0Ilk5OsQNkQe5tFP3gUe8coQ6WSzFokFluUwo72rjZOd8Q0JPFvOm7M7OaP387i
    2mD7tKseoz8sRPb/6qu8jlxkSqJpRv/ELExUN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497200; bh=+VVVSa
    WvzlG0PEWM58aQokId9guxSpIpsUuhlNWcsgQ=; b=gNZkdDZEhqGQ0YzgCdoSXc
    IN7IHs2X/ugcA09Qvhe8IEeC4m9NqBZsBhj3hy2BGZqc1V5X+yW17Zb1bZyk0OEb
    vHNu6JQIm/OBcUkLmSbdQD2zkc1e2mfQPmYQ9OGPzNen4z4w/zSS+FuiM09TLi/h
    EP4Rytxnbn5ewwR/rbFDo8H10OQ+Mft/DxrEdQCVeGn8/3C7jSLS2eiJk7DvFxKk
    W8r2uP4fC7Rrncms7sBInaBpTJ/U+Yj4E/vbyfuWO7EYi4kEjsGEpERof4WnTlQn
    3DgK/YbA6TL3AzUQq2EGcx5YsVgebAzf36a3HFmSzNuKcJJ/fv0HR+xByk/sBAzA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+Xkx/wx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedufedutdejnecuvehluhhsthgvrhfuihiivgepheej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+Xkx/wx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedufedutdejnecuvehluhhsthgvrhfuihiivgepheej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964823AbeCSWGd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:06:33 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964793AbeCSPzD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 20/97] clk: divider: fix incorrect usage of
 container_of
Thread-Topic: [PATCH AUTOSEL for 4.14 20/97] clk: divider: fix incorrect usage
 of container_of
Thread-Index: AQHTv5qcDArgPyVHekiqB5/iZhwruw==
Date: Mon, 19 Mar 2018 15:54:49 +0000
Message-ID: <20180319155411.12348-20-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:CgmeHuMxdg9U2+rHQenN0ZHUS0Cvog3WhRdWLEb3Nq3q9+qTfzOZxYrwmyg6Z/2cg3zm6zSUBJ5h3CEJJ/AioXwEcr+PmZHx3hryVqnD39RxvBanDpM83PSWagjj2kh4LSFl2KPITJgOEkBHhl20Xczwl4F0eKZ80rFdmx5QL6rNoJfBGOZ9AjSOpClnXHMx2ayI5MQZLclat6PblhmAaRfReCkIUwCkVFpYPhUr9KV+tOhIghma6aY8iAkU/KM6;20:5Qk6m4PIjVEuhRtcdQTkq73fEk4unr8ePXDeZcH+4wd2i9WV/nSqRspIyCX24KvPt5E7mLwtdfRL6g4BmJDKjnx+IxSiCmYOzU5F4JyQbqb+xKiFCzNIdH3BtaR8EGvkcTJbCnoc74qsuohY7gFg1+9PDKGS42He2u+IHEM9CrM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74eaa43a-7df8-4b40-d46c-08d58db1bf5a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806B2C6676E362D243A9D5DFBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dwOzFe48gT6+yX8LZLtqHKqrynZMT86HcqMby/WA4UbgVPjVWf4hEXjbJro6IaVt8j3sbGQtOQu0NdpuCbt5Plp5Ske1VhubxcG3PlaUeS63Ftj8RxgGDZ6u4fq8LqkXdmdl6b+iOOOzPpGqIXZIOo/CEmuoXDUQFhtSoUWMVGye9wKcrlUV88VEpNG9pLF+pu1YEmi0bjjdK5YIzji4UZ5N3mzWxV6ODgeEkTwBYdOZEtIkUn1iaHZ3oDAhh6LVylT31KFroE39btb+Hybckk7jx72b9UmVGseJmiGuFmlI4nWI91DjTo+sMV+SDJtoSM/RomrUdLVKuWtjSVIHCw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eaa43a-7df8-4b40-d46c-08d58db1bf5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:49.9830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 5100ec1b5d55..86eb33f67618 100644
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
