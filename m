Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13F32C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98202086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KwG+UiNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98202086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeFMGgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:36:13 -0400
Received: from mail-by2nam01on0085.outbound.protection.outlook.com ([104.47.34.85]:35648
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754462AbeFMGgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNdsyRttoO4RSLuV6djA/YfmEsUoVbAUdwv+K32Wc9Y=;
 b=KwG+UiNJcZmkdKyL0ChcEIcGiScWnbD3Lbvhf4FTBd9rr9ReRp9yrH45z/VU+7fk45r7XlHs5kiEZdXndoRxVxCAxLBJufNdFRyv7e5CP0IbL/2Zu0T0jNh8A0kBhOLHVtbFVCypvWQd5VNcAT67JJZ6ITA/uxikZ0CgRUw2ijc=
Received: from MWHPR02CA0020.namprd02.prod.outlook.com (2603:10b6:300:4b::30)
 by SN6PR02MB4957.namprd02.prod.outlook.com (2603:10b6:805:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Wed, 13 Jun
 2018 06:36:03 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR02CA0020.outlook.office365.com
 (2603:10b6:300:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.15 via Frontend
 Transport; Wed, 13 Jun 2018 06:36:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 06:36:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56517 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNx-00053T-JE; Tue, 12 Jun 2018 23:36:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNs-0001Z5-GP; Tue, 12 Jun 2018 23:35:56 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D6Zsdu031119;
        Tue, 12 Jun 2018 23:35:55 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fSzNq-0001Yk-Lj; Tue, 12 Jun 2018 23:35:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 2B4C2B2098A; Wed, 13 Jun 2018 12:05:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return check
Date:   Wed, 13 Jun 2018 12:05:19 +0530
Message-ID: <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(47776003)(186003)(26005)(76176011)(59450400001)(63266004)(106466001)(4326008)(90966002)(51416003)(6266002)(2906002)(7049001)(126002)(356003)(486006)(426003)(8936002)(106002)(52956003)(575784001)(2201001)(8676002)(478600001)(48376002)(50226002)(42186006)(16586007)(336012)(11346002)(476003)(6666003)(5660300001)(81156014)(81166006)(103686004)(2616005)(305945005)(36756003)(54906003)(110136005)(316002)(36386004)(446003)(50466002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4957;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT040;1:bvg5ewPwbS9haszD2ivAF3HRBHp7ZA/E8071Mu2T4Wd5Dn7uosrOyaTDyteub29fyTgCqZnRrTAIpwYTA9paLZv+vT45KldFi/9fa8H4JuPJjt6BSHBgDxucO/23+e3d
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f1ce245-72ec-49af-a46b-08d5d0f7eec3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN6PR02MB4957;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;3:sGBxqnRJLMpVFACiur1qGTiF2QnI19usPHbtoP1T/Yv7m5BQW3FAoVyuVazQ25dSiuTE8lpHlWEitosMcyDHPBFYu97GjU8JHZQBhbtRax5xRQr7S2nMAUCpnNcnQJRv+e3A8l9S/79t4ga64VKhchcFUxkEyloU3krToTFIh15TqKB/nGYpdwmQpzM8Zpo7U9jHWOC8ACV9t0CvEcZ2vgVA7tBOkRTYfOaqkCCgL4QALb9K04A6oli9Bh9Ofm1BJDeRUdkwpL+ATO6NDMbROTJhPexFWDqeArhiMwrWlMhtOyyNGeWijhdr9soiTtjsiD/XxjAW4HtnPXz+50tM8GqRjhAn0eXkAJPONgPH874=;25:mBRD938Em1U394YWWantwMMKNGgkeoSC32QIAH3lnpB5wzwNXDigkvB1G5H5YwoUXMby3BVzLOWVQ08hO94JSLuKOKeDjc8FBuQAIiLJxCk/o5P0i8f9/Pl1qfGynXFhc2FV5JQ5YWfK4kQeVzwhoVJ64nmJTAlWLYrRxdSrTDefHqMZiMFKE9cZDtT5LIYTN8habMFNl41Oo2IHZAzQqv7+lFX2VpPfCQmO2h6OH+3QbKRGKIsI4aznuZvNHAQEid74RRtFXfM101suEzYtU9J71RaUD02xMSwaVU2861C/K3OzdBQYdzf3Ds7KZo2pCatnY00wGDBW/MsJS2clyw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4957:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;31:KeV+r7npDQ250snzs4CBBe7eG/oZXecNtM2YxTKDZ9OQ6QI6lOjOLJyq7LNbfM1Ukw2Ai7GwbMV1679kh043/hgly0j4T4j09imQmuFEtUSOoYQQyGq38KqKrHj7gEnu2javt7Be9MQSJYDflsLGcWDdlu4kkGZ35QOO7R5eZUcT+L/pU0L5zZnbMBIk4H1QZ7ctpb2kiRJ4PU0aLbCp+yVAIM0vIFgYdJom5AUSv3s=;20:VR9PqW8zB02tXTteoNKMrebCyCH7odPj0YkJYONi+bL8O8iNth2q/mhC014s70XQxIKekDeZ46Lx44xC8g74wSl2XV4SkYUSUCrqmOIqx95gPN3o1A69gXS7pGn3/X6UtWFuUCXeEJZdrNem8UK7/eNIA6/RlWkKX7+Fu0llzH8SWtGVaTuHadH2WlET8gEa9D+W63Uvs9I9bdVBvtURAWAhfD7CvV/GuntRNhSvMa90SfJMZEVa9p68X5qgPWxriSI0frGzPJ9U7XL4p0ze76uGCfKO5dCVMHgVaGQ84ZwdPywiWx1qQZlnxH8H+0gut0feBazRSWLDkcF3yF3QVOJfp7o1zNlt4+iFWKCWiRfb8Rr/wXmGr3JWaUFqETzeYY9DWjwbBjXLdTozwYsDjb3ZWw+TQuyseXkcqCU3KedEQkEWOCRnw80mbDXeeyipbwDILvjWeKHwKze7UXZ8z+I0TfuZ64YN9e05Q4/wjgKNLeH7XbkzPujckSZptzAD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB49574095D12D7851C9BCF385C77E0@SN6PR02MB4957.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4957;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4957;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;4:5aXbXpZAB30PPOQiv1ombFw2+bheQNTpnMaIKkMS+N932+eNnC+6KAmN+B+3X5XWXQhDV9KSVHeDvRvA5bGL2vqok4FXhD6yWEm4+ybZc7Quc35Fg9GlyOgnvrUpaKLG9W2ssb/VG8Hiw5h+/4uu4TQrktZbs2ZiFQH3gwXbVeDRqJlbNF7tpdGEi6BRoC8WLwz3LuXu0CXGRnv48CgpyzsYU+Earo/c02j1Ax5vzPUG6ltTuiGT1mywwGXYKeQMS7pyZmves9vjbm0mWpvqZPTKPV5ARRO6LB2l2FzpciGcUjV67wvtHfOBtsuBgzsySeC0QKSleFSzDTXuYfnPnu2dEI1731vt9HnDpJX0kJ8=
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4957;23:sx5kbpKxUir0cedvDvzKun4YdjLtVRrX17sYUiTd7?=
 =?us-ascii?Q?Pra7Jv7zMGxLEPiiS8w5Gz7prAxUSJ3bTBrULoHuLXjV+8lgurieaTpHlr4x?=
 =?us-ascii?Q?gUcWaLixIo7jeeyWKRXRZpEmBbDLon8ZVSapGxp+WAhxCQz3r8kFweXCo7XY?=
 =?us-ascii?Q?+0CJu2pvinwIkhpdXp83XvGPNztgihYxWmqQcKfHg16JJ6F/NBZYVarxRRR5?=
 =?us-ascii?Q?9kk98qYNkTdOK2CTzfdeuXMAkskmKeOkRB2RT5XP3gHNAaNwtVSMuKJbjMbU?=
 =?us-ascii?Q?TrAE22/ltmIpxfa7Es+EJ1Mm5hzjD+siPx1Kw+hAR/vWLaY8lLtnv9bHP6nN?=
 =?us-ascii?Q?gEYt7rGDidDsLzziAy2Rox3fotZti1gohPzZ2gJZp8E2RG0x97bW+9Eu/iWD?=
 =?us-ascii?Q?vbl/zg2eTEZe4uxkAu3CZOrbd1uKfhpnM59yxM2YT5SBpGPCSmy5Nop4Q/vN?=
 =?us-ascii?Q?pJOWN3ULugafBYb+BjejfchCe6Rwr+3Q2MPB/Cq6LpL2AZOWODTPT0skuxpw?=
 =?us-ascii?Q?eYzbkSE7lsasjL1Oav6z2ZSTITxkzwZvSTfmCb5NIiuJG+NS9jTdJ3nyv9LD?=
 =?us-ascii?Q?XMQC+kJnTUbUH4MnI/fOypYrjjwsQGpCtWEwqyFIoALdGg/7DfxTa3X2seiJ?=
 =?us-ascii?Q?tLyE3QGJBpeHDHBqUembz7UEYkUwq4SPiRThAApSzQhGvpdkysS5CoddGdr7?=
 =?us-ascii?Q?Tte2TLNXryLHN2LlwJH4wppx4xo2XQGbxSghi0WAsD4NlFLkPrcDXfTultK2?=
 =?us-ascii?Q?3ys/e9wdaruHxhzQi7SgXkhXLKFpjx4nd5JW6R94EbZXRTIHZsSgXQD6fmoQ?=
 =?us-ascii?Q?Q1pkFBH3M7S0cj9J7DPqqbPKgWBk1CM7zfDS2bliAeSITv47Gt+W4obB+agR?=
 =?us-ascii?Q?nbmyltzocl8r3/xcO7YokHCVNzhX1YgCp/53+Q5YAI92X0PXRaQdZiE5ooOK?=
 =?us-ascii?Q?JcUKNUUV18F2vqxwiCRhsPq3cQ70QaTPZz9RV1fdI2Q7S6P9KTyM1K5lpei9?=
 =?us-ascii?Q?1gxZUYPgIiU1WRhcN0TXaLg49/Zuju1vFpsiYiAbIyn3iwUTDamgN8BvC55O?=
 =?us-ascii?Q?u6jdTIlcXsyauDPrtqmsjy2OFxILNmVyxHGKF236NvFWoerM35JO6wv/DhII?=
 =?us-ascii?Q?X546gKyDbohQW5BTe9i0wJ8X9Rtaim5dyjk+7anU8GPmjEuJFjjx3hugVC7b?=
 =?us-ascii?Q?zkJNeawqA1D3fgNWgpoboFwuFWEfs9LNYLWoYVWu0VTPaS64Ph2/j9o0/4b1?=
 =?us-ascii?Q?C1Cy0o4/neLaY7qxinShfjFEGpBHVoj7X1PBw6A?=
X-Microsoft-Antispam-Message-Info: oSV7tDj9GX7CFX4V3yyiLwak3gOWES7cogIHGM9QPzdE+wZZVVRJCdBp3SKhbt5oS/dVrbulX+6pxy1dOZgFoF6yVxzrLip6dDtog1ngHkYblfBnNeewOkLmjlQsYzZYuxOmjFIRt4U1cPj/kGiRRqK5IByAhY3yBSyis37I8TKoKpaHiYdQBMAl44Dv13Cj
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;6:QI/qb0iwoL8fFDuYKGbmd4VTzIFUV2EksOFpFJdeVmpgyXjrcc1M/vhB57R5LNA8DmKQP+xE0P4/rezvdKfZhaANxAawamWwHX8Sz6uk+2dGR6vBU4zfKSaX+0yltl5mVTBCd30M0KZwqunPnZm6EEKx8QickTLaPlVgIEgRcDw7lHq4D7et7Kd0fdhkGDlNonWNzmv8DJO+EwsnLDD6RCrIe5mnP9za9VZwFNmUM8r/QDIdWMvOyiiQCD7zL8BFZKqwTpp5NPU1j8zQsLije1wd9vbIb3+eBv3gRfCS1S7hZJy8O8RAI+WDZCWMavRgr49Ct2CEUwGtKZ3tc4NWzbMxzxvImNk5x4/IBsT4KYD46mMr+gRgeLOcbMHEMeLjpAWUAZruTd4wJjgacEpETmbiu3mkbPijDC31qh51hYDazn6uqGPoKixbjj0ZUyQd+DUyoioTtC8FUhMSec4REw==;5:659bmE0Oydl4Kmmq08wuwyzTe2JOOs0W1XlgIbbDCptkkPoRXg84UNQevOXEg0AJTYSb0/DuZcOOJn3qDz7SZxUYilT784OnnYHOvekhLeG/fBwUhtCYZGVpVB+kfh/vZ4nuIQM7gIjEM3OcrB1/DJYD4RuF1llHZaF5HjpVNNM=;24:nAhBXyPJlb5D14IyaX9okXfEPfjwFetTP0gzBbV/nFCNnbvkucyI83GRfNarG0k9U3GIWR0V+uVCri4/B+ZtCOHV9X61PpeF7m7Au3/7vkM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;7:LnlFB/lcCwNbZed0q1sOVN493Bm7N8/aL6JYvT6Fl8MIfbWtoMUinSh0vKQGUe0LTMCu0+3tsAcePp8YarIh4MegZBWN1tNIo5nMVtasYGVRIMjPOeNjxsy5uOSi5+Tym83M4p9XMpsk3oFTHOIBj2j4+WTvhYzjrr3OxRu/AmXXVmXK0hGLzznvgeOFevcaUNSobSwvtxPy1bqQhHkXVGmjMECtdltl6sfyd5DQrkqvftMlrzC4vWOkHcc+9Abs
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:36:02.2217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ce245-72ec-49af-a46b-08d5d0f7eec3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors are already reported in xemaclite_mdio_setup so avoid
reporting it again.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index ec4608e..2a0c06e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1143,9 +1143,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	xemaclite_update_address(lp, ndev->dev_addr);
 
 	lp->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
-	rc = xemaclite_mdio_setup(lp, &ofdev->dev);
-	if (rc)
-		dev_warn(&ofdev->dev, "error registering MDIO bus\n");
+	xemaclite_mdio_setup(lp, &ofdev->dev);
 
 	dev_info(dev, "MAC address is now %pM\n", ndev->dev_addr);
 
-- 
1.7.1

