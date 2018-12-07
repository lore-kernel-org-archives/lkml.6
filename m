Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44870C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A3820672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p/ZKOoh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A3820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeLGSd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:33:58 -0500
Received: from mail-eopbgr740051.outbound.protection.outlook.com ([40.107.74.51]:57568
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbeLGSdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U2iyR++M5JKM7tQ39P6mF6xiktAJtyMgljPS83cvpc=;
 b=p/ZKOoh/RVsy7ZIjBjTHoncj97RQW2Kxj2MT8oB+CijyyKxNY/12AOtw0wWXNvwEXDy1gbTphBjjjQrmWFay7gsBv+i+JmwfvKgxi+W8lLGz2lXFSiRKOi9QWq4KHoY21N68BKMWgA+dM99aTC82HNAL0oCO1TxYJKclbwGiP/0=
Received: from BL0PR02CA0065.namprd02.prod.outlook.com (2603:10b6:207:3d::42)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.22; Fri, 7 Dec
 2018 18:33:36 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BL0PR02CA0065.outlook.office365.com
 (2603:10b6:207:3d::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.17 via Frontend
 Transport; Fri, 7 Dec 2018 18:33:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Fri, 7 Dec 2018 18:33:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwN-0005br-Mk; Fri, 07 Dec 2018 10:33:31 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwI-0001sq-JP; Fri, 07 Dec 2018 10:33:26 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwE-0001ry-Ba; Fri, 07 Dec 2018 10:33:22 -0800
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
Subject: [PATCH 0/3] Add Xilinx I2S driver
Date:   Sat, 8 Dec 2018 00:02:35 +0530
Message-ID: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(2980300002)(189003)(199004)(486006)(36756003)(39060400002)(47776003)(106002)(2906002)(16586007)(110136005)(7416002)(8676002)(2201001)(6666004)(356004)(77096007)(48376002)(426003)(126002)(26005)(50466002)(7696005)(51416003)(186003)(2616005)(476003)(336012)(81166006)(81156014)(8936002)(106466001)(63266004)(50226002)(5660300001)(316002)(305945005)(9786002)(478600001)(36386004)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT017;1:O12PMvKhVuiWGmCwDttT1/7YxxyxhcEBE4KSsyNvg8HNrYSsBQ1lWD97OW9bNFSTfKX/zIe09JVnrszvo5OL2kipw5y6nCDecAgISKFxAqnjnX/MpytWKaQVfG0pJjpj
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ce770a2-9ef8-430d-7e92-08d65c727fdf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:INkIcNEvR7NiBXURq1ZuVDMHyG8mjhYJQOF+IzdUSoB/KnZNdYvsx+GJfSkniAZfgnxu2dTCPjmedIzO4z6+TK+XYDFdfmcMCtE3J1/C1WFS8VzgMkXP21U7MnJ+jtKzXLx8OJ1Vo2L7vkBy4h7nN9T08vMHAq2Vek7BD0wFp1gsJU8c+Wy6H6hmvpo0jB6xt8cnBHb5xPqFtrJ2hGxo5He9Tcd+6lycGHQXKagfxd98NKREv0+fdX3Jv7tA7jUxsuDp71FnjN8XmACUBRZ5TyngUtZVW6LRpcvzat+ZaBpiEGuWTb5jt18YFUXLSa06WFHHfrcEaVwQNbWxuMzet5pGDpr6eJncnLGxueehaBI=;25:0LWC+HKs3ZU8LIIiZfJns6VWmt+7pX7RlCyfG5Vs5wMmkh+mByXqCUybUPGHgy1+P2j277c6hSpKLltil832TD4HsRaYwiMvjpHfuhSGJqvuCZDBYsKgvAIxUG7+snkRAgzJzrUsLDH/o38RDoqz3JoSLWumg6xsCQwtR2UF0nqykqiMV6Ft5J5O5NGylYAI2O6WgrtEGsVSIx9hFqSnNn28KGrCPCtZWImCMKkVo9l5TWBh8xrvNeEtUJMzHTpeeLCu28/pDiZzwBzuUmN/5y+053Gq+mu0du11Ae1MpziEERMc7EjkG2oTc7qOODDC3MiR2ZLo5uL1HaU3ovZS0g==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:H3BhDoxbCoOxN8/4dLawDieib60oU3BRVcqcf/FsAqqioknE75bWRZ7P1AnBTm1zdt0lUce8fdItA9GMUQ2XPXsN1VUC0rwFGXtW7My1dYD5Yp6cX+0JxLztUixaiesJI97V1eQJYcIq0OJeidTcxVSLsgcB0BtlJO/0hU56ffP2TqcEFm0A2mcr1cdGCNp2REWbHMZjUhN+ed2FSorOWKSAwKfDGpH6bCnviuXKIqA=;20:FsiNtdye13UChis7i4js+mKV1h1pyk6+T9efX0ZQ13voj50mKqVe1Cf5+MhqjN8nnjx6jcPIq/0MIkoocZ7uyVkXApl2HxwrOZQcI0Uou/S6kcIC+fedaXiwYqIabOccnl5S3Th4trgTh8XgH0IHhy4C/HZ9bmXVIvcmiMzFUygmo0iUIJ+kQhsXrC5XiLiQotJnXkNO4Hnw/3+198BGZHlEhIDD6o5myxjoffyXsu+p7p+zS15tRCr/oYMCftnkR/AYOnJmgAw/UTRZtAMRL2s99FkKhj3M6Db1jg4OEDUlOqqLGdpFXzLzVXDwhMeYi9gqrHVWg5oZ4H1375rAYM6/ngdnL2Pj1mdAJs3FrNss80sMlMlxz8N6spQSd9YRL7nePyAU5qPlreZJ0gsJjIUupvAZI3dAoodA7bJKHHXUfLfYAjmqyYN8lt2sXX1VUnH6uq221mtKs0vrtMAdlo8LGc6LxE5m5IDKEkew7UTt8MHrb1nvsAOm8Egfgw5K
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44492B57538FCA3F9228CCB1BAAA0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93004095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:NuP95rGiqL5zq6dBKaMaOkK5zHjpnbvnO7s2YQYPrXnlcK62Lcpm0EpzVH706VXSnDOveN5WxiAC5hOdJWW5yMZ4kNI81mDBtuS4uleW3HTqSBd4p/1u9tjmXbvLHbZ00nEupYfd3XNHmuYzxvKwJKjQqpjPrPbyLFYC0KKyIYPOIxxd4xmKlszKlVhPdQjpeCQxP5uoFucnqaKJh7WmP8THmlsHvlnjnCrEW4u++RQSZLZGIJOpjI2VPIIgUykxx0iK/KEhywRwJdxwd0zgzg==
X-Forefront-PRVS: 0879599414
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:FexbKCHBl80cSHtWR+G85iAeuyEQcZzNWqOVQ4EDc?=
 =?us-ascii?Q?lyRqxVQTUNwThcFhI4srLx1XUGCsD2CSUoVBKENMsX5feytifYv1QjSoZn7u?=
 =?us-ascii?Q?5iI0PI1XvMSztJTlqxzjkj+w6vgKxXPT40j71dLcmsrwS3rwPO3hpprKtd0j?=
 =?us-ascii?Q?fsZ2QdagqCppGx3Lbek0D9Epy4u6gYV0VqCDYY8JZ55Yxu66artUb0IgWzKl?=
 =?us-ascii?Q?neUHf10OzFvZAqPPUyZRlUp7+c5dD3abITkWAuiHvVQys3qSMxi/imktkN0R?=
 =?us-ascii?Q?GkK4UddVLORnGoC8qiTqsfn3gWjib3nGvT4wb4K+n6uk0bm0WliMOi7SNlsI?=
 =?us-ascii?Q?pkwvXMyyMcAaLQfamyYVEIQA9uMaK2c5S0Qb2707/MHjnY6rlVb8pPgHfrZl?=
 =?us-ascii?Q?s2v5owglHGDm/xQc6MbmjDBCI9KwzGa2bAWRkVEsbJDawRSV7KaWePrUfvF2?=
 =?us-ascii?Q?yQ8hR2ByyoHh45ZwlGiwqypLhn8xb4PAHqoZELhJnV+ox8WxcMv2b+fc3JcX?=
 =?us-ascii?Q?E9byGr3n4sVTU6OxoYi/uW8D6YMOubRDtwuPliI07UOJw3LV6WPM5dPwOQFM?=
 =?us-ascii?Q?RqBEBVOsIbJbm3zZPyv/mAHnLUIumzfotrkmRiHR2APK7b5OPJfJpJ+8E4BL?=
 =?us-ascii?Q?IEqLS4/Kit+V5v4JNmyiV2JhM/Jp0w44xV7EAIKcOkvP8mQVf5QAhh4Hpd5w?=
 =?us-ascii?Q?MRUSS8KKC187oU3ZhfNqwd8a+SZdeRpaRzlbSPPskhEe+RioFDGbJugmj2xU?=
 =?us-ascii?Q?8iJzUSphY1xSeZWrvKeeogu0Z/mZ6PQcDXfsMxxswCVet5yeImR+dhJmgpeG?=
 =?us-ascii?Q?GIQ5kbbJs8H9AODpn2H7LG9PAW9Bkok2OPSljmgXrtIst+2Vns6jgYaIWToC?=
 =?us-ascii?Q?GJRjmi1lMRXjEEl2SguRrIvIUJJ6xAVhdlnWmyaAXBB7NtgglUkvvNXq4k1L?=
 =?us-ascii?Q?Glo6C4qZcaMhrDz3kj1vWpRzQ6OauCjp3aAspQllzZpfCf3dq8Q+m8FZ30FB?=
 =?us-ascii?Q?bo27eO3thqwexZBYoEAJIl30ta2ATtjwGjcEFAv0SiJqfY74ApUlxlxKfNnd?=
 =?us-ascii?Q?ak7f6CJgmT4/F7fIFyEG+SiQIr+?=
X-Microsoft-Antispam-Message-Info: mgQ0p2t/JvBfKeUthui4X205HvpHvs3yqoCWMlCGHCaaZPpmRrlqHpHAUDFqu6H9sQIAx5iV2G59ZFryg8e9NdyNWuqPiBDHECAklF2HFJlr76v6DMLiv2PPhviSF5Ts++bP82PbkajYQZI5/RgzCxF9MD1oNcx94t9YzR+8QFc+cH0IbH+EdIVREMQJiryuLQveju+cWmHxa/cJ79sBp6XBdppXQhui5IkLdpNNkx9E2TdIJMBeiPvPvhRFDRurKEpoTaeZKEIZtL+gSnEnwCOSIN4sRpLjJ3kCD1TXnbI65Z2oIdLvTpr+mG4cVYgrSRe46cNLWFHQPGiXS2fJCqJVAue9lPuY/Pla4jxTlnY=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:O/76oVjHM9tmvYGtEv9IC2bjVUx7h0JeKqv+CnBxgdYeHU/pBXCzxX4dFbNJCBPbkd/ahiLNyXBva5JjMiTGtimYt8HKomNoTWujGtHznYtrPFpLODCuHFQQYFFAReIzKn1OxO85LXaRLLVQI1i9RdnL+Vg0oYIZSyGbXUiabdAaFzj6f9sRtF/LHsM+2LSLWoBFojLRIFZ/K2SLOCBsNldD6tIFGOFwpaxOfmpFYvmBMLgzE+1ZeJbYct9BFo3HKXNPpKJQOJJXjggR/Lm+16ZmxLsPZ/q6VM0POrUDMzOhi2MEOhOL39u3oUu+Pxuyk29czCM5lwDcOLMkmjK7Nb9POdvlLUBwRcM8GMLuKvGNRVmgn+UlOUssBeQ3+cK/HJP3HyvlHmaq+hF5lRhCYbms0a5FGhg0W42Qumx+wIreHFCDGjFrmGrQS6mpjRsYFZ5OLykCmv07o2f+cPDQOA==;5:/Dg0R1E4LskoIlKE4RkpnK1R2S2XaLt2O5Qj/Dcu8xEO/oClH8lB882mmPV1CpozM2o/a61s2GtCyhYJVJr0+MP+vI1VfZNK5NEZm8dXZZSBoO1JSgdQNkLu5E7qmHllNGFBzKcLw6KLhZUQJPM2TMJ5fdqussTbKPIdF3F4JsY=;7:NJgbxAjiLp4+LoAXOtDhgBYvILoboPeZgyw/mLeZlwBFjQMTNJ+LfNCLNqGtFksZZVYl7IQ7y3XCoD2x9URF+lGuuftNn5okFPMiquQRo1sV9g5s41Bw6kPaExmQ+j/1x6TQuD6SohoiKSlOj/W/6Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2018 18:33:32.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce770a2-9ef8-430d-7e92-08d65c727fdf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx I2S IP enables I2S audio. Each IP can either work in playback
or capture mode exclusively. The driver supports both by reading the
configuration in device tree.
Patchset includes devicetree bindings documentation, driver and build
enablement.

Maruthi Srinivas Bayyavarapu (3):
  dt-bindings: ASoC: xlnx,i2s: Document i2s bindings
  ASoC: xlnx: Add i2s driver
  ASoC: xlnx: enable i2s driver build

 .../devicetree/bindings/sound/xlnx,i2s.txt         |  28 ++++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/xilinx/Kconfig                           |   8 +
 sound/soc/xilinx/Makefile                          |   2 +
 sound/soc/xilinx/xlnx_i2s.c                        | 185 +++++++++++++++++++++
 6 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 sound/soc/xilinx/Kconfig
 create mode 100644 sound/soc/xilinx/Makefile
 create mode 100644 sound/soc/xilinx/xlnx_i2s.c

-- 
2.7.4

