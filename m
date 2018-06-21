Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728FAC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12428208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EIOwQHDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12428208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeFUGnG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:43:06 -0400
Received: from mail-eopbgr680050.outbound.protection.outlook.com ([40.107.68.50]:39956
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932674AbeFUGnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V01O9rIhIalbqLhP+k/+SYQI4YWhY4kVWaxEB4a5ByI=;
 b=EIOwQHDmz6N4+gYOZG1zJaVAw02wOBMyw8NKRaaddr5KPwlRso8lW+yP6ZqnRMkAgVP4O5KOhSeYmZdYDfvchF6xwuteoOdPK8DOappsEmfYLHLWTg8omOYyNCNKLpONHmcM2CvXtNRTaqruZd4ClXWFC/Uf5j3+Yinb7IuwTSM=
Received: from MWHPR02CA0011.namprd02.prod.outlook.com (2603:10b6:300:4b::21)
 by SN1PR02MB2158.namprd02.prod.outlook.com (2a01:111:e400:7a48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Thu, 21 Jun
 2018 06:42:59 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR02CA0011.outlook.office365.com
 (2603:10b6:300:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.19 via Frontend
 Transport; Thu, 21 Jun 2018 06:42:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Thu, 21 Jun 2018 06:42:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtJ3-0006na-71; Wed, 20 Jun 2018 23:42:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIw-0005wz-Ha; Wed, 20 Jun 2018 23:42:52 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIp-0005oY-5o; Wed, 20 Jun 2018 23:42:43 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller devicetree binding information
Date:   Thu, 21 Jun 2018 12:12:28 +0530
Message-ID: <1529563351-2241-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(5660300001)(316002)(16586007)(426003)(8676002)(8936002)(446003)(106002)(2616005)(11346002)(39060400002)(476003)(48376002)(6306002)(81166006)(50226002)(486006)(36756003)(126002)(63266004)(107886003)(2906002)(110136005)(4326008)(54906003)(9786002)(81156014)(106466001)(76176011)(36386004)(7696005)(51416003)(26005)(186003)(6666003)(356003)(77096007)(2201001)(336012)(478600001)(966005)(7416002)(305945005)(47776003)(50466002)(921003)(107986001)(217873001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2158;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT011;1:w/HI2XByvp63nvHWH565TGdFqonogIEumjNOouAXSXof9GyuWIfusMRVXVwyE6AV9pkzCWIpZPhp2vgVXE1/8jXyCSPqqIHM8BcYM3CHhgY4K9H35Y6IKiTid6FCfoff
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b415c3b0-c443-4039-0768-08d5d74239d0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:SN1PR02MB2158;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2158;3:z6Eot6DufxX6bUnhRhsG4DcccMX4KGxb4N16V9yGHLUetI3BIdb6mCYgIXQlbxUuR5tIZYuFSKqWJNY7w8k7ip5GuvkS4RF/vfyHySMe4k+VXMgNiWPQ+WCBnIU7Wslx353o8eiVnouuvgBfK0d3y7NSwbss8ubMq4sc0RLisNmBHWRJB/S+tuvcLV2dZDWpqo/THeGp5IvJ0vx3aYvRNFtGOL3zSnEKNxYZy2iJmcV+/dY1KYKEnm3dTn0Lhlaku8GYvjjx9D2XswvvdEvduyfCRs5TwRQ6RwojnH5MvTDtx/2fdtk3SzooNxwdcukZbBer9cE/oQDfD/3jZ2/i8ImZYnhAi4vMXhTF0L9hglM=;25:PvtmyMP5ttAYgeCP2AjOgUAzarDxQERDwU2VGIgWB3ItlzJ8z9u3+7esD+oU/De5ZXaIYfRazB11nnVBoeIZ2g3VLTRgKsnTuCYomiFpReGHbqFykV7QS8kD0+1YOXSnpkgqyIq+7TPX60xy2mOWdeyaxzK5luw2oizydKuZSRgSK3tLE12PdA4ZCGw9WYwDu+L9smMYEY0TKLexnXkP5oaIovs2Nsqh8/ao75Aoz6VcYOrKx4AGCvOc8jM54H3updCTOl7X4UIinoiXdrMmiBftzNf59ZCT8dEFxK6QFkV7sF1jiU6mgKI2XvlFG4mX1iVu5gFmSXUp1Dgb9Tiu5A==
X-MS-TrafficTypeDiagnostic: SN1PR02MB2158:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2158;31:ZMOuBRi0f9ofKcfEu2UIa7Tteny0+0ZofmkJjvybqK75ETJAKqn2ffIdeNzFRbZa0qv3i5AyotPFUnc1CCgS1nDQr8CENblaT1zGh79LQX0XYJegQX9yrZgJVKNLVqW2CPgX6VhqMEkvBH60f/F89LMnzdD+fObh57k4v9+hb3CVg22bT+kruXYfrIlUKJggZD/okxcPx3G8WrhEe7DAvbeBmvz5Aradpd6iDFv3Cd8=;20:dYpdIzjjbQl0zO/zvzhtnChP50XfpqFUtEDxxzHBrYcsNGqISxAJUhr4oCTTtsq6eqDpLROvxs8YzLef5s4ORNwt5QOlp0bakvtCkKLTuyzW6edAURP6XLmrlO0E88I+z6NhtYgk+AbDuwN3eJE6awIgRiuICDLhiwhyL9xCJ/fGAK2xiFR9/igWxMneMn+ftDLlNqsEQkw5uqtBPC54uZHBIMUerN5p33aaGX+Hri14QlIAZkwyQP91RsDYxHCcL/IWXonmJ9NS/2P9fCfA1CWIKkQ9ViWbB4kaTGz5YiwLGnMO9Wpo9y8wuJBh+AX3nfx0MCy6+RmzdOQWAxbHfiRKZCWNh62VhnF760pkPP/xjkdIBsufUPocK9mt9wx3JEI1FfT30uRVHeiocx+OZ1gAgZOCXrBJK13pgCFDdmkUym/q97lqSFFwGuI+rr10x5mjNS00gq3faEz9gqiCtpl0O9A/T8Xh/cbR3SEU/pM9+EK+Z/lM4au7I12KXVGe
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB215842E1D0673F97E0C264B8AF760@SN1PR02MB2158.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB2158;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB2158;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2158;4:QcBAM/idO4dlDHjx/s/lv7GoTM6DaMa9XDJP6NIK5bVQiPfFrQ/rK55n/hKKn5kUk6LooO3kRYulhYQF3p/OoI6Bc6F8kBGOCAqCvlUfWJk6Y37SE7ZIerrAUnSiHF4Jf4H8ASKudN3mSIhQKFXJ/fRYhYfP71w87UBU2fAIZqgNc205W+E0qy84FyYpcbZKgo04EMbA+N/b70vD0a+GRk2hd5TxxbWBOVPqYnSere+cX/XrAbDTjEGMxKX/8juDYDJEs0eOr3MCMYVrO+55nQDO227/8FuHVhySEHT/PuQtWXbvEUPmQUYy4kqnaprW
X-Forefront-PRVS: 07106EF9B9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB2158;23:8q2VTokOOTP66pyDInKOv9xhP3mDwipAVJmV76c5t?=
 =?us-ascii?Q?pliH/dfJVCyESe0kvmkOdsv4uKaPOQBccvrkE7Qh7rG92AYxsrpIB+k/Neqx?=
 =?us-ascii?Q?81HGr4imw04phD91P19DqSVACyrbrOpvB18MUUjYobw6PKTwu6kY9wwEBCUO?=
 =?us-ascii?Q?MR1RnjGTL2rdSDzl5NFsRhntvrZNODFJj/wqBnwEEIPlPr4Xf0AT+gLQ1cQ9?=
 =?us-ascii?Q?aOZW8FJIcK1kSzDvoxurD7xiZ+GoKi+1GJzVcdWtvTy5lyOj9p6/+6bEpbHK?=
 =?us-ascii?Q?9uFJWZdZaOukXfTeVzffmCJjc1ehZ7k0jwaXFaZT4o2FZ+H5I1mVqEIvplqi?=
 =?us-ascii?Q?mdYywzv/buPNKj2Z6nTj0JOzUmF27caEOq+lwnreyVjNOCc+ZMR8wNIjL0Aw?=
 =?us-ascii?Q?xc4SMmzhKrrd3l2K3H/C4z3nQBTgurZ2oKNdDmgFBFQ2UmMjglHYfd7u+fE9?=
 =?us-ascii?Q?BlqgwiwsqvEfb28xrDqHf/I21B4bjqKmTfIYp7dTRMW3mFxg39qWbZi7h57q?=
 =?us-ascii?Q?iXuZFFOhhUXT+06AtLYJ/4DDVDZqKQIg5k1uu3CB+0NFhDv4uXAvuJDZ+alT?=
 =?us-ascii?Q?Z+olv07TPuWK7gtZrSk7He5EUtl5A6+ELR0k76pAwGantFJrGJ1U8RLcIC6e?=
 =?us-ascii?Q?4PCIg8E329su1nqAAd552rGJDtYszKBKNud6vMTEpcTHk+aAxKNkmIhmndYZ?=
 =?us-ascii?Q?Jg//fwgup0r3fi16Oe02TQ0AyxntZv1kcO7LyWMXRyAWyj1wmDt+YOmxlGDz?=
 =?us-ascii?Q?130oJ0FkRdYjdXuiAMmEbnn+OqLj2S8lj3Ru/ZEF/qHwI6pi0jIFPOzH9+Lf?=
 =?us-ascii?Q?eORSeUJLdjOVZ5fS3ejR5pE5VW188jTW+vhU0seAMtOMCNM8cbAIvVqj7DuA?=
 =?us-ascii?Q?OPJf3wLA7EiTr1cBhRHx87unKoLuQFNT1SXOO+ZR+Cp0ptrylpVr0/GiVdqE?=
 =?us-ascii?Q?Pu6L6ofmvn42PCiZjsYQCIf90PtBaU+INYUQ0zu9dqFjMpZfCG5Rcmdk2dA0?=
 =?us-ascii?Q?CT+Bk4ycAGyG5a/CZ4tGeXCAr4j1qeM4S5Cbk4/rfnjm1BHtuGMb7hIK23Hf?=
 =?us-ascii?Q?zilRtJ+YXdfaYZrHq1H7+L6Z4+YZUh3yEJ0RAnrEncFq5Wl/+d9ayYqMwHJJ?=
 =?us-ascii?Q?nk0YiXYC2OhH79K0+/1RsbD6ogFUuKgkyP2zekz11KGnsSGqLxcNeXz9YLH2?=
 =?us-ascii?Q?hDauvnZFsWEhyzqwgGw5H6AsKPL7T8akhgOP62pk30NlJfK1tte/eApFyUmX?=
 =?us-ascii?Q?yCOIqhx8p8LtOgyk7LYMw+oLNI1emNHhnq85jRM?=
X-Microsoft-Antispam-Message-Info: 2gPZNGasjtu7yTsIzTzGLyHdWj/93iRL2L0s2wTDw5MWcKoLyfIurSVjjfhDc7TBAv0DyPP2byAj4NJ3laFt8qO6x4MKQkk4nDBi1pN1R+GV50wpbgdiP/F4zmBMzE88oH0E09ziS3vKDQcnNdW7Q56hmf2YfNH7GJpZcr/c/UlSN+cdew83Y8Y2p6B1a4J8K3PNzODj19nfx8PWlEIYn1nJ6/E9BJy2ezX3Pg586V8e+7GS0alBhl7b7LGHMgO4dzE8m6dkHwYRYnP6tefsYlsIJLEM01E3FrqPn7Z2Cu2jwZuPUBTSljnkHJ9L6z/O
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2158;6:+Ld7BZL+rPT7wQ2LK28gDYaXcqFZ0ImBfXNmDDWpahewGHtneUNPRJCqb6X6vJSWInhJ7FiV2Nbo8mi8qLOVyjJwAHhuQBW231Spc5LdEKEQb/0aQtt5W13wHz3BZbni94ITQAHZB0W1UMQJcNHgGOGZREV7yhPKCNRh7U+1K/NpUotQqlNgGoxkw8blVqx/LK9DKmT3PMQMfyJ8zLs0G+VlZ/RluWMcDi/lh6BkwOzjEdaq2WoYXbuc5Kce0BSzLFEiEiM2NN6KUcUfGLpuK/XxjAxr1YZP3v5GMsaM1WmqXvaVRRuO1e57SZSP/yA0zNHBJvw8GAGaOEPSv6mHq+p8u45KIGtrNenenvJGvi5LdnLJf3tQcPes7p5skcBdvNcL9m6F7+f8++fultzBPbQFsWVRiXkk0BNQiWA5CmzeGRq/mOoen+TdoBht8QXgm+ZJYrQ1J5+60WtHgvHIog==;5:PHTBe4TV0A6Sg1u/CqjbUk8/+hEVWzJjId1Ebs8g6EBWbtUQ018QVnqwbAYubNz4lOk6zjgnJ/aEue+248i0shvXysze6VIP4zMqbMSUKftpOVLQbvU9tugcE2WTN2acTf2iyRsehyVq7StE3dpv5rHIhsA7YrW/1yxLfOn/IBY=;24:l4833INtFH2RYuvQirUc1bj/T6nWMKcX4hbQFfdmXgFHMP+a06wYDGR7io3S7p2EIF5XoaVz1vEswpYSKEswJjjpR7dJeETLynTKbfCADuM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2158;7:4j4tgRCNFf73deOcczAY9DhgoShGP8AdHUwOaF2ZJ63x6D9W7vSsLr7IPlAU7ZueT7HdMqfISrykWa6p7h0gQlnP4DAZbh9eFPs1v7QlT7h0+B3e7l8SsGfwRarQx3mE9Uf46KMZSHd8JgbnL1ncAmqIXQSslBt0yI3wQqkcL6ZYZoJK/JYixPkOnZiUlWUTja45Llnps4rmBSRCypz5PBFV1GPfvnLHyYfGS8SHgGCQDmusPWw7kNYj4vjmo+7p
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:42:57.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b415c3b0-c443-4039-0768-08d5d74239d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pl353 static memory controller devicetree binding information.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v10:
 - Corrected the typos like "should be" to "Must be" and nand to NAND etc..
 - Removed padding to describe size-cells and address-cells
 - Removed timing parameters from DT, and added ->setup_data_interface() hook
   to the driver to read the SDR timings
 - Modified label name from "pl353smcc_0: pl353smcc@e000e000" to
   "smcc: memory-controller@e000e000" as suggested by Miquel
Changes in v9:
 - Addressed below comments given by Randy Dunlap and Miquel Raynal
 - Typos
 - Added extra documentation that explains the HW ECC limitation with SMC
   (Comments given to v8: https://lkml.org/lkml/2018/3/22/23)
Changes in v8:
 - None
Changes in v7:
 - Corrected clocks description
 - prefixed '#' for address and size cells
Changes in v6:
 - None
Changes in v5:
 - Removed timing properties
Changes in v4:
 - none
Changes in v3:
 - none
Changes in v2:
 - modified timing binding info as per onfi timing parameters
 - add suffix nano second as timing unit
 - modified the clock names as per the IP spec
---
 .../bindings/memory-controllers/pl353-smc.txt      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
new file mode 100644
index 0000000..8b4c65e
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
@@ -0,0 +1,41 @@
+Device tree bindings for ARM PL353 static memory controller
+
+PL353 static memory controller supports two kinds of memory
+interfaces.i.e NAND and SRAM/NOR interfaces.
+The actual devices are instantiated from the child nodes of pl353 smc node.
+
+Required properties:
+- compatible		: Must be "arm,pl353-smc-r2p1"
+- reg			: Controller registers map and length.
+- clock-names		: List of input clock names - "ref_clk", "aper_clk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+- address-cells		: Must be 1.
+- size-cells		: Must be 1.
+
+Child nodes:
+ For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
+supported as child nodes.
+
+for NAND partition information please refer the below file
+Documentation/devicetree/bindings/mtd/partition.txt
+
+Example:
+	smcc: memory-controller@e000e000
+			compatible = "arm,pl353-smc-r2p1"
+			clock-names = "memclk", "aclk";
+			clocks = <&clkc 11>, <&clkc 44>;
+			reg = <0xe000e000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			nand_0: flash@e1000000 {
+				compatible = "arm,pl353-nand-r2p1"
+				reg = <0xe1000000 0x1000000>;
+				(...)
+			};
+			nor0: flash@e2000000 {
+				compatible = "cfi-flash";
+				reg = <0xe2000000 0x2000000>;
+			};
+	};
-- 
2.7.4

