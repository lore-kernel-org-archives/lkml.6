Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB4B23F73
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="45pzlqnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB4B23F73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753796AbeGFGtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:49:18 -0400
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:33386
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752681AbeGFGtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwzC2PBE2nymV25jl0C2kJ0z8eoRn+jP1ymEYPVlPSo=;
 b=45pzlqnf+TWYAz2Mz7rLzbaZqmroDyFuG+BEVo+j91QsjrJwvZ+ScuXnSvuaIspIK1mcyKPptwHcOt2XrMvre/XkquO7gJNnfie+cSl+qrOA/j3iLr9vlHG0NucBwQamNWbCX8LLqdjqvn4Ev48F25me2rfGAfA3fxraIWKIATo=
Received: from SN6PR02CA0028.namprd02.prod.outlook.com (2603:10b6:805:a2::41)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Fri, 6 Jul
 2018 06:49:12 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by SN6PR02CA0028.outlook.office365.com
 (2603:10b6:805:a2::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.26 via Frontend
 Transport; Fri, 6 Jul 2018 06:49:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Fri, 6 Jul 2018 06:49:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fbKYJ-0004Ys-AE; Thu, 05 Jul 2018 23:49:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fbKYE-0002Xd-7L; Thu, 05 Jul 2018 23:49:06 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w666n4hH013677;
        Thu, 5 Jul 2018 23:49:05 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fbKYC-0002WH-Bw; Thu, 05 Jul 2018 23:49:04 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v2 1/2] net: macb: Free RX ring for all queues
Date:   Fri, 6 Jul 2018 12:18:57 +0530
Message-ID: <1530859738-11802-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(438002)(189003)(199004)(8676002)(81156014)(426003)(126002)(476003)(486006)(2616005)(336012)(81166006)(6666003)(48376002)(50226002)(356003)(50466002)(5660300001)(305945005)(9786002)(44832011)(316002)(2906002)(4326008)(47776003)(36386004)(16586007)(63266004)(39060400002)(106002)(51416003)(8936002)(7696005)(2201001)(26005)(77096007)(478600001)(186003)(36756003)(54906003)(110136005)(106466001)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT008;1:Lta4jQuE2M9Bfr96hPFNC+egX0r3g/oh9zFW2+8CoKh10IzT4ZRB0ZGLO+0El8URYJbdWEv3NoZmulitd+pohtnJm8wpMfrdgYTkQt04shzpTwpylIDhtMZnkqXrbeJJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab26457-e4c0-4237-c9e8-08d5e30c94d9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:BpAjCLsxc7zvIHPaHrcOLxIjv49F4N1gylEMAhbtRQSfDrtGOjBQyS7oh1b4nKvOsiysvX1HwOAkx2hr5Gunho44/SRln1RJ/3e+yRRhoXzwi8L4F9hxlLiXzSVG5N3Rx8vyE6M85wm/Bt9WVUiIatR0oA8T+DshCGBeEnV2YEOtxiV8v+fNinMBR+5mqpXBfFM9h0Biz+NyuiND/BUGqtBHHB6OtC3mV2s3cwh5bHF570ojXHvmycw/H7u/DuchrdARM2pO2a3nLqDkanKBmpwgzqzGtWwzvKaJwAAWCmwgKIgRp6PJn6STaA/CINhcv/FeBZfDFdV8DVn5qchziMdOgY4TIhXvzE9+LxBASXM=;25:1p6rbPeUo1b287OLGuEwrViCmmJ/iBoKERKRIaAricxXivXeJQfCIlItx/d/kz4YwvRMUuda8QmERmwjcMh5c2NXPcuzCWe+byKRh6HG2oaG1iJVOstBixdTX3MA/qNQNQFru4XQ1CSdbfHXR1NTVq6f5bYVWqVMsNEsNvTR0DxLh2XHg+TTfbnTnMu5krVHly6wUocV9E3rQGs903eQBydakGtOhfXgEnrNZaG+Y2PC/hsqMHG7ZSPs+RIMq/qi+KeLPha0w1o9D9fxyZ9yXMO07diTofae/1ZPE0fTnQpC+vQHSUDb9HWmQj4LwdAi5U4hj6OtiML5gRelvotVbg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:eO18UEj6D2ROG4L8liaoUnh4FokJNmYPuXQu5MuVcnmxx2ooePFaZxuAxGx/8Z2o4DnTHqHzY+prJsTMJus1ShnwC8358UFFcUA06keyOb/9pcwoIawk06Ch7spQAqWuwcpzR9C+0CC7VYe8cg/BWlyXz0apWhU5pAgh6SV6Ay6CsLA1rOPSVRJPofKM02+4KqQP7dINZvsAQ7OJ72sS7B9kbLYjfIZOelvDkLmMPsw=;20:glOmKS7PGgAl5dDpu7qSsBbrg3/fg1ME9cS4lIEddXPRiG9vrRNzKdOh++FE9/pOsR4WUqidQNVwKZrOtN0u9v95OgliX5uj8PEZ9dg1AwD1HBNmpC+LDFx6PKOw4fcsn0JOxE6RARF0TaEKxX4bEg1IBSMm19C1YHXsUNift5RrAejngvCqx4AtkXgsIGlrU5yddF3b42ri42nts+l59DjqxnQ5bEzAAg5TbvRi+YvQrKBUMsR8/ZvlxvnZnglfoGDZBh+b4LM+N6aHigCUj2PAfq9Jo/EfITpSCz1pUxUEskFi/kbw6BIZ3LAK7nxsnlv4UMG7p2oWf9hw+Eu+dZMNh4edhb0+e1CxvKRZm1lXdempdpkU+nzR8gTBUlMxejJOuE4TxVi0eiNKB0qXMSyrkjwEp+FFF6HshBMzH4cGssQifjzrXDbVYnCe6W3AnOSXN0hl2wQmjKcYGIW0E6qgFXk9Zs9ZYXXonQumj8gfYe0x+dv+ziWYEF2zP4HS
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4449FFACF0C9A3176B76EAA1C9470@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:EO/mYfYT0NliLhfsdSK/Nxayr8hO+342TDBP5yyO6BJffnmwfZgWdXorQvRmj42KDpR2vz7zJ/+X2MBrxp1KyZIlUZq9zLGnWkDg5xLkOeuy03UYYhm16F6ZhutPXB9botqkoJwaVKSF0RU+O+FeUvvPXyKb2jZAAvf0yi9LJiYlbaJF1SngvvD/4kNWMruUgYVeJ08QV3Ym6vB2Imc5Vs3dRVk+iRXdcwS4LQHRFiGskhPRU9eZHVcXiQV2bxf7GjzJiiCuMu+3EIGMomSFGSNE5vAG7AFEWZF6Ls53YrOCVA/s7BbwJFhqdl93DSmW
X-Forefront-PRVS: 0725D9E8D0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:Y3yKVOixkZSDN/yr4ou4zYMDKBpuqEx6f/SvFLJzW?=
 =?us-ascii?Q?R+IaC6aLcfg6ayZRn0h1Z3ZXBNvyFrzxe2ol+KI/I5VLCRVnXBzeplQ4g8QP?=
 =?us-ascii?Q?wX7OVE7wHBO2jFX0MGIZQV7/+femh8NX3OTgjh9K9Og5CftnjE/3oZhsOoq4?=
 =?us-ascii?Q?llWvnH0QQOWHN1xjgmohxhe7acNOenl3/pARCRIwm2estUrC3IGV1nTCVk2x?=
 =?us-ascii?Q?wetpY+CxBwRfmeUYzzV2VNooPFss8avhXkA9oCvoOTcaerJQOlT71HQdfWRt?=
 =?us-ascii?Q?Ng7Cu7n1pjdj2uie63HKVzpayTMoCL9Yv70CqpdwGuqmEPilKKfhR+X5o/sr?=
 =?us-ascii?Q?+pj7SDRm3hcK3Wpkj7wudLuYSqSmEhqusEVMUuWLmjcXzO1J0wv3SQe0R2YN?=
 =?us-ascii?Q?gOTHYGA2lXM/p/iOr5lunXLPwsGBwrq987YfsIE5Hp3TVJY9vP66ZzQEOVcT?=
 =?us-ascii?Q?BDSm5wIwHz5rwSuj5Xbmw86T5bOrj0Y4FntQ2S4kC8BCj6OIWVveNL+TQBmT?=
 =?us-ascii?Q?j3xaeuZEjlRFBSx8TXddqQptYzUV80sDiA3yIq1dA3EozaN9tpKHDBiDGE3E?=
 =?us-ascii?Q?BvT6omKsaJYqxpL2IoEuxDRZpMzGU2U92cdJpQNQ1fvWQUJk/066GMLjHrl0?=
 =?us-ascii?Q?sDDJaJ/SygN1k2jMUBrILD+cZaDW2YU3zGVMcS4hlVmks1vdE3QTq5mo4efW?=
 =?us-ascii?Q?esfffKOIBDVQu5SvRJC9VNr8BDAZV89wUAkIL/0v6lfMklAOKYrM9doddbON?=
 =?us-ascii?Q?Mr+1mEUmIyQaaRmMHBSgsrZNOsK8DXDOoOrZajdAuVjo5C5QCQ2jdCZYcnt8?=
 =?us-ascii?Q?XByYzdeFQ9gMXn9501plzWMR18ZNfW33mKjwFE22odT+xD1HbO6AHG5MQilV?=
 =?us-ascii?Q?lXkII8cwsVj/imSkGh1VPao1MVC/FQsuDPIpukpiKIlaWCd0G6ZOGQ+nCxJW?=
 =?us-ascii?Q?CMazyAT/uJPUuP6bx7YdSQFScTYgxqyIsuk2r8cbZpwiI/UP1enyeQW3DQFY?=
 =?us-ascii?Q?eBurxdATvCY13lyDPX0sdnH3NoYuU20SKhoL5KhPA8T15yTIOA+7YqR92xjs?=
 =?us-ascii?Q?klcX9rW9CToKaUFUADf0DKmpeW36WYmDAFwtutT0FA4EBcxwR+P0tBNT2XnP?=
 =?us-ascii?Q?dkuXPDelBE=3D?=
X-Microsoft-Antispam-Message-Info: qRB1DhuJRuqqhsrJBvDj/AbIBXjQFwC0gQS2dnS2sYFQeWPqUkmMcvSDPCgWYg93LUuC1aOToMm95jjUmCXDiz9S5+9iq4GspY0dzSqJUtbh8TjstvZ1uj4twiYCZGjzjdJNHfvWBsB4A7DDgktucqkeZqADjWcmch/+dkGjckTtgwS8U/NXK5trlSsWV9x+9ydDrY+9ga7v/CF3VwZqjssP9+0o78mndPtPttmij7hed5BQQsFmP0RqzxxW4n1qU2ZUlJAXDypbYtX43GGYtlJGvVJMWta8JzO8iRk0yojfVc3lxudMz6qCYfA+fK10h5anMJ8XEmq2UifU1T618q1naQ+jxf5isgspZbuz1YY=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:mk9Jc/Z6uQTi293euBlX6q1X8ILGOjXAqQZL5mTXMN+rzAGzshZymVL/YiZhkWGlq1rSG+DEZYv8a2DKn8oGZfFxLf4RRLq3MsGukzLBl8HPY9+5G+stBAzfdjSB0X7jWz81zV98JCAb2oEtBr5fT5wQAZQDfY3C4luXI7l/CBHBL912f5EKi3BnL7aSjV1faRjQ8uHJOlzb6H3k9UpvCO0RXuHMXq77xBQZoKsuh8rL4b32KUOt5oDhCZOa2F2c9dZvu4o3WlcP8Q9C2UsBbTw6l5DNy+ctMAKNk7kd0FOWDXCvRP/uyE01CG3i+87WM3+BJm7V32WxWrZ7jkE/cg9ZGjeu36O2imlDXR9LwIqJzdg8vyZJ2j2xDGu4+DF39LigQ9jPMJRoBZ6G35d0hxpP+ZGvxGnHJiaw5yxlDtcYrRZTNj4fNUWDOm9tKzZahPOGmoZl39AqVq3jxpaOrA==;5:n4uS1O+uC3FKbZLOeI9gMX3HWEff3I3rLXcsYu+McWxZuVnA4W5izh1GuLVaRYBedoamRI15rmLE1Tp4VBv9ncVVKAvq8lYrmkzD6EnBSnT/V5M2BbRvP7IZd0SjY5yai0tEN7jFevsZzS5QyZesrfLu0GTvlyAlBFriVI8JU2A=;24:frF1MneTR0sKiFuRhGEWzLY2hCYg8XO8Y5qJnUTNOCoVV5W2Q2C93/UFsfwAc7TltZVE3Cg6TDtST7rtisJ5OwnkjQB8uIQ9XXOmViDAZd0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;7:9L/sB5M0Om45hsFUod9mcS3zrs2XKHdQOXBkZqGH2PfVkgPNvggVlOGZ2By2sbl5StAx3hRpZqNBAoxHiBvPLzSYAcSuHiqqbbzz/7vy6By59ixcCDq8aS+/NSSVHHwAuniZNbreNrr1EP5/FhbOfwdJyl9s/hUVQzApvq29/FU9ktbbYdXVnAIOyLMshmSUGSrgZ2Fl6Y1WK997oelFjajRVYA2FRM0m57B3Yw7lfT1xyKDAKW+vGwCcDtMKHIx
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 06:49:11.6706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab26457-e4c0-4237-c9e8-08d5e30c94d9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx ring is allocated for all queues in macb_alloc_consistent.
Free the same for all queues instead of just Q0.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
v2:
No changes

 drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3e93df5..e56ffa9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1812,13 +1812,7 @@ static void macb_free_consistent(struct macb *bp)
 	struct macb_queue *queue;
 	unsigned int q;
 
-	queue = &bp->queues[0];
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
-	if (queue->rx_ring) {
-		dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
-				queue->rx_ring, queue->rx_ring_dma);
-		queue->rx_ring = NULL;
-	}
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		kfree(queue->tx_skb);
@@ -1828,6 +1822,11 @@ static void macb_free_consistent(struct macb *bp)
 					  queue->tx_ring, queue->tx_ring_dma);
 			queue->tx_ring = NULL;
 		}
+		if (queue->rx_ring) {
+			dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
+					  queue->rx_ring, queue->rx_ring_dma);
+			queue->rx_ring = NULL;
+		}
 	}
 }
 
-- 
2.7.4

