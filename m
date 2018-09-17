Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA38ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A42214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dy5Hge3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A42214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeIQPSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:18:09 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:36864
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeIQPSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjYqF+3FhX//yEr3fxvodmyJk/QIkR4+Ew4wp3Dj888=;
 b=Dy5Hge3tvmv1enCpThjy04COCQ5QonH9cFATP++ePmxNsJthwMB0tY0lJ9e5CrmbiS3Lk9d/yVn/FRGZe96dkvnmnL/RFCzREVOJkj6RKHc8gaajOqhu0LlySyvuz2S4OXxwEnKu3mZZpN4P95U3HRafq7Nxro9JOqQeB2Uf9dg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.19; Mon, 17 Sep
 2018 09:50:43 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 4/5] arm64: defconfig: enable NXP FlexSPI driver
Date:   Mon, 17 Sep 2018 15:18:29 +0530
Message-Id: <1537177710-9379-5-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8790c160-8977-4e83-5226-08d61c830c4a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1030;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;3:aamSBKeW9qpy20GYlZ6TbKlCu+vw54vPyy9lWVZcgnivorPak2JP1W4cCa6/e5x0ONpwe1i8edY/QlTwcix/56Ox1VJIMS7AOHzbiJd/vHL3TMAUKDquBfIpiFgo7WASWPzT+8rbQMZ12NlOQDXpODicyjcOjo84tWYTv7HElt2DcPZQeSywLES13PYhAxmWQkEMDp7PxRF3qBHKynsrzCTx7Tk77gBt/3TKWrtGhT0IAfC8ZQbpXZ3l4CjJ4Gyh;25:xWxja+y1GvJyRbIhuT7bA4v8AgiQ0cV62VDClq5PxrXkQ3rPkpO1rAlZP+N+x9FcW0U68MxgwnjCK3b7+z12C7R8vnVYJAGkGY1IAJ9S2dlMlMhMr9wj6ESuUHmwYObAXF+kkydlbjXjExHZCaJvPT24Vx2JBY9tofCblEjtkinYgNSngPhDEraFwfX1FWlVAyp1ldv9oNXL4+fumKXrVa5K7hXPSord//iJQCIRbKIaHONTLm+EP8+rn+5agsUR6BOe5IhzgwZ9vg1tiSADAAYEXvY55LxqKgwkD9tQ6w65e7z7bcz0+AB+IPJN7u5X6JJOnkR0X1QY+ZzuTWkxmA==;31:yZSsQ6HfXc5eK4MfvSdtv0qZCROo6yXfwG4RrWOxg8qeb9R4TsNXpmqvFhyxNubg/63/KqjvjCEH3Y/7Sj7XBKD/WMdrNpFf+PegMhwNwB5DtIQ3BwJOgB3O8hP42aCEXr6SBoojrIKvyHkJ0rXID7G8y8EOVNzDArnNTaWn1ZRkUbbyYZQQkmiJy/X7QZtSObsjqe6Tjfo0kqcEt+hbaod/klbLK68Kg1rWVePgXAo=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1030:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;20:ESppUddkRGtVZEGIvIfhy/r9LoyBTQLJMYnG45cG2jgAJRFhgLEVRYbEBYxDGFj5wo3LfMK0BAS0LtFh5kH006Df4iDrOI+xjGhxqFLQwcTSsXhrZyDp8FUhm3X0v+8PtYuT9X4EgqqP3+uJ1dhp7qLLpK9ZG2ZnRwABdHeYB5XyLFWmcSmcdmgk78AGico91HKFrEQv3upnzaU/4QeVZ8n8afheeU0poxkfc0Qt0ZTAyasxHH0AAkauzYNuhP/kawHrcsjzDlygW24Mb+aT3io4pSskb/mg7Q6wg0C5Mw1fUdETVmyNc5N8OErsyjHmYIFigNrlRnmllHbgOykHgyufG/CjbQo4B6yEVO2m/gr03nw4iYtglOGnNxKfubUjhmISacY0OvIFjk85NEeUFLQYajmLsUXnzZDUohdXn6JDX9+UBM5zrxG8f3bHrPjIVCUR0KcpKznobXnNWoXLjXEYtxcjysHtfOhMAcbDImFoQZ68XJGvitrBJ1ah47IN;4:ZqkxWQk8O/02UXIIrCqFQ9AWt+BBUa97hkyD/+h5r0KzY9pxw8F0fuO0IU5MrhYRNezQFLR+m2vefQmePwpNCe15s0NTqKvreR0wvyn8Yfn0vVWKzdRbvNWDHem7o75OGk0hWJiDIwME61+oCZDwxhe2dhzxi8/AR9Qz0wdbpHM3NkGnselkGHKb2Zc765IcPQDsbqC1EfFGceTTpKoJK+uUmaV5ukojzCrKt13WBm4Xnb868AtMkQNkN5GyoYTQedTpFTyVyyB6RbdGUmsBrNtsFBj4Xtd9S3lAYzFuZ6319tyVQEg7Ysd4rBGUlq7R
X-Microsoft-Antispam-PRVS: <DB5PR04MB10301DFD73D16CC7CF54478D991E0@DB5PR04MB1030.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:DB5PR04MB1030;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1030;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(7416002)(26005)(66066001)(386003)(47776003)(316002)(305945005)(6506007)(55236004)(6512007)(6666003)(86362001)(81156014)(186003)(68736007)(6486002)(50226002)(16526019)(105586002)(8936002)(16586007)(51416003)(478600001)(76176011)(52116002)(53936002)(97736004)(8676002)(81166006)(36756003)(5660300001)(7736002)(48376002)(3846002)(39060400002)(476003)(25786009)(4326008)(956004)(446003)(11346002)(2906002)(2616005)(486006)(6116002)(5009440100003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1030;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1030;23:XR3QpLBHILzRd6xqmYfj8VZfx7FJEB9SfPcg4F4vu?=
 =?us-ascii?Q?3gZFjxAmO42aZ+Gx+JbEVEj54qM/SSCSguepSNVUntNqrKS5ZLx/wXH8A1ig?=
 =?us-ascii?Q?WO062sPf62Pq/dEBzmzN3Jyr7Aze7hnfU/WY49TmcRnbB5GKsYTYSFrQneQZ?=
 =?us-ascii?Q?fyi4ZcLiqrLQkbbeUdUwd1Lm74Kg3BiccVdZ2Dy+j5zyADgbU/IPJ2+s9Ilt?=
 =?us-ascii?Q?UGyloE1nsyg1vddNdSWmodiTwtv683WurqjtiEcdeDG18PHvIyaC3q/CaH4o?=
 =?us-ascii?Q?WM3CAWORAWKX5J71qiHH3cR91chkcT+L0ndyRl7hHFS40ZrppQ+Y3gLGWoD3?=
 =?us-ascii?Q?zw4U+JXCCu1ah6HdZ1JPsraQz1jXs2HhxepATsz5aIiEW8ycB0ImznId1Rn6?=
 =?us-ascii?Q?qugNYhCwx2mLN3D8S/6U+63wou3kDUIfY0MFnQTH1I5QrlGmU7nfr5QpUGfm?=
 =?us-ascii?Q?CeGSqOVWxP7FV67h1ymIwP0dXCNL9qAgJHnK1e8a8MUW0jUTKPgLNGA2Qa8M?=
 =?us-ascii?Q?RT02noV4n+EgRHmPGw/a4sZ5p7TsY3aqj4ygbRdTg4US5hQGXPgXagSnIsVH?=
 =?us-ascii?Q?QgxaCqhxl1LTrl/xSnq3jxylNgHCkuy0CVsWmzyVRHtdF77W6RTnsO2PtGm2?=
 =?us-ascii?Q?ArryTU/lUgXXqyl4KfXUGr6ipCc2rga8bNHh2RCr8lcuiDOL2kNZDma6SH8T?=
 =?us-ascii?Q?A+p06el8A3T7NbTpY6ybWEcCwIzb59Cb6srp8ZLfttC31uMHNz+Ufn3xw91M?=
 =?us-ascii?Q?2v9ulX9CQYiVvCSwPgK78qVdhmKDTMWhdcxvXly6xrNY1O3VOMo0TGzMdCA+?=
 =?us-ascii?Q?hS5rYEvpn22E7bqStJ6UgpiT3b8FtulW9AmKjm+ih87kcFliB3MOZ6krAsLI?=
 =?us-ascii?Q?0gJgU6DkDRmIymFDrPifoZmi/kICyu0bHM7S8Ih2IWuwXeJTNwj/O5YzQuSL?=
 =?us-ascii?Q?H2JdW5xgp9WHLZnjpFnCzKMdonibsTd8FZHhRaZLS6AV5Z0nBnXgLlZI+L1z?=
 =?us-ascii?Q?Y+X1DPR6ffFp3IzTD3KaI7DObPj7b+sKh1FxTu4JfRSYb0hhyNKZIgQudqgv?=
 =?us-ascii?Q?pcf8mpPEWq9cpbK0JBslV7P8t7Ecg9SFyNRaMiOLcpZF7mXp2Zvrfl/EQJg4?=
 =?us-ascii?Q?dPuq2x/Yt6O863hGsU4gAGaFuJM9cC1aWAixCxTIlaSwrXO2k4Q9hEdnZ4tp?=
 =?us-ascii?Q?OL/KPtyIZGWWvmrfnY4RUFGxtOPGn4iweSVaNgTYefqwHKaW617MyGGTww3U?=
 =?us-ascii?Q?dcaeT/Er7vW46KuvAXnD2voZjYSpyX6pqtcDpHf?=
X-Microsoft-Antispam-Message-Info: Wcyus5V5rSYAL1sKHzKcrDT/p8KI03Z7uwjPsCD8LCu7Zeee4g3fFG44L3YHwZVSED0x1Ds38pR7jj2JqcNET/iArJfnFJQ/zaKNr/NSvcGdgySI5ekkcj5VNLogbFqg/EBy1K1WjyHi7G1h+Ay4UW8y1kdlm0jirDNEvxkbervv9tqDGPDFBKzu/WSs9WmkhBGys/g36Z6pkbY/xrhSSHTm4F53XLiwsIaim2wSpvnhcUTDFKrWM+YtbCrRx8J4PiUnruAAFuPj1PD4JOtuWaIkQSNXlEhJJi3tt0Z5ChIubZsi1TbtKw3RCPmRgnEPVJAkrHVesMsIAlEjKRkagOBU98bYODZtpTrYbLOoESc=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;6:l4KJs8bc3v7NBr5EmvvquyEgBrwwA7H7iIjbl6mTRm7PLhInQjejGtsTSQU989ZoekrlgXR3OTGgaVogZwYgsrWYLFgGbylnJDfVyPsQ25DKiuZ1d/XSSHPRXFylJTDELhC36tgsKOUkgP2qh9x2Jx1/t19CcD/0CDrK5lTzq+r4DLbNx33i/A79ZbmohmlgLAwCjsERJl36Tldw4y13l8924Z7P78eCU4BQ4xBU8CQ8bL/bRuA5068cRdHRZVIpSyEFG8ox1gfrpTSneULHd99THJplESywFa7K/ydTWtFUQV7717U4cMrnRDN4sqq9QrajzwnTZOMEQtDiUvxUljfUL3q3xjIhIuvV8Xr1ZJgqn0jBmmqoISj0wv4WPTtOUNCz9p2T3OpFWpxt+Ai0onjnG134loyBvkI3zwgXIM8o3xPo+mU1KuFhnpT3mk1HcQaBQ/sEpb4ecszf8v8iNQ==;5:MiezkTvTtcCKHFNuM0e9O3pCfxvKwL0JodScoOwOW8mdgl2d901V6bBvBMQEOIYm1IjndMQoJr9l67QvqWEDp3EEiwRaIz672ASvX/lKlPA0Fw7Yd30/lfRHCiMNT/h64RAsU9R4tCXvqzQw+H+ai6DoNx8cs/XpvJn8BIZ6yc8=;7:dJ5p3JBlwet2Ugvx7vSUU9P+Bdm7blxyOa44IygP3jUjrX2EoVZm9IJivg2hf7F8l7f8MxZj6yExeUe11ELZtnjJnqVjjfiN+NvUKPm0G65m96/JMJAFkHDaBylchSc8oCQRh/6MdZtkXlEAEU8yz7rq09q9SBBBjXjMFWk067vJ07bKDpX3EvbgMZs2WWDxKGvbywiDcrBezVpExcfKotS8CVKb7LR41IfbM67FX1b+bOpc4gWLMxfEx0TXooUh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 09:50:43.9339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8790c160-8977-4e83-5226-08d61c830c4a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
- None.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3cfa8ca..75ceddf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -335,6 +335,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
+CONFIG_SPI_NXP_FLEXSPI=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.7.4

