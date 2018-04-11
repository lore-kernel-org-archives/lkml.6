Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDKODq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:03:46 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:43066
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751880AbeDKODo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:03:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, linux-imx@nxp.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2] clk: imx: Set CLK_SET_RATE_GATE for gate and divider clocks
Date: Wed, 11 Apr 2018 17:03:29 +0300
Message-Id: <1523455409-7771-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
References: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR05CA0266.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::18) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:j/9xq7pKCn4C508N60aZ1LXfFUHi06BvGU1iQGG7H9hZMUfxSvFL/VYCE4auxIENTTBJuvkItLQ4/yA7YFkngGdwyvcq+L4wUdl/dPN25chu83lT7TcQzL5owbM2bKVZ2tlagPpze0k2m+JfhjtK/c5yxVglXQ8HVVc7LuizWubdLl9ePg6nsxjwe8/z2lvIJeO9CHNvftFDs1BUUSyaCfe2Mf9ZQj5qIkdAPcKJkxWHHZvRJ4VlpRJ2hSPb3AZv;25:/hEIDisOotJH4Bv9BD4wN7Mf6j8yD85uyzh5f/ZyZ/mFqCUjVtQDukPoBA9JJJILcD0YUOY8AZ594RozZxScAgMSpdgXwgpbGFlpoz4RRWCWRcWurwEcrp9Re/i3dy4CkPXxa7TscCfkLbPieJu93uBE5F8g3ubNqHJXbWIzz97QAIWIWbhFWrrdUF2Ao3Ss6q2iQC6LSAL23xzaLc3wYyiYkFpVnd5DklP5Gb9zcofmtxl1FfIl2mfIGYUu/e/Jup54szGI44IX2+fzQBHXBfbBFDFF107V2AXxMZTUI9fYZvXnjNbOAu3kdgfJG7e4N0/z9h/hosj72dErG24HOQ==;31:pPFvjZq9jQcEIloVlq5szHv11P8I7g0+pRG4lhmbQdHVSbJYacg6rk/Dg8LxEZGy9IkOaOSvyYy63uSLwNUk6KI90PHYdt/ZqQZCN58928I22gGU6Jk6WBw7MDVqoHbpODDKdFOO4BLgZEz2Ao3jJzh4ikfPztKV9Vt8K+icv5F0jjliPJrBddc2QrK9r9rr/dEfk21zVlMX5BMvC6UY7slkmNmaV22AVkHQRPzsFOE=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:X/8f/6Rhw2XmDsLu+gDHT8pTzLHvWH9UoSB6U7bRzK6MZjhJgQhh59WvOPO//PVTDKz+OgjhTdMN7dlK0fiAJ6Kj4OV/7cWrVZc24u3IKmhF25W5iXZOlXacL14rVaCTK0luYxN1uWqYj6vauqONn7L7XeM3KGNnUvfhuuvGAxeY5Kkgg5btcCZL7Gp0BCfr2DGwLfFKKMi6KSSP0MwMZ7zI8gOyXHv5k7ifHiXpA9J5eOClYOcTOdyRZbkmpH7loLFiRCi9Te+uQA4l8vMBTT3LUOKAEoudAQt+yJARlaN5QI/D0Y5VKvnEO9Zmdb6sxiido1FCtwK+bSkmVT11KkU8NlbDU87ETwybLQRGX/DJGgxZEhViT1sthRSGm87Toz3xC244qfYiLmT73/MQ4kluXyUL7Swy+H/FtahkdlRlQz18NKLYFXU7NB5OWeejTMuIzJdWGt7F5/pIniEOTtJKQI3Wkl8gCB4Fcv8PUsAJkGuezot/7M6duWWBInd0;4:uvORH6CSz0OjbOodfbQgfdeLtq+7GxsQuonrfuYsFxIKnJpxaZb9nekZ0Yv7Oac/IZqkM5YlZqN5ncl4dQRPR09wdA0UnfPoQy1/8MxS5pEmvab0Gi5jbcWR/zoByP6VB8x9QH2YMwu0TrKPACVi75pqvfUN4bpDSx3T7zM2JCZDw78j8QQg+tJxuphIsdEFTZhUxFfRymbHfGr3K2ghuFUExKcaldkVtUelvuyOwcU9c08YwumBvUDnVg1FEQVXU1ULoKSCfFl9Ip3E7FCmvdgTvwTMZqd/HDz3Y3irshk7z/RUzHtHkwOSv1iR7ah0gWe4SA1VqVx/+onuePsUC7lXyTo+t7EMzQEgs6k5CjU=
X-Microsoft-Antispam-PRVS: <AM4PR04MB1601160F4CA0080F5F557351F6BD0@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(366004)(189003)(199004)(59450400001)(76176011)(16526019)(68736007)(186003)(52116002)(86362001)(106356001)(51416003)(66066001)(305945005)(48376002)(2616005)(8676002)(6636002)(956004)(26005)(6506007)(6116002)(386003)(105586002)(97736004)(7736002)(25786009)(53936002)(50466002)(4326008)(3846002)(6486002)(50226002)(6512007)(486006)(8936002)(16586007)(316002)(5660300001)(2906002)(446003)(36756003)(478600001)(110136005)(47776003)(81166006)(81156014)(11346002)(6666003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:hOerz+Kwqzzqk7URucbBRlzdB4Aknmk4U7dkZ1X8A?=
 =?us-ascii?Q?d28H/311AkwWzLpMvLfevOKKlaAYapoE4X1Yd1kbvLPMhmWyt5qQSqqQB1jR?=
 =?us-ascii?Q?8DgSvLWdgYeT0By66WiAGX+GFI/Bvjpk7wB/qMwC3E2GP2Pbw3enTNSDMUSh?=
 =?us-ascii?Q?IDBBSqO1kccNHbNuG9lcFUHj47oBqt3aEH50BICxYtEF/Pp0e5FMlm23shgG?=
 =?us-ascii?Q?3+rRIKuxcVbXe6oRQ+Nd+g/GxUvaHx9AmTqjuDd6WFMOCpmvxVs6BI7fuORe?=
 =?us-ascii?Q?/iozBKHfXlkGY+ImCwnsNiuuX1QRQoFuk61/EnvgieKKWpjG/U+jsu4AIu0B?=
 =?us-ascii?Q?Pxxq8QoshdZE4YmYIHge1EDBJS+ZcDhDVZjyaP6t1pTvS1WH4AzeINUwvhYU?=
 =?us-ascii?Q?QppDtcoCdCOL83ZGyBwQRw9B+GQ8QAhby+K0CQujrhNFYDy9TqnkI9n9yn0M?=
 =?us-ascii?Q?EW8CLvFZNjAO2dfBwTVquzi0zMoBBdhNr5C9ammmyWYvWs9tLGWyGrURaZAf?=
 =?us-ascii?Q?37OF3AtwjPk+NL2UdaF0zNC1HbzA5XhREjeUQ5kMVt8FRFPZeXHpS4m9lfTe?=
 =?us-ascii?Q?8dmlH9ozBR9xN2EUxUTQ1B0kFbwiw8xqERgIZaO8E/fLmGu3/+RSMSBq4d26?=
 =?us-ascii?Q?ZumYhMWMn/hY7y+Alj0ACaFC+w7Vk2JsP4U9nk7WazBaxAg1yH3zERmIAJ3g?=
 =?us-ascii?Q?XPEoj03mkieSoXIceI6mqJmNG4Ojawm/NpQY5Z7/dXLWr/41eP9KRHxpTpPw?=
 =?us-ascii?Q?1e9WOjhHltQVdGMPwN9BhNxgJHubtq1hkvteoo21Tj2wV1kryA5d22Bp29x7?=
 =?us-ascii?Q?yg3v5PGOpzR9rm/tG2lJt01cIsSZ6CS5ON0uilaDXD5IjZEW7v7t0UvF5OOR?=
 =?us-ascii?Q?VfEn6kbmB+W8Kx+0nna1FrePYD0U3SRuMgqdUygc7cedTWW+aoe0AgnbqP17?=
 =?us-ascii?Q?qsH6HctIxHXVhcsHg0HxiiNlY5lrtda0OaufU0sIfqYJLdyNYq9Y5pysuS30?=
 =?us-ascii?Q?8SbNvo9nXmTaA5xOdKvNcdNkjlbcZGSdoLbr7P4Z/oxaR0vJttOAlWhQQk+N?=
 =?us-ascii?Q?11HHcZftLat3R+yh3KQrX3oqYVrd0RTyIvmPOLym8nRltNJjq2kMnicUi8QC?=
 =?us-ascii?Q?nq7MHC2KMh4V9iIdWcgiVbiouxyBXylS1qtf8jveDF7YWCUCb2O5vQ89jG6m?=
 =?us-ascii?Q?y0FpIXBn9ufdhFvgGM70J8vRO4Wo7dsnyzGPq2msxQaHSr7DgSq1QoQEg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: dkqPT801+nIPjVaN9ZyA4iEM3ikkdzIoSSg5q6aDUYYp7QActSdPrjfiTrX5BJ4y8B6fw2PFE5PmxIxnmgA8YUkgulerbPoXuMLD49Z8Mv2XAilJxf2exkbD3gTey5VGI+BtMSGyUXQRP5ZjZUw1Msn3MmRFZB64GGgYZRJyjlxzU3LuIgZpzycHPZFyRtRV
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:/xWU5yQUKA9Qmsm9DNgLFMAbJs0nTCpoms/gqufVDEA8AWvXNCcLMU+TjXLhUUCZN1NgyC214X/VnN5Qi6p0voe4Wa3cvTojsEInL354je6s0AsNXap4TqkycHU4YO1wfO/meTPi7uhRbjPHN7uA88sTzGEV1B98mzossBwr31C7dlhuWHQlMl6FxcY3ua/zDOhjs+3kYL1qBXTy989v97pCJUaNjjuFdG7aBgJqFA3yZAfjmcYn2oamQc/sxQZpixC+OKQYxbuGy09qcu5uqasUyT8XpautQa911pOHUjmSasC/XqqMI9I5s/W1iWFAM67pG2YdcBtbl5/o8wo+xHzPSFcGZ1xLE/1uZxWRCMUQPusF9g0ZkkjOjS4kOqZ9E3g6QTyRTeP5GSm1oyzoMOvJvu9ITkSfQxOIaUQ/CFo18b0CokEo7jYD3RykJJJPGFghfwXU71vIzA1/lHudXA==;5:w1iHxUYLZAe+/MEJmBYbf3Zvw6IDFfQEaphr0Tre2u+7Go/Ii0w0Wux3Pbs3feCLVAukIyee8rhwojwzMkIdMfNLUVbXkYgmcxYPQAopVYWplFaiyEUlNcIqTnmHHSwjd/CCyJxRd9nUB0VmhUzfcbUI9PnGwReedXUT/ovbjtA=;24:uMDoEj7ENVquvuANmLCEp7xuGV67PA4apCSGagXpPACEkbcWlB3IF/Aq11BkIFAkjJJj+/1rIOHHWUoPXjXd6mYsOUebdl/E6QIk8WG5orA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;7:2qWMpNQ/rNZCc9hTQu+D+Puvux8WsMBAqruMR1mToSu87J4nXjOohqwsb2M4ozemwLRfv5l1CJSOwOaH603ak+nMVxLUMwBKwPSNgC3Z05wPXYibs9UQUKYEH/98ahULqdPWO8/M/WAh34ElTzYCywUiADJ+e0YDlWULAHF/TcAmS6IMIfyPGHXfbmE3tiKzERcSOiodeUnav1uQUgE19JQ0PBqJ9H1DYIhwvAiYhIhyRZC5oqDpkXIXRcYlMcdZ
X-MS-Office365-Filtering-Correlation-Id: d09749af-c168-49e4-ca39-08d59fb507b4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 14:03:39.8819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09749af-c168-49e4-ca39-08d59fb507b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawnguo@kernel.org>

Add flag CLK_SET_RATE_GATE for i.MX gate and divider clocks on which the
client drivers usually make clk_set_rate() call, so that the call will fail
when clock is still on instead of standing the risk of running into glitch
issue. Rate cannot be changed when the clock is enabled due to the glitchy
multiplexers.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
[initial patch from imx internal repo]
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
[carried over from 3.14 and also applied the flag to newer functions]
---

Changes since v1:
 - changed ownership as per initial patch

 drivers/clk/imx/clk.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8076ec0..753ebc4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -96,7 +96,8 @@ static inline struct clk *imx_clk_fixed_factor(const char *name,
 static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+	return clk_register_divider(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
@@ -140,7 +141,8 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
@@ -155,7 +157,8 @@ static inline struct clk *imx_clk_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
@@ -164,8 +167,8 @@ static inline struct clk *imx_clk_gate2_shared2(const char *name,
 		unsigned int *share_count)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
-				  &imx_ccm_lock, share_count);
+			CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
@@ -187,7 +190,7 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
-- 
2.7.4
