Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965160AbeBMOzu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:55:50 -0500
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com ([104.47.33.62]:13590
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965113AbeBMOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:55:44 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <shawnguo@kernel.org>, <Anson.Huang@nxp.com>, <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V3 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
Date: Tue, 13 Feb 2018 21:28:06 +0800
Message-ID: <1518528494-25723-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073426853957;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(54534003)(2906002)(336011)(77096007)(36756003)(47776003)(54906003)(16586007)(53936002)(81156014)(81166006)(8936002)(356003)(4326008)(316002)(68736007)(498600001)(85426001)(105606002)(305945005)(5660300001)(50226002)(26826003)(2950100002)(6916009)(97736004)(76176011)(26005)(6666003)(106466001)(450100002)(104016004)(51416003)(59450400001)(50466002)(8676002)(86362001)(48376002)(2351001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1413;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD054;1:nH/oMTsPg2xzIQFjskEeKlbK9MDeRxudbLxxVAvacy46wQhHSIEoqowrHQ5xi8feHCdpt1309XR7B9Fy0/PtkoM0HvwcoCEVj0G+W037t7r1x2q++M1onz+L1nGeZwqo
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a61e79fc-e491-40d8-5ee7-08d572f1dad2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN3PR03MB1413;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1413;3:7tBPvsDTIBEw4bL5gm4qZ6S3I0ZNm1Tj66SeLXfnsruyQGuV6Qj8pocfqo6eVTH+CFbg/KQaGFtmQLdbvDYpATognxxbsQflAcjQATXz9UaEJU7/AWWjSvFcBghYzuTTjH4IDm5+mzWJP1FqYdUE3TS0eXKvS9lKywu63V07iFemRYd30Jpmq0nNQ2qmULq9sLzaAfx7qorh/kP5g25CEvahND5PXvpze7cG4/NucPsY0imUsNBt+fK5Fvgl/hxbR9u8w0kTh08G8DoEUNzWPUL35vWTPiZnwA+V4k0TxITTkVHaVbIEo0+snSNme2wPmKuzeBdxyqmS/kRcZ0tT5zlKxG5nlelTuIfBLiR5i/4=;25:Fq8m3UHoz5NQIbHD9ESBdtvDOlFWDjVfP2+oIygZHtMnDNi8kGw83YYP5NgugYGkqaVPSbEG12dZxX/GTE+OtvnAUomiqCDymAGWytDs1qKHqSGk0BRECS/28frMOQDyJc3y1/NEVZKYSy8V4mhsRK9oDODgpGE1Fz64gC7iLGBdjHAvBx4drYoCd8ddCnyTphelylYk5RuFFVEdnmdH5YXY9wq4Dv6CxzJB6zObFS7AAQPJM68cD1+/bwC2s5akc6eS6H2c8QkDKPFm2pCAAIS6Ut6TK3drNgA4nlM27sETfqpGbBqMjfAK7wJiOSU24fkGcx0ocO3Z6fpaSU1rzw==
X-MS-TrafficTypeDiagnostic: BN3PR03MB1413:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1413;31:TW5VblMLaT/LXUos2IsOuBlBO32qvpOsaA2/jgo9dejxqoN4qUwd93okk+i/mjaYf8ld4xXbQ6njPqUqEakk1spjJ/LnQCBHI9OPbT0i60zLydj+Li5FqALDVHhlmORnCTjs4tnxnRDfml7lojSH0RMyKjXbMIEW/sgw67bOsAg6kL2dnyQ/L8rAEI31/k7D+yDRKrSTny3Y26CruuQASzO9KEaWdFwkaCr55xGgcgg=;4:vOpEF/hXCzwKK9ij4JMLooJKe1LmeZOgWbfEhQMvOKs4V8Fkv1U5fIWMq9FoxpCnP0RynI+9NsRIBojqAwNb0mPPfqTj97TpkCdqJG5Z/p4OvM0QDzygfP4aH8cPOfVZrlJ3u3lebg0wU/ILihMrbzRT6y/SINJYsy9Kv6/OpJHh2ljEJKPFITAf/HZ68taimg39+eiSlH2MNX28xd9ZefSaU3d/9/JQrsBBwazlEemrqx8fmbeTWyGfKe5Y/Jvw4GkQSOakF9xABM6FJcBCRAebi2DLVrrb8YPLmb2EmOpXGCR3QqzauJvj/8VV11mC
X-Microsoft-Antispam-PRVS: <BN3PR03MB1413C943A216A60F868ECF1E80F60@BN3PR03MB1413.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6055026)(6096035)(20161123565025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123561025)(20161123556025)(201708071742011);SRVR:BN3PR03MB1413;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR03MB1413;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1413;23:FaUDLmsUpPMo7rw0LUzwk9cKA1wWmr0CONEEjfcyt?=
 =?us-ascii?Q?SDhKw8BmR9GMoa7anxWeBaPllYV9ytiXMSyg8HyaqAWFnhtt8A9pHrc2nxq+?=
 =?us-ascii?Q?9UaYapL1HLJxHvxFRNbMU3LE17zDea/udCl2CkNKjXDneIu2PAoNCwABrTJn?=
 =?us-ascii?Q?LBz5hiVmH0KN1WcLHovx2hRvOP+mEcT4ZS83nPDibk+VDJS8tbTswxnYbbD2?=
 =?us-ascii?Q?+FVJSK1wxvGqcG2vx+QNxxKc3WKb/es3qll3XCMgezcdduVqnZN6uGKDt3uk?=
 =?us-ascii?Q?NNY/7GOMSo/bCeUPNBLdk0kVpSzfXkgJfLC0CQzBCSq/VzvCFAeO+piVimcN?=
 =?us-ascii?Q?UcpC6ElouRxcyanXIoS8eO8Z4czJqh16huOEmyaoPX8JtSIPXDavT0irTX26?=
 =?us-ascii?Q?UDM1SaieBFxx1mM7ZkOarQF5HnDgStAtEFKR4mQe83gN6d1Yk/OYIPIBciGf?=
 =?us-ascii?Q?1qdyuttiQOYMUz7cEiA+3qQ0jGe/PyRmIwaI7m6qUxyFyKQ4mf9aDet+hr67?=
 =?us-ascii?Q?w3oC4ITT59S4CjTbTcx+tdbPo2u3mHcvo7IaUiIL0HuX3Bf+07Vmx9Rr2oT2?=
 =?us-ascii?Q?prPmJKgTyrmLGEOaIf0IaYubNdx3TpxEZtEmkFSYNpJp42umZ9kEvdFm4OvY?=
 =?us-ascii?Q?wh0LC+KWSatTofmpy7Chz900byfRuUsfs8H9DoKr/t1rJLrPe3X2EoNH7Vo9?=
 =?us-ascii?Q?3VKI7gVnVJIaaERxQDeFim4b6mq3xD6EldHxbSZbx4v2HNmMRYcbVnPUnRvm?=
 =?us-ascii?Q?SwsvIaU1nkdWChG3BR+DC746fId1hRnK+EGt1R/fi90LJ95oeK+5xmBBTmS9?=
 =?us-ascii?Q?zo/GZK7Qz064/xtulVOP76G6Tsu0ppCIqmz4kNrlc6iLMCde7yGHQUMf+nNh?=
 =?us-ascii?Q?BaBSBslB7iN2tHLwfpMx2X3SiwK27S1llPH2ug6bLnb6q/2s8fUitbMi9VfM?=
 =?us-ascii?Q?A6vMYYXdlZHA31n8thQpFv8NZ/hRPiWsXv7cug7IsJYjQi18txK5vFp9UH0X?=
 =?us-ascii?Q?erxzWXD99mKYCJRqhkaLdOVfyNb5pOcXt+FudOYajxtPXZr4XGdp3ickhzE7?=
 =?us-ascii?Q?fvO5X9PS3Eahk2cKQLkxTfR5Ko9NwMcJyxSNR+7+KR2nmKdSJprzPGU1sxev?=
 =?us-ascii?Q?IZ+knhbuP5BwjQg9EWywKr7SiBGYX3NzSsxy0vBR/egKVOMSqoQ7VVFRFIC6?=
 =?us-ascii?Q?5vFjuEuMElr2lI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1413;6:WfWFcqLp8Xk5wqg1s0i7C2BoSacEWdLVgouGKBt5ZU/v/nLMz4/duTGvZCHojGR39x5/S4PjN7xM4pE/tdYGk6JJFZkLTxj0roMG5z2gN6C1GQ+83SRqSX8l+pRB1JOlVYEi5Xg0HTQnr6EV8CHJVxG0PsyuZrqQzBe7QHfklTBG19SQVet8+gctk4Ep6MISuEtikDe4kektlPpPs1QSMEIaZqO8aVzBZZukkwKgpMYZjC/pug3GfBSyFLSIvDAmSjgBwGoCvo5XQma2Akdk8L2tXEO4R5xjjXDbbhbVcbP2mnkIRSVn1IMNZFza0JWtow5noXlpSdmjrw82JvDo5faVqGl7GXMe/m7YCzA+Nus=;5:uGs90D1EtiD/7TmR6Hi3tlECF2inZdcV0u028L4uAVOteqkTGFsrpXm8RlS18TpNgOwAssKIQ6iB2/krWVVJ3FNfYO3ouJhd0Niw9MGnH+8CnKdfXsPKTOv1yda9hLYdFLkhWrEn/YWeLh9VKcdQjWlMXQ7S9qOXQq5oO4kzhL0=;24:CAO80H5lwm4RFcxnptqQoS0ftWndj97DePxDs2F8QOBSytnvrFjzwajzwIHmLh4PkEHwvauoyCrW99yEVfx5418mef5T2DUUmxeBZddTFUw=;7:8lXKk89Ip8XxdcJjZnoYAAlPfcjpROJaqCUEwGVxu6MAfNW/5TUrwErO7i4k4D+ZzqVg3q1+SbT5tgZYgxrrt37ebwjB2gtpM0KDEiiqAg5GGRzasefO7OjqYetWLnuIa6AdQbfOSB/pYJrA+UKTGJMATZmjkN3esX2JDWIXgabbkJqDzmx1n2NvqbQCl7JI4oqj+LFrFq0e+8ql3E1J45rJI+zCUJURZ9tYjaRNcf//iCdqE9upal+r+Q4qncZN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.4981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61e79fc-e491-40d8-5ee7-08d572f1dad2
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1413
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dividers with zero indicating clock is disabled, instead of giving a
warning each time like "clkx: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not
set" in exist code, we'd like to introduce enable/disable function for it.
e.g.
000b - Clock disabled
001b - Divide by 1
010b - Divide by 2
...

Set rate when the clk is disabled will cache the rate request and only
when the clk is enabled will the driver actually program the hardware to
have the requested divider value. Similarly, when the clk is disabled we'll
write a 0 there, but when the clk is enabled we'll restore whatever rate
(divider) was chosen last.

It does mean that recalc rate will be sort of odd, because when the clk is
off it will return 0, and when the clk is on it will return the right rate.
So to make things work, we'll need to return the cached rate in recalc rate
when the clk is off and read the hardware when the clk is on.

NOTE for the default off divider, the recalc rate will still return 0 as
there's still no proper preset rate. Enable such divider will give user
a reminder error message.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * split normal and gate ops
 * fix the possible racy
v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
---
 drivers/clk/clk-divider.c    | 152 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   9 +++
 2 files changed, 161 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b49942b..6143895 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -124,6 +124,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 
 	div = _get_div(table, val, flags, width);
 	if (!div) {
+		if (flags & CLK_DIVIDER_ZERO_GATE)
+			return 0;
+
 		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
 			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
 			clk_hw_get_name(hw));
@@ -147,6 +150,34 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 				   divider->flags, divider->width);
 }
 
+static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	unsigned int val;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (!clk_hw_is_enabled(hw)) {
+		val = divider->cached_val;
+	} else {
+		val = clk_readl(divider->reg) >> divider->shift;
+		val &= div_mask(divider->width);
+	}
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
 static bool _is_valid_table_div(const struct clk_div_table *table,
 							 unsigned int div)
 {
@@ -415,6 +446,108 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	int value;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (clk_hw_is_enabled(hw)) {
+		if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+			val = div_mask(divider->width) << (divider->shift + 16);
+		} else {
+			val = clk_readl(divider->reg);
+			val &= ~(div_mask(divider->width) << divider->shift);
+		}
+		val |= (u32)value << divider->shift;
+		clk_writel(val, divider->reg);
+	} else {
+		divider->cached_val = value;
+	}
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static int clk_divider_enable(struct clk_hw *hw)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	u32 val;
+
+	if (!divider->cached_val) {
+		pr_err("%s: no valid preset rate\n", clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/* restore div val */
+	val = clk_readl(divider->reg);
+	val |= divider->cached_val << divider->shift;
+	clk_writel(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+static void clk_divider_disable(struct clk_hw *hw)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	u32 val;
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	/* store the current div val */
+	val = clk_readl(divider->reg) >> divider->shift;
+	val &= div_mask(divider->width);
+	divider->cached_val = val;
+	clk_writel(0, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+}
+
+static int clk_divider_is_enabled(struct clk_hw *hw)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	u32 val;
+
+	val = clk_readl(divider->reg) >> divider->shift;
+	val &= div_mask(divider->width);
+
+	return val ? 1 : 0;
+}
+
 const struct clk_ops clk_divider_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
 	.round_rate = clk_divider_round_rate,
@@ -422,6 +555,16 @@ const struct clk_ops clk_divider_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
 
+const struct clk_ops clk_divider_gate_ops = {
+	.recalc_rate = clk_divider_gate_recalc_rate,
+	.round_rate = clk_divider_round_rate,
+	.set_rate = clk_divider_gate_set_rate,
+	.enable = clk_divider_enable,
+	.disable = clk_divider_disable,
+	.is_enabled = clk_divider_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_divider_gate_ops);
+
 const struct clk_ops clk_divider_ro_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
 	.round_rate = clk_divider_round_rate,
@@ -437,6 +580,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	struct clk_divider *div;
 	struct clk_hw *hw;
 	struct clk_init_data init;
+	u32 val;
 	int ret;
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
@@ -454,6 +598,8 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	init.name = name;
 	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
 		init.ops = &clk_divider_ro_ops;
+	else if (clk_divider_flags & CLK_DIVIDER_ZERO_GATE)
+		init.ops = &clk_divider_gate_ops;
 	else
 		init.ops = &clk_divider_ops;
 	init.flags = flags | CLK_IS_BASIC;
@@ -469,6 +615,12 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	div->hw.init = &init;
 	div->table = table;
 
+	if (div->flags & CLK_DIVIDER_ZERO_GATE) {
+		val = clk_readl(reg) >> shift;
+		val &= div_mask(width);
+		div->cached_val = val;
+	}
+
 	/* register the clock */
 	hw = &div->hw;
 	ret = clk_hw_register(dev, hw);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f711be6..68ccd36 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -360,6 +360,7 @@ struct clk_div_table {
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div = 0
+ * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
  * @lock:	register lock
  *
  * Clock with an adjustable divider affecting its output frequency.  Implements
@@ -388,6 +389,12 @@ struct clk_div_table {
  * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE_BASED
  *	except when the value read from the register is zero, the divisor is
  *	2^width of the field.
+ * CLK_DIVIDER_ZERO_GATE - For dividers which are like CLK_DIVIDER_ONE_BASED
+ *	when the value read from the register is zero, it means the divisor
+ *	is gated. For this case, the cached_val will be used to store the
+ *	intermediate div for the normal rate operation, like set_rate/get_rate/
+ *	recalc_rate. When the divider is ungated, the driver will actually
+ *	program the hardware to have the requested divider value.
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -396,6 +403,7 @@ struct clk_divider {
 	u8		width;
 	u8		flags;
 	const struct clk_div_table	*table;
+	u32		cached_val;
 	spinlock_t	*lock;
 };
 
@@ -408,6 +416,7 @@ struct clk_divider {
 #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
+#define CLK_DIVIDER_ZERO_GATE		BIT(7)
 
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
-- 
2.7.4
