Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953C5C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A27D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PLYeRFgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A27D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeILV2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:28:34 -0400
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:21728
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbeILV2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5ZrmwyMfUPk87fcwowXVpLVknVpK1lh2d2j9N3yqPE=;
 b=PLYeRFgYXJDGGGEub960Mhk39klmSrzadnvGbT3w6jriINiSjmz2tdLGDfaNLbX1cDZsuH2d1TBQa6JMdL0Nu8nt0A6d3+ciBMwzFqgb4nHSc2DRO1+iaKOfEnAHGjnCChIkV0TCX53h1jTkhowZT1A8v+9mJBFjXV7EV204Ips=
Received: from BN6PR02CA0094.namprd02.prod.outlook.com (2603:10b6:405:60::35)
 by BL0PR02MB4756.namprd02.prod.outlook.com (2603:10b6:208:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Wed, 12 Sep
 2018 16:22:58 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR02CA0094.outlook.office365.com
 (2603:10b6:405:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Wed, 12 Sep 2018 16:22:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 16:22:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g07ur-0000mp-MX; Wed, 12 Sep 2018 09:22:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g07um-0002PT-It; Wed, 12 Sep 2018 09:22:52 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CGMnwH029636;
        Wed, 12 Sep 2018 09:22:49 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g07ui-0002OH-O0; Wed, 12 Sep 2018 09:22:49 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id E546660509; Wed, 12 Sep 2018 21:52:47 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <vivek.gautam@codeaurora.org>,
        <kishon@ti.com>
CC:     <v.anuragkumar@gmail.com>, <APANDEY@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 1/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Date:   Wed, 12 Sep 2018 21:52:45 +0530
Message-ID: <1536769366-31398-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536769366-31398-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536769366-31398-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(2201001)(316002)(63266004)(81156014)(2906002)(42186006)(36756003)(52956003)(103686004)(36386004)(107886003)(50226002)(76176011)(4326008)(356003)(8936002)(51416003)(81166006)(39060400002)(305945005)(16586007)(575784001)(6266002)(48376002)(14444005)(50466002)(106002)(5660300001)(8676002)(336012)(476003)(186003)(2616005)(446003)(11346002)(426003)(90966002)(26005)(110136005)(126002)(486006)(47776003)(478600001)(54906003)(106466001)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4756;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT057;1:gBgm5a6HgteXMcKwuH3k1/IqYg/f3I1LHJ6GeXxH4bPHxNdgMiNfyy+l0llUmbmI/KIFdrSkcy90emmAvI5yqqjrDtcIdPknKtPKKNeCwrPoWARxlCJW+jqPN0gLUPaU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 594e46db-187f-40cf-8c0c-08d618cc00cc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;3:HdFCmpMUW/HLj7WmPfwKaEcHZrZBlZSLA3YnkT9drOyV7mSbAHCp2jneJ9wFIfQf8JLxV/szTFkV7r7L1Fk54D20AqsVp2AScg8NLNmDK+Hx+d3KtIlwYtjkW93BAVEO9cEPtPPeqoX4s4KvLx6nd4LUX18B+hd+JRTm2o5TD+3OguK3hrgJQIL/mSk1l2yKm8BOIVBgolSrbZMXbJItwfRRXzC/kEVFgmtt0PLU917QrH6xKVRQf/ycfI91ilm9Sozule+qkYh2sLYN9X5u6cdI1lfzPBksxyxPphD187o8em1l+7RWZmLJbXhxuEFsSo10X1klce27Ir4Kl55QzKxsdqFvNMkogJL/JSoXvDc=;25:HKtu7GKeRSC93idPJSH73FEe6IOSgMngC8JG/30n459dxxXxinkE+ZWm3YN9puSeF4iPOz+wHKJIotOz2dqjin0Uy0gVQP6VFJIfEX2QCSa01rAHdVB54V+vDanw/IPo1Q6xFijuseUFblf7c7Z3blWl/YkY8p+k0pMzEXuV0/HpurHzNJMBxlRkmw5G3xNr7VdndwSwwMLasUg5nOSA9ac2xrpOlBYKoLMsGtL1g9xwhA7DuGxo+ebdP7EbUx72EJb79P3J9nfclzabrqW2zR7L3QjrVyCdia/1I+YwXIINfdvUXYidhdueZ3YOuQ6gBbMR/IDTwGJio+vYK3omtA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4756:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;31:8oa7rueHNFsb86JCj+WqhdzFJARc4gONYDgZfb1MYrGuzDr+t2SQhxB/yJlW7zAYKVgDlgZa0u7cvFI7PZ5R73WXJmhFuXT5FNpwY4UZ8K3L3hZUngH+/vakyE0aR+R48opseeE0Rwp99F+vDH3fnZfVNSrpjGovu325JidUoIjGPgf5vuM0ua9vNCjjAvbQVdSJT0asMgfU7NKEok0wISGzbx021JFZHgCdT6bHNos=;20:Vp4Q2DyeNinphR9HXi3TflB+7WuIP1lFG2iwhcL4+eL4QnTFR9gWE9CgCccbbNQS3NDcDIbzpKeoW2ivNtRrKeACuqsFBKksFDso+qhSJoxCLWx/IDO3wXsWRstOrxgTKMXf7OaSugpp/k0bX7ccBse3D0LqerrysPUyBmp2wcaXyDPIQuFz90Czc7mRWUai+QrpvB4GaJhHsU9pOeKhvvzkdDX09imyQDGzmoMHjaMDxWDwRIKbbDNJ0LvIMGpAVIeW7BDpKRKhbBv8FHIDL/Mz4df8sUQ3eRafE2xSYdSOZyad3FLWAIkEYP+roPLaclfyLc6rsA5iAg04cPmOpu8SqVKhzMTeWVEyAbJk3VreQy0iLps7vswQOvcrVa3XvpoOcDDlVOW9mZ7P1KBYX+ltNtgpCjsNXOm/rZPTAbyX6ybneX6s+fPynsTVyCgHX3bDJCNhtDyr4n0T5qXHR50Z0B9WhXOkxi8OMPiNIMUmptmChPkjzxMLr/XvQJgh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB475696007FEEF095810B9C58A71B0@BL0PR02MB4756.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:BL0PR02MB4756;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;4:4i3+4s3GM77Irk4U5t910woE+fbYbQp7+A76axNMk7vFOELEabppzThOm7a6aQfn0KBUlZqUvex6vIWAVA3apId6zvGMqqclRSON6rRioX1a50giQ/1J+42Wtb+mkzG5tOnZxT52KXiKKmZxOtAmo7JdFs3WJLsCkDcOjjNKz+G/zDF1oNcX1rpLEwTlTXfZypNPmIJZS2v2AGxnugjT5KnEQnj04v6hbYURqPl9c3TWh/f0giI96c/MYMF6nntcQYZBOinK0Ik+RB6mjJDnbvf5muwBsoCH1LXufCvc7MjAM0hvWJgc6ZW6eMQyD+Yw
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4756;23:6XZG7lyh2flEffm03oqoH5c1lNk2HA3rx8wTIYUbA?=
 =?us-ascii?Q?hDE8/OIP03qcx+QapGMA66QxI+q+1mNDxA2rHsmT6GXXVULJ7ynqKiTDRxNs?=
 =?us-ascii?Q?y6KH14MtiOulteEGmLSxK1GmH8+rEb40rfP+l6/HijWpKeAg2gRgUYYUzEM6?=
 =?us-ascii?Q?16wfsfcN3wybt+gtNTU5CQTGJjyoXa8aLSovw/cUoIiYsYsyIqHc4+6tsWAb?=
 =?us-ascii?Q?ppPS1XnPmIAUhMJ7S7njCMrzGTN4VztcYto91mgEM84vsU9b6WmLr2NCx0xA?=
 =?us-ascii?Q?unIqUD3I0Q2mopEvchrOHuUJRUt0r5ZgzjUlIAzv2fFgcn4VDTSlo2yIjrps?=
 =?us-ascii?Q?ApiXbhc9COWrk0POpUol4PI9OvFC3Y9/2EQg+oJKNhIASUpQbc69LSYYP6Dh?=
 =?us-ascii?Q?eqW/aB/8qUb2Nv2rAqZYNj/dk8tmE+Cf14ywz4l2/dV0PFDyT0QdqPjtNBBe?=
 =?us-ascii?Q?4Kql+MprEoMfXy/XgXlTxnHxMRhL2vHSo7AAHXQpF1L43MOqGT1CNzFrJujb?=
 =?us-ascii?Q?oLXWtSRLpGDSzwz3NZhLuyrzgljBNVYyYzNITq5o6bfTF3DKMmOWckhLmCpx?=
 =?us-ascii?Q?Ijbgxnk5teCiTbtIjthIUmck0EoTkQ0A6Dv8fFGb/qIpylFlNPQZ6sAH5seb?=
 =?us-ascii?Q?xUHJOfDdqT8M+zV9ytHjiB6nFfAy1O2ldpp0r+PaKAZx7l7733dCWC03H5ic?=
 =?us-ascii?Q?7pCVBIDSUxml0+ltfrPyQoflmDgaAOteRSrJA+bfux9b+s60eANd8FY3qQcu?=
 =?us-ascii?Q?8hA7JCurVls6zOXTTT/G7F/t8I1+kApC7evRohnoV7mWTppZ5AYhvn+wg8P+?=
 =?us-ascii?Q?+7V30/4aJY4JdtMxdsjKLXivxvMc7mCCpbLa9T8QHj50RHuc2WLts3qWEmne?=
 =?us-ascii?Q?Vbiua6KC+af/nqDjB+TwxvBOzumoq3JhuPmFhjFsWt0ZPHfIsW/HNG932BNu?=
 =?us-ascii?Q?4U1hNGW+9QXOu8RFLEpIdtGicAHEUSKhg0mmKcleJlNdqx4W0n0EpFSDdsT6?=
 =?us-ascii?Q?SXq+M5wUSs+93/YECDP57adyDcORz2W+PCaaxR818SFHIbjnGWv4HO6BJWnJ?=
 =?us-ascii?Q?G/pE+mABin0MmkSAXM7EESa8zf9N9y1PQQhs4mV/gUQhbr5whhTIX/V5D2Jc?=
 =?us-ascii?Q?qKbudCazqaGtI9MliPek24/7zbzAxjjwUyfOk/W0z8M3kRwpyYu3gbWDq68I?=
 =?us-ascii?Q?jicwFuiI7LxD6/74EJn68mjXY3tvFzzqcLyrix/r/IcZPhIu9TQb+9aa7sGe?=
 =?us-ascii?Q?v3FvCHuzBS8kEn9qSk=3D?=
X-Microsoft-Antispam-Message-Info: KSrsaSVFwZwzq2kLvKier8JCWnj5iOk7ogGbzbS0qTGX7oX6KrS01dp6a9zD53q7yjORXG/MtRLb7oApy9+B2GSi2h6RRq86YFHm50RrJWWpRxJB65rqLfUpiL2pipOi7ZSHFqMAfyrmJ2qzMLSv4QsOddiFoYDnX+Brsyj7Xpr3EeFAlJWv1BOnPr2EcZP9yVCC5yEodf6KnZEaJgvbUNtZXyplZmPZrdxIvRfSjZp/9HqbvqyF0zCjfkUbUxF4Y3ZjJBWV9ECoDaO5rKWS/YDBiBQitEjOuWKRRTGGu20cX01/HXnSYIBhdluSxvMkBw2AQRZc3gfV758BxmK22aYKBy0RkYt/BGE68+XFt9k=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;6:FPvCVzXvxEySNMjEOak4jU54UP7GRfLPz69ktZVSfG1j9jHA0QRHBBWmKcuUztRUqDILivm1FJFQGQkn0HpkPylLBAJQJn8o2JLYF9UR5PVnvqemFUhuPPC+PWneeWZP0EI/eErE/JZjuMl3c2S/fRIzM00UFfxrkHfLc/pKNQqLEb6ijzzR76GY1KjAnU930odGyvXEw6eVT1uCZZkbOwm+3wN4SxOmD2q8Qbg1KoahQUy01N7AqluybxQKvdUAfrHCX0OmFKjDiCL12fzW+M4HfvlHxYNNLgIiJedntU0rYkjEcNcrg+GatcUYhldyUilf5UxgQrG0IJ6zVjNipV4ApavMx51r24Rqy9hYXXybqzBs2WtvrqHaIviP72FCjUq/YCwdQUKJHVC0tr1hLizDJovfyWmmge3bQdR7MvL5ZCVramaD0BpS2/TumpYecoXJ5sDc9AEJLQnngPiE6Q==;5:fe2E3cVcKwihdZSn7CX/KrWSs2yC54gjEZGlBdmBvxrpwfpeR+D1SQQwqB9R106uhbai4grfJ/abRdcoM8Q9pzwaesxf4qlyjtwjbfWVSRGbiMvxr5xx+PgHAmsZzZXYy4VZ6TCujcjh8O+R33Pz5Y1BCto9/O+iQ96iCyQ78mI=;7:GIqfP9LoBrzikRywJDrWEsh2JImloSQXKJRLcUdYqmWf67NuSKImu1zeKeB3diZFOwIfMm04W5fpDYkv0k/zJ3JgOt4y9jihyds2r14EDKjJTtbrdCBgnL83kjcGITcV4N3y9dvx2V/fyHANnXJKSDcKudP9Dv4OVX3CUKCFF2MMHwAWsPm4EdEMJ3lvxITpk/feMPDGJ42fCJ35h0lqn74D16G9Gy6bqQzmDK8Xqm0+6Wq+6VpKVq37Thxb91Z4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 16:22:58.2647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594e46db-187f-40cf-8c0c-08d618cc00cc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the document describing dt bindings for ZynqMP
phy. ZynqMP SOC has a High Speed Processing System Gigabit
Transceiver which provides PHY capabilties to USB, SATA,
PCIE, Display Port and Ehernet SGMII controllers.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v4:
	1. Fixed the changes in phy-zynqmp.txt as suggested by "Rob Herring"
	2. Moved changes from include/dt-bindings/phy/phy.h into Patch 2 to 1

 Changes in v3:
	1. Corrected the Documentation as suggested by "Vivek Gautam"

 Changes in v2:
	1. None
---
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 109 +++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |   2 +
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
new file mode 100644
index 0000000..ed501c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
@@ -0,0 +1,109 @@
+Xilinx ZynqMP PHY binding
+
+This binding describes a ZynqMP PHY device that is used to control ZynqMP
+High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
+and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
+
+Phy provider node
+=================
+
+Required properties:
+- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
+
+- reg           : Address and length of register sets for each device in
+                  "reg-names"
+
+- reg-names     : The names of the register addresses corresponding to the
+		  registers filled in "reg":
+			- serdes: SERDES block register set
+			- siou: SIOU block register set
+
+Optional properties:
+- xlnx,tx-termination-fix : Include this for fixing functional issue with the
+		  TX termination resistance in GT, which can be out of spec for
+		  the XCZU9EG silicon version. This property is not required for
+		  "xlnx,zynqmp-psgtr-v1.1"
+
+Required nodes	:  A sub-node is required for each lane the controller
+		   provides.
+
+Phy sub-nodes
+=============
+
+Required properties:
+lane@0:
+- #phy-cells	: Should be 4
+
+lane@1:
+- #phy-cells	: Should be 4
+
+lane@2:
+- #phy-cells	: Should be 4
+
+lane@3:
+- #phy-cells	: Should be 4
+
+Example:
+	zynqmp_phy: phy@fd400000 {
+		compatible = "xlnx,zynqmp-psgtr-v1.1";
+		status = "okay";
+		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
+		reg-names = "serdes", "siou";
+
+		lane0: lane@0 {
+			#phy-cells = <4>;
+		};
+		lane1: lane@1 {
+			#phy-cells = <4>;
+		};
+		lane2: lane@2 {
+			#phy-cells = <4>;
+		};
+		lane3: lane@3 {
+			#phy-cells = <4>;
+		};
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type.
+
+phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_REF_CLK LANE_FREQ>;
+
+PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
+CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
+			  or PHY_TYPE_DP or PHY_TYPE_SGMII
+CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
+				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
+				PHY_TYPE_SATA : 0 or 1
+				PHY_TYPE_USB  : 0 or 1
+				PHY_TYPE_DP   : 0 or 1
+				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
+LANE_REF_CLK            = Depends on which lane clock is used as ref clk, can be
+			  0 or 1 or 2 or 3
+LANE_FREQ               = Frequency of the reference clock, can be any of the
+			  below mentioned based on the phy type used
+- PHY_TYPE_PCIE         = 100Mhz
+- PHY_TYPE_SGMII        = 125Mhz
+- PHY_TYPE_SATA         = 125Mhz, 150Mhz
+- PHY_TYPE_USB          = 26Mhz, 52Mhz, 100Mhz
+- PHY_TYPE_DP           = 27Mhz, 108Mhz, 135Mhz
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+	usb@fe200000 {
+		...
+		phys = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
+		...
+	};
+
+	zynqmp-display@fd4a0000 {
+		...
+		phys = <&lane1 PHY_TYPE_DP 0 1 27000000>,
+		       <&lane0 PHY_TYPE_DP 1 1 27000000>;
+		...
+	};
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index d16e875..09cc0a6 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -16,5 +16,7 @@
 #define PHY_TYPE_USB2		3
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
+#define PHY_TYPE_DP		6
+#define PHY_TYPE_SGMII		7
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.1.1

