Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE3EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD6A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KFKH5fDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeGRLut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:50:49 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:57264
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730253AbeGRLut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sYy6RICp5T7r2qWjp/QcIAPedX/HWcBVs1QA2wLrlo=;
 b=KFKH5fDY4EI3BwvGC+aFuMcko47u3Kb746nO63yzB2yfG6bLMOuA8RbHhDYr02iMaKfGVTzhB8ooPYUeGG2v8aSMwW5S3AoQvN7a0cm6CUfhgwahlBv9JhLxcQzYP2c2znhJaK8gbFmibAG+jhk71f8Qug3pkiBEuxvJdV5T9/g=
Received: from CY4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:903:18::21)
 by BLUPR02MB1619.namprd02.prod.outlook.com (2a01:111:e400:525e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Wed, 18 Jul
 2018 11:12:48 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CY4PR02CA0011.outlook.office365.com
 (2603:10b6:903:18::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 11:12:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Wed, 18 Jul 2018 11:12:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54309 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNy-0000uo-W7; Wed, 18 Jul 2018 04:12:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffkNt-000325-SV; Wed, 18 Jul 2018 04:12:41 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6IBCXpJ000907;
        Wed, 18 Jul 2018 04:12:33 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1ffkNk-00031U-E6; Wed, 18 Jul 2018 04:12:32 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 9D37D1214FE; Wed, 18 Jul 2018 16:42:31 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk related functions
Date:   Wed, 18 Jul 2018 16:42:10 +0530
Message-ID: <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(438002)(199004)(189003)(14444005)(47776003)(4326008)(63266004)(106002)(126002)(2616005)(107886003)(44832011)(486006)(50466002)(72206003)(478600001)(90966002)(6266002)(48376002)(476003)(52956003)(6666003)(2201001)(103686004)(5660300001)(50226002)(16586007)(54906003)(81156014)(81166006)(110136005)(8676002)(2906002)(336012)(42186006)(36386004)(356003)(8936002)(316002)(446003)(36756003)(11346002)(426003)(305945005)(51416003)(106466001)(76176011)(26005)(186003)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1619;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT031;1:I/Ya1Dwjm5MkV3sdTAshmaAvL8Ck8u2puucVL1eeiFxLLPGd3bM8lBzpAxz+xKft/cC/e+QF9DR0ZZg/0/Iw7lq3I5gGC8ABC/UTuIqdrKT7bI/NmFh4uii/LnFsxZK0
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9651044-81c4-480c-1066-08d5ec9f64c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR02MB1619;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;3:x0J/04P0gctOwqKHwK5krswr/hr4qQkTCAGFRoeyIkBBeaozGxGqUNXu2vNI7B0aj3kXmetzbEOnCGgpg+M0ovmqN7uug3DJxiCADZ+lWpeGGBXbCv60dEDj0cKX7/zb9EBHhjxrGn43yUvZaHdzWChUX5J6BY+Zp8E3yQG71XbVGtu5e5l4+7qq8zjcPp7g6bEl969EdGbWwlwGEVT9QZUPiz7G//C1hES5dd0KYXNybfuM6NQjnmMyQFINwGCVUI334xo07j6fjXJk6VZh1Ywb5tz5zD6icCUeZU+Q6ddMVcxrYCcHnIKVMuaz7IHqrueIxVTpATt5RAuQ/Z3Gb0euAjy46aYSvzLREmhBDoU=;25:OwbueaFjtqvuPQtVAZpOfE759qqxc0w7zu7+vJPcKfj211Gc5YGlNM/hZ6ZFrQnKrzoG8cPBJPcY6menv/NpfLndenzIcJXRzcPDUDO1gajSTovUNzKbliztwQANk+pCWMdHhoGOfrwjKkGUXd6WLyWlri7rigyvcG5+yCtFgJmUjfyLYCwTeIhR3jW+cxKKyyMx+cfXB4w6jX/6G8eKHCEiFnbj2Mi4c5Nvmll9Reog6QZ3x0mi3sFp2crFRj0ic/kvVjC61ob8kKSCTgBscrhhh+b6I2nV/Xc85U6F4WIs1oCtnU82/SQZBJFUB2Qca08fP8WkojhbnYImi4EBNXx+h4ou+LUDYKeS5GFtk0o=
X-MS-TrafficTypeDiagnostic: BLUPR02MB1619:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;31:tzXvvUwa9eTDRcYIrKREEBqVa8UMqLD/3jfOAhdFRXp060U1lshi4cF/wKNMo8nhYPg4YMCeguoQ5ggHzJ/piojVK1TqBDBUK1dAL7w9hA4FwCqRXXsucH7YMJy0tz41VoEAxjBqBooTW7bskQCl6nzY7bMXFEdM0KpWUfPGRMt32DLSwVFQyAbb9l120kMCptLB96cPHJHW9P3yNtqkbmIi+kBvVaMXH57btJFjqA0=;20:GgtiUAeqfiph3y9T44Hepf9s7uXbUV6j6/bp1cbKE930hA3jz22XKDMccQEGRD62uYS6NRTFdHuM+Carp+/nCDG3yebNUvqlVEXKtxIsDNcAwyXsiKBXfiEJokjJhjzT4KjTJMOeeMT7qRGvwgnLuh8JPly3epNPkKlVY1qNSu5+heoS4ACkDYvdPMRjEEIyE9OWBM8gf4QSz+ztQsW1X0BuxoNytb8bB+qAYj3Jy10P29HOKtnGFoD15dRWN5Clj3asU5qtwYUwSUpbEXefQpD/h6Fjn5THsvAsh3NCbGJul3316fk5Rp29TrO4Vxz0EXDGsMfLTTU7PRN9KKZQQfk2QKsc/IuBF3b5BiHToZx8/IWg5NVJWrUTl0ZnjcDktQ8vrSQfDUPpOc4JPumZnAp8eI4XZ4jEj6SMGu8ejO6J5BWm8oSa66MB4KCR9uG88tfdVi3u7FrT6myNboUPVCMFEz9uOB0Rod8KyshaikP44gqlfZHF4+iZ159kwrGo
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB1619FE1D7EB84FD9D3E1E910C1530@BLUPR02MB1619.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB1619;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB1619;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;4:+/bgghJd2lVci19XJYIvpUb/Hw3f+SB+7SyA7mCo/J76JjtPeJaDOm5UsMfKYfClrPRg1FN2DGgs5j0FHLeGYATfjb5SssDUFW0RK8gXsq3bs+nQoOY6E/7HlJWzVQqAp+3n/ofoc4T8TQ5H/c/JKFCcLmUhsLSXOxi05A4Q7GELvg7EGh0cILQ21WoT55VwDPFafMFpQjKXSOp0NrTPPMCB+1Sbx/Fg1acHB3WtED8aBIxMCO1DQbmXejOJ1iknMi15tBPuAlkm4BbIGT7mchOPtYvvXks2CFVjTpHQxZnk3XkCqFRgs75+J6KItHBF
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB1619;23:RVIT8w6G1f7TzWihWGJORYmtlHFNbOWyf6cc77jKr?=
 =?us-ascii?Q?RMo8FM8cT4kx1Vnbi05y4MtZzWiyB5cTJew8YVAwxNs6mt4s1tDEwbAnhSph?=
 =?us-ascii?Q?DotYyX8w5iZeTnPqdcfwjLoFrakthS+wuhSM9soJpkICwQEjXrrC15XIRa7G?=
 =?us-ascii?Q?07oTTHkFIOP7RjDbduaTqFl+RUGiZorNP3Djg59EBy7nwO8M1U/87Qnt8F97?=
 =?us-ascii?Q?E8tY6RQRzjlw9qk2fOfWHQtmi3Bxc4ZDAWCeeBDHpmCE2pYrlmxbIX/nxMo1?=
 =?us-ascii?Q?J4S+B2Mhdqts7nGS5uHWtP2j6aovrrs/+bMuKxUxbqYP7wuyqYMtBNQVFqcC?=
 =?us-ascii?Q?blHsnUz/HnhOLvC0DlMfRQ+JLCC8ml4Fpm9lGdjPwkSetikHrNN4V2UUUfcI?=
 =?us-ascii?Q?29AuW68PBWhfIsfMUVGVy/lonIDjPQxY9mNzFNvLKRUQiLQZIWuCejs0QncD?=
 =?us-ascii?Q?IqOu4XnzYAJbuSU3ZPVlY7iZ6tDhi7pZwfJBlw2nZmyjXJYaKQOcDPRIXrtQ?=
 =?us-ascii?Q?sTxf4jwWka6+ysNDiBYiPkDU+h1k8NW0b8ZvygH1btNW+rsZ5ytzRS7kS8H2?=
 =?us-ascii?Q?RWQX/i7Ezfqp875wgqyav8zxBT2DlGOKFOQOsGCB/R0jPVumG/F1jSJGSpsa?=
 =?us-ascii?Q?mJng+wroWVio5iqFYRVYivZLlDz2xjdmZllE0mNXNjImZSmVPEhT2Ti6muag?=
 =?us-ascii?Q?2DTGBAM3YDQvsahoV5lPcLDK/Da54Vluvsyb9x6FmQala7ERaGpFSDbuBtVU?=
 =?us-ascii?Q?AEE85argDYvMljJGMVz5dhI1AUSC9HFQX9uL2E2/IXwau6jiEnu9JcCzvr5Z?=
 =?us-ascii?Q?SNqans5Bi8Qu15iJGz/0RnABoSmOzprSUSztaiYwjYkLZFNOG1E9WjLK3Kq3?=
 =?us-ascii?Q?b5icSAFjAEsccgi59yPocVmB2Lpk4S2srOqwULOSd5bLxGdksx17TeRvNRLE?=
 =?us-ascii?Q?kKmRTmfSZ/DIEfr1laup9zRptFddrTiu8nl698GM6eOJ4ZZH9OqGbuX+UEsQ?=
 =?us-ascii?Q?CKHI7SEj+N+2+RlWEMZwXignaICszlQBPXPjQCxscmXOcBXLH5Nc6IGCGBHX?=
 =?us-ascii?Q?82aUJqd7nT1j7tZeD3SKRf2dQR15+aGcRnXLR72P3qe1WH8e/dtkMM6t58fI?=
 =?us-ascii?Q?FjHF6gusrUgVZMtNegaHXj9332LTO2iUmDtCIirdVpS8qyKIAeEo/PdKi3aI?=
 =?us-ascii?Q?CFlciaBRHtAX4L0AJP5btYSnYlivLqy9+PBRp+AO1ldu5/brxBIkFfusGkxq?=
 =?us-ascii?Q?W5QBs/g49g+SyctnrbeFAaZhRXeW82gxaJ3QA1OxFTEo9R0Eu/X6StK5AlFq?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: vGqUY/0UeXZNYo6dW7adB0e250oXYlcVV7lOCf/tTLaaWnIaOoB/kUTip9GNoQOwGi0B8wVuR/5Nntr8vvWdHX/HRxVSj5gILpFB4RcHof5WU+kXWFjcNqLkdYrUiAHIo0w1mLC/qttofSyD2TVIMfozZbZG3dsEauAmh3y5rmHm4IbnO4i4Tm2Y2KZ1TMoMi4JGT+jKHJ2T4LdkFoexzoSv2QyMkFfrUXXnEho5p3kJP4TiP93SlRzfsdGJEnvY/ERx93H2TH4ONipN7ZerNLSO4R1vkJaep4Zv11iKGc3FDmlCNCe7AlYw/0EX9dz0+hnGhd103pDIIykKLEWyndnNqoEsvBBXuJdCYLlmwrk=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1619;6:5f/cisgmlr17zKf4fV0cqYkuJaxpA4mhc+3cakWkdRrbxCv/ddn1DRQ0bAjgPKFjZZrIzII9+nbYtsjfHi2EjjUAlC8sujNjj/fR/G/ZpOzo8YfwhDX6f6QsE8P+IQuLACE8GySk8hGGrkeHks6NKFwZGLyg1yCY3WCCnMQo66xkK6iSr94nTItGLOdKyZuS4aUSRmbD69/u1PTeRTqiMzHevJQaEzV+qdXnAZU/GhrhH925N3mfdy3W7746EkncsWPf9/6hMtiBVFCN6MAws6E1nxrhWG8kWJZdblC9PMXG1PsLB3ArD7MSOkhGxnVC9eZ9nMwyU0DdYIVwK5RaLDuvTDyRHGMjDmlLl9wuzVKVDjoih8qcpYJXuYI5NBs0cmPOIX6n183UqLNSDw8ysvJFNThKVqBUrwvaj1IKs7et6apKRzip4Ak14WeQLHJFWOghmQ8P8lFM0aSWz1nNJw==;5:phwNcBgxA2qsuQP8a0VGA6xPeRXibS84W/Q0cztgKUYLqdpg1qX5pIhn2TPnOhrYdsaLAMLQF0gLvJSf0sPO/DIS/x929eicmPMcb1SkdU+FMmyQjmowI4hYe6usNx8VMrgwUsqlfrKhuURevdjlTm+Ut3m86jUfPBE8Yyg9AQU=;7:8NZ/aUlpiDSL4+FuV+yssNAo3vAqcVb7KBP+07qgYvUkG+A6xiChR4lSP1NJwzKwJiBC/9H9wUw+sDvrPbz6TfuKHDS2+K0nmHYgmJ7+JFbhCN8Vgse0eqzmE/3v06ZfovHI8qFbs7XBubTFViCtGoZ8D64o1CLdUAtAH/hUs2dmbEMBfCX7lpSzCsAfh2qxTdKF8uHxyRQMsJkn0rXJ0GyHv8kuYuxvOJTblF/ckSiLNtQF0rBjowk305jCuAe4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 11:12:47.4834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9651044-81c4-480c-1066-08d5ec9f64c9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds check for return values from clock related functions.
This was reported by static code analysis tool.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 248cffa..47eb364 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -322,6 +322,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 
 #define XADC_ZYNQ_TCK_RATE_MAX 50000000
 #define XADC_ZYNQ_IGAP_DEFAULT 20
+#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
 
 static int xadc_zynq_setup(struct platform_device *pdev,
 	struct iio_dev *indio_dev, int irq)
@@ -332,6 +333,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	unsigned int div;
 	unsigned int igap;
 	unsigned int tck_rate;
+	int ret;
 
 	/* TODO: Figure out how to make igap and tck_rate configurable */
 	igap = XADC_ZYNQ_IGAP_DEFAULT;
@@ -341,6 +343,13 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 
 	pcap_rate = clk_get_rate(xadc->clk);
 
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk,
+				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+		if (ret)
+			return ret;
+	}
+
 	if (tck_rate > pcap_rate / 2) {
 		div = 2;
 	} else {
@@ -366,6 +375,12 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
 			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk, pcap_rate);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -887,6 +902,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
 	unsigned int div;
 
+	if (!clk_rate)
+		return -EINVAL;
+
 	if (info != IIO_CHAN_INFO_SAMP_FREQ)
 		return -EINVAL;
 
@@ -1239,8 +1257,10 @@ static int xadc_probe(struct platform_device *pdev)
 		goto err_free_irq;
 
 	/* Disable all alarms */
-	xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
-		XADC_CONF1_ALARM_MASK);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
+				  XADC_CONF1_ALARM_MASK);
+	if (ret)
+		goto err_free_irq;
 
 	/* Set thresholds to min/max */
 	for (i = 0; i < 16; i++) {
-- 
2.1.1

