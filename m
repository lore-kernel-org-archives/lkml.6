Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33600C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BEF2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zZXSrXGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BEF2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIELJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:09:55 -0400
Received: from mail-eopbgr710075.outbound.protection.outlook.com ([40.107.71.75]:43612
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727154AbeIELJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef2szFAro65kzedAXrH6t6bpfJSi4xbl8lbr+MTgIAI=;
 b=zZXSrXGa8ON0bBzQz5gtVBhkSXSR17nMK2vc5QnThRV0Au/8F9RnZHMuoe0AmuGnkAl6lHHmCl4Oq6S0LeGi55S0t69C3J6A+WIg4/vYpWmbEJ2IL2Sb7huNMhAPtlkgBz2+xy0AdhgSbZb1Sa9QI8xT6GSYW+yChtUktIBQbiY=
Received: from CY4PR02CA0035.namprd02.prod.outlook.com (2603:10b6:903:117::21)
 by CY4PR02MB2679.namprd02.prod.outlook.com (2603:10b6:903:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 06:41:11 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by CY4PR02CA0035.outlook.office365.com
 (2603:10b6:903:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Wed, 5 Sep 2018 06:41:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 06:41:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:38350 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRV0-0001Xt-3u; Tue, 04 Sep 2018 23:41:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUv-0000v6-0W; Tue, 04 Sep 2018 23:41:05 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w856ev7I015659;
        Tue, 4 Sep 2018 23:40:57 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUn-0000hO-2t; Tue, 04 Sep 2018 23:40:57 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP reset driver
Date:   Wed, 5 Sep 2018 12:10:41 +0530
Message-ID: <1536129642-7049-3-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536129642-7049-1-git-send-email-nava.manne@xilinx.com>
References: <1536129642-7049-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(438002)(199004)(189003)(76176011)(106002)(77096007)(36386004)(51416003)(7696005)(9786002)(81156014)(8936002)(186003)(305945005)(81166006)(50226002)(2201001)(36756003)(217873002)(11346002)(110136005)(16586007)(2616005)(126002)(476003)(478600001)(446003)(336012)(426003)(486006)(6666003)(47776003)(50466002)(316002)(48376002)(106466001)(5660300001)(2906002)(356003)(8676002)(26005)(63266004)(921003)(107986001)(83996005)(5001870100001)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2679;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:bLzgkMvsALwXFWF9Z/YAesmJxRynZUUYuJwecF0jaPX+XkgFOmjYSIf9kfX0Rox6KNKN34rtTsoL1wV1fiYIl0oyoOuKyrkDM3D1VPqRUWUE4mfNeQo4hGrExC7Rkm77
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0de60f0-f3a2-4f87-6aae-08d612fa9165
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2679;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2679;3:oHQxqRWxOQVE26FcQsjH31+mdniAAUoF/daDK9qramCdcjA/RukqTgr1GItW7sA+9YPGtDZkgQNUmdt8h2N7IaruzgBIkswTqq/bb4fNDIzSPyVp2SLeeb/mXeqaxhjsR6FZx8bGpKQBBlYNmdVgwVJkW7M2I0uWVOiuETLTAGDGJwJVTERyMCMIBUuAvHxN/La2kxeOBRPOVTCYLbt3FwFC9W7K9NZUL950Y3Y6gai8jxHPJwiuRCQtlQ2IyjCL6N+wBget7H+pr0Z2Q6AhDnUIKoelDaZfaO2mgcjGs0dIpeGhthOc4+16yxwx30H6FHuOeZ/A82OZWzBdsvoHKIA4zlf3HYtDcxwdDoLgbp0=;25:7llPyd1QO+6CNwEElQT+5tfHvkES7rMwH2sUxm8my9Nu64zn2h0hnU+8DpTWYsH8X3b5+nGvUPyGGYAJWczMCH/t6ehmKRE/L9GXzCQTbeYcl87onMiORkE8sa5+Ifz4NtXXWBj6It+QMpqxZWsCIzH32t0WlLiTPXXDHMzT5Elomi/5IoypJoHvW2FyHzQeyK0SByQE+e5DWBNw949Ar0NDfruG4/0DMMUsXBDrw9P4zEH1tNvZUB9fBwffSEIgvfUS5d1UC52sKZ4cc9brK1qHnQl5K3Q6b6KOR9d4MFfFXMlVjzGoo9Fc89koTdsuczYOG/28XA7Wy4ALQVybPA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2679:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2679;31:yUtXumOVcAFZrlrQJjekCXYp6HVJI/3UBZHCQIjcWpPe11x1mAv3/okdnNX0XwES1tXZiyxeFAlDzdyVlYjenUMvGQq54LPo+jkWwxSasKdrYXiR7foHU1SXCDsvjtCNPUgR9WJ0O9It3t8IZ9AtU20r1zumYQQm5BA8Ri5B+CcdLYb69biXcfugju1M0v+q1v6wdImstKNQt2qmuqLTpW2r2UBnq8ZooUJnpZIooE4=;20:TJkzVErXuncsz0VCkf1h5+TIZxW5Hk+WWKlkRL7o9JTVaXvlYG9Rr8l3ybvXvEPneue+edm2t9mryX2FyLleirrZdLID6UPdntlFctzynLOFzNzUE40pRHcNIGjW2rMqBiZ4DQtJNkveyK8rDrp885PTbJfFMAh9ZMdGCCJHIgjvWDqEoE36RCavhOUvUQSr2Bhg4GqfmYl9nOZbvNCAoOxA2lRj8M24KxhVdVqeKA7x9W6kiaKxmyeB2lQJ3AmUNMpG0hgTxc7MsZmj3ETNckgjIpdIEfw+U2L9jAj9gITfSgnxX6753DRlzq5IpGDk4NrUJNx2poXZTeS9OwFtBMrH8YDpBKoYJJaD//Y9UEP+dNxFJSKKSfKjYD5KxSXTqi08hHq4BgMvOMLVhYTjrnXHMCidWgy0D7j9H2ickYXnTETfA/08G1ormQOz+18bEnA9BFAdecXgPUvWjypzL1NvgYdL5XdOVc4V4JvBEQjlRf6pDRC8n5BmWLc1y3Ry
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2679ED3B8747F508DA3EABAEC2020@CY4PR02MB2679.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CY4PR02MB2679;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2679;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2679;4:zBlxNv2pZdLQ/0VNIfnGP6nubrdHRfRSzlQen9yRc8k/3k8YCZ2b5y/sY7/ZMreM8CyU2/dD+0HMX2qq9qcr0aXxWdbl4SowwWiu0GnjldB+/W9SbKfiXVs3drgTh14/aLI+IXsT/XlQdfDlkbS3nWck31tBFrt80gdfJBDv6ttLu6Ici5wz5Lg9MNS4nAxcATlykSNcgN5vtBVE22t4xeyHLb0SYEr3COkHJNuoJVND94I9Szq7n3Jiin3zoFzhEAl/s7p+Z+acV72t742VXvf0W5hBVuqoOLUVgbgT+FS+rbglQhemRop8FHS52FjAcWkKmGMm4kOJP8b3IDBpSD+/t8odfcyqC7DhEusmRnc=
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2679;23:q6P1tAaHM4oZN564V4tTyi/wi2wJ2cn+3+i4pz+ZO?=
 =?us-ascii?Q?LATZAOOWcNiNnFPV66zIQPX0wGyf6lL9HLOfFJJ7S4tGuAQUBu43LZZ69Sdk?=
 =?us-ascii?Q?JUoRvRu8Ncxr5zRXWwqdu3TTEqVJkzbja7646iLwA3UmsBTV1vnej+KQH1vf?=
 =?us-ascii?Q?W0yvQ/qH70o1mL8l+SpRxPs7B5VbeA+W3azujjQ8dVeqAFXAX55fqAEwDvgt?=
 =?us-ascii?Q?JDILbAJ00NacYOhH595nbeav1cJXdcVIeg4SUk8t1WMQK7aJ3KH+LCppDcaa?=
 =?us-ascii?Q?odN84A6Nu9mT7rbJcf653/+lZ2Z9+rYAXDVfXn8o619tiZJPNc2FqeAhvYhH?=
 =?us-ascii?Q?FHZU+U9fn8X87QmcVFPXAjMUNLXDw9wLOJFDv/1kaOT1Y0IFK47aRzMgZc5b?=
 =?us-ascii?Q?R9txj54TuL8hVj5e+tyYCywEQwfIAM6PfkDsctexaEAylFfeGOttXpU5+0ti?=
 =?us-ascii?Q?GkfB2ZAUy3Wa9mLWwT8Wd3LFE56hcQJZZTHrAsqyntu5MQtswSnvJ6VsFAtW?=
 =?us-ascii?Q?7Nq7YCY4DBWXucX6a4vD50TCS6pp3CKxybfNcZuwmTgHI4NEioIdNbqhEwlA?=
 =?us-ascii?Q?VOqSp5yYaYp3SY4ooHDXbmkukO8RuomoBiDiTz9aPZl1UR/oNjgFPdWzyWiD?=
 =?us-ascii?Q?JPX8kkbtk3UXCRWnH+L5Nn44VDbUK/wCcRGwawfyvdbKhlaEpUt9MZXMt3VL?=
 =?us-ascii?Q?QJLz+a1Fu48/RJgscGE4F97gsztkXHUkRi8HQH4wuhZRsAgiCnWQbtZn0QUl?=
 =?us-ascii?Q?YvVjMpdTeEdd4YFSPsSKzPLtx7XR6Aq9X/z66cNYUmXYzEul+vnGok89I/hS?=
 =?us-ascii?Q?sRKNW35pVY6OxSrOcvazV4SWhh0c2F8JAQL8aTz/lEYI/BDFoM+yife9NoIA?=
 =?us-ascii?Q?VhoG+eRBbmGsat6HNJXAGDtkdFu49NMGtq6uYrJ2OkVM0ZeYuo5MM2SWMGG9?=
 =?us-ascii?Q?pzM5Y/kl4Jw1VqVTeOyG0dCUm534zduVz3PFgHwdhmT40pClwEp7FURPA1dH?=
 =?us-ascii?Q?zKh5DSSHvN/Vqjl4d3Vd8HqRZdWqDPnge6WhWo/uRxnNqCF9jXko+kMsNsEY?=
 =?us-ascii?Q?YqmW2DoI6lINZ1l8Xh4xO61JxcXawKachSUxSRCwEcJpy9GJdIjlUvFwWhE1?=
 =?us-ascii?Q?g84jPCC1gYG12vXXqDjECNTavIZxu49TjhKlrtfFIVefTl/evISKpqouZ6g/?=
 =?us-ascii?Q?c4StYmoNgwRY2c=3D?=
X-Microsoft-Antispam-Message-Info: AYMmKkIC9QH6UQ29pJfmPgDePXf0YBQtZCRb0ajq3pN0dv1iOZZ5a4VhPafBJIf0lNp9JBPVED/Mis4+PcM/D7WWmRQR5E+PYAuWbkILy0a/+X/XwFO4jKNhM/gHkHDRa161DAhntqkrqRKMCJii0UKYFUtU6h+aV60LwktC5uy8nyC8nrSKtVmsTizwVU3iy9gGBkMxl9EwQsWhRcBse3L7SUJdYp0s2j0tn9wgoFf+ycTer63eJ3b+AIjM/UINnScvj2Y4+sDVm1o+BRSlAcPGX5V5/YX2MF+UERVR7sHpg0IDi1q/nDq2l9cYZ0cF42MW3obccEEtfZcW+iko9iXZT+D/g73BHOpt8J1dcgs=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2679;6:FXxU57FfaS+e2s/F68a3r6gN1MilM4vnfMwU0Nfz8d5kGK3DlYQP8ikiFn/998gD3fmcTQjqCGyE2jQlpbUqd+JhHlc1LgiRi5QwzQlwJIxpKAe6JxV2tRTbMpKDJ0lL0qrpUsbg2xzk2tLrQo9HblTBIuv9npYOw2Y0X4xcGZ/Lw3ezIgghyqqkspb4ByG7sidDlc+Zq6Ys3i48FUn/2JPzBPIug9nDQIid4A289DT7hRxSyIvZayeGJrTHgnIcqKrwWaFkwjq9V+EHuag8h27S6jLlRWfbGqZi4F3uhM54uFZEw8JOndw0CQjfB6x/2bSBwjHQ0NRYxG8tIf5HlvWun27VtBcm+wxBAKvFov/Ymx87d9F3iJMJ/7WTnHdX1Z2gRReA9S+QKURtakiv13mtkBFUHnf5iieqadLoXDD/s9DQuVYo7Fag/qpHk1RNqxhWyxRUu/j0IP6N+fXQ/g==;5:ILitFJoSRNdH419fCRNdBhupswrgLb35mtuUQvA6piGv9ETEprnKavwgDMs42hCPo/jwtTY2xb4R3znDLn0PiGktzzT2C/mZKZOePFEGQsZKeE3U6ftYbM4r7NQUxNsyo+gLHl16FowobHzCPAIHC00lqsIrNn3d1WXfxbsArl0=;7:Gw7H9CyVGHMUNUL58NMgB44vg/+gxnEPnwH5QStEPw9mGXtjRgfGgoacpR3VobykbtSm3VCOmVL2BWUTYaVqN4pOJAX8AeDYY8ftvysqoUTEHRvYqCbBgmKc+CcgnOu3FCmH0RUBtShAELd9KfFWQ1QwWVG54YYfPrZZ07oVPPMgDuV8DVSXjDCVVygcU59CdtqTq8+p/F9ihGYXWtEd48eIjUBprw0ZRDKCZ83x8bR/EfII5BNEAc0gnIqi8rAv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 06:41:10.5751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de60f0-f3a2-4f87-6aae-08d612fa9165
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Moved reset node as a child to firwmare
		 node.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 142 +++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..351b1bb 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,144 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible:	"xlnx,zynqmp-reset"
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+Reset outputs:
+	0   :PCIE config reset.
+	1   :PCIE bridge block level reset (AXI interface).
+	2   :PCIE control block level,reset.
+	3   :Display Port block level reset (includes DPDMA).
+	4   :FPD WDT reset.
+	5   :AF_FM5 block level reset.
+	6   :AF_FM4 block level reset.
+	7   :AF_FM3 block level reset.
+	8   :AF_FM2 block level reset.
+	9   :AF_FM1 block level reset.
+	10  :AF_FM0 block level reset.
+	11  :GDMA block level reset.
+	12  :Pixel Processor (GPU_PP1) block level reset.
+	13  :Pixel Processor (GPU_PP0) block level reset.
+	14  :GPU block level reset.
+	15  :GT block level reset.
+	16  :Sata block level reset.
+	17  :ACPU3 power on reset.
+	18  :ACPU2 power on reset.
+	19  :ACPU1 power on reset.
+	20  :ACPU0 power on reset.
+	21  :APU L2 reset.
+	22  :ACPU3 reset.
+	23  :ACPU2 reset.
+	24  :ACPU1 reset.
+	25  :ACPU0 reset.
+	26  :DDR block level reset inside of the DDR Sub System.
+	27  :APM block level reset inside of the DDR Sub System.
+	28  :soft reset.
+	29  :GEM 0 reset.
+	30  :GEM 1 reset.
+	31  :GEM 2 reset.
+	32  :GEM 3 reset.
+	33  :qspi reset.
+	34  :uart0 reset.
+	35  :uart1 reset.
+	36  :spi0 reset.
+	37  :spi1 reset.
+	38  :sdio0 reset.
+	39  :sdio1 reset.
+	40  :can0 reset.
+	41  :can1 reset.
+	42  :i2c0 reset.
+	43  :i2c1 reset.
+	44  :ttc0 reset.
+	45  :ttc1 reset.
+	46  :ttc2 reset.
+	47  :ttc3 reset.
+	48  :swdt reset.
+	49  :nand reset.
+	50  :adma reset.
+	51  :gpio reset.
+	52  :iou_cc reset.
+	53  :timestamp reset.
+	54  :rpu_r50 reset.
+	55  :rpu r51 reset.
+	56  :rpu_amba reset.
+	57  :ocm reset.
+	58  :rpu_pge reset.
+	59  :usb0_core reset.
+	60  :usb1_core reset.
+	61  :usb0_hiber reset.
+	62  :usb1_hiber reset.
+	63  :usb0_apb reset.
+	64  :usb1_apb reset.
+	65  :ipi reset.
+	66  :apm reset.
+	67  :rtc reset.
+	68  :sysmon reset.
+	69  :afi_fm6 reset.
+	70  :lpd_swdt reset.
+	71  :fpd_reset.
+	72  :rpu_dbg1 reset.
+	73  :rpu_dbg0 reset.
+	74  :dbg_lpd reset.
+	75  :dbg_fpd reset.
+	76  :apll reset.
+	77  :dpll reset.
+	78  :vpll reset.
+	79  :iopll reset.
+	80  :rpll reset.
+	81  :gpio_pl_0 reset.
+	82  :gpio_pl_1 reset.
+	83  :gpio_pl_2 reset.
+	84  :gpio_pl_3 reset.
+	85  :gpio_pl_4 reset.
+	86  :gpio_pl_5 reset.
+	87  :gpio_pl_6 reset.
+	88  :gpio_pl_7 reset.
+	89  :gpio_pl_8 reset.
+	90  :gpio_pl_9 reset.
+	91  :gpio_pl_10 reset.
+	92  :gpio_pl_11 reset.
+	93  :gpio_pl_12 reset.
+	94  :gpio_pl_13 reset.
+	95  :gpio_pl_14 reset.
+	96  :gpio_pl_15 reset.
+	97  :gpio_pl_16 reset.
+	98  :gpio_pl_17 reset.
+	99  :gpio_pl_18 reset.
+	100 :gpio_pl_19 reset.
+	101 :gpio_pl_20 reset.
+	102 :gpio_pl_21 reset.
+	103 :gpio_pl_22 reset.
+	104 :gpio_pl_23 reset.
+	105 :gpio_pl_24 reset.
+	106 :gpio_pl_25 reset.
+	107 :gpio_pl_26 reset.
+	108 :gpio_pl_27 reset.
+	109 :gpio_pl_28 reset.
+	110 :gpio_pl_29 reset.
+	111 :gpio_pl_30 reset.
+	112 :gpio_pl_31 reset.
+	113 :rpu_ls reset.
+	114 :ps_only reset.
+	115 :pl reset.
+	116 :ps_pl0 reset
+	117 :ps_pl1 reset
+	118 :ps_pl2 reset
+	119 :ps_pl3 reset
+
 -------
 Example
 -------
@@ -25,5 +163,9 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		reset-controller:reset-controller@0 {
+			compatible = "xlnx,zynqmp-reset";
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.7.4

