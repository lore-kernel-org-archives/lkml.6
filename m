Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7840EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9D32154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="UA36mdTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9D32154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeHTNQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:16:49 -0400
Received: from mail-eopbgr10137.outbound.protection.outlook.com ([40.107.1.137]:53184
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbeHTNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wviSYsgLYmP3fV14jNkQfXvJlOMPD+JrpzoUnzfVTWQ=;
 b=UA36mdTLqrlVBOocv1CbB8U31R4RfNJ/aGjg9MpZh2D2Y6EVsRsUe/GdroDUfDMUgqDyPQQ+YlaH2rbtUXl9fxtNLpzujoGBdZpkEuO8K7pNuB6G65LdvhCLzwaAT+O/8EfEM0aCasK56QfVRtA1AEIPR2HxkrA2pfzNRMzY6Cw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2451.eurprd02.prod.outlook.com (2603:10a6:203:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.23; Mon, 20 Aug
 2018 10:01:27 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/5] iio: potentiometer: mcp4018: use the correct MODULE_LICENSE
Date:   Mon, 20 Aug 2018 12:01:10 +0200
Message-Id: <20180820100114.22966-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180820100114.22966-1-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::29) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42244c0f-f1a7-42a7-7637-08d60683e581
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;3:3a0jiE0RcWM4CyDFzxsga1duhOHqUVvdR1Oi1Jpg59Ema9TSGqtcKo/r3q+kpkP8u+NOotd14W/49Yp6Lg/w5v1v8+LNzkpLRBiaxVV7WtnQyhJJdt8UOHj1ko/j7yGnuAOIh44Df2m4rIiu49OXj5Ui4XCJ0jhrrVlVjRaXcUo+Z+rHspA7gSpPYXAh76ZuXM+8gjy+j8MGtGYYYfLeZoEGUFYtGCj2HOvC3azlmdSXnhIfWwByOKHTLCTE6l0m;25:8p/6qG6AQoDegdlBt9e/nTlHH6cPTrZJkmmmmdrtdth6g1UkEBI1VKbFmgCD8F5oh2J9pf9z+EGgMM0PJ9GOHW5z54yvtqpa08FznlDIscjB7irU1XSllbZkQq5/adEY6vZf6AfPWXjmMz/0swesLO+9Tjv49wFDlrIqwrrvpm1eHmo7cNQpesJMFCndlHUIrRohpEzcHEyWryMqvXD/SKp5YBR4yhfLdU4hyYV8DSWGJQ4hJatGjSW4XBRwQ//FlaYfRKnasbPCbRtLfl8eNUgfWZw5Fm1e6/hu+fND/58MbH0sTFaun9FjpPGNpprA9lgtCynxCU0ai0fzqeSjLw==;31:fdDw5zWux2MxwaAo0fwabfLPoQOpIEmnd2hocfBIhzbSB2la49yGKinMzCTvS06nCRlrwrSR5A68AAHFl4BXKMt0JCVWcC/CER1sqUxdH1uWgonWLehZDGTPA69IdbXFpnPo/XdUwOsEbqeehaTHJSmuRr7sKS4Gmryrd1xevwpCNbZtzv4W22CKpqwRWnOqOVGb0sZKXjF4JpV5gVwQAAS+OCr3l9tYn+A9LBIYevU=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2451:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2451003C58B26D5EE2D9CD6BBC320@AM5PR0201MB2451.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2451;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2451;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;4:Yn6+8fbQQGJrMx9YUDnQ2tKzgs/YyFAMLa/ZDzTxeB9EYT7YQVoyGwSF4RueBFqUfzLOWY5VIdE6hjc2DqqRKK6/rO5Np3G9r1zz6DPYcpqx0C1ZMWJrES3IfR1L5kdEaQoGqZLqB1qCe1f/9TV5E9rLFcUXBkRipq+zEmlFFjn7tg4+FObUtUa7NK5QV67T5nkbU58r32xQyMtwmWMA4Qa8iSU2kLvCw3gTLOX2F15rNuliS+tr+RjX0VHq3MzpR21spZfVHruYi1UmDs3Usg==
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39830400003)(189003)(199004)(6666003)(478600001)(2906002)(68736007)(47776003)(6116002)(66066001)(3846002)(5660300001)(14444005)(6916009)(6512007)(1076002)(53936002)(476003)(486006)(86362001)(97736004)(6486002)(11346002)(956004)(2616005)(446003)(48376002)(25786009)(4326008)(50466002)(50226002)(8676002)(81156014)(81166006)(76176011)(51416003)(105586002)(74482002)(26005)(54906003)(16586007)(386003)(186003)(106356001)(2351001)(316002)(2361001)(8936002)(52116002)(305945005)(7736002)(6506007)(16526019)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2451;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2451;23:00pbgb6G/FJuwm2sefFsU+L2OUhv+r4XklMjxnm?=
 =?us-ascii?Q?uLoGOZGBEnAtXA5BUGYsyHtLZWZ0G8HnQO+iGtHrTyPz9mAzKYT7TsciHdiY?=
 =?us-ascii?Q?uxUaZBWTkHk7etDfLDMpivVNhWuGYvI2kN43d6xTpHMeQMcacTLua1ERVoqQ?=
 =?us-ascii?Q?x71MM5ezUFYLH54QjtqeR9VJKy8m+hgqbi3ySy+xFgzb+YMoDFpeKwE2pddG?=
 =?us-ascii?Q?tNtjM0SJXa6+hYGdEZYlLRzh8J4G7D/q1xty5+8C1MUO8esnCGhgmIScLKyU?=
 =?us-ascii?Q?yKYc0yebJhpCELk8UEAdvLmCGK48aVUvtVl/Fah0rsUM5dmnRuNegkLo9Tt9?=
 =?us-ascii?Q?kcI+Pw5I+j8DbGnoZCe9DAEOjvatjxuowI5ojg9aIdgNmZJDvo6VZ1JKXl3W?=
 =?us-ascii?Q?REzvSXGvIa7EwArLW967kQk7zWzC/egk+3ggMYgMA7PvsyMr9VlLyEDeRaOE?=
 =?us-ascii?Q?J5hm7ORKIHCaN1ybSXWGWQfowLpsQzM5+9uMMR5U6E9BOwnrGVOVzstDWVp/?=
 =?us-ascii?Q?UBQQWN8TZfTm1cMMoodUx9ltBfCe/tLd3vqyqMfFq1tSdb9Pm8kByJBRJm/s?=
 =?us-ascii?Q?/S7ujQeQt4jjN0iwS2VMdP3JZ5nfWFD0U8qNqDNbrHJDbbF+rvc8E1OZt0f3?=
 =?us-ascii?Q?jUuZLatWfihxlkOjAvaRMvdHJCGYGEjfmXYV0/ZJHd5WqA1tx3b2NlUv4kSI?=
 =?us-ascii?Q?1bIyCNmY+21N6rP8J/nGmDT1HV8QRszHjch/G4kypHC+OrIU1IsooB4qfSPw?=
 =?us-ascii?Q?5wL359kBXQBuarkJd52ZAoZUUaDPvF/VOutLbh4ptkXhQqPxAEE/gcDFGfA1?=
 =?us-ascii?Q?AfkbE91qU8+XMtbceyPnJqDUKrSdIvdiNikw/bxGTTYdERfxq11Xv2YkbGs3?=
 =?us-ascii?Q?8dgS1kbaAsQTfNhwX9T3gcRt8NR5UlbIs2TYtXIW9vGDB7sTxIErs7TYzj5K?=
 =?us-ascii?Q?5/vO1tg+biE+HzTIj3mZe2WhfAHs1ajpAzfmNCYUGELCzjdZ33Tf+2r/EYSs?=
 =?us-ascii?Q?bt5TNd6ATBwMtPe5o/kbPegabZHkfkfmCB0cybrVyzre+dy8dTAkWT7LIG/A?=
 =?us-ascii?Q?beE5pVcSZ7d4auR0jtIeA9ONgQF2vTjM7zAb5xVsS3mPUptauolgjwwHMg7d?=
 =?us-ascii?Q?bnRuwwKiiLcV7x26pKvCP2P0GAjQyDDJ2hb1CNU6l2q9fzf+8H64ziNwBz5l?=
 =?us-ascii?Q?DNv0uQ6EDireuMrBeQZq1C/HiG3VBmh2DhOICFrfLZxxCTi6zmhvIDlCo0HH?=
 =?us-ascii?Q?IB2WPecF2vxPzaXNd7JUAWm/Pv0TLF0BNqbGrONh+973JcwgwEot2b+rGHCa?=
 =?us-ascii?Q?705P01VBZk+U1lXezRJE3ipM=3D?=
X-Microsoft-Antispam-Message-Info: G9fQUXK5ocyL189yAQQDkYyryYCC4hXs3dQn/8KUVZbcOUfkFq7Hl42R+ucJstNQRThpmkod08ea0fnjV1ZjxYju6+ni2vTLuseibcQprIHvtjWCzmw3hL6+1hTVm5quT70dC+/Qn9yUe9KAHBh1KUT6OUUFo+oSdwEPFtVL36kmadWatPFwgC9okz4SUEaKzBBCuSsKDShL+S9nIPkgiQPxbzAmcAf0l+uEPFZgMo457UIFFeGIO4MxyUoE+XDotOEmwGXJBGcANDZ5NDRVIDzZQpotVSjUU2Ij3xdWSf5XDjy5CizhOp0Z+mxsD2TH32jKm3Qwlv9PzSgUbzDj7PPZ1kPD05pcbWhuiQaxZZ8=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2451;6:rscG8j/vo5wtBa0YX8PdFNhCCA0X32t9b6TogsazHG+OR9L3zADsstHqi6Nxa7Dh9LFXXak0IBKr0x2LuAxeI4DomVcrtgS22yfrDwOjb3Z7u6Ve+ZfRLiymUzFBfAUoHalHhXYPVYk4zcb1kyxFl6ikErxVionbsMVhQHvn2vd2xgqR3Q44JDTfe5JQk29qlK/ENWAtgli8483GaTn1TcYQMOVcGtA+Kdg6Cn7eXSXroAJxOa3aOYa0dPj5Bo/FB6T+lNZzvFRHx2PxyJIQ7z4WR7090rukpyej+crTnqeG5p8rW1IiTS7XnkY1gpJ8bPyY4+zn9lEAWq3UeHSB9YWzw4R/8FRggh9mVMkBUN1baMYP/v+dxYPhA/yKvSEMVnMzYHnEjd/Djvnf9cztYoaq4+Tqu5Wnr6AGcTRr9vEeyQQd0HL4wKtBmKmJI4KmKYV31W3apC92SsaB0XYTxg==;5:JZa4I1m/Bz6mM8odtyE5+E8B+wUiPJhxdWeLfAQyj28RO5Mw5mJUNdtDsm0hwc87FFkwmpXXk3cff6UtpA6n+ZqUrpzCGk7ilazt4+onio0Nnn8DsgTXjHUiMZEDjcMH991w+kXYkBxdLFHALB3CoQh30Q5LIjRqgUp6Uiueaoc=;7:rRPPwqfqDfEJVkvqqNJO5NgAaIeL2Zrl+ppRZR24fSSaJABu5NFBATx18YEEYHBBhpzbALqIIhGFCGO9A7qv9ZQmPNjYIcR1tIK5oHNV5X3/s3Iaaryxq8PhvfllvqXcTT9a8U/EDluw6+nVa2l9u3n3/w/pqlndbZ63+NSc3sUfwJNgmJdEePvus7EfhpkUBQposelgWn4V985zqHuUzl64GP7gV61uK6vy+A6X79UZzk01i3VUyfl+Zd0hqriB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:01:27.2176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42244c0f-f1a7-42a7-7637-08d60683e581
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file is GPL v2 only.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 320a7c929777..5ab74a839982 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -190,4 +190,4 @@ module_i2c_driver(mcp4018_driver);
 
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_DESCRIPTION("MCP4018 digital potentiometer");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

