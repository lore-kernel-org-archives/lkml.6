Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeC0OT7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:19:59 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:25408
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750898AbeC0OT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:19:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peter Chen <peter.chen@freescale.com>,
        Irina Tirdea <irina.tirdea@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Anson Huang <anson.huang@nxp.com>, Anson Huang <b20788@freescale.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx7d: Correct ahb clk parent select
Date: Tue, 27 Mar 2018 17:19:34 +0300
Message-Id: <1522160374-31894-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0901CA0087.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::13) To DB5PR04MB2136.eurprd04.prod.outlook.com
 (2a01:111:e400:c582::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82dea8bb-9e8c-4a61-8849-08d593edcd73
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB2136;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB2136;3:/LlW9wbyn3SszycdN84W7lucVz8xvSJXzdwFZujVBbm4ywZZ2VMNeoriEN5VEufINE+CKLeU4Si/+FZSCK9Hwo0/HxW3KAX4f99TAkPNKLakKmRJ/ENpazXTzyJRxIl+koW64kIdNrHysaRT8miugZlHt2n6UvtwRud1/016MQbPeKCEHxw7OGNeeki+sFLgjoLcqNgGiBbupEenvO7owsovXKSNX9mPCwAmH6w+Cqyb7aRtyS8dOHHX9f8+OQtR;25:Fv8BeaY0ve85Po2ynVH+4A8Gg9BPK+31gIGHpTo/LoeEHjPEXYS+yhMgu3WhnyXoWdWI1MT7DlGLpTeWBtKT4BRgnaRTR2vGgLEjH720VnmkFrzdgKyno2KYDBeJv7r+85j07UEUzzkcf9NkaC0cLsSKp8zIl5oYzIi0NpdebvEbEbiC8RQDfCJcrwkqAMnB/P9nkkn5VrNQCEYpYP+2bN2D8Gy2PiTb/SpCWWZE11jkHnXG2EVO8fVjjP6KmN5GlIfQUQUAEU6QDSYcyECEGYbRYkhzjSvrOswh6pEHbj5uilGaVF+0fzdn/nWKW/1+Atx0IJ4gScYUsLiKMpuD0Q==;31:VoV7v5gA1kK0Cw0bHWOGFrnzteVn9cIZlTaT5gymqIumzTeQCpl1nEKUSo0D9wyyYtwhuh0457jMAGNcgQKQ5VmC1z/8D3eRvc3cAUbiVtJKVrMXuSqkRdgn/f4jQ4zh95h3dQe19ODXKtjjD70JGq5l/Wn0i/jA9x5GifdMY41NnAl4vxJnxAaWY3IxDl2dA9ynl3gq5uL+QlqDAXcHfsM+l7xET36Wm1/3XRxh2lw=
X-MS-TrafficTypeDiagnostic: DB5PR04MB2136:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB2136;20:W/7inJ9P6FO0VEY+hV91mKW9B03KBqvQQgSJwFro3fnJ7lOiU86PligQEyZszcXz0sNuO3z6HDPpXUzxQLvQAqit3nKa+6QYGC+U7o7+9mE93PXwPBcGSQNwu4qDyDXcbKjtoBzdC5BglcfT8QJOf/0uQ8CgePrHEO2kbVg4QfzBlPxQxEU/Gq8gE5UsWGlRSS0tZ/4nPEPOCKCHMNSccvDpaQy6Ix9GRHKLONcrapsUj3GaAv6HuQtm1d+bsNaYQG69Ev/Mc69TyObzNQcFPo491WLmxX9+JaNSKC26PZLTPAopJmEhyw62Yiz8X+bC/cbE/4JjaiKkH4e8DVabJ7jeOtQFNjONtkW7bzB0X/Wr/059cJ+IiREdPPC7qrtZ/8kZ8wV8oNIY8soId2HAfLCV5yUGGCwSgg4kJ0MFc0iJ7srWRYqheIjYkNa6sUuqGwE1aDUWBkPV0HERzQdm69IjvSrmsa3x3IPklXLiF304PWAjpXN4KIOYHKvjVmuq;4:7dxBzJ1pPdgswO816Re67+3fu56bd+Jg1XhGUYoyT5KQNjf6sEsQmEyN0/B48R/+iwBevsWLSCa3SugnyDhqgUX/IJFbjjKrY6InfjQOzsn8elifG3A5vXYyQX4mZEIATe4X4jI3bEJcMAlLugLJ1hQ93Pi2VmG030YTd/CipZRZHr+lL4rvO4+Hb6PIscVtR+Lfd06a2oprDlcZZ9U2qXULrOghq1MWW1GgksPTOqKWg7H0DGVOjFRO1LWmIikM/uPPWyj2CnxQSkvuUA96yy2TjIOFsxNyj7MBpEHV0y4uL6uP+IKdDBI0L92AsVkVv/XApUHDwRAotyRr3qLHr1W+LKU83K4jNi7t1a/s2wA=
X-Microsoft-Antispam-PRVS: <DB5PR04MB2136E93D24A52DAA2F6FFAA9F6AC0@DB5PR04MB2136.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB5PR04MB2136;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB2136;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(2616005)(305945005)(478600001)(6486002)(316002)(68736007)(47776003)(53936002)(956004)(8936002)(2906002)(7736002)(16586007)(6116002)(476003)(1857600001)(6666003)(25786009)(3846002)(106356001)(110136005)(6636002)(54906003)(86362001)(48376002)(6506007)(6512007)(50226002)(52116002)(97736004)(16526019)(386003)(186003)(66066001)(59450400001)(105586002)(50466002)(51416003)(8676002)(26005)(4326008)(36756003)(5660300001)(81156014)(81166006)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB2136;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB2136;23:cG+7+Ks2rr/dRU/bkp6zOCc8zxuIclYBWb1nAHCkH?=
 =?us-ascii?Q?77+4CJXubog+UnE4Ge8LlK+/PLnrR0RoWLt+Z74H0FRPdUZzndmp30zAE7HD?=
 =?us-ascii?Q?iSqiDNPOglJkPRniZD1ETTbKuUfluP6OI6lqLuaasgg0E60A+fBN4YpC1BEX?=
 =?us-ascii?Q?6BU3jRdeluP6L0GWYoTi1aCmlzGDkxiB/mBTChOae56Yep1vSrpyzmxeEMG7?=
 =?us-ascii?Q?yBrcXi1/v+X2uHSdyykIdnwcavCdFByFsVs0HHLkcyFyGgDxi+vPQzvw3D6b?=
 =?us-ascii?Q?WtFzP4Nje5V4haviwqIhsYLj96RtqPluWti3TEVubK4Db+NTVUsBaZRpCpoD?=
 =?us-ascii?Q?Tl9pBtRO3oX10wxnnYRSToYcxsdNHX7hrZPNBbx7StusOZavdv9e8zmFRjSm?=
 =?us-ascii?Q?Vit9rvhtG06sH7jJuTtM4eU66C4wjTmNyKzd0Gb7Ci2ownmXi7acqqoRB9gw?=
 =?us-ascii?Q?wZRRpwi7EnftWUnG7AEOlbckPMPor/NMnKfXXa9YJZnOjSWz/qxmzJnciqCO?=
 =?us-ascii?Q?DnBzhQmXztmilJ4HmrGruJRPyuSsNSszNkGRfZeHbi5+ESi0cQAC9vIt2hhS?=
 =?us-ascii?Q?2/qWtJmN1M+8KjiuhuvvhLKj9hW4wzRnCDRd6gSU/ABxl/tnCbVXU9cUym97?=
 =?us-ascii?Q?4JRmNSlACSdF0q/MH/YzJxG7BF+shyzvc5RiExoHRO6O7mFdVB+77qbir9Q5?=
 =?us-ascii?Q?I6zwqSbI+wAd8anFKFXAb+/j5l0inr8VZWcoTUwyEokDGR6umMFrOOKiOz1V?=
 =?us-ascii?Q?DIPYIvuvdiVzJGq8eoRorWX1vAg+afD18Xq/DcdypP4GjelzlsynHbtaXeKx?=
 =?us-ascii?Q?2w6FwjHJUkrdANdZlP2ZniUZ/D5rWO4T3g1Qa7CPYiR+C1JLL9Xuq3m0SFd2?=
 =?us-ascii?Q?VmyMa3bvT3El9FjlSp4HOgM+SFox4xdD4U5rsyZ4gOHQQuK12e5nuHMBS01W?=
 =?us-ascii?Q?xlbLDBrAyyQ7QnYQxhXRZbbmXvfj8Y286VLpVxgGFmG/A+hgj3wdse1dd8xq?=
 =?us-ascii?Q?h7QcODATlMcVvMtl1tYRoqWPuejl1VCCB3RLSPVUHyX0Io+6e/ivWFYnYvGP?=
 =?us-ascii?Q?vdkyDp/kk0AK3WsMi+Z9aRjisaGYDuPDNJJ1xPDaG/AZjJ7UlUf+Xb6khU+A?=
 =?us-ascii?Q?CWCvAtF8NvbfR9e+GQmky8KJ51AATfu7ggXvEmHCnERXu/QJFbI6ujfAJMKp?=
 =?us-ascii?Q?3boNTyxWv9W6TW9FXR4F6uZVPScoveFEPS1M83GGMc0Z158N6Qk/YkYcQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: kC+PJCIivFyF1ln46VYk1XP54zTr02+/X63zsETgN9s6rhpTLHjjU7JKlohr+8COgH5n8hrJ4ARSrg1Y0dxyn8nbgoZ/byzHsbLCBQ1FjORDNSGNpxTtoiX50ZNzwGE9X2uzWZEYl6lHtLmghyTl7+n1zvORxHt1n1OAOV0XZK1Mg+6M/Zv8cDl0FjOyr1Cb
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB2136;6:j9muzyv85Ne2HznY3hlc4btE2gU78WtmUGd5hUYdcvCAkdkb//eQqZKPijGjzSBLfuSAGzWIo4ksmFD8wlzJ4Kedwn/j9LvKbBF5bFxLFOc8SmAgybXdA/rR52RPgK0HCWOJJtFCzxhhl8FYJic/csp/4yBdRMsfYT5o8FikiN9KZ10TYOLhibNKDEYSrJiB+D3NddLsAPmWZeQaT+dX2wdwMkYSSijAEEM/RD5A3s9fR8DtrCXgTezwNC+K2EFe2RBtms6uOU0WVGEd7qJ+WNh5xQhrJr7OYMZnvQvBY7NNkZLNsM7t8UQ9Ga7tQXGC3iEw5M+2ohB2KJHLPEjDzqP9gfYQIemgdJfETFj2WBNSQzrepQRdSyWxz5Hg4JfKkKPThWCYzwR+o2hjdTGfj/waYfjr7HA9dkaMwsobVnBWdF8FSPjivieraHS9RcWo5xAOvhaFGhcD29iqIR7IgQ==;5:V/BPX2klaW552t4NBzDprHjGDnsowVJ8ljAHYERdiE6EwHlJNv2ejVFQhj3copW1ia3FKKYrbeaAVJOBUIanP9CcHFYai9/gpfb4G7hx+A8z/fi8ogdDMmckaoefL1+uj0j/d9gRHgMwVVO0Adkw335L1tEDhurXBExyiSYDpD8=;24:LVyHc6EdSSAhpmjqLjiDYckpB+F7zqjbs8lmjFh8qHoASXbSIy8IMUNEzPHd6aMoFJN3YA2WQYfB9sRS1UFdij87QtwHhla+cjX4HIVhJ6A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB2136;7:HWFmqr07NUKquSnQ2tk+vx2MR99plfas99gw+B7gfg5wfymR7qRYSTATymB/7nuZnMogty0C+LaoIY6M5n2QkNXgITtHK/Zr9dwOjf6kcREAaYVlOjUkbErHDkkYcH1fuUmlabNQHgiuApDHD5VBEUhxjuzASNTCFPf6rUTGijTLHEZuEKenrgFi6XwLbmdCSpQvBQlUPBmmXL5Hhx/DBHo5nO50C9mkduiePkrbWILer+9qqNMlPslKxgB00Efr
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 14:19:49.1538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dea8bb-9e8c-4a61-8849-08d593edcd73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB2136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <b20788@freescale.com>

Design team change the ahb's clk parent options but
did NOT update the DOC accordingly in time, so the
AHB/IPG's clk rate in clk tree is incorrect, AHB is
67.5MHz and IPG is 33.75MHz, but using scope to
monitor them, they are actually 135MHz and 67.5MHz,
update the clk parent option to make clk tree info
correct.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 89bfa75..4d020dd 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -74,7 +74,7 @@ static const char *nand_usdhc_bus_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 
 static const char *ahb_channel_sel[] = { "osc", "pll_sys_pfd2_270m_clk",
 	"pll_dram_533m_clk", "pll_sys_pfd0_392m_clk",
-	"pll_enet_125m_clk", "pll_usb_main_clk", "pll_audio_post_div",
+	"pll_enet_250m_clk", "pll_usb_main_clk", "pll_audio_post_div",
 	"pll_video_post_div", };
 
 static const char *dram_phym_sel[] = { "pll_dram_main_clk",
-- 
2.7.4
