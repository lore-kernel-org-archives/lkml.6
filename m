Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3010EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D511D21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oyn4xQYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D511D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJSQnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:43:01 -0400
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:37949
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeJSQnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0IBm8GaqqrW2TRHpkaIzNIp+uykdjcWXLrpLqfB9H0=;
 b=oyn4xQYeu//zy242d0gARD83OKuusWSbUUxxTtgewNMprh8wU8wjFTqXb73e21l1+MOx56j6mle3kj3nAwAFhaDLt/UJG8CsT0kHmJp2EgjrA7SKZS2aLwqExi1M8sxWEf71F2IFYVQxQBbaQPIdPwPi413MzBKdycoTmUX3QO8=
Received: from DM6PR02CA0036.namprd02.prod.outlook.com (2603:10b6:5:1c::49) by
 DM6PR02MB4331.namprd02.prod.outlook.com (2603:10b6:5:2a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Fri, 19 Oct 2018 08:37:53 +0000
Received: from CY1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by DM6PR02CA0036.outlook.office365.com
 (2603:10b6:5:1c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.22 via Frontend
 Transport; Fri, 19 Oct 2018 08:37:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT010.mail.protection.outlook.com (10.152.75.50) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:37:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51064 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQI3-00023F-RI; Fri, 19 Oct 2018 01:37:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHy-0000vg-NU; Fri, 19 Oct 2018 01:37:46 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8bbMT029416;
        Fri, 19 Oct 2018 01:37:37 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQHo-0000r8-Oq; Fri, 19 Oct 2018 01:37:37 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
Date:   Sat, 20 Oct 2018 14:06:03 +0530
Message-ID: <20181020083603.27602-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020083603.27602-1-nava.manne@xilinx.com>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(81166006)(8676002)(106466001)(186003)(478600001)(63266004)(81156014)(8936002)(50226002)(48376002)(50466002)(77096007)(36756003)(26005)(14444005)(2906002)(16586007)(316002)(5660300001)(47776003)(356004)(6666004)(9786002)(110136005)(106002)(426003)(486006)(76176011)(126002)(476003)(2616005)(11346002)(446003)(336012)(36386004)(1076002)(2201001)(51416003)(7696005)(305945005)(107986001)(921003)(83996005)(2101003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4331;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT010;1:3Zw90vsF/6/F21Hex3kKchNkR5DCbz6Pn1dONUP/Z4BE+avU1vKDvnfeZ/8Q3R+xk0VUEF87KcBlyI26Azb1f7lkDjAd0v6S6/alUI1sUPJxM/d5pBSuRiOJqsHvIcR5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 344b3fcc-377d-404a-7a1f-08d6359e28e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4331;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;3:IMRCyoLz2tDSKdFIefMi9jBit9q8dXgX4nRmXJ4Dr2u9izX3CyN5jPnwJ2whEhk1M2102z0SmHg4gI7/0qzFUB4tecADmBoTuNcde2kJYAF9k6xhNCwrWxcfnKP7KDEO/SgVBk1Z0gCdNn0Fqjhv9786OuwMK2qdbUsaZ3BoxifEZPlHOCQP6El/0vEWoprJymp9nfduurw9zwHgCaI2PeeSJ3pzd41o81bJdSMp+EDx9U6gsB/EipVVvaFFqnDAmwREn6Iz5WT1cR/qf7Ds1itU51PSFL1tu0PD8HdwzPZDaGZ7sX9b82lpQ6NgmXEhmmi/Vq2ENH9apsGWH32aoipgZrZjK7rByTfcd7GcKoo=;25:AU24E0tokmVA5/a+WdmzW2emAUOO4iKSzfUgJJA/3UzfVXQms4IHktqpNeAx5XHOSBmW6msiJaBPxgCiEP4TR59tvx46EQloUmHRTNteSlpj0T7VC1L4/EfQu3xF//TJG8CZ00PKx+awfCYTy4sqiBAlAvIJr8Qc41tfj50NQJl5LrRKG+KcxEQsTOJhZQi1Yi7Z1BHwSc4eZPuo44/lQVGeysEuKmFTTr2htmFeIbkaghN0At1sZyW7uFAANevQFgrNFNYe3IyL8jsv7Qa3TV+JxKZ6LKjjtTb7ERy2LNiub9vVFK3ZuqfOoCq8+7BaZQAT6cEMI0A6zEs4ka5ylw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4331:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;31:z8J9rCeefDpCde2Mj+x1UbNlGlFAF9AaPvfCo4sh1sfGraGpPKEmUxkD/Fh18nfK77v40kWECl+TjWRANLSZX1isr5H8X41iJb0QXR/femU9/sFaolfgTlLz1IE+3CqN5V/7CnUvX7f2+9SpWgTsZSAR/HA2YoRkECqzPbD0UeVTsfkDkKbJStJs409ZfHIzwXyuoO34p95g8BDeWAhIDEsahd5TKN9v5BQovB2AcWI=;20:etxAal/rdRmLLIMx5ho8LSkpSw/baWyE+UhPKLnP4isiboA7//+JSNZiuFBnYaJZpRo7/GzKFgMc7mpfaNdhVejYzNBFhkEdiJqZ3igzsb160mQ+BVNFf9XYBAyAEF6EJbFepe5WEk7qEjaOnVEBidnS656gP3GjEtpykOVV+sTCNBipjWNf8VD+R5Nm4aBJoGlCr8pig08bZNgrXKfo4yYH6AFIfHbPnVusfQBUUdIxE4RePAeJyrhEzZ0f5VKUxgFEhzUpsf6uVm5Aaz7FU1Ar8LQLBqFpRiLZbkFtS1IeRKe8O+MH62b6ZIaQbjFBU2G2Hir/cq0nBXwSOSwjFNWzH8NkxoumgeLmOsYSzaf693irxCX7hIRtKAb2f/jP/2WVpCP/hOFvjNEC1W2beUREms85l5wp1MUW/jqSW2LVpZRbW6aZ94eF2sChPVKmr6JiMB6mUygRdjC6yAWGahLoEPv5dWZvEjfOpUc8BR1Ja5XVtPJOeKaY7m+5YiCH
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4331ABF7DB2C8BC4182A1E46C2F90@DM6PR02MB4331.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4331;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4331;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;4:HDqIF9Hrl0AhIxVE0wd1yWJ+nNToztUnk06hUCqlL32CRx3Bc7AQwxoSUVYMk++WeOTsgOrUZ8FA5OUUS0JdYifnHkwMrIkzgpvMHpiNXVKidalXVCJ8xwB0U7yS6+FEVO1Lq1ugXUNACPWqvczO4iWxD7KBJ9ztRXoRo0JWBgUDgoCv/xZZeKeCGcKD3tC1rKwvPLQGIn6myc4f4b1ycygsjrLBC3m6WGI7lYIwILYyeQNSgtKBI0WlzKqFoxzQmjxKS5q/NYb1wZEM4QAW/DrhF63grqwD7JJAYFZcH9hQA28nr6SCRoGEvgwL5Fz4
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4331;23:k1biDXu7GsVzXUscQhpJqydFtpkg99BsYSPfTLVNh?=
 =?us-ascii?Q?QTrEBTFM2HtJRVoxJt44q7WF8m7SCPVhvacrMtvfLAnGvYgGDlDgcNvquAXX?=
 =?us-ascii?Q?5HBenAdw0I8DmR4l5/mBr8FLbd6eWR7o90jDL2/AtQzNHSv4d75UX8GrnQ3y?=
 =?us-ascii?Q?JKtH/+BkWX0ho8TsXDkEYf8nSekzMVBjJWNM/hm3qCVeRINMk6bc0e665bDx?=
 =?us-ascii?Q?sgUhn8PR+OqHWAZPK42e73KFY4pJHpzi0c6eMS9Le1OL60DH5OFXmtwSAntg?=
 =?us-ascii?Q?JLwvDt3MTmXCZnyjqEVe7XYSJtoVYhS2HipH3GM3SS5b+yaZmQIsEXh5c1vi?=
 =?us-ascii?Q?Cv/YIL2qxdRqwmMuaf2kUjR3KxT2RvnptsaKcH2SqOSdBkEClGU1anTAryDI?=
 =?us-ascii?Q?tnokVTg8EIX6t//RsNMnwNveQZhUm/JAGe2baV0jasx1Bf7uFBhCI4/Y5c3c?=
 =?us-ascii?Q?PCRA6okVq0mXiExraR2EawTMrSt/rz5jEP0NbTgEgEn+7DZG2JilirLQ1pgQ?=
 =?us-ascii?Q?ivjE7iMp2uJjBXWvraBCGUD+94kdyJd72JRilycWnLqoA5UR2VYIQ8vYItSI?=
 =?us-ascii?Q?AwGOzAhgbzVoNeQi7w+D73IW7BE2DahWHoCA1VFPOWw2KvrJSD3VVoj3PE5k?=
 =?us-ascii?Q?M0LrZmjTsrF7yVY8gaxVDGVTPV09FFI5lWDz5lMNyp339WbjCCKbo8ky+TtA?=
 =?us-ascii?Q?b1LS3w2vfhussWBf0lM2OBGjVM1MAF5ohRCMyOqTcqZwtbZharuV7p6pR3th?=
 =?us-ascii?Q?i6lRnwa2Fk+Ozr/dKrT270Oug3PHXv/qLs43h5JjcxYTqSW6DtmqAJeSaa8+?=
 =?us-ascii?Q?nVDrQWv0L7Z6NChdoqtNX8t7jwPzqDFDloapBaYfXhNxeC+hSb4QRymF5ZBl?=
 =?us-ascii?Q?RMms5JLPWU8WPNptH8zRWN4mo5L0OstPAWPCgYy0LwM1iZXOpD8mBhQXjHF4?=
 =?us-ascii?Q?1K1SOWg6awOv3gmRpFMrerseFl3GQpn0Og61RtQzQyFEHgVmYaABUynFgZKn?=
 =?us-ascii?Q?9QtVl/aov7A+bPGIZBOj+NNtXEKye3bkAduHNTRG6hm3BzJnX9UUF73i/0I3?=
 =?us-ascii?Q?Obw0v4EXgmQZujRCf+kgOAeVz/RbWAXQT2KU3MNf8r/sZelmBK0KmVVasBsp?=
 =?us-ascii?Q?zM5ym4jDnMShfaLc14ZUmwVRa0OrtF7mmXJxW+B8lDxR7TMxS3QBFgETHY6I?=
 =?us-ascii?Q?cTHmrgIELU/rhSjHwqvSF0F1aIROLWYQAVB?=
X-Microsoft-Antispam-Message-Info: 4XMS/weDNWFe50fcaiVZuWeQvmEwjrKl5CC7G3vujW79dFe39zcIsU7XpOwn5IAikFiPmYua876SL9ia9DyOfuKDFhgu7Dkchx6DGj/3cPZbbx/cRtqeitnAE2lrBwdNXiybMpsChFmsZL6NErGXn5r6NeGeoq1UY0VJAupExds4Vm+l9RIMHdUX3FID9+RhadvCkPM83ZRS2mQUAJ+qyXYhJSgZ/TYmnl4QMiRx+8xnf5Ex6Hx+vPZ/Z3ohfaaqzHFC7xwBA2oBOFBdEZiXfVMivN4gS+U74o3Ou2pMkKWG7QFUhr57tTSECSG2a9Qr1BKVBuhCXu487hoKyBq3FPuA93lYqWp/qFviAViBZXQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;6:HoSnkUd9NViFXNUo2OVTqkfquwk49tGHPR3vNcZf7jrN+hq+qapvXWuODt8bDaPEaPvN7xsHh01f93fs9ILl/MiJlqcQKaA2XXvLn71+ujMtCgyfREhKo5fznGdsVNjKFx3HAusXwELc/stwFLVQMb097jIyXA72ExQsL1gniyhK7U4IaUsrIyK9iOnYXs46yTceUzYpU3Bi5p2eDMp/f0E0Jz1BaFvFbt4ZEXAPHgIQ407yj5NSGI81gFFRhZfIYtB/XGDZ6HcBqmtvZGz34z3EGHqDhsEu+5af0jJZfWAkc3vZVMXaKoijvkjOj7qXsW5ljLX+zgN1R8yi0EOgp/fLVq/JchawmNguxDBvHEgGYd8/IeP34PJV5SRjRDL6hYq56ibn73OrzsANALHA5PV7FEyrAf7F06W8eT44PkrNgGSmd7B54ikVZLi3ruzQDw6bvKf79JHMHBTXyLUeXg==;5:cjFoWrallQH3MGRck0GuIAxjDZw3SH0/lnsuP93VmAHL4kafbb8dpu6BhEUqqixjWfQAekKoKvH9GTCYIpMkLw55kpR9PvfuFF5pHj26oY1sLQzxpdyuWBfHiy2xWq2sYvYzd7P5AATtcYJ3p92aWTmcSxAkULkzKftGIEo/600=;7:Ayxz3pRo/5w7o6t5MTfyjYP5NydDR6/LEV1kGMNDSXqltUKy1EfNxy288QbWBvZ755fVVeumDWkDlEy6x6u2qZVwOZfok5gh1gRZ4a9WjLeOyk9O3TKquTizfhXg5TGj+5awMkVF12B2SE3HE/Ac2RWWNHZJzjsovUiPFVSzh8ot0oPRUwh/pRhdT90waNmPknRq7uDblC4izMBRi15IX0VVSoF/d/j5uotVt9FfwlpPhcsRMhNTIXZCMEOqVOqN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:37:52.2492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 344b3fcc-377d-404a-7a1f-08d6359e28e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None

Changes for RFC-V3:
                -Changed nvmem_register() to devm_nvmem_register()
                 and pr_debug() to dev_dbg() as suggested by srinivas.

Changes for RFC-V2:
                -None.

 drivers/nvmem/Kconfig        | 15 ++++----
 drivers/nvmem/Makefile       |  5 +--
 drivers/nvmem/zynqmp_nvmem.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 10 deletions(-)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470e..2edb142 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -181,15 +181,14 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
-config SC27XX_EFUSE
-	tristate "Spreadtrum SC27XX eFuse Support"
-	depends on MFD_SC27XX_PMIC || COMPILE_TEST
-	depends on HAS_IOMEM
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
 	help
-	  This is a simple driver to dump specified values of Spreadtrum
-	  SC27XX PMICs from eFuse.
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-sc27xx-efuse.
+	  If sure, say yes. If unsure, say no.
 
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4e8c616..0b3abd7 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -39,5 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
 obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
-obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
-nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
+obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
+
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 0000000..b910864
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define SILICON_REVISION_MASK 0xF
+
+struct zynqmp_nvmem_data {
+	struct device *dev;
+	struct nvmem_device *nvmem;
+};
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	int ret;
+	int idcode, version;
+	struct zynqmp_nvmem_data *priv = context;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_chipid)
+		return -ENXIO;
+
+	ret = eemi_ops->get_chipid(&idcode, &version);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
+	*(int *)val = version & SILICON_REVISION_MASK;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "zynqmp-nvmem",
+	.owner = THIS_MODULE,
+	.word_size = 1,
+	.size = 1,
+	.read_only = true,
+};
+
+static const struct of_device_id zynqmp_nvmem_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
+
+static int zynqmp_nvmem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_nvmem_data *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	econfig.dev = dev;
+	econfig.reg_read = zynqmp_nvmem_read;
+	econfig.priv = priv;
+
+	priv->nvmem = devm_nvmem_register(dev, &econfig);
+
+	return PTR_ERR_OR_ZERO(priv->nvmem);
+}
+
+static struct platform_driver zynqmp_nvmem_driver = {
+	.probe = zynqmp_nvmem_probe,
+	.driver = {
+		.name = "zynqmp-nvmem",
+		.of_match_table = zynqmp_nvmem_match,
+	},
+};
+
+module_platform_driver(zynqmp_nvmem_driver);
+
+MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("ZynqMP NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

