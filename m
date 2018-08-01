Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B84C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B36D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G3y5+sj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B36D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbeHATBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:01:16 -0400
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:11461
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403811AbeHATBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/YLddCwqWOYLbFELmo7npsj2XC8xBXch6W/yzlPNc0=;
 b=G3y5+sj5vodCDxM/XeMm6Tb3oEzueBjbbh6zeBW9IQqkVIvwMIDLvAYtYoG70V7Q6ePKZecXK4pFI40+m535X91rc52rn5/41CbOAw16X1JUFqSQhGWeH+EDDsFtDQ0IaNanE9kHoTiDpHCK5flY+uQJdfRgPdGm0yVDjapxrEQ=
Received: from MWHPR0201CA0061.namprd02.prod.outlook.com
 (2603:10b6:301:73::38) by BL0PR02MB4323.namprd02.prod.outlook.com
 (2603:10b6:208:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 16:49:45 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MWHPR0201CA0061.outlook.office365.com
 (2603:10b6:301:73::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Wed, 1 Aug 2018 16:49:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 1 Aug 2018 16:49:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60556 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJh-0002wU-JY; Wed, 01 Aug 2018 09:49:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJc-0004si-EN; Wed, 01 Aug 2018 09:49:36 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w71GnZTZ001199;
        Wed, 1 Aug 2018 09:49:35 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fkuJa-0004rx-V1; Wed, 01 Aug 2018 09:49:35 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/3] PCI: xilinx-nwl: Save error IRQ number in device_node private data
Date:   Wed, 1 Aug 2018 22:14:47 +0530
Message-ID: <1533141889-19962-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(189003)(199004)(7696005)(50226002)(54906003)(36386004)(76176011)(356003)(305945005)(51416003)(316002)(2906002)(16586007)(478600001)(110136005)(81166006)(26005)(8676002)(77096007)(81156014)(4326008)(126002)(11346002)(476003)(2616005)(47776003)(446003)(486006)(50466002)(8936002)(336012)(63266004)(186003)(106002)(36756003)(106466001)(5660300001)(107886003)(48376002)(6666003)(9786002)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4323;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT040;1:G5uvWzAIeUqUvv3MAQVEQ2KeNI/Z9YEuonDjnsZuxmgFWCQzRpnJctUvmeqALzBadlOZ7byWnmSeQSY1Yquu60MEQVtgl35v7jhOIYiakFYeqaHeQnJ6dkhpAroDzvPE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ddafdd0-a283-4cf8-e51a-08d5f7cec81a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;3:sfcPVhpbow4uiqcnPBHgQ53x1hRtA3Dc0AY36u3MhqYiMwdCxGsb6XxajrebRP40KAs0upsJc+0WrW4d2m7/SefQvXsN4hYawjzGOMf/e8++ub9+57pqoWJBZDqYsii1z1F/AFYDpj4brLQLAdovwUwFViF85QVlFeiH7EhZMpXrGJLXef3OJ7amOPkMZCtvUVeNJaEshhra//Y3N7VznXQdmacpL+dPU/vf0f7RjLIaO0eCYpw/irNDeD47QVYtCLX/RIHc9aXyz+v61oOo9ajObbIFENxiRryTxWIxm1AgqNNgEKEfxmCWApIK8qT/addNgIenrs3VoR+y+n/9LDCD5XKtdxr3+Qz11a8zr90=;25:Bhdtz2IJHuTNBL+VpGYbM8MOppXqWo+vhVZDZosFaYHJ6K5zsJrT22P+j9IAMKbU0mBEBAxIK5tknJ3CTP7ByII+oocNHYfm9ocZvJNlEBC4sNCPnOBgrXVhz8eT1LKhlME+/ImFHUjUq2QZZm4k2/7jeF/z0g1inR+Lmi0/oO62/US3MECs9xqJMIXHsavkBjdEMm+tz2+ppwrQxEMrs5r47wfzQNIIb0ak18RshhTrnaGKwa51g1yVuNLRCEP/Nheo4Pj2XGHOm+LxrOEV5f+o4L7cvnOGgfeSOrViWfI/lwyTqtKIhYGHqt5lj/o6CqYkYWLYbURtyQQPmYJlEg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4323:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;31:OQTG77kpCVORdAz8/Lt1eiD8vQCyBi0RoFK5SiZ9gWJ3rBQ7ZxwhbNgKJAJ0RiXaTFMbtICar9RbUGldwo1beb94/yF/ARHEVlaO77ySIFDOdM1rk6lVFXGUmVbPvj3cZNBuPGkbAvP+NKx0fx4mEMBgCgDFIB7bu7Pupmd2r/r6x3cxm5T2SB/OMhC/QaKrqD9emMOlFbbfNTvivwQCxycOrNw/BdFvOaIUZ0NzwA8=;20:zAN2wQqXyOMqnGNA/z42FvZz0omZeCQYWuRNygjmqAwp2EINbFQXxXyXles9lYwiQ7WBdP+ndWgw1mCxyM5CKisYzH/sBhh1u67IPNbQy1X1Gq6NoPd7MTXX+yzTO82+1rKSI7AuSa+S039reuTt2TbyPH4H4/XveFIMdCJvVTwkP6s6bnWnW8KEfAt5NVCQK1I96gXVIDZ+CbU3EDtzenRuh/80P7xTf7Yp92yeZvPA3vEyStIFPx0JqzAtrvSbaR4Sb9D9OgJ9LHX+yjKiX/4rZ/k6zK9sf6iTBX+D9tUr0/tmjS4yjkWi4/oykgXDf5jrcgt0yir7qCAcIq7o/5S0ehwgcApbh/jghaDpECowi/wuMdSUtV27VMj9mkDMcaCNs4JJsO2w8JSUsNLGGTabl49u/B/Sw/MEjJ6EvaQbI+dNsRM+R01UAoKlmpNC8LVEaKXvVN5+vZi33LcMTvblzBuVhOhSpM2gNxuTsiuHBB5xg73y0ekjYPPthr0W
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4323B1223D5ACC6E9C86CA91A52D0@BL0PR02MB4323.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4323;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;4:rKF0WrVdjo/dG4WNjzKzpom2jWIT//tJVwOH/h6d2vlM1JgKykNXjr64PoXF6i6i8jlufqkvXF4R/JkretBSOidiGkkVqWuuOa/fwyFAbOpze6JkxeR5lQeygESaq+YJcg5TXx/shiG1blYqHlLpMyym/YMxInCpesB87vIbInf4/kOq6r37dr5hQMiDGqgWxEf7EIbly76Z4UMm+xwrxKoWYuofXzYjHbLjboKZ1IX9/EbyMRXWxSaDymYXoM8suolLcztX3U4Kir0t6RkHbn2Mrju83wDSFs/eAnjHUJ44HsfPuNRZbdrfz+R8lgWySV03OHWGTVTlpHpEbz3APKj8FzKMeUXfA04E2XYF0FU=
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4323;23:lRboK1WBUV3BB+G8XtpiKLf3NANB4qpdi88B9Fgwx?=
 =?us-ascii?Q?IhY/OmYaJH4ZMdRlSU77QzRkyiUCdxmeW2KsUMdGYdOxicFHM0tZPmPmOweC?=
 =?us-ascii?Q?Gv9mQ31hzLkj+kMqqDCLt77sOFbNnbsgz4Y6RqRUMZvkLkc8RxuXWIUoic/l?=
 =?us-ascii?Q?ZgFYs72XIpmSNoUlPdZQIJFxZIIenPdkbc1dYfJgfQOPcXIgnYCS9bdCdN3J?=
 =?us-ascii?Q?7R/GzOsd/n0CLVvk1mNjZHw+GvKbe5CdWe8oQfW9O/C0dRCODBmO6LYbFZen?=
 =?us-ascii?Q?/0+bGztWaefJ1Mg1t14AWpngcJvDdM59+5InGJMfre5mkAYC0Tew805JVg/L?=
 =?us-ascii?Q?qA2mjwXrVYwRbBkuHGzN1veDgQDLQYNfvXjEHxxDQOUuXeVaDNRP35KmOhoa?=
 =?us-ascii?Q?CSnp1JcR/9lBuaSKVr0EmYI0y+qPjnSD8FisDHMB99agu7cZKD/XuRvcO+XD?=
 =?us-ascii?Q?Il7a+NDYBaufFvbJCrvq92228kPWW9w2ZOn3GmmTeBGK1Gq3mzb46N2uMdN6?=
 =?us-ascii?Q?byVV8oQxqIJj8SI4MQLJkHyRXp5rxV5G0Xe+/FIKyYw+fwbimvvBFtyFx75g?=
 =?us-ascii?Q?UhE0owARYjX709+lohmlBg6690w/WN0jv82/S7Y5ftx/qHEssbrE9SkTrTFX?=
 =?us-ascii?Q?uRZGD4Jg5qaOV4xw8S1DKHYNOd4vcA4s3stfvAAAZNM02PzIM4qPpPRQrzYe?=
 =?us-ascii?Q?P9zrrfoEJKyJayai7FWRzbFjePCbAWpAbj3yxmD4FKn7iwd2as8G4bDR0sjN?=
 =?us-ascii?Q?8XVAh5HQkXbd8637cl2vj4vf+N9qcwmfSgeEvcD/Dl1isq5MKIs47JuIVBQH?=
 =?us-ascii?Q?whkemSxBXfKlUkzE1quVX2b8DKMOEOig92a65lFwLao9LYdiGKxnVrp+a/Zv?=
 =?us-ascii?Q?JKOGpIMG4Bbk+mizSdijwtGBLT2xEKsuYLKEWm3opBXyZnYaxT0YFrcVj8mr?=
 =?us-ascii?Q?MR+BCZ+V6RnDfQKksXEjhlsdomaAImg8Q7Pt4uQK5qLKbeCZYW2OfsowvSmy?=
 =?us-ascii?Q?cggBQCYsCmwty1x03HB7HByQL5LLU0oVACnUDPe820k5krPSatbyN6FuEBJx?=
 =?us-ascii?Q?6SCv9FfHEe1IznDluCn8eDQpCaDR9XcGxxHWXefiuBIkZtcRScs/0vnr/wXa?=
 =?us-ascii?Q?1sqrIjXrXmYt39kBq4/7AIXw8y2gavC?=
X-Microsoft-Antispam-Message-Info: WMx1aOp3W4GlQNyl68dVk9hnoYGPzUGHr0pFM8+4r9C+nbDTVsMUbjqKTIL1nlgmjBbvHqPw5W9t2kmHMt00YRU0SQEPUyhDRZLQDr+zf0g8kB99B2vxO5KGn/O+pnVHrfdM1pO9NsYaluLeTSpm0KnYiv5lfUw08yRZzWj4v8DeLXSZVin3vKSlMnoSKGTaCs/TH7be3bruvPT+oNaLv1jgNZNKDjS0XBr7hteVUYVK4k4hGNcnrqTzl+MjIHlzHcbe6exs38Ya5QCF0HMJ0adTQzdRwEO7lZS4zpm+2Yg1jkmnLt4S4JHoVwbhqk3aIG/cVhLB9Vlctbq8wCl0HXBsilMi1yq12g9oC9A2fj4=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;6:Ev/ullD2A2Aikqi0R147fO2Pdi3FGuReqU3AqZ6a3I2NhEQQ1Q9PUTg4x982fepHI7is91k3xtJTrkCADXLUsKKhvAMugev2795XNbH+q78K5ZVUgjtLXX5VdkNq90E5/+BGbkVqL/vqFQMZZ09g+ZwS8iOLNTnnIRtSMq/SQebdaTniSuK4tdK3Dm/nBtie6KSCNXSCB/Cn+UkMAxygcD93+djgZzWx9/m1Wh2A6mf7H+HwuFGwYqO5eetV0fIwi0Vjul0jT8BcmzYOqaB9XtFt3w5aLx6YXyLDhVklHXRFXR1Apacsu79djpe5/WHwgDbKZfEhQsiGyUtlmLZLi8f+b0eRuewqTXRlPBUdtVUltbp5Tef5uQ8NYs+iveEwiFvPUKOGf2pGQ6pdrmJB0l+B5+5fEyzR01/OORbERi1Bd7S7iehzN7HdWvjvoqJ3jzEOda2X4JrGMLZfWifjoA==;5:S+zsoJKRPqWg/A2jJBRfhrPMTuqyrI5I65a8x7XUAMtLrewN1cdxL5bcYB5FzvA+Msx1A1MbToed3FGna6O/L/ZQ9UVLX4gj3WeO6xO37hA+Mg9Nd6D8MbDzpIm+ElcuBw5XXMB/nNJ4n7OWGv4aF8RZfOVDUnYa3sCMMW75vrY=;7:ryBQ0rIOhPw9VLBiPwuV/yo8mDislJmRv2XHMNrhPFjnC27IAuTjcCMikM1OGGf+k+tIQUIG7/jFUjBM9m1o5V29cD1dFyCIUpMte6BLRB+qOdGOdL5iDKCvZmO0FiaRiwat+mQu+rvOOgqpbf8jAHWNynbXnJFzLLiaNlFJrxiWxodvOSk+nLrEyDDi6nm2jTWUprk1Eg59xKt2ERFkRJUpYRlYo+CE7LrJ8clvKWrlyGkeavwy4yqwyWP4hyPt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:49:42.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddafdd0-a283-4cf8-e51a-08d5f7cec81a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP PS PCIe has dedicated interrupt line for
reporting PCIe errors along with AER.
Save this error irq number in struct device_node private data,
this will be used via PCI qiurks for AER kernel service.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index fb32840..d505fe5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -663,6 +663,9 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	struct platform_device *pdev = to_platform_device(dev);
 	u32 breg_val, ecam_val, first_busno = 0;
 	int err;
+#ifdef CONFIG_PCIEAER
+	struct device_node *node = dev->of_node;
+#endif
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
 	if (!breg_val) {
@@ -744,6 +747,9 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 			pcie->irq_misc);
 		return err;
 	}
+#ifdef CONFIG_PCIEAER
+	node->data =  &pcie->irq_misc;
+#endif
 
 	/* Disable all misc interrupts */
 	nwl_bridge_writel(pcie, (u32)~MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
-- 
1.7.1

