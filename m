Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D516EC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946C32085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Y31ZAOvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfATRkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:40:09 -0500
Received: from mail-eopbgr790071.outbound.protection.outlook.com ([40.107.79.71]:41448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfATRkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF81Ebz/i1HNTI9kWeRGPVYV6q5ca1KtBsKg68aXIyg=;
 b=Y31ZAOvyV71Xw+YXlsqdxmDe1b/Rmbyuopcv2NopwhtJPMzCIQx0TNUaDEZz4Sh9s6JVUkVLX8VvFKGI93xceLE92/NqHVcQ0rjadlRo/yrcjDHE36g4D9VXb6ZIqMd3VfkMpmFaSZUBow3kx+Z4v66yvdrPV0VmrOa3vrYgBeI=
Received: from DM6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:5:1c::23) by
 DM6PR02MB4458.namprd02.prod.outlook.com (2603:10b6:5:29::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Sun, 20 Jan 2019 17:40:04 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR02CA0010.outlook.office365.com
 (2603:10b6:5:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.24 via Frontend
 Transport; Sun, 20 Jan 2019 17:40:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:40:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56606 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4l-0001kq-Fj; Sun, 20 Jan 2019 09:40:03 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4g-0002wC-B3; Sun, 20 Jan 2019 09:39:58 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHdpB7022699;
        Sun, 20 Jan 2019 09:39:51 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4Y-0002tH-Oz; Sun, 20 Jan 2019 09:39:51 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>,
        <robh+dt@kernel.org>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 4/6] dt-bindings: pinctrl: Add ZynqMP pin controller bindings
Date:   Mon, 21 Jan 2019 23:08:33 +0530
Message-ID: <20190121173835.21173-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121173835.21173-1-nava.manne@xilinx.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(376002)(346002)(2980300002)(189003)(199004)(2906002)(63266004)(336012)(106466001)(16586007)(186003)(50466002)(106002)(316002)(2201001)(478600001)(39060400002)(305945005)(4326008)(107886003)(14444005)(54906003)(110136005)(8676002)(8936002)(81156014)(81166006)(50226002)(356004)(6666004)(47776003)(7696005)(51416003)(76176011)(9786002)(1076003)(30864003)(426003)(486006)(48376002)(11346002)(36386004)(2616005)(77096007)(476003)(26005)(446003)(126002)(36756003)(42866002)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4458;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT018;1:AiRVTl9RB/pK8VYLeWghO8Y7oH/E7jj3El8N/pi/qtDemJGTx1X2ruaxKziq+SDY2ZNo3VEG6W4gC0zNPJRTR6uxWXfJVwOTtCONbs+eHjzdOsKp80WXFLVW6KQHtTV4k7LDl36l4oZB5iyLevQnNMEcYJiF/pVfCsMIWYj7MkQ=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db6009ac-492f-4a9f-d32f-08d67efe4fa8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;3:x7V8Z3UFp2J/rFM5Z3Yi20X9J97Fv8JDDGG70ssd1hijeEQlxJ9DkleoQP2xIRL0lMoVKSq0ZvC6fU7en+JpvthIamEtB4H6wTWUeRuzHc2CDEE+ObS4Vz3U+6YDbooh5SUhIzlT0g1kozxeFSHbPkyVHbU/wWj6NnmVW8S+6ZC+nqAzGj+NVbSV3x9dWvL2L/elARzsZ+L2sJqYAPXlfss+2Y9BMYUeMQVIKkEL4tmdvsZTEdnNSQf0/Zj8EuT51gsfgkrI3eOuB5XtjAKTgRnHF0ieUZipUd5sOdZn4qHtDUCAxODKEnriSqzGkl6rz6m8a6ecTdRfYRncMq2iXlBUw20iFq9pwXqow35P6tCHkqQaD8bwPZG4lK33klZT;25:CU3lDYIcTcD+0dXk5efLFekEiekWpguCK3BybB2gCQSbKQ2iQDw2v0H1xSo10YYr1FNPhK9kAhlrsT2C9ovcKLTSlwP5TysnifJspz2t6IVUHUuTN13NiKDLGCiNzJ2DtIIedz76mA4MuqUQEaTsulr+C5atDSXqD1LmiVat+q4SH60iqP5E0EBPU3rSKmDq+hxHMQaxR/6SXgAZMzZN7NCY5z/8y/lGiVL9clG57IA6R1dCwALsG6AX5UMC13y91J2wwSYI/E/7zrJkFcuoscKlEfB+g4JALLmSy6dEOUgLKDu0xxz7T+xnipp3VGouOOABqZR2LLGE8z5euAD3Zg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;31:Exat3TwrvOnmswqGq0xA0LzxXCt8TyS2CiEogtdxrehvRmhUCBXfT51+XaqtZeCOeEkhahcxoYEV/9tyKOPmfxTZczzt2eAz7xV6dHUHEQ80WbNdvxnEFX1042bCpCpzibXnShRuDiGdptA2imUVz6oRRyghFeyo5clbsjI4NQpSK8evmjq/HWK6ygpgGF5p0aV4LyMtdSHFcxfb4wY5KiM6pYtSFp3zAIErY/xAkYE=;20:sqsJgazfh2g9wa3DUp/30xRcrzfSwg3Y4dLdt/x1ccVAvGVwEfLZ8q+02hagGkRPGje2faz9DdjUcDOC9TFxoFB2cWLUviZc/lDn2DjmenvfunQoWTRjn9CEBzMHxwlhxfWTmMDdzm5qT0d8bav98kwpJPaybzUnAFEESDw69VDyt0JejDirHUcZ2OsELiC1SVi1YsIci5XpKwzemsbKaO9hS09mgl/Y8lVjw+r+ihLghOy0SqvEiQEMOGMQg3B+PiZHXGUphJrONNVxvZm5eSFx9YsjszLY2Pxcb941F0N/Gki/bhJK878HyD13UaMO2Bcgf44sj57MKxSI7e1a4BrzLuKbxevQWnYqrf1yuZ6B0Bhftgk5iUgDuVonksHMZ7IWndxhzYi4imfL1WeLWEg8WCsOQNc1NV15MymQwbsd6h8/m6ibeKiQ5+zosCMHV8oGo4UfzrrjyAug7SjgC11YJTgGymlR3znmU6oeVoA/VT2qc1DDoamDG5zMJ7tt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB445829B52B8D9B66C9D87F59C29E0@DM6PR02MB4458.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;4:XkNiPdTmPzXwb0u0lO20FXoNjz53OS8eQYyPxbcIKkUVK/Ag1Z3snIavgdzffsnHZ8dfgoTUpAga1UgcP+8iinscGNTV9uEnAXNAf+5iq+Y77sv6v3yLt03mX1tnXHbD/tNVuUgC21G7Vl0Ak882aqmAR02tky1OIfQH71blHpdhyxLSCwAYwYUJqlcnQqyGKuoU5DsHy0bEUg6Fi4477UhBPBWe8k2Uffh0SkTh6esoKr0TRmaF389kaWG1Xxit+vB0BAlWgPHQSu97QgNGgpjbdk+XY4rNGoEq+VRGVYM=
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4458;23:Z/3P0d9cnxCvHT/2lpIAvrRu3kIDo/gy9Rk1PoR4g?=
 =?us-ascii?Q?xMOYFg4GaLd7xbg/fzZQm5POdD2oyIEvewNCmb9wq4m1Fk62uiUl8Y9Rz5BO?=
 =?us-ascii?Q?CxSZ3CgzPm56taA5lGtjnKxq16OMB6zyG3W4TO8WzybXGdPP0cq8jBVLAUfk?=
 =?us-ascii?Q?/tRe33hnOPC9TjaWINsc6smPflYUTM9BJDRaNMhV8HFYA5zOkRRaVD+Wmb7b?=
 =?us-ascii?Q?768h7+bGBS6gqQ7e/t4UsMELmRzJYJH4rSObo0mbi85IRNZe8vnoclfSkI9K?=
 =?us-ascii?Q?utBm8xpjVU+W8mQ1a/vk4Pr1PPdXyk5nixRDj5vpyLPQeCsuKsUu5QbRjJCr?=
 =?us-ascii?Q?5IG7zgIsPQByhygNyYYM/JuyDx4ILWUiJlyQWRGrf0gndLk+QESs+GFdFwKZ?=
 =?us-ascii?Q?5Bvd6P2/QBl9LbisfeJsML/BOvWM7Dq7O5xImndUWd5SNxRiMC9bKi9pwOKp?=
 =?us-ascii?Q?o9uIn42Z3jo4+zeEdlHoIHuS04jXjDc0ND3l+j46YnKjNQ3N5IV40FjaiRuV?=
 =?us-ascii?Q?61jBukFY2pz8+Ma0qoOqyvwZdN3MH/i+PyxaL5XJzGbFu441tS9z3OraDxAF?=
 =?us-ascii?Q?9SQqTRrH1Sj3BzQ+h8mkVJW3N7e0eu3jWDgZwWEwI0eEtUfUao7ZiQTchnWA?=
 =?us-ascii?Q?QB6N5zC2RYBK1pZSCrd+xuyHYp6vpnIAVHSERa7ngq1sBZLo/qlHnMHOVUF/?=
 =?us-ascii?Q?uuQCaY4eh5zy2lSkuAjzMbitAEUmltEhoWdX5i623viT4hpsKQN0K651dHHi?=
 =?us-ascii?Q?wZQJhTJxhX5zxjnD3n7TcvoBTnssTKvBK3HcDTjCTv3ViTJbuDRbuz2uTC7v?=
 =?us-ascii?Q?RQrq9/tMhhxIjDkxpTQd9be0HGmDz67yAQmNPR247b4DLYkOkZ3eM0H647PG?=
 =?us-ascii?Q?6OwRhR/kqVqox9FXZFYB/zIiZzDujHLOj4QRXJSKTONsE9HoPm9c6wE7et4n?=
 =?us-ascii?Q?ReJ5SVvnz94s4es6Ws+cjRZvhnxif182afGu8w2pS+iJGe+BkV/tfo4QhNI2?=
 =?us-ascii?Q?niHQH7vaIb6W1QEjlK2M/ZoaeHDzXjAjB9P1f8w4ul8TmniQcuLF/w/uoq7o?=
 =?us-ascii?Q?oubIrUxicInnNNdtrtzFepVq8LgJ0JPqjqZvELyFu1W2xFB9nvnxlW0jqwzC?=
 =?us-ascii?Q?n0qUdY0JM98tudf9MB0pNEinzh6WMlAvWkznrAeK1Us48fhuVJ8DajwaOkCK?=
 =?us-ascii?Q?5a2qUDMrXIa5/tuBkoXvvWyhATXWzKyoxUscbNYzhvJKJwhK0hWerpBl125S?=
 =?us-ascii?Q?16gbN6ZeLbDYzKJqf8=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5uqu+QkU6ArUytCna7kPldjJEhZQEmtUFVfk6NLdAyvjYmuz+6o1z314yJZEGla8rnh0E5octALInyKf/s7aN0D3ueYONpjiSOsoP0As7ZPBThVFEGV+y8TvEvzFMgTcvnHnzAxpdtCIuTbDBz2a49CTKGXQCQZEDlGwRC15CRNMli8Z0ryf1bpcN8BWB6jqJZt7URljXCu5xpftoDxceHmdPIsO6ATeZPH1xyHKdFUXqmI50oXFOOZ8gQcvjI3ZV9zhv9PWawo24ea5cFgpJpMdsfkMmGBcBA45lB+UNYkxXP/skFyx9H7UgHwdbOi1J5NBv/zF6elQw6+JYY9KjcnB0ufP2IwQUbsbP/WCXxuymIsUB5UgNvTFjeXlNqgOih6E71LEbveb6ZZn5EqOf2ib2Nclc6PdbYmusFAUlG0=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;6:riekQuIgHZqtkqMi/LxbXxbmVKy3p293aD8hxZDRFGj0numOhn5Vhlgn7IZbw5LyAEDqq3fWKHEl+HqcFS8Jlnkh8bhIJNnNtr7WBL+244MPhrS+y5Q3NEIg+zBp0QVrjlenLlksbW8YlHovZipsUe3fzBt+vhgTv1ofinJha+r1PlBtsnqJTrHWLbeSkzKEMeyRhNe4sdF6s79zZwWOiY9lNmHsfFpPRUi4SyhiceG0SSZlex8bhqi5S18XiZuZJjFjFXt1cWfgWPbB2M/a9C07gY/zyrRsQyxbIJu/UceehqLtAnPx+t8zd+DiAOgss6g9rQJbhDntVOVJdRI9d7yI+Ke+j35cxLJo8uaLt/svT/8exDK3nqcILA/mAB856t7yY5zw1840ssk11ljqNCbSqEpA5MWiB1Ao0jPEJW0a57NWgVuh6BK0aMAcex8moNCidKh4vFEst+dUHugigw==;5:VCWILgVjrAoHGVe9YB0mxuNlCRTI6QaA6unwg7cFnMOlWOYepGUbcrOpNWus/tDC8vca1Tx7w6XrShGhxercpWZv/Cm9oQUzazZI502Jws45TAm3w36ZoJB1tLeZ1UDGEor8eAPBn5xpzfcH+W7swP20YDc9BwHp0nGSsxkKXFnfvz8vNDGQ/GQMJbxo7Mr/zbBOnuuEuHUaSNiQA6H6CA==;7:/jjzrUK39OgAeuvzeg8WqpGUaZmr5MZcTsRM1j8HaoBppxWfPxOjNgwasTa1t97Z0pE/jvJT9VTLsihYwXm02/CQlmnLMX8R1HyAoF3rSWMhkaZk33y7rRaIedBfQFHgYrlcDREZaGDyU48yJqCWig==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:40:03.9167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6009ac-492f-4a9f-d32f-08d67efe4fa8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP pin controller
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
		-None.

 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt  | 275 ++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
new file mode 100644
index 000000000000..acf44a5d3778
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
@@ -0,0 +1,275 @@
+	Binding for Xilinx ZynqMP Pinctrl
+
+Required properties:
+- compatible: "xlnx,zynqmp-pinctrl"
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+ZynqMP's pin configuration nodes act as a container for an arbitrary number of
+subnodes. Each of these subnodes represents some desired configuration for a
+pin, a group, or a list of pins or groups. This configuration can include the
+mux function to select on those pin(s)/group(s), and various pin configuration
+parameters, such as pull-up, slew rate, etc.
+
+Each configuration node can consist of multiple nodes describing the pinmux and
+pinconf options. Those nodes can be pinmux nodes or pinconf nodes.
+
+The name of each subnode is not important; all subnodes should be enumerated
+and processed purely based on their content.
+
+Required properties for pinmux nodes are:
+ - groups: A list of pinmux groups.
+ - function: The name of a pinmux function to activate for the specified set
+   of groups.
+
+Required properties for configuration nodes:
+One of:
+ - pins: A list of pin names
+ - groups: A list of pinmux groups.
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pinmux subnode:
+ groups, function
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pinconf subnode:
+ groups, pins, bias-disable, bias-pull-up, bias-pull-down, slew-rate
+
+ Valid arguments for 'slew-rate' are 'SLEW_RATE_SLOW' and 'SLEW_RATE_FAST' to
+ select between slow and fast respectively.
+
+ Valid values for groups are:
+ ethernet0_0_grp, ethernet1_0_grp, ethernet2_0_grp,
+ ethernet3_0_grp, gemtsu0_0_grp, gemtsu0_1_grp,
+ gemtsu0_2_grp, mdio0_0_grp, mdio1_0_grp,
+ mdio1_1_grp, mdio2_0_grp, mdio3_0_grp,
+ qspi0_0_grp, qspi_ss_0_grp, qspi_fbclk_0_grp,
+ spi0_0_grp, spi0_ss_0_grp, spi0_ss_1_grp,
+ spi0_ss_2_grp, spi0_1_grp, spi0_ss_3_grp,
+ spi0_ss_4_grp, spi0_ss_5_grp, spi0_2_grp,
+ spi0_ss_6_grp, spi0_ss_7_grp, spi0_ss_8_grp,
+ spi0_3_grp, spi0_ss_9_grp, spi0_ss_10_grp,
+ spi0_ss_11_grp, spi0_4_grp, spi0_ss_12_grp,
+ spi0_ss_13_grp, spi0_ss_14_grp, spi0_5_grp,
+ spi0_ss_15_grp, spi0_ss_16_grp, spi0_ss_17_grp,
+ spi1_0_grp, spi1_ss_0_grp, spi1_ss_1_grp,
+ spi1_ss_2_grp, spi1_1_grp, spi1_ss_3_grp,
+ spi1_ss_4_grp, spi1_ss_5_grp, spi1_2_grp,
+ spi1_ss_6_grp, spi1_ss_7_grp, spi1_ss_8_grp,
+ spi1_3_grp, spi1_ss_9_grp, spi1_ss_10_grp,
+ spi1_ss_11_grp, spi1_4_grp, spi1_ss_12_grp,
+ spi1_ss_13_grp, spi1_ss_14_grp, spi1_5_grp,
+ spi1_ss_15_grp, spi1_ss_16_grp, spi1_ss_17_grp,
+ sdio0_0_grp, sdio0_1_grp, sdio0_2_grp,
+ sdio0_3_grp, sdio0_4_grp, sdio0_5_grp,
+ sdio0_6_grp, sdio0_7_grp, sdio0_8_grp,
+ sdio0_9_grp, sdio0_10_grp, sdio0_11_grp,
+ sdio0_12_grp, sdio0_13_grp, sdio0_14_grp,
+ sdio0_15_grp, sdio0_16_grp, sdio0_17_grp,
+ sdio0_18_grp, sdio0_19_grp, sdio0_20_grp,
+ sdio0_21_grp, sdio0_22_grp, sdio0_23_grp,
+ sdio0_24_grp, sdio0_25_grp, sdio0_26_grp,
+ sdio0_27_grp, sdio0_28_grp, sdio0_29_grp,
+ sdio0_30_grp, sdio0_31_grp, sdio0_32_grp,
+ sdio0_pc_0_grp, sdio0_cd_0_grp, sdio0_wp_0_grp,
+ sdio0_pc_1_grp, sdio0_cd_1_grp, sdio0_wp_1_grp,
+ sdio0_pc_2_grp, sdio0_cd_2_grp, sdio0_wp_2_grp,
+ sdio1_0_grp, sdio1_1_grp, sdio1_2_grp,
+ sdio1_3_grp, sdio1_4_grp, sdio1_5_grp,
+ sdio1_6_grp, sdio1_7_grp, sdio1_8_grp,
+ sdio1_9_grp, sdio1_10_grp, sdio1_11_grp,
+ sdio1_12_grp, sdio1_13_grp, sdio1_14_grp,
+ sdio1_15_grp, sdio1_pc_0_grp, sdio1_cd_0_grp,
+ sdio1_wp_0_grp, sdio1_pc_1_grp, sdio1_cd_1_grp,
+ sdio1_wp_1_grp, nand0_0_grp, nand0_ce_0_grp,
+ nand0_rb_0_grp, nand0_dqs_0_grp, nand0_ce_1_grp,
+ nand0_rb_1_grp, nand0_dqs_1_grp, can0_0_grp,
+ can0_1_grp, can0_2_grp, can0_3_grp,
+ can0_4_grp, can0_5_grp, can0_6_grp,
+ can0_7_grp, can0_8_grp, can0_9_grp,
+ can0_10_grp, can0_11_grp, can0_12_grp,
+ can0_13_grp, can0_14_grp, can0_15_grp,
+ can0_16_grp, can0_17_grp, can0_18_grp,
+ can1_0_grp, can1_1_grp, can1_2_grp,
+ can1_3_grp, can1_4_grp, can1_5_grp,
+ can1_6_grp, can1_7_grp, can1_8_grp,
+ can1_9_grp, can1_10_grp, can1_11_grp,
+ can1_12_grp, can1_13_grp, can1_14_grp,
+ can1_15_grp, can1_16_grp, can1_17_grp,
+ can1_18_grp, can1_19_grp, uart0_0_grp,
+ uart0_1_grp, uart0_2_grp, uart0_3_grp,
+ uart0_4_grp, uart0_5_grp, uart0_6_grp,
+ uart0_7_grp, uart0_8_grp, uart0_9_grp,
+ uart0_10_grp, uart0_11_grp, uart0_12_grp,
+ uart0_13_grp, uart0_14_grp, uart0_15_grp,
+ uart0_16_grp, uart0_17_grp, uart0_18_grp,
+ uart1_0_grp, uart1_1_grp, uart1_2_grp,
+ uart1_3_grp, uart1_4_grp, uart1_5_grp,
+ uart1_6_grp, uart1_7_grp, uart1_8_grp,
+ uart1_9_grp, uart1_10_grp, uart1_11_grp,
+ uart1_12_grp, uart1_13_grp, uart1_14_grp,
+ uart1_15_grp, uart1_16_grp, uart1_17_grp,
+ uart1_18_grp, i2c0_0_grp, i2c0_1_grp,
+ i2c0_2_grp, i2c0_3_grp, i2c0_4_grp,
+ i2c0_5_grp, i2c0_6_grp, i2c0_7_grp,
+ i2c0_8_grp, i2c0_9_grp, i2c0_10_grp,
+ i2c0_11_grp, i2c0_12_grp, i2c0_13_grp,
+ i2c0_14_grp, i2c0_15_grp, i2c0_16_grp,
+ i2c0_17_grp, i2c0_18_grp, i2c1_0_grp,
+ i2c1_1_grp, i2c1_2_grp, i2c1_3_grp,
+ i2c1_4_grp, i2c1_5_grp, i2c1_6_grp,
+ i2c1_7_grp, i2c1_8_grp, i2c1_9_grp,
+ i2c1_10_grp, i2c1_11_grp, i2c1_12_grp,
+ i2c1_13_grp, i2c1_14_grp, i2c1_15_grp,
+ i2c1_16_grp, i2c1_17_grp, i2c1_18_grp,
+ i2c1_19_grp, ttc0_clk_0_grp, ttc0_wav_0_grp,
+ ttc0_clk_1_grp, ttc0_wav_1_grp, ttc0_clk_2_grp,
+ ttc0_wav_2_grp, ttc0_clk_3_grp, ttc0_wav_3_grp,
+ ttc0_clk_4_grp, ttc0_wav_4_grp, ttc0_clk_5_grp,
+ ttc0_wav_5_grp, ttc0_clk_6_grp, ttc0_wav_6_grp,
+ ttc0_clk_7_grp, ttc0_wav_7_grp, ttc0_clk_8_grp,
+ ttc0_wav_8_grp, ttc1_clk_0_grp, ttc1_wav_0_grp,
+ ttc1_clk_1_grp, ttc1_wav_1_grp, ttc1_clk_2_grp,
+ ttc1_wav_2_grp, ttc1_clk_3_grp, ttc1_wav_3_grp,
+ ttc1_clk_4_grp, ttc1_wav_4_grp, ttc1_clk_5_grp,
+ ttc1_wav_5_grp, ttc1_clk_6_grp, ttc1_wav_6_grp,
+ ttc1_clk_7_grp, ttc1_wav_7_grp, ttc1_clk_8_grp,
+ ttc1_wav_8_grp, ttc2_clk_0_grp, ttc2_wav_0_grp,
+ ttc2_clk_1_grp, ttc2_wav_1_grp, ttc2_clk_2_grp,
+ ttc2_wav_2_grp, ttc2_clk_3_grp, ttc2_wav_3_grp,
+ ttc2_clk_4_grp, ttc2_wav_4_grp, ttc2_clk_5_grp,
+ ttc2_wav_5_grp, ttc2_clk_6_grp, ttc2_wav_6_grp,
+ ttc2_clk_7_grp, ttc2_wav_7_grp, ttc2_clk_8_grp,
+ ttc2_wav_8_grp, ttc3_clk_0_grp, ttc3_wav_0_grp,
+ ttc3_clk_1_grp, ttc3_wav_1_grp, ttc3_clk_2_grp,
+ ttc3_wav_2_grp, ttc3_clk_3_grp, ttc3_wav_3_grp,
+ ttc3_clk_4_grp, ttc3_wav_4_grp, ttc3_clk_5_grp,
+ ttc3_wav_5_grp, ttc3_clk_6_grp, ttc3_wav_6_grp,
+ ttc3_clk_7_grp, ttc3_wav_7_grp, ttc3_clk_8_grp,
+ ttc3_wav_8_grp, swdt0_clk_0_grp, swdt0_rst_0_grp,
+ swdt0_clk_1_grp, swdt0_rst_1_grp, swdt0_clk_2_grp,
+ swdt0_rst_2_grp, swdt0_clk_3_grp, swdt0_rst_3_grp,
+ swdt0_clk_4_grp, swdt0_rst_4_grp, swdt0_clk_5_grp,
+ swdt0_rst_5_grp, swdt0_clk_6_grp, swdt0_rst_6_grp,
+ swdt0_clk_7_grp, swdt0_rst_7_grp, swdt0_clk_8_grp,
+ swdt0_rst_8_grp, swdt0_clk_9_grp, swdt0_rst_9_grp,
+ swdt0_clk_10_grp, swdt0_rst_10_grp, swdt0_clk_11_grp,
+ swdt0_rst_11_grp, swdt0_clk_12_grp, swdt0_rst_12_grp,
+ swdt1_clk_0_grp, swdt1_rst_0_grp, swdt1_clk_1_grp,
+ swdt1_rst_1_grp, swdt1_clk_2_grp, swdt1_rst_2_grp,
+ swdt1_clk_3_grp, swdt1_rst_3_grp, swdt1_clk_4_grp,
+ swdt1_rst_4_grp, swdt1_clk_5_grp, swdt1_rst_5_grp,
+ swdt1_clk_6_grp, swdt1_rst_6_grp, swdt1_clk_7_grp,
+ swdt1_rst_7_grp, swdt1_clk_8_grp, swdt1_rst_8_grp,
+ swdt1_clk_9_grp, swdt1_rst_9_grp, swdt1_clk_10_grp,
+ swdt1_rst_10_grp, swdt1_clk_11_grp, swdt1_rst_11_grp,
+ swdt1_clk_12_grp, swdt1_rst_12_grp, gpio0_0_grp,
+ gpio0_1_grp, gpio0_2_grp, gpio0_3_grp,
+ gpio0_4_grp, gpio0_5_grp, gpio0_6_grp,
+ gpio0_7_grp, gpio0_8_grp, gpio0_9_grp,
+ gpio0_10_grp, gpio0_11_grp, gpio0_12_grp,
+ gpio0_13_grp, gpio0_14_grp, gpio0_15_grp,
+ gpio0_16_grp, gpio0_17_grp, gpio0_18_grp,
+ gpio0_19_grp, gpio0_20_grp, gpio0_21_grp,
+ gpio0_22_grp, gpio0_23_grp, gpio0_24_grp,
+ gpio0_25_grp, gpio0_26_grp, gpio0_27_grp,
+ gpio0_28_grp, gpio0_29_grp, gpio0_30_grp,
+ gpio0_31_grp, gpio0_32_grp, gpio0_33_grp,
+ gpio0_34_grp, gpio0_35_grp, gpio0_36_grp,
+ gpio0_37_grp, gpio0_38_grp, gpio0_39_grp,
+ gpio0_40_grp, gpio0_41_grp, gpio0_42_grp,
+ gpio0_43_grp, gpio0_44_grp, gpio0_45_grp,
+ gpio0_46_grp, gpio0_47_grp, gpio0_48_grp,
+ gpio0_49_grp, gpio0_50_grp, gpio0_51_grp,
+ gpio0_52_grp, gpio0_53_grp, gpio0_54_grp,
+ gpio0_55_grp, gpio0_56_grp, gpio0_57_grp,
+ gpio0_58_grp, gpio0_59_grp, gpio0_60_grp,
+ gpio0_61_grp, gpio0_62_grp, gpio0_63_grp,
+ gpio0_64_grp, gpio0_65_grp, gpio0_66_grp,
+ gpio0_67_grp, gpio0_68_grp, gpio0_69_grp,
+ gpio0_70_grp, gpio0_71_grp, gpio0_72_grp,
+ gpio0_73_grp, gpio0_74_grp, gpio0_75_grp,
+ gpio0_76_grp, gpio0_77_grp, usb0_0_grp,
+ usb1_0_grp, pmu0_0_grp, pmu0_1_grp,
+ pmu0_2_grp, pmu0_3_grp, pmu0_4_grp,
+ pmu0_5_grp, pmu0_6_grp, pmu0_7_grp,
+ pmu0_8_grp, pmu0_9_grp, pmu0_10_grp,
+ pmu0_11_grp, pcie0_0_grp, pcie0_1_grp,
+ pcie0_2_grp, pcie0_3_grp, pcie0_4_grp,
+ pcie0_5_grp, pcie0_6_grp, pcie0_7_grp,
+ csu0_0_grp, csu0_1_grp, csu0_2_grp,
+ csu0_3_grp, csu0_4_grp, csu0_5_grp,
+ csu0_6_grp, csu0_7_grp, csu0_8_grp,
+ csu0_9_grp, csu0_10_grp, csu0_11_grp,
+ dpaux0_0_grp, dpaux0_1_grp, dpaux0_2_grp,
+ dpaux0_3_grp, pjtag0_0_grp, pjtag0_1_grp,
+ pjtag0_2_grp, pjtag0_3_grp, pjtag0_4_grp,
+ pjtag0_5_grp, trace0_0_grp, trace0_clk_0_grp,
+ trace0_1_grp, trace0_clk_1_grp, trace0_2_grp,
+ trace0_clk_2_grp, testscan0_0_grp
+
+ Valid values for pins are:
+   MIO0 - MIO77
+
+ Valid values for function are:
+   ethernet0, ethernet1, ethernet2, ethernet3, gemtsu0, usb0, usb1, mdio0,
+   mdio1, mdio2, mdio3, qspi0, qspi_fbclk, qspi_ss, spi0, spi1, spi0_ss,
+   spi1_ss, sdio0, sdio0_pc, sdio0_wp, sdio0_cd, sdio1, sdio1_pc, sdio1_wp,
+   sdio1_cd, nand0, nand0_ce, nand0_rb, nand0_dqs, can0, can1, uart0, uart1,
+   i2c0, i2c1, ttc0_clk, ttc0_wav, ttc1_clk, ttc1_wav, ttc2_clk, ttc2_wav,
+   ttc3_clk, ttc3_wav, swdt0_clk, swdt0_rst, swdt1_clk, swdt1_rst, gpio0, pmu0,
+   pcie0, csu0, dpaux0, pjtag0, trace0, trace0_clk, testscan0
+
+The following driver-specific properties as defined here are valid to specify in
+a pin configuration subnode:
+ - io-standard: Configure the pin to use the selected IO standard. Valid
+   arguments are 'IO_STANDARD_LVCMOS33' and 'IO_STANDARD_LVCMOS18'.
+ - schmitt-cmos: Selects either Schmitt or CMOS input for MIO pins. Valid
+   arguments are 'PIN_INPUT_TYPE_SCHMITT' and 'PIN_INPUT_TYPE_CMOS'.
+
+Example:
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		pinctrl0: pinctrl@ff180000 {
+			compatible = "xlnx,zynqmp-pinctrl";
+
+			pinctrl_uart1_default: uart1-default {
+				mux {
+					groups = "uart0_4_grp";
+					function = "uart0";
+				};
+
+				conf {
+					groups = "uart0_4_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					io-standard = <IO_STANDARD_LVCMOS18>;
+				};
+
+				conf-rx {
+					pins = "MIO18";
+					bias-high-impedance;
+				};
+
+				conf-tx {
+					pins = "MIO19";
+					bias-disable;
+					schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
+				};
+			};
+		};
+	};
+};
+
+uart1 {
+	...
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart1_default>;
+	...
+
+};
-- 
2.18.0

