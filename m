Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67C9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FC12086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NZHB18Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FC12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeGKHkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:40:20 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:28815
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeGKHkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plTkWSQhF2xKG+KHtzCJFLdJpdHD96Vbw78hJKvyWb0=;
 b=NZHB18DwrxH406Dcfpq7GCAnmE72s1fAicH9/5GKH6qkXoAiyucxQMZdvi9q5csJ87SZ9EhTOuT1TVcv1yOasvcyWF+S/OsdSRSyGCyiwKk68cxsNxjZ4Mn6ei/yasI/yRMnaXp/EEAiU7gEPEclneJ6YqhWolBb5Se0PATC+9Y=
Received: from SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) by BYAPR02MB4454.namprd02.prod.outlook.com
 (2603:10b6:a03:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Wed, 11 Jul
 2018 07:37:22 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by SN4PR0201CA0044.outlook.office365.com
 (2603:10b6:803:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Wed, 11 Jul 2018 07:37:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.930.16
 via Frontend Transport; Wed, 11 Jul 2018 07:37:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9ge-0004hN-3A; Wed, 11 Jul 2018 00:37:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gY-0003YJ-Vh; Wed, 11 Jul 2018 00:37:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6B7b9ge000485;
        Wed, 11 Jul 2018 00:37:09 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gT-0003UL-5W; Wed, 11 Jul 2018 00:37:09 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.co>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>, <linus.walleij@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v11 1/3] dt-bindings: memory: Add pl353 smc controller devicetree binding information
Date:   Wed, 11 Jul 2018 13:06:50 +0530
Message-ID: <1531294612-29526-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(11346002)(2906002)(26005)(356003)(966005)(47776003)(76176011)(36386004)(5660300001)(7416002)(51416003)(7696005)(48376002)(6306002)(478600001)(305945005)(486006)(50466002)(476003)(2616005)(446003)(8676002)(126002)(106466001)(39060400002)(426003)(107886003)(63266004)(50226002)(8936002)(16586007)(110136005)(316002)(2201001)(186003)(4326008)(9786002)(54906003)(6666003)(81166006)(106002)(336012)(81156014)(36756003)(77096007)(107986001)(921003)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4454;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:74LknJ3A7d3JaQC28Q1zSkxrW1n06o3IJs8pEwkKn/4yZhyfL0iPwaVCq3Gq9Rq+PCa5giSqoC4ATaOeTDKpnZB1I20UB+RGiBUw24hnJdYXyaOiDWjJHlbUTPEBPZaa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd530916-a997-487c-2619-08d5e7012345
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;3:98VI3V9nVZKcbWH95QEgl6sya+Db7/jzhnzYupL/X7mK6CVgIwBay2KquPi1DPfGGAUEYGQSkD49GONSoGycxPfdvrzlcePdjb4gmbGcy2/v6GXSsah3pU0KM3t7oiToRQOjHJgt16qu93n+fVSLtVIKLu4iOW4W1s7CZv77U/6wcZFPfA1ApPhVAuR5UbSMnAgad2qx+QBsPjByetVu5UcqLhfZOHN84nB80dMvFeEqeMYajRldgm8KFCaoEfDkW9ScUrKDoq3LHmacTHaz/DSc9hjMz4z62imkafC2MJNBxTkK2yQOmxbmndUvjQp3V0+vsBxJMguHfvrN6KhOdBfm312l6q6iBgQBekJxeRI=;25:ulnZZCjKX8vT6iyzNggj8QCdRH9+SWENblaD0jIJxlTn0gfKg9/9sQdzoOCFYysHyaemHiX5SbpvBBg0/m4pnZyYw6jgbifgayzM2nj0xCITSzOGsfICkih/d3Ju5Iwzyut0PFcMGmfheREfNPTmJfD+VdqJ+hyZNU8zBhAniP73mvZnAtGtHgb9sL3dtSRFLDzFbsBdVeXpdUsIYaTxI0w1aq2EnNQLgluZ8bhf6oYA8m5aKWrbWb3LqJhyrLwZIaqX+t3OX0IKqSzzHPEm91tac45ZUHxY7sT50PJJRE6zejtZStdpB1JuNrvsgkN+5UQJBhkicGv6TGWOLDnOIw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4454:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;31:9PeRKNfFUUE6ejdYUV635zAySUvI1g5yP68wN1gPSTr3KSs/BCWUT5fdxR2Ojx0RN4qr0p9mb841biP+3N6Qxqrd36NsnXM5AkY7RJqOdOfXRl+zlsIE8Qy4mLTlyQhJJefB4iE/3nGRGTGv0p0ZsBe/1hnV3qxU8bK3cdEtimH4ijuY3LryDLa5vN30lBx8+px9G+Qqa4U8e7iIG4PGbKXUMzTunJgvdh2Ln1Y6lWQ=;20:yJ/FJ2V9IqWknSH5J4dfnvvE0EKc3J7azn+eOB1Fh9UI4bmyEqf0JUUE3mE/SVZoXxjgh02ld5sG/SubaN/29k2PJTfwxDQjFZG8Q9ieiIOR5PAZsGZw3rHmFPPd399y9OyRuGAT/pyVgcBmoFMBFcx8CpeZ5Nn/578Cbr2D0SY7UuYz2DY8CbbOcc7riUjnM+rNbY05nw4tVsjNPOVpeJO5YMae7rd9CeMAW8o9SCcRldW4x7rUvySec2zLmGjuX1SY1hX94L3+qW1u1b98jjE97zIueh8zHPtMu/u4/ntp7LG32q1q+K0SJGn8jG3BcratirdJRAjmYmD+P5X1Gy5/D2eTpdJopG+W4s823dEq1zoQ2UfDwIh6G4Z4CJD+i1UrMhVVCwTgvwhv3Yuc1N9p79SgPhxfZk34UjYnfbws8nu5sScUgROhRa8aOs0K2qsLaYQRrru6Sw7JVkx7RhXDCWbipYhvE0yebLghUOEr67gG9Q9h9xZf85xTqRzB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4454205C8EBE07196AC5DC04AF5A0@BYAPR02MB4454.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4454;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;4:vSH60Gbjq5BXfasdnhz901aZp4NK3QBiFWksUQ2KNDzHMuM130iWOE7cIXRPlDujsX7qPzi5b+3abZBR7GsxeYk2EyCtXY9pnAO3exn9eEA5eq4t58d+T1L1hijyZKM1RNMmi3SMd+nFf3n6v7i28f2lGv88zmIR9RZWku6kNYTyvxdsPbRM6bZcBYOfQnZ+Idwv6+F+cCnneHQXfzAtBaMht0xhLZM28WZo62NfGFdcfn/L9c1kteGPwunRvPVJ41BSzo7U1cz9Fci7Lysbx5NiDm+mjHDd+rgYCa4fwvIcmDiBuT5CMRmTQwp3djVr
X-Forefront-PRVS: 0730093765
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4454;23:9CDQ+DPdapcdbzB4LPG1/gvVoBuUVxqMZIvV2OlIR?=
 =?us-ascii?Q?SUetWHxz7LCf0omCh6Kl5AxvL8wq+TQ1D0RVqd/q11Gl2o2HCNq5xkaoIKwY?=
 =?us-ascii?Q?wRyIWgOjVYWb6vQ2Oyy+j3/ycG/qkcOSHqDDcugzAmz93RXuPhmlXX5pt+MJ?=
 =?us-ascii?Q?Is7SdcVkbvYTXI/Gvx1MiJzKdGJ+6T1oWMwpjH1Q17TM7ALiRLOeZtM80Clf?=
 =?us-ascii?Q?CCIOPfL4/C23gh86O8WzCVJhyuXw9GO1bvZox/iRO0uL7wo72mTgz2uBqmkM?=
 =?us-ascii?Q?S9Xsmr0NBda0MdmEO3nDg92Jep5h2I9n8fGnKWT+jx1XCsqxh7o7XqNxCkEg?=
 =?us-ascii?Q?o5Jdc0m2+4qTyxHkmT3hByAwoFvXhaPcxNMVmG1QRXgThj2+lA2VJ556fD2l?=
 =?us-ascii?Q?XQGCtWe2ZgO6dA1C0ANuDq1hUQ5zU9xUr/vpglIvBhgVQlOh9eKoq7qu/f2d?=
 =?us-ascii?Q?ISxTwDq8pRaVW9jd7lWGpBNR48Bof5PQocKNHZMEI/du27Kp2UhHQGhxwmE0?=
 =?us-ascii?Q?X+J5lTLQC0L47CHCgaWEZ0lespNCPYhuHBFTmptgRyOQLbFQjB7ak/u5GP9N?=
 =?us-ascii?Q?fpE/wzbeXkiOj2tesPAhAVHr0vL7oZmVqwb7V18dulW0+UXXsNVMdT4maZ8W?=
 =?us-ascii?Q?eh/7xu2Tmz70idI8JvM8kDjg0mqrXeGBNg47W8PV1ZvH9STTvdJWvu3Zbdcr?=
 =?us-ascii?Q?3J9mCFKRcp3bD6O/7vmjEv8/BLZTHBZH36Yyx7kYLd1aHwvYvlo6dK0tk1PY?=
 =?us-ascii?Q?sznKF4XrxfsLUCfFxmEJg5RoyzKw1RvrUbNRSF2VZOoRO1JxioUc9UcTR6GY?=
 =?us-ascii?Q?thqFDe1az4sokl1zDrNHJq2TYDKMD/vbeN8NUxXIo3hluKA2AveuEEVkMXhY?=
 =?us-ascii?Q?W7qRHWsdhbUfj5r8dOldF41MpdPhVYsoMfhIJgdlwSh0YoSlk1P1O9IZ02pg?=
 =?us-ascii?Q?zXt8FqKbqsRfNX0Gr9pAqxeNCN3roPXBvwOIehCAYhYbCjCCJ24DDoifPFU0?=
 =?us-ascii?Q?wKQHz4G/S68IjuHQX1OGkA2ctYWdAmAQrOklW449yiLf8u0TjE87KFKCJzqz?=
 =?us-ascii?Q?3juGGSx4yzLYkv8t6/v5GBJ4uJ/Y9IrPE1GajbWGWPKT5F1nynMx/96hjQ1F?=
 =?us-ascii?Q?GSgdZ7pkjGrji0YFEfQB7z64DhWfc642JDkVN/tiL9m+yhfKo5kDUoWRBtQ7?=
 =?us-ascii?Q?FVea3eBeYUOQBhfsAxFB/eCk1yoCv7pCOPI9Cpw313dYWEoBv0O7V2fuyAGt?=
 =?us-ascii?Q?DNdG8daPNlW5rWLC2yBxHXB5r7Lv02JDa683zT1?=
X-Microsoft-Antispam-Message-Info: R3+mRejlwhQutgCsvMI61ZvF3uZW+fWsN30EGzRoSBqPXZZBCkePpjY6JMokigMzEing95NdQXgVhjoaZu0nqjL6MRBnIG8MdROsvIaOI8AAKk48WwivJnou1h06fhybIVmH5LOdgqDDT6pt5cYQKIgeWpI0Iq/dVzgEL7mUBlSzIC1zUvAT7acj9ky6Pssr9mk/nSPT+La8xmACjl8UCj8SNiRqe36a1EuQJxf62HgDXJtZ5i14H+BvkqRVhJmOoQw8d9ChdN6tJiHkB7Md2hjd5qSUrYEzr+kJsgyHW5JRbduUNCRdFcO5uRLv5+cA5GqEAD4xIhvbeNCTsZmRCnQxRGMC9jtf72f8tglBkHc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;6:G8W9wcLxuh4ejYSzDVM7ESDHBFMZxZHEUc6FomIqrShbGpNmnCfmqOdwHDU+YRJ1eaWV/AjGkLjmYU3wktBR9Fs8m4kkUhD8cYNbaXLvfFFItZT378xSxR3LS2q9kY4rKkPvL1e/7kAYQ7jCU7g0OBWGVBkenxHxnRNhP5/8EhMcIMm076EbjsayJbg0E6RT0evOopUYE1uC77WJB6wlRLrJqASZy1OVfDX8IhIZO5ULM5VTMVaWEp5yI6k25q6s7LXu8mDNFkm+hW8DF0/jX4RbSS3jx1T4PhVVLRH9gO4Zjvz4EfwqF2o0gOr3d+BxKq9wZ9iVxRxXNstGkr7TJyo+XSiOf9TXjarVt1OSpLcukpkgfcm6j4OrqRamS7zb6RfmCMWp8v8u6f1UtTEWCopWQk9Ts2JuioHcs5/eGV5JplqRSqHj/D/+ElylBREdnAcRBFq6xG0Wxj4+aAeM8w==;5:hkSc6VONpWHv5/372tlBy5CpWqR/wuk8ZnHYlDUZGThzINR9QPfdVr1MkDFwRd3V2pdRh9M4CAxzjbyWw5zQJ0FequKRZ9gevGUQQqM/zYdJLTU+ZhvhMaz3EADGqL0+3oV10N8HKRRJgROJPSiPeb6ODMRdrvFzhHav/ai65qI=;24:nqune7/14lspvWTnY9gII9TGuPtJPEq9wpDhs74UwtYYa4IXRv15B+BQfBWaGO9e91VBL59Lw4NEvXLzWWqOlj7vuqutTj3B39oaZRH/lkc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;7:W+/SkkMYlSRTsiqcIlVRA0Gu8KsqeLlUVWybZKfGbrh5RMEAq9cK94S099dG5HK+0fBQtrgCSlo7Zj/iY35MhTzxszUqvOOOENb5P0DzERKUOdHoFmfAemBPBqt+mJG0tP/Z/ZLP3kt01HUiwU5BmGm7Vaq0ggk23zVOSWWGJ5SgHn/SJiHdIMrEIXhqMLo6QeIg3crhFcoV1Y+5aYqR0m955I0IetuLyRHFjtFQTi40WYDeBooPaU4KDsSu7Arv
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 07:37:20.5979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd530916-a997-487c-2619-08d5e7012345
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pl353 static memory controller devicetree binding information.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v11:
 - Changed the subject to dt-bindings
 - Restuctured dt binings to represent peripherals based on ranges property
   as suggested by Boris.
   Now the new bindings uses cs as first address cell value similar to atmel
   EBI/SMC.
 - Added "arm,primecell" as compatible to the existing compatible property
   as per Linus Walleji
 - Changed "aper_clk" to "apb_pclk" as per ARM AMBA peripheral documentation
   as per Linus Walleji.
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
 .../bindings/memory-controllers/pl353-smc.txt      | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
new file mode 100644
index 0000000..d56615f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
@@ -0,0 +1,47 @@
+Device tree bindings for ARM PL353 static memory controller
+
+PL353 static memory controller supports two kinds of memory
+interfaces.i.e NAND and SRAM/NOR interfaces.
+The actual devices are instantiated from the child nodes of pl353 smc node.
+
+Required properties:
+- compatible		: Should be "arm,pl353-smc-r2p1", "arm,primecell".
+- reg			: Controller registers map and length.
+- clock-names		: List of input clock names - "memclk", "apb_pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+- address-cells		: Must be 2.
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
+			compatible = "arm,pl353-smc-r2p1", "arm,primecell";
+			clock-names = "memclk", "apb_pclk";
+			clocks = <&clkc 11>, <&clkc 44>;
+			reg = <0xe000e000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0xe1000000 0x1000000 //Nand CS Region
+				  0x1 0x0 0xe2000000 0x2000000 //SRAM/NOR CS Region
+				  0x2 0x0 0xe4000000 0x2000000>; //SRAM/NOR CS Region
+			nand_0: flash@e1000000 {
+				compatible = "arm,pl353-nand-r2p1"
+				reg = <0 0 0x1000000>;
+				(...)
+			};
+			nor0: flash@e2000000 {
+				compatible = "cfi-flash";
+				reg = <1 0 0x2000000>;
+			};
+			nor1: flash@e4000000 {
+				compatible = "cfi-flash";
+				reg = <2 0 0x2000000>;
+			};
+	};
-- 
2.7.4

