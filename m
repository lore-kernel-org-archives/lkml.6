Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeC1GrE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:47:04 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:31376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751182AbeC1GrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:47:02 -0400
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
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 0/4] Update imx7 clocks
Date: Wed, 28 Mar 2018 09:46:34 +0300
Message-Id: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::29) To AM4PR04MB2129.eurprd04.prod.outlook.com
 (2603:10a6:200:12::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80c90840-7d2b-44b8-b199-08d59477b3e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB2129;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;3:EvGn61HRASM5Xpsm+cUHCmd+Vo75VOu0RfH5exFVGornKj6ZyyTVHAHtpsGcT1I0B2y7WkQL0JCh/qHoHzTdpfgLym8wu2YfS/S7nS5P8L/AL23sITkYard96gFDxP8AqabEyo2i7RDYrSXb5XUwob6VHA5F588aJAZCLKUQYRrXknCwiSzxN+XcFu0UigcqkmyJmTG+H7tj3ugeTPsf7Dm3rM5+GJ6e36QkasVdR6GnmGn0Wx7FJuskhAYkYvV9;25:WJhklucJ33Xp47eT9lY9N+opUAefCmLBYcFEONZi3dfoJtSLaEK3DnhJGYoUxOlUeWxdaYReVX+SPHNauRIsnncvokAgL203fF6qQZPQA49ilQS6+r17yN0cH58yTQMP5BXAf2jk1y6xFgd7G+M6QPPm9VdkZN0GMCowC5u+Kud5LDABKCn2yN9+ur9JfPg58YS9+nR86/p7B8Ch84ZRR7dU+2pqkY3a73ZQDpq335ZLpbeBfwP+BBl67aFqBkwEWqnhQoEnNt+wTb2Ne0/OgsBbS0BgdFZaEu9xPtlkWDDpcgiASzPHfrvn6FjJq7RgELohMT4q+Ox4S/qGJ0s65A==;31:MlEVZsya3HbdvDywbdK4o9e87UA55Oe0rzFB4x+NsYskYxgJOPiyz9F0c6XI8YCpLXxOw5JrlH/CXz+bGVVnFNok6QhYqI9/WEcWYXZis2cIDtI03pdG9DDr3/qYfjgItvBGUSCA++iGVnuQLdJbOT3MPmV15pbDNjV0nt4sORTO9Sryzj2kV34rm9Cewx72FOSjHTRrxXrbEdRVDQcsCmJ3klzkr/Zyg0QQFvgKP6o=
X-MS-TrafficTypeDiagnostic: AM4PR04MB2129:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;20:S0Oj4cx7Fm3uE8gKQS8qeYBe+/3JS9FiR2BtyWnxCAOX+YQ0B2DYLc7ra8FWQX6jx4nJn+TTDCcwlYzbXFgmhQD2qD5uZr7I7JZ1lYohLLGeKgX3vLrqY1kKpDlSbb2hcqPiDxnDALzgQXS7THxoGdgB83ntburbxbXHQusr67Xr8yNoC36gIu0iFkWPsmZV0dZW6OmOGyh6MkrT4/B294d9FRMtLAx9cXFpJe9eugHsuVbiyku+T8ITJs7d88YYeyZ/ZYKM1ElXim/J9CtUL3JyHsVUAO4B78hjrzFw32s7AF9Xj1kVLyVnvhKl+Bux71LVkJ8qswRgHOjN2jWisZ9UU3sxIlvDxwXgKK7Bf/uYm5HlSJpk0ZTK4/DcglFfXiC/lqcR9x6+kqGT84EOpeVWqfOock5rGvUrXBvvfDSnofh/+J2L/VcC7pMz/x+XYFQDq3sZMe3gaVFU9AxI7vR2VHeBXDOYvy8IDMo6sJdxoCXVr3HeMftNRL+1/Y29;4:FNrUnaC0Pc3XSFWASw0r8Bok+4ehTvQ79Z7N32kKTs7BGnFyuuynx4jzdA8+yGyhz2s8hfS6YUWrpW7SrlxWX1O8mAdIBVyQDtwnrgBQFIoCJaKukQ66lkPM7icX35T5UPSmrUIdS3Bj1A4zo+XYMTxcQxpNGT2pQPJOhi9fVeKZFFTbaBZcm7v197uSxTW42r2cu27Btvp8AQQLlgrdiXgiEsgHkPDt+Nr73n0udGrYl9nLJyC9SST5PnWDJ72AjL6VqRu5mz9VGoKpz+r8AA==
X-Microsoft-Antispam-PRVS: <AM4PR04MB2129304340840031A55188CDF6A30@AM4PR04MB2129.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR04MB2129;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB2129;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(199004)(189003)(6636002)(47776003)(6666003)(186003)(6506007)(16526019)(386003)(48376002)(59450400001)(3846002)(51416003)(6116002)(6306002)(36756003)(26005)(6512007)(50466002)(54906003)(305945005)(106356001)(486005)(2616005)(50226002)(956004)(316002)(486005)(81166006)(478600001)(16586007)(105586002)(966005)(2906002)(81156014)(476003)(66066001)(8676002)(110136005)(6486002)(97736004)(53936002)(52116002)(86362001)(7736002)(4326008)(25786009)(5660300001)(8936002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB2129;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB2129;23:DZFW98gZDG3im6RMtJN64BeFq4066CRclVPEwJgTt?=
 =?us-ascii?Q?cEGXRPT9yK7+kFzNjXHw57ehoRNHTq4Zd/NNN88Y5z6rgO7KYNqsJ7SmOm8H?=
 =?us-ascii?Q?4k2xajZMSQXm8Vppj+gvEdP6lsM7wU0/058yIHOyvMjNw0idTSkosLmamA0M?=
 =?us-ascii?Q?c6esxqWu4u+txWyVauZXrlEhLJY3OhGsvFhlr7d0nH+5TvGc5PosP3GZ/QAs?=
 =?us-ascii?Q?5XQiSQM3uoRWR0EXVWLQ70Y7GgUXEM41gms69eY/3VG8EOV5CLSskskT6/P9?=
 =?us-ascii?Q?fW+b5lSOIsjOHH0Nyyf7Jrp9TjWHpwdhYvejkwl9HscaRMas/RkfzTavjxNp?=
 =?us-ascii?Q?JZEc5WTb6O3QI1YpHsi60LRHckIPxP0i/ZG6EraG06VSx027gbv0V88gyiMn?=
 =?us-ascii?Q?iaV90jyhm+Y/8/QO6L/fOgoiY4p91J2iEgkp9mqTjKbrCyES+UbvutVkMqvC?=
 =?us-ascii?Q?D43/KASVZ8A0WqfasZile80PB3O9Y9QoBCJwGjnIfCG4kgGnPKHpc68ggqdY?=
 =?us-ascii?Q?XGq4FEeoLN5ir6iTu1jMlCGKH8PFXQJ8kEsm4aRNYx+kcRWsycI/j+2t9rmX?=
 =?us-ascii?Q?2+IbhuWsuNgKOPslF7jhL9LPo4CGrVUJIobDMXAg+kFZ+apT482drrROBzJp?=
 =?us-ascii?Q?pwg7hL033w+UvfWvOtb0hOZ516g3x4lp3i6T1k9dRMxdmUhJp2/hmOCHGnWV?=
 =?us-ascii?Q?jeIZdvcxnvh7sVNmDSbPTJCPSlQoyERUXOvzULKP4SuKXTEUvpLOu6+V5Mw2?=
 =?us-ascii?Q?scpEM1GhcP03NdTHbSxtktMfpRG6JzXhcISot3VxYmO0C6Dag2eczqpuCewL?=
 =?us-ascii?Q?vm8OobiqqmqAJAWyDXW4Bg9rdbOL5NElBZ4yznIbYXxwXC/W5omcQtUbNC/T?=
 =?us-ascii?Q?APDDxPAb4ZhZ/Fw3/5ocmj+6HcdIoXgSH18WoRthEkbaP2k4pHLldMWu9Qj/?=
 =?us-ascii?Q?G1Ng2KDK1OJ43LTfRiJ34EQjAD69XMC0t3bUvUsVl46V2oBqweNDoVr2pC8m?=
 =?us-ascii?Q?zTVQGa4Jicf2M2RENR+O5oXuBm4595p9jvovSjdwilsS9Mr82OPHOYikVj6b?=
 =?us-ascii?Q?w/24KcHjX4+jSKWZHW+ktrQcLq3Cis3H1cHpOjYaXy2+pNN2yhjFHGYrp1YP?=
 =?us-ascii?Q?riWrOXSh7JDtviBcvtr7VvW6JlSbhaYayz4Ce5xOZDpsxPejdzqL+WiPWvfi?=
 =?us-ascii?Q?mCzCE7uvMnJX4GTnhrYqBzK3TeVR7B4bOgynS/SSrKqCj3fbf/hktT/rPR5+?=
 =?us-ascii?Q?Y0z87DfpFWIfv5TNto=3D?=
X-Microsoft-Antispam-Message-Info: ggC420Jj1zAi1UWuY8whEDmF7cDZsHkAC45VAZqmXy/tj1kxaqQU4E7r6EA9+cyWAo8g7pAKPdMGaKQ5CT1OXwwl7QGvKqWY3t5n0/Jr5J0R2ZrTisu46dZEkOS5brxBZ+wBJ8XJ71gjieePEqmmXrjt9qOHdq3+xwVK62yvacHf9rzhtvj+8SQbA3pqIIhY
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;6:aEtrNA3uOSNLtOjeLxM9N56Jhk9ExnhRBGLpJkVGb1/rKsiQ3umGeVpm/gmmsbnjTnjb3i+yUYBBqWHyoSKt/cTC5wrTn7O705hOiTcITRAhiRUOMMikX3dgnVVBbE1ucJl9tHkUn7eV5DZinWjswfLkZyuo5vMn3B64uGLttPv6lnGdBfjDdLF3ghJthgq6UCA7hnR/vsy7N1PW7X1O2Ni1YIOmDH/PCPQV8vHV/qDSWFEm6O7Efoh4oZlp2LZVC9lK+jJtOrGFIl5eiWxW5Z/BNFX+IMPBXjYD6c4PZgKU8y+H4m6Gh48bbXunaq+izJ8Dg6MnbGtl7PRXwa/+P1U9i5TacAaRQzA4EPoldDX/IrxkoC3Htk0Ka9q18BBXfsw6kwVZNecH3QsV+FbM9Ph+6GrmBqzXxST0a61DcPn5E7Hut44McDi1FPpWpP6IZW+1nNCdBxcQTeItc4QeFQ==;5:zuJLiEAa3rviQFeiT8LNB53lDHD01R1IYkBopnq6m9ID/yvSRwS6OXjE17NmDA0vzh2RtFj8KPogDMcx3QcGCsicUTHcE8Dc5ksabS6mbVNGb5JaMGZ6jLW1O7Y42ZiP9SrfCrVN2uqK6xbVNJZjg1WxUxF8aWX7sift7x/Lp6c=;24:b3N1+Gfa01toRsgEgNhlD4LyB1beSVhJkfz4kGTjAzw7bNab6SaFQiRnvH3QVbwOGGH8WXkTamHYR3lIH1YO5cVbIfQeF9lBouCQ9IxtNO8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB2129;7:tjlqhiYHuvWIVL4J0aG1/p5aVIALRqeB+xEq/ibichPSNpmjlocJyYcUsN9cJEn8tUeWoirF0up5RVIuVLxda03PzqSqz9LFFQmN5lSXAnNqM6zPw7uzTOUtif7vqS1Bzk3W82fsw40yOOpaUApfWyQtYreIQ4GAkb8rW6hOyVxMUscGBOfZycwRwPst/+/hqPcS2nA4Fiyil2wZlgMTCmR2Rp7Stmhk8MJ4T7R+0heshhhyAvOKP4OU9Xy5P+H6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 06:46:57.5395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c90840-7d2b-44b8-b199-08d59477b3e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB2129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resent as a patcheset now.

I sent the initial patches as individual ones,
without specifying the order they need to be applied in.

https://lkml.org/lkml/2018/3/27/535
https://lkml.org/lkml/2018/3/27/536
https://lkml.org/lkml/2018/3/27/539
https://lkml.org/lkml/2018/3/27/542


Anson Huang (2):
  clk: imx7d: Correct dram pll type
  clk: imx7d: Correct ahb clk parent select

Dong Aisheng (1):
  clk: imx7d: Move clks_init_on before any clock operations

Peter Chen (1):
  clk: imx7d: Add USB clock information

 drivers/clk/imx/clk-imx7d.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.7.4
