Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965786AbeEYKip (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:38:45 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:41487
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965255AbeEYKin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:38:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        linux-imx@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Date: Fri, 25 May 2018 18:37:19 +0800
Message-Id: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To VI1PR04MB4224.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4224;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;3:9ife6Wc7ogVRvYeZvk/XaHLJL/0pjmpUhEgJy8NPdnliM+cqGmSD53p1bpbR8gplfxgiQ1IvzzD/Mt1dc6vSzGFdv15iWH92JLuyJlFC7CpRT+BHJJj1JizYKVMjK/BmOpPTtf9Dx0e59hl1be2k4i7TI/5SYEHnGExGXsx1oxSwAbp8UoluJoGiy8oJwkZdZicosQfS4pKHezHXwVMKqmNC+jdNK1JM/YbUhTVeXjTq48YpkP+17KOf+Y5OoOAt;25:uhvej9Wir5xAYbVwODsG5KCvymnbgpPf0GPvqx/5S4TuIriIwn3/XrLf/ecA6mkulBuJM4nSc6cnyfNvcz/t67eYHJiPMfjUQYVipB58VAmgnZ6V69ESDAcwGRCHCA8nQYWXVaR3BsGfSHTVQmsbWSuvBZgkFxmgM94jBBWF8XkcWyWm2yl+U5E1x0XNdd6sxgmmmL7q0f/22o4DQiiGdcTM7v3locdTuPe9Wo3unxPM68zPvMtCREdoK7j5OO0nKPZQ9QuuBs7YWiLE2+fX4vnM/HQtz5utfuiz1WWlM3O3yhic8KlYfR0UrEPCmF52uKFmyQYzDhTiXBAzbT3FkQ==;31:hUyNiiiy6ZMRB7G6YEEIiZ/0Y76trIoa6/+bT1b4ncVpohJ2x1nWQ1y0dvxY2qVN5bwG3MPmCUyALcrnMbCm4DK5IPMM6y8xwk1oRgR5SNmrHvzfGqR+CWgZ+cC8yNswdK8q50j2soGwPFT816bhpRST6C38T4t0hP6yYhn2XWdt+f6WcyPk6AJ1fdw6FJwhrYXoKUox/laR8M72UAx2W5mtjMeYY2bYv7F1lJ9Ckmw=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4224:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;20:groRdS0wRqbjFeapfIk1HIUc6UgoFYg/5uxP7OGF8w/yhzrli6gdLDGfVBBxugrTHon5fDdkTT4MQ5N0tEcEv+Q++PNDMckUUmbGF3fJVIRl5HM7ZFGgsrQvA8b92tyF7WOqXXy47DGRwfoFR4wfbZhrhaNn9hjuMnontNIeEvSGEHH0Dfe6htZ9AW71evZD2TATlSIhNGIcaLvsN7WHUMY2z9jgkXqknY6dpHRxjDLeXozOPvxMW50ibTMBAc1y18CnoQQlmLYowYsKIT4tttBu5DzuUQCSQfK6z1jpDWFclF9axCNLZjb74s5BWDdYbV5VwQVUQyKg6IaO6RvNoqUKrlU4pnEfecuwImx5OIgRMsEu05p7PLZ6QsLCNCYywFIfKVN2ULJ/l7Rlf4CF31G4AXFu320BbQtPdfbhictpGqilkumMrVIcq9R711ktb8gP16SlNlMEkSC56A1YwPTztXC/nKhhIX+1S+i6pCoQm+U4d/WIP3tq7J2rTfSM;4:NHdgWHqKDE9ZbqI7+BUG6ePEzB+Pkqs8kWvNGSF+UzLB3Qrj0M7WbGHHc9tp/7jjfSxjt11iHP2O6ofR2Rchv4YGVMEL/lB7tnwrryabBsOTg7I8zj/zIuK1zYAu9fzY+v1q9lh9bF3b7mDAYVp9hBDROFq/DfQDGg5dZXrKZmx7Xe+bewHdvwYErYHKmSDPDnWest0yIyIogqvFZNa2dCIPzTavukY3XNhmunxJNWFrbAHvvuHoZDXLXZpqlCr5TBtya43sTSS7nG2l19S8DQ==
X-Microsoft-Antispam-PRVS: <VI1PR04MB422494E2A1A5A1CFDE76A40A80690@VI1PR04MB4224.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4224;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4224;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(62966002)(74706001)(36756003)(77096001)(77156001)(76786001)(76796001)(81542001)(42186004)(93136001)(76176001)(92566001)(46102001)(64706001)(81342001)(92726001)(15975445006)(48376002)(77982001)(59766001)(56816005)(33646001)(80022001)(66066001)(76482001)(90146001)(89996001)(65816001)(87936001)(56776001)(88136002)(54316002)(74366001)(44376005)(87286001)(87266001)(50226001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(93916002)(81686001)(83322001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4224;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4224;23:19cnPv8dmPbkqi3L5yfa+ROZrKFdyssToRYf/XA2c?=
 =?us-ascii?Q?bZjtLfN3okA0/j/4BlhiS5cLnRP9AS3ZW6wemqDs88nMnzMTgUVMu9kcMLKj?=
 =?us-ascii?Q?fFbXLmAXCqKwAq0jtN9TwzPj23MJsagNpCq1mb+eagmAIdIzOokts9kK3Nd4?=
 =?us-ascii?Q?Wu8ct46Ai8kfYGuq3+hj/bYkbYcjEDbT8aZuIJEcBmbDHnDN9g05z05fIyH0?=
 =?us-ascii?Q?oRPLqaWFIqm9J6x5T/UY4BK0fiOaRf1fGZ0J9uMRYQlE+nn8b4nJoqvTdgYP?=
 =?us-ascii?Q?BBvzpb2kCGGvurSZJNIKlKjrJ7bMVl87Y/tAgkRTCvoekhAlVP6aCPkmtCh0?=
 =?us-ascii?Q?ZukQa/segpglRBolzgHHop36cryC6mxup7KhyByWvpC8KCn3a4bn5rdsWpk9?=
 =?us-ascii?Q?kgDUsr2ik9RkoFpjxIhNaZrKMtN8h4/9m1fafJnB8FOVttyG/8fZJfkqetP6?=
 =?us-ascii?Q?vf7ZfRxFj1uF974gQQBl0m+/Vc8vOOV+x77sZftqDdTQ36ZcR/VUL8+f5ImW?=
 =?us-ascii?Q?aCYAMBBMIfSLhMUpHyf4wem4+w0JZDHFKwfHaDDXMjQhAv6mI0iah7yQ2olb?=
 =?us-ascii?Q?PQ19074eh/gsbBcExt3t7AzJaQ/QsolMJC67+rKH+TEVA3Yi6ij+PAXiOKS1?=
 =?us-ascii?Q?iqFLKPOPwC/Rdbw3AUbx98f9csdDCAii4m+1F7HkmyLbTlJu0yVnWBmC2lsq?=
 =?us-ascii?Q?3iaNc1XhIKkCKcweZ4G5clGK76IC/IfM+3axXFq3IcNw70/gKEjsWVvz664E?=
 =?us-ascii?Q?RNaDnhObeRzWmFfOzqsEWO6nydLBjR7e7Sbs5BKkc0+LbF+Vyv5ZJtiQuFZr?=
 =?us-ascii?Q?ikiOHdRBSC2PHxx9/vWMFLUUi85ymm9GWCGxkhRf23pIKp3BllKL3QlV3NSC?=
 =?us-ascii?Q?ONcX2jQ5sI++lcp0BqvIMlUGQ7hs+pEl1pDfvfwPHIek4k1ljGiiQ6EuUA+c?=
 =?us-ascii?Q?BRGxdXNnAoJyuDbzoET1F+l6QjYcsuBDRf4v6UIBEDjKSntMW1WxHFOyjHJ1?=
 =?us-ascii?Q?FL4bXu6JsrD5PL4bfmAgu7o+ncgKxJnazMgKLIt+PSLKNJ17gQ3WX9nIcw3P?=
 =?us-ascii?Q?CkBWvGrVMKYIP5LVaaIDQfX/U/Ssmy9J2JiexjfkNytPOivFWUt2PNas2161?=
 =?us-ascii?Q?gGTN1rscvsLQts0MoBRbYwHtZo+liggXOg/WRcP/rs0CpQfoqMHBSDgz7J2D?=
 =?us-ascii?Q?rpsi93PnM4hEZLrN7JiFzwuloAA97jnQCvgcFG6nTjJX7CxQ5cchWQ0I4Uru?=
 =?us-ascii?Q?l/j2UxajAS/hWE7k6dTiQljjmX3Q6Akq6O4nxPkhMQo6MkEdSmfCS037DHsB?=
 =?us-ascii?Q?bUgZddKdoDkA1Tg8UOiqmsbNhSAmrYmimeue8AJRoyw/fgeTUnXvd4kb/g/j?=
 =?us-ascii?Q?5SHXK4IIv0aESqIkUYOFTdV5LUz8YnNolkovi3QR37BbpQxljTM9ZxneUAUH?=
 =?us-ascii?Q?FY1D2gst1/cQe6FKkim4tAYVXvdQTlNyIa4jUhLC/kTWsi70QbHgNDP4YGc6?=
 =?us-ascii?Q?O/yrlyaROhL5r0CgBx6j8wDDlm3Nuvfbrz9nxYrSnRLUll4qXruoCCbx4nqy?=
 =?us-ascii?Q?9EvnJOcTLTl0ulz4KCEXW8yV52vgSPwnDkz+KUoIMWw4eD1hrkCc+QXrqAJ3?=
 =?us-ascii?Q?McTq4vWGdtaWM7xmjdfkSB2pnlzujjl7BWWr4LQXhWvGs0Q8H9N3xSrnSB4S?=
 =?us-ascii?Q?V9ayYgfsrSp3+BIuPE3d74hl0jfFleb/xT37eo8/VoblpdLiNiOFZ/x4GNoL?=
 =?us-ascii?Q?8Pd9ioF8B7ZjsSC2HbRN70CJelAV8Jn3Udh0csNTET1MToYW6fFhEgySTSs7?=
 =?us-ascii?Q?GggAku/lfie?=
X-Microsoft-Antispam-Message-Info: BjD16Et7o9T5uT8HkM3sox/aTYxLyxtQvJS0Bo8JfjbLpIVlbg6xZWtgf4RcVZj3YEcN25k1oYuXeIfXGUl61/RYBn6nWIqKgWISPNtpingyA94KckJwPpNOL+lvs975NLk38Qgtbgf+UCjwVUwRQhmQsYHJFpKAm4h/jDchb6YkcySg33obUQyew6BwIpQ+
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;6:8JxVpzB9s1o+bsr1qdGe5zy1AgKdzlg8bqPxhh/t3gy8Sy3JsYMhP8c96ynBomNGaFkbmNwB5iAnnv93V6pLtg9FfDBBHD1ARn3IdT506rb+T3fnIwOkeVOekKwh2Wl8Dnp4u/gVCr+QF0fjVecj57q8a0nfUkkmDwCUm3DYK51I6/yDFeZupfj2ERbnM64WMgvJZOg2eBhiP4UlFokaaeakllFGb3fJQu5xRn+SJn+yr19QYJVK4tLm9PVU4xuUTwCQHUGLrJe2ddkewzTNRpPR/wy+29jfB9fAHeiVQnTpn7St0iNGlJC47tDIUHFc/Sic5LGnpmfLdeIqBBuXxK7PEFMQXipN95X1BObZY7Y0fWqY2aSTfNXTfP+N9Y+AqHMywcgtt6u6Jv9GjL8i4lfSsfMGfMK7n3DIZ9WvR/kj7OSsZKVr/qpivSOgph4Ju+aBq1GlkhIPSCD/vZ7yNg==;5:8GgLqJ9omukqXe/B0H3ttTRiGb6Tlet83har0Ll/oE0yKRORZTglvvfz62C9m4yf7EzKe2nlu28tJLBliysczlKCfAN2M9ti+XIR2r0Ze8lshU5OK9kLxt0cbbczFLrcaIyqbAXCiCply/To0yIa3MS2BW/oSbhyWkjTNCmK9yY=;24:o0O8OoOpKZfdnPsNHzSkZ+hJbMYb8AwtwIWo3VtlbKAEPBpGCG2Fm5Ta1JuS3n7D+n1YOZXmH/SgmXvF7TVSLRs8oJ2XSHdBo+a54OgjtN8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;7:608gFoQjhCrzgXKedpyHXBkaQBF/z/uKLsge1S7PPeLDegCZ59ucYMLujH/Mca5KSuu7IaqHjcwwRXp/57XEsaxt6B5uWEcJ8w4foqoEGZb8hR4rgrh5KzbC2mY1SxUN07JJpraMdmvUrnXi2s1gmjRODs5WRzVighKvDBnDSS48fWtxNMJj8BTRrv63QPUVTlOmrjWxPo5O35qo7Qx7/ZI3B+67oYwqMD1Eu62+TeF6JFbotrgYreboa441EJCn
X-MS-Office365-Filtering-Correlation-Id: c594f80c-82ad-4c15-cf6a-08d5c22bad8c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 10:38:36.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c594f80c-82ad-4c15-cf6a-08d5c22bad8c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a continue of discussion from here,
https://patchwork.kernel.org/patch/9986293/
that some users may want to handle all available clocks from device
tree without need to know the detailed clock information likes clock
numbers and names. This is useful in writing some generic drivers to
handle clock part.

Note:
This patch series is tested on MX6Q SDB cpufreq driver with a minor change
to switch to use clk_bulk_get_all.
But patch 4 only test compiling. Hopefully someone could help test
the function.

v2->v3:
 * address all comments from Stephen
 * fix build warnings on other architectures.
v1->v2:
 * add clk_bulk_{get|put}_all() which only supports DT platform currently
 * remove _all variants and the wrapper struct clk_bulk
 * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
   proves they need it because they don't have a struct device pointer.

Dong Aisheng (4):
  clk: bulk: add of_clk_bulk_get()
  clk: add new APIs to operate on all available clocks
  clk: add managed version of clk_bulk_get_all
  video: simplefb: switch to use clk_bulk API to simplify clock
    operations

 drivers/clk/clk-bulk.c         | 80 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-devres.c       | 24 +++++++++++++
 drivers/video/fbdev/simplefb.c | 66 +++++++---------------------------
 include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
 4 files changed, 180 insertions(+), 55 deletions(-)

-- 
2.7.4
