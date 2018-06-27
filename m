Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197CCC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B38824BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QdkFDHHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B38824BD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934686AbeF0B3q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:29:46 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:1152
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752484AbeF0B3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqrHaPjN0bjWqJuepc08DVRkAKAjnihiorWhxft4WlM=;
 b=QdkFDHHdjxG5Wkl4GgE8wJqZTfqB4Q2K0HoSbIqVHHtzRm5Zd60FvQnaVzpoRFzxOqhtwT1ovtG0wxNYnvZe3QJFhJP2ImtNCgLlKdAHZf5DmNXBWPV1dhkjrwRko5jD0/NpaYPXy2CmKjEOUomrUJv+ZnEQ0sgGmzG3DR3kSMw=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1319.eurprd04.prod.outlook.com (2a01:111:e400:51cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Wed, 27 Jun
 2018 01:29:36 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Date:   Wed, 27 Jun 2018 09:25:25 +0800
Message-Id: <1530062725-25779-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0095.apcprd03.prod.outlook.com
 (2603:1096:203:72::35) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b2e3d2-d717-4ddc-1cb9-08d5dbcd73e1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:YChAJA9nmMxPW9MS8eMZfQkt8TUEuAaPTsaoIP67j6gX1TFEEkcNpVXEPMLPTnFu4Qn5dpMGVaXnnon0BJWI4LS5dfbMWwBSJpTuBRFhcN27MXgeW/ZbkOb0Bmz8As1MPoHoKxhiC711R2cZgDhaGzoZTXYUuTCSd5E9wxSq0sQAw9eSpcFrktie1x4zdCkjDr9D6cqfF7jJglJ7IGuY8kRHEk4R2uD62017c/IQv5eO3e9qjinDR696WffSa3As;25:1tuiowL8qlUNaYIXcm3dSSQJ8W80d4VPbXk324/7A00HI15oh8MQZxKIsPaRh9SJz8ML80s9YYb4ElhYp3GBXWvM+QOaNf75Z+MboANMvEtE+AD+QD70GYg93Gkn7ufCrNwkmwIhPasWQbQxtU2P8XYjTsXjqDiXLV/Nw2ktzUGpJw/lZw3oXOg4fgVWZIYdV3Hf0xFy7kl8Z5cbiv3vGckj7fTaXeVgSsvfXdMUFFUt7TWWn6dSxnw8qXGpi5z7JQmXhh1poJRA6KOytfJEbbr9Y36Lv9S/KgY+NnbIMpSMIcUwqSSmULuRRWSs30uKODtoRkejzXF97BRMAhsfBw==;31:kFvIRqWMKoDTcNEMPLGz1jXGNSPlXbCP5A/zsd0oJsMVzpS+7k7cglPErpN/YPnCISkj5LwfeLjIYDFq21RpbD4ErMfSgZV/cBs1aufEQJspV7xuVpDSOzBciSmOgAxh3NOQuj89y74b+dbYI7Nx26UY8EBKxjyFaWCAiVewXtssv9/fxnXjg36Y/e1dwWjsqe9wGPkoh7b7rxJdgpu4jrocROAUd9xTWi5utUs6IFQ=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:AOvJo1+ETnXFiyo3Su0IZyMfAtDRw6A7vFQjuIxN0zxTi6FeHkpPIWCX/dmjIXJX9nzWrP4eNN9HdNnprzwdSqQGd602jikxPyxjoS3Y1Tmg0BdqrYU0tx/r67FSFTobjdlbwxeL0VNs+CUibfNvUOvczYmqD9ZafiNAyXXVbSrnIuIYwUgWhSojBIxcx5FJGm/rreJ4N1A2umoAcjYH1SYt0G6e0kzZzHbFSPmBPKJDpfZ7czCJ6i8TWpGajOOhGFp8nY1oZDs9Y+Hrz3bNzB+3ZiUQKy/GHpQMN0mFMgfDicqLYUGrEVf5/dh9aDwhd6a9spvEVSB6nG8Z6BF1xGMsW+50VADflujMgcccAWyhIjp8nMouTvFEoE+AcxZQBgV81tQ+vt6OvkfCWAZR4zK8VuGZNrVGquQ0eksVdjJIHrWzeHYJIXacZelgrJon2r2k+s5YJmktwWhJ09MmtPy+2ubB+Nc7DA7gaYkJeuoktZSWF9rZW3r43biz6P8y;4:q8TSmmDrS/JCbZuRYmVP9ZPdQNJ78jdFZsCx3KC9/YjyTKHBd/pI4vkOAnevqr7I1ybEsiKzUw6MWB102M7nsRma9vTrrQwtIZcUcHtZwb34BcvGrCGgbDc1SVT8Rj1BLWKBxiNlpsYCUYHfu0lT68bSlI4VV7jTeZmHW0hM+SLOMn25eQ2cNIN7rO+dop0DrLasE28V54j2CMvWJBDBIhzQprREQnK4EOwK0sg3LGS1JjCGqzIQHTOdusZ0zvrwD1Fm5Caf9xWTFOKiV56PGw+/LFRFQiL4ZwnzZTJ5nf/gg4qAT1C3RNpdg7Hc4jS0
X-Microsoft-Antispam-PRVS: <DB5PR04MB131908B4D30EBC91688838A3F5480@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(14444005)(6666003)(478600001)(186003)(6346003)(4326008)(16586007)(50466002)(6506007)(386003)(305945005)(53936002)(48376002)(16526019)(36756003)(50226002)(81156014)(7736002)(81166006)(486006)(25786009)(68736007)(8936002)(2616005)(97736004)(8676002)(956004)(476003)(26005)(316002)(3846002)(6116002)(105586002)(47776003)(6512007)(66066001)(52116002)(106356001)(86362001)(5660300001)(6486002)(51416003)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:b6IMf4h88huedLBOq2e3RYeVGLhsVu71/dCO/HWhk?=
 =?us-ascii?Q?CF9Zk76BW5g0A08zW0obwkW3/1ctgtlDyr+HTr4IChGW4wuOrbz2n4zqXykQ?=
 =?us-ascii?Q?lkrXFUg3arA1HUbGeNh6zZtTD2cdT6h26G2+YVpMOvRAozeBSYjLZ0LYETYL?=
 =?us-ascii?Q?sYcOoCo8CcAv3ssqQ51/5CYJP8PnZJLVJDukYDeuRQNH40Lvi1fxJ0JuZ6uu?=
 =?us-ascii?Q?d3sxu1zgukN2JrtYOk9At4c/y1808RGri4TedUBnvHUE4+VpI4WP5488Kftj?=
 =?us-ascii?Q?C15RvJQ9m6V6s/8O3XfNtssiKG+IV50t/BPz6UhnRigxgn44UJAoljsK74uH?=
 =?us-ascii?Q?lY64+7JmjWeogpMAjQknRIEk7RlVlsoipK+JD8pttiR2cq6o0wFE8L8L5CEz?=
 =?us-ascii?Q?ycRy68hNx+Ls1UPhV0/YqLXu5TfJQs1B2TKfZDyN5xgZclbX9QY46sRH3R2k?=
 =?us-ascii?Q?8JM6l6GXXH9dHeW30DoOjh5LtilI4AVJpwwmadfelEPaDj5IvU5y15tsjyxG?=
 =?us-ascii?Q?OAKmtGGfSjyNR7g0cdmL12lM6TtyQdXS8935gjab70J/F9dsSMkUAD/pvDcf?=
 =?us-ascii?Q?0c0VLSKQvru51knH29alfsXPyPSqp07BMVPwjQGqNfD7HB/gGLB1ToptulHi?=
 =?us-ascii?Q?aLadSm4Gz2dqfis7BRnsRnVIUnIXnwdWcpoRjbdj9E/NFivJ6dmJfr1QghNH?=
 =?us-ascii?Q?ee22+RfnwU08PoQswxJHvejST+BZHutV1iYCpwUu5JxDGx6k5j0S7F4Trnxa?=
 =?us-ascii?Q?Ib2XjjykinsC4oRMN34essS576Bm2aux0+1vHDa47UbPRiZ+OiQtKatbbI6R?=
 =?us-ascii?Q?qdFERFGpFNRKS9lObk1iQjaLqq9wB8UKGN6bVTJMu/pMODyeh2TRaH08TBhQ?=
 =?us-ascii?Q?LaDwR4UW3G9psOx5pkYkncqaqsDy/pX662KvT0lYW2KsCc0lDGayhh9XpZzV?=
 =?us-ascii?Q?xv8nGZvOJc8VgU3Xvvixbd4miUZbnp4LK5ecOqk8mgdyZiR7zGLN5wzh43fA?=
 =?us-ascii?Q?hbt/+mYv3lnp+oxR35YGXjJ6yyQVCCikU5mTS1jAUG6n3V/2YAZAjtzNA9Hj?=
 =?us-ascii?Q?fW0lKGU17ELt1iR2BwqtS2fghYcoyG331Lp7NxPlvyMlPrc3vttGdaTiEVKn?=
 =?us-ascii?Q?mTDpZrUWTChQGUfTcGqcuWLsm8+/g3+?=
X-Microsoft-Antispam-Message-Info: SJXxxXLg27y6a4Jx+gY2ZWqcT1xYhBYAWzrXi++nexHQ4/Hd/RBeOLrCTK9QpwWIlQcvkHMq4xs5oTFW+aOxs8pFzr4csW96lVsngdave9VjtqON/ujwzupJRDOdCia365k8BTHyLRFDQKykkOoTKdfiw5Sa6k8wIFEks3klgE7g87/N9GAsbaVTX/Bbvg+Gqa+bezLiilKnDOavA+BQco22UutQ/DHHR6Vrt0QZsRYvDIMdLiFuPj4mNJxCXQa2udfcikqVOe3ifHRdqmfeKKxn+CTBF7QTW6ueZtedvbMktPbueorFVBEIyDtTgUnf3puX6EU67UZvTUlxj0lXeawmHb9lDRonZOD9OjeiKZI=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:0J2xXmIv0LNCmvurGBvaTEvZGqAcdRo34Qb1V5go43LfZdDDT4r8xw24RBNsFB9AKDdhAwzaugDXDkjjeo8O6gEB56EJIbqwdnLe1DOfLZPnC+gJfKph7hMRNKceY0CrqP8a8HcVL+kJo2QQ8EVVSUxLJvYbWg3k1sv/77RT8sdvWqWA4B+mK82ABlHbAepBzgq9d1PdHsJYVVqOE5O7Sx9BPjZAzQq+mu93kgE+42/8F6994ZhrUlMsx8GpQoJYab4oKykcJhad6hxoQu6Xa4ZDFQCIf0bKQSGY7WQUHnbslH2zP3bTjWyegGIXWaRLeQiMvlD0BHKLx3Q/pf5g3yDYxnw22XI/8i4xqs62cDZBztLys0koBj/90PMluByfrg1Om2CMCnFbItl/r8B5C9ldFdCWUMXgMynGTbm6svA7rcpK8wUh4Wt8pnCSuTvK0c4zHwjsqaw2y+bDN4OVIQ==;5:gpKqxTAcqzZfAHAGdl9oVR0dXPxJx880vJt6HP9nHpYuaIxlXA+hOUhNbi0EG8n73QBOOeidO+HgBfqNjEK/qKrIEl/7vpgaf1/TZz6+AB1STs16AFpqH3rDdXy/If04R+3t/YpU+qdE7pubEFpyofnOnj+cWKh0fX+njh8XQCY=;24:im1pnqq8EITfTShwLzuBJrqLuDKxcegXn7xR82N1xgwpPH96hsNPOp9EaK0Bzi1eAljQRUpDK3BFxo712cEJxk/i7X906zXmbwiREu9au2w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:rG45os+WDSkOAr8zXzMiF9MOnYUMDEqyHP4Xqv2mclBKqQrFf6NsY6I9I4H9T2URkYkVDXWG12paZZAX2cswLJjVVfyiOJ/zkuacwc8LM5y3ieF6EYpjmaVOXg+phvazEdxJscug5e6QyGpFf4kj8VtdCwia1FjY8Ye1Q6kJHs9S/Zbbo4jR7dBY0BarLorxd7IvuMs3HHNdRZrGBwndOD0fRpijLO8rhFC5LNvMeEsvu4DKG5kZfieAZDEFesiX
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 01:29:36.2032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b2e3d2-d717-4ddc-1cb9-08d5dbcd73e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, PFuze100's SW4 is supplying
LPDDR3, it needs to be always on. This patch fixes
Linux kernel boot up hang caused by commit 5fe156f1cab4
("regulator: pfuze100: add enable/disable for switch"),
because SW4 is turned off unexpectedly:

[    1.693613] cfg80211: failed to load regulatory.db
[    1.700063] SW4: disabling
[    1.703973] SWBST: disabling

Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
changes since V2:
	improve the way of referencing commit, and add fix tag.
 arch/arm/boot/dts/imx6sll-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 4684ac4..2217c40 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -142,6 +142,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

