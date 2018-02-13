Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965254AbeBMO4o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:56:44 -0500
Received: from mail-by2nam01on0067.outbound.protection.outlook.com ([104.47.34.67]:47424
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965118AbeBMOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:55:44 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <shawnguo@kernel.org>, <Anson.Huang@nxp.com>, <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V3 0/9] clk: add imx7ulp clk support
Date: Tue, 13 Feb 2018 21:28:05 +0800
Message-ID: <1518528494-25723-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630073429381499;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(396003)(376002)(2980300002)(1109001)(1110001)(339900001)(54534003)(199004)(189003)(498600001)(26826003)(336011)(966005)(48376002)(50466002)(47776003)(2351001)(97736004)(26005)(81166006)(81156014)(106466001)(68736007)(8676002)(356003)(77096007)(8936002)(53936002)(305945005)(51416003)(5660300001)(2906002)(6916009)(6666003)(6306002)(86362001)(316002)(54906003)(105606002)(16586007)(4326008)(36756003)(450100002)(85426001)(50226002)(104016004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB1415;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC002;1:54QrYwdoUbfntU47mdToeakdZmSzG0KeEKp+ldIz7uOnxOypVii6aTb/E0SruYiyx83+Yj/JkU+TRbvJs3/NWn6XDPxfz5+7eO7FJ9gYtiDVmxefTQjCD0DRiHCej3uj
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e29281e2-b0d4-4d8a-83bb-08d572f1dae3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BN3PR03MB1415;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1415;3:2SGJgCx9frYBe5EogmmYZGWkVEEtpIiyLtL618H9xp7vj1riFtzuz+ZtBc23W6Ng/FVCWHq3qJGJMhMsEKwx6s5byM5LGgVf274DI+S0aluye4+sXrJLi38bQ6u4A5llMBoPM+YGgxTVoClO8QCWbluTjKIbdq++cRcJqvjNrZ7ZGc6n54AXgmqlNUHeBWRISCF8YiVHJLqlr9V0Dvub2jxpIOFqz6aIygkykkrfOoAW37++kZ1+In+LxeyJ4l8y8d+Nf8wzwUcP4rqHwh1Q0JBA9EYL7bBv5fKoKJ8h0JCJlUwkcFKNweTLgP+KWk96cw/AHFw9PgvQwt6xK/3p2tPPXxF5k80/w1NRV+WIYWA=;25:+0+qSfSSy6O+tB7c1xOVHkiVuWdh8XWYx0y3c/awyVySzffnfByPmI2YRtr9CFFY2U/FYFe8XOZVhtXr3wne9haizx+h5rgESSPAmWK04Pmddxz7vxm5F5yIGvqDrBeRa983WIU8HP1qnBrd6mfY2qPQ/5BDDggoloMN+9g3GzXGgjuL4vNhaBLFPzooa+sZmfvxqrye8jHCYGQKbK1yH1xbYYcgDRw2cnC205JsffQxdT3cZaLGkh7r9bgXVly4CEOXW9rpfxk4bOtiHqQWfpeTN4oED9oOfTphfSMVk2ouTnsB1bIhEqsujB0WfLuLv32zwBz/u4F00Cy2xnQ/zA==
X-MS-TrafficTypeDiagnostic: BN3PR03MB1415:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1415;31:9rCAevU1MftDPHd7keeJm+a0tMddAYHABWq7n18k1Cp7uIEG0w4GvnICelA8bI/leBrkG6Zf7R/2ybQL0BQt+aY6JYjR0miZzQCCXzRy3Jo2oea3/lMWXPSc7XRewqPAimn7W08d2LcitfvBIxV0kP7wC4km5DkC7JISCihpME6Ox4Jmlp+VVi5OeiqxfJgEl4MOJ8oZYetbjme7s6Ga3eCAz0Y7smfUZDHBt0ktNTM=;4:Flhx7RNMXzG9tAYYx1L4YIGhHnIdLnO91zI1/QPOQvKMc5eMWl7DPT+CXX3+fcRLzQRetvjmF0r5nsWOhE1uPrl2nXptshCdgY9C2c/Neei3HQ15klrQviVNp5C2T268DW4EePs0Cwc7dzG4Le1K9yRjZHAOijZEmZDysY1S7XQHD5BOJXhJ1OePQ7CZmkHNgKwyoJn0AabMpzU4TKvRBZeXCvi1OPyLHt26gYloK5TO/Xl5ZNaoNHkfD4xSqWi8G0ItaOpaqTbO84xOWyVmnA==
X-Microsoft-Antispam-PRVS: <BN3PR03MB141538F1AEECEB9DFA2BF3FC80F60@BN3PR03MB1415.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(3002001)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123556025)(20161123563025)(20161123561025)(20161123559100)(20161123565025)(201708071742011);SRVR:BN3PR03MB1415;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR03MB1415;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB1415;23:dl8YZLT2jhNqQa49THAI4P9HbRaZulVmaHhskt9RB?=
 =?us-ascii?Q?4CLdzM55xqINbeuKQ+I9FEoi3kv/zvcnC9WCSXClO6N6vHo+teN/2XaS2YNe?=
 =?us-ascii?Q?/v+TZjgKPavLZ1hNFKZFlfCFX+dBhL2Edof0MXfUjUENuAAdscCNU1OPJTch?=
 =?us-ascii?Q?jBQcpamOnJlouVkkbOi+vxfdg82NuAfRf9cB6Cknr+1APZVu8+ySPmeAzj/n?=
 =?us-ascii?Q?HyBW8D4OwVlM0nmBzn3t6d/E8F6xRPeHttdbdbUksGoghS2AQfN84nWIZMnm?=
 =?us-ascii?Q?6DxJVraEkrl27jp6CZE1UTQt0GKXVyFlKqohMk0I0uaLS2uPlD/iItA+g+DI?=
 =?us-ascii?Q?O8+hqXAIqUIvUB2Qa67IwQ4B/cwKvzFypPJ6hJ53B23XeajVDJkTwDIOsEtG?=
 =?us-ascii?Q?ukbTFTCn2n/frFhyvJAmgq9RyKR65SWzH+7fZN68L6jziEdH6i7Tb+4a3Ahm?=
 =?us-ascii?Q?rvRrKqolpJHiZlEVvKjCWQwL2ng8GMRw+gBIKGbFa9lLf8XWZcxPBOCjPzdh?=
 =?us-ascii?Q?ByUZ17R9YyQyGVghee3hOJe/T9lflYRybb6glhBLYqaicIylVVl1z/fKbmHp?=
 =?us-ascii?Q?E4HfOKQxI9wgdBoNlMN9AP1Dn8xt40vDnXLvJiZQuyBdJsrGh7FnjcDnu9Lb?=
 =?us-ascii?Q?bL2NgSrKJjG9YqrDt0hZsDtryFkaXT01dcpLqQPHovBt1yn/QEA3xbD81L8H?=
 =?us-ascii?Q?AhTHJJ7IrhqdduEo4OH9oP8i4Nyr3HeTiiIxUREompmqyNVO4JLLQLTu0Pct?=
 =?us-ascii?Q?+Oaca+xmrPSdGnlBUiv59riG6cbJ74RfZDff+OhgBjKRV1N6FyJ+sYYWYOM/?=
 =?us-ascii?Q?oIkGHm6L284nFcwhyMVjOHiShB37S526m4tSAw2Vh/UwaRuz8yUWF2jquyHq?=
 =?us-ascii?Q?3XJkpNag0OV5N4fP8GVWPqFDBneDCrmWP3XSZQtBgSYQXa5AOanQpIi0ZIpH?=
 =?us-ascii?Q?jMQxOviSk9FS9baZX7SpC+IffQnlTRdh6rM+7zD4uHF+oXRzVZbKDz13cfOZ?=
 =?us-ascii?Q?9uFrKmNkgqwvLNmW2xZLBgBFH3VNxf/IcmraXYi8Da9re0K7xk/RQYNIOEds?=
 =?us-ascii?Q?CxfrSauyF0e9DHT5aueLuJOZq/9sYjgiAD2qY+ej7nA2Kn5p1wkOIE3+oK6W?=
 =?us-ascii?Q?KXGnGTaBy1C+urvtAlshKhTGGVaiz9DkOVfEHaahRQ4nYQ438rkUQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB1415;6:vkTLqbS+1Kq0NeeW5htzQrCZokLeNq1pSSneVE6PUk8WjdHJ4TnPXeShGCv7RszQxt5TcPsffJ40Iir1Vb6TvL2MvCIJGrVs2KP+fGchwst1efJp+3fCg5EdRZDpKjoe/GzCciGdn+Dj4+mKlmYdH7oa48f7IwIJiei/2Zqwaq1Zk/ZAzOYNvGLCZoK79GaQw6utGLg0EPOiC9v0fgGRl6fBejHi6iOAL5o5hIdJzogoHNz10A5y7jPRupDBXEz7JZNnpF66p4CyFQw/Du3zRJZkUrNbr3aRKzQbA3lBRmf2BkpxcUSE1GQw0j/Q5/N41/smCXq/Lak63AyJnafQrfUOwRS33j3oJn6m2upkRKM=;5:hP6Q0KVk+2beMdBHUBcYEKnTuSxmCz4pUcglyLiVaaPJ0nURQuej/of0gDJNlXbUjF1HGy/egFFx65jqKXzl91Ncnpbbqayx2U3p6S+0awrZr2am4LDHevI+XaJtWjZHqM9maRlU3WOyp7uUeb2E/U6WlkTTB1QW7cbjc3Q6dBU=;24:sAV2f/5SVpsuo1eocg+PPT04NM3UGiSxFM6pd+BCWZ9wCZw2S6qTPAWGdD9FiY+uKYWmHI9Ab313ytRNUI6zXQAj1u6ylnA0YjX8At6+RGo=;7:7IDpa2NM87BAO72yYvzLUDmZGASkC9IqLgqp0dOpe5+v0HGDRJp08iJEdkqZMwnsU2NnU/lgvupmserFY8JQ7JrT2EXLnXIocTfs7ONzxbRP8uYsku9xzBOpA1MOX/Xw4HXLHMhZye2ho8vtdYqFB7+9ErzCprc0MG8AL43KDrY7m7LYzV/3f9+KJnstHphaOvHv6Nb9aiMbCaUT89kppCyXttqyKUfPi27mof+DWOdcYQ0K3gSjMeXm/BDGaDgf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 14:55:42.2361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29281e2-b0d4-4d8a-83bb-08d572f1dae3
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB1415
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend patch series.
See the original one from here:
[PATCH V3 00/10] clk: add imx7ulp clk support
https://lkml.org/lkml/2018/1/19/351
No function changes but remove the last one which is used for the test.
Rebased against clk-next branch.

This patch series intends to add imx7ulp clk support.

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

Note: this series only adds A7 clock domain support as M4 clock
domain will be handled by M4 seperately.

Change Log:
v2->v3:
 * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible racy
   Others no changes.

v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
 * use clk_hw apis to register clocks
 * use of_clk_add_hw_provider
 * split the clocks register process into two parts: early part for possible
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.


Dong Aisheng (9):
  clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
  clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
  clk: imx: add pllv4 support
  clk: imx: add pfdv2 support
  clk: imx: add composite clk support
  dt-bindings: clock: add imx7ulp clock binding doc
  clk: imx: make mux parent strings const
  clk: imx: implement new clk_hw based APIs
  clk: imx: add imx7ulp clk driver

 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++
 drivers/clk/clk-divider.c                          | 152 ++++++++++++++
 drivers/clk/clk-fractional-divider.c               |  10 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-composite.c                    |  90 ++++++++
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx7ulp.c                      | 232 +++++++++++++++++++++
 drivers/clk/imx/clk-pfdv2.c                        | 207 ++++++++++++++++++
 drivers/clk/imx/clk-pllv4.c                        | 188 +++++++++++++++++
 drivers/clk/imx/clk.c                              |  22 ++
 drivers/clk/imx/clk.h                              |  92 +++++++-
 include/dt-bindings/clock/imx7ulp-clock.h          | 108 ++++++++++
 include/linux/clk-provider.h                       |  17 ++
 14 files changed, 1180 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

-- 
2.7.4
