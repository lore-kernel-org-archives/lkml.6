Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E80C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF4C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cNU8YWY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF4C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeIEOAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:00:49 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:31808
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727965AbeIEOAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sq8WrbC5MsWj2gsNLMSgVQl2eBJQFTWJoqtfG9QTnc=;
 b=cNU8YWY/yRjVYCDtHON6HvibnGI3byna2osMnUgSxNjQeO4Y0v1BirVtOv3ZIlsD2oRmYDAjzX9h+6mBCoiOCLFiblQMAhVKaBbnJzYu2X8362NVAIgHtuahqJi4vosZ9a/Vt8Izmr/7Lo/mbSb1IhLlc0cBTibkqWZbiq7jcP4=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 09:31:20 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, marco.franchi@nxp.com, fabio.estevam@nxp.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] dt-bindings: egalax-ts: add support for wakeup event action
Date:   Wed,  5 Sep 2018 17:26:47 +0800
Message-Id: <1536139607-16848-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dafb7eaa-49b5-4a63-3224-08d6131258e2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;3:YZfdBKM/mHySbUhA12LCDpUPbPNZBK3oAOeuPeiOmp1NkCn5DbUQzdbbzTHDjpFdapiTfgpsvhaKse5oKiHEfwcRAP0oS/ASIfJQmCpq7sPDtKP/blUO/wd3tLQGUs6etDjeNnHwDxtodGYFr+0uNddhkhRSbulc1h8x9D7BVi/ldwldVsAEnSQiaACtZhX7/iJEr8fqaQ0Q5CIXIK7vCZbRYipWbE5rFLWVROcu0VpTwfpxPv+zdlPxqZl4Vtwb;25:xL3AnhCuPblRyX1tn3nylMcaUH6Tg9AOKjsp2u4aZf6hI92YcqekPr7s+RPPYE5zENqhMEOWipcHk34AmwPakYeQDiWLoP0QL9FUhflm3oQa951P1vrySb/KBz8FOlQrZBTUZp9nOuxxSbO2tVI6AcS8cG7HVU6uTa0Mrin6Z4d15KVNPnxsnv9NtMaUVRT6BoHdCnF2NDKXIungE7D0sBl+4Z/i11TRqEH97vgLSPGQ2rq2JHa/7VYFZnUJtLr9fRdsRCbIYc9wPtsHCyeQcrfYW7Rm17iJVNDJibq+e+BRIr8pY1ZrNzZJAI9g0Jp23aNFgDbBSy5njut/M4T0gA==;31:lk5hO2+3/Msol11syO6PgRuMpbbXXxtfdNet8ydN7NVgzBQXCcGOPiugplDz9pDNQVVCOMXDYR6fnwJ+l1HvwpELFxN+UALqdJ291bqnhx4LzcujV+OYxorSZJTIJi5C/CWiIuCh1SfDfbZCLiMg5tgSIxP+LAwiueu11deK0ECNXOtGOjM8/VsVKScj2u/J03T6yt3DwmJJkHU9ANpuagwTve2iofWFIHZ3pVbs+Jw=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;20:nyJ7SJS8Vfp0RE7IHxSfdA7umYVJ62Adp2wptCGBChg4CHloVJxnW5nX/tCK6wr8KYw5nJ1gD102+rI4CNNp+S17n1u0RBc0H4o/ioYWlML351bwNVm312OIPAQBIbLLhSKSTCKG/nj23OzEP/IX/4adxTMB83QiuwwNNG3mMCgVx8wQqCkDOsslAjnYi0g6fmZhiGVMa6Zx2ua7nId5MJkoar5AlugqnFvR7tQgUrpqjyyD6gpQKn7+AJc+RTjWIOWNLfQQmrzWE+8mH8bKh/J3pSz4Rw/4pw1wSiiQg4CNXcNuRFK4e2aObqF/0mYjDz5olTlknEMmhZXQmYYe69Ttb18i7CsmNfkpHKbnoGsvF12dbZ6tyB06hrwgC+l+6CiUiXZD+bA43reLrnubrtAFZD71IRRDGEGlBNnBVdNn5MVp6043VgKX+zLZGYuUSG1dhhEmB+RkK0nxvpvQUjBIXIkD7WFAqIqTeMTrZTD+VhSn426y2bjRDvFkIQpa;4:sAajCuyK1TyhqgJi1yH+AVF5bzL5cxrzxCe6KsG4OYLUw8ousj5RqzK8gxEzJoegCbMhCMhTXC7ztCQgdslsOYQlbkZMHFfpVVSXKgtzTom6+YPYKONGvs+1X9kjiKhmcT08MDO71BO+Xqhl1qMIZzi6VO9/F8ac+8xANpqcsEj0C/lm+7o77PS2hi2UfH643m2/7vVbLGDh5TYqd/3SrIo9fmSp68IIrkPLmqZrCRtxK+lhaEwH2a1DHwKvI7NusenpRTvGWoNNYp/Xh8GX5QElw4hqBQvXywmX6xIQWfbXAM1IV1rdMs8Oyr+rmR50
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3916A89E59228559CCB9C626F5020@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231344)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(86362001)(486006)(2616005)(66066001)(476003)(50466002)(956004)(8676002)(36756003)(51416003)(186003)(6346003)(305945005)(26005)(16526019)(446003)(14444005)(7736002)(52116002)(76176011)(316002)(11346002)(6506007)(48376002)(16586007)(106356001)(8936002)(50226002)(105586002)(53936002)(81156014)(97736004)(386003)(81166006)(47776003)(39060400002)(2906002)(4326008)(6486002)(478600001)(25786009)(6116002)(68736007)(5660300001)(6666003)(6512007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3916;23:KaDHbeyRWSlkHUekrWTuug4vPbbhWEjjpzaDp2X?=
 =?us-ascii?Q?owwIQKXFlEryXHCiPeLnXsMum3gpFFesNQs+XN7vrklNWMUhFCKVs7jcO8OE?=
 =?us-ascii?Q?elW1LjNQrAKodRDfRmRfOZKMkxpjQu0IAeELOF7lI68dWqIzt1TOq1ZFZCXI?=
 =?us-ascii?Q?xV5V3cUBGQtX6M2AtwBu0CUfWl/y580Tp78Xwa/FeqE4bH/nOx6SWCONm6yF?=
 =?us-ascii?Q?Vz+diafraAAAznJ/KSPv6tOtsIhLBFrQOfNyLPjO7fBd+T1dcjVHAD76MRg1?=
 =?us-ascii?Q?iSkWD65leMVCxjTVA3hfxGtyglLvHWB18M8SLdmC8IYs6eBoDqjk5KwbfBeV?=
 =?us-ascii?Q?QSsm3xqlYId2fvaQfxl4MoRHXFd6KPvn5d6QOS9ANUAbg4T8ucNK3nHlCPVQ?=
 =?us-ascii?Q?1Jqft9stytcLvwPaTbUPi4DGe8eaG+GM7+04kuOXl7Tw0gkXS22QbwobJFKm?=
 =?us-ascii?Q?N5ZwxkZ2tYPKWcCYrOwWfAuRdt3xjwD+d7SQ7owRIEjJn3rI323LOONch5Oe?=
 =?us-ascii?Q?NH3Q++VclkUKttLWm6pSEqSDUJWKFpvH8Sde86xWqRh4k0Mg0cXtbkmZfUhC?=
 =?us-ascii?Q?wocpHtf+0pPk0CMcWdWoFmnhQJtQmw58b7/P8STN0WPAuqlup/0+xsM2OeO6?=
 =?us-ascii?Q?YhSv79dIohCZY1OykHxGqNs4hNVshKiv1rfw5/eaqcyn/oB47Yw1PZdR16uf?=
 =?us-ascii?Q?riTPVab7KyMm56IVDJJ8n7RjqplAJbhUf87p+RAvFp/cU9zZkoEwe37Qnk9h?=
 =?us-ascii?Q?yrUH2e+3n8R7u37NyqvqogkwRg7Ev5mdR7t3JkMTJBuIBad6OjfeH2RsDG1w?=
 =?us-ascii?Q?UW0AUC9rpE12saVhG0cbo2QUEJiR3FQKcs/Gc8ZYOeGObTILVgND3xZv+Ziu?=
 =?us-ascii?Q?OR4Fo6XUvFYFO/PGDzcVqGaNK0I8ntYJ7Hay8OxJp+fVS6tPI++4WH9OLtLJ?=
 =?us-ascii?Q?fpyHDMhqXsifOYpcdHKSjubFEPk0l/nJajcolGygoSbKifF1lPAlHq0AKNH5?=
 =?us-ascii?Q?qceAlFmx4QQFkT2KiUqMIiogDhsGEHWe3sVtsBHMJ1j3MtVxYapLs1zPPGE0?=
 =?us-ascii?Q?39ShmrOLN9gcbOPrSMwe7FgdzKNfHhrtr8/UHoMie7GfW5kypwZ1xyaT+SxF?=
 =?us-ascii?Q?a38+FDUYhyC25s88LVIEZiZBXY5G9QNv7b6mD0jD4/qne5KLj3iY618oKApx?=
 =?us-ascii?Q?gCUrF1zL2sI3Wtqa4W+vhrSYHZaPy5e9mkWQG?=
X-Microsoft-Antispam-Message-Info: vEShm8TiWC9W6t0GTyQ8mJdvwolwn21r3pdArFZYC7TGrOxrSZpjdQmM5iwI7tYN/32wLpdQJh0U433wdPjBFZy9dLATtqpOa5OWhOZ6QkF7LCYpTP0MJ/Mwftvt/VJSxbqkkbqXeBASL9hGmcr3bjMTAgk0+c4BY/mRRUZ/YZCHNKWu/JPT/2sMjF6At6MNpkzKEM1Pk5bJdhGonANpS9a5KjhEvHZYbnAIgkUVzGIHzP4f3uZx20T0athvyq6IfCBjR+v9GKt620aRP47KcdkoUfZ5Ng9pn90+0dkfMMDjnOL4EPOoKfFrB6ZQjG5J1DNUAHVBKfeyDAnUXca1PURtFRIlzxqQemrJ31W/sic=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;6:puloKn5f21XseiIIbkrapGAezzmu7E0HUKP61QkjX9Ctgp9Wbd7iG25ABLYmhU/hOelCU5D1pB1vE02bNLzz0j1AOU8Icvjx0ZYcfvjjt3uqNz0YlKiTuRRjCiZB8XWdCIh4RbphgUykVv0aq+VO6Z2lS8U6+rSHjRxvSsVTbhIexam0Le8w1FYG/hu5/1XJSWJipkzV2SWGqJuzEwxn0NqP802ajN7Dv2+dNJHmgWs9Scz+9ccH8GZ3+2yiMybGDIarwe+ObH3PWYSYvHuym1tmV+1Snr6iJB+yLckgTHjtrLKIEM2FbgtsWiBqXxrJD7HvRsyrRhbavYexiQKKKd2Vqu4NH18QtVyhTmoi2ORn6xDt7uiT2cHJwVb6U9z96OKk1MTtHfBa+9CmrfvJX0+whVTNKC9/hVpLN49h9TpTEBdFpZ1Bv7QfNqMpmqlktu/aHZ1W9+79by0hH0z+ig==;5:2s+pC5/lm2DLdHODSPqOjNwkKhwQHX9HNDUO2Ub/BJrTsW6qPxSqMv6R55Ohj/O6shjBd6bF79MGYrjJldqdkFtDLZSKMxZLrsO1dhPd759zbXdsQFE/MNk/7IuLOpaqipWfEhzeCUM4zCX1bEUbX1jGPHCqBEKf/Dd1PzGJ+No=;7:XJ03pi5zNRlymARIKOX2cmynq2jgV/cTnM85cIHx+/z7xHQyDZrgjv8sdf86ZFCasDFqJTeBiKgfSwsSw+sQgMmrGXJtpsf1/avYF6K4lSLNmp7O+M4M4DhUI0kKE9uWSlc2AQ7nTXtN//WSLWMJ6Hhk+eiFAcU3nhVA+EuSrqubC1WMgQXqum5olJF0NHKM6f7rCtlRPW9dw/tijhDAavt4hGTiC4+BIcj6bCFSao9usF3ZWcG0R/cdd25x/QnU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 09:31:20.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dafb7eaa-49b5-4a63-3224-08d6131258e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wakeup event action, this would allow the device
to configure whether to be a wakeup source of system suspend.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
index 92fb262..296a9cd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
@@ -6,6 +6,7 @@ Required properties:
 - interrupts: touch controller interrupt
 - wakeup-gpios: the gpio pin to be used for waking up the controller
   and also used as irq pin
+- wakeup-source: boolean, touch screen can wake-up the system
 
 Example:
 
@@ -15,4 +16,5 @@ Example:
 		interrupt-parent = <&gpio1>;
 		interrupts = <9 2>;
 		wakeup-gpios = <&gpio1 9 0>;
+		wakeup-source;
 	};
-- 
2.7.4

