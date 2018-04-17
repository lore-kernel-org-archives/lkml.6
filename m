Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeDQOct (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:32:49 -0400
Received: from mail-he1eur01on0103.outbound.protection.outlook.com ([104.47.0.103]:47424
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752427AbeDQOcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:32:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
Subject: [PATCH 0/4] i2c: mux: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:29 +0200
Message-Id: <20180417143233.25145-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0039.eurprd03.prod.outlook.com
 (2603:10a6:4:3e::49) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:u11qqlQDgt6QH6v5NglDc1EdvYY5h2qo30DPZ/ZjaYxBmCXrT8r+a2aW0gRrMlobiiqRD12aQ6aJyTMcW6d7oK482yNSiyath7eo1vTfXy4IEf7D1h/D0+KCs69WG4R15OnJIvyqdqTYhlcV/O2jzequ+u4JJfj/reWugyfXhhwOGk0mcgyY+p96EotvdeuIXQBJ5mcQDthc8I0fv1NxDRerNCA9fOVypg3lwhEWkzcZyP7y0RfJbH45L56InbdI;25:mvAwpf+eJ3AxlP6GrKhKqtzAv2P0iyDwHsn0R0OGwViwsrmJ4cAE0iakmuyGAruZh2+NZEU08LzUHR9kj327iMiIalsusBo4MYXcuDCupO6zIyoGGlZmjshSO333DBw06sASY7KivsCSLPq6O/9OquCEhY4rgg1OUIGP+Jvd2+cMfD6Wt5J8JzRg3i10LtfT6nFVCpi1vanMvyp+rGyHjW/UKrSdcFaO33/WUtiGr6cxDmW8CjMdxyjHkMxfbpgMgyaxP3DLx07ug0vf+XT2TS6Sl0sT/qj+/pc4E1sqwU2LqY9/jZzZ2aYGJC+aIpBrXovK0VIxDp7dDIor2FvtjQ==;31:YyXiQvRO37xQdk+KBzHvoHhpbvYKcjavCgmFmHE/ZMcQsE00YtJD+Otmsn/nFOWTkdQPsj1i1NUms4msndmvOr5Mdt2DqVISGHQbCiCIhFu2wktTZbSSfulKnvpC/1gXD6Ro/A/v4M4+u9Avn7sDWG3nOgooR5Gb9hBh2E5YBRS3pSAigi3hT01cJAp077CJp3IJuD2FYiXi+zv42YVb+5PUO2nIHf0p64DN110vqg0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27775292CE53C678C41675BFBCB70@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:Nj6ntHu2CpTl49Fn8rGkOM+HCF8wqv3jOQUDdQx6t+X9xuYaIgW7UTdSmOOy31HQ8C/f13q4h/v8w7i8kVXxjMQSuYG9DUorTvRtChz2Iv4sTk1qwk4j+0u7JHZehnmOsS1f90wb8b1TRdiiR9U0Bqsf4rMMEmn8U95SI1qzB21ohDIgiI0EMRA99tF+8sqtLQZkdWhHAKuZNgaApcF2FfK285Uz6LSRV18VfpEUTKbLP3O3fDSf7NHDpJQFJDLnRqNKbsHaWaN1MpCZo7/fzA==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(39840400004)(366004)(346002)(189003)(199004)(6486002)(4326008)(1076002)(316002)(186003)(16526019)(53936002)(81156014)(6666003)(47776003)(52116002)(16586007)(105586002)(50226002)(8936002)(106356001)(8676002)(81166006)(48376002)(386003)(97736004)(6506007)(478600001)(74482002)(305945005)(50466002)(7736002)(486006)(51416003)(6916009)(6116002)(2906002)(2361001)(476003)(3846002)(2351001)(25786009)(5660300001)(66066001)(26005)(8666007)(2616005)(36756003)(54906003)(956004)(68736007)(86362001)(6512007)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:W8hbd30Spss4WFmYTWlf8barQEk5utuM2Nwk+An?=
 =?us-ascii?Q?RkFPpj3fAkWDOHz/+U7ZNCpuOPo2GsX+Umq0B9+/oF2pR8uOZg5ga1aSumrn?=
 =?us-ascii?Q?DylgY6VGd1rlCU46blXFrOUl0GUrA5JaIFeTfNaIE6HOXfgK21cSUQTQNRHM?=
 =?us-ascii?Q?N99erQ/QhDg0AhFdn4PbQ7fwdXjngAv+QoZg+KvKw1jbQ3ByW3lw7leD5wAa?=
 =?us-ascii?Q?ZUGzLLrJrR/+Gct8FWrA5iHmNva+UqiR6oEqpBzW09iDLxXFan5ZnNzEASEN?=
 =?us-ascii?Q?0Wn9QK0JpngtkPtHsoVflMLzxSJItLQJJSQEMjfem6z1L3bMtXOy4hn8UwKp?=
 =?us-ascii?Q?6YROx+ZKj/1Z8TVTy1Z/cz/wV7S9wCm3S+z73TTZLt+HmB5AzeQYk7ov1fUz?=
 =?us-ascii?Q?qWjFgLc91TX7cI/oZXKSGLgz5tI6bEcN5xFg/X8x1IW4XIL/TrbEdSTg3W7A?=
 =?us-ascii?Q?Fpb1pAs0kPNhljeZkZGsBKzmUZrEPx8LhccM+vAhqTU9DYgAFf5+SigL7gJm?=
 =?us-ascii?Q?8EG5Jbv2hu3Oucbr1FA/+Se6QqDr8xMqnKMX/bXCdHPsNs3s1+J2P6zvzSNZ?=
 =?us-ascii?Q?fIwayWLEYBSzwAhAlZluEbUZcLbJyEudeY8HQUadmQ72mdJTFLBaQ52IgLCI?=
 =?us-ascii?Q?qupvIg25U2K/+FsuXzPQCilyQ4UKxYj+PQ7hSu0Ia2CX5yAmc5R+9sZVLP5Y?=
 =?us-ascii?Q?Wqq2LiIl6ZEDiPJwE72bQ/31HeG0jmnLf4O5tGk6piRmX91G9O4UCRZWdgSf?=
 =?us-ascii?Q?Qo9bAhG9QbCL56cyjidz+S/bknsr7xA8MbLJAC4qVX4vxSAvJAotpOU9BTMd?=
 =?us-ascii?Q?KSx6V0ryr8AYLpkwkWkQJP3wOcFIclDfBql2ZOtePpouKbMS5AzvyJceo3oH?=
 =?us-ascii?Q?dA87t19HBHRH9QwO45hTCxo6gG013GHNaQ4h+MVCmt/sbMdtx6eyBENNaTUM?=
 =?us-ascii?Q?IOe9IQbMzglywP8GIE1wBW6U2+30tIvAXmx2+ovcRGAHQ0FSJYoyYC8nQO04?=
 =?us-ascii?Q?yepXrM8GkjRoQZv8+gy7U+OejTPdN89Z/87AFipyESBRTQ551IC94osCx7Iz?=
 =?us-ascii?Q?j4GmFJoOXY1vC+fA3iJ+BiYlni7zM5GHy19bwQD4F+Fb5MUWOcfe431hOrCe?=
 =?us-ascii?Q?GT/BdnRWaGd4McxvC4ELeq13mUBL0pgaYC341Hp3ICApC42ZVvO0HdD3P47N?=
 =?us-ascii?Q?0YlnNjE9I39WQwmdFw+g9WDf6VZ1qlLY6zuL+4PZIjt8hYhBGTz4YFiJB9HR?=
 =?us-ascii?Q?Qx7W7LnOhz3JSaLkPzMDMmmdMn5gzMMSwpTJIkqBYHZoUZoqJ3g1QbXUzSeG?=
 =?us-ascii?Q?acA=3D=3D?=
X-Microsoft-Antispam-Message-Info: bLDHGJh0Jt5HWY4bCB/UpV032LQjJZw/3CZaUoJDpH6na5nvduywhqlyYjaQdGgjcG+EkqhQX/V7XMuVFo/fcJu7ompiIZmDUnabHtfoHbVfEPw/8WobEB+dflZ3OVa7FxrvlnJpjtqXu2f9xSM8W0YXc7RkVapSSAnSUpa5bGbSr7QA/3k8TxI2wFuUpJRz
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:c6yjOzsLQfmF/+MeTft4uxooS2+xcLrslmglYDJi6qxFFM7inMHGTJOMGCQ0UFp8eZEn6Gt5Xb6E77dd422l+EhdhFQDNYYSzXUtKCKLNNFH2UhbpMYys7ia+n3FTCo/seepFs4HaH+1vGhmQt4S3kUW21lUEz4klDThEHOjKijKtjEkspRnE1DOotaa7b9ZONqLcCy49FKtwv26QapWj4kynED0w18A6yIlc/9KOpNdZJL49pLYPSbR4/YO7sKslKQnyoMfR97XLBpUh8jzT0j+bpYa4XWbDC1O+E981qcqdU1u4lFM+Tltl4XJBGpCxCRRELyqJu+PG+8iHQz3mvJkJ5gj17WzMoGDx2Rh696avFF5XcavEqVedq+OQHwB2em74LPKabsy74ZOn3YqYQO/XX4CZ778mJ2uTSyI2EZo8r7eIDtQaTe2hwPTW0VMx8xm4gyjAe3kUy+aWQesew==;5:zZYOhY0Yu3FFQl4x48DJlp4TcpsJrDcPnAMbGTKeyaLq5mm6a23waApli3dbRxuacIan4gUqsl+YmgewFDoQ4soiHNyVQhPFLKBcaDz6QmR1KCkzaGvcnzSpCGPA6ENPD0PYZ+iDzBFDrpdmdk6wRqox8n88uTSuJsT90p4Ersg=;24:xYAmbPjD0aQLTypBNgxTYdI4KrpA8HZ8RcoCCc5Kl9OIbP6Y4GY1uUutAqSsGq2DbV/gNvIKYXz+e7BVFkTaocaVINK/m5n0zqM0sBRBWbE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:HjWxtkx+B9neX6MxCtrNizY3P67FeDLOaE7q0woBRq/rNg6sELuSISa2+A2IqcVQjkjCqp2cktdRDhsERi4RowCTHtgCJlK/MDhDhG0P0rQiwb0SqTYZVo6R+t7v+AI9+e1tRecvy69+ILG6Pk56bttR8dM0m96b+6ikaIZhLV9LS8i+vsWSjmNT5SCTX/rbKA9iUyM7NRJjlQcaYPe5EpOSK+9CYtCGGU8C+2aMF0NAcq5m7ZfzyXm/VIf2G1ti
X-MS-Office365-Filtering-Correlation-Id: 0b6fe9ea-e93c-430b-5fd1-08d5a47013de
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:32:41.0207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6fe9ea-e93c-430b-5fd1-08d5a47013de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

4 trivial patches that switches the existing i2c-mux drivers
that are also i2c clients over to the new probe style.

Cheers,
Peter

Peter Rosin (4):
  i2c: mux: ltc4306: switch to using .probe_new
  i2c: mux: mlxcpld: switch to using .probe_new
  i2c: mux: pca9541: switch to using .probe_new
  i2c: mux: pca954x: switch to using .probe_new

 drivers/i2c/muxes/i2c-mux-ltc4306.c | 7 +++----
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 5 ++---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 5 ++---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 7 +++----
 4 files changed, 10 insertions(+), 14 deletions(-)

-- 
2.11.0
