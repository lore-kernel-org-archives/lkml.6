Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeBSQLL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:11:11 -0500
Received: from mail-ve1eur01on0075.outbound.protection.outlook.com ([104.47.1.75]:11653
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752690AbeBSQLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:11:08 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH net-next 0/4] DPAA Ethernet fixes
Date: Mon, 19 Feb 2018 10:10:40 -0600
Message-Id: <20180219161044.30279-1-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:301:39::33) To VI1PR04MB3278.eurprd04.prod.outlook.com
 (2603:10a6:802:f::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 430c32d6-5bf5-4435-b29a-08d577b36169
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB3278;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;3:LxV38OAoYtCwhG/moEPGjvaiYCFf5SJhjKjIqPj03rZ43ZqGFAjJI7bb5ctyHzE/4Ywppe1CcwgH39E/KgMMaMqaeWeHi+tQnGq3zWGCz8vEKMLGZc+tNjMPS4hgFHC9HTumbsc76FhNQW1L2xtFXNYZmEjwJlLEEszAIZKr0QPc4B7VulHwxcRMdYfvAwW0qerDY30DePeS83dWso+bt0UJgzBkswJHiUX1Nz1qF7qzV8w+Ou++4bV5H4kbFY57;25:BCpqyRD6ZAoDiRj+2jiUVvfJq7LEqTtXBGttmlavHwpG37CB2JqFn4x9JNS1pthB58OVWxDiybAI1zWEbamtyp8uJyNMzUCjNBMKde61vYCkjods4ufCNxwB0EfoJ1QRQd026EiIMr6hONLpLRNPgJkmDvOy5F6sXsQlx2XhXU9iEPWkV3VDwMLumNOoE6hcgBc+YMc8vOfJZ5CxXldw3mLUKX32kDsRjn3mv0O62OAL7Bocyq2IvcRxMfY+kz2RuMRdaWPej9e1jsQJAPDXgHEfPg/Kzxhyjy/0nRI74W1GExvVGGaTKJ1hrsoj277X+2v9qERblG1SfRWEWcZ3WA==;31:AQeIcbmfMELx6ekgb8xbNlDrdzedaQaf+udyCvW52gonw4ZD2AXizgwajDArVsRl79fP2rayv2ntSatBB5M6iER2JnUwxxaNmhdRKH5/yQCcIOhJ3KbsuMeSkedMFXmQ7pol2lBx8hs5rMXytbngCkL2d0kI9/4IJjL0GQmEwIpcKbWW5evFjs3agFzwOsOIYzZCSWJiKXLaWIPCm8lGFCsLsUnfkH5mTAzDmriez0c=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3278:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;20:T94d4OysMW43qeYxNEqJ5MN+eLllxSBasZjg2vP56vuZm+CJPcQxzkXveGiKHmCdroptrq8gw2BRS8zwMgM3JA+jnIbYimI8RkshQb56WvbyMLgmhl3kSYg4jvCae+nQT3SnEPocOHUZMBx+5NAh/2nzj7NCIxXhKQFwxLhPOUz5P/0Lups9X09InXQDRnUpj5jar9A/YNe4G6tWJ4f6oB7Y1rZM9FFGOTAIv66cIHyl2N9joXaUUP7QZ4Q5GLK4Am1pZl8+7YKHeJfb/nHKy+IqHvVFZaE0RY5GvPErbH0kvuai3Jc6aivQGN8PPVaiU86xaKMaJDUD3G+iu1oXQZib5e2RSQ7J7pz5CQS9nx01Rg5xb0bXc05WbRKu3cncd9LykLcu1dPzNBfAEkbuONmLXA0Gm0L/oRPW0f92X9LOb6Ig6lBDH3RYr7+Jbg0GioDhZmYrotoIJsPQKdWNPFUYcDD3NUIuazmqSvGVgO7DXnF+v7+bLZU4ZA3lTD/g;4:mWGP+5WlLbcd1Sm7CMOONKJxT/y2DlVNSXz4EM5AJVFfjZuaqJxEkyh1Vtz2LOaq6B5viWsJoSUv0+0OPei1lVV4ovCTCtrE/Bi8x12rVAj2Cx/PG3ZBlc1unW2dPN/j75gZAUen0jPpBr/BNGQeXk0jDXf5GeKQ8CQPuJUVnn2PyNGiI07LtsRsoOnZktg38fLI19XjPYfNNmEBpALGIEENXakHJqXJtZOvwEXHHcFN6DoAvaUxIOmrUxdz5iNHsykAPxD+3uq75Pxu49aEmw==
X-Microsoft-Antispam-PRVS: <VI1PR04MB32787C0CB2CB468A861DB683ECC80@VI1PR04MB3278.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB3278;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3278;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(68736007)(105586002)(26005)(43066004)(6486002)(16526019)(3846002)(81156014)(81166006)(6116002)(66066001)(8676002)(1076002)(186003)(2906002)(47776003)(86362001)(50226002)(2361001)(3450700001)(2351001)(478600001)(6506007)(386003)(4326008)(7736002)(36756003)(52116002)(51416003)(48376002)(50466002)(305945005)(25786009)(6512007)(6916009)(5660300001)(8936002)(6666003)(316002)(106356001)(16586007)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3278;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3278;23:tmu3mfEGjTpRMQzhJJsQC1W5PZHSAiZHGBbUqBsQl?=
 =?us-ascii?Q?4cEzMshYWeGqplykaMjQeNmiM7RkE78MgZPSiLjSG1Mg9btqyk5zA6BzZaos?=
 =?us-ascii?Q?I6QJbegu2gdzbQubHUJ+bW3lYbNyM5GfUttYLPj3RmClrZQmxzmWpaMgo/dM?=
 =?us-ascii?Q?Yd7zLyQVlFJ/yH0cgCGJ5CSa2OrIuWv/Hk0cTty2aJQl/CUWFbMxlGJd/DV7?=
 =?us-ascii?Q?ZY/E+5OIMp90RU2dNWCxh1GvCi0SODVnIPzrBct92HJOLSWlgUSkauJpRN5f?=
 =?us-ascii?Q?VEXNCtVIFfF77ftShL1kHaefya1ozYItgu/8NvIsKqUuQJEvy0kGmEBOxZ++?=
 =?us-ascii?Q?6rKGoN0qCIemA2aRSAbHV5INcRmSW4HWaq8LwYJHYrKze0epus5pyxsyULLg?=
 =?us-ascii?Q?Jy3umiMcuCyn7ZBPlodCpjXQMcZcF2DWYwbyQfs4OwkaVteRXApk/A1qA9Hr?=
 =?us-ascii?Q?NAvoOwaIxCEAtw5/IwgBG9VQZO8upJm+Qwl+V9RuXkyzXX8tVu+zWSVak+J/?=
 =?us-ascii?Q?dYdpN/RewaL5UxG01hpIzhWpwoBc8xZm1Q0Sik8Mf6oSS2rA0sEZ4TJaba86?=
 =?us-ascii?Q?E7OFiQE+mx+AqZmd5mOVTiHF4cB22z9Q5m8vmkfX6pSPXY+432M6em4rngGM?=
 =?us-ascii?Q?C4JEVVpk2Z8w69nwRr+DvSyu3d4TGzC3Lkg6m8NzfCuXXODPwKnjBXOPV4aO?=
 =?us-ascii?Q?YyH1hFwdktZbsPjl2g/uuB/sKmbprJT1S0/30b3ZXOm+Q6vaEYtc7+7sEdU7?=
 =?us-ascii?Q?4cCwpvNar+WP4fUD5hvqOf2fnEtFc1hjaujhy30DFFNJ41Z8nvY1TDToLXsy?=
 =?us-ascii?Q?uUN/k07gHsRHRck52FUfXF+kP/GppcIS/4ZrB2VdnlOs0siUdOy/w3FdTD9f?=
 =?us-ascii?Q?1D0V7dv7xKMRDOSCiI+Yv8jg/TzmmGb0s8rSqgweTOXkm3zqYDFlz7GsVvW5?=
 =?us-ascii?Q?lKSjhJ1TTLYOL+446Re7QeBADpJzZUbx9ENn4dm04gJlfiZjlUze/RL3f/TE?=
 =?us-ascii?Q?1xObB2FN3iHfv+KRSclrQ7iyIO82JePmSsrqzYUifMjcoiZuzh165JGRF1iD?=
 =?us-ascii?Q?djfPjaIOI9z8YSlnA0SMEgEYcNqADGA14HCS46BWGdGa28z1qrqL4bCxRaAo?=
 =?us-ascii?Q?qBj6vGc5KHIbEDSXV2eKg4LHdS61ElLqP7uj/0dQb3GiDkDXuz0Ug=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;6:VrzfZldXn9fQzqJL+6Pd/3TpYgZM3SoQQiU9Jp+JWnmLpyZVTkEJiXQhc8YGkHxhFsEFsZfm/TMFBdusT3Ck+F2rjcYViBxKlAAAtWOH7033xe9pqBrd3mQaefwuaB57rKktMg4PP2KchIs3ThrqemwsINx8VgzbnHj2gcwN4Tm5Dv02k2Hnx27YzGI+hKICmL/IQ1bKQ1K9lKp4yVXJ6I25pp6nJ3hsa3AVEwgSvJAU21GMuonUAQH22NpFYm13W4B1ljagn0NZBNyVs0CwdxlPr3zKX1eGl3mYAYJpHcBjJzHhMocYuJmLFYfw0IuAAZIY9auaQDeS+F+G7A4SynFHPrxo1DvWqRzOwlyDtlc=;5:b/EpVQ9lc9P/9Kz2j2upnqxQ48c3pC74KylQOao2ZNvO6ApvcjxO5MMYPnn+gJr2x78nx+3siE08rd7xFSMdLjFltMl1I6bL6EsD5qMzX1J2QDcndx8iPbJ+tf/577cIgaqta76f0qC62w8RjVepOABkP4J3iTG+GYrrnIWmnOE=;24:5UUYuYlZMdS0ggzS+Et02RYXCr118NWxZQQBFprMgYZN7SZZsIsvFS/gebFYjRj6pR4mKf3JxNrs0/xjk3sM6q7IfPw2L+MqDo3ZaC5WGVc=;7:3HyE4UpekNdDgkpUSIUy4P8TZqMuiCcZPE2r3XGZBXexyj24g8oIkP81/GfQzLNgXUFpxxhk5URCf9pJw1qQMZSZ8jHEGWcInic3DlflRtqgfPSPXrEX0Bul9INeTZUJtR8Nk1KKHyk2XkuKAC48hlrtqS27+lFLU6u8nmRQ5eL0z9Ce5IO2X3VE/lImG34v7Jf6BWPC63KbScKTIzDWxBXaRz2rZ64SHxEMEZIdRGlV8hJ1PfXiptcTRmM1dm0d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 16:11:04.7305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430c32d6-5bf5-4435-b29a-08d577b36169
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3278
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed an issue on the Tx path that was visible in netperf
TCP_SENDFILE tests. Addressed another issue with Rx errors
not being always counted. Adding control for allmulti.


Madalin Bucur (3):
  dpaa_eth: fix SG mapping
  dpaa_eth: make sure all Rx errors are counted
  dpaa_eth: refactor frag count checking

Radu Bulie (1):
  dpaa_eth: Add allmulti option

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 67 ++++++++++++++----------
 drivers/net/ethernet/freescale/fman/fman_dtsec.c | 19 +++++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h |  1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c | 32 ++++++++++-
 drivers/net/ethernet/freescale/fman/fman_memac.h |  1 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c  | 33 ++++++++++--
 drivers/net/ethernet/freescale/fman/fman_tgec.h  |  1 +
 drivers/net/ethernet/freescale/fman/mac.c        |  3 ++
 drivers/net/ethernet/freescale/fman/mac.h        |  2 +
 9 files changed, 126 insertions(+), 33 deletions(-)

-- 
2.1.0
