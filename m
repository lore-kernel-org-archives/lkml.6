Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C178ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B59A214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="boBsRcPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B59A214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeIQPSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:18:12 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:36864
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbeIQPSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw9jnt72gkKnlH2c8eRzV9kNWVLJ6cXSmgWIzc8MdW4=;
 b=boBsRcPdRR0qCC6//ol6HE6gCYFBj02G3BMllFiF7GvSz/D9SMBNQTUBvyX4yeuekIQyQkhrQFJkNog3s7mQRyYgCgPfCBiilLdJ3xPyClb/f09VBJ1oxzmMbS7OnWswlXsoos1Ur9Pjm568nMX/ovCMmCwPgstj6iJzj1ywdkA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.19; Mon, 17 Sep
 2018 09:50:49 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI driver
Date:   Mon, 17 Sep 2018 15:18:30 +0530
Message-Id: <1537177710-9379-6-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d3ea902-59c9-4226-c0b7-08d61c830fe9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1030;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;3:bcXK62aspFq58/xoMUo7UnNfwaT0fv7cSIVgUOOTQoemz+l6aSuQb6D7Op2xfl1FjKmpm4JrFk1AWAgNOhsPycNzUBfmIsrdA6FkqwvuHiXjkGt4GsjtWe67x6LVD5w7hbeL3d9hV/d+WuWh5uGOcsERG9mtRQuBSi9ur7rl2DaXjLhulR1xluF5Lq9p0HUOOv1bxeogl55BQkJsUi8m4wWFosDE8Ai2xVQF2P853vRA7kujCrVwP5kr5Nnun+9O;25:65yPEHVhNNOMV/LKo9n5rL4uzWIW37c+plnsGVRW0Zrki4VxePaHVcTENaeEUAuGeSt3xeQKi0C5AiTtDxVTg3aG140rxiITNW8daXxAsOPCj0S3vhR6WWijlwSi828uNNX1asL3KWqCUO870CYRXzTF+cGJ5IHRB3L24U/ecoZ5em8kUX5lhOLhHQ73dJ2oMYHZBkQnWQabKnvOJmlXKrvQyMSejPHnytLX7w+wXgQUujl2Se1LNfSn82jDSTDQqTbr/lSscgRN8QpSzhxmHY7c683VnCJRI2DVkaLjN4O+ApL27gBmJqQXiLXj8QZAa/41Q9iZbRxvxqVs093Iiw==;31:oJfWGQKGuh6Qs922BMa71TZNOEY3cYsfU/XwS86hPjN5qyrpy/plbd1Xm2UjKfKBxjhL+842OxGNfRmS3CASKYVezev9Aig6r1x9WI/yDEtlKToOSf5E6S9iIzOrWSAIV6liqNKk8RQ/a7CpwRON6Epk4O5gf3/y3IE6wDdq1qWIx2KJSiwc9s/zHLfHHDuEnZ0JPkqpThiwDaJvqsp4TC7vq/cTk9W1AK4sV1bJ5Vg=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1030:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;20:uRJsRIVuEl+SR+z+51HcmdMZVdcPGlAl+SSimmm6hBnOL1wjBRrZcs6bZgFrETjlDe7bmfsi8MjrgTULT8PCqegbE0vw3wS7cfJJvG0VyYX39J2cEWOQltyiB884pGSwa8CK903s9X+o7zcnEtIQmk1vZ0Pc9Jshvu7emXyLUYqTaBBTNEA3HCJkANNtI4Sy8MFgAKLch7B0Vdxw1nm87RCz8uhYnQ0mS+leagVwqehwkFRetOi/T8tRdBcvDuTzBMqExoVwSG5nTLnScCAuSN4l7XPZR4JJmnxNfsUOvhMRLqAT8mtijAyGHbH9+WmtWLzd2KkfiWsJTfCJO4b7KptPgON5yLjaQnOAX/mi92Y1bpp7QCk6W14JoVnmdDh7L0xpmQhSLGJ7Jqf9EZ56wUECo8iAYSTrUumVK9RbwgaHS/Bd1qy9d8s9LYqv07d97G13LQ+pWDPoPgS9FlOJmSZKwi5lFpbxvw0Y0Q1jM+8L73/IPhxP+Asfok5Tru6h;4:uBeSmrc5i1/AZFgWbbtAoDrff+7MZwYW9DM533hNDCmSFfpJv/NELrkcHVl4Um/Y3/2g3MVtnVvHudlPUA6DvWrdVGoEmJNcgrUXM6FMxmCdxItMeZ39juhUuSs1pKzJGwBL7VTUZnGkag7q8VHunWvtxQpo7JIBBxLUvD9Sbm9ryU6ztjMGK2TjRSsLys8Jpv8mBvIqedH8UrQBXGNX26q5DJC/wBBs66GI56J6x6W12v//xiR2UUj78JtY+O4dipJO4B1SIlPGKCwvNJPTzWfda0Dt03qGrd03MKJy3g8k98B/bxC5AdGCyQEXI4eG6G9xXxdZSJqQE+39wFEmUgN6ji5mrmtPMWurgc2mTCMFuf8IgeMR3eBi7F35JN6/
X-Microsoft-Antispam-PRVS: <DB5PR04MB1030CD43337C442FEBE65591991E0@DB5PR04MB1030.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197)(162533806227266);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:DB5PR04MB1030;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1030;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(7416002)(26005)(66066001)(386003)(47776003)(316002)(305945005)(6506007)(55236004)(6512007)(6666003)(86362001)(81156014)(186003)(68736007)(6486002)(50226002)(16526019)(105586002)(8936002)(16586007)(51416003)(478600001)(76176011)(52116002)(53936002)(97736004)(8676002)(81166006)(36756003)(5660300001)(7736002)(48376002)(3846002)(39060400002)(476003)(25786009)(4326008)(956004)(446003)(11346002)(2906002)(2616005)(486006)(6116002)(5009440100003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1030;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1030;23:VPM9/oucLT955bVew2BfqGqTOqF25RZS3dJhSGYVT?=
 =?us-ascii?Q?24opEuiE5+FcUnFqTCflKjSj62M5JUxNCNCEu96slNZVMXekMYwQLTkGsPoX?=
 =?us-ascii?Q?nB9EjZD33vNUx07r7jwcK5P4U+7Qq22BnFhPiAf3HIp02uODxIW/bcl2InPW?=
 =?us-ascii?Q?yhtnEjtas+evklNiki7/cKpJr9LNL/D6BSAhlH+5KiRc56kS/RaS8ns9VnVD?=
 =?us-ascii?Q?Yq8KYiIgYkH9qgSQEWm9vCfjRCUGZG+IlGpwv1F809nIs/Ug93PyZgrMAH3/?=
 =?us-ascii?Q?7WkheGr58u5A1JH4X7odUuy+RwmM+Duoi9/ofk7BPSd4xqCjNH3/ecAfIoKX?=
 =?us-ascii?Q?C3cpnX5vQtxf2oVl4MIcQFj1UqUoNE9OYOMWBYGiFDEUxcz/BQ11PjXUj4wT?=
 =?us-ascii?Q?R9QIjjDk8i+F7RNw9z2uRGVuBTNo3QTkYDB6aMnJsE1gb1Jc/Q+xhDbmFtFt?=
 =?us-ascii?Q?oO9u2YwYky/jh2jRrTdDKWHeUCdG6hei1L8922ApF7EVC7eUPHEkyLWEfZnz?=
 =?us-ascii?Q?OkTnMmuaPNdrk3Jz/BBfz43qP81q5PiQ/+WJdRcsCc6ihprAZJtXjrNGFtXc?=
 =?us-ascii?Q?ZJtqiQxxd5mXzDshfNTa+KsH80t8b6jNmfjW1HUITPoPO6BJ3N5hStuauzRr?=
 =?us-ascii?Q?BkXIMWX8HF3HKNKrvkWvFjvXB7LQ2mq+MX0OtLD6SgjBISZRMSskqW0qriOB?=
 =?us-ascii?Q?KfRMMTMvxtwa4i2AQtie6dCLiplIiQrUKZA/LXixqavyxNlk7Axi6JFU05ya?=
 =?us-ascii?Q?DOxiQ4E9OWNwXQuh09xq0JVfH8ihtLpBX+H2YoFTyh5I/f8uoMN+dWCwUSq6?=
 =?us-ascii?Q?/59vb8hOSUTCMmQWnXTLE/0KIiwVdbGIYyG3V2bDwQxnkjsU8QADMCbeBQUb?=
 =?us-ascii?Q?Eq3tUrY5Gy2Zmthm1FCBVMkENqD6nA1BjNioou/w/EB58p6pgooftEpUxm5O?=
 =?us-ascii?Q?ZoKjS9CULoFxdOii16b6iJcEy8tPo8tWgVrDITMuorEhsBIv4FV3vyHvJ9Ak?=
 =?us-ascii?Q?jDB3FtuNEWmExUvCW6pmeswmCvmXdm8Oa0vtC0C8Cb9YhXYHH5khISMnv/VC?=
 =?us-ascii?Q?eOTZw/dLheDx2KMHaOjBKReJRpFuA458NWgm5T4fIsQBzxGOb9YYqLWGmOzm?=
 =?us-ascii?Q?TYuBtPYS8dwuCr7GX/+fvNEKNKJ/s6MNQuJknxnYRPYZjJxRfMCrfHvlCatg?=
 =?us-ascii?Q?s5dEv5c+nXsLnf72BZ9EUWTx2YYlM2Nd6pnd06XqJAyzsIXVuIIInm/cs3zF?=
 =?us-ascii?Q?X29lbWlMQGTAUM3LlWlEKaYFQwdo3qcp51Q18Ij?=
X-Microsoft-Antispam-Message-Info: kYRS9dYUrsVdjA1H8tz5lYRgsMjXJ26XFkLQZbMv2xiqCrL/9mwFf8uHUsUvfysbrdAe9VaG/9ROVaZwjI9NlLgUFKKS02eOzGIgpDtLzf9MGxvQlK5y9IitlIPBBsIb3o6ZhZwKzME047V3nOiMkxYA5s5Y/Pst8DKRFX54O9OLm3C+mJojsVidljdoCbCILIWNV9gAPkfvxui6oD4jqkkv8gl4pCXttQ06g8zuYeecyZeDhdoDiLZpCv2tDnYIhK1jfChvBI7Mj2XYRu4v6F45XYNs0gDa4DR7d6/C6u/mic9GQg2hVho5UXMlFclgWqFkUr9HwuRXmaTe+rNQD02vBeT4R66O/i8YV6ZZMMg=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;6:6nlaMgQjw/ViQ/RyOeZ58LwP1OeybYyTBka6TPrD/bO+covTHv6EyRfF1n+vIsOQwpnVx26WEA3AVyQveAcxLyiPjuhxzIlaRtppV+5WNujp62C016PfJJUIbNyAbxBkEnUcFGpq1jnzmFS8Pt8mX3nxupm7hdnQzrHJVMkcsQkF26Pqfoh2fExCsouIA064jYSjbEnXBMyC05bwyljnVdKCv9nXNhgFUUcAd3NHNpgbfhmNaveASUifrrUQhLgJ6xmNW9fVnpn2x9awZZKIbD1xjErt2BJ/FMMu2/SBT9jA11l7zFsnk+zivGD8+tf/dUUR2kAIEsi3eRhoBfRNoZEbeKUUsNBok9LIzK99AqImHMpRvuoQdbG2jmm/wrakVTls0s9iP1Je/bwmOLMfXmT5zYtoAuBA+I5PiSy5R6KmPV5kItJzCqyYqRifSru5ANDzuGUtQSkEPqubLvj14A==;5:ctA0r3BLHeRmxSA11S8qb8aOcXX74oIiQdqTr7GmwKUGXw8ybfbzWkeFyW/cyoSIvhXNNWSnT4gcrzwYl89Ps/fFlME8h0TtmbZCrtLV0kLZkIRnETcmiscXK2cr0sSO2s4EhV97r+gU+PpSOoxuH7dob1xhD+FerapKOQSBriA=;7:3KxETdMQrwTIBW+0gN71iiZb64l03FaQIStRqKP+Bg82EZSatUxB2zgYI/KzarlgyCi32N74usYt0rviLFJZingeKLHb4LeAr86JblrhDbXArfIUvDCjAwnDMwqSFEpG9C6PsBN7WKRZlHOZtgkDtigRSPLTfkQ/WAm9mH3hOpFbm5/WQX4xs1HDq1j0PSBjvNs5MRdZMj6fUKXSkjjYKTHaxvEZVhYw75lsa/4lKKXYuWhhc9I8XETUnjLa/lI+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 09:50:49.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3ea902-59c9-4226-c0b7-08d61c830fe9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
- None.

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..2696898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10228,6 +10228,12 @@ L:	linux-nfc@lists.01.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/nfc/nxp-nci
 
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.7.4

