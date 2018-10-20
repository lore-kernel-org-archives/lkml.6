Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBBAECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B9621476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JFLTR6NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B9621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJSQzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:55:08 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:61360
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbeJSQzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx9i9M1/K0s6ZbRwOG0iHRlE76Qy6pYwwDG+swEK6M8=;
 b=JFLTR6NCsELEOqd4aOSdZn7Z/thEMrf97mvMItldbWz1etq3auHhhH4Dzs7Zjxwb5+ZBdSKOlVI6xUJPh1I+dweN0EPm5buei3xPSdlLcfc9cueCr0byaPKKhJUqbw8aBYhaIdFcuiH499spOb1UEhUD0AP5cPrZvyrkEsUcF9w=
Received: from BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15)
 by DM5PR0201MB3511.namprd02.prod.outlook.com (2603:10b6:4:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.29; Fri, 19 Oct
 2018 08:49:56 +0000
Received: from BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BYAPR02CA0002.outlook.office365.com
 (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.20 via Frontend
 Transport; Fri, 19 Oct 2018 08:49:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT063.mail.protection.outlook.com (10.152.77.121) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:49:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTj-0004BK-0i; Fri, 19 Oct 2018 01:49:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTd-0003Y0-TJ; Fri, 19 Oct 2018 01:49:49 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8ndMX000486;
        Fri, 19 Oct 2018 01:49:39 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTT-0003Tc-7X; Fri, 19 Oct 2018 01:49:39 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
Date:   Sat, 20 Oct 2018 14:18:05 +0530
Message-ID: <20181020084805.29103-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020084805.29103-1-nava.manne@xilinx.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(50226002)(336012)(26005)(2201001)(8676002)(9786002)(81166006)(81156014)(77096007)(2616005)(106466001)(426003)(476003)(446003)(63266004)(47776003)(36386004)(186003)(11346002)(305945005)(5660300001)(486006)(106002)(8936002)(126002)(48376002)(356004)(6666004)(2906002)(50466002)(16586007)(110136005)(1076002)(316002)(7696005)(36756003)(39060400002)(51416003)(76176011)(478600001)(921003)(107986001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3511;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT063;1:eQT0MEjW//LqhyIORdnIP8GADZvQwZ4lTgkw5Zn5XM0vLPvfYEEy+59ylCMy01CF1EowaBVsY5AYbocOcSwEw3eMl7vUrL2qiVnZx4RDWm7rnYWtw0uuX15agK669ai1
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e78403f-1392-4104-5445-08d6359fd807
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;3:fZ9AXYjKRs+KFPBTm21dvDRKBRBV8OTpcqEimQCeBACOfZzOiAaUmcXwXwgc+9rzDyK8AwsNKfbz6GHj5sJ2jPct0ARdhGGXYpCINROzCxDQY2uhMV016vYXdJ9H0SWli7L2pODLkqyb7JnO4zlFp4RFE3Lorqq+OyZJ4a2uger1Xg7BPzJbOruQHxbnPz6T4Q/lPiMfg5YJZrrwPGjsM+4lv5oCxN191tYsHhG7fgOI/cf51hPHqrLTWdPuZ4WHxeEHr061mdfXThd0kN+4oK1d/GseVh4q5H6cNOKUugCmpo8/9CaXE0b5TViqmrYJZeNDZb4vfwgif0snN/1UNliZ7SePnuDgi52mqYk8WVg=;25:kNJivHTKj7KuYBpH0ONqdVplc4Hq+YwyRpr/Tfcpym2JGxNImbY8DfqnA9isnJn+a9F2DFIX25FFpS/xsln5G6G+mj5cf0mnEyCsyPIWPmT9hdT2xDwt0ByDkIeD+l3pHmTdMEbpPPKNUa1SXYOujyr3axnqyLwfXBBpIoGh9ocBaPexQ1srGvz0pK8ayKTbATY61wWXKB0Y3Mj5+jK+Y/Wjerw05L2ESfQOGqjGQ/NVZ1ym/sbYv01gZgXX5Twdt/0BxSQcwfYaMn2tInqasBJ4CNd/s95aYhCHBNecruCpJVSLiI4MiDNdRqJmAnBIxY1nXNtBO03OQPQdrwTqsg==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3511:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;31:pULc3o6lHynkU9/ucfUglVTc0+pYBfhB4DZfqlH+fYzIKO7Cr5Z95x4lxaRusquU+aGGGcM4KZYP+lGnAB2Q6BpFkJBdynGLsuVgODFWKsmB4URzsq84Za5I8EiZ2GcOysJu3kAzgMufsbCBMIwCur1XLOv8hqUoChHjUsov4YHCAKTP2k0FZN43aT5su2yOJ/XIJiNub/7HctUr92Hat+aVaXcCYFoDX6SB5HK6ulA=;20:6w+Ls2PwLq0UWVXgPtPDN0rNi20DT3xQUiwOkb47D+qdkD5VvZTczFVqESaNIMtTMkzBHprKJPU5qnUfLLPmN9X6aSg1Pwk6GOcdzmWpS0fbLusnCDn0HvdqJ+MJGtL/G4onKAavLl11Pvk1pchfotxXAdfnjxJ/V1RN51NNLsNs0uGNrd8xbi+vs0qxSHZ9dFdbBZdX6/zhtPTQCm3yt6Y2yLSIfYfQyTrd/4hgJIlX1Bnam+AXXL9e0PrVc+Og1ZYUTbpuUHVp+/mPRpplv4riO+5x8rYRwMviva9FrWaPgCmqtm0DmQGrPFhbz0dPQZ41FJ3ycJSOQ6dVHknoeoTRGw4y4g7xSQAPu7pqo8vmdbUku09UGZMsh39OxLL2kAdsJhutQWUuUzNVZalMf4QRxIGOLWNrxNJA08hwkUZhZ1rK7VISiBKcukoGFJRgv6ZG1KgumZocjbZpU114zVj38MMD2PV03RGhyiOCOkDKixuF53Kqu1FIcDNHOR9M
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3511C389D630917C34A797EAC2F90@DM5PR0201MB3511.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3511;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3511;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;4:Ds9QDYw+ol3l+qzptQQwyPshIbI9oel30Wl4v63g/GvkbgX9vsjJwa70LLR8uiE6I0jPZeuhC6R4oOaL5Oao6Cy33yyBVMjzZSPECKBXI15mW5rk4rfAufYpuj57IM5MUB8FM5VpPPCoQ2yAYCbFRKZctNB3TjR/O0Fu4n63eVMFX6ndsXjXtphbPpuXmyaxzPRc5nHwZXnikW9LlVVbwIr8fHOOJV0wlDx/i/MbIu+ex0rJyo6keF9P0+a066Jt6UbnFIZGVH8Tf1HNZztV8TNI/ENalcl5nF4G1/LHi5rpjRLG5D12UJIZK2/YlTZs
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3511;23:HkLsI8Kpbv8SogyZfl065+6kMEtAzRz5byxgUjI?=
 =?us-ascii?Q?I4t3HCyBu3isY6zw1/b3P2kf2sbYwGyziAUNZoNSK1wty6BQoUSqbz+F5d5Y?=
 =?us-ascii?Q?Y6jxWFX4cRn+KAMjcSV8n07L0ev8rnvLnnnltHgSgKbbu9+HwzsYFi1gkLD+?=
 =?us-ascii?Q?VSjqc4eV4tCQxerCpuyZVeVjScFM1DSgquZjHXdHAn+tJYe12U4XRuPL/hbX?=
 =?us-ascii?Q?FacW8badZZPWFxHIF7NGFAbO41LNOJUgkBTwilWcnf5CrlOK81BrRVdS83lg?=
 =?us-ascii?Q?0omlZ6ThSuYEdNQwFo3sDBkqyoeYkmvLVHWtD1Jrni+riw1/eloU+sejpzWg?=
 =?us-ascii?Q?Fr/l5uc4jDs90oAaYuTIGtRcChFmHwknfgf2aKXJmZOCbUt1EUmM3I7rh+UH?=
 =?us-ascii?Q?VhwJJjYa3p3DEB+AlXOl3DuH9A+08nln0QxVXskKn+BgubllfCLDBflS6Ioj?=
 =?us-ascii?Q?kCFeyUpGUslHDOfYGmJI8atom/5+9vEnzotWFrzgK/KhSp/r7l6q7/wlMgh+?=
 =?us-ascii?Q?cFqVGUmTi7cicfv/qlCDZOc/Km54WCaYDO/I+0twOOoDcnY+n+f4/WpWl154?=
 =?us-ascii?Q?NHs6VklbIrSyJxBs/E50gl1lRdI6MCV6eGpGjt6md7l443R/4mcYbm7GgyJH?=
 =?us-ascii?Q?CymtI8gXXZg6RKOwBf5KzVA+9ECgaadpCVik6/zRMdk3JP0vqNc3wox9So8u?=
 =?us-ascii?Q?07anOIhtsuXEmGW0SdAzijYhmHUuK9qShdSTsbsoPSir5RDLkqNpbehRbb56?=
 =?us-ascii?Q?nhdNrPRrtpNiFoWeLts2NaAPToupndcGS/AOK89Vqt6AbUQ9WWD42uzN5oew?=
 =?us-ascii?Q?G03cbAtgmYJVcfYY/WOz6mJu/t3G4GbbZqry7Dxixcp3aa6pWuWc/HfeFcnX?=
 =?us-ascii?Q?ibpk3PBuTT6/+Px0KI+bP2w1yhSofQO0aY7GhFhOHkjvC1ZntREeOfGkjvjT?=
 =?us-ascii?Q?InVdLC2RGl28AqYqpHUCiuIDI3gJ29FR9oB+zszr/kmO0zCUdv3jPJM35rmN?=
 =?us-ascii?Q?IHvBX2CpexSy95DrDYXBLshlCJeap50Ubz0auRsOifr7JxOne/X+hOoqrRoU?=
 =?us-ascii?Q?H+vFZbF3nKM7+JK8M8hK2ZJTuFx0dAEG4PWFVtOEBecDUATrSNxtGXNnO0cI?=
 =?us-ascii?Q?9kvG+mI9XDwC/+zdTZh3adG8ByCbd4eY/K+ZhbkH3a5KnHJs6+ugSwC1n+kj?=
 =?us-ascii?Q?8Cjf+DFAhmKj1nNg=3D?=
X-Microsoft-Antispam-Message-Info: /pfPTOlwMnMAVg1pFDSTjhqJWImHQg6wJeugFrJldOgQz+DzFPVFjyvHZbSKSRv/M1iGy9fB9MbV0pdMEDaJ1U8DaDcoVloyAHzMrrTkXwmfCZS2GD8gyYIocMlATVLHObV1m9FDdq6ZbdE8j5JSjQEZG1Eg/UE5bSRKK1zpsajhjuw6jAbOmbwb4tS1l1/X2skJrKDu7+5HtY1UL+aFYwlHdItdlm6Wkh1pZm+gPo7326vA8ua3YkhseQjQk/OoFyDKrX2mPBmxGwgXp3mpkmphPKmLexYGMp3IYN+P8xQNPGgwYxzFuND9F4rmR4MivxglISW6JO8mzTMQ9gcFctGXBZFA2pVC0/YuLadF/bo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3511;6:x5oz7wbF0XMPTjl6DiqOU5SkIauDERlgwQlgEaGpObSyub7MJaKU0pbrjxO1n/dibv0gD1Ixvjj9stouEusv6iKc7PiMCIESmXRhSu+kLIvh0keerRcjegQbUlDsekflia07ysiDz9MN5aLFQS/iFawkLTS2a647RWitLCepTIZHqiqV8PTxDTnnwkIv25EYiCVatNrx9pABZBBfVksRrbmCOCrAMxRK9C4J71+LvB7aiTRqWrMhG4dNowHfE2fCxeYM+T001hQjTum6mpTel5UmnyFzWsCqXZpLJVlvkN3Z2D/TONrW2PvVWqw0PQgi/dARQlj4uvO4RIwCzMG/8/9xoXyu4qaqNJwbRU9QTPyl9qAtOrliKz4LeD4L+m7PUGr+XA4TrQBsLLl510VPjtUhy6zGmKIM0zTQZK2LTU70u67/I50yEoUQP/hIUrImieiPvc39kH2hjYgcT8mmqw==;5:o6HdFW9CuGBAkzFjAjL17mQ6du1WvOAKBksu4lf37iEolESkL74Yv9Z2S8lzxUBMmdIqvQiUCjKcmGy+f/O2Yd+SlWwsmosxduqHm2UdPTS5v2ZT9v0VJ6cXLDbP+DoFW8uTaFR/rxlioHgWTZMtKoR16oVAj1IzMhg8lkzGMns=;7:qNauXU3f2p29KG9H/5rMmWOGX+pr0NDlc/YGBn2bnyzZlJhUPDyUNl+kl13N3bAy0i9ch3RhW9ZUPpu2VXUVEJ9pJN+Jt10+Ww+V9h6aGMEMNE2Fiu+fy85+ubvVXHVOeRpXU+ROlJ3enOoK6Wokgjr8/MRJtsM1LfcJuk4RVfTxPcqcb1gBVm9cZCFjqZpcCgKCACfR7vCftRrTf2Xp1lx+m34sEbIvSBkrddLrfTxPtJW7qrX15KPzwybuY4gH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:49:55.7434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e78403f-1392-4104-5445-08d6359fd807
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FPGA Manager support for the Xilinx
ZynqMp chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None.

Changes for RFC-V2:
                -Updated the Fpga Mgr registrations call's
                 to 4.18

 drivers/fpga/Kconfig       |   9 +++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/zynqmp-fpga.c | 159 +++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 1ebcef4bab5b..26ebbcf3d3a3 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -56,6 +56,15 @@ config FPGA_MGR_ZYNQ_FPGA
 	help
 	  FPGA manager driver support for Xilinx Zynq FPGAs.
 
+config FPGA_MGR_ZYNQMP_FPGA
+	tristate "Xilinx Zynqmp FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
+	  This driver uses processor configuration port(PCAP)
+	  to configure the programmable logic(PL) through PS
+	  on ZynqMP SoC.
+
 config FPGA_MGR_XILINX_SPI
 	tristate "Xilinx Configuration over Slave Serial (SPI)"
 	depends on SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 7a2d73ba7122..3488ebbaee46 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
new file mode 100644
index 000000000000..2760d7e3872a
--- /dev/null
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Constant Definitions */
+#define IXR_FPGA_DONE_MASK	0X00000008U
+
+/**
+ * struct zynqmp_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ * @flags:	flags which is used to identify the bitfile type
+ */
+struct zynqmp_fpga_priv {
+	struct device *dev;
+	u32 flags;
+};
+
+static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+
+	priv = mgr->priv;
+	priv->flags = info->flags;
+
+	return 0;
+}
+
+static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+	char *kbuf;
+	dma_addr_t dma_addr;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->fpga_load)
+		return -ENXIO;
+
+	priv = mgr->priv;
+
+	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	ret = eemi_ops->fpga_load(dma_addr, size, priv->flags);
+
+	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
+{
+	u32 status;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->fpga_get_status)
+		return FPGA_MGR_STATE_UNKNOWN;
+
+	eemi_ops->fpga_get_status(&status);
+	if (status & IXR_FPGA_DONE_MASK)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops zynqmp_fpga_ops = {
+	.state = zynqmp_fpga_ops_state,
+	.write_init = zynqmp_fpga_ops_write_init,
+	.write = zynqmp_fpga_ops_write,
+	.write_complete = zynqmp_fpga_ops_write_complete,
+};
+
+static int zynqmp_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_fpga_priv *priv;
+	struct fpga_manager *mgr;
+	int err, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret < 0)
+		dev_err(dev, "no usable DMA configuration");
+
+	mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
+			      &zynqmp_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	err = fpga_mgr_register(mgr);
+	if (err) {
+		dev_err(dev, "unable to register FPGA manager");
+		fpga_mgr_free(mgr);
+		return err;
+	}
+
+	return 0;
+}
+
+static int zynqmp_fpga_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
+
+	return 0;
+}
+
+static const struct of_device_id zynqmp_fpga_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-pcap-fpga", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
+
+static struct platform_driver zynqmp_fpga_driver = {
+	.probe = zynqmp_fpga_probe,
+	.remove = zynqmp_fpga_remove,
+	.driver = {
+		.name = "zynqmp_fpga_manager",
+		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+	},
+};
+
+module_platform_driver(zynqmp_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0

