Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF10C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F78F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GNA+RF3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F78F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeGYNDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:54 -0400
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com ([104.47.33.41]:51362
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728934AbeGYNDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmJICp8rIMxhQrhZK+JuM/6pKC2hdMb/nJu4r3Y4pVg=;
 b=GNA+RF3DtPDtqzCxOG52roi/UvOvK2bODcYyyk0LkMeSnFE+7YkkNnSYRxUayLhKt0qwrvpLGRWcdvsRtF+owVzBVCKNHgiwkULwAEVdY8vVgjEt+LNV4klVpI6hQ+H9oeR77RLgIa8BNgYe+xSETY8hVeegbjdVWtktbUU+GPY=
Received: from BYAPR02CA0062.namprd02.prod.outlook.com (2603:10b6:a03:54::39)
 by BY2PR02MB1622.namprd02.prod.outlook.com (2a01:111:e400:5267::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Wed, 25 Jul
 2018 11:51:59 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BYAPR02CA0062.outlook.office365.com
 (2603:10b6:a03:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKh-0007iN-Be; Wed, 25 Jul 2018 04:51:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKc-0006dG-7n; Wed, 25 Jul 2018 04:51:50 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpfo9027056;
        Wed, 25 Jul 2018 04:51:41 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKS-0006a2-UF; Wed, 25 Jul 2018 04:51:41 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 1871960504; Wed, 25 Jul 2018 17:21:40 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 5/8] usb: dwc3: don't issue no-op trb for stream capable endpoints
Date:   Wed, 25 Jul 2018 17:21:28 +0530
Message-ID: <1532519491-19502-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(3923003)(126002)(63266004)(81166006)(54906003)(107886003)(39060400002)(356003)(47776003)(6266002)(110136005)(8676002)(478600001)(42186006)(36386004)(81156014)(50226002)(14444005)(51416003)(476003)(16586007)(8936002)(2616005)(426003)(5660300001)(106002)(6666003)(11346002)(26005)(2906002)(316002)(486006)(106466001)(48376002)(186003)(50466002)(336012)(446003)(90966002)(305945005)(4326008)(76176011)(52956003)(36756003)(103686004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1622;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT026;1:5jj0xxG9JL9FWdHOVxgSOIBs9qiAyw20aI9pBndX5i44nuVNO1g0fXW3xXhgxbCvc+8aONW23wTjAXkIjQjAg23GzwvUdNWtNloPeUQsywI1jL9G04WZWDvdJ8UxiYiG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: def3443b-e7b1-4a1b-a631-08d5f22506a4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB1622;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;3:b4k3aOCVmOgrkF5UU33tYvBHV9yVtA7s3k0mEh5WcP6vG6Qo/1kyxUoWT4TQCRGPiO3deMOrJIAJ+seG1XQ1PekMgXf/LlxkaS0fGy9Xt678Td6BmX+lPsNX+P8jD0jFQzLv+iOpYbgKTsUhbwMjKSA/8x0ZwYt286nYg1qF9+7wwMAZ4Myh7mfj3EmYxkOR8ConBQXBJczbqKMRixHCiTAY427AGn5LEehXkFeVhvq/DV5CmFA8yBuD86glSfmcIKLV9+u5wHjl7bFuC+QXlOw3SlmZyp8kiuwVYbNzePAGPPkjkjg0zQjTmTx9Vys34k56y7Grhj2mnnU+aqpZ9G9UG+68uJvU6dFXsVbTcgA=;25:TO1tyF4uGPX0U9IkOXI8WgzV/AVPXbNoLOw8beDPSKzNlEEBkqu6fGDUV+Bt4QeJ+1QrygVXC++2ftESKg/Cu6qp6YPhsXV4nWT5hWeVyv3m0j6SjZWpkLX2tQWdRiloYaatyPiZ4PtfiMEVtUyMtayTTlpUpH4djezdH7IAIEBykrJmBTEPDWZzYhhBPLmGNvgthzVKYsuaPxjnxbd3qi2Z9Nn3D5CmFW7Pax/q6Ggs3ukk7fVdVoNkHotDwZsZs8ORLrujupRzVNqavCTSxYIJ5BbcNZYaRQTkt1iZKQdX8RDyzTy98KuSxaAWLzrTPY6F8k0duu3HUkf04aZEGQ==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1622:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;31:MDdGP4tdTuLzNKGx9sib1CI12yRq9/uiaZhLO5r4pqqdLDSONONKMsXqaltNDhUBmML3gHK5P9ovT8zPqbZhPTGJrm0DWa49J+0oFF8iydi+BpqiTPUwcpKANATv+GIoxq3RuJHQAkrzZ0hFhBlSnTrwCvD+ezxtYpfv+7neGEY58h2GLb2GQ2FIGWJE602YmR/RQmmj4wNYfziD23ipa2hQzSVY/iX8qYgJDeg4iWg=;20:0YeZnqFQtDrPXA+WEPeTSk009aFQ3mGk2hTke/fUEIF41tPeMZNELhDyMFcozI2nb+BeEtVNaCuW+PepfyXulUI1vLrHko56gbpKoBOGn4BfBSeUdYSN7V2tUi8SyqIWFAYxzZA7jQbph6ZnzticpcMtbsRjdjn3ymSCilen2JsR+lg9xTf337FcRg3khclyx4p6tTvzNmTMsKCPhNcz1iFfbDk2wwXjsf22AHTYwU/db+pqWrqIxwdP4IKssnyG1jZu5WbhNwQkg/qMzhtXqge5hL47CxBdVslwizhP45gPSfugZOO3O8NO9jyyhhlvAsfZsr7z1x8AJua2wIwqRLeLanZHi6wXYW6+MaTUBQ5N73m4QzmVDgIP1uI97jmvvVSEdi2mLHFz/vOp6zZsiQFmzHbkUGv0mx7uPKDsOxnPVrUby+x8svuPJJS7wFyhymrAKvis5otEOcqwwE+orS7JHXruAG6+4ybIzwtYYQdK13MDJn90PABcT8Um+qjO
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1622F3CA354421BC43C71974A7540@BY2PR02MB1622.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1622;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1622;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;4:m1ZjQmmOfmQqrzqapBHZpj3Ao0m4AIRuwvvWOATcIUfkp3pjH2y8dNF7Oo9OPns1iLid8FZmM6uPZeIJfyRTUJwfRn6HqfxsmYXNYM9Egf15vd6YYNvYv5goF1LdAmg0V9MeGbcIHEcGwQMrWmjUClXzj/znQ1P1CXmKEIYfxNLG1esQO8aqvLZ+RsWGFETKgtx1QVSzIc97q2jurYFio6+1OnLsAOfFNCM6AfNzP12C/FC6oeGk/Of8rH/Lind8IPZS29ZX1DuQdUipRhYXsNeZirEVzRAO02+fySySOr+CzRpTJP0aBb5WUROltsya
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1622;23:aZ6lSn1vpmAaa3/mxXoLbD18A6zbIjwfq2TIsDpyp?=
 =?us-ascii?Q?xycVM1TfwSFV4dsun+T4af/N2mM4td7G08Mispm1gMgXacjTA2WQlyt0YbF2?=
 =?us-ascii?Q?h/LoYHGd4vJZ8EFiK88Vkgs/yLVXUVAZ71/wsnchlJ0MPNJrZonfdMwqXQgf?=
 =?us-ascii?Q?xu8k0shc+xbCMXdTkL5oWZ3PBy7vd2cooC9tvBxb/Iqa1sph0jWLKwWd1Z0/?=
 =?us-ascii?Q?iaXVTnqmFLRMspOCnpji5ypumj9bol0/ArPzPRCU0KLLaNExkyLJ4jLAJ/cu?=
 =?us-ascii?Q?nP4PE8h+yV8jhsLSNwzXbWMXLJaIQRxBx3250UcArzPfLHwYMKixpTTs22z+?=
 =?us-ascii?Q?17a/Jyd9uDtsvp5KM/B9OTL+3AscDQ+Ezu2conVMLWQchctxAL/3OFeMLf02?=
 =?us-ascii?Q?0JDHg1dkKD6UlCBrIzz2I5v7u6t+Qb9zYF6ty91g/MN3ai7BH8cNIHsx8b7f?=
 =?us-ascii?Q?CaVWSLOHgvCk1B5SzCrsu3Ha88UCCp5M5OUrOCGJpqYGwtTGa5y9d8MEKDtb?=
 =?us-ascii?Q?bEvCe+vLRUVKH5yZdhJEDmb5rJiQqHMZ343Bby2Iqf516AEdwTPK5eEBrB96?=
 =?us-ascii?Q?NZ8W7shT7ObO/Knl11o6dpaG75mB4s7D6GjoaRACqx1By4mJvKZJJlDskyhG?=
 =?us-ascii?Q?R+TSaizKMkjuAWoEIA8Ko/i1yD4b3Uq74ImACusIviPY46HyRjtDBXE7H148?=
 =?us-ascii?Q?TmsC55ZBU0V9KhwOqOsYZD1L21RxXqn3/XLn8Ilx5hcdWB+uHWEORGqedNgS?=
 =?us-ascii?Q?H+jNA9PY+b3kdZs/nDcd6oPBQoHjwh8eKh6QzIAaiSY0HHmfCujD6r2f8dm1?=
 =?us-ascii?Q?wA9XvldqrAsTQNZ2/2MAbucSPDSUhAanzmqqhrxWJ2qMh14BzaIaMoZ2irPb?=
 =?us-ascii?Q?3IZICcrh0qTFzuaLDUiEqYzr/gzoYqsVjJ0d7/HbmGll/qPADCIMQQL5hYbt?=
 =?us-ascii?Q?7hxAgCr26aWJ1NfZQjt3CmA1L4TmMeZ1pTBddMTE4k3VcK/B1PTXjwmwqYKw?=
 =?us-ascii?Q?jTw7nWi9PwJAXL2NuhI4xS9O9VymWPezof2o4hrrdK34S5Gj8o1tjPpHF98G?=
 =?us-ascii?Q?l6/SWFEgeaIXsn5cO2EPF+gCtXK9EyiejB5hkJ17UFTHyWHcCgHFsMOOX5gx?=
 =?us-ascii?Q?IaMbOVpgSmNy0oFWJE9H9swZ7o4i+BqpTQxp2Q9EydYtjtMvDmylmOjbOIEE?=
 =?us-ascii?Q?/Kpoza7vqpTUG8wz1tJoYRctb+lQaN9mjyt?=
X-Microsoft-Antispam-Message-Info: JAUjPOSCJd4Z2SaeAAAcJ6cmUJMxzXUr2+783E0CCsUs7JiSvigqitaGijuRarJkUY0GBJrCvQze7ZiSeOdsxCIa//se5m9ACEC5ct3bZmVAq8NKGwEhSI6+uDKbXBtf2jUdl+WpM3JkMHnji9UjeIb13oGoqjjqGi8oGYv9p2kxmtnwnnXW2d4SuWsuJwNkrvLfWIr8oMyxdD8GzLotlUeiEo8/Vz0rQIEGTDysnbkd9Ox0WIF2PswIsoGXX1XuXoyqlisMiT0d/X/8dl7NEIZnSoZsn33RYX/9JOoSMCjL8zeVFqX+FpIaBeJb7/k9zImHeNhxmuIHURsQ8LGeoEKATrjlO7ZssUBKRdLMLTA=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;6:gMl+ai+9w5OujvGy9O+p1PdimFaOTtpcofDjusrB7WmOJH9j5aULvxLRVbkL7hnjlJOIfo3D/EaNibsUouRdHYGClT5FrflbUusZJAHqSoIBRq9l57k0gVGZH/LdghDqauCaZWEBjZeCDF4z0ISFC2LBA1eea4zUu9E+AU8O4AsZl5aKjP2esDLVWz2pUp69x3aSxCxM8jr93WzLIVp8lAWIdVS2tIQ33MxiV4zz+tFTpnzhF1X2SC1X+h1+i8qvUlScBb05FbKunflH+CffBhlTsXFd2KQ1Zux/Xk+4RNxK424h0z9A3nrcxC8aR+Wq6sw+cgQIUZXm+x7LMrkZ0JWfZshNo6sfjzU7AJFiNYiWBfNpfLxZ3WjktLfee7eStKKbwr809jqjipupxJOdWPMW2QDDHFmhTtjOnhGpRIL6FlobB/wSyqfZjKpKBFaOxgyIZusP3QKfpapEJwVW1Q==;5:Oe1vqFUWYQZFdHTN69FfZsMbn7mPb2L0NZ3pYwSOEbyXzir33hqZkLFw2M8q1o+U97e6c2XDhaNNUhRSKQFOVe33RD5USznTNFj8zI69C6sRQojnx+skjJlUy8LwKsK1YH9ePxS4yiv0N64eDAgrxRAzpda5UU7FFXJ5QV4yLQA=;7:+ZalvdP5KJxP6PKr4yKBxpqFsk4Pa2j6xML1GPdMbPKvwfREPtzTBW7LXWE2j4zVRcl5xIyucaoXYi6FMdapt+BNBH4j29F3XmaFfZrH0SHPzf8V+1sJ1Qa1XhQYz/YMVRae9aKZU3/ZF/Ayy5gM02GLxE7atlZTM6FDFV3TJqCp5TCxlJDnCrQqyVkQ/iukEY2aDLxkfEAR/ewOpyX0VJofwnK1S4dDbXq7/OQa0SHRGxFYXrt/3tAISYr0+cLD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:56.2399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def3443b-e7b1-4a1b-a631-08d5f22506a4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream capable endpoints require stream id to be given
when issuing START TRANSFER. While issuing no-op trb the
stream id is not yet known, so don't issue no-op trb's on
stream capable endpoints.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e2ccb55..af8d470 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -668,7 +668,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
-- 
2.1.1

