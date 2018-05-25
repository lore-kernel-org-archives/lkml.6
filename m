Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964964AbeEYHvp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:51:45 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:23744
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935866AbeEYHvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:51:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
Date: Fri, 25 May 2018 15:51:03 +0800
Message-Id: <1527234671-31755-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
References: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To AM0PR04MB4210.eurprd04.prod.outlook.com
 (2603:10a6:208:66::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:6X1l12tfnuS9fQt0ymu0q0LC+PLof/I1aQKPfgNcY737B3dXezlGSq+qmto0EAh/QRl6TLTCnC5why/omY76NK32mhixI9yZUz2VI3H+f1KmAL5pSPPo9r8ZyowzEr01q7mnqYdSVFSjOwsuvSw2ysFyOHfPsNHtmcqQp6PrTy1JJKZV7E1j3QAffLN2UJALlEevlzOpSjFwCRr4Z0Xyi9SDgC0rwajB3HCWnQlTONKuJoXcY4Yh1fSYtHC79hHy;25:3qF8hmTfpY3FaoItj5EdO7Wnt4CDOfG5+QVMg0kPaRwQ/icZ7btEo0+4vgNRfbb0gXEPvGjQMzV7rsuzu/sI6RCxzuRG1HvSQ66B+tuC/KzF9Wb4BtY45yGZXLAcShCG1RmIImI3tcoLFmx+9cayAy182Y2J/klh2s8sabhxAo4Ndd4yHa4fWVgyJMrkd5uMjUNQhHEDWOSECGqnjhDRhyrhAMcYehfx2fkCKFRJLB0hKLoba7IVFjBZa0Y/2H4+TTDS2PUF3v/oAjgd8/CxA9DhwICNE1PsYT0ubHL64PiDaw2UWNT+Rkaq/WNeDezEVzBQQ6AzUicqyEAdhnPEgQ==;31:dI1nIfetqvpnKzCeXl2uT4oRST+t/Ls5frJC17QmLgTAysNlYqMEGAPqmnZd2kBFuAKQuaf9GTU26RPrh3ffgDVIEw4hvJMq5blifkMBpmAMVmpXY3m1+bFMGgGfU436cZJI8IyjgUt4/PU+n8L0JIhSMPBETbBl8HxdxgiO837LWnEKCLaUh2B+/h6gOm4j6McntpSC1GAUP5fqtZIlQBF5cc79/gTIqRWm2QMdV7Y=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:XTotgEwvNbu5OQJ4tDJX84DJ9ESR1AnsxShoh5ctPKWWJ4lGT4WhyFNsQa+5x7BrTa4KDwuwVL5hpWZZI+os4ZmBNedFlfVXW3170EvjZiV4N6R0UBmf2H29JrfRTx3rfnUt7DCCLaJA2SffgO/Sy02heF84H+sMY8rKSuZ9KzDKMDdw31awhcuY/7mnrFrj04qYzZ+P55Vcgaxnyw40xHT1IoLVR2Mz4cdcWc4m5aLFgG0331EjEYZxkQaqfvj2rTAmEQysG7xlzi1ymXmKn7P2qdAcYR+SgJiNKs10Ld5/L4sVpmg1HLrkFYfwqxstaYBOjMxIZa8pqxQ3rJQ1KvLEuXWzBcsz4phu0NZM2nj7NqlNsQGmL/6qBT+3IWrKHWRHRCzbZ0Nt+RfJjkdZFrCP5Ie/Kjx9RMlEk7ghTll8fsdNWm0SymnEfRiizn9ZAIyEIJj05iMIurbNoOME1S/W/2FJt+nvJlGfdmWjB0Bja54iLUv36upUFt6ear2X;4:+stMiXe8GPW1DR/hdqWKojDKqtbbA9hVG/aV4jI+E9nZcWXgd8d0kmWwKB6ZrXFRLDoo58CNY/EeoiHFMLZIS1LAP27TpFjjFexKH5x2ZhEtVUVF90uYs6oOpi75M1K36Mq02ZIOWH0poHY76md6/P7/Zb9dhyPnJeZXEdCiVnGJ1JtBSoxpLDibPce6CFCUejtFpgV3PLsaBHpXvDQ6fCHXS0sG7GSjEh1CkP/MMxsSkeeRbhlIqglNR0otVfsIyA8fKQtrbwDXHaK/xj/FFpUW6SupUsm+5kEv2bSzk3q2JniJxIJX/iiYOvyhzfZF
X-Microsoft-Antispam-PRVS: <AM0PR04MB42108E573B51348C9DABC8ED80690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:G6zqFEMrtcJSl4sx2d/q5u1DmkhHfjBeE6S7vAPa/?=
 =?us-ascii?Q?B0X9L950dZOCrIs6ejbMzuPbM+116+GgM90ODkMFvNScPUtEpPy4XDwN+GUI?=
 =?us-ascii?Q?ix7WLRMlhVDcJNK4SrtTfXLsPeNYbMr0aRtKVj2Dj9I/ViumSoxKPtDloX39?=
 =?us-ascii?Q?Ej0gbQ8nh08H9tWL/4fug/8VfMkJgYhi78i4VDUg79czICYJViksC7UNwgyj?=
 =?us-ascii?Q?fHbnbuh37NlfSujffGAxB8zEunH2/HKnsFvxzt7Tba09coLLSNJ4Rkt0vx/o?=
 =?us-ascii?Q?oQetRMNilB5O1VfJHdCl5z/WrvIOcnu153mYySCliy4u1dMGlFO4SecITMyY?=
 =?us-ascii?Q?fP98Ux7agZgjl8ZER1/TYL5oklSWipTcxECk7bgu1m7OnIQLGtKVnxdeeNPU?=
 =?us-ascii?Q?BiqgC/Q5ueAiX14ZcPu7i/jKVsxV9nQ8rHAwrKsNqE4Ic53atnhUkYVYHdns?=
 =?us-ascii?Q?YzUpLp+H3SBvbIgkH00XBJTSqZSkoCOyEEmZa/Txa16LlnXzViCz7cJOIy4m?=
 =?us-ascii?Q?agx0CYrLFDG0tIJnn9/JEkeyryAGdvHMQZCieEO3NyCSKm15sizj6a2c2Un/?=
 =?us-ascii?Q?WRCK+N795f7jvCkBO4FKDqc5fZBPqanxhH26r5GdPj3qwGSgSMFmY1b/IVdN?=
 =?us-ascii?Q?tx78vB6TklsrAh8LrV0uHCDrs06UQ/vvdi2SjDpLPBYSyBAGaix3HiSrGyUs?=
 =?us-ascii?Q?4UIXgp/cy2+/eGSMCFJQjfdkeINd1WNbXyaXWaw4Tm9D2gZdv4uIiibXL+TZ?=
 =?us-ascii?Q?eMuKpbCXMr4ZtuFHy/h48fC4CAEHMBlhlJYPYxmjcyXs6vsSvH4EaYIxp4q5?=
 =?us-ascii?Q?ZwmqUg4XnsiaHx51J5QYOS2iJJnOmknHgVgXBsqKfB+vZNdrBkB2Ckbh4oxq?=
 =?us-ascii?Q?q7L4CgKlgNG6jIGDMafCl/7xkfoeei0dLLMmE3l7ZjC3e7k5AZllAtx8HjQL?=
 =?us-ascii?Q?cKBm7jqkdpzE5KXCgf7OdV3nyWGiOFPw8dBBuhWSKhU+myIcwSCqUQTU5LIW?=
 =?us-ascii?Q?DK1OolsJ+usyuc3iJIX3N4IDlwFHxrmUkFgk6Nyffe61rLtU8Ez5vzo4cc/U?=
 =?us-ascii?Q?ubzqwE4/nLCiu1t9vaurOcc3ZlUHSOEJIsmSQjlNJpNg6IaJe3aIZMTHeh2j?=
 =?us-ascii?Q?5pR2ngD8kJWw0swBMXNH8DJM27p31CAnkmzwI+Lc2O+iRdHqRcAiSqlBTOso?=
 =?us-ascii?Q?/OGJsqLPKQoT+lC78gQI+U/IHmSc14dddrHTvMzd+OFquGj03flii7bnxsZp?=
 =?us-ascii?Q?UOgtpPeJLarBAtl+AUbLj1o7+7u187Q238vJvx7pSHxBva1j3JZuPfXkD05D?=
 =?us-ascii?Q?+g7FUpVyFIdygdTaMSpZzs=3D?=
X-Microsoft-Antispam-Message-Info: q0eqr1T4QZHdzuc1Cd9mTtM22wAj6FEpD699rFlzzfnNn+I1dNwTnB27TBcsvOpot5lmdU5IbpgNzCXVCo8eF2u5/36ZCdp98Zq0ty8bFS2/C6CvdgDZE0pp5IP2mwjp8yAi23gmz0QYhWqkpdtv0p9pfTlaMbkI2i/B/bqj8Zb3pydWf2ZR4EEdJ4yMzT2c
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:ntiuZsCIVeeRtxvjLPYM5rRVG3RFWvts4dRMbwapT17IXwbc84NuFpvYK3d2PUBiqiVc5fhxCJP6tg0DIQaNQGgvth8E0CpNKEvmMiFlQJ3L+RD/dSTGmBkysiJYJOU15i4ZXGqhs7vYEJPbnNAHDt4D5HeVuiIv0SRJhWOYEk2tm/td8p0MiPaSlRmZqZZ0n7B1bAtrz90NN73oKvxTRGBFYkpvhpQTepN6d5TYvnelAlr+SyAWJi/O05HqGbpQUdVqayN6NB4Uj4HP7e+GNwd2HCSmhtkQAGSoKLEkKxh/MSoPBkUSdR2N8NjjoP/I79Kiof5Ey98bBliUGJYnmNdbEyI1PR7WVMGpUNGkU5n3E+2CRcyMqArj8RDqydznvNxf5b0xTwMvHfqZmizB70DF28jj/N3MKiZ1ySsjj6NC63o90XhNOlJZdzxTANDje+80QoWSBATANM5KqKeQfQ==;5:ghSXTrpmOdy0GEqqo8I3vUISGEZD9VOdn73NS0vuDpoA6IKo5V5SDcghsa3AyyoOxfNobwaQzv5uWiiF5YKeoYWdpxKkpv8O4XKS/H1vQXcTZXG66/uL5QY0On+iObEt99zj6sUjgBS3YX6LNbYnio5B7kySrIV++KLrk0bua/w=;24:HhfWFulKWUiHyoAE1BrptlKmYLFtKLrYnMFUoPZg6MMdb4PyeIIWaopJYmbALvQ1KpS9kpZI1RA2uaoc8rLPlShMXQPMS+PaQ4K/lZ/qKHA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:BGBoTozXUA2HQx60ADhL63a7m/h5/B2aZ5cdFKnsoVT2jizyLv2xp6OAGQ/z5J9fBpLbA8L7p6vGfEY/eY/m2mscd6zYZtwd+zBI/5AcIJBs3PiphP0cTDNOQAJofB1euBZLObwp11VZJJGaJRatCQE5/Zb2s9r9KLOAWMTDS3PtkI9J7HqD+D9VLGazojeC0rufiZ8Jv5l6/iOuk2bIwDqbQ51Xu8PX0QLt0WrhuVg1d2Pe0rJxPtLpVI6vZXCr
X-MS-Office365-Filtering-Correlation-Id: eb89cf37-151a-4114-524d-08d5c2145770
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:33.0261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb89cf37-151a-4114-524d-08d5c2145770
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
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
index b6234a5..b3566fd 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -122,6 +122,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 
 	div = _get_div(table, val, flags, width);
 	if (!div) {
+		if (flags & CLK_DIVIDER_ZERO_GATE)
+			return 0;
+
 		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
 			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
 			clk_hw_get_name(hw));
@@ -145,6 +148,34 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
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
+		val &= clk_div_mask(divider->width);
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
@@ -437,6 +468,108 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
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
+			val = clk_div_mask(divider->width) << (divider->shift + 16);
+		} else {
+			val = clk_readl(divider->reg);
+			val &= ~(clk_div_mask(divider->width) << divider->shift);
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
+	val &= clk_div_mask(divider->width);
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
+	val &= clk_div_mask(divider->width);
+
+	return val ? 1 : 0;
+}
+
 const struct clk_ops clk_divider_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
 	.round_rate = clk_divider_round_rate,
@@ -444,6 +577,16 @@ const struct clk_ops clk_divider_ops = {
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
@@ -459,6 +602,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	struct clk_divider *div;
 	struct clk_hw *hw;
 	struct clk_init_data init;
+	u32 val;
 	int ret;
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
@@ -476,6 +620,8 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	init.name = name;
 	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
 		init.ops = &clk_divider_ro_ops;
+	else if (clk_divider_flags & CLK_DIVIDER_ZERO_GATE)
+		init.ops = &clk_divider_gate_ops;
 	else
 		init.ops = &clk_divider_ops;
 	init.flags = flags | CLK_IS_BASIC;
@@ -491,6 +637,12 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
 	div->hw.init = &init;
 	div->table = table;
 
+	if (div->flags & CLK_DIVIDER_ZERO_GATE) {
+		val = clk_readl(reg) >> shift;
+		val &= clk_div_mask(width);
+		div->cached_val = val;
+	}
+
 	/* register the clock */
 	hw = &div->hw;
 	ret = clk_hw_register(dev, hw);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1053e2a..3cf522f6 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -361,6 +361,7 @@ struct clk_div_table {
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div = 0
+ * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
  * @lock:	register lock
  *
  * Clock with an adjustable divider affecting its output frequency.  Implements
@@ -389,6 +390,12 @@ struct clk_div_table {
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
@@ -397,6 +404,7 @@ struct clk_divider {
 	u8		width;
 	u8		flags;
 	const struct clk_div_table	*table;
+	u32		cached_val;
 	spinlock_t	*lock;
 };
 
@@ -410,6 +418,7 @@ struct clk_divider {
 #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
+#define CLK_DIVIDER_ZERO_GATE		BIT(7)
 
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
-- 
2.7.4
