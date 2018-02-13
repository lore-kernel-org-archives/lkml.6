Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965393AbeBMRzu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:55:50 -0500
Received: from mail-co1nam03on0067.outbound.protection.outlook.com ([104.47.40.67]:64108
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965168AbeBMRzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:55:45 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        <fabio.estevam@nxp.com>, <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <wakasugi.jb@om.asahi-kasei.co.jp>,
        <shengjiu.wang@nxp.com>, <daniel.baluta@nxp.com>,
        <mihai.serban@gmail.com>, <cosmin.samoila@nxp.com>,
        <linux-imx@nxp.com>, <daniel.baluta@gmail.com>
Subject: [PATCH v4 0/2] Add support for AK5558 ADC
Date: Tue, 13 Feb 2018 16:29:32 +0200
Message-ID: <1518532174-11350-1-git-send-email-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630181432949918;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(39380400002)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(50226002)(8936002)(2906002)(81166006)(59450400001)(8676002)(81156014)(956003)(47776003)(26005)(450100002)(51416003)(106466001)(4326008)(336011)(26826003)(97736004)(305945005)(104016004)(85426001)(16586007)(107886003)(316002)(105606002)(86362001)(53936002)(2201001)(356003)(68736007)(36756003)(5660300001)(50466002)(48376002)(54906003)(110136005)(6666003)(498600001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR03MB1418;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD009;1:G8LZ79jT0uVlnnvf0kutiLDxaT5yDB2muW2aYf4WR/VWNdvWF/pxv0zgTn/89InjRZWHu/H8QTwaJnSMx1tYEIp7O+NXlM7gW6AgyzAJoJGBQKWC1Dhn6m7uLkK8eRTy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1656de-9b18-453c-f18e-08d5730b006b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BY1PR03MB1418;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;3:imLPEmwGUoeUky7tC4+acwuNVOaC8bbHlUS2xnFhwG1Uh3J261UkQKY/nfBVImdQBthxeFD/8JJTiTPUEhPe6Qj6Qow2gNKZFyFe7XM2yMz9+ck4lepdt+ATUwW4bYWgHFNmiW8+uAWNtUDItfogMqlWlIFqP//GrD7tOp4UvWWa+a0jgp0ROr0n7iOp1fehGwczmk56tl4s+87nPkzQv4aVd+15BI+3NF8ZALKjr9g9mOsNbFjx80WoJW/o9tOqf2RiSCsxYNjPFIBtPflxvpyIy4Ymf07ouEo/xRk0kte9jLt1k0d6dQW62vB3asTZ2J5Qt6X3wT4VrGIRUZlYzKGSrSWAC48LvsC1LPzj6V8=;25:MYyM2bemO5dzF3fJdWngyt83yuEIwnYL9zglIVDcKCupM700EMqp1QPf6MF/+M9vjZTW2Ub3vKcgaeumd1t2j10mENiJozkRxUewxVhMr7mB8oyJcSgXa+YOp1D77kEUum6XaWSX2v1VSaFdEW2LLBlSWpzYQApopSacH0WZLwoA4JF/NoAPYh4vD/FDFsloL6Tv2XD9T/yxUpix8ms/+ve7k78fGRMu4Q0w2JxJI9dDT1VNb6SS2fUqhdEQNumRkLVLgBUL/XDetj2jBITFGsHfdEheX80SRPOG3QpFRO1NyarikNHbqr7+mQPWpbhlO5HiBMDhpvbTTB45OQEYzw==
X-MS-TrafficTypeDiagnostic: BY1PR03MB1418:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;31:37DND+fw6si6+W4+53Q5zMeseEf+MnsOTotKIdnTUbB+wL45viwPmvmm6emTupqw/FXUqm4xB8yZrVc0bQ8+1zf35JyLC6WiFY2WPjIrr+hDQ/H8kewNruPH6guRs1sT2eVtwPAlTN6yVLigcXi3hWOGbWEVApfAaDRnYULbjyCZlpWqtJG6UuaT+4If6BaWI2KzLkTLvBv3SiozBy6IQvsFVmgXARb9fH6tXQ2O4jM=;4:a9iRz2IEEsRpAeLxUYwFRCygr+RlDA59nO9/nvw4pCE3S7s4fWG9Hxs9CZvhGndqGQeBlnQuzqiDC9HLCjNF5K3goZpt2513EAQ9Ho1OiJeL0X3ISVGNlO4VMF0NU1hn0gXGvBK0P4Hn2o+hjfUeW14VxJ4t1bPuRIUHbzLx10uOU1QvSBMcZhJ/dkOkLKlhqJCpPCDYPMApP9JD9U6T5N00eyI8tRTyig+JzJxpmA+qwb+x16LhNjRkCWlBoWGcdQRojbtiX9rmPGfphBAvAQ==
X-Microsoft-Antispam-PRVS: <BY1PR03MB141873248F2FE98E6B87CA2EF9F60@BY1PR03MB1418.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(944501161)(6055026)(6096035)(20161123561025)(20161123556025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123559100)(201708071742011);SRVR:BY1PR03MB1418;BCL:0;PCL:0;RULEID:(400006);SRVR:BY1PR03MB1418;
X-Forefront-PRVS: 0582641F53
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR03MB1418;23:IwnLdsgMU5hJqTF+0dZEOFtd7Is+PdhUxx8iHZfVI?=
 =?us-ascii?Q?F6W+Te2MWTKJspK8rPogtSelV7+GCxscjE/88M+llZ638WLlpohkeWtCu9O5?=
 =?us-ascii?Q?Xs9cW9J6nQ6UQe2LDxYg0YjQm8gZofFWUbv2ZmVqrSUVcGv+NIeslhLLcITJ?=
 =?us-ascii?Q?mysK/cyzD0xG06rCmzZb9LHl+jSITokzL9Mv6n/UgDHdB7QlRP4THTOr02le?=
 =?us-ascii?Q?I0QIymm+PGuWeOKfdF3RAYn9pOEN7v4QLp0wo4zq7iCPmJOwislkBqC/T87b?=
 =?us-ascii?Q?CxTsOU4dn5GtCckADcfZnuAxSlmCVSVAZkrp6S4m91VxMKWOEynCr+pItj75?=
 =?us-ascii?Q?9hkXr3eR3VQOcTqUrWBNxI8qOR+haZJ8TKoklce0X2QhuL129Cv9TheQB563?=
 =?us-ascii?Q?i7GX/mdRjzZPYgw88Qzf98j1OGlltbF0MsDnegFlhXOT8TWNznUFw65zxwrx?=
 =?us-ascii?Q?dN7G68pt2gE+gqrKwbP3m0ioug+B2fEFR0zb072GYn8Pb/q/Qh7/fmxSDLhG?=
 =?us-ascii?Q?ONiAH7AwgTPyoYjFuh5yZTti33omM2nasMkzcweyLIc99W0okRNiYgFj8/9W?=
 =?us-ascii?Q?9u6oJFOr+73sqOdRBfefBF2PkFloOm1evybMUyDfYLUuCwN//WVlxAAeOup7?=
 =?us-ascii?Q?pqBOtLN/tr+V/HTzazmsm2ty2UpulgIXYONuDCX4imwAkHHq8yyQ1ev21WLb?=
 =?us-ascii?Q?eKObS/hE5MfLQlQ4sDLBiFHO1nEPnvy2LlIetbXSSqiHmUQRoysXCCkV7li7?=
 =?us-ascii?Q?ykJ89Eu11dh8LYeBwLCMv6esCNqfKUUmF630d67RMpyKS6r53x/zMaif/K4+?=
 =?us-ascii?Q?vZKo/80nVx6B4sX34h5vRb71MC1f+a+K4j2FKVvCq2fqjw7jSrc0HIOlANvg?=
 =?us-ascii?Q?lkwWNLaVTuUSTKKvajr4Q3eyIPvWPJUYDC4EhyD26OzpTCkzlqoAh1zgT+h5?=
 =?us-ascii?Q?SN1lMoT+cHjDD3aNU5xbI2as9pLMdiSAmzQgpcLsqZHBFQc8zoUmrZ28DFWN?=
 =?us-ascii?Q?0vpqWYYvezlgL8bgW1Z/g7FOd0sxZ8ytNIKgD+h3mi4hKCcfkMhROOJEUVEh?=
 =?us-ascii?Q?b7JSRBLuPlwi8SHvpJ8SNcr+d6PZmmc/wG1NeG2P3pl8Sfi7qU6lzpCblBYE?=
 =?us-ascii?Q?YpoqNMmkbazuWoq0jykfBkYNnEFp23u?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR03MB1418;6:eLnDXrUvr37jlMavAFPyJo/V0bqlzE/9D4hcWjQNxvlsdNdwuBf23zV6hUUlMbbQ+pr32r75l1D1zlO9/b3rzV1Pfo/XzxY7750l9hMJpTKPxv78eB2OMR/oGD2YoZiCBh/SPnvWhDfFipAhPKB92tOyVcGgkhxYrg/oj48UiDXq6Dl1zxYWWN0WbG+VYeuvBZHGehKxHIS6MvQZNJNzc1Z8OwKviNeyLGgRnFpHhBc/IrI1x+JV/u+aJsndbEtUeVJ3vXjGKa2s/EoVFZwK7tU2KmiITiiO4HYFv8EkG2CqPvsDeq3PTvkTp5QIw6vQBgFUqMT7WGjankumGAgGsyYTBb8NKQCEgLNEweSOb50=;5:by1r0icw2b7V1HlOxkmoAGxz2YiAnbKPV0mrh0BS864N8KXvn18M94rbD39loO3RQ6NHqbvVae9Hz6jDOBycsQmYxos0U0tyPpSVkJKjVqO5jghENYdywUPlmGc6Mg7Y7ZAzMwsL1xu9PPF/nAqnI4102O4FN6/j1KkPugCuO7s=;24:4Jhn2fjgJbPwh5m7KPiNeeFoQbMPqdFLISGo9SlSYj6MiBrDkylCYxk9qfrAijJx928m+FXzxQtpGhCFU2wEAl9w8ALJ/8FjHdDl4h+Kruw=;7:SxycYgr04a1peCzgI8zwiBgPaibtk64AusX1nUladXILWmITRJW7i//2zt6Iqi2laiA92tsBsvaJ3D99vFP4N14MTid5Pqp/2yylcUsLrl/c02rOKf3SIKYXtFxsIRxZQgUfzgoWFso+yhnCZNJVaZtspkJA7XBv9dtETlJe8WBu8CGVyho0zeQYJoNK4v1iNeJTzGEyVWqHnVF10e3PCJPaWl3zcYLmrW35ywnIqv1DG9DO9let0BveJGgS4gt/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 17:55:42.9829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1656de-9b18-453c-f18e-08d5730b006b
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB1418
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support normal mode, TDM mode and pm.

Changes since v3: [addressed Mark's comments]
* use C++ comments for SPDX identifier
* removed some unused widgets and controls  (channel enable MUXes, TDM, DSD related stuff)
* removed set_dai_mute, set_bias_level, set_dai_sysclk as they are not used.
* refactored probe/remove to have symmetric operations
* use snd_soc_update_bits instead of hardcode read/write operation.

Changes since v2: [addressed comments from Andy, Fabio and Rob]
* sort include files
* use probe_new
* reword the binding document
* use adc@10 instead of ak5558@10
* remove file name at the beginning of codec source code.
* make i2c_probe and i2c_remove parameters naming consistent.

Changes since v1: [addressed comments from Andy and Fabio]
 * fix GPIO polarity from active high to active low for correct documentation
 * fix license header by using SPDX identifier
 * remove debug prints at the beginning of functions.
 * only support auto clock switching (manual switching was dead code anyway) (in the
   future we could add a DT property to choose between manual and auto)
 * Use gpiod API
 * use GENMASK
 * introduce power_off/power_on


Daniel Baluta (2):
  ASoC: codecs: Add support for AK5558 ADC driver
  ASoC: ak5558: Add bindings for AK5558 ADC

 Documentation/devicetree/bindings/sound/ak5558.txt |  22 ++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak5558.c                          | 417 +++++++++++++++++++++
 sound/soc/codecs/ak5558.h                          |  52 +++
 5 files changed, 499 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
 create mode 100644 sound/soc/codecs/ak5558.c
 create mode 100644 sound/soc/codecs/ak5558.h

-- 
2.7.4
