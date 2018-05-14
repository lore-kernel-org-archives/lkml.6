Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeENOyM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:54:12 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:39648
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751953AbeENOyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 00/21] i2c: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:09 +0200
Message-Id: <20180514145330.4857-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0043.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::14) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:onxGpKCqLI+MviHVI4Dp40l6MiTRk/j3o0JuRI6nf2I+4ylvFqW4XyYGbgHd9PAnKusxA17CtnnCgJO4hXCAWp0F17VXe5QszMavJRuLOvXudXd3gnH9JApDwQvYtWtnKsjaVIKYupfj0HOM2ZBe9NB3qlC2Eu6w8Z2+30yd1GGqgVPQbmloO8cakVuac5eALHZXF6U6N+aQWtREpFWXb18JeXgJxxEGbwowku29Cj2pJtMCb74jhpezcbpMu4xd;25:p6oht5xsYNKjKiWCadzltBX1WxdvqByUIBKftRE7Gd2wu2F0PKcAdlJ/+XGlTLoR5kEhKMqyRcv5NLlrtpvvZlBmA8figx1yOT7F5AOfrpqfDKnSV7ny5rFe/xucGIlRljenE0taMbAAPJUa0MUU5x4k5IuQay1mMHZ36ihxHL2YDoG6XIjSEJ2qz0/bdnos1EItiOklPeDehAeLlXp0bj7snvLedZ1duhhjjrdwv8/C2FuEJANyMEGPfNJRc3p4dcTUrP45nLpCcE3dPQwHrKUWLEstOy/6Ib62+jPAP2Lum+EJmrPjdLQixnqmxylIX0iawJI/XEF/RFngEjM5xg==;31:UF3rQrwvFsATTfyo5rjM2w/+kLOxm57syvei4IICHsd0zXw/IP971F74w75CgfvBY5YR79ToLXYHpQdqTslEOoscwI+LJsJOlcSc44Sf/vTwwCpC3u4XfVEaRYZ5BtZcjXUM2t5qvC1CATwXQTIPBE+FD+t0hIlk/8J/dpqx/n1OO0whdnDNCZwKcmkYc4zy3YDkTME39neWoOBm0gjZq4cEEhDKrovdKgG2J2WzCZA=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782AE45E6E4B3452CD22C76BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:pdB4sUl14LJed7ghkTodmhQMp1IzqCCzw25IvEhuiBs43GvhJDhVlQN4IdTaYrf0vaNDPxJt/HmxstHeHd1bWvs/zmwXF1W72V5dnRCLDmSRs7daMDfH5YB+fo7IebAAphrHT3gW4/Fd3sR4aYDKXZcplz6l0BgLXgO4RBQH/G1TxLI15HM2whHl/TK/5jre5dpePPzXY3dhMGQqeFAZorTh4mSFy6HdqGp9J/1Q82h13Js0TkbeA7LBLlFhf3kgdrzIpdOgmO1BzdLvUxbyYA==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39830400003)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(7416002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:3dMrWKx7mN5ubLPo27TbblEUMOZDW7mYICuvvAL?=
 =?us-ascii?Q?k3uuLj4QkaWpcA2WcevtDE32JDHEx+tTXxRvjiL6bQyRZ+yg/h+cDpzXWnyI?=
 =?us-ascii?Q?LqSTgqMO0+ZK8FeWjMonxkCXvt9ME8Xlf5VAxHNIp3sU1xUaDqY6nVZ6Zzyh?=
 =?us-ascii?Q?6FZSStSUeiK5pvA7p7JLHVMx/Qnz43xmfeSdz08Su9t5AzAPAO7kxy5YQcAB?=
 =?us-ascii?Q?ehMO0A9+Z9hoOxDIjNCcX9y2mhRrc51UDjysAr6Q6+GSHjmVEdeZEhQPo84m?=
 =?us-ascii?Q?0+z0h6EJPMUCsckwXDc9I22cbrcwScsR/mYSLdcd87xktVBNr44+b4nlVLvm?=
 =?us-ascii?Q?Q2unpiCupkKYDBuCJicBq84qi54c7/UJeJYcJv4bG1oQhyf0COFeT7AGec0W?=
 =?us-ascii?Q?ybEJG0p3FpGOhDrEQidKVHZVHiGhFvw4LNKEbhbtLqKkv/Xlg85H0WZBG/OV?=
 =?us-ascii?Q?Vgpj3dS8x1is0lSvEEzj4QDWh5gTjNeImCmeDlcjX3nRLKl0FftI0H5JAnTE?=
 =?us-ascii?Q?XJ7rMVPo36Z/Lu3E369e7wHNP3iPk3YY4MLnouKF3mZpovyoFkOJLX2JPWJx?=
 =?us-ascii?Q?gf86uPDKyjF8742VPfnjUImL7wTl8FQPGsA2/z8bTRoules5lJMUovCu37EF?=
 =?us-ascii?Q?Z/qLhE3+NbDCskrUfu0Oi8CXZN94/5kRNmW61Gjdr7Lq2PkIUBbkdNxIF3gC?=
 =?us-ascii?Q?P2eIStbga6qDV7/h4oRkgBXIqKo7ooE5yJwt0B51rPAUmeo4Duj+I/V/kNVt?=
 =?us-ascii?Q?54UdHc6Y4X+UO2si9M3exAjBgmvyglKBErAcYm0aqXpFhqk0VJkZYF+aZVSW?=
 =?us-ascii?Q?EDj9iQ6QwWe+XfH6x5Gj7FavABOpGUiNZU+FCdqYg9U1yeJC5Zm9jfNZTnQy?=
 =?us-ascii?Q?bhI0pQj392qdKXGTpvvcRwFnnd8Oa3pOP65b4ddqe+KK7epQQ0QyNGJS7VWu?=
 =?us-ascii?Q?NTYS8JaAQsJnH3jOlRPNrjcTUHzSAuV9RSxZJVUiv6Xxap6ISpy5vL079cSe?=
 =?us-ascii?Q?I6q0MnNqdQ2Q83sGib60zmLBdWBfEx20oRqhAUk6z+IZkWGXWACfKSXKGReh?=
 =?us-ascii?Q?IfegmGm3b6oiMt6kixLBg6f9wJUxTRnW/xLtf61jsIe6miyVt97klfiWHuck?=
 =?us-ascii?Q?dO7VgAeA7Pgx9iLVw7sO3Ve98w8J0lIptCu9/cFxA7Wjriho7YrZHoD4Rxda?=
 =?us-ascii?Q?jZ0sbviGEb0vfy3A8VjNcKoPWnUdz8uAPnEJ4YKhRX1Mw6fTKwcxX4Tk1ot2?=
 =?us-ascii?Q?l+x7g6lK4q0CC1OJMdpEyanRQ80ZPxxEpPJnUkB87?=
X-Microsoft-Antispam-Message-Info: 2h5KKwVOdY9Lt3Y7/uvTQo2MlSTJHcxr6SvpL3W9XYBd9JjgkTFuFWb1OyCDycfkh683qvcoD5dcgwMPfTk+ju58NP9xc4grhneAe0gokZq9mgY+IPgglG8WkoptChUo1pjMbeoqD1hhAzJZeQr5a0Uuyzho6raFawDdRxkMitZwJzz0rDBzqOpDzh4aQBfK
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:NlvOgwV5H3DafF25Wb0/KQe1DX4i35e0zPT4n5GTCafBGjMvUgv0HlqSLks3mAfVtwq0j1QGY/Eo/0ad535/s5wvNItYy9YB26PRm0M2tECLos5Dvyzd/zslyn0p3iwA1pGyDEjARqiyYk95dHAz5JwMRT4MNcQ8kvaQQimtTt6YZTLD7SeuakatxRnbFo7auEmjCm3wia06DiK/47Gnz/prrpUe7BooNG6StT4GJ2dwa1uuJOcq6kXOJvE6c6w1g+rHcPxxdtasyARac2/o29VFQvMdzaqtPJBWLUuZukX31sgh5Xe+8hoCehgqzwjAMdf7WERGETxjCC7kNI5BlUrCXhdvSrGpvhD07MF3FVz+PmgtvHaMJ7h0sJk1+FkNCBlXEif1Au7b/YlEjEqkwibyYD+zVfAiCPIpwWxD17veK/967OwQNGv0cLP4J58OC9a1iCwTG9Rzhlk1SIiEhw==;5:0yqIfMDSRA+H8HY5wYR9Glq8Hegkq/VoDbMH2rCqFrR9b5lgQQjYR6G3D9L0DAJe3530x4dWJ+tHZd55pRI0p0wI/PP2iVEBbfh6sUwwRcQlhYp2ta4cusvNC5TIs86u1e290uPqZtjUEmE60IfCuXW+zIuGZsQ3igNdu+cDMp8=;24:PHjlWi8Qk8iW1vKDSR0hTSzpeqSS0RpllNS8DS9vURPCyK0/IEQqrVaScCRG6vxtyq/0xKOE4zA1qdC/7WITFOTSrj8nthNfvdWwl4FAim8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:tRgwux/qTWNGqo2CL26Qq1dhEP/Ol9DYLkVgvVOws6hRHvvhfrw2+jWKCHogkQ4KQEj9qlFA2OvgUcQwIg+HNXTfPa44fZqunx3ZrpeqhPZZlPIo8RO9HNDgWisb27DZVp7DVf1b8fdnu2A0ky6d3Iwmuuyaff2u+y9Sb0DN00uVpaSlZeBSx+ecFVNLd2bV7aHoLFa5GOFSyN9/hZb8gkrnh/ZbM1EaXfZzh1Y+HMM4JNRLu0jy41YF5tH2JdNw
X-MS-Office365-Filtering-Correlation-Id: 402292d4-5387-4ba6-648f-08d5b9aa89ee
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:03.8411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402292d4-5387-4ba6-648f-08d5b9aa89ee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The nice little inline i2c_8bit_addr_from_msg is not getting
enough use. This series improves the situation and drops a
bunch of lines in the process.

I have only compile-tested (that part fine, at least over here).

Cheers,
Peter

Peter Rosin (21):
  i2c: algo: bit: make use of i2c_8bit_addr_from_msg
  i2c: algo: pca: make use of i2c_8bit_addr_from_msg
  i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
  i2c: aspeed: make use of i2c_8bit_addr_from_msg
  i2c: axxia: make use of i2c_8bit_addr_from_msg
  i2c: diolan: make use of i2c_8bit_addr_from_msg
  i2c: efm32: make use of i2c_8bit_addr_from_msg
  i2c: eg20t: make use of i2c_8bit_addr_from_msg
  i2c: emev2: make use of i2c_8bit_addr_from_msg
  i2c: hix5hd2: make use of i2c_8bit_addr_from_msg
  i2c: imx-lpi2c: make use of i2c_8bit_addr_from_msg
  i2c: imx: make use of i2c_8bit_addr_from_msg
  i2c: kempld: make use of i2c_8bit_addr_from_msg
  i2c: mxs: make use of i2c_8bit_addr_from_msg
  i2c: ocores: make use of i2c_8bit_addr_from_msg
  i2c: pasemi: make use of i2c_8bit_addr_from_msg
  i2c: qup: make use of i2c_8bit_addr_from_msg
  i2c: rcar: make use of i2c_8bit_addr_from_msg
  i2c: riic: make use of i2c_8bit_addr_from_msg
  i2c: stu300: make use of i2c_8bit_addr_from_msg
  i2c: xiic: make use of i2c_8bit_addr_from_msg

 drivers/i2c/algos/i2c-algo-bit.c    |  4 +---
 drivers/i2c/algos/i2c-algo-pca.c    |  5 +----
 drivers/i2c/algos/i2c-algo-pcf.c    |  5 +----
 drivers/i2c/busses/i2c-aspeed.c     |  3 +--
 drivers/i2c/busses/i2c-axxia.c      |  5 +++--
 drivers/i2c/busses/i2c-diolan-u2c.c | 11 ++++-------
 drivers/i2c/busses/i2c-efm32.c      |  3 +--
 drivers/i2c/busses/i2c-eg20t.c      |  5 ++---
 drivers/i2c/busses/i2c-emev2.c      |  2 +-
 drivers/i2c/busses/i2c-hix5hd2.c    |  9 ++-------
 drivers/i2c/busses/i2c-imx-lpi2c.c  |  4 +---
 drivers/i2c/busses/i2c-imx.c        | 10 +++++-----
 drivers/i2c/busses/i2c-kempld.c     |  7 +++----
 drivers/i2c/busses/i2c-mxs.c        |  9 +++------
 drivers/i2c/busses/i2c-ocores.c     |  5 +----
 drivers/i2c/busses/i2c-pasemi.c     |  2 +-
 drivers/i2c/busses/i2c-qup.c        |  2 +-
 drivers/i2c/busses/i2c-rcar.c       |  2 +-
 drivers/i2c/busses/i2c-riic.c       |  5 ++---
 drivers/i2c/busses/i2c-stu300.c     | 22 +++++++++++++---------
 drivers/i2c/busses/i2c-xiic.c       | 11 ++---------
 21 files changed, 50 insertions(+), 81 deletions(-)

-- 
2.11.0
