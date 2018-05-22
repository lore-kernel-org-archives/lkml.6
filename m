Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeEVDJ3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:09:29 -0400
Received: from mail-db5eur01on0070.outbound.protection.outlook.com ([104.47.2.70]:51558
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751557AbeEVDJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:09:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
Subject: [PATCH V3] gpio: mxc: add clock operation
Date: Tue, 22 May 2018 11:05:40 +0800
Message-Id: <1526958340-25883-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:SM3uuNR7s0ANzn0FaB0yEeId+yB7tjbjq7lZbwNrZgG8LbKTAOawPzJ8Atf0d+TFv4lqtIfoqNe6rpT8DcYOo6SJ1q2YCM/5IOu/QiT531yQzHoeM/Yjmez2YIaeSYV9QcLQmpejZCssTtrAJ9s45ZTqhD9KW5VJv1z9dKkFnWcsbb8Ey1E/ljcrDxFVqNlno15Yp247OFsB9xm/9C7Qc6tD0UkKbdSl725PervtsxndzgPqs5F9ulxeZNYD2Eb2;25:Hi0iQEQn7ChD2/B7ZsaE4ctWQQq65V4K1l9UK1VWBZ2+2nRVffRuhf5WInEl4kGlHnp2gfj7n3vJ2ac11UPRT1luKYEHpz+hd3G1dNislrdVYH1rMFeWiVUvof408Fe6Xp262w4mjjQtXhYPk9d8sHSoAGVvmcuIMreiAWZo6h/ENdgQ3NAeEZ91+cX4MpTCaStdxC1sor3Kw1egCPOwJYrfNhnD6VXItmm+y1BndWwNJkt99DdFyZ/K7Yw6qkCv8LGwdQZXOQHUTv8JfV7SqSheRuUHhiu1aDSv+1V91VcrTqbxxj0eKqFKgRaQfJBs1TOzjFMaIub4bTWXcILrQw==;31:r0lo/maDsIvIRslAWu4kswSaqPgiHk+jriO3vH7bFT+tibVdZPPoMQlAguoip9guK+jdHixGI5yGCS6pDnd+bIeMaFLa5eBa6ZNLgFAg2jdb12j+U3m44S6xpi4ZQVSbEmjncGBFi8pcC9Td9VFJ10ax9C8fIFs/lkKPCC42DDpbJNkR86xBecoOBXij+BpuKbLWSu52dGsOx+LH99YVjmgAP4YbAauHme3y53xM1pA=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:sTVTwwbYoco3cf8nqyuCSzKTZwSElzvnlYWbBw5ssqmTuBuyIdT1ud9cTrdWsd3Eh5007YaQBsiZrCDwLhkaD/DtQW47jXTBwADUvVq1DDvN1OeGmzqfqjTtJOmHxcvyoU/621qmv3PSIDf6Q/rmppaOU86llMwqNGido2GWWJbpKA+DWl7A79C/8DevPMvfmvHlNuMTir5Om0lDXy9UlnZzLW8Vf+HOEqX6VNgJCwyweW3s7eOYzPlbSsLHxfOHy9OgqEKGkI7z6CYVMFlmnnsjTc1ciZWzn9S9jlz1e7xSSDZFEeEGU8xDIEMzTqrAmM0uOxLL0vKLRSvdNS0C8AGCT5Nylv0YLWumu79+i/5wzyI44NqdihMC78AElPFzZtJEyuGnhC5CG2pNfwKWoJWSz9EIvkgWyf3yStiB8zXgprPi/HJeewa13Um/x6xNLQCGYqdN1ZTSsLREs87ymUw2qdUN9AC8BPWB1VPGOkIko5cuMVR5NHhAXUZsDLwM;4:542/+80ye/wmDkPT9SB0d8cXF2JwyDg8TilPXvqd6Aj+jjdL/3CWixYbFHqWW8rq/wPRUsYr+bXz1unKBnTju/LVIa5/Tr54w4JYFZ/bY8DG8Urpv+qnrT0ovfEYZAF6rAqZLX49wCieHGztV3z8ArKLKUrAuduVvk2yvXNeXVXzmDJ9xIMOUsMk7PQ90Ea5iqG1SETjbJaxcUA7ylRcbiHPo2tb/vjIIZGJUR9zxCZRpgOk75FovLSf6zDVodNbG0CSeF4lpIuMsKOPXuo7t5DiHNm50s1eVIRcPgJZSA2KxHp6dtyLw1UYrXY8qR1D
X-Microsoft-Antispam-PRVS: <AM3PR04MB131597204C03B8144ABADB47F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(39380400002)(199004)(189003)(386003)(53936002)(36756003)(16526019)(50466002)(7736002)(26005)(2906002)(5660300001)(48376002)(66066001)(478600001)(186003)(2616005)(956004)(486006)(8676002)(97736004)(476003)(51416003)(6506007)(52116002)(6666003)(81156014)(4326008)(316002)(16586007)(6486002)(68736007)(106356001)(6116002)(105586002)(81166006)(47776003)(25786009)(8936002)(86362001)(6512007)(305945005)(50226002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:+SBfYgWh36eZYlFd4QeIT5yZJXEz5OkOkaWGoCiL+?=
 =?us-ascii?Q?8UYkH06xnTlZUff+BCeSzhl54U8qrU0Rko51hlLpLy8ii6rCu7zI6Vtlj/Xs?=
 =?us-ascii?Q?IxN2A7PammABgQOBWloSpJPmRZrpte7EGAlN/api8YrYgeloPbLz4nr7G0IV?=
 =?us-ascii?Q?jOQeJTHQ42vQXBnzR8IxT5HIDvidq1hZwT02tf85+R5Px2Z8/65dqeVvAK39?=
 =?us-ascii?Q?0qJPVlIkodNluCW/lBFpn2GjJrZ4V91PGMchKm9xrPHKsF24EefxNGlU8p0q?=
 =?us-ascii?Q?d+wHNsTYrkBzwh++qxoCO3sbGzZen3RURg9Xpa9RJgu/ZI6fs1oswEebX4V/?=
 =?us-ascii?Q?u2ny0Nv2C+WLgXLPXoGMZYGFQNCaq59Ta8Dj7FYE1IZN6ShGbjdIkUxNACMy?=
 =?us-ascii?Q?n7Z3gtIa89c070qur3Th/DbGHHwUizglpa1t9r6QV1lKu5sT2hP3nLdJLXGT?=
 =?us-ascii?Q?BGE/Ibpt3jZd4WTaKcchEOhCY7cMBta3BmazbuCwGXhcAnnWvZ0p0G0ZEsOd?=
 =?us-ascii?Q?3Eoxc5/m8rd4DUVR7iFsZ/cya0s/WO9BVoRAylbeG+He49aYYGjhIW/bqiPh?=
 =?us-ascii?Q?+I1BmFoQS1IrXqDR8RjmWujYf5rw3BKi7fciCHoLdT07WpD3jMwTd2/XSrkr?=
 =?us-ascii?Q?grYcLszoiP5HXRmsdbpUycm+rkq0lPLUtl/pSMEe4VwN6XuFulaGKGptE+wK?=
 =?us-ascii?Q?4e7MrGuLDdNqAzwtP5MLHKdLPL9Y5n7EnSY+ebaP3XvGnTA89WC5QJ4bvecS?=
 =?us-ascii?Q?4Is4H189Ruf+A1ouRrE6Mco1NQkfk07oEOMu1jEgphIHPc67mVZHOl3F0Q6C?=
 =?us-ascii?Q?teN+fY7137ei46AwbPH+Mt3la5qe/mHXPkPXVo+9wnJ4E8Db9af4X4FrkhLL?=
 =?us-ascii?Q?YpHl86CvzBiNQveJuIPV3FP1yV4haRCUxi8xQ/JMaUsFJfR18Y/wbpQD/oL0?=
 =?us-ascii?Q?islzD8KEM1/ZgrV62Z87DCNMi0mXvO5wZCz3NpnzW5sjEB43C/nB2DhtbLmX?=
 =?us-ascii?Q?yZj2fzL1O3b3Y7KGn53//HnBH1+WqLk61QrvrQCdL0WlwX6DIWKMM4tZpSb2?=
 =?us-ascii?Q?WPB4pgILHrnTrcT9R0ARaLkiTvjjcglRi2XwESDfl+BGj9PRg=3D=3D?=
X-Microsoft-Antispam-Message-Info: rLIXvMcpyTFvJqRnwAtfI8MAbFRxFlhTEo+0zDt7XhUqr9rHZxb2AKzZVVn8sPqFxgqn8XKIW7DPcaks2E7Il7wsrpBneLCebdL8W9C8lM9G4qYfjDPiD1OKKlJwGxG+TdqV+KSo/qG/1IHQ5xy0WvCJFV1Sxn2Y4l5gVT6pUekonP7j0vHJvGEmkxoMBWNw
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:G2ynxFMbIVK3i22sFzl+6K2cAR/o3T2xGYKci6Tx3oDVMEnSIpyQoDAhKgmkOkU6gJfxvxi2swtglOGzYxOLf8kNicqhIWUr6SEDRxmFZfyaWmgjenaNsEhMQEjGwdWUngv+p7K+yIOz/4PHu15c9tB4FPj1p773sx+QBkdBLSuNR24PYdy8RicD1hj5UPEosZV194s6RIpUtLZCxD5aWQgUTdtH0poJ5y4Cmi7tG2b/GTOQrDPwLI4sUn4LWN9l87gPeDjeviV4BugamD0psapVDoysXpmgOgD0KeHITCyuwBTqYu8W+qb4Z9vPig6yKGqrg4zKnfoQ/qCNayI76hUQ7aDvOk2E1mXnDKMepgs/gv7NIQn5kLA2JDTvsszExSdWoNxKiyXgwEWKJJnJWaJN3n82EaYbC+ZrhMVkV0quQ6wnr43UFoM/qt6phVP2qaa/rah4cHaPmnq7jtgaQg==;5:x37BPdKLmVRLU1qtycE6wbUY/13CELmZrzTSQV90JOB8ulFINYeofrsD7LO6C9qBgdF8UlaVh1fTj+vYY8bCN+1TcE56txIMQj85pyc6alshVIsm7w80DFFjpyT/1Y5oHD+u1ntd+agU2ZGxqZ3b5Fy3SbKMzF3K8omCgePCiBI=;24:3JtO2O2oavge9VJBg102f95KF4ZlMpeY5LzXx8DUsaeHUPd35xGFdm1ocCgdQK4qW7F52+YE7KmmSO5gA104Qk1bCgCj1P20L0bSQxsH27A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:5PvrSkDfNlWtwCw4qUf7voM+kei+vukCSkzpO/68KeUO4RHgqMqZXim9WtBAE9neToJq7l06ru4BGMXPmyHBI3PvWnJsofO9nbHxsx963SHVmpTwkomIZT1osgQ9WyTeZktos2LuOLB4qt2EnMbLfwrVduYmKUrFtMqnAnVuXK5Sn/jXkrRGa2+Hn+lv/wS1Oc4Zx8ltYYYlf813g0sVfyulwIvBeMLdINUp/ocycMkOxALR5jFCWdaOcE3CL5RE
X-MS-Office365-Filtering-Correlation-Id: c29e39c8-d27e-4bdd-846d-08d5bf916a65
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 03:09:20.1469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e39c8-d27e-4bdd-846d-08d5bf916a65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some i.MX SoCs have GPIO clock gates in CCM CCGR, such as
i.MX6SLL, need to enable clocks before accessing GPIO
registers, add optional clock operation for GPIO driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	remove the copyright change, since the change is already done by
	Fabio's patch [1/2] gpio: mxc: Switch to SPDX identifier, I redo
	the patch on top of it.
 drivers/gpio/gpio-mxc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 6a9dc61..2f28299 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -7,6 +7,7 @@
 // Authors: Daniel Mack, Juergen Beisert.
 // Copyright (C) 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -47,6 +48,7 @@ struct mxc_gpio_hwdata {
 struct mxc_gpio_port {
 	struct list_head node;
 	void __iomem *base;
+	struct clk *clk;
 	int irq;
 	int irq_high;
 	struct irq_domain *domain;
@@ -421,6 +423,17 @@ static int mxc_gpio_probe(struct platform_device *pdev)
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
@@ -489,6 +502,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 out_irqdomain_remove:
 	irq_domain_remove(port->domain);
 out_bgio:
+	clk_disable_unprepare(port->clk);
 	dev_info(&pdev->dev, "%s failed with errno %d\n", __func__, err);
 	return err;
 }
-- 
2.7.4
