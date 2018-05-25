Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964882AbeEYHvh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:51:37 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:35200
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935866AbeEYHvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:51:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Date: Fri, 25 May 2018 15:51:02 +0800
Message-Id: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To AM0PR04MB4210.eurprd04.prod.outlook.com
 (2603:10a6:208:66::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;3:lhyoXQBLeXCMn9yJ4KRbaKsNnQ4Vaeey6RE9bFdxZI0/35P1/SRSF5lkmAnmQY2ukJA94nYlB7zWajGQZB9x5oADlcXZg9SYTJoXZQbnkfjn3PW8GYpk9hQJ5B4yDSf5NVDGE5fNQfhsulhcQjh03vYXvxEZXTtwtvWqKTXI8SieANuSXsBoQ9CscIWklUqUFsBA54pOlhj30v5eUfrXOVjpE2t58b+rMAqD0q80DoQlCGgtjMbg60g5dV+hQXBP;25:0ZvyLcdlMBxZwk95iJ9cYm7klpjsE7lLRbVrmBVOq9CfgWC9GSk2/YwXzec7b/3eBjM1EXBLNHCmD+/HPdpoiUDwbEC5Uu2NtQ06C50MRhXrWP2mWbXiwMpvqUFsgeT/sZlbVAGqJFxgdrTF0iQPMjY8y5aKgom0AbASVKI6oD6R8C77GmRgRJ6yYkzdvCKVV++i9M0dMJfkeKZcANrMk+8abBx6NAna/CpDvYUXHcLIJ/Cc/QvvUgjsj/mH40Coz3bVAzqB565GpDMg06pSXMI7V+PoX7pXY/KymoZ6yoF4qNki/NI0v0AMPlLuUMnPh+pjPsJNPG2/tANt3lfi1w==;31:cs+CVVlee70j+aq9OcEHjZk+ys+R5ZA7DaRLMkQxDsHIfLLcBoD04McNaGdxOSMvg272MUQDkEM60xF8/vJUx/YF6MTj5dRvitNCYJMj/KBKjcsHBDHah0kA7nkP2zetorElkkS1VnupyyxdsvX6dMQhMcnQzE0+0XXx7Lyf2AFqswyt6mXVKkvE1JElzTupqnkxzytx6+LLARMT+OQKi85WI9ipmBraCofWdg02L54=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4210:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;20:jZL0KQbvt7LcyOq4rAN0H/azoZUy6MGmUVuqI/xdR6JMhQEHF9gKtbdvdUDItLdkHwRdindKX9/aTVKQAEkXDCmcS0XDExk2m7aANVux0JRdrGVxMYpBV8MoKDMdpMozvndQoVUmzbVjYXOLN0h5fMHr5khtU5NXluxY07b+HZmCTIUmQQdSj74NgH9mzSrHrJiQYF2ld20oeDmrg8v16+bMtlSGwrJEYPTD5s+74coYr7+xrXzSOGXlL7x7JcOOLj5pFAQRszO6YlNh2xfRCHmVyZoOn9d49geO8TKWN44v5LVOdJ8B+SpOIidPj1n5qBnc+75VV2HwbQf9mpS+8dR7RFdQQekKnK2F3W9SyRYh2g1wqVlJ1K1BsoVJczscY+Zqiu9pJQ51TlyF6ErjKxtJCCZYnexR6esuPXku1ZRGj55rWbFv5puWsfXrhXzfMbE6qYFT7+DpIaOCEf482tZENLO6geWPkhiUbrAgoiYib6paY1X7jtCn9rnm4gXJ;4:0VDNQhZaNdLcLY7+yGx1fOgyg5VnSJ1PIV+wsiFh9wN1bqNYBqXAZ6xYUYM3LUAQVzXyLT/IHS4aOgYwD5GaWCUnK6QF2fCb9BIjZJOSa88/oMyzSvIEYX0y3DD/IAmO+u+OwKFhZcQY+91fDpHQtMjLR5FRe2zpIFkWK5o7gw6cJHPNdkcNG8MGJveH47emd2tj5lnh/inAxnK68Pr5yQ8ox/Ou2rQHDdrBMCK1BG2C1GR1nbZHJHnuQfUvrZTvjnyMRuq2bOOWWrdJCYYyfQ==
X-Microsoft-Antispam-PRVS: <AM0PR04MB42105A2B91F805938B43844080690@AM0PR04MB4210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(199004)(189003)(54534003)(8936002)(6486002)(50226002)(478600001)(2361001)(3846002)(6116002)(53936002)(2906002)(66066001)(966005)(6666003)(52116002)(68736007)(51416003)(47776003)(6506007)(386003)(6306002)(6512007)(81166006)(81156014)(8676002)(25786009)(4326008)(6916009)(956004)(16586007)(7736002)(305945005)(50466002)(105586002)(106356001)(48376002)(86362001)(5660300001)(36756003)(2351001)(97736004)(476003)(26005)(486006)(186003)(16526019)(316002)(2616005)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4210;23:kySVQxB8kKn0vbOTfJuV5J4YYaDHkal+nz+7fzuHr?=
 =?us-ascii?Q?TVrNQyWUPES4iqrwCBgSvWp2eXPWdX0zmRBVVuewuLausxLN5VD/GoFVch0F?=
 =?us-ascii?Q?C0WUqNW99+Y3CtvEvA5L2haZqMUdpWoK2vOK8YMap8km3wfH3AiX6BjB4B7r?=
 =?us-ascii?Q?njoe1EdcIN2SEecuauiCQM/ZgbOHLvRN7z2PdFpGlsNlYJD1uRi6rhFNp5Bp?=
 =?us-ascii?Q?FE8nqGU27YkgCRPcuaHnhmO5bwSQxT9UlCJG10LSRUymE0yeyz3XUAKuSl3K?=
 =?us-ascii?Q?/g2RUeAGw8UX/K3rcjBN5r0ZTLeXm250ORzs3EMIvCFlH5q6S8EMmN01ks8E?=
 =?us-ascii?Q?xy+U6b4iH0bYgRHdmsWGiq5kc9v2QB/80BXpHbs/FLX1dDXQJe32cFkZm0NX?=
 =?us-ascii?Q?j8SZ6KkNMyrbRhiRQ0PvLr776lUsXUJCFSzDUAwAPkOPgfeLewSn8cY6Ogwe?=
 =?us-ascii?Q?uXSOXOmbftRHIX3OEWyDhLLdLWlP7itnhXodnzdJ5hLAAb5qJ1mJf8pRnjrf?=
 =?us-ascii?Q?ds5iONJLR25ZklHQM/wFCtl0S6fuu7/wMfv92Dnd18/0h9p50tEL/caLKjsL?=
 =?us-ascii?Q?qvfg/U8JIxZe4t2Pwe4CzGpY0nMKQy02vLDk2riZ5DeTtB25KCdXYt5L6tjg?=
 =?us-ascii?Q?dZ52AsYjRcbG583GmJGKLN9XFJVGjrSTqdN6JocJnTRvsSN+TQDu9OKgxBhg?=
 =?us-ascii?Q?xCISeGGgGaGNHrXACUduNlGBkHxU6LeGdg6va2h1NHv5gtOJ0GAc9PvIx/K+?=
 =?us-ascii?Q?IwozWSpr/SSxZM8wcIVygyk+ufAQSAJqITqMkPd5bl4eyy1kJ2UdU4l/8iSC?=
 =?us-ascii?Q?r4chZanwcQ988i7ME/58uT0C9RK1+lv+KnjfJmWSvZxfm1MB1uEWZkZP6I9a?=
 =?us-ascii?Q?vfQk34cQA5RTqk/3x+7Fp/JIl1WDJULjeUvlUHyDtZARXnOCKZ3WsDXNHfZ8?=
 =?us-ascii?Q?qDmD+ags3AwHXi0sIPI7g3iYJnGL7evAOwF24bbKRDq5MS7xayNKen4C8evF?=
 =?us-ascii?Q?6zRh++jOyTsmLYwsGQM+enyg7MZptOo4XJoR9vbxYSMR/JW7Kc0sruuQ26BP?=
 =?us-ascii?Q?2nVC9OZd2et3bOweHCKfc/VXbF4GaUVyhOWY7uxWSjLjAO9WnG2gqzah15B0?=
 =?us-ascii?Q?lhmF1EicpwkkvFrVuiCFhpFxtb88JQdUMFZ7F15/adl/7bsnHVkdbAUrxB11?=
 =?us-ascii?Q?Qb5vNaUFciNkb7eDF4y7kMOcha6GndK4l+SOYT9Di/X2P7Co8IJaDQTqw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: wuTvOMGQe9X3HFQee6AsF3bHgt0XYmrPukJHIku8RvlHncNNxfech2+nmmuibmHv1Sr6/umIdMUfqVFWu1LiAs5JCRat0FYQjeM11d2wLT+jzNyZHXosykH2CvncbtuiDYVrFevwNcr1RKWcTE9TO2boSuGFPe974T8Z7PwpZ3bJETmfgTy9ihRGqfF95z9v
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;6:DGzgDwKxJ8S+TRCCjeZo7bzSateYsstIH/xiCDw0fSk4HQtMncU8uwA73MQtatioHkEdzyKDqTbPhf9tBTxW60fGC9QaraIKcpEEJ8WVC25UMugvSEnHrfdN69GeR/ftiDY0urxcJTb77PHr3sUPFI7IEseX0+4S48AOyHYeG8wd+zHV2bFRnj+cWq9nPm61lartaMVcvoImtG3zrXosRepR9kO0vrToHk6TEqipnAbwv4AgrGbC6a/OtYSDreCXiqoZZuBSjIANzuWT8vl7fx2R4onz5oYaJy31vpAb1+iNe1tD4leRK8iy3/MgbBvqwF4q6TTJ7rrhW5DSlo5vVU9gDuNDIxvTiMXcYi7Z1Gi+Zf9xaFyA1Pe2Z4pItPClvE9oC4KSy0sgkWejQ5JRCBuYOPZXAMJy+dJmAX7w92bbYM5AY6tczBLq8Al6ZCH/apjUc54W36b9T9omIqxQGQ==;5:Am3wtz+756ArtAXgYFhzEMTjteqLIq3HlbX93gMRgSTsMPpYIUaqHAKgLdQ1CiBr9C05j1iEAUrAG4YMUuEzfNi79OFg/VJbrC8uS5e+P9Rct8NqJnYKYh3rTOY4ioOK3jwrK7mrMuHTXBYJwOh3Kns1rC6icaoepgV3vFOmEC4=;24:8CAdaCi7AmkC2kRdEq38JdzYyN69ptPcllbDBR/IQQ2iVU3jh1bpNa45nbHsHPtAoU0luh35YGR/R3b4qyV+tau3jKoU2xQtFU74USqPMS4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4210;7:1tMUKQqg5gSL8+G6U+fCjbi0boiwK0S3VLsHWVPlzhBt+k9qpn4+kHyMDyajH6qIMI5iA6NwFDKV1NEGl3u2xd1uuzP8aeNWcK6LJ7nl6YepDyBa85U4cut1ibL7axr0iFz+XJf0A6VU0lp+GcScy1tAW83yG8Q3FaIa7CFeKLREp2JjT3OfONwSX4lLNBd9SJFQHK1Y95lRKgcuQWsxq+y3mAE5J/fNrxJu0TAroOuMv2RXUCRNxg/R6xmWFmOO
X-MS-Office365-Filtering-Correlation-Id: f690aadd-26a7-4a81-ed42-08d5c2145515
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:51:29.3464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f690aadd-26a7-4a81-ed42-08d5c2145515
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebased version of below patch series against latest clk tree.
[PATCH RESEND V3 0/9] clk: add imx7ulp clk support
https://lkml.org/lkml/2018/3/16/310

It only updates the license to SPDX format as well as a minor fix of
pllv4.

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
 drivers/clk/imx/clk-composite.c                    |  85 ++++++++
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx7ulp.c                      | 227 +++++++++++++++++++++
 drivers/clk/imx/clk-pfdv2.c                        | 201 ++++++++++++++++++
 drivers/clk/imx/clk-pllv4.c                        | 182 +++++++++++++++++
 drivers/clk/imx/clk.c                              |  22 ++
 drivers/clk/imx/clk.h                              |  92 ++++++++-
 include/dt-bindings/clock/imx7ulp-clock.h          | 105 ++++++++++
 include/linux/clk-provider.h                       |  17 ++
 14 files changed, 1155 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

-- 
2.7.4
