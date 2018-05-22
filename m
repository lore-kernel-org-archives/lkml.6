Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeEVBTF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 21:19:05 -0400
Received: from mail-he1eur01on0086.outbound.protection.outlook.com ([104.47.0.86]:52768
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751601AbeEVBTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 21:19:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: linus.walleij@linaro.org
Cc: Linux-imx@nxp.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] gpio: mxc: add clock operation
Date: Tue, 22 May 2018 09:15:17 +0800
Message-Id: <1526951717-12347-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:tAUpHwqCvJZcHBbPvzNGzkCIQ33vBd1ThKeJ6esX4vOHbkCqk/6zWQEZ1Y5HMkhZYhkn3/EYgBS3QhCFBvbVi5Dg8HBvNaW9OkxMRLZyaAYJ/QXhS/jSXLK7hMGHssk6XCqb1FGfXj3V28yygGg0SUHgjQnAwx3IDGdtYUCl+Mb8QpXsrl4zorpFEHcYiL3Agyvh3SSBkZFheTxLUNtH3Ms2g8grncIbdgUy9KZLzmsNevEbns86Js6X1L4kOQcu;25:BqjSsH1fREFQ1xoQHGzAVCZT5YTM/jYIESNhzkdvMqyLxUB1QYqxUekceHd8cziDEZfbT8vl1JDeJHxTThOKXrhHUR3Yrbwei0lLEwsMyjozvdCKvTaxPC+vfoCH4nNnpBfNrplI5iULd2B+dbExypR3EjwbsADXYNUFOALdmX8k5yKBtVE+3r5uAOeDycfiLasVV36eYaSnjfkCLWilC9NrMx5bDBjQrhqxu7dbswuKv2VzvlrPXFdewoo7imy2uA5uLaXFXvLMb/cZP8kSRncc9T+nBqE2QqHp0b3hw28iaVRaOTeqwTXLhITzoXhAURw4Edbw/agSP+1DxQcNiw==;31:unM3hCRwQwJDB4YoZJzzRBMTVy9oKYBCyKvmh6DYd2YLUguuzpJ2z5TpRY0xVcURsderVsEAVP1rDss5EXWXoCH1OYCoCRGtJOK9UioPbQSoHEESY+zr6po+oYRfVaGZvtl7cMgkYbXjfxGGN4jt+IPShyNNVbyuuwCjzommYeqJGco2G83TSIGgmemzZv/fkFlHY5B0sx/9hr1AU35DrxhmyuhjDnZqsFyXP7fKcSQ=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:uJ6922+YEB+JklazM9v6ElgrGJnQGJzRvP3ZMLwrkMpzBwwpxqFDmanlF8Vnj8dvCOlbUHQaDup059xgBQhArt9wbWGTRjr36nWiPGBuNMvnFDvDXrw4aD4lzxgWqg/26vsVovjRtWpEpmqNesGK8d0cu81uF0U4MkD64d561CUxP5YfNOLzTHch5NP47rBnO2JWE3BRu3jZCNseBFdIaZ4yI4v+4ojTuZzT6hFoQKOjTH5Glr3kIt4e/kxJg2hIcoj9XuH1HLbuE/pd/QooSmxd/ux2vHPGrWAx5SMffL9k1Oqv4ibTH4dmR+WCeiW7X1eizTBm9xbeljYQikuMEvWEv3l5G+e1Pq073pqmhGnol0SaYjX4NWd+Csh6mybdY/gG7hdhybK5sBb+OzA70gGPJeCIauqSmVn0CYiXa5yU2RWzXiq3gishPlfILPHFvFitxTsovtbLSS/RlHGOmKBHZdKqTvqJ9swpMi0wuXZ4lEE6bT2JYjpBm3zh3V+c;4:fqaAn8JikGZx8WVIRJqI954D5qEzrmLsoRGCW1tGzEcDuD5c77+MSI//Q02gYOcdyLYracnNnCjPOaPqdCuidAwrrZxzsAwiVLZoF8sCshZEF5Ej3XF4+5cfhS7OFThqVNOICc7+Co0y4akVjW0Jll4kpVuzRRAn1Emp+UGvf77dH63io2KvrB+T1Zjo7bAxbn+4ovV7H2e0ULFrQGDZgNeRdNpcU1Pj+FZxfy4PWRdDV4oTephAI0DXuKZJJuan4gJxKY4b5JtURc1tks6JAaxy4QzQnN/GrqXUFS14JadY/j6lUz97X9fssIaPESAt
X-Microsoft-Antispam-PRVS: <VI1PR04MB1327F6C390313DFC512DC0FEF5940@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(97736004)(105586002)(68736007)(81156014)(81166006)(4326008)(2906002)(86362001)(5660300001)(6506007)(386003)(8676002)(6512007)(36756003)(53936002)(26005)(25786009)(16586007)(316002)(486006)(106356001)(47776003)(2616005)(956004)(186003)(476003)(6666003)(8936002)(66066001)(2351001)(50226002)(478600001)(16526019)(3846002)(6116002)(2361001)(52116002)(50466002)(6916009)(305945005)(48376002)(51416003)(6486002)(7736002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:fqNvYSir6JE1PT8OQWa+C5doWpr74L4NdulRevBen?=
 =?us-ascii?Q?68kWNJRlsXNZKJxS94P8Bj4reQtehfCWmO0N81ejlW3XN8vTmib0uGvkuQUD?=
 =?us-ascii?Q?pf6WzOHbhnnMMHs7kIx/1XqTq/ys0+2KbP7tbp+iNHLl6XyG1WQp02SB9lou?=
 =?us-ascii?Q?SP5LjmZxbmHkbfgORrm5Pl4GkD4t9WxFLPrkPk1cKz9ZguGnZXTawTWe6P9B?=
 =?us-ascii?Q?de4f1GBLDxRMFYZmt6LBr6P+hMsHON/eGYEVqDV3n2BAOvPiitnjK5xoCYNJ?=
 =?us-ascii?Q?PbDpQJcG60nbYBtg8q/7N9O6G67rMOG86pJXSHA6DJGKn58LyjCJ8w/av890?=
 =?us-ascii?Q?KhzvE1tZQ3FV1dQtJ/UQX6vo6whh5vvgLjVBILq/EHJswktancnlG5pe1/32?=
 =?us-ascii?Q?p7fqZsjTAPsG11Xr7LL4fPSwVCdEkIiGjVcl+9uS/8T1AdavbY/v49U/Lxbz?=
 =?us-ascii?Q?Wh+P9fuRNduF0YgokwAqaXS4WU87yQyntl7gyc7GMo/O2Q54NxNiDFsDb8ci?=
 =?us-ascii?Q?hTr8sgyoKXphn+NDGBTkssyxNoMcxcpJ5PjsWehKQ4s2QJIBBTqu8aarCApF?=
 =?us-ascii?Q?oSLEU+GWbT8fL9wDY9txkCLfJ/q4NitFLW3pmaI0QtShsBwg3ywidXryA+ba?=
 =?us-ascii?Q?UGEduj5eZ6nP60s2+RgATxoYOlVwt0EAcGJizgYbTVoHN7QDWbD18JnVcE2Y?=
 =?us-ascii?Q?v3BvK4pS6Gqx2qvmXG7jRsNQR2Qvd0aUhaoIRoGr6xhClEP1B7rNTAjkbapq?=
 =?us-ascii?Q?Fopd8lVTB5K2BBNsWCg9+e9FS2W6ALDm6Uruv3ejqR1DYoh5RP/k6ljcJ8Q/?=
 =?us-ascii?Q?7Ut55JBtcWnc4QAtNzveuJPaFHhf2qREN7hbXK8/ZqfzPOx4KFcABnv57FA/?=
 =?us-ascii?Q?Z+swklM51xFF3g96qvPqHLP5MQlYs0u1CB4lTG2JQmmXwHkLIMiBQQl3Ki+Y?=
 =?us-ascii?Q?0kGpSmykWCMNJFEGLkPcdyID8nesL6aXM0DfyKvrXnV030aBol9tuziiZ0NG?=
 =?us-ascii?Q?bEH8DxETTzW7N2HGRugabUODO1IwjglNdqrjgDJxzDmmb+uE91p8orNa3q4B?=
 =?us-ascii?Q?DFUqq9DhWBSrPDPKsegvmIPR6JD7JcX+iimXdpj8AiC4pXZyCnH65A8NfRki?=
 =?us-ascii?Q?VuuuJyMY0DJG2EQQomlDK8+2bx7dX9sJjMch5aRMFUFSYVlmkbvsKDXMCGNe?=
 =?us-ascii?Q?4wDD5jtK3QyEpE=3D?=
X-Microsoft-Antispam-Message-Info: cDEdtGeremKN7z0nFOsyM1m+HXPlejy07viGlHT9E+5GDZIWn0v9U2LT3EJpm2qDbdRxmJ544tPnJcQOvRPi1VN5FmtYlvOmNdUNwKo4ECggYShS2GkiO2wi8NCp1VJNZgVWYSyms2DmKeisFHq6rA12/wvb1mGQJLmSvpLrRuWJsZEE9wPTFUvEHJ9nPtX3
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:q2HAtrhWiiRN2aq4aKnxraKuoU9WfnRnXk1B1sC3UN0Mfg3Wl7WnGlkez76Fw5X/jh18AJNmOogUjvnYmpfIITo3YjgsxCOoQef21fxbYZEWmHOu7z467Yg8RMkP+K1PqrJodC7rw4JlG5OnCZq6sf0a3j19IwxASXe4z5I18Ex1/rxCS6Pd4usqzIFEVGOiymsWnMce3Hz7k57NHW4T8MXC57tqNZ7PAm848m+NbxEimCLlb2P3apO5piEd3o53VmfFqztwVV3xb2FkU4uKI4e0utkQ3mBLkEYgmveIXeH6LBrujVqUOqgxczYOKZj46ycAaqJnUfW2TbpS3J5NvGJflcNffQocrkJokHoMMmFbMVF3KNqeNqJbP7XY8RCjb1bFRcdoVfsJTns96W4NLxvbi2HmzQ9CjOZbaP4tUnFA0Zm4V0FH2RBi0NokaKH+jGCs6Kb2AEelfXrQ33sX3A==;5:sLPsSRq3UJMxNsC8P4vrZMxrEj9QSilUMrwB47upj/qTnjgRLZ4kJeAMc0VhRODGmcay4ryjetzEun17j81k2bOIF5W/0QxKWyMifYN7Ru7aR9owAoL42jkwtsLheRQ2sv43IaGroyrTyAqeLcyH5i2KeVcABxrfTb1GiMiRUXQ=;24:IyrTbuOURb9V4H1pEXZwqX4k44l4kwiurRXiY7avPVlUrQ2bOPC9B0luMByAGyjbS6JuHkIVFFcKs0mM55Es0apdnOjEB9D5lIw6bfPzee8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:bKsPqBhqgjphp3u0wst+Uoe/eqZn+qC32AwfXNSMxYRMi7ChKSb1IA1Nmmo8dNJ5hWM+6VPm4OSAf7l+No+gSz+Lcu9dhNqfsSfpiYgZZ+8QWj52JbJlBxJ4YfC8R+tb39U/PrM4nSrSAi/9498ujJom/qOHS7W3P+TvRA7Sh/VOVo9Uc33OFk+p1Cv2qK+DJwM2oHxm7i8hs5AOqZnyvcnEL2AhlYcTYbbOUR2tAMDy+3lyJHver0SBByByokcd
X-MS-Office365-Filtering-Correlation-Id: 0243e993-c6d4-4e37-2b4b-08d5bf81fe25
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 01:18:56.2233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0243e993-c6d4-4e37-2b4b-08d5bf81fe25
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some i.MX SoCs have GPIO clock gates in CCM CCGR, such as
i.MX6SLL, need to enable clocks before accessing GPIO
registers, add optional clock operation for GPIO driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	add missing clk header;
	remove FSF addresses in copyright to avoid check patch ERROR.
 drivers/gpio/gpio-mxc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 11ec722..2026f94 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -14,12 +14,9 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -60,6 +57,7 @@ struct mxc_gpio_hwdata {
 struct mxc_gpio_port {
 	struct list_head node;
 	void __iomem *base;
+	struct clk *clk;
 	int irq;
 	int irq_high;
 	struct irq_domain *domain;
@@ -434,6 +432,17 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	if (port->irq < 0)
 		return port->irq;
 
+	/* the controller clock is optional */
+	port->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(port->clk))
+		port->clk = NULL;
+
+	err = clk_prepare_enable(port->clk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+		return err;
+	}
+
 	/* disable the interrupt and clear the status */
 	writel(0, port->base + GPIO_IMR);
 	writel(~0, port->base + GPIO_ISR);
@@ -502,6 +511,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 out_irqdomain_remove:
 	irq_domain_remove(port->domain);
 out_bgio:
+	clk_disable_unprepare(port->clk);
 	dev_info(&pdev->dev, "%s failed with errno %d\n", __func__, err);
 	return err;
 }
-- 
2.7.4
