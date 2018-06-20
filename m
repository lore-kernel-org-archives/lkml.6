Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C0AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3D920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dW3vD/ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3D920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeFTLeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:34:44 -0400
Received: from mail-sn1nam01on0045.outbound.protection.outlook.com ([104.47.32.45]:58880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752747AbeFTLel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J0L4IQji8ecFDLE8j+AxZrzz9JbPd7gwu5kLS+L+kQ=;
 b=dW3vD/lsWt+KpyQDip1zZ8+QilgaRVzjLfVCJ/+tuRKEcZJd5hLOTtZyvnNhdHKuPnboo/qSxGHzhlZvmt5Woupd1hZg/dr9+UoSu4wMiN5CplSBbLkPQgKlXQOGsfsDd36khjpiVN4MCVtrVhAiPWsQ7uZP9g9hU8bAoaipGkA=
Received: from BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47)
 by MWHPR02MB2653.namprd02.prod.outlook.com (2603:10b6:300:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 11:34:40 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN7PR02CA0034.outlook.office365.com
 (2603:10b6:408:20::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 11:34:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 11:34:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fVbNm-000872-Gi; Wed, 20 Jun 2018 04:34:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fVbNh-0004H3-D5; Wed, 20 Jun 2018 04:34:33 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1fVbNZ-0004G9-MC; Wed, 20 Jun 2018 04:34:26 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH] net: macb: Fix ptp time adjustment for large negative delta
Date:   Wed, 20 Jun 2018 17:04:20 +0530
Message-ID: <1529494460-4689-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(6666003)(336012)(316002)(54906003)(16586007)(110136005)(106002)(107886003)(478600001)(5660300001)(36386004)(4326008)(39060400002)(50226002)(47776003)(8676002)(305945005)(486006)(356003)(63266004)(50466002)(8936002)(186003)(36756003)(2906002)(426003)(44832011)(26005)(51416003)(77096007)(7696005)(1857600001)(48376002)(126002)(106466001)(9786002)(81156014)(81166006)(476003)(2616005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2653;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT016;1:vPvfC6+ERvl1Qtm37U+tWlHsONBbftrc28P/GxMxPwAPZfwNSuy8S281ASS8CHCynE7jE33dY4FIZOTwRoDrAkSGmlSIFM8+QIJb0j1YCOrIPs98lZskWUoLpEc4hwN3
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea5985f2-b76d-40d0-1aaa-08d5d6a1cedf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2653;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;3:ete9Ep66Q1JDnv0yeCwoZ6uFJYr2ozNov1JueQyYrZLMHcffsJfD053KyoBjH8NOZqdR2HepPq7gL7LZUg9Dw5FWppzH0GJ8VumpgAzbJJbM3lfKrE7LthkdaFNiJHro48mmxyTzCFXkU8cNYtnzdv0gPS2etb6um8nMIoQGnnTb47yrNTCL1fILApvAzLtM2IaYDLGdu9hmaj0KAN4eOp7WLVYriG0NDBARkLtGETL3U0kqoOKrXi+cGjdEww8GNFZksoKcaNg9zxJFVzpKNXCWdqukINNsXkendRwqdFfQo84U/FLwu4MlgV8+bkJlb2hMZn3uhAuoOWJyrPw4jWqdoSMQ02/gk2OUvy4kRSE=;25:9D8DLIrkfSjAlKXq/ZSea+arkv/LkJe8QosmfoQ+G5jrhvITZjah8F0YEjTMROk+S6zG6yNBWW19cYbUA/2yelrrtYCr/LJQmIwfQA/jNg+cKHrnq0vWZE/IhFtohzo+mvP4UoXIJUN100TT9FhwFzvyVL4w78muw3gHaAAK8v+RjDNaf18Qz/Jbz1UiJQu9Sk5+jfDbTqsvQsYxh1kKBh52SBrBYMGIKIwGL/3pIF9z2vGPrZ/kMfMP1bTvol3s49iuB7bjQzrNiOhveM6iuMhWZ1JdZhINehSNiU3EyZouVEiCPnLpPk6y6PKHvuhtNv50QtQz4LEl5j8DWEGrBQ==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2653:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;31:iKE37ScGc1y/8sEEgYQG4n76c4bWF2CN4I2tCNkgEm33RWST1XmYyvHSNWodAQYQLPcxFxfNva3FYhbgdHbRauIsqXgCyeJIaST1f3JVQcEPuvHcQ8agLTvPIMVZuwOTndMB0gktqMtuW5L+fOeHqvyLd9K7rMPaq/0wSBWdHhb1d5n36lfH1HfDCmDxtWg0jcIxeKslY8o43apT0gdeENKfL9DabVfsytlR3rcRugU=;20:uON//rHS/ujbjAlhCoVnvas3NpFc7s3po9wqBafLN+K8SMrlwaroNZ1N3hZdh1d/du0WXIr1nQBdU/sJQ3USWBSyPkUTSACNtjfQ3PFG0294Y72SsG+YEWhXxbqOsSlJByUZiu3h72ZAwnIkPCRz8GUZaKOyA8OpNt5whrqVKnGSwYKMYSNsCDHkTQBPVJy8t3wnA78vYGL+YoVgILtU1Io3R/vsB+fLQGixNWcb339WVmUgewJB287iBZV1wpAMl4h8YPN/8syymx6fMJ1RYNSQWRJdVxrtRhap52sU/GavVrLs3ZTytAM+u7kXhQ1V54dfC81em6zhaZ3rGf+8TO1glOjmglpRuFaywwAVQ7XDyLPVrh9HlLn+9vxvaoo//csqcVCjKHXBWiUK9UIUCxL+yASwZgZCnYWsP6kmaQYf+c/shiHVB4n85B5K3shOWIR/vVlDCal799njbioljXzhVGNlB4tK+Cf8Y2t/u1IP4qGktPZeoqsJ913WJVvF
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2653E65576F82460927C8F2CC9770@MWHPR02MB2653.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2653;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2653;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;4:I3z7Ja5aZSVhhNjVG3JRrfD390ucqrRvCna13bhWWVdSrr5UmEekMcS7WyTFkqAjJZZGNLYicGVPggGLpgnz0pe6Hmf+l3Rgu5rudYxBsaoJZVMU6QLY271IRQCeLDV3qw+1IuLBHmOMwoR3OSY+2M17h2HUJ/Ecvhr0cJqG4op1lbKZV+ZQiBOyKWme85emccYu/iznqQIPbazKk6rixOlX3JTVzr9FwVBb7D5h0S2pXRKSEVF99seXxeKNRby9vISMwtZsKeiuXdXXglZedm0513Tb1k65Lh65E5r7dFz/6/fs/qNqk9DqjEF3+WcG
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2653;23:zV07yMVLZhUX8EO/0ddh9+cPZmsdH9QHyMB7Lmp21?=
 =?us-ascii?Q?8d5BdXvqhlpzq2IMx1lmF/UPyke++XS7GzSpZ1iYxldD8L5L+85yz75VtQEN?=
 =?us-ascii?Q?x2NByVWwBQQTNdpcp7HaKQwu1YJCIs4m1IuX7TR/NpORh/RFDMXDN95674sj?=
 =?us-ascii?Q?Dfi/6VqzXx5ohRaa1mjqzad5EDwvFmg7Q1NaH1bdqDT9ZUvlere8k7sTw/BD?=
 =?us-ascii?Q?Y/wMTxLglyJXXufl9copGb93qwP34OtSbv/MuR5IbMW/NMH9WDszFZlpSZhN?=
 =?us-ascii?Q?s4J5/Ti+uYhRomU7XYlT9TB4miEY2kwDdTe26Owv0CCXxEFh2/v0WWhjTLJC?=
 =?us-ascii?Q?g6Tq7UZn2lJCVwAezTGAHl+R/qDeiyIjjUzhWdTo0UYytXmfNN7LcLdFQB8J?=
 =?us-ascii?Q?54juhTl67TumcwZSmBRqBnhAWa/03GfHlKZFeZUPJ9eL/jIxej3u9vPRu941?=
 =?us-ascii?Q?kpmvmg7ZHcPNo1HcdSsPklf9hfjO26bxGKrZNdylSeY+tOIre8j/U6ELKzht?=
 =?us-ascii?Q?Q5USy3VuMKvdwWy3VaYVkC9HHwM6SAdA5tSWwavIZBKDeBHMltofYQ8iB8Zi?=
 =?us-ascii?Q?a2B4NaRiP35v/k9pNtEohsx7CyxglJyf0Kf1ijj02iPbGo8DzcYZuuCB1rQw?=
 =?us-ascii?Q?Bs+OWBmbm6RXC0V01NijtpIPpjC/BtU1trNeHsqSSv4Ue8lDtb7SjiRNCYql?=
 =?us-ascii?Q?ZLSnsgC359GJmTWO8n0t7mv+KJOciiRaqNU0eTKcuGgBf/hozMzG1a7NHJ9d?=
 =?us-ascii?Q?HqXDRDxAD59v3K0zpsssqce2H69bdxeWYflOz5wj0POAwDd9RBN0oyd84kg1?=
 =?us-ascii?Q?glELGSwOLnmW9M283Cwjh9RLTJYKjVGqT/ZT9xq5UsfAcIBpwKYO9sK55nqM?=
 =?us-ascii?Q?0T5Ul7a5fIadIalDgZy2dOxDmDUdvjx9+dMIUAIiFAwkI0cgibpJwBjpnYuO?=
 =?us-ascii?Q?qyYptSBtcWBftKpTvutJrubf9VnLUEl7mOGoZAwccTz2KYldpiPgcKJK0KMb?=
 =?us-ascii?Q?W+xsavdPsirKQXFTtVn4hXxSN2vjHXJQKrSlaflAnh5EbuIGdAlSG9ddX/sE?=
 =?us-ascii?Q?b4DqQ0eSYkUFffWwKZLg55JFVTOJZ73Gy3oDoebxQ5+kJBxfa0nKzyMER1CC?=
 =?us-ascii?Q?u6PFcToUdDFSAWS9OAwko9i88WWksAZ?=
X-Microsoft-Antispam-Message-Info: 7z7B/InSQVjPB46A7ocMoOPx7UkToJHlF60dAYCL4H2mV9jqP0ejkcxUrLuDvZcdWX3fEnd7JjD92ITGU6AymcawGAA9+NtGkq4rCtSdB9dm5aqxfmCwqjjwrdB3ZAluybHtltEXT/GQNDryJFKyGXyT93VgXl2m+4fJDpJN+iT9kYcgiNxO7UkxnPXU5HmxvedguCyMXZDSFpxoxhKTu1PVM0REV2oZYr6bZTvyHmgt72156mW/iiBeLITgMkg0LiU32GCTC8+t6uwwvYxdyHld0D/dEQY4erqGmUOCWKL6QHdlbP3AHO4W61DUsDW+STqNTijJeSMyN772bN7tMA==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;6:xL+1AXajKnVbS+GWSMvaehqxdChC5AKOmCnkGFnw7qhj7XBLKIdqw1lwh0iXeBgcZKNt2+SVveHl1k5Hq7vqVwcktDovPyx5b10X6PPKhjOXcabhiemZMHdnz1LGsvrfzTwLmbooF2QUcCYufbeD6y5npqH2XT/5TjDrqOXmpPWAHP4AhbrXMqMscWTFDN/4iv2J8M7O2+Fan0X0NALJEsTp3+oD9Yssb2M+RaQ/6im8j3S00Q1XYHUTyhGEt7SHr9IAyhWp0d1YSWwL5qn/C4FjyZPZu1WMiBQ+b8PDoIPE1sFC6VQ7I5WpQW8CCfFVNZnvgGvgYG/RYmW2huPv3YXInEfAXjixl4uOq7sLx8NOh4GZCiahIaVux0ND2ESEMz2Z5htwCMeThfQRR06PAhlYOjvd7IGPkme0Itc6LEHQ0oiLnFKATW7NfPi7/zBnVGl7ac0/3G8Xb+SYj9FPrg==;5:7EaR3VoHNBqsGiBqTupv5objk/We+DprZ8WjMuvrDMZZnDJuaCf8dGueC6ek2X9jclbr/qH4LcSEUVPyvKlEpmjQTSs03DugOadqTLsSfpbqHVQS8uT8zBpHcqblYH0FRkE8XvhK6HWlWu/RXY4ctoCVyFp4tlZlHvISX5faEvw=;24:D7SN1mJKWLTguCP5C3QbUS0FEsZ9N1cLW3O/0X9es4B0fmdlNbYk2Cc6/YrEHThlHMn0mUPYD/pZzCTr+7PXiDYPvT6rhcHQ/xF1GBziGUk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2653;7:mR/yGfTvRPhuUlI4YHRSO81sF79dOBFmc3Vbj7xQ2nfaoTie215CNUbRgQhxMirb8NbNCVH+bpz06I+Dp33KgQq/XSnTfbSWxkH6NEZXWfBB9JNfTVcJcspi0VOjeV+W+HrKCcCMgbb/v3eh3Sx3IMs+3XkXWxpKRhrVdQrfXrQhF+mQflfjv4xeIt8cMpLDXGA6ukAZJ+q0jMGJjw/Q1Y8rdUsDE4u6Znm2CgM3LUWDnpkeoEqMkFcYU+gzTiCu
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 11:34:38.9099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5985f2-b76d-40d0-1aaa-08d5d6a1cedf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When delta passed to gem_ptp_adjtime is negative, the sign is
maintained in the ns_to_timespec64 conversion. Hence timespec_add
should be used directly. timespec_sub will just subtract the negative
value thus increasing the time difference.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
 drivers/net/ethernet/cadence/macb_ptp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 2220c77..6788351 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -170,10 +170,7 @@ static int gem_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	if (delta > TSU_NSEC_MAX_VAL) {
 		gem_tsu_get_time(&bp->ptp_clock_info, &now);
-		if (sign)
-			now = timespec64_sub(now, then);
-		else
-			now = timespec64_add(now, then);
+		now = timespec64_add(now, then);
 
 		gem_tsu_set_time(&bp->ptp_clock_info,
 				 (const struct timespec64 *)&now);
-- 
2.7.4

