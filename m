Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeB0XZU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:25:20 -0500
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:61705
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752346AbeB0XZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:25:01 -0500
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH 0/2] drivers: soc: xilinx: Add support for ZynqMP PM driver
Date: Tue, 27 Feb 2018 15:24:24 -0800
Message-ID: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39850400004)(2980300002)(438002)(199004)(189003)(106466001)(47776003)(81156014)(316002)(48376002)(2201001)(50466002)(72206003)(63266004)(51416003)(356003)(305945005)(7696005)(7416002)(9786002)(110136005)(54906003)(26005)(107886003)(77096007)(50226002)(478600001)(6306002)(6666003)(8676002)(39060400002)(5660300001)(106002)(336011)(966005)(16586007)(4326008)(186003)(36756003)(2906002)(8936002)(81166006)(36386004)(921003)(107986001)(83996005)(2101003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3813;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT021;1:+qCTlkhMEQgABKD4gmjjys77BgJGUWSM/kmF0WfG3yQPmiUgYOyppM6jl7JPS00FtYMryu0g9aPOojdJGuApbdfVL088SskngO9y6Ix3s+rARwphsdOJHjqenbK2dgnU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d20a4eb-0950-417b-1640-08d57e39500b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:DM5PR02MB3813;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;3:hurt9LOWdBc7IkBc/M/KYPC+s0+u0n3O4VyZbcfCmUp8hwg/kst2gaLHgzDZZJDOlttvHkbEi2T/cxtBoXoZNwMSrmrsixKG+6kmC5BpND4PiDSRP5sDQoMKpWvjqxRBW0BPhOchcIpSSFWxYhWSy5bVj4ounfkWO4ZrMgvtAkMb9eP6FBoVI2sCM+nLAzEle3J5xmhzC3JUzEHIs1DuV4v3bVFiDSSp2FAR8LvqFhDJf8kk1rp+fh4Yyt64AJPhIwnXnLMF2k+sTSw06FY5oMihkcg3gFPKuYvC/AHJJP7aOm4D8jigXzFkOFawSdfT3UdW91F2xSy581pLwcp0JddSP+Y+iQOZDQNEbuRtO9U=;25:mBlVgmg5DhhwVexT9cjMqvzyDJTyHAQQ+JigBin/NDK11Ic9A/riZ6H8kjlgv1785XU/+dtGf6zWawFPMEXUkBy34bYUsp7c15FLbQVXmk6IrH1gJhautIrDzpInaDr6LRcVB2G95Lv3sLA0ZXrVTz26q2CP4IdaEsKogqDO+dwMWgKwEEt6O4iaSeAQWwBo5WzJoFwP3ymqaO+1BT3tz10RzHy7potk+z/UEgT6iTqhUlItcm132dFBRzDq8+nOAjalUjPYfMjRCZaqRWK5RnnR5yqA4vLJBevHfeOtZV7cJ7XG/tNGpo2bjA6LPZhvknsKUIdc67yHQETHEjCrWQ==
X-MS-TrafficTypeDiagnostic: DM5PR02MB3813:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;31:cM5B2jWfhrgGq1zjKmvNZWL0ldO+dwnLvHxyFBlQrNamCVNvBzjLyGXlKyVH7TnoDdAzY58BS8mq+sFMMWBYmr2+RiK77FbMzvOg1q4DVaO23VJ/YpECXNDztVN/agBvUkEsWO+U8A3YWWqkbry25wWrTkeNc3v9hem00B7ROrSX8I13LLwjqWKEaYrD09PaIh93RK6Gz1Tgd0f2kdacAs7gPsrCp2Mp3vwzUOQYRPQ=;20:KaL3Qe6HlPOjjCShCNxFtKhxo+wZizH/x5KxG9OOtvq4IPqu+A+PJgCRax4SPzF5IfxOKlEoOfPZoEpwcEtiuYe4qarpSLjrdTFEf1upvbemXRcSdMR4I2AN2WibTLYbcg5YXmdAC0WT+OzX9sqHCWeP05SV7RHESaTjNCA/qx8AK0CBMH8wnHXuvtBEq0pLOweB62NQbCIczfpDqFPQa38K0D3p4yGZ9oGFFPSb2oj2anYLBgOUeoKT2RAFVsLoTqerTZEzTOi3h6a2n9dNvwyQ3RqGM5ECAw1nLWGsW7jM3VN17YVZHwwaWPX+AeidIJFkArU4FvRONnbxfOdaXVe7t7/v2MC8D+1ovp/iik6ES2i1xuT3QFXy0/bdtylFDYkQSmZPvptOt7MnDtbYZfWCixbRdlxysRnxH3XRK2IpgZBlFxNFbt/WCzr2l3KvMqJDQaOAIL/7HC2HnVdtl/xUgG76FobwlcF4DJFgH+xVq101a1678y2/ol8HQxA5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB3813D2303937A747BC48F8B6B8C00@DM5PR02MB3813.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR02MB3813;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB3813;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;4:VBaoEIVXiLR8zh3Fu7TOxE3OF6C+E6caSnzPNA9KlIriu9bJAvQ/x1cPthE2auLtPTNU+gZnG5a5Zr62agnSZyR0uUt3HFmUg82lfvI2x7dN4OMYr/B87exKvPMYRKbglhSiZ00ZAlP3k0TUlqPvcBBip6mnc79wtF7CJof3zolhHq/AFcApHtle82KC0Uw2275mgdST7KPaNRCUcaqWBak/X40ATE8v6746lgLv77vn7qQzsMiMXm3RdB/XAXfQMSG6PlWUUqGNzV0/SZquAQ==
X-Forefront-PRVS: 05961EBAFC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB3813;23:Jly4sAi2JKxNfqixHXI26tpHrb4EWa97/SXrvsacM?=
 =?us-ascii?Q?8imzVzkyIsRRG4HdY8zxu5IvSq8+0BGGjJfEu7XK50mKhkmke0axuHMlRiQ1?=
 =?us-ascii?Q?tIuFmYINuGnF7UfxazxkjbCpBTx6d/4Lqb3Vf20508DADy39SRP5SASw59ub?=
 =?us-ascii?Q?uFjQ/a1dFhV8h/nG1HaL7gdeUtaP9uqSSMAbC28FOl8191euwibQb/uMI6kT?=
 =?us-ascii?Q?coFRSSh8OYwIhPQaV+meRXyOEs8gkncenVNLPUH8NusvL02hkWRnqdQvamg/?=
 =?us-ascii?Q?cukxkKvv5DOrDjSsKYgQCD41SonOW1pqZR3/SMiivLtgQyjbrUYu/rxrvfTc?=
 =?us-ascii?Q?7fLjb1n6/QswA1UNc/51JWXdOze4a7uHKgfyCzfw0tjUySTFydv+Kj5WdoLB?=
 =?us-ascii?Q?8jY1QuPa9di3cb/EgcQGbKU+4tlfHI4S5pKqaaBOHdVCkRVyMp2/LvhIEIzy?=
 =?us-ascii?Q?8NgmJWIoQB0JZgHYGqc0tliuWZXnrw1EUz4jlwXN1YR5N+n66hbFqci0shVF?=
 =?us-ascii?Q?x1HtohwGl5oKz8c5SP4IWBFHuOMe42Lw7UxfKxX5yMGFINXk9ck+VP3KRN0D?=
 =?us-ascii?Q?kc8zOckFJ4t1OoyVVg4NqeMksnVGPEjTs/j4s57/VwekAtr5l/jiKtEEVIg5?=
 =?us-ascii?Q?+9FXd4515p7tXysmrd4/xcUDZEnBMn+mys3yVqfOkzrez88JCoyAhxhBuuI2?=
 =?us-ascii?Q?WHjBTgiZX8+cX/Guven0zXoPoDBtdxO6RXkGJwjfAtVi+RDPcxI8LCHoKUGt?=
 =?us-ascii?Q?DtusR/8CXZST9ykdAQC3TDj7+LSnk0vcmVO0E+BhnLnaq3MHd6RyIU++VxZw?=
 =?us-ascii?Q?prG8DGvQOyaaqhlUYDT2ueGLdzNnSUUN2/CLL8qNmuRHkRXX5wtS24WbN2EB?=
 =?us-ascii?Q?UcoVziXLhqvFGU0PFnzvyd/6OahqnG7aAZb4WM6fOdojzOVlXqJHzwUrXyd5?=
 =?us-ascii?Q?jhxkpEEbssqdrgUYKllrGCvutb4FHmg6zwvKNan7pYjAYKUOaV18EhNXb9Lo?=
 =?us-ascii?Q?O9zoYZQ5uE4EZaOjhXIHnYtQlzTj2TSpOnTvG+w3yZ14bEA/oB3wkQEchXjq?=
 =?us-ascii?Q?Uuo9AOJ5f45Oj8OQa+lXPzMZvmjkdlMutMTFWu7sI+wL50SAIyHqsuFmnOMd?=
 =?us-ascii?Q?J/k20NZorlMNyh7O2g+Hir3FyJKF1wR2eVnAcYOKHBMOg5cw4/fj0hAZFfGX?=
 =?us-ascii?Q?/RhhqPFXyQ51OrT97XnT/XrGWVig//ak6JJ?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3813;6:gw7g0+IiwwX6yto/cqvpXwhAI1mtzuVMUAuSCdGLj85fCCeIejHNABQ9T0XLYOEZlz7OpVYDhnxcDHtPAp1DZZhw7CSlDVXszye/uemChqH7ICl6LR5gNtV0hjuUZB0nDQQDqpY4NN2KM6tmywJT0Zda0ZEkG4nquP1jmwAUGjVZ056zr6O3/rk+iVcaT0hqrypII+59HEtN3uoihai5JYUpD//NPdrElONDLie2zFzbHE0Sk+R9JMKzzn4QhEV0eRTOYj93ITcy6NbPPwStrZXtY5GYodw50ZC7thxHY7UZ49hlL76k/V7euUxcj6iN9XFef8MIYuZm7Z0WKtXSU1EdrecZkPrRaLPzOwIVYUI=;5:yZbl2MuzlAUwiATY8cT7DXQKP9yCRgQbcjW6F2q3xDBFIUIMCh4TGSDgfXG9W6yQ1sQkEOUhUOBYg2udefiV/6YcrpHrlDJ2R4kd7hpG5N6lkiJTTPb0ivOqopEnM/BFqY6u20X2cixApA698Ekd0LmtQbjQQUghgk/B3HzTQg8=;24:0XYk+gO1pUAyL8WsdeLM82AMxn1+kzoM1ZNq1u0YALMZ8AIiaX0yDs3lLFNFAqAWzVxgsd2aP/XpRqHKZmpyz1nMv3hB+v6O5BdK2TodRBY=;7:9+A67/rYuevIuB0M5nQh1GOFbT5avv71au4Z3BLulgniz8SWw8NFQCp9fOe7poqpJ4bJQ8LLkyb6vR8LRRK7FNsVHLwp8FKSkbf0r10L1ogo5Nu6o/eWNQPujmgbqrb5RvrwxA+/Xi0GqQ03mgDX8+j7JiebuE/krA/fjupIuTnLkDmPXeFprPgQHJIW+ZsVpkJCa7ny5bRl9MZMsOBuU03issvQ35FwKhPTD16R0/VIUIN4AYkc4BbR9EWmF2sE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 23:24:55.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d20a4eb-0950-417b-1640-08d57e39500b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3813
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.
This patchset has dependency on below drivers:
Firmware Driver:     https://patchwork.kernel.org/patch/10230773/
IPI Mailbox Driver:  https://patchwork.kernel.org/patch/10145799/

Jolly Shah (2):
  dt-bindings: soc: Add ZynqMP PM bindings
  drivers: soc: xilinx: Add ZynqMP PM driver

 .../bindings/soc/xilinx/xlnx,zynqmp-power.txt      |  28 +++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/xilinx/Kconfig                         |   2 +
 drivers/soc/xilinx/Makefile                        |   2 +
 drivers/soc/xilinx/zynqmp/Kconfig                  |  20 ++
 drivers/soc/xilinx/zynqmp/Makefile                 |   4 +
 drivers/soc/xilinx/zynqmp/power.c                  | 249 +++++++++++++++++++++
 include/linux/soc/xilinx/zynqmp/power.h            |  18 ++
 8 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
 create mode 100644 drivers/soc/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/power.c
 create mode 100644 include/linux/soc/xilinx/zynqmp/power.h

-- 
2.7.4
