Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2C32087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jwA8SZKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfA2UjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:39:05 -0500
Received: from mail-eopbgr720079.outbound.protection.outlook.com ([40.107.72.79]:25568
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbfA2UjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnSGs9z/sekXqACS8dcM3ARJes8ekF/mYtHhHGqnBMw=;
 b=jwA8SZKiZCP+Oc0QzvHCy8Mk7yXjdubvThvZldNh05K2+Edv4Ea/rmBXcK8qFxf7AMOU+gn5Se8QQ2bc1Lab7qz+1fKk4vMJyxSewBOA/NX3TQ3dutOR2wO3kd+dp/eOG0RmYFeHkQuiVLqqjpZwC7dTPWWPOy/UbvE5jLCa54A=
Received: from SN4PR0201CA0033.namprd02.prod.outlook.com
 (2603:10b6:803:2e::19) by BN7PR02MB5009.namprd02.prod.outlook.com
 (2603:10b6:408:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.16; Tue, 29 Jan
 2019 20:38:54 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by SN4PR0201CA0033.outlook.office365.com
 (2603:10b6:803:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.16 via Frontend
 Transport; Tue, 29 Jan 2019 20:38:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 20:38:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33336 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9k-00059Z-Sg; Tue, 29 Jan 2019 12:38:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1goa9f-0007aV-Og; Tue, 29 Jan 2019 12:38:47 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0TKcaYP008058;
        Tue, 29 Jan 2019 12:38:36 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1goa9U-0007YY-IM; Tue, 29 Jan 2019 12:38:36 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v6 2/3] firmware: xilinx: Implement ZynqMP power management APIs
Date:   Tue, 29 Jan 2019 12:38:20 -0800
Message-ID: <1548794301-30483-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(199004)(189003)(7416002)(316002)(336012)(77096007)(110136005)(63266004)(54906003)(39060400002)(26005)(16586007)(106002)(107886003)(186003)(4326008)(14444005)(6666004)(356004)(36386004)(2906002)(7696005)(76176011)(51416003)(305945005)(44832011)(486006)(8676002)(81156014)(81166006)(9786002)(50226002)(8936002)(478600001)(47776003)(446003)(126002)(11346002)(2616005)(476003)(106466001)(48376002)(72206003)(426003)(50466002)(36756003)(2201001)(107986001)(921003)(42866002)(5001870100001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5009;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT018;1:Udma5CBRAx4cmo3Xf4AtAe1oHRDoITGw8MWm7T9P0RYFXmWAGXubq7nCf7gCZRDhMWs1K32WUxJNAyP+HbW3IhL2NKUkMP9/uoh+wB2YJGLGp9wPA4Um64RJ0KWrPwXPEhzQlw1QV9r05q6ZcyjMB0BOGk8NbnpDKx2ORIXD1ek=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc698dc-5586-4b59-1d92-08d68629c89c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN7PR02MB5009;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;3:fSs6RZ82vOhYZ+x7sG9d+NAKu9Dvdfoz1h5MVJEu32KwQuF+poBnOW91jOghLkUZUEh6m7qXVNTOqZ/NpK4iydW7Bng3H/NRE4IMvq4XIuQErHa07Mx9oXbqXB5ZSg7OiqAiC/UKJ1oEbFFRw0EIjg2EHoGcXlbXANZSC8w/gl/4mN6D8Dk6nSrZ3Jyy6PgspI4AeiF/fN80Ukblj44CHJDZiT31EhlLGJbOp7Ql9oA2eJc/4EyzFWb8deY8xjOTrUNw4pvzTYH+uVNxVhPJ4DYj09OWgZ1eo4OGeoK2s3tchraT9elj1YsSj8lPlaaJt3l6S1AY0UYNxojdr1hMxiQTkeYuEgvgslsppRNxIvJcERVhoNgWofTf19V066gi;25:M7w7l82lNuK74Xq8z2cBpIzBsYgeU0LS6D4Gb0Ks46PwbjqDczx7gmsZ0q0WBoyZFx0Y+OroDqePiexKLFJS7YmycVYszXZMyHm0wWGfnN56o3vhw8pNjEc99Bua2tnhnqUA9nm7Vo0QcLr9ACJdT2E8h3W/hD6BN/K1RfBFM4niHS4b7gejmBhFCR0xmg35OC9EG7gLXhgHgtcaIkaLwyOO0cthPskvG+eWG4GbN6p1eA2ev8jhYQb60CDdwXeewICT15C8QZKA+9HFgfMM0Vfs+VxcLo3CZA1SIboMOKSb4KQt/2h1F3viXFxRG/HuVhgTN9ymbdwiXcH+M2dfoA==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5009:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;31:8NSNYkBE4JJAuujmsy7dcS+29OZDxmZ67aCvshJEE+G/pN+z0a4NGB+Y/NehQlNzEYbUiORZajFQaLTxNyFVFT7NigwsxprhoJGb9gWXinuA2o+mnbXPEJki+W4mKcZ6lbfKKYud4oTUxQkV0iVBdmfuyEPjY8w7wwuOmBJkjILEI5ZeV6s94OLEhBKSw6jOoIeKPrpS1DZteoobZ2EJF26cDog4OxJJuA/efS3GU9I=;20:arXz0dSuOgbJFqJzYWlxA59qmTQEemwLPQ3FU+5RoAp3WUu+Nd1H9x39ucI/eDZPg7aAH1rgjyW1oHsCFVlUQk7vTZtky1nowxx3OY91u00ApoNLGLPl4WyyrlNNPnCAQwbLp7sOXldRpd62GrRruIA/ZA5sphVSlzXnYgZbjgcpRa/A5N56QROXF5TTNjBeGqtHEyk6dlhhHmj8m5gDuv4Krtl4jILC1nmXBzicHHbvHoMkZFMtrdxamBHOPD79QxQAVurcNZ/Cw6w98y4irb180EAsO3NC5QCvS4G+b6vSaAz4sfO7QHWYdb0fY0OvuejHR4ToCi7FSuDEKWO/lsX2zwQ+FJqsOOvGJdVUP81tNu3Sab1276EJjbVwrdheX0HoJt4QKCOEvVOSTpWgQ/Lk9efe71rq1EpKdBbtMt7O4MGmG3V/XdRY+slb8Evqa45Aw0VhooHe4mhSLhWaMAp4sZ/7hlrDPYTi/oTojKG+3wvv0QqhqrbYV4PVxGng
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB50090247394B09AD78A3E167B8970@BN7PR02MB5009.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;4:hn8c8fxajMcA4OuN2PAN7U+CXONroKCb8/BP9Bfx1H381SAYLH+ZqczD+BsGzip9rFh/CegHOBr4oh+wJLCtlCYMU5BQezmgAooEO+3F3RXfVGzGkDwkYJbIz33DYhsiK3gh4tEw8FPZXtzyoSht5Gp67zk1c94IgvcqQibInsNYi8i9/X/F6iqKBoVNJkyrb7+P8JAG4bwmine27kqVGAZlqwq4Glr1UwnRVYAQi6wGWuq50ML17rHLEdOihyoOpA9SXTHbJLMTYFy1FepqcmT7SsqA+Wy+nC00xi7by1sqJ+2/kfhFwdoZdFqKVWEJ
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5009;23:11NxvluBDyO9jokGj2cnMHOlJL2ILmwvbHLZ+LDEd?=
 =?us-ascii?Q?47rUVARvxY9EJcpac5dcThmKwkjE7B6KIHKYu0jGcerCZD1IvPd5bPstmN5Y?=
 =?us-ascii?Q?bRtGxegclqzRNF4/BSf+8MFp/p4dtBUrYNPywu/+ZK1KDiz29cHEWw/gIr13?=
 =?us-ascii?Q?YkwjiUTCpgiYiUFnCh9BFSrES3e+/eOjSh9WmZBu8kszP08rACyXhj2Vk0cm?=
 =?us-ascii?Q?8lIK4BrgrAv+SFohpstfuUYVDrNzaasjZ/b6DF7Sf4bK04JMw9QnWbOv/6MH?=
 =?us-ascii?Q?zatEi061cfqRnEY7zKJFlHKTp5PflIhsAV0Iab14yNdMF5tXzTSB3ijnCrtf?=
 =?us-ascii?Q?ei5tc7P5MrjiYoCxsAgTgXPBbgiJyWxB76aVR65lKOklFuOxwTZwLExjJcYF?=
 =?us-ascii?Q?zs8k5FfYaY+BB4C+L8LoFEIp5FnrkNMx0vcRek+9wrDBL+iNlaRUdwgxbkCA?=
 =?us-ascii?Q?kogjVOl4uTCZhofP+MHZu8dnIYrcWpChKJYnIK4TZW4+OMrad75A04KRyjzL?=
 =?us-ascii?Q?yeyI/lSbjzYq0GgPbqIxa9uGLuVtBvxLw+/0OuqTvOvAnB9pDfE2VhiwRk/F?=
 =?us-ascii?Q?TQNCyesH8kt/eXbSxZdIjHZHs1ViV5fRXw5i4Q2nYdwsIEhFZysSwsEqy4HY?=
 =?us-ascii?Q?RPqF5LWMVn4QlVbmrMsYO3TC4uewkbg8I+RUNX0kOaxceyJujPQYKDI2ix/w?=
 =?us-ascii?Q?VcW3wIwnFjX19SWxIfv+uJDfthaFNEZOJURnkRU5yOtW1KB726LmKK0O2P/Q?=
 =?us-ascii?Q?wkuVGtY+fPlD0SBZMjkCRd/Li631pHhqcnnbzfFjt//fetmpbtb8ZqtwIY2d?=
 =?us-ascii?Q?p2ShculIbIxz7eRFGw0wOuZhdt5+pMJzm64IxHfYhNwJQvzCqe4U+2iU40eK?=
 =?us-ascii?Q?an65zDzfPSiSYaKUNBfPPM5CBcUXQupvbGsWqpqSBYeDOMJMCdNZxM7Y4NT3?=
 =?us-ascii?Q?K4+mtYK+9Ae6tXzteLOzmgJOTrp/Fj9DOZR9lY1/h1HsW6Ue3APuthvSUE7g?=
 =?us-ascii?Q?6SdEeBUPGghcDoRp8kFKO1iGyZgi+1RJKAkT9ONi1QnBo4EnSCGHdGHcJS19?=
 =?us-ascii?Q?mMawG29TOPkh2krhA+VgYv24NIEF60/Lk85NHWvX6zHHlY3qSOwIOVmPYRB5?=
 =?us-ascii?Q?yyOJqnkCUariAaOFU1B5WsbfF37KDxJCkxOB0v+0L1gA+Oce9JCViE92Xz4S?=
 =?us-ascii?Q?yaUrW+DCW9hY8sU7u80LtiXHlX9iQJ3T7jkSfvfX6v+Byj4RHjk0XOdR1MKn?=
 =?us-ascii?Q?M4mPFAf6/8i3Xp8tKwwAZX60e1wziPzb1ndXtm5Ko+4ynz3Dv05EQbGBeTMS?=
 =?us-ascii?Q?0QGeGkDIZmXpRBjVegGkcE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DFDgQX3QpStLw3Zjt0ao29LH3b7BXpb8dvZfwWNnkMjtcKMKICBWqYBUNxgtCYIG6sKxoiSL0ssumHStSJ1LUxTilImzQ5tqeiiRI4Eg53axGeGmEa2X7fM7aJ5rkA3RX7/7h2R8AvpKC6IxhoqbDl6orTtuNVwhVkhsKOhVrbYsIMGUpUrxNJKXalMBGBhIy0uIS+qgv98QDdgomP7p5WBPHqxf5Oj5IH84fkmFo+A7aL32Jtu58T8wVPIY1sYjp2MAEidp5rDhWpEeCjksksdJOSQqfG80ueK+GyuDNVIQCAS6Z/haByCtHktvtaGjEJ45lN9diSTZZxrt3CJouufmO+B4D8ri5s4j4v3Z835ARw5BQs6SPB8ZrZIp1p2RCYmGXUnMvU3bk7kp2DSpqTwoaZQcEsJMBPaeTY1DQ/I=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5009;6:Zd+X0gTiQjEdOJXFnBBW5KV8Td8sJuTkJaFtXHmI/Ecs1GYQ+wg1NJ56sI0Hn4jlhTTElgA3OZDJE5jSbifvki4AJLpdqWrI3XWLsaQuE5idzLdzVYxrGXmkxExTbpX3STb4n0Qn5YUsOV7UaGh580Eiv6K5IohTlLiTqbic2NMD8b6iFlxbemowprDhYgXM7S3Px3qRFNiTnqdsA49zpc1Pyc8miG3sGJ7XeV2m9sNcrfSRkM0GMT0kKjuEBgI2wmWkRWG9u0plHqsvCH7CR6QPwD03quUTLOkLxMa9lp1D7TMcLdFXNdUFXbYOoRHty8IIE4CBolETzIw9ed0RDCzl8M/RYk5mJN5SRtdkhfCHK1xFkevt6mN7KgDrcJjl/kSeNMcY5d1+wmJtFl1uzSAdjv5pB0u6R3FQyI7H7YrY8W9WTcxZR5bhNGuahNdqT1NIaI7xNKf8De2T6JO4TA==;5:sRqvRN3NcnVYNnvjdnR8EGywlr525tyTlcGnb/nUZ+UlX3exRH02zZ6xo0mmujXH9D1/Ao3/qDTO57K5ESIOxJ7ned7OW/ZprjuhrSxyDZcmbytVVK6GawXZU6Fnk4G0Abmysw1C84x8K1KxcAjKCA1sXyXjk6hRiat3WGcX034SwnD2qpwKKOX85BhbdEru4RiDAf8+KuZgTou4D4eR8g==;7:i7E/tnpJrrXGC1WNpTd3iNPZQQVBe5O79b0ylHMGvOYegQliMjtoMwA0K/Zk6A8AtA8j6ify04cmx3x1pHe29MljG9Qi3KXwnFIrrphNfq4L3auNCPEF3TePT221UR53U0VNhv8yVZXVdDoQXuDvFw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 20:38:53.4527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc698dc-5586-4b59-1d92-08d68629c89c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx ZynqMP firmware APIs to set suspend mode
and inform firmware that master has initialized its
own power management.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 70b5037..8065e33 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -507,6 +507,33 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
 	return ret;
 }
 
+/**
+ * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
+ *			       master has initialized its own power management
+ *
+ * This API function is to be used for notify the power management controller
+ * about the completed power management initialization.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_init_finalize(void)
+{
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
+ * @mode:	Mode to set for system suspend
+ *
+ * This API function is used to set mode of system suspend.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -522,6 +549,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.ioctl = zynqmp_pm_ioctl,
 	.reset_assert = zynqmp_pm_reset_assert,
 	.reset_get_status = zynqmp_pm_reset_get_status,
+	.init_finalize = zynqmp_pm_init_finalize,
+	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 07c587a..f84d700 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -28,14 +28,23 @@
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
 #define PM_GET_TRUSTZONE_VERSION	0xa03
+#define PM_SET_SUSPEND_MODE		0xa02
+#define GET_CALLBACK_DATA		0xa01
 
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Number of arguments for a callback */
+#define CB_ARG_CNT     4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE (CB_ARG_CNT + 1)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_RESET_ASSERT = 17,
 	PM_RESET_GET_STATUS,
+	PM_PM_INIT_FINALIZE = 21,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -208,6 +217,12 @@ enum zynqmp_pm_reset {
 	ZYNQMP_PM_RESET_END = ZYNQMP_PM_RESET_PS_PL3
 };
 
+enum zynqmp_pm_suspend_reason {
+	SUSPEND_POWER_REQUEST = 201,
+	SUSPEND_ALERT,
+	SUSPEND_SYSTEM_SHUTDOWN,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -238,8 +253,13 @@ struct zynqmp_eemi_ops {
 	int (*reset_assert)(const enum zynqmp_pm_reset reset,
 			    const enum zynqmp_pm_reset_action assert_flag);
 	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
+	int (*init_finalize)(void);
+	int (*set_suspend_mode)(u32 mode);
 };
 
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4

