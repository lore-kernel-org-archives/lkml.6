Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BBBC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DD420875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQ8vosae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DD420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933351AbeGIPBe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:01:34 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:9760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932879AbeGIPBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+L+z7bq6zA698a6xBjgDajotrukazUM6nemfh0DME4=;
 b=RQ8vosaeJmGgw/Di25BMytqaKGV2JVCUhWyvCkGbxBjK6tgAsAaqHhFsWxedTb443NgEoKYMe4QQvuu9nIhTxZbUx5bM0I9eug4l4IQg8wDqArd7/P60HN4SjRl9MOfR447gx29SN379HEKw8GUIwUfzYLhVo0kcD5E63IqmbQA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB339.eurprd04.prod.outlook.com (2a01:111:e400:881e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 15:01:26 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 0/5] staging: fsl-dpaa2/eth: Cleanup and minor fixes
Date:   Mon,  9 Jul 2018 10:01:06 -0500
Message-Id: <20180709150111.8875-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0085.namprd05.prod.outlook.com
 (2603:10b6:803:22::23) To AM3PR04MB339.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84aa01fc-7066-409a-01b5-08d5e5acd8eb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB339;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;3:k4W4nhIZHmdP8t5PnJbjVleU2jQH+ty0PYDj7J/yXXT2UBpYP8OVGD9HYXprl9I+MLCIWl68wn2qxm15Re6z59cEhBU7wC1bGr2UM5qB7LobkchoqWGPYeWeh1Y9zMahHXiCR1qQwamO+fMf83SCYfsMV4B3rWYfar1DdBv25Fje4mrED0zUgWHR8BAArB/xMMThqao7mzusCBgyJhAczOiHBBxtVaIRXFQmI6VjAXVX2aFU9FTzE92vF5BTwhdi;25:Rh/5wxO6PCTMX04JyKYDH6yeu5jiFI4I8h1i2sSycSBFKHUqKnacGm/P/+u85Qq/R2ny8jvsZVhHMvFRYlMzOIBzcuATZ/NXtRJw2dNzhOGRpvelwcS61R97KCwxzNkIZZQu3lGQTiq70nl7HI4wozGlLUzMaV0g811Kvg0Mf22XcT9i90JqjqwK9J4MYf+yv6uc9D92aDxjEUUJ+x6CnqCgw004xTI1NNuY2qhDiA0ZdYmt7M2EnyYBA3IKcCZkNE75O0qMyfc07p24pqh1HQkyHLwiUtus7ZPTxT//aoQO+UELIiCb8p4mV+SvjDo9EvDtdq126gNBDFh0TvY0NQ==;31:pPWo7uthzqvksZVkkUCviOULPbIKLRi9GAIvkfF2mMGo4uJYqYhaDLtz8Vncz7QknhpnojtqCmr1/3YRqYT9V4SbLdj31BGO1ngUamHMJQRO7FXAcSCq1JoEPa7vZzRQNhDhrkrFoY5oSZED06bS0S6IIoaiBNP5s8KdEAAnS68zHovEx8TTyFSvsAcXcGKJrM5AaUj+HIARuSqprw3cTT1XbUqYzfJMT1UV/g37nMs=
X-MS-TrafficTypeDiagnostic: AM3PR04MB339:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;20:FprjbKvYMhC+3q/e/+IrUZYGwYHgedBgCSV7PJdUNveMrjsMsALzWgEVYYsAUuoNj6IAgh2w74u17xSNk3JqdEAsti5K7a9JxIzUK4TtpXOD7BQ5smsyVX6SLJQSUQ9XEPV+o8+wo7kt+kFDq+kyWqe9KRD77jHpAZlbakwWG2Mx9NqwswuvAvgQbkBgtIB83wj2PRyyG8empsTzDaZ3PG3sEIvwtqyALy1StDB6akqwUp1bDtgBFW91orgOWM6qSIpW8V7vpm+v6BwJ7sVdMa4akRaVxiFm2DZJdMvOWS8BOf1XgCjvGa7Fpl7vAkZ6lqD1rOmbYiAAcT3gsKTdI7OhT9TGzShQ9Ikl71s1k/f77ewb6GAe3wv9azDIfEasi+GBmdTRz+LTCTXnpiYBk9aAPmnMOnIhVLE3xH6W0A3mUtHfRvg7nQHSHWg5A5rREr4MVSTrmIytGiLS9ijgdmxV/+tKa4N4OTW6KZ5TEtCJoilNJGhiVUw9+Y63PCFR;4:c69effkrwbvVUHe3clCGshwjPrZoYdBqEkPzvmkGn2pdNJjEF/e/PNZ6o3BW4aHw1QfoVTvlq2cQshkB5MJeEX3UAJuhJT54pdwpYFRF+sF6HCz2G36sztF3fKG6M/SO3+BTDcinCnRCjaHxHzuQOOauh9Up0eZyo1QDxc4fitczDFjfTtqk5n9xvvsL+VXcEqH+Bcy+py+1b8AJrmO5ZH3KKnDXHf1AmO6xDwMTQiGympu5F7vIxUbM0XgRf8kJEvgtj66m10Kyez0g8ehyZg==
X-Microsoft-Antispam-PRVS: <AM3PR04MB339BCC0643CB506CE147B1B94440@AM3PR04MB339.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB339;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB339;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(68736007)(4326008)(25786009)(53936002)(6916009)(6666003)(1076002)(5660300001)(486006)(956004)(2616005)(8676002)(81166006)(81156014)(8936002)(305945005)(3846002)(7736002)(6116002)(97736004)(478600001)(2351001)(86362001)(6506007)(186003)(316002)(16586007)(16526019)(106356001)(50466002)(51416003)(50226002)(52116002)(48376002)(26005)(105586002)(2906002)(476003)(47776003)(66066001)(2361001)(386003)(6486002)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB339;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB339;23:ojKBJLE5njtujwMMjF6uxR+3JZ0ms61Y9AN4lnTaYX?=
 =?us-ascii?Q?7FjMr8ze5I6uqhMBxEw/TLlA0VQY6/Ul8lQf0lri9TgT3Z2nKlZKbuJ7//jm?=
 =?us-ascii?Q?s3ks2/56sIcTz7vpbBGYCQld8fI2RlxrDNUi63EzzlXPb9HQDFVgU0S0MyOp?=
 =?us-ascii?Q?gZCStpSLqjUptnLtdmjHYzNWACSxpvqSdpy09QLTd+7dDNlnLZzgrXKY32eV?=
 =?us-ascii?Q?+UE29PNWGSwiNrR5JGkyMUit2ZNb9CYuv9/lzdpP49AbT3qcwTpJqKyjVBpW?=
 =?us-ascii?Q?KZhax1lzZRjlBVbibRrPYTGAS/3q1hwzhut2hYZASIRAHxU2poja+CLadadJ?=
 =?us-ascii?Q?vyCfSgEe1iTHHRkpgzDXhsKsqkkIEggUtsSSTQ4/XZfvWggQm2lEfaZnRDwA?=
 =?us-ascii?Q?y5pqVPcc+vp7Lnzq+5d28Vu2r44r3TlkPWfoZ7FVDgtsL7JKMz6iqpgarTxQ?=
 =?us-ascii?Q?3s9Bt7vSiux8nWmqgowWhtAV4z52AQAoj9h4o4PDaRaMV2ehb+e+o3Xjtzqd?=
 =?us-ascii?Q?D18Noe/uFrDm4Eg42eWY1zi/picrYUlXSMTk+QfQFYuDP1XFcW0Gwqm6aLIw?=
 =?us-ascii?Q?bP69yYXbAd/TbC0R15gHyUtbPL5z3IKi/G+a14fYC49JSkKGIW9ZDMBwzgzS?=
 =?us-ascii?Q?pxT9WyrabLAjQWuhXhp3KMIwEobJVQcpk2q0nb2QpId1slZl44JlKBdB1g7R?=
 =?us-ascii?Q?cWuJmYY4xItIzo6/DKaSihR0ueRWYAVXnRElkcyrjKTs9lB+Wop45ZwX4nsX?=
 =?us-ascii?Q?p7XyP68hHWiOr2M9xqkxt37kCQoToYezcfVL/BHrWYC5SEJBktONKbY8GbxM?=
 =?us-ascii?Q?AwF8iOlp1ScMWp1JFVUc40z/BDydlkrRD8qyBIpJ7W3+HSjs0keCwC5XRw91?=
 =?us-ascii?Q?gdozbgGSSf7OXcrggYGE8+JrVUsPG9RGtFsZnX5uAxl9XblC6l3AQu1nRG1v?=
 =?us-ascii?Q?gXQP2yzXY9Qeg0EAa5m5VI/QUxZQoOMPMvAQpPu9r3sVjg7lEzKRdMqIqlyI?=
 =?us-ascii?Q?oX1VSakZ2BFduov2W+Uwm8HVEMNMGtyJA9qjeNiF38G6yTjNwbx1BebiifLI?=
 =?us-ascii?Q?XEgLIB1tRhY78Nh/xUTkD+Kwzq3OA9NOsRAkvgk+797M9AH2Rfm/MjG5fr3D?=
 =?us-ascii?Q?hA3FfkdL/R3gS+/LUD2AOfcAoFmEN8bQ8DwhXWKX8nnPelh+azrw=3D=3D?=
X-Microsoft-Antispam-Message-Info: c8VD6wJMhF5H4WCY9poGXoqfD7gSTgGSyl8NfzChY/FyZWv5ydy+ADiqRUU6fgzFZ4Jhfwg1jsuF9dyz0Tvkh7GJvNjgfYsw2MD/sYZLZkZBONASeOey6mk5B9rD85ihf96vNjOLU0N1oAmvO+v+9PZx5QPbqwSKgIDoWTJN6fXztWMLf5TVqfGOG8a8FKbHTOF/d2XolwXCqI7QWO59N+B+IiZ3wva34SZFqZ70gbBVypE2mxHXgqaLYYZfaQvLforNf+Nf1NH5F7UrzFUGQS6+/KJBymxjaajTxHSMepMVCFoCNvDntp6eB8N0e0nBDrNcuZP5yLz/PVy/RgxMNjtTUFWIsKSwfp4c5Jn8H70=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;6:CWTVgBR7kT2GPM1cwm2tZ9/Mm4UR8jL2liitZ4l3yLgPR2iye9YumlOH4NUh+zXhPlWKgZUcgjYTYthYoNwLo6FfCCS59Hs7r5H31rO7rRVOubPGQ+MYLQvxqPzx0aKyiJSx8HrPJ7cTo2K+1+0RitPI+REHSz7wgb8gdv4A/rk6NU4rHHfijxqiVn3s9xUf6gVmTLRhbunX/CRjEMKsp4wIqPgINBURRWU7K6N9gjkJZ7aWE7eD6+on3blS49ASuayY+7ndFtxObKcqi5YH8YmM5nAIGbheUOTx5tUyNDq/rgvD7oG/6xI/Yo9j26ANMqsze6M9Wx/+5TJsLEsH7+kSArA0Gf0Rz0gtokOi5o1Hv+Q6jg/ijnp75yBTWjVOLpchXmTYuSn/M0ufJqGbjZ9lAE8TJhhpFxtfSyiKU+7POnJSvW6qvxIVLnNm+nBx5EBzSoES+MWbI3EmSSx0CQ==;5:j80JxIrM0BQaLpXm9WGlRaW1HJ3g5iD930y/UHeALR/8ey7LWQT+xMdUcYeZci1hQgO6ZL/7BxYZ6b62duWPct7D1B+s7L/va/qoo6R4scdd0MoX7lJEx7Oq0kmObPWvo9G+tYxdMZp9KrEudVaAZP0fCr7AvUo3HZMQG7OGCpQ=;24:clGfukfUS67RFZ4pMm7fdpVX8HMtGtiivCrV44DC27ynkp64lPUSg8yrz3ykqDm/xv7g9KhH+MV8zC2QzDtY6rgfyxqWL+k8RJOo+onO0ZE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB339;7:RrP0ee9SvyPN/G+oAMG+QkmPeRf1nrT7nWle0kdAY7y5cfVs1gF2MxIVbcjtCdzVzj7QmgqafAgxS/4GKiu36DjhZ1xA3A9PAg7mieoXN8R0JSfPar547AvhNfYOc/3eQU+XJg/DzDdTlu/N/87uFiEIz79SlWCghn0gvSn9S6GtIpAWSTLofZLBndO3Ar8WAFI9yF9twSorH+umAID5ToxLRUGXDTbnPbIf9LY+PdZLucnxCmWPjqe9hnW3w5LI
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 15:01:26.8740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aa01fc-7066-409a-01b5-08d5e5acd8eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One bug fix, one small functional change and a couple of
cleanup patches.

Ioana Radulescu (5):
  staging: fsl-dpaa2/eth: Fix DMA mapping direction
  staging: fsl-dpaa2/eth: Remove obsolete reference
  staging: fsl-dpaa2/eth: Remove pointless instruction
  staging: fsl-dpaa2/eth: MTU cleanup
  staging: fsl-dpaa2/eth: Remove Rx frame size check

 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 34 ++++++--------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

-- 
2.7.4

