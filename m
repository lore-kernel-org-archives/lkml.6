Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeEQFEf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:04:35 -0400
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:62940
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeEQFEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:04:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx6sx: disable unnecessary clocks during clock initialization
Date: Thu, 17 May 2018 13:00:47 +0800
Message-Id: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:203:2e::28) To HE1PR04MB1321.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1321;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;3:NEMF7bbhV/nTbWA2hv7kLYvCxPHJunR6gTF5DI/aR70wAmzQeQowP43oLwH4/VQM8Pq+6118tnnoIrQLtve1zdg21oy+ND6gDVJCaSgRvAFUVymapkb7E5m8zId4Bb8fMJmZK46hPdnCWIkR5tJZPyAeFQd2wC5ekiWb+XmKNn45+dsJEJo8Q6jtNW33UIwGAs6/JFi+lyAlvC4LT7AFc5B8JUvTqNhVMCzUFNHD6PWk4RkrSbIfY4azH2orftjs;25:5jUeVi3QO/N/DEr8AuFPbiSVhO3CFjKT1Wz3rVII17TeUUEdj7+2wMjLcliMbzRn4HofmKMw/K+e/rppeVAwkIjYRdnlQdjBcFliNc8XGgqwAyxqcbd1tonqnULrIg9yMHFstuuTghxUDmOC6DzKIC1AyDt7K2QJnMalcy+sYuwz0ZTYP+FKSjsyqVyoWyLuq7P7vllm+/yZcI4cvcp6Vs1Q6A5GPMSpmfBNlVxREOy21HR9HVTydkm2ubLgstDHhvvc9GFU9u7sl8/RbI9qtg0uuYvgJiseaNqv4x2azSZDowCBPUQuulwfN07AKYoszhCW9SdxmEY9Seaqi6dgbQ==;31:OO6eGy0it9zVmk4FSYTwIeI1rF1ic+Pp/dM319rMRy+lm9dtHJoc5XL7OiYskoFdlvMGc9hBHYFwEUFsHGR4sIYWmwe9UGWeuwy6TMmPmQKa0kc91i8NjLBTB8FxLNTzCxia1iTM0sVSZdS82/Rgs7PXoqBgiRXt7x4cKGfSGJ3ZWVy7eLJ11Kg6OFLxg0Y77uJ+SroYun/ueQDoswuOGZQJ+ifU+mWnC8qh0LGC1BE=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1321:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;20:xGggTUuwB31GESPghxFowtxYpR5bD7Td1vaUFGc1KpZz14G7VEZLTaAp4H2X7LxPOElkofzzCyaECcEN8fGO5smujiGBwuaRLsy4U8BKKj3Jx5WbS+LniVcZXBLatXfjK7Tm/47GYqMBIZKCAatdAcnZ/iYNCTxXq4SqAQqDcJEh6aayh9taq75QANx8KAwugM0a5lt2ZRAOJs1voPtoEMYUH5yMM1f5DrEvdQjQ5yyCy7w/KOa41HCHZB6e/DDPTA+k5TxCqxTSMSLWV5F16TI/i+TEx/t3G3W2qyriJuYOLYw/ItjcGCvesdzI+3NlQxFvvFEOQKv/SI1wm5fMEUGS2jo2CstVJV/NH9wc8GhHTaI4sI0jOI80EEPl6lbBlUabVMGgQdg2towDlAii2kikj18JuLcv/Udzih/9lB6X93c1GN/HW6oemwpOmQf8/1dEqlnblUKNW04p0uKO/H7NF58Xvg2KFfIUYlgds0oChylJnGmrlJaW2T/d2goS;4:8QvG3M0qOSEXkGKvcl024XfnuafZf8z4mcFRiOkKRrNazv4qo0yJPa6IZT9+eUCk4ClZHPbTtD1AzI5KFx24z0M0Ss2aNkUAFgqlyvpXdyFxZPiwCPhiyJE6oFisrf8T96qXOa79khmx/S8CuOyvCqYpCgzJi4abwGl+Jswl/YnsvcP923VOfTkva6CraGnETobKsSHvDSMrCyxBoBlaxrHJboubcZSsIfVASBYXRqLbg4UjnPCnu4SH3bQnORwF8BwdGFi87JMUtPad+7/ywn5QN4uXPomBYt3aDsXpxNF3IcfdYAVtwqHsLke58pDr
X-Microsoft-Antispam-PRVS: <HE1PR04MB13219A6C56153C6149FDC424F5910@HE1PR04MB1321.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1321;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1321;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(486006)(48376002)(6486002)(1857600001)(53936002)(50466002)(68736007)(16586007)(956004)(476003)(2616005)(6666003)(6116002)(4326008)(52116002)(66066001)(47776003)(305945005)(86362001)(6512007)(51416003)(2906002)(3846002)(386003)(97736004)(6506007)(25786009)(105586002)(186003)(106356001)(36756003)(26005)(5660300001)(81156014)(8676002)(316002)(81166006)(8936002)(7736002)(50226002)(478600001)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1321;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1321;23:GZr36FsWc8L3y1TslqTNeXnuIy67MO5Ug3jrnzCyt?=
 =?us-ascii?Q?m67ZLvhirWmO9klhfxcOMq5C5jQi1xJF6DCF8K8/HRPCJ8SKd4XdNQVYoRhP?=
 =?us-ascii?Q?DhsWPB8DGoon2TECnbCLJjCUlECqocDATjMzWepZRGOnXOPJMk5DtHakwtA0?=
 =?us-ascii?Q?UcL0JGv84zPEHakUcTp+NrQtglo2APtLhXzbnoL8mSuEDbpD1ht6uhGUXDeO?=
 =?us-ascii?Q?/6SMFNUpRl4cLZY23t5gfg+YNvnwkMokGrmAAyL4ESjiHWv9Zo10Vjxpr7Y1?=
 =?us-ascii?Q?mZnyHzMf4JYLUeEqT6tmK4cGyIzttz3Q/w/aRgi6LAdSe4zEhRuNFxuDxnSa?=
 =?us-ascii?Q?/gZc+vp5puZJ9gy6d8y7kc0myqbe44eIPp8ymLL9kAMdiUxQ+13A0PRPJH4e?=
 =?us-ascii?Q?WLRA2+dSVRbcF6lC4Dw5jJjg7ndVw7ecBGw3KFpQayCSBcfJBdefq+XBw+Hp?=
 =?us-ascii?Q?v7i7Ied77hFwyEC1I4m/mpxq85rqUJsRsGzZUvzkpaOlKtA+aH+00CcYdrX4?=
 =?us-ascii?Q?1U71yw8IM/KbnzFKIZ2l8Go1n0/wnXpS7yE0/cCDWxo8u6z+4WO8U1N6Csn/?=
 =?us-ascii?Q?bJAXenuV7eQjjn1l5+SjjdVP7P5utcp6zENToi67ZvDo9Yd0v0y996R0a/0w?=
 =?us-ascii?Q?vcUMHydGJbxheR8Dc/dffthNF9j/9ke8ccIpzXZ3i2mTPl2d4XfreVOsVYPx?=
 =?us-ascii?Q?AKHSPCqz7p2onPAv1/zTqZhWOOF9Pu7IR/FQmkzA3lQjQdROCLu3N6PvuP3V?=
 =?us-ascii?Q?/16mrvB4eV9KMwHbXMY6kKyQgMY8Re7jYsNJW8lszo0AD7VbkhhmkfANk7Mc?=
 =?us-ascii?Q?NL4foeo2W9P3u9mG/304L4wzbDuPApHgUXCf/HxHImXr75q5Zq8MYRj2b95k?=
 =?us-ascii?Q?aSGjjm/D8WGYMXnceJBObbRpbNqCvZc6y/IjF5TdmvE3LKyD4zMjK08LVMOu?=
 =?us-ascii?Q?NXUtV21P8oZ2d60hxcLyq64hsjYRMmOGC4eA5YCEgW63ukCFxumts5V2FqN4?=
 =?us-ascii?Q?wvxW4wGClViOgetNNpeYQK9mqsUKH0Q0UB7al0jc2OKSj62dfXzRvwev+1oe?=
 =?us-ascii?Q?3XOXuhrQ7hOtIvm2RSj9NZ1rMzrWojFiBcwXw0yQBzV8YD3pJXLO5iQJhkGr?=
 =?us-ascii?Q?5LyDTFUblV1PwZ5/9eBmL05el+AR1Ja?=
X-Microsoft-Antispam-Message-Info: 9XX+nVjEZ97UjXJs5UShcce9z8Xqslx6Tj00IrQ537fiifs4CLiWSnPXnKhIWuQ+QTxRNLVXeTYBbbyDIJHgv7QXxAcAA7imGEiPrYnD6UiaX9qhfp1odM5fu4UcusS5MoLnPcA6NmIv0Nv90u/Gfrgss0PAzS8y0SlkdqZ9zbUDsPiIe0kLJjok448pfWKN
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;6:vrswLyYJT2enX33gJXOlvSWvIQCQRtU6rQ1NgHHO3KiAWyQryDqSOMBxENDNC3eSpysUosAVEj+uiWLHrTyxhlG9en5eoKrWXBoHTe3SwwpHbO/xSVyWtn6PuGcSyHuPfFnnoGWJYivSe7oeg/k52UUVc1DDLlwXU64I1VANL5vpQcZ+8hUwXaWwJ6ExK8wh9IxygVIGCJ2DpPjS8uUY/s6qbMi34z5jca65a9z2N282u7iYDVU3jHJ7NGf5igAeQc5+4QTsoWUNeRQXVwRn17Wg8PtSKvX9h5uiT/vJbqmtQmoHZJYKBI/6i4LNT8GYqJ/X/v6f1FhCM0CLkR51xPnNZIVDj2OdH0vh4q9hR+teBegvDpW6hE87ln1a4uFII3+CB1HIjcSXx/ma21zI2BGppgdv0/DNRFc8tOS9FSaOzSXWa5VJNqrWoyEBIUOMedkomvNG2jd3qOSb2w8E0w==;5:bhqhFfb5cONrU0Fl1EGNMG/cm2kou+R8D+ZTYEqy87od8wJ32etvLFRdDz81u9uoJT3PierNFbZT6SghtSxB5gKD55BY966cGRAH6K493uUzPfdzoRJgMx2DRQWi6pvyBB5FvFy7584yg/CWtp20Fmx6kw1HDxcw+GawY96UESI=;24:trrAIj3BWYeNCtNAky2UY8cBPm6448ZZ2R4tXMLouqh1i1Si+eoZdXkOkDuMJquVrgDa+kdv5/Wcon92xY583teB7tXcdbly5FM+HWfGuFM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;7:pWilDsOvANSGw8M1Y16pDif0MIorxXMDLezxBt5UsvFnkf0cmYAA0ai0TRR+QaRnD7X2kask/wVn5tSnC8vwBheToJiGCK7OSDvJv4P9+4bZ1KRhemhOULPLGMcLSpc92Ii/L403MZFgDx1sU1Ecf0A4mz/RESOYPvpjfXfJ7gFWWPudmV5kqRKhqIA9LkcWJP5P5KeTfhZaVBbib4B5u7526YKLGH6/hbxPFRXozp/L5vn5j4rAhupXdbhZSdDF
X-MS-Office365-Filtering-Correlation-Id: 2c031465-10ff-4750-b85b-08d5bbb3a89b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 05:04:21.4484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c031465-10ff-4750-b85b-08d5bbb3a89b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1321
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable those unnecessary clocks during kernel boot up to save power,
those modules clock should be managed by modules driver in runtime.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 0178ee2..10c771b 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -97,12 +97,7 @@ static int const clks_init_on[] __initconst = {
 	IMX6SX_CLK_IPMUX1, IMX6SX_CLK_IPMUX2, IMX6SX_CLK_IPMUX3,
 	IMX6SX_CLK_WAKEUP, IMX6SX_CLK_MMDC_P0_FAST, IMX6SX_CLK_MMDC_P0_IPG,
 	IMX6SX_CLK_ROM, IMX6SX_CLK_ARM, IMX6SX_CLK_IPG, IMX6SX_CLK_OCRAM,
-	IMX6SX_CLK_PER2_MAIN, IMX6SX_CLK_PERCLK, IMX6SX_CLK_M4,
-	IMX6SX_CLK_QSPI1, IMX6SX_CLK_QSPI2, IMX6SX_CLK_UART_IPG,
-	IMX6SX_CLK_UART_SERIAL, IMX6SX_CLK_I2C3, IMX6SX_CLK_ECSPI5,
-	IMX6SX_CLK_CAN1_IPG, IMX6SX_CLK_CAN1_SERIAL, IMX6SX_CLK_CAN2_IPG,
-	IMX6SX_CLK_CAN2_SERIAL, IMX6SX_CLK_CANFD, IMX6SX_CLK_EPIT1,
-	IMX6SX_CLK_EPIT2,
+	IMX6SX_CLK_PER2_MAIN, IMX6SX_CLK_PERCLK, IMX6SX_CLK_TZASC1,
 };
 
 static const struct clk_div_table clk_enet_ref_table[] = {
-- 
2.7.4
