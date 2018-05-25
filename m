Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965176AbeEYHxz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:53:55 -0400
Received: from mail-db5eur01on0048.outbound.protection.outlook.com ([104.47.2.48]:37608
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935918AbeEYHvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:51:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH RESEND V4 2/9] clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
Date: Fri, 25 May 2018 15:51:04 +0800
Message-Id: <1527234671-31755-3-git-send-email-aisheng.dong@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:yyk3xw30Sfo0if5PhxpTh426gkajy55bQiblFdOnpbhj+Jgc1JN9XpnrSOn1yj/mTBLyT1IVWy0mjitSVs1wfFduFYGsiVZA9kysGbJRwvvY7hhIczA1qzP45pxXEV3iEuVrkbXtz1VquRv7WS62Q2SLusgT02he10wY/0shTHQps3mj87E7xmwsx7OVDC04e1q6XMWYlSo7sKCSgS61IdEyaVG6pnaEFWNBKi/zAZ6//ffJjNucQL+6OHzFxtxC;25:6ZDrasHgu8Py1oic04Krw8NVGBJYT/kRzcaAMIreP+qz0olryM34+07VlrZqt+E4i5aE29p/npo2OsX+qz/tUYjm4T5gTK5W6osh9ugFzFIhkDVxZqL2FkeIL/XWUau6gp3AAs+mByOg3HvicGGzJvJj1Jqn6ZLXb2iUvgZhNREAW6YAOggVSEucitXC87tcVeYbsOdq/GcBzLUCvJDYzq9RVmjy+pebYIShTwyajoGXI0DiCkea5kq0VWTGi4OVu4i47z1oBgXm9qmtwrca8xRGPu+6BN6MlwrASd/Oib2wvdEd+z5DUQ6smAk0qsaqqiXBmtEizh/WT1GvYQtDzw==;31:egk7lY6TLniYDzjhs4kOjufkKFctQOTuGQWstJXuD+ONWZE4KoxXEHIE4RiNBgKGgrG0t2rmgz/X7IMUc1AUq56QHzYbcXiXxXL1eJHrJz99SPL/JmiiQzd+Si2fSeEkP58HDdBNAvcrhjqS7DBYRXh9pWNnuGXs4HzNlEHfOdbJMf3qkzgKvHFTNBAdhoVhruECa60Bz/NQlMhcu3VO2+QdLn0OyLXhoDWN+lbdRjc=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:3kOoKODmdFAKjRXjOPPD52Z7Us6umv+bFSkyTwCuBhA0OBt/mrJmnqB27hILaalNxlTGHEE5H5yNuqA/JtH6wKw/C+9E4SlHRvEVQE1oBkxcqfLIq7SzTbbyJC3YbIft8ziWfcDdUg5AaM4axbmcDjGsJ/PkOVf2ENaLpXczO6gpPa28FvJRUFmLHUxAhsgti8okY/4m9Ez15FjtAV1Ojg8SBwmHfCvGF642lcFLk6GZr6YarPbXuZIfVobqNUqYEZ3cVFW7fL9NiFxFuJo/D58MuX/ITvgCs258F87uKlNaFjR5ozBvO7nCQKjq3n15+dSxjrmm2s1OVFq6/TCwaNpqIzvInLytkmxTwW/Fu1WN5KHZIOXgRO3NIGwbqQWMCEF4lrSGn2dR3yrfCHaMIjhXArmjmCSN+08L50//JQ+PKnqo991AMi4XIPhMBT22FIv1X754/7N+8wSt4yMT+SH0LPznlxJ1o7n1a7A0ObaN+Q+0UZku/nulZOHGvf16;4:E9AVy+RAuJxp+7tCNxNmBj5CgGL5ybc4RrKA1Gh724BFTkTlPlwdpnD1xKZOy77LYo8J5WbSudJWGw7XyXywFCybGSrFJW3eKbIAN8mBPTofLh86QIeT8XzFQLzDJF78We+fm63xKDDkij84gl1LUAHZFqvT326cIVrgn14a8F63PG2+kY7xM5LOKjzYQR4R+1PGzAZk7STlgOQcncqwR9WUTGeBEbjctUW/ICsFpeUbpVWn7pfEV7+fKslO0LSl70KACCEnc4tH0V9fQhG37BwB4NFQbLZN18851A9+RFp1gCHJxlI9ZnoRBDPPzbtF
X-Microsoft-Antispam-PRVS: <AM0PR04MB42101DBF79A635C421D2EEE880690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(6666003)(52116002)(68736007)(51416003)(76176011)(47776003)(6506007)(386003)(59450400001)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(54906003)(16526019)(316002)(2616005)(446003)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:P9jecGcghEabno5cgeM0rAlS5mrBa58hQDAxlHInO?=
 =?us-ascii?Q?HrlJLYihiq6OR2fJiFtvDqDIlVk82wC68mjhdJZ6h7xduCRkwaRmeZQQlS3j?=
 =?us-ascii?Q?T8SI/hv8UtgxzY+BcrXtSxig4IgotTre4trW5GmwJQgcDMnJbOKJ5Wk9saYq?=
 =?us-ascii?Q?nnTLdb+5TjbamTWfM9amgCRVRsa5Ovji4IHbficfsEVLQB24i6waVmVVqxsn?=
 =?us-ascii?Q?TKUowaAXjEFde1HuW/Sd129ez5kb3fSN69xrrFZXILZzT7djiFdvzmELBk2v?=
 =?us-ascii?Q?zmV7kz9HlwH76761qECsv/DlXV6H+MoS4kutpVLjgEAs6xuQFtmJ8Ch888t/?=
 =?us-ascii?Q?Ud+bNBUTvp3yFKhUHmeKXBWoCsLdv2rA65S6fMPo1ce0EbgtTeArkUBuZRSC?=
 =?us-ascii?Q?tolROafsqzAkBbxPw09iFupxEu54IAvfHyVd03oZ2/gxfsdif4DbLFUmzkDK?=
 =?us-ascii?Q?HM+5OmMf51tUvSw/jNyF18JbNSEz3u7TbQrXGmGKI6IAWfe0JIEtxbMsqFRR?=
 =?us-ascii?Q?SsdsSBid6fKW0W8Yxv1YAZjaf+t9pOq4Shx+fudEfE5g11CBJrYsQkRHYYl+?=
 =?us-ascii?Q?MauqHdS6IlD1+CSfbjpMPZe0+JymsDDZnJXKklv5mn/PHc4C/GucSncjF7WG?=
 =?us-ascii?Q?BmKW2oHsS1tItOWSgpomO2RLeMaWWQzAn7GxCBY9NXedGWm1f0WslbEitX6c?=
 =?us-ascii?Q?Xq2agr32ABEOAgp/DS5Os93e7WhhrVcd1kItwcAoX4Pm//1pHzusdE85bw7+?=
 =?us-ascii?Q?XqRDHjwiI+R9ZBqtp8kFkmfOUeSho4a2KVveJa0/gucqXLgKxKU9d2OnRwxo?=
 =?us-ascii?Q?33uYmufl47yEc7RElhLRWfZrhxvOHxB7R9pNFrIOakL8zJUBdroTQ7LkKRWI?=
 =?us-ascii?Q?+9QPb2p0BSfyhfg5ZhfbZOQduXLZTzreh0GO5a2t0OVqvLyjHd7sieF7U+Y1?=
 =?us-ascii?Q?dUrWRM2hMEYTzpy8R3yJJ8LYcUZXCJ7q9sPtBjCpXbHDDj91PGKNHVhp1gwo?=
 =?us-ascii?Q?BWenw01A5DVdFTo26FlFrOuuGQvMKpcimtFczk8WDU9KBuiXc16p9gsd0RbU?=
 =?us-ascii?Q?FAWiqT5j24aLPv77GjEtJqqTrEJhiHjWgNsZzuSAFCDn5L8ZU38d6Xa9IUfz?=
 =?us-ascii?Q?+rkKEOxciRb/yl4Iw/0tS6a9SyzVuQNLAZYXOzHMHamAL2fd//BQ3YH5WXKS?=
 =?us-ascii?Q?2pgHIt9nYoABOkHoO3AzujZ0NfS5KRLgb0kucYtQk7NznzQrDzNS931j67wx?=
 =?us-ascii?Q?YBKnAtxMCrzhYJROtu6cM2w3wNLnNS8AEEDF5RsUSZDUXI/XJS+e3Rf/5pYc?=
 =?us-ascii?Q?vWVQQT2tOfdJAg9/GALXg0=3D?=
X-Microsoft-Antispam-Message-Info: i3f6kNybtbq0MGK3DzGWdlQSa/MKAw0krGiTiWRsGBZjWt2s/8lSJlOh/EgW2loEPhiba/Qta8dyQuelWha7PQfvFi/IMHzTTR0S425HClrPb5t9+GhSLuUq4UyAkCcadOKR7fxBKlTkUpLcWOUO31IJdOK0gIhj3HAFZmeqN0amUUbC67l6D8/u/BJuL1GP
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:98Op5+9bVYAwtSr7ZuD1dw5xCNnRarJw9RplJbzaswlqNzxjOi8kEp/dw8pdcntfJTcUZkx2ei7xobxcoAy27MgzeY93nQSNs29FOwkt/bi+AaHXrYidACXUiNNoypPZCm6/GVW8UGIoMzEOLk+Nuba6fI+BZqsyKQJt8HyHc5TAiNo3ptAs3KHRvqgWEswFUFR7MB77S5Wg1I3rqf8i6Sd6vVy/eOo6SQDCpWg9MHGgt//mMjeWSISGJpXINGyB5jxQDlxEGETtgJx6ENNJ0JL26fdDX4T5iLLTab9/c9smsiMCrd33kBDuytWAsgBDyC/37OawCbF7mlOX48vDu31JpWfeabX87fl9jTcy+Tej17kYI09Zpf8PU5EwAV1kdIJ66GxleWnj7HVob+MNINyybuxDWL3VH+1KYKlsob9l48nvASe5JQFhr7zF+1Qdg/vp+zDMz6P73lTrR+dUcg==;5:OZ50KfkKODwCZlkvvwiZf2AlNVnjSmke6mc1mQfb7Vzs0K3Kn+wpkKWqETFyjUt41fXkmFk9iZ5DLjy3vgeWOqbTZ9sVekd/XmEgDgbxYEyDmSiv7zY4jr9gTIGiqm2zVQYXhtytCvnYyFMfpnbzfGoPDbitOe8o3cJ8IREr/5M=;24:DaoTpmIAUrvlpVbVSxsSV/umM/jqZQxsVPtIRBCEfXgzg7HWaaOSaFESWyLOSCEg/EKrEnKtlyckBvu71bAPBIksKAuhijRIRbMI7RrrtP0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:0OrOof8Ipv0/+/sp/6LEkyMJnETIYqlVv7Agf4AVgqskY1tL9jZvBSomCcwc3eojhbVB2UqHMob+nSIILn8GUn9NnqgXI2Lw6+GleuqTAkyURYw4LMHQFg4JHxA9JlXswXR7tbznn+9xX1NkrgOnLFXJSyb+q2V+6JCM4/OE6PQ9Cp8XvqHfaA3h9YYiMb4jevfAkKU/FrfMuaZ756oEpqpOMuDBGZ559Xio9qwfdC4mFzJhdqhxOXcnFSK6JEtH
X-MS-Office365-Filtering-Correlation-Id: 9daf3fb4-4153-4290-80f3-08d5c21459d2
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:36.9890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daf3fb4-4153-4290-80f3-08d5c21459d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
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
index 3cf522f6..8fad6c8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -577,6 +577,12 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
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
@@ -596,6 +602,8 @@ struct clk_fractional_divider {
 
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
+#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
-- 
2.7.4
