Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E54C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B46A20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hMcz0+lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B46A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbeGLF4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:08 -0400
Received: from mail-sn1nam02on0083.outbound.protection.outlook.com ([104.47.36.83]:56000
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727478AbeGLF4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/CIpvnfiddbBkxQeIGNnBuQGcV9ZdAuz7mjF+br/v4=;
 b=hMcz0+lS3Q2Qrv0xfGBFFxJfBVnHlbwlDC0sK8IR1t0b0VHAQ96WsGZStkqOIfDsnaPn3FljFnBazzVXsM5OrMY//VbefYtxhgwFgSmWVQESIj/z4LkmY7gOLAjj3r83o0BiGALl8ByzgETOV2kLBq4rk9gT4/HmS/TIj5HzguU=
Received: from DM5PR07CA0116.namprd07.prod.outlook.com (2603:10b6:4:ae::45) by
 BL2PR07MB2292.namprd07.prod.outlook.com (2a01:111:e400:c752::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 05:48:01 +0000
Received: from DM3NAM05FT030.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by DM5PR07CA0116.outlook.office365.com
 (2603:10b6:4:ae::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:01 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT030.mail.protection.outlook.com (10.152.98.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkwB032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:07 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:07 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lpjm029787;
        Thu, 12 Jul 2018 06:47:51 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lplV029786;
        Thu, 12 Jul 2018 06:47:51 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 20/31] usb: usbssp: added queuing procedure for control transfer.
Date:   Thu, 12 Jul 2018 06:47:17 +0100
Message-ID: <1531374448-26532-21-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(36092001)(199004)(189003)(8676002)(7636002)(336012)(47776003)(26826003)(126002)(305945005)(87636003)(76176011)(316002)(36756003)(51416003)(6666003)(86362001)(1671002)(356003)(107886003)(109986005)(575784001)(14444005)(5660300001)(54906003)(2616005)(106466001)(186003)(48376002)(478600001)(105596002)(476003)(11346002)(16586007)(50466002)(2906002)(8936002)(26005)(486006)(42186006)(4326008)(50226002)(426003)(4720700003)(446003)(246002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2292;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT030;1:Vz1own+5XbRBsMMKzAsx2vzKExeZ+MoyhhW0oPRveopYdOY6eYqJrBiB77DO7LJG4LSVH5uKyvW0vdAO3eLfjT6gTZGfcAB7aY56Te14evxe39z3GL+T58O6yJKQlN3g
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d34716-48ad-453e-f61f-08d5e7bb0767
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL2PR07MB2292;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2292;3:9nlcQBfk/F7SK7Qgd0YA6Uq/NS4kzbyYW7oBIAuEomf2fM86CbMJKfQGMGxXGsbf5dfBkEi7TmM2LZsrZkWtb2YYjeEilESs6iuiMwJYa+V8+7ES/T7nEBV0hjYsnoRC72UM+d66ZaBbK+cgN2ppnCT6wafBIu4259eehsqe3oWaD0NfX3cP6yqPIm8J4tKpXIQX9+/6hTx4gjyCD8Z1evmp7OZL2tEc3YwvwORqHCnMUdmL6hjqQuKhNaUva25demftIsk2YQrc83QOIpaQLVKzLIh8hLOyiJYmSZWgl2bJvmX7PLAN7ZCiUsVUqxpTccR49qiDkb/wIiSWYJ6t+DhqCMIn4Vs7fIrSIVe767c=;25:osK8ulirvk9y1cuOHluZ/g3RZn/qwlddLc7WihTDe5o5xD9S2JAJgCbdUERcq9VWiqDooXVceiYr9D5VGEAESQcTrnI0kwwo7Qxnk8yTPGPGSyTAViAkvGLSChNGTa072Gcg7zCFmPAzDX8OmolYsc0J+hLlGyrnGjQl6+YjyP6Kc57El/IUSNSPyG2xv79cm+ejxdc5nuU3l4GSk1z38G5TiySHx9DPS9a0NQ3GHxmlcoRm6IYNDRpcfJk+B/wdFKrUZvixfUoIhr6M45BLg9ppUQlIyTDBnz3lpCCFkZp+X7ThP8x5PCGvreMijekxjRhxd2COGtjJwR9MzYBojw==
X-MS-TrafficTypeDiagnostic: BL2PR07MB2292:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2292;31:aD463HZP9RfmxoChXUGcpAmby10qgsNzYONXGokqdfEm+o2yEMHtfqEqlAn40Ll37u6R3nsFBrWP2D+ouqsKGp3WX4OFl6yz2IrW1GoRdvcMXWcZxCby6tJ2VqdxTxqzO3uhHpxTrNdAzEq1sw4PR8titj5EIpeuvJjmGJTfT3Q2L8Iy/ujM2YloxkOPN7djABLcyTy8mPv9Fh2FW+igdKQjQPy7DOuBZESJgegf7+w=;20:alkUBRJDOLh/jRDngKX59wsBqPKXF/HisxKQBDmB5i69NlfxV4Vke+eo1190fZDGnuEzGo+WY5jNd8TDoPjVFC/DFRc8XEJJ2exeRLDpoVOpa8g5Hj5pIu8jelaP25f36egBOD9+ChC7EeXqHEtmLW3BvU4zUSTOtVBJ9TTeADpjzFf4+FWwRWOR0sn8QPcZCOMkSDOJTk3eCsdvFJGqpAco78XVBMoUBejt6x+U7AZTELm50sRNJx2b/F9H1/7sycx/1qzwHMVNfAtc0YaxHJ3/rHqHJKwUj9jqi3J4dQnENa2YVeNUpyEBW8XjcHjy6W78IGgYEfUDCe0MXlwL/jnSQkfm2kvhUmOcVDn08otZ6pBRcceHeAUNuo/Fb0uLLp0sYB43YVzwz1g37fGTwY5UzBtpdcP0F0PaoMeAyceryWIrE/H5h0jCqFliknB4QwmxZFmG0QOdHT7HmMAvymApcRDYsZYP4J5xuTyoCCbQ2yCcxQ+ECk30JLpfv8dh
X-Microsoft-Antispam-PRVS: <BL2PR07MB2292EC51A69D1D4501267F3BDD590@BL2PR07MB2292.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL2PR07MB2292;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2292;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2292;4:S2nWI9RWkGjBxZ60OP92J+G3WgEI8AtPyluYNgulE0lkLooVqfi30x7Sjf1nT2F4vMLfpolH1kFSDGIsu5zQpGYmX5NAh79akCog11WAnDJ4m5YCFkLjt/h73Yjdjkgha4fhOlROhf9TXMwT/KW4U8MAYYE7OJqHYM1a0QDb6ojly6rtoCfs2eSnY3GAKYUfPdgy5sliR2nvKwkOeegL7j/oSNLm97f7yj15HNaTRiLJ9PrTF+BudpQONszvQY5P6d3CUyvPNMr7oPOBXxFrlj1V6zkAFtQ/gRDXfAG4uxhHPFoySSXf2glTeXxo2Y4P
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR07MB2292;23:GV82wu2L0Bkk03sYwLJT7Rv1Ec3NFuby4I0W0HFEk?=
 =?us-ascii?Q?omk2nlITRPQvTiIIhNmcQ/wvYFcWaRdZF9u8ZrqhOX/8HFRtrFrYqRC1+N1d?=
 =?us-ascii?Q?kJ5I6lDTUDnJQXcVLWgvFWmCjzhm7ztcTmK71hV4AAx3EuFhkdixxjVI6xRt?=
 =?us-ascii?Q?sG8p8PQkUtObIx3naUgjAO0+z8avKfTFyeo/czEXdCTAADipTy0Z7V0vhiTC?=
 =?us-ascii?Q?2IAfyvESvovKPxsSPEFg5REu2xr1+bU6vqMJ/PiNSHb1N6RUK76/IWOLdxue?=
 =?us-ascii?Q?yWueBLmoLyUlb0EGwyHcQ/rMRU2Niz2Sbua5HG4IMp9VOk8gTP5qaPUSbMG9?=
 =?us-ascii?Q?DoE+Ohe274RXVaH+sHUXVCGxcP75iUFiqf65BFGdcZYwRacNeQH6B3cqlsg0?=
 =?us-ascii?Q?8wpd6rJNpvfRe74OpjsepIHOMCBSAmAyyrA1FXqt5clsfyPP4+QAC1ygON3O?=
 =?us-ascii?Q?mGf3X7VcYLBbDR2lZI20YtwYwCn5PbuEBCbC8ZxYclCd/JscOv1UsZqMTL6b?=
 =?us-ascii?Q?RX5vob++oECjUnCxKzcYCqSDOEYVXkwWKQupUSm7XtjONtV+UbqxfHOm8zHZ?=
 =?us-ascii?Q?4An9qISCQYXyetdKQSwXR7ZX2SWFo5qSpbyS+SKP9DgDbzzhrL4Fx2o8pBiV?=
 =?us-ascii?Q?y6bxfl4GKLWTy9/SatZTOR7cyLIicJGEXw1+oWYf8ryS4jKJnrSjGb2x2bjj?=
 =?us-ascii?Q?v4cKKf90+RGNkja/1fuJJxyLe1G3wZFD2+GtLr6wcLiySK7G6eDrAdD71twi?=
 =?us-ascii?Q?v9z454zgyYS8e2SMlEzPjDdEd1WHxOjMBCLNZxlDtkunXY4m/jkC6u/pyjQW?=
 =?us-ascii?Q?jb+F9H/8Ja/X1weChu3SQtQqyzlNd7fm3HO5d5XU0se1iLC/WJBADy1PTgBZ?=
 =?us-ascii?Q?kE9We99GKZVKQBKk/YNaiBVZxBLY76lAxtlnQZA9eB78eV7gSQrfMXZxDUfq?=
 =?us-ascii?Q?xSydhnlBPDFdAHrrAsYROBCsmMLrCRosmxW6TU0f42xi3k1WJMbZvihO6ZXw?=
 =?us-ascii?Q?HdIb4YmaDn1SaanBEK9aa2HU3DFw1aJDj40wTdtZpryNKZv5b/QVFphaSYYu?=
 =?us-ascii?Q?EHS21WuPeamaZ/6XVhb/R1UkKhM91177nLQoU3lkxpPyIF6Mt2cjnKkk7mvC?=
 =?us-ascii?Q?jKHAG5Dvwpvw1loX7gIArA/bMXtkBRW19ScOZz5wBO8XmYAFzobs8zBpBVxJ?=
 =?us-ascii?Q?RuLFdLHWQbgYtM=3D?=
X-Microsoft-Antispam-Message-Info: HO8rPHJ8pv633yrOpQHgUgqn/sb8Pw1lK+Q/oNCZiQlU5L355MOKsl3IcGsGvFtdG4gQmV8L/5zpljk0DRKeNRIZ4DYHxPyzSR5c4Abq8giK3vGtYcAbB823G7ZA2q34WFb/kWqDCtKFnr1vZtP+7DySy7BMPDMZZ42iLfFr3iBHduddxlHD37cx3EXnoNl9kzgCmT7a35PYCZzDfDQUAo55BXjRhXXv6cdHutu2qD7ebaOYynCzAJ1VE11PUl55UtWc+ygM9oGxuBdXFaPJMPkUexXkA7Y5LQKcLmN4bujOKZsfwjCiAK41FfFQr3DAGT6tXNLv+Yqjwb5mLi+QmFWfVqC+YC0ixWoNzUq3mhCM+d3kGpHMHkP1x15zjjx5QhO7usfrTtEsBMBDWXCpug==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2292;6:6F5o/mSUB3TjAdGGuAHXIPPYwYLPVwVQFVzYicy8Xg21r+PeiX1N+HTo3DZ/48q1bAyZYyf9vza44rKafvZINThhN72iu8UrhwZYvVYHNmfF7lc+MeaZYKRAi1Ioy5fGj3cwnUgPbOIBKwnWSu7cqCz7JzOIenMckmjtbOFeyNYjcII++nReM/TNrY9nGXvNUR2Riidq1c/fVhAd55eejlZWWTCmBPiQM91X6iifEVYO6M4JzSoNiI241KN2oJFZlC3Ip0pbFpnrsU050nNBloNUS3ULCsg1GZx/svqLkgK3HSp8Qek6e0s0H+1igmoJ/jzE1rfF8b5oCD5Vx9hip2aIKpT7R7ZT22eY7/d3VhshDhcnbss/MKAs2/6KDMloZiAnHxM9t5s8cz7uA3VW34xmG8zrBctzuJyztk2KO0ie97Mv8r2KIP6+JzddN93JT1swN4lhgG8RPHeSqg2zPg==;5:8sEnQ5WIZ+JF2Qs2+ADRvCweWAX59BzOKufIxfKXbEWYH8WH2NwIeYssagJ9x8qbSUjZxp7B2bkIS7QCz3qguZUmMmupTiaMdrhySvVvTpGKlDMruOIAMeK2j4+I4V581/9IRPCJr6m7ufb7k2Ye3o74PFhzvBW089uK7JNZ8ZU=;24:GsuTydT1G05+7n2FZ5yQAJWOiPA/r+YHxoyRFt+Jy3RBIn2XoGi16QAbkqRQU1W6vwJcPEhjVa1CGtXd+oz574+MoFu9lIVLPNF2hBwVB9Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2292;7:mS+VVO+3AnScmkDLBcPo3M2qbA7Y3t2gTQA6nTeA+E2ieiH6q1jrKxQBBlOm2kMwGlpkT+b1GRJxOlSX0VVaUmBcgjJ6ZfwIXF1u6Hn4ibymYkxV4Be3I5UNVdVCjcu96TgZP0g/9TvY25aVm4ALSkluuss5HBKhqOjonB6XCvFiBBPWWFa61In8oU1dNuDfGrJqiZ/LJY0XIJZPPqMjqyvAGZ45IvfVIMHTqJb8FAFBhrjl0RCT736+6ARHZynW;20:ZmN0ecSzI2PjFkCgl+UnxrgWile78UUe9z1XxmYrIL/Nl1ErPWDjeKXdyTl2/zOCX+davs8aLTaXM2VO1hOWpuF+q3XsUwSaOudySk2Fbu96WfF/9z6fXk/h1Tt505KI4kbAkVYbm2ZsFR8h5F/d5b7JHa/us7E5giEZSe13b1bhGtcA1gqRnsecSLVdw8/OSBVOu4ooGnxinFjLDOxTEOcQp30GW/UgeXGXCqsk7r0ZlRE5mvNOELPGD9epaUi0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:00.9291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d34716-48ad-453e-f61f-08d5e7bb0767
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2292
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements generic use in driver usbssp_enqueue function.
All requests queuing in driver must be send with it help.

It also adds specific for control transfer usbssp_queue_ctrl_tx function
that prepares TRB, adds them to EP0 transfer ring and set doorbell.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 271 +++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c      | 115 ++++++++++++-
 drivers/usb/usbssp/gadget.h      |  22 +++
 3 files changed, 406 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 84bd462a1f23..1b763faca7bd 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -306,6 +306,44 @@ static void ring_doorbell_for_active_rings(struct usbssp_udc *usbssp_data,
 	}
 }
 
+/* Get the right ring for the given ep_index and stream_id.
+ * If the endpoint supports streams, boundary check the USB request's stream ID.
+ * If the endpoint doesn't support streams, return the singular endpoint ring.
+ */
+struct usbssp_ring *usbssp_triad_to_transfer_ring(
+						struct usbssp_udc *usbssp_data,
+						unsigned int ep_index,
+						unsigned int stream_id)
+{
+	struct usbssp_ep *ep;
+
+	ep = &usbssp_data->devs.eps[ep_index];
+
+	/* Common case: no streams */
+	if (!(ep->ep_state & EP_HAS_STREAMS))
+		return ep->ring;
+
+	if (stream_id == 0) {
+		usbssp_warn(usbssp_data,
+				"WARN: ep index %u has streams, "
+				"but USB Request has no stream ID.\n",
+				 ep_index);
+		return NULL;
+	}
+
+	if (stream_id < ep->stream_info->num_streams)
+		return ep->stream_info->stream_rings[stream_id];
+
+	usbssp_warn(usbssp_data,
+			"WARN: ep index %u has "
+			"stream IDs 1 to %u allocated, "
+			"but stream ID %u is requested.\n",
+			ep_index,
+			ep->stream_info->num_streams - 1,
+			stream_id);
+	return NULL;
+}
+
 /* Must be called with usbssp_data->lock held in interrupt context
  * or usbssp_data->irq_thread_lock from thread conext (defered interrupt)
  */
@@ -1496,6 +1534,230 @@ static int prepare_ring(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+static int prepare_transfer(struct usbssp_udc *usbssp_data,
+		struct usbssp_device *dev_priv,
+		unsigned int ep_index,
+		unsigned int stream_id,
+		unsigned int num_trbs,
+		struct usbssp_request *req_priv,
+		unsigned int td_index,
+		gfp_t mem_flags)
+{
+	int ret;
+	struct usbssp_td	*td;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_ep_ctx *ep_ctx = usbssp_get_ep_ctx(usbssp_data,
+					dev_priv->out_ctx, ep_index);
+
+	ep_ring = usbssp_stream_id_to_ring(dev_priv, ep_index, stream_id);
+
+	if (!ep_ring) {
+		usbssp_dbg(usbssp_data,
+				"Can't prepare ring for bad stream ID %u\n",
+				stream_id);
+		return -EINVAL;
+	}
+
+	ret = prepare_ring(usbssp_data, ep_ring, GET_EP_CTX_STATE(ep_ctx),
+			num_trbs, mem_flags);
+
+	if (ret)
+		return ret;
+
+	td = &req_priv->td[td_index];
+	INIT_LIST_HEAD(&td->td_list);
+
+	td->priv_request = req_priv;
+	/* Add this TD to the tail of the endpoint ring's TD list */
+	list_add_tail(&td->td_list, &ep_ring->td_list);
+	td->start_seg = ep_ring->enq_seg;
+	td->first_trb = ep_ring->enqueue;
+
+	return 0;
+}
+
+/*
+ * USBSSP uses normal TRBs for both bulk and interrupt.  When the interrupt
+ * endpoint is to be serviced, the DC will consume (at most) one TD.  A TD
+ * (comprised of sg list entries) can take several service intervals to
+ * transmit.
+ */
+int usbssp_queue_intr_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+		struct usbssp_request *req_priv, unsigned int ep_index)
+{
+	struct usbssp_ep_ctx *ep_ctx;
+
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, usbssp_data->devs.out_ctx,
+			ep_index);
+
+	return usbssp_queue_bulk_tx(usbssp_data, mem_flags, req_priv, ep_index);
+}
+
+/*
+ * For USBSSP controllers, TD size is the number of max packet sized
+ * packets remaining in the TD (*not* including this TRB).
+ *
+ * Total TD packet count = total_packet_count =
+ *     DIV_ROUND_UP(TD size in bytes / wMaxPacketSize)
+ *
+ * Packets transferred up to and including this TRB = packets_transferred =
+ *     rounddown(total bytes transferred including this TRB / wMaxPacketSize)
+ *
+ * TD size = total_packet_count - packets_transferred
+ *
+ * For USBSSP it must fit in bits 21:17, so it can't be bigger than 31.
+ * This is taken care of in the TRB_TD_SIZE() macro
+ *
+ * The last TRB in a TD must have the TD size set to zero.
+ */
+static u32 usbssp_td_remainder(struct usbssp_udc *usbssp_data,
+			       int transferred,
+			       int trb_buff_len,
+			       unsigned int td_total_len,
+			       struct usbssp_request *req_priv,
+			       bool more_trbs_coming)
+{
+	u32 maxp, total_packet_count;
+
+	/* One TRB with a zero-length data packet. */
+	if (!more_trbs_coming || (transferred == 0 && trb_buff_len == 0) ||
+	    trb_buff_len == td_total_len)
+		return 0;
+
+	maxp = usb_endpoint_maxp(req_priv->dep->endpoint.desc);
+	total_packet_count = DIV_ROUND_UP(td_total_len, maxp);
+
+	/* Queuing functions don't count the current TRB into transferred */
+	return (total_packet_count - ((transferred + trb_buff_len) / maxp));
+}
+
+int usbssp_queue_bulk_tx(struct usbssp_udc *usbssp_data,
+			 gfp_t mem_flags,
+			 struct usbssp_request *req_priv,
+			 unsigned int ep_index)
+{
+	/*TODO: function musb be implemented*/
+	return 0;
+}
+
+int usbssp_queue_ctrl_tx(struct usbssp_udc *usbssp_data,
+			 gfp_t mem_flags,
+			 struct usbssp_request *req_priv,
+			 unsigned int ep_index)
+{
+	struct usbssp_ring *ep_ring;
+	int num_trbs;
+	int ret;
+	struct usbssp_generic_trb *start_trb;
+	int start_cycle;
+	u32 field, length_field, remainder;
+	struct usbssp_td *td;
+	struct usbssp_ep *dep = req_priv->dep;
+
+	ep_ring = usbssp_request_to_transfer_ring(usbssp_data, req_priv);
+	if (!ep_ring)
+		return -EINVAL;
+
+	if (usbssp_data->delayed_status) {
+		usbssp_dbg(usbssp_data, "Queue CTRL: delayed finished\n");
+		usbssp_data->delayed_status = false;
+		usb_gadget_set_state(&usbssp_data->gadget,
+				USB_STATE_CONFIGURED);
+	}
+
+	/* 1 TRB for data, 1 for status */
+	if (usbssp_data->three_stage_setup)
+		num_trbs = 2;
+	else
+		num_trbs = 1;
+
+	ret = prepare_transfer(usbssp_data, &usbssp_data->devs,
+			req_priv->epnum, req_priv->request.stream_id,
+			num_trbs, req_priv, 0, mem_flags);
+
+	if (ret < 0)
+		return ret;
+
+	td = &req_priv->td[0];
+	/*
+	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
+	 * until we've finished creating all the other TRBs.  The ring's cycle
+	 * state may change as we enqueue the other TRBs, so save it too.
+	 */
+	start_trb = &ep_ring->enqueue->generic;
+	start_cycle = ep_ring->cycle_state;
+
+	/* If there's data, queue data TRBs */
+	/* Only set interrupt on short packet for OUT endpoints */
+
+	if (usbssp_data->ep0_expect_in)
+		field = TRB_TYPE(TRB_DATA) | TRB_IOC;
+	else
+		field = TRB_ISP | TRB_TYPE(TRB_DATA) | TRB_IOC;
+
+	if (req_priv->request.length > 0) {
+		remainder = usbssp_td_remainder(usbssp_data, 0,
+				req_priv->request.length,
+				req_priv->request.length, req_priv, 1);
+
+		length_field = TRB_LEN(req_priv->request.length) |
+			TRB_TD_SIZE(remainder) |
+			TRB_INTR_TARGET(0);
+
+		if (usbssp_data->ep0_expect_in)
+			field |= TRB_DIR_IN;
+
+		queue_trb(usbssp_data, ep_ring, true,
+				lower_32_bits(req_priv->request.dma),
+				upper_32_bits(req_priv->request.dma),
+				length_field,
+				field | ep_ring->cycle_state |
+				TRB_SETUPID(usbssp_data->setupId) |
+				usbssp_data->setup_speed);
+		usbssp_data->ep0state = USBSSP_EP0_DATA_PHASE;
+	}
+
+	/* Save the DMA address of the last TRB in the TD */
+	td->last_trb = ep_ring->enqueue;
+
+	/* Queue status TRB*/
+	/* If the device sent data, the status stage is an OUT transfer */
+
+	if (req_priv->request.length > 0 && usbssp_data->ep0_expect_in)
+		field = TRB_DIR_IN;
+	else
+		field = 0;
+
+	if (req_priv->request.length == 0)
+		field  |= ep_ring->cycle_state;
+	else
+		field |= (ep_ring->cycle_state ^ 1);
+
+	if (dep->ep_state & EP0_HALTED_STATUS) {
+		/* If endpoint should be halted in Status Stage then
+		 * driver shall set TRB_SETUPSTAT_STALL bit
+		 */
+		usbssp_dbg(usbssp_data,
+				"Status Stage phase prepared with STALL bit\n");
+		dep->ep_state &= ~EP0_HALTED_STATUS;
+		field |= TRB_SETUPSTAT(TRB_SETUPSTAT_STALL);
+	} else {
+		field |= TRB_SETUPSTAT(TRB_SETUPSTAT_ACK);
+	}
+
+	queue_trb(usbssp_data, ep_ring, false,
+			0,
+			0,
+			TRB_INTR_TARGET(0),
+			/* Event on completion */
+			field | TRB_IOC |  TRB_SETUPID(usbssp_data->setupId) |
+			TRB_TYPE(TRB_STATUS) | usbssp_data->setup_speed);
+
+	usbssp_ring_ep_doorbell(usbssp_data,  ep_index,
+			req_priv->request.stream_id);
+	return 0;
+}
+
 /* Stop endpoint after disconnecting device.*/
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		       struct usbssp_ep *ep_priv)
@@ -1557,6 +1819,15 @@ int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 	return ret;
 }
 
+int usbssp_queue_isoc_tx_prepare(struct usbssp_udc *usbssp_data,
+				 gfp_t mem_flags,
+				 struct usbssp_request *req_priv,
+				 unsigned int ep_index)
+{
+	/*TODO: function must be implemented*/
+	return 0;
+}
+
 /****		Command Ring Operations		****/
 /* Generic function for queueing a command TRB on the command ring.
  * Check to make sure there's room on the command ring for one command TRB.
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index f14b357a1094..2b16158c8bd8 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -409,8 +409,119 @@ static int usbssp_check_args(struct usbssp_udc *usbssp_data,
 
 int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv)
 {
-	/*TODO: this function must be implemented*/
-	return 0;
+	int ret = 0;
+	unsigned int ep_index;
+	unsigned int ep_state;
+	const struct usb_endpoint_descriptor *desc;
+	struct usbssp_udc *usbssp_data = dep->usbssp_data;
+	int num_tds;
+
+	if (usbssp_check_args(usbssp_data, dep, true, true, __func__) <= 0)
+		return -EINVAL;
+
+	if (!dep->endpoint.desc) {
+		usbssp_err(usbssp_data, "%s: can't queue to disabled endpoint\n",
+			dep->name);
+		return -ESHUTDOWN;
+	}
+
+	if (WARN(req_priv->dep != dep, "request %p belongs to '%s'\n",
+	    &req_priv->request, req_priv->dep->name)) {
+		usbssp_err(usbssp_data, "%s: reequest %p belongs to '%s'\n",
+			dep->name, &req_priv->request, req_priv->dep->name);
+		return -EINVAL;
+	}
+
+	if (!list_empty(&dep->pending_list) && req_priv->epnum == 0) {
+		usbssp_warn(usbssp_data,
+			"Ep0 has incomplete previous transfer'\n");
+		return -EBUSY;
+	}
+
+	//pm_runtime_get(usbssp_data->dev);
+	req_priv->request.actual = 0;
+	req_priv->request.status = -EINPROGRESS;
+	req_priv->direction = dep->direction;
+	req_priv->epnum = dep->number;
+
+	desc = req_priv->dep->endpoint.desc;
+	ep_index = usbssp_get_endpoint_index(desc);
+	ep_state = usbssp_data->devs.eps[ep_index].ep_state;
+	req_priv->sg = req_priv->request.sg;
+
+	req_priv->num_pending_sgs = req_priv->request.num_mapped_sgs;
+	usbssp_info(usbssp_data, "SG list addr: %p with %d elements.\n",
+			req_priv->sg, req_priv->num_pending_sgs);
+
+	list_add_tail(&req_priv->list, &dep->pending_list);
+
+	if (req_priv->num_pending_sgs > 0)
+		num_tds = req_priv->num_pending_sgs;
+	else
+		num_tds = 1;
+
+	if (req_priv->request.zero && req_priv->request.length &&
+	   (req_priv->request.length & (dep->endpoint.maxpacket == 0))) {
+		num_tds++;
+	}
+
+	ret = usb_gadget_map_request_by_dev(usbssp_data->dev,
+				&req_priv->request,
+				dep->direction);
+
+	if (ret) {
+		usbssp_err(usbssp_data, "Can't map request to DMA\n");
+		goto req_del;
+	}
+
+	/*allocating memory for transfer descriptors*/
+	req_priv->td = kzalloc(num_tds * sizeof(struct usbssp_td), GFP_ATOMIC);
+
+	if (!req_priv->td) {
+		ret = -ENOMEM;
+		goto free_priv;
+	}
+
+	if (ep_state & (EP_GETTING_STREAMS | EP_GETTING_NO_STREAMS)) {
+		usbssp_warn(usbssp_data, "WARN: Can't enqueue USB Request, "
+				"ep in streams transition state %x\n",
+				ep_state);
+		ret = -EINVAL;
+		goto free_priv;
+	}
+
+	req_priv->num_tds = num_tds;
+	req_priv->num_tds_done = 0;
+	trace_usbssp_request_enqueue(&req_priv->request);
+
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		ret = usbssp_queue_ctrl_tx(usbssp_data, GFP_ATOMIC, req_priv,
+				ep_index);
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		ret = usbssp_queue_bulk_tx(usbssp_data, GFP_ATOMIC, req_priv,
+				ep_index);
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		ret = usbssp_queue_intr_tx(usbssp_data, GFP_ATOMIC, req_priv,
+				ep_index);
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		ret = usbssp_queue_isoc_tx_prepare(usbssp_data, GFP_ATOMIC,
+				req_priv, ep_index);
+	}
+
+	if (ret < 0) {
+free_priv:
+		usb_gadget_unmap_request_by_dev(usbssp_data->dev,
+				&req_priv->request, dep->direction);
+		usbssp_request_free_priv(req_priv);
+
+req_del:
+		list_del(&req_priv->list);
+	}
+	return ret;
 }
 
 /*
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 1f0d1af33dfa..0870635ef728 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1743,6 +1743,16 @@ int usbssp_queue_address_device(struct usbssp_udc *usbssp_data,
 int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd,
 		unsigned int ep_index, int suspend);
+int usbssp_queue_ctrl_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+		 struct usbssp_request *req_priv, unsigned int ep_index);
+
+int usbssp_queue_bulk_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+		struct usbssp_request *req_priv, unsigned int ep_index);
+int usbssp_queue_intr_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+		struct usbssp_request *req_priv, unsigned int ep_index);
+int usbssp_queue_isoc_tx_prepare(
+		struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+		struct usbssp_request *req_priv, unsigned int ep_index);
 int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd,
 		unsigned int ep_index, enum usbssp_ep_reset_type reset_type);
@@ -1773,6 +1783,8 @@ struct usbssp_slot_ctx *usbssp_get_slot_ctx(struct usbssp_udc *usbssp_data,
 		struct usbssp_container_ctx *ctx);
 struct usbssp_ep_ctx *usbssp_get_ep_ctx(struct usbssp_udc *usbssp_data,
 		struct usbssp_container_ctx *ctx, unsigned int ep_index);
+struct usbssp_ring *usbssp_triad_to_transfer_ring(struct usbssp_udc
+		*usbssp_data, unsigned int ep_index, unsigned int stream_id);
 /* USBSSP gadget interface*/
 void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data);
 void usbssp_resume_gadget(struct usbssp_udc *usbssp_data);
@@ -1796,6 +1808,16 @@ int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 int usbssp_reset_device(struct usbssp_udc *usbssp_data);
+
+static inline struct usbssp_ring *usbssp_request_to_transfer_ring(
+		struct usbssp_udc *usbssp_data, struct usbssp_request *req_priv)
+{
+	return usbssp_triad_to_transfer_ring(usbssp_data,
+			usbssp_get_endpoint_index(req_priv->dep->endpoint.desc),
+			req_priv->request.stream_id);
+}
+
+
 static inline char *usbssp_slot_state_string(u32 state)
 {
 	switch (state) {
-- 
2.17.1

