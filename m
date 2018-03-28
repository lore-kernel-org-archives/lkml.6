Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeC1GrT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:47:19 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:43380
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeC1GrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:47:13 -0400
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
        Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
        Abel Vesa <abelvesa@linux.com>, Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <b20788@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 3/4] clk: imx7d: Correct ahb clk parent select
Date: Wed, 28 Mar 2018 09:46:38 +0300
Message-Id: <1522219599-10831-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::29) To AM4PR04MB2129.eurprd04.prod.outlook.com
 (2603:10a6:200:12::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6d0254f-d282-478c-2705-08d59477b896
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB2129;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;3:cR/CY9G1IzXitCLkMhw38PhxjDk4LdqwzlKow9BOq6HQunIMeGevGO4qg1N+8KA19DPqntovdDSYc4P07ptjjzClL55rTSrxoRFFAhSt3XVgpJ0Kjw+/I+7ygLUWrb9P3ZUezmJl5w5lNnt02hiYSVr22hWsAwUKHc1Az8/gO5vkNuZ05T6JJPkkJ3hnA1PFRCBIsyGwv88/fHPteYehlZ2qIcF3zIO40gIPIUgEwiL+MadCwFPmUUDEscqxA9Sz;25:5dBvLBTM7WTnuCu+SE03MoBfLIxI80N3H04C9GRVlJXVZrIuNWQ370K7d8m32zVeRAwbZ0h6Fn/BfWZtGN0vMEvuLwAtGt26zYzgssrXTu9wytWVelQo0QERP0qxZjmsjHZ/md68RGhsmWLYT+5irGBXDgSOYAhuw0tP2Q0gutvQkRFJHABaQWt7uRg7myBvYWsxXBU9iI62fC+Wle04nP7Sy85zB/KQE5QDrjEYmOmQs77QNrHQsGUwn711gA8Ae7p/tKXbw2NCtrppc7EE0cHHnwtlKuBymWa4FOVvG/KLaAzsY8u+/OtXfCIgwDWcLqzC89G5wAkCeHMPlaA4hA==;31:9xy4TlpaCQGh5yfkS6F1wJkN0tAfsVklcgYnHP7FuNsZp0m0AT0vbHVPdsnVErdB+CkxPaoWRQ4dbYI0hBXYJsjnaXKfwjFZ40llU47VpVlcJOlsMg5x/e5B7H2mnvoe32dLB66LAV82PPeM7FaFB1yxagqOIeg6Ez38EXae6JTQg8ZARzfFe+R+50DNI6l9+JVqHbRrGeVm+QchNgw556xrtpKeRXaI/p8Vz3XKbac=
X-MS-TrafficTypeDiagnostic: AM4PR04MB2129:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;20:+PV/juP31Wgz19TnFPNAmuGdzDbQm4bbkQv4cdHyKMsOzWAPCc7csVZoUcIREq1m22tp4tbu8I8Z18OSRUteCJggSEqiEnwiGzvKsMII1WzXO44c+cTe7TyAyaxeLRjYk4aRWu1NjUyx25c6usYVz8D7uC5+R5+a6xDjoyC1Jj8388pQe9/7xXzj6SQQD0nndrwKQaNzWWv0jTgO/Qnuvs/zP0RVdiITJl8qAcR9vTUxXz1wAWHofy0ZYnSWrP9EdzsEQD2+P3jOwHp+qp5CwxO36o26SL266pE5sbSbWzFzxd4pkRZTn4jcAbTa5LeeiH6H0JDNopgcZn/d3PJ5H00E+iouCVXjJ8xj1lrHKS0fSboTlMV2JvfCmlydv63U2vxBtR6gwi2u3eeRTRyWj4+YykLN2+SthOjm1cy8Z7TdGm9YY9Xv0/yU26nDtyYQdIbnpWnyt2RR/pVyLfLwbfcsLa0pcb9PPfKt2/muHvLOPxHezSUhd0UWvz0G8F/S;4:Tn+zVIZpLXnXJfdFNdRO9AnUSAmCY/f0Mw2mjN2Ae/zBtkc1g7pwFTUR5ttJ1xEj9DjXPhcQLqb3nZiSJE8h3GhLI7HXBD4qXu3wOpLhNcM4ki65U+HFcgr2l5rI8PRt0pUb8rIEaVIrKceYxQr6DW4LQ2aD9A7gk88SU++GqJ6A8vsPK5N5RrsO/qEZnhJsvVbb8TXDpJOX3MVn1YEQ4dgIvuem4/TPQCZUqW62Jq/b6B6/OZzOJgzoGI0sPbt0GsyoCGxiBi5C15+YQCXWbUQpWGyIx2/T7Wtj9NjxbqnBNd9rmUIbl44wQMCrCOWaCAyHt7rKQOJvwO/R6Px6P61W9d3Oly7czvBxL/GAu+Y=
X-Microsoft-Antispam-PRVS: <AM4PR04MB2129A727B9539D223BEDC976F6A30@AM4PR04MB2129.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR04MB2129;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB2129;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(199004)(189003)(6636002)(47776003)(6666003)(186003)(6506007)(16526019)(386003)(48376002)(59450400001)(3846002)(51416003)(6116002)(36756003)(26005)(76176011)(6512007)(50466002)(446003)(54906003)(305945005)(106356001)(486005)(2616005)(50226002)(956004)(316002)(486005)(81166006)(478600001)(16586007)(105586002)(2906002)(81156014)(476003)(66066001)(8676002)(110136005)(11346002)(6486002)(97736004)(53936002)(52116002)(86362001)(7736002)(4326008)(25786009)(5660300001)(8936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB2129;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB2129;23:eTgKhjHMhB6LxJjQk6twGdUvPz0SNRH9geYftJ+sX?=
 =?us-ascii?Q?9yUG+9wkhQjLNhhOhpQ+8JmRXN7U2lV4V0VHHmJb+9A1Tl4wXl24pcASoW6r?=
 =?us-ascii?Q?qyAcXi+NztCiIRU9gIfNR1QEdoF5kK5nnLo3VeD8zXIpQoieSDO3fSotJW0M?=
 =?us-ascii?Q?ZedoYfOp7sAxea0FzFwOVkWPlgIhqrtRFeeF24LhUctCj2ACVhw2xwmujeui?=
 =?us-ascii?Q?ezaIkbeUm6SgG7aqK++s5/aDo8slRWpsio+Kvj77uen4h3dEaI51kayBtRrW?=
 =?us-ascii?Q?EvSSryIobyf2I17f6nBTRL9KCKF7wJvLgIERsLr2CW/81eyBiuIL4/u0Qsv+?=
 =?us-ascii?Q?O+jbcwibCfhlF7YEh3rPNgJGRsN705jHbUAu5yvO3q8HJYlTlbUSc23UQCEv?=
 =?us-ascii?Q?v2q392e8Kr8n3j10C1u0OJQPOi5kN1Yo2oDtgzol5fqo/PmxnluEwg3nufPh?=
 =?us-ascii?Q?V4QgIvwYSL0ndcstEnH35BalckRaz0kcMLpqydyBwZeJPSX3ssKN9eK/nbAl?=
 =?us-ascii?Q?RI898JEdyWLOhLJjs+8Wtks29cnaBb5zu6PRDZtvadt2AJyyJUFnql2bs6ov?=
 =?us-ascii?Q?GUIRjRseXqZDTqRtoyCZs/TjS3GrCNLlp4O/H/GTrDmligu2CekMZlrPOWDh?=
 =?us-ascii?Q?YvBducj83rk8pZxBxKnivxgJCs5xY/TLqatY+Q14yjX5fY8uR4faLmgk5vRl?=
 =?us-ascii?Q?wXLcjUpEbQ8FwrN+8FVxRbODe2QU8/zyaPzV6zrTOAV/ytvMHo+AtuhW+kt6?=
 =?us-ascii?Q?sRY68GN/MZ82NnkGOU7huXdKERxwxIih1FTIHCqCJQGpZIQK830hXU/qM4DP?=
 =?us-ascii?Q?5uGs2LzdsdJG/YmTAm7Mw/WTwUtO3hS6ptuA125sV7yYbY10FMPcCN5PnOAn?=
 =?us-ascii?Q?+0iBSABKQXdt1UsFJnKQP4ERRj2JegoMqTqiRdaIOzqiqNniXJFeSkXbmY99?=
 =?us-ascii?Q?QUmlCxrWaf533K8Wbo37M1m67JnN4pLEOC1N99mdfUe5aUA4mgMMo9cANuSB?=
 =?us-ascii?Q?ciy1B57X2JJtTFK8A8JT86zpKQw6Z/N4RIwc8M2rluykhCSZJlqiUsgIrfF0?=
 =?us-ascii?Q?tgHGdr2+pS02jSuxJEZT+tQskL0Sc4dnHSUOlhojh3DFS2Fdm9g/90OQ5peD?=
 =?us-ascii?Q?2qnvvxxe/jQy5nizK7NBsrjqp6y4dHNyXNa0MIa5jAnVxEHoUZMSncxAbWJG?=
 =?us-ascii?Q?NMuN7So/zWUkFdGvU9jREXfxqN9KHqodEjqYqGuhvYsq8tYfDv9nmhw8mrQy?=
 =?us-ascii?Q?jDWlOJ8shgqqwBFXn9LGt5QjtgsCzcaxXm4m7NJ?=
X-Microsoft-Antispam-Message-Info: MjWHG1O/PHoblrsiZyXBOLxJLCgOdq6VHocYui/hpjXTBjHItUnmNffHj72mXThys/qbfU746YfnVSg6ha9Wk+48RhM4ctAZh8HTbQTPt51Xr2jicV4dZhFVPkStkxbO+W+KXK/x2+CnfqPHJEVvptQWQShqtZBXO7jGtzF3Di3thVjyu4Ge1gP5jTZPYjmW
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;6:D1yrQm4bD+yeodBjYaKi1cIYqAm7R4tJ7LRgzKr6Z/cbU7sr4CCm2tz/My1EnehxKfWzM/99GASAb/s6ZC7DzXb3FgNh1ZHFi9TTcQfLUCdelrxZklR5tn4VaQ2/QH+My3r1xQnWfNvT/PiazbJHZ/5vptQJX1rcR72JqXeFJslCQ22h5RYHcsSbBRMjWRB+JX+46aLn+yUXW2LxEI7tRZYhp7K7cc+kXZXCmPKrnB5JPoaw2MAUHRNE1cFzQXVd5lZ627CKH9XUhPHpRHrAsQ31HsXSXOyKrEOUBN01x3UjsMXE0c8SAwahj1spoIzlDOryjmsVjex+9stdUWcNCszg6RYn1uFdcpT9UnMzOJknLrG3YlIroK4PKHYaMQkrLcXx+mIA/HmR7avAIeES/NMai+Jm87hjDOKfBoJPz3B4zqhwqxx7lLh8pW6PH1ADJU+b0Ae/yCVDl0xqh7Q6dA==;5:VlLSMAckTSBAZq2wlNegeh0X3DdfVNSU2jVSMo/M4+KnnGJRNERFajVlChfI1Cdy7zR/JoQeMW7JUFCtn+o27lFXXnTaTFgHoDuDMJUQA5aJZg/hpQWq1NAyVsoeBYk2wrungrf5WzitlhY3mcCUuH+zEatELgdIBnwHPcpV27I=;24:tIE/v4iQmN3TxwC0jgnvhPv+k5Xzd5wa4L41zIrCXWbm5/CxSabr1+cwgLo6tJUyO2E/zMlZpCk3LjR9YzBFjGWwp5fyGmC1Eqz48/YYe14=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;7:7Se1t0HzsJmtm4ourOx3TlJJKIx5rGz0lzanWTXrFHWt7ftO5XbpI7L0X2IADjT/4901VU91rKjlkkstN+vRs9KGhhpkjeNl3e1gVhIC7QfIKkqKWR/opiOG6deLTtKUx/gchwCR/WFftjTDPrca/gqCfmFyD/Cu6y78LYESIVvlilU0Ku/oFRIxjUTjphTfbAoiH45WqCzRDv9TTH353v/CDQPEdhq3o2N9AUel0WsWzpgMtRR3qIA+B9QdO8xl
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 06:47:05.3516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d0254f-d282-478c-2705-08d59477b896
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB2129
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
index 1cc485f..50da4cb 100644
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
