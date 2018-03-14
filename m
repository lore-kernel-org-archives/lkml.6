Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeCNKpD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:45:03 -0400
Received: from mail-bn3nam01on0072.outbound.protection.outlook.com ([104.47.33.72]:17167
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750855AbeCNKpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:45:01 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <nagasureshkumarrelli@gmail.com>
To: <boris.brezillon@bootlin.com>, <rogerq@ti.com>, <lee.jones@linaro.org>,
        <alexandre.belloni@free-electrons.com>, <nicolas.ferre@microchip.com>,
        <ladis@linux-mips.org>, <ada@thorsis.com>
CC: <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [LINUX PATCH v8 0/2] Add arm pl353 smc driver for xilinx zynq soc
Date: Wed, 14 Mar 2018 16:13:55 +0530
Message-ID: <1521024235-30374-1-git-send-email-nagasureshkumarrelli@gmail.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.679-7.0-31-1
X-imss-scan-details: No--4.679-7.0-31-1;No--4.679-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131654978990501489;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(8676002)(83322999)(36756003)(48376002)(47776003)(966005)(6306002)(86152003)(55446002)(81166006)(82202002)(9786002)(8936002)(73392003)(87572001)(2876002)(356003)(4326008)(110136005)(316002)(76482006)(26005)(16586007)(2906002)(50226002)(63266004)(107886003)(50466002)(106466001)(105596002)(336012)(2201001)(86362001)(498600001)(73972006)(5660300001)(51416003)(54906003)(61266001)(81156014)(77096007)(305945005)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2535;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT023;1:FWSF+H2w7+TPQyix9JMOoNzZIEcc/XljOWb712dN4hcTXuIAe3OWQDtCPuKzygd/ezZlMYrOHitzy9NL4ExR16Vs6ATxjt5dGs3tI57GcE/d7+YWSMVYvWbNYp72fITK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e058591f-572f-49ef-efaf-08d58998a20f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR02MB2535;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2535;3:9IsZKlv2IqUHHPV52wcFrOZB9zRgdAALB76Y6Pt10u3lFUV2d2bBV2VGvu1goQZIJVrzze83d0JVj9CsCNKYfj88PtvmoarHPkHY4tL/LO5sQptMh4Kk5N/bmx3Yic4TaKVengHzsl8EM+FOgEGdXCxBfD7WFKG9Vmz2Hvye1GRZiuOvriaEuvT5g4H2rsuw4VM598oegJSGjFjJtJ+8d4uYkNHPOq+DpRqOdVUVVbkzy0ry7ScVv8BvP1xJrFDEOYVd1IwrNmx9isfbfVlyGoNxstgEJKVWEdK4ap4MZWs3syHgvPEHZNwQmlFdar7CZammamJPKIYnSaZYczxNr8dHyXPHxko+qL7eejPZxe4=;25:AxTkqnOtaT5rrzMgxnPNedTl0UgFxo/LeBbexY6FlfGxPgOmWspqVrC9BXA1xiexWwXhrVxkQkPlL3ZAfs82Ewz8SBaRr6fUoQ0pcAfwEaNKo47tVrUXaVk4hDCrogPi2Mq4Xt5hQOF5y8u51wLe5E8LDZFDqRGYdJQ0vVt0PUajm3nmJWCSyX3ga+NQYy7b79XpR1pMox0dziv4ij3g8r4qkp7uYTHwLENrBLanEgcB6lAA4dgKQPc+CpYEIUNyszrypjbU45spelA0rMen1GCIqGLSXvXcvcg2UqdI/Vo9hNqWyiOpPclnkpRtileUxpmDqBhQp7h7rs2g8nW/sA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2535:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2535;31:H8FBtJXHsmh6AvpYLd3R9OEwoQYeeIm50vu9BO9u1SueH7g9k/jsc0CVZbYW9CBSOmjL1xxzSMVeUF1kjl8qnkJW7+8I6r/4QEh2PNgiZAWYU93k9eclDOmOEe5DHdsFaMv/Tp/cy/EmfnIxkmeoXmRUcyq8ypP7xaO5Co0eHvk2BJfEqZ5B0b9a3XLqwYKbNCJg0QGJg4dd0pk7uH8ZoZQSK3/z+HYLVGrhj0PaHZU=;4:Z46pHvdHgaCxlskqGof4ijI1cKPj05oVBPSySEg1l914u7s1NTQ6QDY3n3r/SiOea6Jm74qZisNT1Ufh/QafGi1XtKd8i8bUYpJ9rEapIBg5mjz38T3cPtgqpzQI4fw/tUfQpo0zpYa0StI3Y3C2ZwE0+LTD2KtDjhWr7Kw1vF9kyMgWLqLWanL7YHutBeG2FYDmPpJgsaiksQezQrhQ6HMs1Zii/EvQU7YJB8NFOmKeCvuZJD4P1BAW0JAD1/9Ovw+HNMt1nKJHv6uWaWApESvRaMj3HtpXl0DV9NFojYFBS3QX0+2/KPFBG6WgrdKKTU/wB5QZox4WedhaaXojuWSApX7xmjSOgaKIAHnnQtUPHqOLNput/REUsDihu9ti
X-Microsoft-Antispam-PRVS: <CY4PR02MB2535EC481404F21B761E2E1DC6D10@CY4PR02MB2535.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592)(189271028609987);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123556025)(20161123565025)(20161123563025)(201708071742011);SRVR:CY4PR02MB2535;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR02MB2535;
X-Forefront-PRVS: 0611A21987
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2535;23:2qQkXIoP1Qo4xT0BXa8yegMNuEjtd58tGWrbTiGPg?=
 =?us-ascii?Q?n3AfGXfiT/1SAwNd9E6oFoeIMbra9obXgy7EE0oUrwJqKDy8iF+1CQqxBiY5?=
 =?us-ascii?Q?YmniWzNGVTeUoeJ/1HeZhtxwoeotQDtx+ghy5Jv1SJG77l3Rh1EUe+H4vSk5?=
 =?us-ascii?Q?RpXu307I6XBrX4K6uwNOGMfFfw4y1aAMQPa6Jjh0xjqKURcuDJr0QexJi5fN?=
 =?us-ascii?Q?wdXHqaL05idNs8Q9MTzqMOvfEdRNL6lFi5Sw1YhlKhKkEoos7hE1GyXKaKwO?=
 =?us-ascii?Q?RfEtpa16kyq3kNPyT2C2cV5q9/omExfz4uhtUsNYSrXAh5JzpmSdtuh/6r2S?=
 =?us-ascii?Q?iASC/QDSgrU3J7Lbo6BBgHIazRALth1Ihb9Im8Xlu5A5jnOusMUiB+pobPOc?=
 =?us-ascii?Q?aWgDmiMY2S2hGfOspsbtVqdFDqO7wso63TJrLu6DH7a/7AgSkhWed3rbagnC?=
 =?us-ascii?Q?8s4tdTCbA/bRqA5rOErxdUTKAafNv/ueutFLQ3Rt/f0Mh0K+/spEckc59dH2?=
 =?us-ascii?Q?C6o4L6Vs5XFvZ4+E3YAjr8xh2eyxq4DltAX2AyaEI1u2ou+opUUOoIWoUefA?=
 =?us-ascii?Q?GhksDKcwA/Dt2Ozb+hWUOcAOaZs8wMiRuyh/iwYKv91X+vg2wroL7TlhCF5D?=
 =?us-ascii?Q?F/SSbi4xB6Mf0lDZIXpDg9wNdLZxOKXmeJXGMr2DdRaXq9bjE0d2tEiA6GWt?=
 =?us-ascii?Q?ARMziSKgLp3N/2rIcs8KirG99VD/2lvttwAYoOnIVyO5VAmqKVy4kykOYv2I?=
 =?us-ascii?Q?iPry5232yrGDjD0F3wsF2xgWcA5bVJJb/Rub1RBlG7rnTGw9DNzkr0dc9Hka?=
 =?us-ascii?Q?/ZzLV2oy7Hz1vGt3JOd6jMFW9bnqErtD/FTZXY0jFWon3zbhRZNp0v7eMKaI?=
 =?us-ascii?Q?aXELaJHVQjX0jbZ7ckt7EAqBatD0JJA9ZqszrzzOgiS/LZYNvnQq5qBpoog5?=
 =?us-ascii?Q?5OvM83DapDIDkMRWzJMd4mexZ3vhG4FDIBjKQj3r1MX0ROK4NKG8Yplx081F?=
 =?us-ascii?Q?z7LTQpgODUAITHqiWUzt98NJ8GVCRpK44wreFT4FECn7Ph8qVSRTX9IcF96r?=
 =?us-ascii?Q?C56oTccB+kyhF5GbpgyMRoQt6JbE8y5yzte79DodKzUXAEMyN2yeQY4FHtDw?=
 =?us-ascii?Q?oPGhvlONTNdgE8m540vb7BsDF5IyBwTt4EsHD9iSdcDl5kqf7kqFWY6XLy2c?=
 =?us-ascii?Q?CJSTklOh32+A2NIG7/MV8p2nofJIac8RyZ+?=
X-Microsoft-Antispam-Message-Info: 6cB7vHVzQNGYFoXSFRJwf/R841NImxr47XoA9rDVHMZjIbpBJLgKVbFNaqfu/HTl5Ck4smyLo7Vi/rvpZ81OEcjQs/eC+E7cgpcDbY7TMgvTeF+SyI78PGVDZFsdO/YyRMvWopWlQB4uwTvKtEBLvZFJgUukf9Zqw/cE2SP1Hbng11R/TJiMBKqemZXFBM7h
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2535;6:uDqi4BezyT4322a6kbF+nz0/cPQ9jEOBeio+DN7NRBJW3EPrDD1+H8aMmR4rJ4iY0FNAYfTLZtr46TVlWfdZCmJ9A37P65ESzMNxHyTlkFQj6BuZs3zrhFhUIaVLrSHkG1kg3JxilhAJnaulmDTbNDR0fHtso5Gr0O9sKlaqwVQ//mP0mT9zxHQDFsYwZPczOy552WoKyMJMbrboh4MHuVdy/PAVsAVnScPKJoArmYeovQheidlHkdeKw6zdfteA9vhHQYwsZVNZRt+aoLQ3//TXBO7HEwOC8vtWtYv2ANF96VcQb+QU0s6w/DRqS6DzVKulROXQW9hu0CRfUS884mCRFYPqk9qGrdeWQk9frRQ=;5:rm1f4oSom2uqZaM3chtZPTU4J2GEC19fixaVZtXE7A59vDhudHnA1RqRXZBXrkKmn3aiTAbGuWarzyRK0ZXA6m1ZSOGAwBGfpHljGCQyPxRoEA/n9W3xGb5an9xVuoJ3S1Tzk6bHStUMgaiSkG/T23vZHNf8km3ZylHaLtfST6I=;24:D1S2zIaibNgM/HY7s8ErAUsdJXndR7ZyeMfO2y7yB8AAFSzwabHD6xODzN6VqXIRglqCnI0wX+bw/2KMHJA5a07fXgZZCLx1nwzi+bAeHSE=;7:liCg2aoW48XXyhcy1/N9VcaKSBTfk7wFIhxryno2b79VBkOCBkfKA+Se4wLUH96uYRccc1Shfr4kzCVcIs3ojlrtrg8LOjA8NV80UrMMPudoWLlmSgFYzk3ORETKroRbiDow9b08x9tCyn+D5PAFq4NzpMaduRqklnrx9TYf2r43LGS39+pMrP0xwWtfiXTM00y0KmcqWZjdpb95ED5plp9Cqnl/sKu6TUkZJjrbU4P3hMBiAijwaIhtq1ca+WRg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 10:44:58.8359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e058591f-572f-49ef-efaf-08d58998a20f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2535
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naga Sureshkumar Relli <nagasure@xilinx.com>

The following patches add arm pl353 static memory controller driver for
xilinx zynq soc. The arm pl353 smc supports two interfaces i.e nand and
nor/sram memory interfaces. The current implementation supports only a
single SMC instance and nand specific configuration.

xilinx zynq TRM link:
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

ARM pl353 smc TRM link:
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/
DDI0380G_smc_pl350_series_r2p1_trm.pdf

Naga Sureshkumar Relli (2):
  Devicetree: Add pl353 smc controller devicetree binding information
  memory: pl353: Add driver for arm pl353 static memory controller

 .../bindings/memory-controllers/pl353-smc.txt      |  53 ++
 drivers/memory/Kconfig                             |   7 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/pl353-smc.c                         | 548 +++++++++++++++++++++
 include/linux/platform_data/pl353-smc.h            |  34 ++
 5 files changed, 643 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 include/linux/platform_data/pl353-smc.h

-- 
2.7.4
