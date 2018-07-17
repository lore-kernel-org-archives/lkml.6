Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76696ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C7D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fDfMhZU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C7D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeGQUdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:51 -0400
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:13920
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729802AbeGQUdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfW+TeHXf25KA6qOupiMQV9tPEEtp8syyNbbmMvNliw=;
 b=fDfMhZU7PLcTjt1vt8jFoPhScS/QzRWoYgrH/CtOeBAT1dtpMXSK0YSMDET+0hp9gvX/67Igcheavmw50BLH4331x6/DP+/+DcUzibBa5r9/cPrg9YyLtIsBKsMBAgJggJQHR0lvYs8wI3qdmoRHavVGO+He1zZFmGrasaYcKMs=
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by BY2PR02MB1624.namprd02.prod.outlook.com (2a01:111:e400:5267::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 19:59:33 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.21 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0001ac-AX; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-60; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-J7; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 07/10] firmware: xilinx: Add debugfs for IOCTL API
Date:   Tue, 17 Jul 2018 12:59:04 -0700
Message-ID: <1531857547-16652-8-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(81156014)(26005)(76176011)(126002)(8936002)(36386004)(14444005)(81166006)(426003)(186003)(476003)(44832011)(2906002)(316002)(72206003)(7696005)(106002)(36756003)(446003)(305945005)(51416003)(336012)(77096007)(7416002)(6666003)(48376002)(5660300001)(16586007)(54906003)(50226002)(107886003)(9786002)(63266004)(106466001)(8676002)(47776003)(11346002)(486006)(478600001)(2201001)(4326008)(110136005)(356003)(50466002)(2616005)(39060400002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1624;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT050;1:QJ+qZo107FzUcCiN5TvR2TltMjY/S4KuzqKqIAPmpE/lDTRoqUnh1A2ZF1HeiM/S8ifXjXudllBO9WW/cJ/SOrYfBHmB7uarMc6NyqkwRnSn8ve/rTRwTfAhcUwFiG1a
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e9fd342-be84-48a2-3944-08d5ec1fd0c1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB1624;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1624;3:ownqcniHVMnYY9rCW09v3I7PZYOQ3G2mjynm470Icu/VT5/AU0hbCWZL1xdVsRVV19UBvxIFcWK7ZqxzzIyIXLs+heX4VxfcKdH5N3kPcuVpWOvimVuL+oEuFDGxtn4ufpagECycGPxT0iFiEEqKf8SNAlZn54vrusWLWci4zQycG3tD6xZrGYGHjrmCQEF4NusTthPpp89LfJbSXkaf/XHlaAeGgI/RMtzB2xqfWROCy29tO6SB6u72hXlgK6qPZa48FmFTl4l9wNif9c+vKqCY19XreeZYyQjHqjYlvRreZhVqO/jZI63NCEvNfATShcg1bxPFBvZnkUR776mkFaj2h8hwCkmP0E2Mw5eA8yY=;25:PUsyForZt69SCwaYivP+B2EEsHzjavOn7YxvGMFNkaSFHewnVUW7YmQGKSdtwHICEVmaP4freMslnroQkEKzLnVNZ33KmIS5eqahSInJDgYrAFJa0WWPYDrBop/md4qjLIe5WMojp+kb5rMN1pZt2cOhOmDqo3MKqUsC5656zOVVWJrUYUgpk5fisRn/i9mJOvJrcRmoTSRBFZLOxIUZLF1KbNCg5OImATLMfbjfKm6i3c2RDCoeZSgbX/blDVQOq780QyzlpsZrI60lk3uts52jta+ugLQ+rUx6nw3mU9xJUQpTcPwymqF0viBiUagDebx/AZL4T5RtHeQSNjgGFw==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1624:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1624;31:6kUOkkee3/m3cSCKeFaG88iS6ehoipKSwCotVO8GGY5D7E0VOpqtQ9sDy8b3+gpKiZAr4Kj5uoTiCk2n/d8lHnncPa1R5xR7TtR7LjIUB0J+9/5DLw7Uwc2d/arLG7NsHt3fNKmrr+Z993dQaWUQmTMGVq9VSE81NtKqA+qTR+vS9VaU2cqhQNXItpmr7yRl689WeKd19xBOfFRbpUYt4gwjVpk/9P9DHVCyyj3qhvI=;20:hhiAfgLh33YvhjlF3/1U5qiBDu4NN+1WIVzHUoqpf0J8DFD9K2N0rLSdE5VRdErquKbvDyTFnlXhYWEhp3OYdYByJEgRbkrH2JmFowQAkVBkWQa2n73gkE+9EWqOL8EnZe494tKdAiJCTd2CIlAdXoIfJJYJsGr3fa8yIhyi2TG6GZ0XnwdkUKNGp12BXcIQgpipM6Mopod/In8LrALU3Jyhl4FSxxQr3SZlyz71uXL0Mx9M7XX1iDNV152pmOM/w0vDgaddbfnPsRA3jC3b1pHqLvYUVd8nK62dLSL3RC6ZM8h+DTl/63ePPoxfqKL83yd+zqT3RCAs3UDrOQEFzEQx6jA3PGTSwQAoUHDUn8LeEF8edIOzKIcuEpEOlFuTIsEu8HPPyaCqxEI/MWJgWTPkT/Bk7m/7tvcfP0ZrNAugLA+AUfKWusCVZNpdJgWVvFQMNH/xavgmcJ99BOgA6/s0ZwIW2/gU/6uiM1SZlTAqOsbj8vwwUI6DGrAjCtAr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1624C7C1306D924C5853BBE9B85C0@BY2PR02MB1624.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1624;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1624;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1624;4:ENU4TzxOswOuwoyaUivaRoL+xY8OAHRTrhWnOCNMZvFbrt8sgKMnZjzojAnuEgEzc4uUWVJa8yAvwxOyd8CxVrCPiy5/k+zA7kefaAxplwR45DkN+eXyJ7J9h9N+ihWOfwogymYAO5/nXQqdCI79guZKKbSng8Hgwpi5tPWkCKIU5Q3WM7rEDsZsVGc4BMFNFqL19KY6MXt20jNfiheqcrGo5oBI8oyTF035nRohmIz6JS3rs6irGisOldzRV+sPHsLIPFL6AJyI7+jvkYk7ZMCZysLnmcnfTV9zfg9oCX/ffh+oPjCXMSopPc+e2Tfl
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1624;23:W7QLxbKIoOwZhlc2sGW2K496LptagOh5a1PkUvUFx?=
 =?us-ascii?Q?x2H7Di0tg/09UyyTRDGftRIOf29aB2CuEhxdrOG60jqx6tynFLkAXn9eUPUd?=
 =?us-ascii?Q?vgvoeZYl2llD9rGA43qQ5ro10u/8id0bEHhWtjiZRd8O2grYOY9wyJh9a4AP?=
 =?us-ascii?Q?AzGQywhtfoViAtPgcaFXUhUyJsL867L3fKnrWJZkgUXsiTHwAlpJY+lW+DVn?=
 =?us-ascii?Q?ipLdrV8V6d5EHce6f6yoi+5J71toMYpQWRTUV3M5iEboa5RBqpsP/AkILULH?=
 =?us-ascii?Q?uBzij1myXF6vQ3JTRTrG6O8bh2KGR7B2TKlhm96uwS1r1b5R7aKo1dvmkElr?=
 =?us-ascii?Q?WPV2R+TeR+smml3DOq+N9gZ/pxUG5UiXvrwzezBfE1FprIWrmBMGnF1uaEZN?=
 =?us-ascii?Q?9WGENNLof0Br3Qbh2Db9RtAH+POu1DYX2PDTbKmhKEVc1N6OF7gpd1ZZJLsl?=
 =?us-ascii?Q?dT0yp/GcudqxJzstcqm1a4tSk/5LhA7lb7JHQiBlzMAJR2+wEvAn2KLZ8YW+?=
 =?us-ascii?Q?SGLuP5zUoPP0A0FRqdCemEzLihH9lOI27xCiOA0qoOZl8c+FmXY7PldJxS9b?=
 =?us-ascii?Q?sooev42Y3xXmzKN9FKDuekqXlVBRHCZ2jlI5jgieIBZVcUSlv09moWOmhUrY?=
 =?us-ascii?Q?ItRCcsVwQPhA3b0gRKuK7MAD7gMzSx5EWww8hfbznfZBS+6r8XWY/j5jQ1LP?=
 =?us-ascii?Q?rvajVMazR1m6nfhihnRp+lUP66J6j5BOcv6kzv4+73WSJP2LCBp1uEC+ishW?=
 =?us-ascii?Q?7pR88Wg7wWSTVurd97+4P4ZY6TC8aIuZbDBPBUuUQ1p8QxAbrRC6lrFN+wEA?=
 =?us-ascii?Q?oFKNbSsCQaCjtPy7rAaoCURLSnGP4dd8zuOdQB+vgQoBdIaO/KB8KDy9EaMU?=
 =?us-ascii?Q?UUeqT6sOcQmLzuFptCQAUP5pV6X60aiWCGTGLCcc1xvvArmdveuUGGfe54hX?=
 =?us-ascii?Q?cS+j6SzAKSZiZ1AWaoE3jeKg7VbX7zLmuK9urqU5cLLpOzUgrdkK6rkEMo49?=
 =?us-ascii?Q?mA1V3ZjrXzjlAsOUqxa1CMFOl+xEfa9cOeZR6boVs/0jcopGAjEDOHsDUNdH?=
 =?us-ascii?Q?H0G/ZEmTRT6ZYDOSuSpqocdl1PCEfDmyXwEURqUb04bXWM6tO4dL3nXJtbhX?=
 =?us-ascii?Q?W4uKvH0v5ruP0fHwZ8+i4jnw/VKMHA5TYEEYgVVkXjIvV/ncMeuHkJStTJnS?=
 =?us-ascii?Q?e5bBpZSrhFSZEjgImNc7vPlpSkP3Xc8K4tZkcvMQGvOYsCuDQLXjoHpyzwWP?=
 =?us-ascii?Q?L0TzV4LzqDUL2g8Umo95GndlmwNYZl/eT8dDtuS?=
X-Microsoft-Antispam-Message-Info: eKSnc+wJv8nnU2Ah7EfzlaTX2iYwmqSrQYplbkzUpfs9KsqTzd0W4JcD/k/S46YIAmEYtsFEPMI2vI0IcsM5+mBwSfEQvjzo+D1P67s/IDbrkr1wHiVawY+24eoFXVxdKh+56cwlry5os6edeW5Sr4Qqmg6XSPTq2slCCijn+Ea1Jnely9pi1NCYs7WN+U53Dol8nqrGn1LSbQQhybQI0pOzksovEdeR99VytfVgothR4MlfL84YFvkuB+Jd0YZPP0pZfQcQKG+aBuxhuSMH98+bCNpdCNETXaHScPdEWzG3QzRFPpUhNfHksR+ysP78gBtfa2aKBIdkLQ0dYRwfqI09NNxg3P6LmrOjlV0DdWA=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1624;6:xvGWtcQEA5dMy7qnIVDg/FmvPezA97LKU8W9Uo97ehZ9RBzVJ5FcaPEAeJgRuNNk/Az6Yyck6W0Df9gqtqjC/Y7BS134HdUc+hSxzDJxZzIGYxOmN+lzkw0JfHbXDLEWGheIDyaSp3TkIugmiJG8gaDp+JGfky2KrHhxRayxG9czYSeq/NzOfnmbHwON+Ti86RSB38ZbcDIfwAuTZoMz4F38iLfF3wdVhrzcBasuQ6HCa8iCdldDzNM9/RwDYgGd7hKZj6c9kapMRBgSO5VclFSyev2mSMBcGnAQJyY5qMOOB0MTwRIamQGSr2+5VPxyLlmsxjnXWY++WdPdA05dVPu7ZlFvkagk4tRW9sIxKR2/7oB4xV2EYkOmY5T0hWd5I3PrFEBcMiQt5s8t+CTxWAcqEwuJP8i/FSk0PYltUgmQLP+ugNYJ793y+XaLn+cpw7LFFRAk7E9aw4TnQ0sbYQ==;5:IJviWXgYGRFfX/ar09V3xF9Sr8bncjOE7zQynKdbGdH5FEmNVYDfRJkJkcabbntFP+ropoXlhzH2IcaigjmE8cXI7yvLOegyChGj3GzCJmpIPKt//dFhEOUPoJeNHpHGf6KIuGKuhIs0lX3W7vcwvuWNrrlBwQeRRBmsS6YkI3g=;24:ND20NSlQJ6h+PLXKpQKI0eSqGGx+p6TjbmjLaYdqWUYi2DwGoFabug4hQNhr649T7SPv4bLOlo4MYv1dNp+vQn8JagP3Wd5+EqKEj4oJaZY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1624;7:J2m+FDPq9tC9LXyqrws01eRaQDOByVzxMNM/OzM7+xEozkBScPiWrHZtw9ygNWq4ewVq3zfmVCxKUDQUOeKBc3/XnyuIXp1Cwf9XHdERR62d0VG3uHz6WQ4WFQxNzl/a+wS/mSj3pLlyS7OZ+/jfq3dTR+CNQrYp3o5tiH1ui+PTR0d+kBIQoNTynuCf/LAe26xY+dyYMwUD7D34saOScJ2IB8GC+UrBPE/UAlrSPDopbUpli6urIkVqZbB8Zxsv
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:32.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9fd342-be84-48a2-3944-08d5ec1fd0c1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to set/get IOCTL using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index fcbdd6e..fc11db9 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_IOCTL),
 };
 
 /**
@@ -95,6 +96,15 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_IOCTL:
+		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4

