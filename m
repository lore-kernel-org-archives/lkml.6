Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966368AbeE2Tji (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:39:38 -0400
Received: from mail-ve1eur01on0055.outbound.protection.outlook.com ([104.47.1.55]:44901
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965980AbeE2Tjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:39:36 -0400
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/2] PCI: Initial imx7d pm support
Date: Tue, 29 May 2018 22:39:15 +0300
Message-Id: <cover.1527621510.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:203:91::23) To AM0PR04MB4289.eurprd04.prod.outlook.com
 (2603:10a6:208:67::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4289;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;3:M71WALi4kuiR7CTW4WwMn7uY85Jn5s6wj8qH0kT0JMTVZdXnN/ITPyUv8D5JNEsYQKK3EJbLnjRLiXMc9JbX2NtD/V80D1bnbzzQ4EwURw7OzurAvgfA44ZTsNc9FTS9jJS3Lt65rlTpaAn01xb8le27lAcJYVakLd7Bv4dHwJjorzYVQoV/Lx7JcMW62a2Bu7HtAQByF49rtoFPD3snVoAzA6o9PgtlcGMPMcdIVK1S/ETY1nJKmIAYIayCQlnS;25:2VI2OetTtXI5TJinSByNOpIwVbEw9TL2KOOEwlT4H0lsvhRa+gEf3lNRmVsamCfhYQyCb3WBBKVhmSyMpqssegPJev6xY24kDynPzOTjsyAoGytrgAGcKiVb9ZSw1hUa+5dO6n3l0sfpbXx/HNZ4fUxEwVKa9WaJJpaPKGDW1xnri3v67ho4OJ1dD0kjWt0DaYhPCJrjmTFVzgSHcWJJOAgWAW+GmTszsj0bKZvbCSSJbCncngVUENsRjt4g1SsFZzwadzfS88WeUK3ZYHpRRuHFM4Wno3ah9XpIPGVFRybxFfyinNQfn9j3xQogngImQpdR+TwdSkbgjrz+r6iE+A==;31:I+DKbw08VHuEcMOzz+ffANnHjYTqeOtD53H0WuohR9oaBUqa9v8qLj9pLDnH48yB64AGZlQ5eKbGlizN/4lTVAHmpuYgwdSdSOBmVoc5o0X5mfhbGIoB3J0kTXh7F3UsupM5qc1kHI4xAGD982K0FWkA+AQvI0x5Hca4dmp96CV+UbQgLy/LggHMn0m9bqd9VEz+h0XFtub40hbZ6eBZWiV7BByodIFLHFDRMZ6IQEM=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4289:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;20:s1HQyvKY8aep+A1qpZAPDbZtZsD1Rrv6ptkSCeFtNmzyhOEdOC1foO8dJlVkiJUThfYAbfjRTblE4g/Lgz3wgWvUGWASKPII6odMpSnBRyW/PfHGB87dKeNAfhFtg/pG3x0kMm8ncQZ14fkjE5+O4uur/XTgxAdrFTjztkI5oF2cFnWj6UAoXwJZM/9YSNwjnlfF61UhcjPiBy+5CrRo3TMb3Hac7pxneAfmwhlP3t+rscyxFHJ21sU4zjL3FHnWHZIGF+kf+6QrO5zgVx5e5XDNFr0GlEBtsjJAh/XRN3j7QgSfL8pVkqNHRudDbv9WpxoNwhcbw72RPdMU5FP1m5XMckCgK3q/yuJcu8JagrEUMKRgVgTJBlruP67aieyT0xSWuBW6D3+wLNXj2jJ65blr9XwW6FNXvqvCqBuW31YBe/wUj8zCOHMcBGE9JOrhbG7gOIoqSx0JHtxuLpkA1zwpRNiQLx36hTFrbggPeidhObA/4ctIUKPg/aEXwVC7;4:xFxq9ipKONW0XZ25u1RLgJlP4Sc2y6qNQkFwva6IgYMRxx+YDUFn0kGwjL1eQO1JEJO8zSCGbfaU5cVLS9ctQGDLu/ttK3hIx0qAVOvBWP3Z+9xTs3mlGKimnS0pgHoc+Cf+vGMP7/+RdUw5x+fgL8eeIvHOUEXPl9ozhq2vSxaMbR6ILkg+yV/dULcYBIcHvYm9S6tAuyTVNKBirCeZFkDiNDtMRBiVjt9YudpCFwX80aINsDRv/SLr6L0l14TBJ3PClw4xEPLDihdeN63Law==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4289FA677395EC183903029EEE6D0@AM0PR04MB4289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4289;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4289;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(2906002)(3846002)(50466002)(16586007)(48376002)(59450400001)(8676002)(81156014)(105586002)(106356001)(50226002)(476003)(6116002)(86362001)(81166006)(305945005)(7736002)(8936002)(44832011)(16526019)(186003)(66066001)(486006)(26005)(54906003)(36756003)(110136005)(6506007)(386003)(52116002)(47776003)(51416003)(316002)(4326008)(25786009)(6486002)(956004)(2616005)(6666003)(966005)(68736007)(53936002)(5660300001)(7416002)(39060400002)(6512007)(478600001)(97736004)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4289;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4289;23:uDvHy6iv/jKa2z5tUaFjBjlcuEgdGwx0PlRkDJDa4?=
 =?us-ascii?Q?ZtYpe50DW8kSsdNu76yN7JXCHxsBeS8yRH8vnP6RGn079OGldwPUZ5PgokFx?=
 =?us-ascii?Q?4hazjnxYOKTGPPucfflmtthHDKuRfHvLXIksKVLXmUocWPPZDc5+Jf8q6pbJ?=
 =?us-ascii?Q?btZUiOsKPytWOA7SpfycZwgxMIdfQWxYAIgMonm96AesSe9REXnPo9KL2GwU?=
 =?us-ascii?Q?zgVsoBitInNnH7I//hWFYPLZcWeYy//7iBD3I9NP3c8ecSX8Hvfur2mi7F+I?=
 =?us-ascii?Q?p/UgbrlgutJVOegcfP5G325ibci5ps3sLhe4C5eG1Tm3ZZEw15kd2/9bFPt1?=
 =?us-ascii?Q?3ahIOBiFYj8M/NeOOAp+6dKKAFJjHxHmsdKW5n8gaIqwfKQuzMm97f6z0+Bk?=
 =?us-ascii?Q?C3YDfb98cWryBJ2Aei483W1l3qeM4hHmMZKMUE69B+BbZm1ogKYwnN1dNHBb?=
 =?us-ascii?Q?9AgbieCgzhzQd5xFjk8d7sIMDUs5fQhitrU0lyD++9zKMT3N0y0xoJp7Md2x?=
 =?us-ascii?Q?UXAgtRM4jYMLyn8zZy7qLW8344SR0GH2mQFwZDUlozyTyUADQi/WW7xwZRDK?=
 =?us-ascii?Q?XsKHP1IaPKTw844wDagf5oxeIvgsZcoG+qoBz4MbRoSFi77aExFRForc1O9R?=
 =?us-ascii?Q?UKoYSwDT8OGuG7gXMdF6/oji248srhe+GsZ2uPdrPUqtD+aNs7wHI66eUR1x?=
 =?us-ascii?Q?v+PTWQmGmzcIuwQD6frqxKpKVuCR2H95dC+C8nfJ2nwaIIMSXB18NDNCw03f?=
 =?us-ascii?Q?MEwVWG+ry4z+GME8qHk42W3g9w1V46zacS2bmM7FqPOvSyfINsMI0cpVA2Bj?=
 =?us-ascii?Q?f2aIsWWtGXjo2VcAXGZqVIMjqZdvELKI6h8d8S5svG1inX7n3dtykdG43JfB?=
 =?us-ascii?Q?phzvi3QDfiNl851PXy7b6IMoWf4euSaX1yswwJbB2RTHN2tTmsxUSmcBCUiL?=
 =?us-ascii?Q?YQGdR2p86oSmWp2OC99pqId3HPw7z6FTMj/KLtdfsbnYCzDeyj2jSqSqbJd/?=
 =?us-ascii?Q?3aVUi020q+eZ++ibvG3+W542q8xNA7oFtlDc1ZBORJHq01GN9F8953Shq7KN?=
 =?us-ascii?Q?N32XJLqJVUg8a99HVIzMYZg2FnbNC36CPkUXODRaFW16osINumkuopsHnVe+?=
 =?us-ascii?Q?U00CPpEhEth0j9EUJN19etbAFha1mwNHzXgnX119VBZhYm88c9Hq3OgLF1c4?=
 =?us-ascii?Q?JhPDuR6OQpRMZzxNeHMNqctq0JZ9TnuvxWLqMbVyqI4zQ0FVEd01Gj5bdvzn?=
 =?us-ascii?Q?52Qz4+lcTBlfX+NXhudnX5IIssf0etYjJo7wWd6WPOzE3+Z4lCR7ld5EgZ5T?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: jL9URYPyR98n1aIHK1JlQXMz4Hml+rjaBG2ZCqYU6sJhEWneKSFHIGcfSDvtJBnP4FL1aWU5QhDVV/LNAHvOloETKn240ayf7LOIxYxgXavrybYM66s53I7hqENQnEf79XDCB5mAS1r1WL3+M32Nf3l74TJOPDK/h8lX09mfR78cxRUKmL03cWq8CBl1+G2t
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;6:9uZcamda0oiZHwuJC6m9MZb2XRtNGqM4Gaoh2skwy/72yTaEW1ODGCWJSym0xjTuUfhAYc6/QSQIeEslTEeHS0c34NYTQa147hule98TAuOPKbtDgbSFMaRqjLaew+ck9ywaFINqGcNz/HAgLeBhL8bYeqioFJTdmagy/l7ePp9gCOWm5mTq25MF+3wpgZkTRRk+2mXfKihr9zHqHqebn3l/bNMYC06739XQNmXF9UWLRFyUWh4BcltlfAbhbciuhjP0uvmwBlTghQpN0xkZfCF7hnlJEoTknYKQ8eRWbrxK6xXKa39ZEtMn1G7jVN6aADKd6RatebdPZkBSYc/9RxS9h1TQ5X7aVm4GqfHHt+zYViWvbv8vgMLICJPau3QqUtKvIGLU8zMMxt48yWlkVZhiSicf0l5aK2PZvLnH/2Hs0K/94HUpC0jLxgg4wbuAbkWjYcwIjHZ6un30hO5+gg==;5:40iSJWNYYNruGexQ+BEQT8wYFcSePDGI4iQfx6oflRTuGRb4bhbavLbGV22cWA0yPjYcUKpWhzPq8fWJoYIA/Tg8mW4XqrhfnRPcofRwfLd19hKePB6SEJ9vbnn1qtegfd4FXT5tLAivQuKt38OP1xBJFk5ul4LP77XepusCTQk=;24:UzXYlG/ftA4oDi8diqpqNmfZVTGh+OYiKLTlLBeALb3begRqUaC8U5BnFxKBMLb+0pwwGzYCbtFa3IoYWXQmwNT4AnNXrU4ac1NrUHex04c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;7:RF8jxh+a9LesBQThr9kqadXaWWSb5wyHH/Zp7ifHl3Kmc4MnAnGY3hyf1QGKo86rRLXhmrhIYbCOcy91RjD5xNCP1KfNV9wSxyAdScCTGR5wEAkcQaWvpZ+FvbSD7lsAPMTQHI6SC4uIWdY6FCGSbj2FlWlGrEb9XHBooLJkjHzAF2HuTc9t9I/hzgxORDa6DJfDA2BZ/Z9kZt5fQpBUd3AuYk322KyPbZE13MHZ5GXNyvvYIIG1EdupjeOREDmi
X-MS-Office365-Filtering-Correlation-Id: e0c507ab-ec0b-42f2-959f-08d5c59be747
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 19:39:32.6719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c507ab-ec0b-42f2-959f-08d5c59be747
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial pm support on imx7d so that after
suspend/resume lspci works again. This mostly copies the resume sequence
from the imx tree.

More can be done later to reduce power in suspend as well as adding
support for other socs.

This is motivated mostly by a desire to bring imx PM code closer to
upstream. It is possible that I am missing some things about how PM
should be done for pci host drivers, it would be great if you could
point me the right way.

It also relies on this bugfix for PGC offsets:
    https://lkml.org/lkml/2018/5/29/138
Without that patch resume hangs on first PCI read from PCI-PM core. It
is not strictly related to PCI but pci-imx6 is the only user of gpcv2
power domains.

Patch 1 in this series is also technically an unrelated bugfix, however
pci-imx6 is the only user.

Leonard Crestez (2):
  reset: imx7: Fix always writing bits as 0
  PCI: imx: Initial imx7d pm support

 drivers/pci/dwc/pci-imx6.c | 94 ++++++++++++++++++++++++++++++++++++--
 drivers/reset/reset-imx7.c |  2 +-
 2 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.17.0
