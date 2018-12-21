Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD86218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vaPMOeVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbeLUI5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:57:45 -0500
Received: from mail-eopbgr820055.outbound.protection.outlook.com ([40.107.82.55]:63571
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731074AbeLUI5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVTH2iH8SktGBsxpVsVfjTqRyOWL84zOGrCbYo4/W30=;
 b=vaPMOeVdHD9ZUFYAz67t1Z4AH+10CkHHD6Ui3Lq737AyEOt3rT6IU5J6cYIKORHNOXGnNUexHY22v9apnUoO19Q72BFsjb/7G8GCNstJm1vFsfGmC8ne4UyIcZzWa1KRLIf/GwKVZJILHFm2L7sTRXzz4LOE3sg4anb1dBLVnZo=
Received: from MWHPR0201CA0043.namprd02.prod.outlook.com
 (2603:10b6:301:73::20) by BLUPR0201MB1892.namprd02.prod.outlook.com
 (2a01:111:e400:58af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.21; Fri, 21 Dec
 2018 08:57:39 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR0201CA0043.outlook.office365.com
 (2603:10b6:301:73::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.21 via Frontend
 Transport; Fri, 21 Dec 2018 08:57:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Fri, 21 Dec 2018 08:57:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33405 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gaGcj-0002Dr-8F; Fri, 21 Dec 2018 00:57:37 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gaGce-0008TF-5c; Fri, 21 Dec 2018 00:57:32 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBL8vP8R031549;
        Fri, 21 Dec 2018 00:57:26 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gaGcX-0008Rq-9E; Fri, 21 Dec 2018 00:57:25 -0800
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
Subject: [PATCH v2 0/3] add Xilinx audio formatter driver
Date:   Fri, 21 Dec 2018 14:27:26 +0530
Message-ID: <1545382649-181411-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(50226002)(63266004)(2616005)(476003)(126002)(486006)(356004)(305945005)(81156014)(81166006)(8676002)(7416002)(8936002)(106466001)(50466002)(5660300001)(48376002)(106002)(110136005)(47776003)(316002)(36386004)(336012)(16586007)(426003)(39060400002)(478600001)(7696005)(77096007)(26005)(51416003)(186003)(9786002)(36756003)(2906002)(2201001)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1892;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT008;1:0SCM9hzqWOGrQz/YCvdNE3cMZxbEkqrMeXox8NJ08zVZFpIAyNCMy+3mgWGr7QQBGHyQUiLahBVd/aI2tzKVw/xoAGs/sBgNpprJRwtPx0kEdoHlLUlQjgwqseApuDXK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5a7e77-9b20-4592-97e1-08d667225b76
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR0201MB1892;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1892;3:yyU4Mxst1XUzYpLXoY3VKUIYLXNaS8zrjgy5ygYq+9Q8NDH+rzCL0loLsLWijeAnJnyEKPmMkUnRNC3buBDWDct8Ygr+8Zqw8oyB5LXSGaIEWIKag0lqVnQBn6UiKgAj6AIZC28UvuG/IBuxmDDwnhjbxm4KPLqq6ltl3L3YSXrWWmVvQTNWF5gDt/fAIwHYD+W6rkF3E1zwkxckA0pzrQCq1fi+xwy++T3ZdQDJIMO4sxvRCCPxxeECZs0Jz1fXCwVlXpfvffvNdXIgeJKXAtMy3FOV4KbtaPRqa6taOvIDeZ0fU5Ddf65g9KAbkXmtzPZfKupMu++wwMU6UvarLT+HybhAZryLdQPlj+RIZbY=;25:y+mwTxvWvXSZazTuquGKJ5ZxDVvVat56ABcYy5dNfVNIBlg8RXcVvk/8n/gaAetYQz5rhH0gD1gzhLPhQp2wArjSWS9/Jo/0DciIMdQqI4rvInIBVUT3z8ZOEn3IfVmGJ97e53ebe6bR2Kplpo5uBbtxaWwDqEOhSi3ECUw1dBd9l9vAXr30Y1tf7GW3j8w0Auy60l9/Hfyd2tBxcxFSC5Yw3iapKmBTfye6D7G1nnG6ecPvE357C2L0N3j3t2kRPmw5zC8g/tlwArx1/MN874+ybU0I/6nZx9BQ2mnlZD5vOgupxnBBBnYq7IIDy+48TPZnua6dUS78qMMXuGp3jiOgfwYy1DULFtuyo58HCPA=
X-MS-TrafficTypeDiagnostic: BLUPR0201MB1892:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1892;31:34l7RbSbGBm5fKN4ET1kZ03R6SGfbhFRCSY+hKxNjoCUSjmgUGTY8d9gPtnmz7WOg+R0UVuxazHEQQ71d1PBUsUozBw2vsVGMk4m1CPSeBmSp5i4HpCcpE76I8m92u4bvfIa7Eoi1ZaYJYtCgzS2ZazlqzvS5DuogIsPmPCEBIETXegnNVZsocN2WDtvF1Yw5Dm9dRITcCJCXJxQNOWVI3nMPtHkWlV2TJXyyaVkQUk=;20:C+E6nl4mt+WYmEYgjP0BG5BsGL8I5EwENBqP59cyIjhd08W/yKk+yM8TNJ35d46xH38sMvsK/YpiDMb3UjuOIrOiGw6Q5V+6gmxAhtSUuBSFkY52m6B3Bnvw7eyhkb0iUGeX1kDaXcClhfftirfTBCeqdu2pKujfCeEGZh1jX8HtGyaXSBw4LNwnilzsTWfs0UNlxpe/pm5tMV8NxkpvX75Iye3mzGZ1bIffSpT8fkiRYi3lvrF82647mk5LaKyMnzmxSB5O2YEMBWhlhgHJ6x1jb9OWoCGRTbKv0igwaFwwdbx34QTVI+5Z/VvdXO3jnQsKE+3mgWF3v9tMSCii0PlopQlKR+28nDoPm7vY7VquPrakRP9OSp4yp4xq0nWazxpGQ+ZvfUZgF3pnCaFNpamEngHCw8DhSibG40s7ZFlko0vLVOzsCWQ8g+xZOFLj/vXqCDTLrd7M9fewB2c0zPvafIoK0hJUfClwuAMqWwYwlWcf0lfLhEQX2+qbYIjg
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR0201MB1892BF1EDED72E5284D88E17BAB80@BLUPR0201MB1892.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR0201MB1892;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1892;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1892;4:z3Z0lkvMpYqX7FPUNX8UxxUQOPjF32KOOllXCNhLaR2ovIeaOWpCsbF4DwR7/nx9AFjpIZGeDAlqWWbgh6vRdiIyJTT2qb27HcwLY+eIFsKSnNhEQO4fUcjNOLFs0U98msC2CWWKPB3Bys4ZDavakfEBzgs0nmWj3Y9BetMtglI6j4fbenGMYQkCqWwRN/3pu1h9yMCsmXBenPJ/08TxowJ8Mhfw8I7FLHncFIhPDbpbkOAJZQKKKFeMdDtogm+tqlbv2RBALf+C3OuC9h5AkQ==
X-Forefront-PRVS: 0893636978
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0201MB1892;23:Hebsb6nJKlX/iZyrkZQ2eveaReh5NHA2sLpJ98G?=
 =?us-ascii?Q?l4DhGzdiroEilWwq2nEXlEZ6LjPLg9nKQpUQpMJbGvUfHOaOguirMOMfTXov?=
 =?us-ascii?Q?lV6mEhtEedxD8K1MDTFr/97TZZ1aaG7QZDdUYETizajG7E9mf+/K+IifIWVE?=
 =?us-ascii?Q?GNdP/wkpcOICEzgIVKpyA2Sntl1W0+J7P9aMURCGF0Vm0JRv3F0gMBDRhdFm?=
 =?us-ascii?Q?lViXzi+fM6uZkuatFi0NMf6QXL2nzxd5KAIIDOGmLhv6jUXIEHLFvJ+rz0C1?=
 =?us-ascii?Q?y6WUazkDa7DQC6aTk+DUlZbCtIOk6PKoQo8dI9BupQu+uAvQVFwxVQXIvqp6?=
 =?us-ascii?Q?5ZuM3iSc0MiGLntGSU4bMY3mpGShxRQJUBpC7ISh8dXZLIxoegInGGfT8Xgz?=
 =?us-ascii?Q?gMHlBRGnije6RxdoehVuqS/gyNS0PzPOq1/Fo944VQ3fuZ1Vvl5CrYD+YM/w?=
 =?us-ascii?Q?oktRz40Gd8FiKH8tbBbFu7CvTGli2gUAYB6O02wViLORmF4Rieav4JEpaKPZ?=
 =?us-ascii?Q?tHFmhi4YIBMCg1aBiz1zHEnn1xZsTZmL1Oae4J12A0vHTmg5coZ+si+T7pm/?=
 =?us-ascii?Q?uFkRTc4gU0SMf1t44C4hqdR1Gdtkum9tfUAXAmRbctVyoBlozwHiPX+3/Bq/?=
 =?us-ascii?Q?BXYuAyi+a1vUZ3vva1mz4HJwHDa8QLBp35Q6pmtp8yDG4qq4aL6wA0+8z86m?=
 =?us-ascii?Q?eGAsn0TXUjX/3zUVrrWIyzj0tZ+hFhiEW6FKahqxgSk8sfi4+3qumzkqL/lh?=
 =?us-ascii?Q?3hIbh+SCU9sLTiRi8yj9ENzhrtbNV5aVj+ZrKXLTji0yCLAH+As4/ZUw7O9y?=
 =?us-ascii?Q?5UdMr4vqr3/P1a2/nruEgCrCSJBFHtoZkj1yvXrfekFSh95+nMd1sFm7rgLa?=
 =?us-ascii?Q?AJOBZSvdGoalCkLdWcClJVlHW1ba1b/yl8/Pxs9iHs+SUGrOfX88vu4ddaYg?=
 =?us-ascii?Q?jKEmykdIsonl6n0UZ2K0mEov4fGLjUQAO5AYtFHjCetlBMtxiKp2iOMC2MAu?=
 =?us-ascii?Q?jM6L1zwuGIFYThTyvbY8JnfA9IayRXfjR5HBXIO0YliVmNYbBxQKmZd9MDWI?=
 =?us-ascii?Q?bZtKADNSYfU9QeNBKgs/UzRq+52dG?=
X-Microsoft-Antispam-Message-Info: UCTFO2uV0zVl8qOMGpY/+U9ru29H7rdTl9UJekvRClHa2OrqbbippzZjMr4kVV6Kghx0bRs/J/Vy+DbdSVSAR2qitteDrdEfRUKEco0/TnamZUm8dqOjkfrUubvkITnr6hRbSE9xuAYSI31tCFfemu4nAYe2bq0lmHqRcnd38rHTQp73Nv3hooTlzJmRWvyIBkWyKgRvME7ruBDjIP2xQpszw9Akf4wNTojKeA4IgKXo8H/VaEVPLNpZ6ZyzMvACZj6GRcaMvztz1JeSGtTVZsTnLlHtwpQiO+9n2MMdcbsn7cFCTneidBQ+VSZiARVL
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1892;6:sai57Ob+u0sf4eX2aIxhvWoi3r2uD+EcUtdLzkFsdxDKYbv29poyqKOxrTIbC1e9mX5gD1jVBpLqKWoKsV18GkSL/XirIAJKuiLwxrlrCRx/xI+a1wXGjYmIUOb9G++a5rRHGIFffePm+xdoB0ZGB3vs5RJ3yG3es+tUDp2BdRd5vrYOtx5wZpiy+bXagvA/QmR287JOiuMyeUBza/J9rGn53+m+G+/XA8zb8UfzBHUjhII3xHAiNyDCdtQN5NLAKOApc0mWmCxMj6DhXOJxyMkoyJnabYmJy4OOppw/zdoGyuDxWvvWd7YEwqcBZkJO9aBNEk3uM3l+oPiIpm9g6g4mPE0hiAD0yFY46GNagQ+uBx10vMUT4QTfvqmd66WizYAb61NrHd8pzf9HzdE8Fm9tgmB6R8p7gqZDQ/RgmuTNZxiUG6lklCHsK5NIHOptOHDf7Ct82yDlGm89A4HKqQ==;5:ofco6hgjl5e4TX29KQ9z8rM9kE0F1e2buh8SiAKNx2wuPlz66j6xp2X5smVuJVG5iIBsNoqqmW0PRUYR1t8+ysJpZ4yaPaIkK7f2q/3Z4HYGAxuXnow5vhA8bsjTUlu/FTR1Yp6k6zJysZ1l9rqalckKYHlJkKFPNvnrwQb/iRc=;7:h6JAh3iOk/8VMH2HGAaBlHWu1aNkbJg+vrMhX5+jLZGx2Dj2yPTG33HFI3Dxy1J1/kqmb+NT49ihZQcIY5BV9wRn1vPLVsAUvNsvQaF86mUtyvR6xUsTiArA2qg2d9hWMch10JKe8ZUafYN/qqlalw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2018 08:57:37.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5a7e77-9b20-4592-97e1-08d667225b76
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio formatter IP supports two streaming interfaces - MM2S for playback
and S2MM for capture. The driver enables DMA functionality for both the
interfaces. Patchset includes devicetree bindings documentation, driver
and build enablement.

Maruthi Srinivas Bayyavarapu (3):
  dt-bindings: ASoC: xlnx,audio-formatter: Document audio formatter
    bindings
  ASoC: xlnx: add pcm formatter platform driver
  ASoC: xlnx: enable audio formatter driver build

 .../bindings/sound/xlnx,audio-formatter.txt        |  29 ++
 sound/soc/xilinx/Kconfig                           |   7 +
 sound/soc/xilinx/Makefile                          |   2 +
 sound/soc/xilinx/xlnx_formatter_pcm.c              | 565 +++++++++++++++++++++
 4 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c

-- 
2.7.4

