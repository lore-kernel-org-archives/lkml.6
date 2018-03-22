Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755627AbeCVNwU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:52:20 -0400
Received: from mail-co1nam03on0064.outbound.protection.outlook.com ([104.47.40.64]:18896
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755600AbeCVNwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:52:16 -0400
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <harinikatakamlinux@gmail.com>
To: <nicolas.ferre@atmel.com>, <davem@davemloft.net>,
        <harinikatakamlinux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>
Subject: [RFC PATCH 0/5] Macb power management support for ZynqMP
Date: Thu, 22 Mar 2018 19:21:35 +0530
Message-ID: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.719-7.0-31-1
X-imss-scan-details: No--1.719-7.0-31-1;No--1.719-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131662003339635883;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(51416003)(7049001)(55446002)(77096007)(5660300001)(26005)(498600001)(47776003)(63266004)(73392003)(336012)(6666003)(73972006)(83322999)(61266001)(426003)(4326008)(356003)(59450400001)(305945005)(86362001)(107886003)(316002)(106466001)(36756003)(2201001)(82202002)(9786002)(76482006)(450100002)(48376002)(86152003)(2906002)(105596002)(8936002)(81156014)(50466002)(81166006)(2876002)(8676002)(16586007)(54906003)(50226002)(87572001)(110136005)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2536;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT003;1:oW83NNVf+MwjU34Xq+56m9aZO4D7w3r8EdsEPZb5xSvL//I2ilSubRs3feEbHiIKTN4PsWO4nO941w02Y/tlObqktnAw/2DaVfHW9p0pxXRq6Pcv9PTdlG8p8SHIXjOV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc7ef2f3-5d68-47bc-fc15-08d58ffc1ddf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR02MB2536;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2536;3:fDhrfbT2kLLdSVDHerrAUdfj7K8tkIEpSSY7BFV+s0SPTc6QO1VO5/a34P+e5BzOeNTdYiqOdGuxHzMhT5N0E5kTzesKPdRA6XR6LeiDy1iTfQzZzzpMG5RBRD8DvhW+z7Huf7TK7mtKBMAsfmbKQ0iJf+gl1gq1Ieb4cNIQjk8byxQppd9xCKF16IgR4ap6INspHpOYtJXQWl+bkIPqc+8rQK3NzLtRlwAPYfeU1A8rFah/2Bs1bdS3egjz57jTwPWQLS1sKfveYdYFdJ2gLgYovnq4115falLijNYGpkdJ/fjJH7Gh6C5TEKo58frjmWiSbhCKQuC5z2KcN8SAP4PrmLV2E1KYc7OsoKA5/V8=;25:JLOKtJMGmQ3LeAS39MTK/fAVHeky7WqDiT5dKj2b5ezAYdZ3mgXwEoaNa+yE6OPHkK6xFYzE4ye2hqDeWmdvns1XdBL1XQ1ora95MbMS+DW1US70MW80U/iwP7QfYNgKJUkUbcv+Oxn5VmwWmjPvc06pxIsFVfaqYqwYRyxZTQbR6wZ5L1W0zhjz/roq1EvtNSzb62gIp7Dycu8A6txXwap1yqiJ/8U5fBicye8l7oC3GG3CsPakDcQQxZWYTKn4rfP8QDn+RcSEJNKd4a154NjvlusS4yxdH5ph3szv6ZoRp6IxrEyavWrpHPbgkbVBwpn1Iz6cyuj7S9+AjBjCOA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2536:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2536;31:dCkUrj9YT1d7eHW29YzjYCFODWt1MDrUeQr9zobVQnFMwhlmZYGcF8ssGT4wdVMx+6U3iU/lfCl+5YDL6mmU6huuCtWGvoxc4GctC3KoGUSTGeQkP6ThCKqy906MUPZDSGoNetiZtMLeJTzc5Ik4m7GCTtX0VIHBn9gmOGNQgah1ZVYIKWbWUcjdBA2tsnMKqzPKUrNjTO75wYkQoV0sYmyQFo2xDvLzZbfj1qIrWDs=;4:idQnjmfxpUbuGtP9KhCZLHQQU302kRHkx72rgvHMOkk8l0r4VENcvkKHT9/NAKnKnmbR65Qc8fW1F5+MhfrHwzaMWwCt4bC2rhG4dFuWt5pUPqVHuC5r7IwIL8EMQg8hkpsslQmp18JaQP+TafO0hyTXBbD6elUVUvsOxblWItpVD7Egwzs1qHUBtIx2XitV7bAyEgnMEnsjrskt0CoWSWDUU6NEL9CzAgrLx+6e5NEar8QUQR4keCdSws4QfuhcBlepJrjxzrbc4dWPL1kCCn3HcWJpiomLellkZjaNHGK7mV+3lkwEXE8gxw2RmD6h
X-Microsoft-Antispam-PRVS: <CY4PR02MB2536BC685EBC3224F1134F57D0A90@CY4PR02MB2536.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123559100)(20161123563025)(20161123556025)(20161123565025)(201708071742011);SRVR:CY4PR02MB2536;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR02MB2536;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2536;23:O648V9AORSqiPuptjqoRbPOTUlzRDAVkvWYGRHO4c?=
 =?us-ascii?Q?1iqNd67MuuauF03v0YKQppgHJ0opluLrlZnYHegJZmmzXGaUFBPq5oC0gneU?=
 =?us-ascii?Q?IhUK+PUsUuc44YKhb4iOTCy3m22qLV7YyiIzbp5jGeOEQUS0r2QdCtHLVl/g?=
 =?us-ascii?Q?XKK5Ccbsv1oGhtHRnGZPbiRm+gqzZQ4RNXGFu00N9ApCGyichByEcScvtWEq?=
 =?us-ascii?Q?+eizibDrowFqXEGnXFZKizbqzCjrH9N6t5Z0OiKGnWwMx+heq10m1w3vIpUL?=
 =?us-ascii?Q?Hj5eQVKDIQjsOryzxIvFAxjku+Hu6PRP4GWeKxX3ht16WRpAZf5oVHyYhHMt?=
 =?us-ascii?Q?2u4rxEGNWO+Akf0LA6IrFaJFNXJiEkDwgLt1vjDc4hnalGFtJ0zTRx9c3DXF?=
 =?us-ascii?Q?l+6IYhXVlXBzPmFFgDnfNDdv5aBmp5g39OMYpD5b4ddsvTFlUpfdnJLOwwdQ?=
 =?us-ascii?Q?0tlCXLn4tJkMxvuoCp+wtLF78mPJfsZ9V26S3h11qFZIxdj8BkGcxXVlSb/I?=
 =?us-ascii?Q?2uNL65Gw4L1Yy74Xlr8raBNzo31OlCugGciDPyqNkHzD+NPxZySI8Vtu+ile?=
 =?us-ascii?Q?cmiwxubgPXeSRtfee0mZI+Xx1msjb6A1IhJMqM4LVAWDXJPad4aLfqVgqLTt?=
 =?us-ascii?Q?9bSUB41HGRPLQrURZaaN/GO4wnEOGsKEiAvGZw9x6SNQskuZXHcnNEE3lMYE?=
 =?us-ascii?Q?S00EgaVC/qJkzD7io28igcIZqHRd+PKvbb4CKnNtNQN1JSw7hSyn00gbaskr?=
 =?us-ascii?Q?HryDWZh2/J3VgGQxhzjgXNzLAPf2+r9njuBf0DS2IaNMtVf+WWgQhLI2gho5?=
 =?us-ascii?Q?EvrGPifZSmeNrZF7ctOj1BOD4F23SAWV2E/T/AS38pXuQI11XRiAyALR6PTw?=
 =?us-ascii?Q?oUa2SNcl4qJxMpiLO8ZzBX7xJabw/3FUxjEaBjfVB7SoujQAt0dlyJuzS0bT?=
 =?us-ascii?Q?mktnVRnjuG93vXULoiGO1zSKiQQbZjfiPSlovNO7HqX362ufN+TUUpgDm9XW?=
 =?us-ascii?Q?S3e5KaqRxfnmM+lG9MrFD/UOXB+cVrkQxS9vqGTbtmR/x0mfzaoXAyVXsyUF?=
 =?us-ascii?Q?ZrQaS+Xbg4MKHJFeo4duX6DTNLjyUZ6ApKmGvGgCRAFTs/IxNJLKc5FOV++3?=
 =?us-ascii?Q?LEuVgFq2weG7T2QLNB7/APHue1aXMDbcO0kXqhMCvMVcyNhoPeZ3tVQOe6Mu?=
 =?us-ascii?Q?nBghoeA8NR2WO7XS+8FmPsR6d42o1GH3xukqmtKl52B8qGtuuyv37d454rJu?=
 =?us-ascii?Q?/Ap+2VIJYdFd50qTu8NGOCk6QWImpoPG95jTe1y?=
X-Microsoft-Antispam-Message-Info: a7HZB1MzmvC2TysCzIQTOt5G0t78suFWURX4+B5m5/Gx/c8PT+zU0UrG2Iz+myq34UOLQ8CAsjGyvAU7mjxpCwVJ7yRDoXCQOxuVqkjhGAz2rOPSwFZCqpHApHTcAx25d345CbjLq18G7ug+8WFBbkIw+w45DrUQtRwZwGh5ZnwJvqzXh1c1IIWKQvprQhgN
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2536;6:SYyxJA8CRFzfPTBvjshlS83Zz5dRJiiQZUGtSllI2058svWI/6ekxy44OQuaVp8mcl9vchwvWk867hpX3s2zfw5FvwqVTyW3cTE+yswwqJCjKKRFQ/NOPnz8TEU3Js7MmOf6Ympe9p5c/4aav0CeUVs6JW2TFGV2wXgnw7jS2vzYqOjo+0en868CNiEGlohxtsKDBqICgyToPCdzP8TdRtgmG0lyALcHk63Rk6Pq4Vuz8oXn4liAGP/mghDGfXNu6VTPJX8qUHBgy789eIcDE9RLp8IZAbE+IIDb5iS2loODcHB4vytH5suVNb3jxIci/HzF0oYfaB40xE3b+q8KjCCY1ZAYtNus1c9T90RNE3Y=;5:jNOy0XaFMXIqDhsUr2/XYwYxvAuHZMcUUtyehKfHdoIuJ+4sca1wYA3p80KwqERmG5+fAo+mLKwVkVakJ4M9yzgHf1F6RljgzTbyNYTVfRmEW6we4wWaHwW5+Y+sT/lZ9cFQqvDy+6tT4P6YrKC2EiadTMJsMCaF7rWkPBBwtJ4=;24:tVHa7b7wNyDCCDgd0KVzuLVY2x330LE4qo2QjR9RgXjNhG+62ExEpQCXdnx4BaY21Scii5XJc/SrokdcRzBo4BazzGhqwkr1MVEojodHC/o=;7:uK1Sm9zuqhBIIUuTzs/GnHncnP2wvBe0LPlDKKGaKfVfxy10fxPIBHylwP4CKlDIBtsUSRxi3DRHO8aaGRaynRwo8S77IrPYe5t1N7IZq4GDmlHCsuheAc09baJB/7xtmEhR64oSOmv6orZLjzcLhvoSRCSkwNhaZb6drrhexjOk5vLlKimtPPhSaGqutG8g92NywQCEgL589RiXIgfXUSmQUVOU5YYeCOF2pDZr5f2DGZeRU6dSx2DybJCdxP2s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 13:52:13.0416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7ef2f3-5d68-47bc-fc15-08d58ffc1ddf
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2536
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

This series adds support for macb suspend/resume with system power down
and wake on LAN with ARP packets.
In relation to the above, this series also updates mdio_read/write
function for PM and adds tsu clock management.

Harini Katakam (5):
  net: macb: Check MDIO state before read/write and use timeouts
  net: macb: Support clock management for tsu_clk
  net: macb: Add pm runtime support
  net: macb: Add support for suspend/resume with full power down
  net: macb: Add WOL support with ARP

 drivers/net/ethernet/cadence/macb.h      |   9 +-
 drivers/net/ethernet/cadence/macb_main.c | 349 ++++++++++++++++++++++++++++---
 2 files changed, 332 insertions(+), 26 deletions(-)

-- 
2.7.4
