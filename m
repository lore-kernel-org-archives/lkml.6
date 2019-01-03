Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802D4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290CC217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3HSV2fsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfACSJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:09:59 -0500
Received: from mail-eopbgr800048.outbound.protection.outlook.com ([40.107.80.48]:32410
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfACSJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy/mXKGJmoxufR8YUyCixRzueS1+iYiEvZqAHbOxuoQ=;
 b=3HSV2fsxRYLLBFVZb9tI/vAULz8W+eMP+2EresD5PY/8Rsh7HvO4+MhtmAeH/QjuVuBXuHOvc3I9pFCG6UqcOhfW196hoxRdhzS61VYlbUxX9XfBdzoGrErr/o2V+pZuX/d+APTGJBACK2lPx3vS9yBz/eJKiLuXlvOtJbYEUnw=
Received: from SN4PR0201CA0005.namprd02.prod.outlook.com
 (2603:10b6:803:2b::15) by BN1PR0201MB0721.namprd02.prod.outlook.com
 (2a01:111:e400:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1471.20; Thu, 3 Jan
 2019 18:09:53 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by SN4PR0201CA0005.outlook.office365.com
 (2603:10b6:803:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Thu, 3 Jan 2019 18:09:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 3 Jan 2019 18:09:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52610 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RH-0002J1-Vb; Thu, 03 Jan 2019 10:09:51 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RC-0007gG-Sv; Thu, 03 Jan 2019 10:09:46 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x03I9hGU002772;
        Thu, 3 Jan 2019 10:09:43 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7R9-0007fE-0w; Thu, 03 Jan 2019 10:09:43 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: ASoC: xlnx,spdif: Document spdif bindings
Date:   Thu, 3 Jan 2019 23:39:51 +0530
Message-ID: <1546538993-55473-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(189003)(199004)(48376002)(63266004)(36756003)(305945005)(478600001)(8676002)(11346002)(106002)(2906002)(9786002)(7416002)(51416003)(486006)(50466002)(2616005)(8936002)(81166006)(76176011)(50226002)(476003)(36386004)(5660300001)(336012)(7696005)(126002)(6666004)(26005)(356004)(16586007)(110136005)(186003)(81156014)(316002)(39060400002)(47776003)(106466001)(2201001)(426003)(446003)(77096007)(921003)(142933001)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0201MB0721;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT025;1:e8GOyyFgS82J/4eH+56vB7vFQGoQ/CdGqNIjFHZUnG768UFogzRvQnw9budURQF+sBXvQW7Ktla7xY0qICGGfC1g6DtvBmZp0Yksr8dFoeg7Pk0zOd5Upu/ocUShQjWB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f6171c-d018-49d9-7db1-08d671a6a8cd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN1PR0201MB0721;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0721;3:nXkRQB4O+Xlqy7fdMdWD0SrS5+5lUj58ngkWK4EtdudVUG/Infz3uFVW1cWHXrA3wVIb/G3TOFgcpQ47F43Qsr15ZLqQkZBBx+voXi97vB/fBKPsb5qK3QfRlcDrM/XO0/NHlWhTI/vMt49nyQo1Sa7zuWogAZ7jX1FwwPgmIu8pF4g07dFXPY1GlCBogmRnlDKddHKxfX1rESNcqSXaEoPHsJRXDOVSeRN2DHzKQjPIdEz/wNVlUvA22ldvpiWGUqsNlKzysq7Mgl5e8NH1Kr6yIOiseJoKUlNFTcFaSSsbJ7yqN5Zo12MqxVqyxpQZvTM15l4RDncxoMs8C8xwdWJjIVfpTk4vkx2nCHBAxuA=;25:CzMhd4buEC3rA5gM2dBa3YDKFZeourPqoI+DftTo1LEHSkfTo4JUzpEzNY2J1Kpl2ZHIlLISpZTIr3csIJfbRHarRXzjWkYQ6ZMNPiHS3mcfX366/OecjFQaJSfUf8KbMj0yNyPb/pNTtFYnFlqfsCaKQIbsWlO84+l4uZjATfm9g/a2W3sJATEVgdYI0pEfe1wJ/1SOzxkCigsamOkK4qItAG2psfxH6uWG+8tNd6+mJ18urs1EGvwkZmlKxTA0/9b5A5atAOujo29Yx3drh3eBf9w8wWwERluNUbRBMzpJUn+vTaBICKjwF1WRerrUDjZRY0wWVdo8ZLDlhK5UFQ==
X-MS-TrafficTypeDiagnostic: BN1PR0201MB0721:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0721;31:fDWcIsrWBHavfiLLwtlU4eZfCW6ZMyUu6Mn+5kQqH592njCCpWEaG5MIXY4CDkJKW0CAO9wvrucMy29m5yUA2QvIwEw0TDru/2hPOuIs3m2q+XdQg4rwQToEAPhWRK+0W+TyRkPXmq87lymjrnZBEylhGM894UJ1np0nGPb+6zhvlujlSK05wZP/HiaH28ro2Vq/BNJS8RAk9D3ov8RioHAqgxFRWh6eJRasx3DFSUw=;20:mDo1hfNw8qNICzqKeCB2sRdAu3RWMfYVeOn8XY+J8J1H0VSo2cCdYcc8dtH2AkBbuK8r9kest3fE94v1XPuu91qGi5NqicQMAwXu9wys+DVYhwe8llyTC9TIvdfRhYeXqJ59mTJvIi3bqHt9P5Y//bXKX2/W7RjGXvJMSz1t12X9VygL7zfFSCrrHZhC0RywPKDj17HKYPf8YlTLe47yOGCQNdZ9gbCKfa61FWxswEMSLGTORAIa3M8GQJccVtIpcZT/dq45O1UVBwSzJds//i50Al1xVf5PjaFOFLpXvDAHqt+kJ2WFDdcVKqgA8FXfvDe/g0LQumtRonsYU73Z9tV/yq4OrMhXc/oA9Sg66btLEBl8OgqYrBYpygWwExNaCVo14NpPHrB538KwEcvrf+W6i77j+RbTLp+Nv0JSo8b8k0J1nI7JCa5AjixwUpDS7V8EPf6pWAd5/aYsHpUFVvzwyAnFALnFzIh0BDXV5Mk6y4Lhc1Ks30cwIsZbVXbW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR0201MB07215DD68B8D620575A720CABA8D0@BN1PR0201MB0721.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN1PR0201MB0721;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0201MB0721;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0721;4:APaCmN3Mz2yeGSXGRzKQ5tcGsT8k+6Ll9HdyNEowj7vgf85M2Y2uYfb76OrOVHJLzKzwBLlE008WMJb3hcqAS4xNFzGd0OcjuWZdJgasne3yZFzN42Okl0WOO1CjTpAWolCfWaNTTwleNQTUtoo9Ay4yetSjBJwp1V7JXQA7XMuzOtrW/Loconto+MeUOtNPJxnsDnRaHLoilL2rOmecwBXPZtYDADK85XTGTioYLWcPVYzoxR+AFwYoz2OTwHrCYjMy92UNar6QVqPnFbaBQw==
X-Forefront-PRVS: 0906E83A25
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR0201MB0721;23:BjP8p4GPdhdqe0Ryp5lEu+nFquXxQ5lwXvuVCOV?=
 =?us-ascii?Q?Yr4d4FuJJO3IiipWI4LLY0DagM/x5Rb0hbQKZ5DIyihU2gTG0KBlMA3JTADz?=
 =?us-ascii?Q?KzBWjwLhxlcHVuKYrha5aP/RzvFzXIfsIVgKraY+jMIjzsmLazdmXs13id6d?=
 =?us-ascii?Q?kaxIMNLjj+Ylx9cyjGsycnZOQhiBuPoaV2aI6yVBWDuPwL51/y3y+Eb8Ujf1?=
 =?us-ascii?Q?1+b3/j/jHmCy61+ycS6oQM5O6G+MwN7JlEFdIL3j4AYyq9vvtKPtnYmHcSVW?=
 =?us-ascii?Q?StITs0sw1jaXrw/Ni58KtIHnkcTbVAimis74pGHgrue+cUkdd8QwiKq1Nhx8?=
 =?us-ascii?Q?mVcp7bmz1PfBBVHR0rBNrXSziLixzzk1Q0bfTpqRbjhU1SrDvwJquar/Wk06?=
 =?us-ascii?Q?qGEWKNB4maN08IRiwHXQPUrNMX/B+9VKws+3eu6MYvNxlXI6s0o1ZGTVzyA3?=
 =?us-ascii?Q?7RARVdzUvjcXnnVz2rb4DulADogvyO2DWYtrnsA98mely+Ji8hw9r7q3zLL5?=
 =?us-ascii?Q?VYenPcW0r2S6bvpJiBFcbkrtk63IQZIWl4WtUyAK00YBqmAK0g2BnExo5aOR?=
 =?us-ascii?Q?RPSxjZYl9ZVTEujvbdHsQIyO4+zhpBwOMC8OcLYmc6xDA4/prQO8Rh7rzcqo?=
 =?us-ascii?Q?PGlO510fxxAFf/I6kmCn/NDK8Z2dYRA5lwp1SGt2VjzpMZ5lT/g6JN+IiR1j?=
 =?us-ascii?Q?pJ5SVkzeR8q9ecZ5fvMWTqbT4MlZCBiDA2DAGB0JkiAqbxPhoxyRGR2Ika2m?=
 =?us-ascii?Q?/sa4ea+RQTljz52fgPYuOXJqWXOXs87U67pBQHX2q8nxLC9o87lqRZ5s8TGL?=
 =?us-ascii?Q?ODoo+1Sye7jPfYLIjkx++Dbq2pIQztEgIAUfibKruKNeA4JumDKsjkjA1/9f?=
 =?us-ascii?Q?oAGv7xz1APkDBz9JHoSa/W+8wslAoGGn/vxaUZmFjTAWO2S8RubXRVzEQZhM?=
 =?us-ascii?Q?mnYe+3aGikLZ9ffsm/sgaV03EHlD4ujw4unmeporxLMjg9cHWigi+wne83GT?=
 =?us-ascii?Q?UJs6cIHLvndoss7OzyuUGAo5bO5B7mPTDg5vvsfGiOUcEF6BNfCCIkuju5nH?=
 =?us-ascii?Q?LEui1oIeyseLfIOyQ802SD7g/jd37k/lG3vZyBce4SxBqCjtx4/D3rUO49ME?=
 =?us-ascii?Q?C6P7SM3L7pCKmbY4qf9m9wFBhM8gRkCTjccucrUxd0hfuJLAq7p6S+qBu6WF?=
 =?us-ascii?Q?XL1g4SYKz2LEcby0=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QRh3PFYlkN95jE8epyRnfFKp43LsCgs+JyPpm/jwmOpQBQBVkdxtcENBBW44DcnlpUETCpDOl2se6cmDnhdhgC3FjE/je1gTPMPGbzLVEmsJY6xv/iN7+5l1c5n8s1jYZJv9KOsHUBuCsShJip2uZRDWswyr5AWF2OQwCguXxfe0KR9Wdvco7opHGSW48u8fIzgKuPSIo3HTLDF1LWpEYQ2nlQ2KIl++wzgm2PVUy6vEcS4t1QzajOUBtnyfMHv/chg6l2wbM2v1Ug0vvSgRbrVjKKlTUZLltIb40A7JDtJp9ML+bezMGaur2v49E9vS
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0721;6:0EfZBCTAdcWIYT1L9RMnUrS6ycRGb2JJH42NbYMl2Qg15GXM8k9/t8YI6+FOiPtm+WJCmTXq8keXj7JqWkUCmMl/ASNwpaVNYSlRZmWWrJVk8LP4Qt+oIP2/FhK0HOF/YJRKvn2tav1h7myDl6T6QgATHdtefb173Q7PiL95we/H1JjBo3mkNR26vEuDqc6+2ep8KMLluC/wk2C1gBYXoe26zEUM3qy4WoZtTDxOJOY4T3OzRWkZtunioe4v4qrcbINydbEMyHW7LvJefTX9sVIuM4aX+z68aY0Eb2p7boMDznku2S9CcLUk2Kx6p8CAP2W+tQMkXcYva4eGHEwEnTmP/2WAOlnDBEWjHnXLWQubTAJdEWPrnTqyLfXrV0ex3iMpp6st7scz5+qH1G3rfXS1DOWKfOQALJeGXIS/xdR/TG66lGs5F2Rbf/dL2fatwwuhNUv32JuH9sj11IAyoA==;5:Y8BH35nDa7Jooou10q81tKJ+k704Sb6PP3J2mPhfQpqC28Kyp5ZakLUIlxYKd3kne/sersfh6T9HqHpcjkDmV9KLGc1HNBslXvkWkn/nanOnBb7z2hwA0K62qWvbtqZr2rUqLxL3IfqZ3OZLotRIrAweCaiPytNI/+Zw4rTIeGA=;7:T0HqGu/mg5Xd1EDSwJYOmd5TbqV5PV679xQzZk3X2ztfP83ktGcSpZqRX2VAIkLS5SLG0HNYhFoWUhph5n7yc0hf42WaaKJGl8dMnVEQHH0r/H/GShT+GPipHhoipyWdWa8lCZ6wFVAO9S0LQmbmCw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2019 18:09:52.3959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f6171c-d018-49d9-7db1-08d671a6a8cd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0201MB0721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation for SPDIF IP DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 .../devicetree/bindings/sound/xlnx,spdif.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
new file mode 100644
index 0000000..15c2d64
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx SPDIF IP
+
+The IP supports playback and capture of SPDIF audio
+
+Required properties:
+ - compatible: "xlnx,spdif-2.0"
+ - clock-names: List of input clocks.
+   Required elements: "s_axi_aclk", "aud_clk_i"
+ - clocks: Input clock specifier. Refer to common clock bindings.
+ - reg: Base address and address length of the IP core instance.
+ - interrupts-parent: Phandle for interrupt controller.
+ - interrupts: List of Interrupt numbers.
+ - xlnx,spdif-mode: 0 :- receiver mode
+		    1 :- transmitter mode
+ - xlnx,aud_clk_i: input audio clock value.
+
+Example:
+	spdif_0: spdif@80010000 {
+		clock-names = "aud_clk_i", "s_axi_aclk";
+		clocks = <&misc_clk_0>, <&clk 71>;
+		compatible = "xlnx,spdif-2.0";
+		interrupt-names = "spdif_interrupt";
+		interrupt-parent = <&gic>;
+		interrupts = <0 91 4>;
+		reg = <0x0 0x80010000 0x0 0x10000>;
+		xlnx,spdif-mode = <1>;
+		xlnx,aud_clk_i = <49152913>;
+	};
-- 
2.7.4

