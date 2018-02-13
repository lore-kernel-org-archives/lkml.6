Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965143AbeBMOzr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:55:47 -0500
Received: from mail-bn3nam01on0075.outbound.protection.outlook.com ([104.47.33.75]:60416
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965093AbeBMOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH RESEND V3 2/9] clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
Date: Tue, 13 Feb 2018 21:28:07 +0800
Message-ID: <1518528494-25723-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
References: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073427270681;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(396003)(376002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(54534003)(105606002)(8676002)(36756003)(81166006)(81156014)(48376002)(97736004)(16586007)(8936002)(26005)(336011)(498600001)(47776003)(51416003)(50466002)(68736007)(2906002)(104016004)(76176011)(77096007)(26826003)(59450400001)(85426001)(5660300001)(86362001)(2950100002)(6916009)(316002)(450100002)(4326008)(50226002)(53936002)(6666003)(2351001)(305945005)(54906003)(356003)(106466001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB1421;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD010;1:iFvPDdEyabK/c/SS5Us3Lf8DEye5SUIjyhLb5Xa07GcSgFw75rgG2L6ynPJfJx76+9pspdy60PoWhLgbGyy9E3C8l+4rBbFbqJnsdekhPDruAO/cdoEB5zk06nrEstS1
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa8215a8-3a43-45a7-bab8-08d572f1dad8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR03MB1421;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;3:FTEQYpHqVbV/kmHa1TFHUdrNHH9UNgug/l85SXNFw0TJRKCVjklVcNvxZLntGvLxZPVFclXAG/92JV4XrvB0l15wW77LmpnwjE7k2Bds+Xru6R2B/buXtUl1v/ifY8pVL2ryKiFiIeMaoDxNZQmcs9FCvYFI9Px5mKKjFoTGv80zHvHwTzbKJGBamtGi4KQFPt53UDhmuSZvS1IFF1cB4lhBTUdChspJeZSW5ye7XpzLGtlWgmyflsRvBZA4+olBbYRNjXyCtMvRsfwPJYKLoiKGTpya9v27AZDTRpfL2PvP31GUMOBb+YSWQg0GNy55VSrOEvu8RPZPUEjNFkyF89/3ZxbORV163UDzbtgADTY=;25:pSPrTB/P1qyz387Wft2eQ5SOGffVPNrwIPOZlj1pHyVTIAAXYMv9gdLUyEjYMdR/59eY/iP4XAfNCaIbNzohqnQp9h2S5zI17xodbSE9MmDe9WoBI7gk1JHDtSDxd/Z5iD4U2w+Ehboib88JO6PFUayKUHDQFcn6OnVNAx20V3mrsl5ZGjhQ2MfAS/DKVTG5XTv3gLWssBhx9UbyeeaP2pebVmMd/K0gAWXovVRZRQFWSQYbuC1UCg5bTaYtoFu0eRQ3eX4wi4VC0umhEptxoBInOVWlJd8u935S4QytCtuVWBps9FlpQUxwD6AAxX4Ww16vD7o3rhDoATTr4wAVaw==
X-MS-TrafficTypeDiagnostic: CY1PR03MB1421:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;31:nJsnf+bGL8BKTVRIpU2mlnX5qAhwP5+RIFee0g9MaU/FYU/5O/WO/+Or/3Bb1DPKxufj3vSeiv+4rG+M2cMjFO8RNkHDJN+9fclJA2JxmhuKVVj6ElInPcHTERYZdCQy4b1l7qLGsuDcZVyeOE8HqL6TVTLUHLHpjHLQw1aBjO1fAFDtvfT+sNxYblOAG2HyU5dn+7NyIcsaHnUvqJj9G2fDooz7H3s5y+7wPdKYDuQ=;4:rXeACLf4lKuC/HNBLkl+3rqi2T5OD1bvCgRXsLuNEoG+t8rsm6q8N7t2z5vu5TC8kw4fg0uC44D5xPy94pxqDKVpbpxH0ppjOBwAjaZ/+YUbl8AjaMvu+Uxb3pVggCXs36B4iLeyuBRJvVSc4iAqHis63Vla3SNx3Yrc+SiVU5swPbY0JWszLLsfASe5frvhmkfsj7lWYMumWR7tWBPB96guma80opuU/LIg0WPOafHV91nX2QwJm2Rqf8rzWpr0lGwECjrvpYHUqEC+zCHqo1YNfQ+t0Te7E5JeNzdqrIXA5TqkuonAfm2eGTDYf3uz
X-Microsoft-Antispam-PRVS: <CY1PR03MB142192006174D6874684CDCC80F60@CY1PR03MB1421.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6096035)(20161123556025)(20161123559100)(20161123565025)(20161123561025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:CY1PR03MB1421;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR03MB1421;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB1421;23:MLiFPTztJ4g6u2EilIOhiby4r9bGLAXN70kNgXNnU?=
 =?us-ascii?Q?eds7tyYX5xzk3AhWRMXUVkSQqD5qSCXtZ8DgcqwAHACwp1Iu3dUsCIFmdd4y?=
 =?us-ascii?Q?14Vgj6SO7MAR8/2lFI9BzAJwMb5gjy8gCXO5suK5iNli7m4p0WyIRHLU6L9h?=
 =?us-ascii?Q?EXxRVtGzCVtcm0Ym60vOyc4LO4UPYWOLw/XpWBFiTEKYXvli5FWQNStfU/Sx?=
 =?us-ascii?Q?mc+oNE0l4XFBAeGEqkafO3LZ3rXJM7+Ssa+3gcshp7LAv7630Xa/LZQVuPXd?=
 =?us-ascii?Q?pBOena1CXR5afk5jmyMfJmMhxjRgYM9Mq5DJZnpuJFkKm9bx6r7hf4PrLJLI?=
 =?us-ascii?Q?mO1kXH1IDhxaIDybIRXuIokNlPa7fbYMiFMLFCblbD0s9FqidhOhkw6Xupbr?=
 =?us-ascii?Q?WUqN/UJdkUP+y1igmjmGSz/aaTCa6DJGgSiaGJMVS8d6KP5KY/s5966qUXK9?=
 =?us-ascii?Q?hmbJg3SWa4NhjLNQRzrq+EAv1hRQTzxfpcTMtWFe0Gs8w6ebt4EjjoEvZiZT?=
 =?us-ascii?Q?YLLYj01lTORULJe5mKNgxffiIp4o7XLROAJc+TBD/8V9RGQd2NvqOqJJI9Jm?=
 =?us-ascii?Q?pR31SyrOEatqk0gAwRR/HaMmLdcHzTYC/Ly+BT+Dk3Op+qWYXWCCadsNHIXE?=
 =?us-ascii?Q?SaVE4miRVocChnspzHk6nmcgGj4v9BOp6tKtJ8zefylhP3jIAv7904xtWGdD?=
 =?us-ascii?Q?Dnbg+i2MC3IFoFD9V6enrhJwKqaUOCmsTmFw8U/wy6yzjgSZxxxWbRw7HCVc?=
 =?us-ascii?Q?attlyIxKr0vUOI7GjLMoHArW6U1JUuERcfNumvlEba0PYUdjIYD0lqsnJCSz?=
 =?us-ascii?Q?S7Tn7lm7cUbbY7jV/8zLoTbdCNfBo9RuVexKInOkFi3BkA4+1gQkGShnGaaB?=
 =?us-ascii?Q?G3IHs85OKW0mU7Y+Tc+UNgAMhLJjp0xPrqG9ln2TMx9e+4nr47ATTxEds+bj?=
 =?us-ascii?Q?SyyEH3qVh3H0IiKgUbYlRPP6RkPeNQN2QCutgFGeXARHvecKIxa+8tjOqWOv?=
 =?us-ascii?Q?M2w2HhjvJSvVQZrXZsm4t5czHYA6HMYaT5RWPSeOlJ2S/7CIt0/Z3TR2ECFY?=
 =?us-ascii?Q?C5fucy2mARPYf/7XnCFP6auI9Gf9QLoKWRmMrlkqBiZZMVfstzDZJ8qyOjjF?=
 =?us-ascii?Q?WO6SR/zTiXADXypFHTJemv8k16cdbuLrAcTLlisz3cNDue6ascB8a4mMQCB7?=
 =?us-ascii?Q?cl9buhNI79MEuw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1421;6:c2RoKbrZ+Eu4sce4BuA2A83y5Wxi/B1oU3kJPDoFnBt26wbs7JWrUxymGO00gNAMezkzwDyGrre9RdGgOObLE6y89oFeAdkEW/ym31B30AVvRK5IsF8BYW3VZr5ad6RGBZzKIpOzLZctbyiQOh5k9FGI2cBD3U1z1dQWu96v8HJh+keK/Npv+KAK49ugLwPCvVIgY2pF7vPpnIrgYX7vi793GRS0tHPT9bx6QXJWGKhEOFQ6rq/RqvhGZgweam/+9+NyPAmdbCEA+IthbPuOmzN8QW1a5LFhwIy2PTvPaSe33GMkSx+MYh4hF9IIpA9Q3CbQcxfTW2x46hCNkPGABV1ec8ajDJkjPrLWUmn2fgg=;5:WdLvpl2T9M5r1B+jyt0NR1v8Wze3uyQri8YhlsdmW2NHq1frPuLb2kHFzRQIvdW32Y5pslBioXTFWRMmBHKfW1D4nG+9xT90VIRb/eUXNre3NwVu7TaYe44HJYdll3tMAV1ScXC76P46scoh9HISusr7LAahKAIPvXqyv2baMRE=;24:7rI5XxTls7xWSKTmY/hx37FpXIUzwhEdsnJcEXxHMXEBJBCX//3Djw1NLs2RqfKKmzXKrv+JkkFsbv4SScxCfhQFAAjZfPgLD2ABsbVrjQ4=;7:julWp+Pq/tMwXw6vgtvd4GxvL3WyVqC4CPIOfPCKMFq/lm29YZFcIlTYK2ReMEMQ+j82BceVaRSl55LrqF6/XgoVWzewY8n18o1YIEeaEIOkEYqReS3crIFT2pt9E7lyjbkI64IPZN/ltSB8VNs3yXE+Uqxny7AdB9l+gd13hwLRDcU4u1spUGKu0pgJW1W55AQDkXORSW7+byXd9L+V5o3yMpl0zhTCfLVKpZKUkgMUK+3B/wjXWeXYXJ8Ips/t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8215a8-3a43-45a7-bab8-08d572f1dad8
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB1421
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CLK_FRAC_DIVIDER_ZERO_BASED flag to indicate the numerator and
denominator value in register are start from 0.

This can be used to support frac dividers like below:
Divider output clock = Divider input clock x [(frac +1) / (div +1)]
where frac/div in register is:
000b - Divide by 1.
001b - Divide by 2.
010b - Divide by 3.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v2->v3:
 * no changes
v1->v2:
 * improve comments suggested by Stephen
---
 drivers/clk/clk-fractional-divider.c | 10 ++++++++++
 include/linux/clk-provider.h         |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index fdf625f..7ccde6b 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -40,6 +40,11 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 	m = (val & fd->mmask) >> fd->mshift;
 	n = (val & fd->nmask) >> fd->nshift;
 
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m++;
+		n++;
+	}
+
 	if (!n || !m)
 		return parent_rate;
 
@@ -103,6 +108,11 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
 			&m, &n);
 
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m--;
+		n--;
+	}
+
 	if (fd->lock)
 		spin_lock_irqsave(fd->lock, flags);
 	else
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 68ccd36..cb55b67 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -566,6 +566,12 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency.
+ *
+ * Flags:
+ * CLK_FRAC_DIVIDER_ZERO_BASED - by default the numerator and denominator
+ *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
+ *	is set then the numerator and denominator are both the value read
+ *	plus one.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -585,6 +591,8 @@ struct clk_fractional_divider {
 
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
+#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
-- 
2.7.4
