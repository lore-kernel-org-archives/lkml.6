Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C961FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B7D2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PJ/dGsNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B7D2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeGYNDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:12 -0400
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:19904
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728897AbeGYNDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQrwVGz/AepZlNdSAI1uzcWSU9rJmtUHLICsfAKt9bc=;
 b=PJ/dGsNG5qdrqeaCwrS2wV60X1t8IRQxTQgqd+0uE4gsuPirHLzsnQ3bEwuPFeKLUt7WwIJ+EhpUwGM7catq5IQc3GcZvfd2pUJgcqk33JBRrHthKk54uVlJYGdVkkuyGhJTR9GMGjv0Nn1h3iKlj0ah48Y325HTg8u326QNg/o=
Received: from MWHPR02CA0035.namprd02.prod.outlook.com (2603:10b6:301:60::24)
 by CO1PR02MB093.namprd02.prod.outlook.com (2a01:111:e400:101a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.16; Wed, 25
 Jul 2018 11:51:48 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR02CA0035.outlook.office365.com
 (2603:10b6:301:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43600 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKW-0004Q1-Hu; Wed, 25 Jul 2018 04:51:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKR-0006Z7-EA; Wed, 25 Jul 2018 04:51:39 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpb5X027046;
        Wed, 25 Jul 2018 04:51:37 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKP-0006Yl-4w; Wed, 25 Jul 2018 04:51:37 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 49FE060505; Wed, 25 Jul 2018 17:21:36 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 2/8] usb: dwc3: update stream id in depcmd
Date:   Wed, 25 Jul 2018 17:21:25 +0530
Message-ID: <1532519491-19502-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(6666003)(126002)(106466001)(5660300001)(446003)(51416003)(14444005)(15650500001)(11346002)(356003)(36386004)(50226002)(426003)(107886003)(110136005)(39060400002)(2906002)(103686004)(106002)(90966002)(63266004)(16586007)(52956003)(76176011)(4326008)(54906003)(42186006)(316002)(6266002)(48376002)(26005)(186003)(305945005)(47776003)(478600001)(336012)(8676002)(486006)(50466002)(8936002)(476003)(2616005)(81156014)(36756003)(81166006)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB093;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT046;1:91rBV1TRXs2ko71btvTXP/lS7Q9SzqjKFh+d6iMQUEZ77Oae7DpbJRR2Yp7/v0wOWIdOaFAsABKLH4phe9szvFufGM37l6hdTbqK83aX59++E4Vp5ovBT/uT0sbiGppc
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447d1ee5-ff6d-4399-b9f6-08d5f2250039
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CO1PR02MB093;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB093;3:gA4YmViYxIvYOTZjjpUCQTrZbxH1eFSV685WYuzpw3Ml7LGEV9lrX9ZpYciurgbnKQ5lbG5IcvkDqs1XAkwpxM8tx2Crl61XBz3FnvLTsHoZX/KmYeoAm44TSygzQOKFpJzlkS0Z3nfAO587kIm4s2a1U+xvYyCMSsYytkQkyzAEWDDRilNc6PvruJaHfpb4VWBwfciOUM3sY15+6ns64x8Xx67W+WZhoOs2tjThcHNV4HL+ZM3bBU6xRaAxnTM8cmvAzfzJsJYUJ9uNsDbG0kJ6PO7r9OEV2k9qIjMXYKH2zRdu09J+ZhL9UadEu2zvhyddHXv6nBN7Ia9g0HJ4E7ENq3K823i2J3vuDl5psWQ=;25:FVd38T2lQ3h4r5bgtAXGW98aLpwKBEgvCBeAwj7VnxSd29RV8D9qBmFPPP+Xg8qUX3FWQtQir8oQ2LE27V7yPwVD9WnDZe7zu//yGaJyC2jMdj25VccEwSvRSpN7n4kpdpl3SgpYGhdRgN3oYayCufjv44EQr+bz6j6d5JRG2awaxkohR+Egjy3e9GMQk/EGrP3ZpjYISNGuEFfJPPSjcCGyPXCqe8nvKC8kU4fOlWwUU7sF81agRO2vtHaDy0lrVe/28ncbtQXUtvLHl46gyYhXFoDLZqDUK40/P0ZeFKnoZ8PFd2U//3ZNVI+3zKYeNZ3RS4o9qDI3MIZa0Cdudw39/B1/HiVdfnVGFBpZJtU=
X-MS-TrafficTypeDiagnostic: CO1PR02MB093:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB093;31:bBaOacJp3aQagVdhXOu5S7mvRKYg6uza1l8aCdnocJQnQPycxuKKnEGhAl8iFzDxT2rl550UVG5eE3bJQa3xZv5bvb1W2CjRLccJG95ONL+xU3K58asfMPA3h9SLmdPhuqvFBDDeu1KiB+z2q1Zk1lUUPcXlYm2f2kX2OViV+sv3/oZP2ltw8ynpLWNxgsjI9Or/Jk0vDx15cna9UY8fqfcfBUn8vEuYmj0XqQCL4xY=;20:uykEliG6x54UleV6u7kpqL+L2VmO5MNqaQTauVI4x1WHpBi6iYta6B403npmYQloEu8eTYWMdzJHGKkdctwHJopZfcRew/zH/VQfYLOCzREAQXQhGP6dQLyX9mHAVoKSR1hGTIqPd61DTvgiuO55h/Z2FNSs/qyHJ5li04H8nBKcmTv2wLkoIN4dd7YR3LPCnkQXAsaX1eG6Zaoafv18CUQiORO91+NFK8rjV8eYRolGqoQ/BpDtSDJH/Mqk0173FzZUeC1tAWDm4ibeoIY0vUyjt+tVE6S3KAYucmFqFqdL3rLgeaDxz1AB4Hz5WztVmxrYrMKXzjO+JPVkJBo/AbMN3TNI+weM4mCL9l/3ZKNTmbi5lP/m0HY4iyCC0O07OBFt6DYy3JKVtORNw2G4Oaz+vcdKbMQs9QtRjwqOwOR3v2d3cKzWTBesU3RFMl+4VhL5C3PLOTqFJsk01QxOh40BENw2+WsSJv2e/Xgkt9K6R1EmSQH4nuqoE4sdJIl4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB0939D9A6EA1F72996560BE9A7540@CO1PR02MB093.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO1PR02MB093;BCL:0;PCL:0;RULEID:;SRVR:CO1PR02MB093;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB093;4:BLLg9Un/iJnOWbzep5Vtjf2kSm9I6Lb/VAHlmlFNiRnVnpOLXRMUIUwjcjvoZrcYyey5ZHDgQ1dLAqckEcibf1MnGDL6IovRYNcu4cvEkvjWoS2zjZ1m5i41ffparaQRKWPvkr0pVC7BS58EN6pXabt7IJF1LJzY3VlxrWR5APr59FSN1D/EDIxtDnLU1aTMXxYdCTFPisveFoPidVBeDMs5CXavUtKTLesuTFCcGHhZLgytyDljME4x8itPxJc1yHmRcb8aFvPi4uafF8+qdVcHocQSoMJ0MhBMrSyBfIH7cH58KLsM65JH6kaB+Ji1
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR02MB093;23:4ooET55ODukZkCMzldlm2/Bs7k8O40DiVPWhAjlJOe?=
 =?us-ascii?Q?yKAgMDNDqsrHTx4FNFz8n9JP5pZubrrbydaCW+rsRYxybC7U9g+LhiM1v4xS?=
 =?us-ascii?Q?E3pzy3JDrFzK4TYM2WaczbQvtF8NQ1hZK0FC4/3Li5tvc7aRLOCLVpu9Xqjq?=
 =?us-ascii?Q?2QIPphGxWLt/T5f/hNz5Osy33ByFZIysaxL4uBeY4bt3VJhbgzDVqSVdsLqc?=
 =?us-ascii?Q?tcqoi7eXe3h2Aza54pARX1dc7WdQCfOVbaruhYbxQIlXv0lexdBygELxaoub?=
 =?us-ascii?Q?yIOSwVLRGOejt4ysgFw+M2tu4RKvoXYicb4MUHZEXZ14neU5k62TFFxgxfjB?=
 =?us-ascii?Q?ehtxWFM0/KDZVcLVN33V3M/prR1oxmoL0/XCq1pQhOBMNUIo8wfVNp75D9al?=
 =?us-ascii?Q?KzjMejmO0NGdfunlKUG0U0BDnnQudjdtB7YY1W/TlWaoq9jc/dWNZt3EySHB?=
 =?us-ascii?Q?yYl+4yvCr/onSpJtqlP4Y3GXpTjjBEJZ7o6F79cPIJynmXcjSqG4XP37Tps7?=
 =?us-ascii?Q?hHIkPk9Rzw0Npraue1tI8cx5ZoaMONgwI/iFGlekvE6GYvprggdSsbGtfPwk?=
 =?us-ascii?Q?juSfMcDcNt+EFItHXk5j6lUt6TZH5tSbDK+zFsng7nacUGKY1qx77Rw/vP4j?=
 =?us-ascii?Q?Nn0M8tcmgKR1VvAry3Mtb7LI+pt1HOpnQcmSLtTXaH9Kvgbd7D1DpMt7zjek?=
 =?us-ascii?Q?9277uv8TyzHwwUpN9vDPwDyNRzdXyIwO8TLrMpShqztwfgIIztEDbB/+1CA7?=
 =?us-ascii?Q?jhE1O4qU/7o2pjNC+YEZAPStlbQEYAS1pwR3XJZJyMvrBkRVodM82KBSdsWc?=
 =?us-ascii?Q?uyNJJi5csY+zehixYs/lJAllvbp+b7rrykHHzBzHH7uCNbpWrfwcr3Rw44q1?=
 =?us-ascii?Q?4jKtDPVbZwHPgkH5jcGmqi+wO20iUo6fsyWWTLcVUTgb7Yka8oK2TyZGQWOQ?=
 =?us-ascii?Q?R4F+oWsj453XGmBYlSM6DfoUDXMuemYOQn2cIvRCEz6Zs7in9k3nD+5CWgLh?=
 =?us-ascii?Q?W/qQ2FwSot9TptIy/V6DDtERgpO4eYAuDGjw0mLsI9+wl8tptMYYzhKcWexc?=
 =?us-ascii?Q?b+uvamtXoK6SaUOZCLSozXoVTfu4tmUl1SpbwPxUsnIeiiWw04+dSnJaguIo?=
 =?us-ascii?Q?kShwhog+tWF221aGcYx6hG6dgg/QYVSrwYNNIHC1v8PDBGncqOjwHqimE21Y?=
 =?us-ascii?Q?FDr5sIsaOZUmlVj+H0tFw0qVF1TB0nrPP9/PkV193FPyDxgIqJpPlfGJognJ?=
 =?us-ascii?Q?pXzPX6GOURMIpFBtE=3D?=
X-Microsoft-Antispam-Message-Info: tjdKqWE15o3GiDluDHKOP+IFlZNsR8gFxZUq73vun/dZjIaV6pzGQ0eZZl6gHeEMEq/PVTJAoMnjppkDYaDGaFjcJK8XA/tS78CY0U+Aisyl0aw89drm3YBPRvaj/KR2i34NHR+QQWTz7HhLqUrcTDKb3r5NDNBBKttpr8TKU06SkaYS74dfdrCPTffrkushsEoTquEEQzOq1IIrxO2tH5BAXD7KHgBxmTo8z9Tp1068VPavrJnYORZ5beg0I2rfUK/r2hz0dZWwy+DrUuhyKWYJ1EuQwrU5GpDqjqFu0FiqPELrH1bXdGr2NlUMY0WsnwUS0j9XG+wtCyUEZcUpLPJhaNC8jxqDuW9Lm4EVaz8=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB093;6:bUof5xLt7Bp9UM42t7gtDW82CqEMq9E8HdsOQ6tQKPpCtDOR1U6y4mbac6z36cuFj95Bl81plsjRvdkJCU17Y/dBCMLXQmmOn0wJKO5jF9YLtxifNXLdRHl49LvJiOOhIiWeMYQeqCYJtHJILAbv9r4x9phtVSR6npIPN0pAnYtRX0280Sc3yXpaX1h43XLOzWYHd4aSvIjBMSffsLWXXq6n2AMX8MJqhO6QTw3t6WYMOO3UKX6EgUVF7E38x/cOrJK8LIgXdspROHFsQDl7PdfxSFvCjIKArH3qJeqaWpwJAsuZ7QDmP4TClyIc2kkYJdVPksCR155t9LsM8HqmGlpmHrfOMqU6ftEI2x7waMUmnH/aaOABZ04Jn+G8IwSOCdnDg8nllofCr7LV3Hrr2ZU52J9JNZAm4AZpQfS8xNWwya4xTNauenl1z2m+M8xvd5nb810DHIuFC8XKp6+Srg==;5:QgHaBHxK90jvg1xNjNru9nYRrbuDo3KoGrbOugG8sN7ueVMHECtv7eJSFrVeq1Jmhl9M1iub89CGZu3F8T/ApcbdHcG9doA9LRHG/uq2VQtjTka51KLpJh9+qAWEn2qoh3c2UqueJM6HD2eNof3N7JrPTuB2bILK/3FoO1H9eCw=;7:iovy78A0t9kukHhU40UbfkkwiHH3MWsZRQHZLvzrR4RkxN/MYSwpgN0TrlYWXSiM16Mbo5kXT8QvHJDU41Z9ELBSVLgxNCeqeYEiBcwOlrLGfsR8W3Nt4XbQ79dYq98bQhGzMKoI8AGk16Yg6hUIF/WCgtH81QqJ20a40PiYB34kCUcSKCkEMC/mgYGejFtf179GUJjjbMNuOmExmirZu0p3PVmcsEf/HNpSMmRLYLzIo5XS8/kvcdU6gYz7KytI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:45.4912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447d1ee5-ff6d-4399-b9f6-08d5f2250039
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, stream id related information
needs to be updated into DEPCMD while issuing START TRANSFER.
This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f73d219..efc6e13 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1224,6 +1224,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		params.param1 = lower_32_bits(req->trb_dma);
 		cmd = DWC3_DEPCMD_STARTTRANSFER;
 
+		if (dep->stream_capable)
+			cmd |= DWC3_DEPCMD_PARAM(req->request.stream_id);
+
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
-- 
2.1.1

