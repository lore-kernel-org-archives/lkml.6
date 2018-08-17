Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E02C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17566218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KwwKwjfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17566218F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHQP3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:29:01 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:37312
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbeHQP2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/70A7vEtcvWJF0usoMkKpzmi6ixFyA7R4CLqBIkp1L4=;
 b=KwwKwjfzt5fo7Kuao7+10cWGyMRONiXdIkA37IWNE2/4U11PO+H0/zgUjzFtX9wqrfPd52CXD4xKLpvQYQGtQ+YC3NZLuYuzDnGcFqnS+jAfP9i/gAnJcIVBbSO00qZnYExZMXM7JIitPLcW+Udt5SYMSszA8sa183mUMTHgDJo=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 12:25:06 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.21 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-00030u-7F; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-5s; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOwdQ019103;
        Fri, 17 Aug 2018 05:24:59 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoI-0000Th-IW; Fri, 17 Aug 2018 05:24:58 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id A35DA60508; Fri, 17 Aug 2018 17:54:57 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 8/8] usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
Date:   Fri, 17 Aug 2018 17:54:55 +0530
Message-ID: <1534508695-12642-9-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(376002)(136003)(2980300002)(438002)(189003)(199004)(217873002)(36386004)(4326008)(52956003)(48376002)(36756003)(103686004)(186003)(26005)(14444005)(6346003)(5660300001)(336012)(8936002)(50226002)(47776003)(107886003)(6266002)(486006)(446003)(476003)(126002)(426003)(11346002)(2616005)(39060400002)(50466002)(106466001)(356003)(478600001)(90966002)(8676002)(81166006)(81156014)(305945005)(63266004)(2906002)(51416003)(76176011)(110136005)(106002)(54906003)(42186006)(316002)(16586007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT059;1:Rdiw3XiCpRjNdxSTipyVVbTPoS8u2yh+XwLTHzpHNP6LC4txVqEqrbJRtY8GSotvkrgb7Q11ROfOc4auRP7i0xKhlnMgRrIVaRUZW8njqRNGzKKAAt/vBxckclpAA3yE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2cdfc4a-1651-4d5a-32cd-08d6043c76d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:BzhiixSl1liDYeJxXYGPTKpWgLFGZFiRqJDPxmVDpBeQPZct8o8P44+6/4eSqcR/CVKSSOGRm3yjK68bEVJmUifg2LB9WtdcrApmP86vI+6CHCAIjjM75uZ7lY5tIxpGeQLill5m1OdrqiLediN2a4L+K+g18x534qbEuw53Tlos2P6tu7caKFdK44cnDke31fKyaY2XOfuM5c6f64BPQ6BXrCnB9RFgqLyYM2UEAl4HKF/zzcYC/iBPjg4eMY6AejOds4AA4dGE5ZyhIOjSWWT+l7/dwZsMFUYz7tP++GoH/ybe+hgfZHy4ocW6RCJ16Mwf6bMjlOr2t3rDYPy2mkC2bArlGekj0lXVtRDxOwE=;25:ajbaCNz4wBInBodMrTWiqZPynM+DP6f+0u107Nh07TeOpbMh68O0IJLmIFBcfGdvhVCvPLuwQNflqBqelRNvzuJzxd78/mEtTbcmeVtY7XfE+o9fqp04likXhl/SfKHFqfh8g0YBhFmwNb2p6WUrLCLna1SZkVk8c0vCUN3ykY4ZZwNgECqdfZkBup8OqfYhuUmvZqNpdAZ52rXx2ASvXrz6iYl9SwGWMkPJPyLBDwenC0tTD+ddiRRLLZnbx8fcDy2B227xWahAlaKujXB47/OJlcOCOLAnxWFxL11Awq/rHKMjBliY5CPfal3SwCnm/YS0DJWw2yVIIHZ7ZOBoTQ==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:4Y9be3eMGEP0xom/oQPksFYeKyf6gfZA8PMCgGKHsB2ziFURgwhElNlm/hdUHyDzGF/JFRwQj6NFmwfaXhVj3B6ACfSLRDCz0L7TxW0j8hV6uhTW2mcW/zy8ZkpnN6SB0wvuZrAeOBCwE28CZbupazI/RtVn1dBmgx+D/wr6WpfKgRQCWo2NZywQ01jml6x0Dz880t+Q3+uCTP2FgbYPyFZjIlPvVF54x42/TdU/Hv0=;20:qbJ5iQfgNkcwubXzDE4sNHIbcX/kgPqFQl+/34lDIDyVtsLbAiCacsHSdiL7x1i3zPg08dWMS3PoK4Q18db3N7/1OP7VnIHtcO6bjiaf+fmOsWmg0q7XZcZ8v0hLXrmTYJP5YK+ivqgS3sSkRbp4ssDPEYW7PJl83OQYPZpC997SUv44sojaAVCf9hPijttFEnttMJkr33UFryrKBG5HSKZVAvyMjzzUxToFG8VkJT2fz5ohefIrqXiO3ut/hnLyY8Pr6Oa595r3UXy/fy6Xlatal59ia9KpkT9nubp4f3BY8P1W9s4/CVQZmGV4tM2Ud6IJdi6GuKNk69nnd2a04PSSsuYGyPpfZwCAIwbmIvRIH4pmNkwEwglGM/1eyQ4lELr67XcW9tRe2muxq5Ly46HFeNkQ278P3hYVWyUWd/HKpdTFgwfU0dU1dgSWvURemnTjktZ1cxQKqr1oP5cYQ1Rqb/pBsFREDbapBrDqJrrr1DQAj4pAUnAkzYyXjFWb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3510B1B5B53118897268FF6DA73D0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR0201MB3510;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:xLjrNlmGiNT3xEcmW603Oe+Ng+gERkrsfPotgzt4IYeIjoq60M+efknrIy8GnPc6BEZpNNZ3UggvNwoSPiTn2tSmV35W5KUFDwjUWSGSZcUi1kkcWxbNScXhofVTjJjhoSQWUSYUZ1Uspa1tUrwWHO5sEP0zeLw+bkOqp5Nuo5/+DskeUO+/APaCUsdBJVqQy7Kg0mVG+DzgLvcjdq++8IvsC/q+65GmT7MkyWF77jYuNDzdheH3WdoA3uJLiNbQhJlFbBjeAZHRNge9siQcBAAK7pkaIapx+xPs/dOR+pqtOzy/P0X6MVNSBTuRa2N6
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:+sC9C4NGnzi+6mDI4GFuBc7nHeMik8PfPWoaE9k?=
 =?us-ascii?Q?KUR2zxNI6FqaukgSlBfK+j6wGMROmomSBySHVnQnrVvd+stI3Wflj/YaFyaA?=
 =?us-ascii?Q?gNT+Pt/aIWAG+c8fGy6kDhi2a1keLwpEh1nazmQ09cid4VyJf78J8xBvqdKa?=
 =?us-ascii?Q?0GAkbnmh/FBR7c9ahvaJaHKyZaGczs071JkLwbXV2lUNnC9MKLKItcBG7FST?=
 =?us-ascii?Q?u8aS7HHe0d23lKgia3uF6d/c8A/KzqUGe3SxtPT/2ix1hoxVv7JwBuM5Vb+X?=
 =?us-ascii?Q?+JlJ8Dr0XcGTXhg0a6TTzq9KGfBkvSy2JoJE2iRL3BkUAp6KYaTf2JHkhRgj?=
 =?us-ascii?Q?/aerPOcqk9GHe3si9lgkjjAMBNJa5sRtnUMNZS+jX+Ld1krsFgG77hPGs8De?=
 =?us-ascii?Q?kDwS4Ux/ULeT2hxebO/i4RWs6tG+kWKQxq/eEDweRGEKYV2WdlqC6yVwk8vl?=
 =?us-ascii?Q?jzeNO607y5ayvRuip844mU7uigdkWpJg9nR2SRSq5oxnhVH38eZjp5oip/EQ?=
 =?us-ascii?Q?+sb85Y3r8l+KIemi51vrsX/UHAdu8qil17FtrxTT9+WZN6YpsLVSWqVnZIO+?=
 =?us-ascii?Q?+IQWD1ojJzMrABVulG0Wjq96TlCf5m6TyH9P4V7igqY6H3LkzzbyPTH92bXL?=
 =?us-ascii?Q?kSohTOmDUX9dShiPTM+7+uCURR4hcn6R9AbrvOLD2z52SzVCF+RskfMHnIcn?=
 =?us-ascii?Q?pj0ZKco+2CsguezfENaTYg0LPjGHDfTT1BbIqxwr1LLrMTRTqUs4AaM/JxFR?=
 =?us-ascii?Q?TAhWSQOr//1EvDtpCnJRnKYMzeDhVWygmloX8oRGnfOP9p/FsRuSX5RFn8um?=
 =?us-ascii?Q?+HQYV5/thcddZi4R4GrANthrjhcOyqrAPUY0oVZQYWD6C5HkCr0+LXo2cG3i?=
 =?us-ascii?Q?z1DPJ4W+zBPoFYcdA/+i0d8JiQdnvUytg4/HgolE40FPrdI1qX5HIgVrP0Wj?=
 =?us-ascii?Q?MIuRqia79BWJqPek9/ZsB7SLcCUtIIDMxX5WRwdCh3gNdOncfDZU4pFoby7q?=
 =?us-ascii?Q?bkMUbH2iRxDFRmRkuDiSAQ0CervckrjcGMmcZE/kwRfSP3fNmGjqo94JoZ/Z?=
 =?us-ascii?Q?20NJRwfbIIupOQoiqRiV/8Y/br0D5J3hWJfaY05RBuAot1HHqkJw3rzsdPQW?=
 =?us-ascii?Q?4a8G1rv3XIIE2Z+XhUTsXsM/1m6/od1qhN1hClbdStWbWMlz4q4uPz00CA2R?=
 =?us-ascii?Q?kLg9EIkHKdbI/UHuqNXBqnipNMwBjAAVvmvhEJrv6slWKk1fvht8OIxaaAw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: HpS/YKdtNNIlIK74mE/Q9O0qnDqIvyGcwMEC9qmvvltnc3tSeDLeXrDXR0l3F1nc0uVttaHD1Cuh7RGdYr9skio8nUJ3qlVVj8fzrRk/FcYaWBgaE8AM8Y1ty38gNj4g+Q4BGVWaqT8mWt30m6hl2dMi02l7S22BjZzSLSdkekv/wtLNL1XmsBm8w6l4F+KGS5y6oqu69yXTxtHuzse34I0NAUszrm3oeh5mTlTag2j04I3BCRSEp+aqxXV3eSYD23giAAtfRJSrAMN0sor9SKD+7+kprZEnNtOpnLNUWyp/8Nvxlz945o2yjDVdAF7FgXUaERo674yixmAKmJp551XL5WbvI8VdyCoqA6DgeLY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:yL+lpofGiIrdA91FWCRiz+LFqeBUYNWaQEuGYIWMBA5alEbOopRKZoNClDFYeCpy61qBihqjvWYISwdeTBQGUMgpKQKRe2ITVCcwQu+Y+4mRBBYoyXzMOBAYTZqr1/vds0Mcu7WLkJFr8UsRfwb1MvkEHNNSDb1HzwFofRjCPxJbym8Mb74z31kRfhW6E8wZmTke/OLe487QsmGItQf92o/vqwiWl99wmfB86eB/hz8MBd0TTfeQ5y5pPBK8KYsDPv2M6JZkmoytv/b3lKI/3fhz/A+2/US9gknxgeOf4ccAROleZLoKC2tbkXo+W2aSyzNyRKlxGGyFgCBZ3utGyV5BqxCRrQ+1K9HbHr00i4YhlhKWmRxL3wVnT9KOGvzolAzNaHRlrqxYvPmhA2HiSoTlFQUIiL02F1PIXuiU9vGF7N7jYLnygX1wChD7XqQA5n4P/zn+IwTnzcjN/aitgw==;5:y/ciefo/rcX6pi3Ka/wvNCUhtRp3oFDHGoD90CWqpETtDK3tJ5BC2hHZ4JpgH6j8avcIWSP0dUygCUoj6+TrEMRzAHOARcowiEF5pcSW0Y9VVCcJK6ZK2vkvIb2ydEaAv13KAzKD0WltxqK/zaI4/x3eWRWbwQNPJY6n2MAYc0I=;7:20mMS1ehaKK1a/A+jN6uzbIcO+TXoz7u6dkOL29SLCPbCH3xlrUe4soK8jKCaAv2FZeE9YQ8DwLe7Ksoc4x4x2qgxqOjPc0udK607Yixc2+rl9/8L/oktd26rg6gfrgC9GsrUVZLGVZndqynMAK33VymTbJ6udxcpVSQkB1KmRClF0+0iuTcfMGOiau1DaMkQWrnuq2g+IBrZNPetZlerfPWTtWhCyqgCWMkUAnnC8V0elm15D1WkSvl1rlWHJ4r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:05.5508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cdfc4a-1651-4d5a-32cd-08d6043c76d2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming is enabled on BULK endpoints and LST bit is set
observed MISSED ISOC bit set in event->status for BULK ep. Since
this bit is only valid for isocronous endpoints, changed the code
to check for isocrnous endpoints when MISSED ISOC bit is set.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1b1bc14..188b043 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2413,7 +2413,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
-	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
+	if ((event->status & DEPEVT_STATUS_MISSED_ISOC) &&
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 		status = -EXDEV;
 
 		if (list_empty(&dep->started_list))
-- 
2.1.1

