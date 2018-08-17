Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED87218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eE4/h0al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED87218F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHQP23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:28:29 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:6083
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbeHQP22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wFOTUFvXsd6q7iyl+68eKqY29wu/E/t49K6bssvGTg=;
 b=eE4/h0alhnle+AUsQUp1Ibxi8on3PikX+esDN5m6yI2tT7H5Ep+t00g0EJpVJfj7h6nbCBkoDiRSko8qTLto6P/46rMi/zdyGkd2yLzHH3APKmRZCqNuMczr2wjl62f0p3YTShGJnVit7K1PtdnCxJMlMK5SXJEvTZRPJIWc+mc=
Received: from CY4PR02CA0041.namprd02.prod.outlook.com (2603:10b6:903:117::27)
 by BYAPR02MB4325.namprd02.prod.outlook.com (2603:10b6:a03:56::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 12:25:07 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by CY4PR02CA0041.outlook.office365.com
 (2603:10b6:903:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42394 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-0008VP-U4; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-TU; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOwfE019097;
        Fri, 17 Aug 2018 05:24:58 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoI-0000Tc-7I; Fri, 17 Aug 2018 05:24:58 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 258A36048F; Fri, 17 Aug 2018 17:54:57 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 5/8] usb: dwc3: don't issue no-op trb for stream capable endpoints
Date:   Fri, 17 Aug 2018 17:54:52 +0530
Message-ID: <1534508695-12642-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(376002)(2980300002)(438002)(189003)(3923003)(199004)(90966002)(6266002)(51416003)(76176011)(16586007)(126002)(316002)(42186006)(14444005)(486006)(106002)(11346002)(186003)(2616005)(476003)(446003)(4326008)(103686004)(305945005)(50226002)(47776003)(50466002)(52956003)(8936002)(48376002)(2906002)(36386004)(8676002)(426003)(81166006)(107886003)(36756003)(81156014)(6666003)(5660300001)(106466001)(54906003)(356003)(336012)(39060400002)(26005)(478600001)(63266004)(110136005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4325;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT030;1:1hC5Ar00JhWeXtewQ80m9wNWRFzKDae2+VYacx9ji/LlGs8r0sGGqL92iWA7fhM4FQX9AUnNYYh2n3/j1EYydspU1llTGpsEupZWhfDbxGWtuG8ciqiUujF+he3lHAs7
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b372a06-99f4-4201-45bd-08d6043c775d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4325;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;3:GJvGoNtcQBrAYyJPLHGpQMVFC1+baR/fzf0XouV0/ofb+rt9uHlp+9ofVpJTd8ICuLnj2YtVIhhjMf3/N08lhmnwoixR4SIZQgeEkC+wQD+zoNMNP1zABVsoewdVDHU+YRdUGntlLyI/p8MRsRXTjciEfG77UBVM8cl225dkLOE0flzi0jTxevASvoQfVVs64mxBQ4JRAYIcuNnCXibg2hAjk387JCCazhSDKDAOHyZy2xzHQG6WaZyEoatQ8zFfaw0iGBmAWqXsQYW7J8wBBe68WGyGd2CpnCUgC69e37mz8fGxosdYu301+aJKifwbehvghVW4vWtBUWbSNmBDyLlKQC4r4skGtpQiMohwglw=;25:tlBODgUjUacDfarevMyfFo4nXwE5p0oOxdycpUB/2B9Uctijntgd57eMxsjMXyl67wyiMTLs4sSbHgfvdCbhMpOOMyQ6yYvG2wUU960i3nhEP0dXFSI8hjGSHxeXSW05hsWUZcugawivN5d9hBj9xXr/dkkvpiOoUsqJqBmUqSaiLA4OPuJ2N6q9vGQYL37WggHFFsqJfQyxEawaVdy/StmSX25t2q9O/pROqI1pqGggeKRmFMVhWYiQlUih6vmpYe84Vvopfo6L79O8Tf8FF25Qu9InjHY+3pFb6++cEymvcOoeJhEho5QKBPjFXWw7aJrbAmVbgtqedSZokgCrwg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4325:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;31:0ZZ9ZeLqWMBZv0Q94FU+eHT2ccEdnyt8543xvpQ96bYA/u8z1a5Fa+15whlzfqMtFFPJpvq9qiBcWJ0ddIMeHzWsiEMW3nTOY74k/HMgQGe1vZWJHbdviY/bgO7nmafCCGdgTiB1imt0pqvZUHB11c8zY0iT4KjNXZiSmhMu/uIYBFrIuVkLSgctBlG3Fw6IW+JY7eD4frw12hnsv6Oe92n3n8IXUj9JjHfkPiFORvE=;20:uwL7GX0C49QGXOPy7fsiSfvI8nqGCqvlHUc6Ob6XpZ7PcxTAKCwjjByTRp0knyDbLQ/NnBJngT/S/tCvTP8zwQERs3d6nBaMAlADnwpAYYW8nI4lB7Gi9jK7Lw32zymAnI2kPG2xOcydRWqIumPAdo8qDxRkarO/whCIWp3QxvKcbpd7qBMyRhtK2bbrMr6/cC0CvjRkK7EpWD8EP7yG5q3daYd4KnCGlLLzSWIC5GaOXaDvogoq7pJy/6MhpO9z1OAEleBYqwOrebEsxmOB6NCt4TYXyXqPttnhnXzl0TGs8NS4OgINEGXONrmjCq6U3EfOpRomQQ+x15bl5Q2aQqmRel5gOFQenj5KLCp+3hSt+A42xXCqpdnwP0yEn1i2H2kItM82VPcwCMnoxDMJwT7g3vtlHpdcSOS8tT6rmWSmrZhsRCFIoyDX4tIkjgjPPxeWcXerSE6Z8/IOU+FUiY7hpO2IZg+qTmmViK3wppfZnTr8dgEXyQSRdXYuKzaT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB43250BF8C2C56CF9F464ECECA73D0@BYAPR02MB4325.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR02MB4325;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4325;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;4:Ghpb3m+sk7mNrwtded4GqOlhJ0IteddsOSF5grhXpfs3x1bddAzqajzPbg4U2bSS0wze/i4HC0pnG0AxAc85eeRc8x/pmtaXFLufxaYk6qN2qhQoTO6V/2PnpKwf5oQUv7dZWclzZ1lueFAsWr4+BE+2lD0wTbYgbvISI7DOBGIC+ZnaP1cZzZiuUTi5eT6+Ddhi2MHxgmi3W+4zZWfEcnLORBiGoMXDP9g4liyoeUNe7PbmwpxpaI8bEfEg2QdIrCfGPKl2+ziTzcdsfqsR9xZ8IMRb2yqIsg1YS14ZYGy89vRobonbcNN3ICRAoWaC
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4325;23:mT6cb5cANq3MY7H4RqTmPidMtIx6sb/d04+2nz/Wg?=
 =?us-ascii?Q?418ABlgdJWMt+1D5Bel+uPGxSfdcJkf3AqKebAn8sjtRdTCUM94og0mN2mlp?=
 =?us-ascii?Q?x+xmpmRc+KPZmVh2JiWmZX2EAMvy4OwvAU7HMG8ARp+gjid0eKtQDGSLjCOy?=
 =?us-ascii?Q?Lx6BxyOx7elb55qrVQc8otjV+K57iO7WnAj1jVNDqOALNVPRCoyuV6U4TjeX?=
 =?us-ascii?Q?dh2/xCEAKxyz3qZl0aP689J7cfzhuay33TX5AFfzw4KrvPPFfwUql+7Mkymn?=
 =?us-ascii?Q?nWpB5CBqPWR7qT1ZNeKRmuxwNgnsorW1t/Avw+p8GiSXEcgtIwrjYnEHdXJg?=
 =?us-ascii?Q?Ax41/Ar/HZsidhvJQAP8g8BIjmJ3cDwaa6E/OvyGzIcY9IaRcy4HULFaSRW2?=
 =?us-ascii?Q?R1dGUBcw52ske/5M+jheoZhXHj1ABc1IkM37RPWQ0Yl2oR0MPCEVyJ+vJT1t?=
 =?us-ascii?Q?vBUlbn6Gq+0yfq7LDr6i47EvHgAn12fXXUQsorjrg5f84P6arrAjKryyan8b?=
 =?us-ascii?Q?9Hc0yaIduLifntNaB4oREXNIcBXSBIoGQx4VNWMpb0F/3heSeKPNVJN22dTD?=
 =?us-ascii?Q?4apfZLTL8Z4kPfft3URpR6ktMF6F9SG9tFQ9dC79KznMyZwHh+d9Fa2Pq799?=
 =?us-ascii?Q?6iO59RaBDB+bpQQyALmY3MHOzBJ2yLTUuD3/1LinRDFCdAx74ySUsLiw7hCe?=
 =?us-ascii?Q?yLShHUXiWVFz1i8GdFWlo8XyfnOmv4mZlptG/T0jBcf/JShO4cunYzWlG1tM?=
 =?us-ascii?Q?oyOjao9o0OGDDVYO2IAfhWFMZj02uA9kjVfqiNtXViurk/7Zh8QGmQfrTd1L?=
 =?us-ascii?Q?4RfFrYT458vSNAqjOhJLtdZV9hgDJ6xIFcw2dbslCtHOnVCiVTs3siXInbtt?=
 =?us-ascii?Q?KjdkLkG5twV5K6pBTv8pGI1wzwDciPU1bQ5qCmNJLCr3UVauwgZ2Ci/cmngw?=
 =?us-ascii?Q?SEKS4g/TUWhdHhWRt/79JxmVif2BLc4SQLOxgLh1HId13TsuUbf/VycklUvk?=
 =?us-ascii?Q?DhnMQAyz9UQ3+1PwOxPjJW27kFv8LYppxHGVojSF8ykEYC8IASq3jERdZ+vT?=
 =?us-ascii?Q?o5TK7C2bNJ7T7ym/IDnkvrj2L5NXjV+wHENl9siochJw0TD8pinMQvXHir6l?=
 =?us-ascii?Q?QIfKJezd9qKcgzBcVAWQZ/3YlCXsUfmSSBWFXBhkMKVTIsogotY9y4ZfLQlV?=
 =?us-ascii?Q?9TwKQzKTvSs4fCAYMrCNQefVqtAuMg3oDh4e1+BF2oSdF5S3KZVdmMeXlPCE?=
 =?us-ascii?Q?00Yey+jid22bdgXnyo=3D?=
X-Microsoft-Antispam-Message-Info: ej/wmCoujQcSGteFE7H14HZ6WHqApO6lOfUpB5OAy8clGMzIw0c6V/e3LHRMAd1yG1/RedqpNsYvA8tDhmvgfBWPs7pXodAbCeoWfnD+0S/jrDIQz2K/wgmJXwwNJ1TlbbTtgqTxcS2s930bVorgAuXQt2EZ0wmV0xdqi9asf/Q6pnvUCSnmQ6YcDcs/NJXr4q2YsG+e6OgeRw/SfCsqJW4MWLLll7nd5rcl6Y6QzSvTOOV1JR9LPgemYMwj6eZs8pNbnn3C8guyaunChGwMZQdfgUS7G+pjt6TUb2gOX0QiWpd0tmZADpf7Kg696567wdVVBUR8tX3UPmpmUd8IyfMOxP/Gyt/JMbpmEAWSi7w=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;6:brUP8JY6kdLGA43SbXTG+HiNr9WsIIDdmWMbAZEwRpvhP7tvYDXb0/zpgmpIBT83aYrlU6zeMgXtbDd5I40o9KpEkrSQT4FH+ASYk3+gcp16eVs+KLX1qn9VKPFTJWvaZtcMRJ4CVwtDe/n0JkzDD6QLafk38C6L6/fYhW+dr4XRQRSW2q5Vre/VIxTMG5uAPAR3Vj9yHpVoheCOTVH3V0Ayi4WLVkaMZ147JXr1j2wZPVuyqZUj3y3kIZiWoZlEqyrXwjzcPFZOdfcceGVDCXxwGZiNipWuAQKk6vqUPEH5A2BNIgtEtrNj5UvpHPoOqJDw+kJ0dIfUryNo/ao7slzKD3B0lVE3AhfUFrhN/t6eZmauntiHXCM4DcKdhFOlJs7bNSYgzLUYHGoNDCbvRJDLvlurNuqc+KAI/qrGL2fMiltdKVlRZj47Iauj/QSxhjr1lfTJH86eT6qYgIIpeg==;5:tOO1TYXN8w7NLo9PBaHDvpT5ude7mnUQjm6npY85R/T4GlXCIT6bzFg7GupLxGBnM3DPWEiibseKu0F/FMPwfnxTMdRGlVkEcweQ/0/VP4SQaFeuZMh7QgmSEfT1OuTnI77NeMC4ZuMca5xC/2eK3IH9FCQyZwcRdrM65r6/aSk=;7:2LoJAKEl9C7wpVVrMQNWZmR6Io7esDstmpe0FIUQd+hBCk3lS9yf9+Vo5bQL3/iNTgbfiAB5/qXrSsnyd8z681sQYHlTRSZFu7kAtNLDO8epc42moLyy1RC0c1YjL88lcdTrhaC4RHbb8o3W0O18eHMSkHAjZBEKAuaR23eIdlI5U1S4jONMvXptGG1xbgBkcOKi7x643RU4H0O+8DMRzleqIbeIQ5CkFXfgM+5E5n25IuHjdn6wXwxmGtji8vd2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:06.4779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b372a06-99f4-4201-45bd-08d6043c775d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream capable endpoints require stream id to be given
when issuing START TRANSFER. While issuing no-op trb the
stream id is not yet known, so don't issue no-op trb's on
stream capable endpoints.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8cef488..260f10f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -668,7 +668,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
-- 
2.1.1

