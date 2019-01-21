Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410FAC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DED2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WBxJwNvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfATRk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:40:28 -0500
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:21558
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfATRk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GEZFY9FBwFtJvdNCp7bJwkJNb3GByq64+HpZTjvTmo=;
 b=WBxJwNvXtsEoMxlXBNmQNGbZxPBhXAOnQx0jhcV5rfaVhpTEZ++7lOB9rhEzj97Ns1/bKFV41f+FzjXt3PIm+SZQFquGyRgoaeoBTU4FIYmXSEXRBLFjnk+mxJBwJLZ01puYUdLfQdr37QKG85fT1M5Xp0c5l/vYvkNNFF2pcKs=
Received: from BYAPR02CA0017.namprd02.prod.outlook.com (2603:10b6:a02:ee::30)
 by DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27; Sun, 20 Jan
 2019 17:40:25 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0017.outlook.office365.com
 (2603:10b6:a02:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Sun, 20 Jan 2019 17:40:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:40:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH55-0005YM-SE; Sun, 20 Jan 2019 09:40:23 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH50-0003FR-NJ; Sun, 20 Jan 2019 09:40:18 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHe6X7027539;
        Sun, 20 Jan 2019 09:40:07 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4o-0002tH-Cf; Sun, 20 Jan 2019 09:40:06 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>,
        <robh+dt@kernel.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Mon, 21 Jan 2019 23:08:35 +0530
Message-ID: <20190121173835.21173-7-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121173835.21173-1-nava.manne@xilinx.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(376002)(346002)(2980300002)(189003)(199004)(63266004)(336012)(36386004)(106002)(426003)(305945005)(186003)(50466002)(356004)(6666004)(81156014)(8676002)(478600001)(81166006)(1076003)(48376002)(106466001)(8936002)(7696005)(51416003)(39060400002)(107886003)(36756003)(2906002)(2201001)(2616005)(4326008)(76176011)(446003)(126002)(47776003)(9786002)(16586007)(476003)(316002)(50226002)(77096007)(26005)(11346002)(110136005)(486006)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT032;1:KQuzWZwqzzZesqJgTfIoZ7zc0cHX1/TZ3Ac1l+1G1kCexl3zRABCNEoR55/EQ5is2Hp9g508kO1pN5BBtVNZTWeqqQ0gUln6jpnKkZyfc4FlPmmyDa6ixue8po11fxAhNUs0dpdBWAVcp2GqV7Zm0/obnPvWIbXa3/PSgGpTQjI=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f9e4db-a339-4460-0302-08d67efe5bc1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:GfRPDcwcaLL6jdpBdvKs5Mg/42/e2aj3VFx+YtYfTykkaU1Szrju7P8b70R++Oy6rLNraBMPLHxvxFJZ7vb8osW3bxVf6d+jgmpj+qz2qeVGUS0iNUqG7b/KudKvdPP63LD/tkmV1fkhkaHk0Py8B4fErA+mB61p7ab4Yn4rVTmkL/8yGKJbt1V84GEnkXkFlCzwl32u3vHpGYqBCaWe+muY1Oho2Oa5mu9d7IXHQUpqmu/o55zi21+NjxRZo/32XgSc/vVHaVzbmrFkDMcWjp/Nep9gIKif4fCciA/lqi/Tnffk6H3M9qTG4+kYWP6ivmKXdTdbwl750N/67HXx7bR4xLO7L5S1/pNv5gn261brq38Ihqsr9yHZo/5GiqHd;25:1ArWbTsGeiMuSs/RI0DEOjFuJVUADu2Uq4MIyA7OWPx7bZDo/+O+M5DjmwtlBvQgVDo8NhpHdenLlivUS6mkjG8hD9IsX7/OoXOmkXOwFL4AZ8uKKBZf/67OWgfIo1b57duMV/JNLa8H0fDd5UrcDNdzk3dOPwphl6LjLWUfFiciKCvcePWH0n/VnpMowNYX8iuag+TJEeX8Zgt3Y5/uHgH+7Q8mipoD3C7jZK//0IXLWu8RB9NZIj/AQdZgnnprQ6tk6yFMI8E/0qvnSKmcWXUNaVXjR+h0rAVkjGZh7TJX0vlXvOk2bQMJDw+s288oHnwgskkP7XMs6xpJ/KfVjQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:HjGcmUE5bNbqzM7g626X9TfubenYJElX8VuzUhWQHLaJkPa1vgJF5dwhp8Cc/EB8WFCzO504dhkVrFZBn/YVlBB0xWety5qN3rzRdTA+X5gAzFgppeF3zC8B/SzwED8LI5eQt1S6V8kGuVzYk3qQ3fI57mTyTP/KdqWJPV9/GF0xYVX8nl1PcoLHEXYCH6thCUpMMpIlOMarDrahFydYPZPbsdqQyiSOMXJ6/SnqPcc=;20:JTuO7mbLyacc2nrnfJ+ZqMWf1NHxpLxyWDDReRsRHUStfNhakf7ijJFtw4mfB/YefsTXHYD/6pIsPhZIOYh1nrZobW8Qj0SbQdibLxuiYeDxwDr+NtF2l8ke23AY3yhkXUJafAzG8leugINfizXUZR0a3Iyai8wqmT3UxZGLen2jBp20r6mrdRXPng34ZmykymvvEdjrK9kd1HVMR45LT9mvkd+o0m2VcYrn6n0R/tXjZdC0wKhlXjhenmGnKmHAop+KyjytrvrJ8uKO+KSSPxlFPpROK+PIBJynnKAB03tY7gDUVlHZsQ6rVcxcZrWKnryIIy2FW/bAM4DUJLQRh9rBaTk0rPct9mNqfrzbzcYSwW6UD4vsW+pqmPkGSX2/d23iicwtYJ8WvgMRpJ36ZuYwUc1BjjhaSqQe/D+a5tHsfaERZ7vCvQYbtqCkgR5THY8J0YU87Fn/c5hTbK3cBB15Ldt1T4GCWt4+ziYMPkvCvKRhxOceuRhe8zhvhkAO
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB433026AEA9E1EB06D306A051C29E0@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:PDT600UKInx8ZGU7PHSSKWkK2kqnjUriHxCbZt+xOceiER0g+AJrw6BzXRkgrdyMog1cAyBOCFVdi5muYBxFIcb2mJiFoLo0Kx0GnPBRKRwI/VW0RKTpFfjmphe3UdA5R8V4b08jSwWPk1MgovO2uoM8eCCxHsufXjNjEawKs7gY5C+N7AOX73BtdMvdvHnYp68FoWheFSrGIEKkIHAPSTdaJSCRRWqzdERqT4kKC1qNeZl2WLGBGsAUDMx+/XPrOfW4NRiGCDxePP/Vay72ps2L5c5ikgJDF80irWkNtEKg0whW34E3Jk+LuhhIhF8z
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:qMzfjq4tsB/cpJ/h9e969iX4Tuhe787Cs+CNP5FUx?=
 =?us-ascii?Q?fQ9ifhGtK93zuH9gcrCxGqint/R46WYny74yc1mReT34IZd+IDidGJApv3nW?=
 =?us-ascii?Q?B9H00Ugh7ZOA+OW58xFE/q8jLH7CPUEpbg7lv/wPmRh3LlsMCxQFB5rzUa4D?=
 =?us-ascii?Q?P2s5MxFMRcXYc60ZRod8+IY2m6npl6VQBRoP7vtXUu3F5KR1qT/1hHGD7+LG?=
 =?us-ascii?Q?vjTvm4irKc31KEqopuMzt4HKM8b7JpB8yhdU+oGpVRKMF5GHUxuBypvIbONs?=
 =?us-ascii?Q?74yShl5TQBc38WAioyUvBelVxyKt4tTv09ep+1hEmTkgNhAhaaBtHaW/PX45?=
 =?us-ascii?Q?bEBZQjoEcRYnwy8+Ogq6vi0OWTUfM00KRqsDdZBhig8wgI5QMRuqRpkuAYcy?=
 =?us-ascii?Q?bQ/Vhwbe8R666SGlK7EI9C3Y2iF1bYmWo5HRbn7fc3mjbuBFTqP6z6wdXui1?=
 =?us-ascii?Q?yf/kV5HkwLJC/ZML8Ej9sokPpcaqtRp00qMQkGdFegZcaeCrnToo9hS9ZEr+?=
 =?us-ascii?Q?CMOD2Rr+EaAmZnRRvp0kl3LtEn6kufS2KgzcsX+8qefgjIIqBQOUvdoT9xj2?=
 =?us-ascii?Q?X7dz6htFs/Vu1a2MUrr9urXMTxSAEaIo84vInT7kgQ2w/Kh6xaPa38qSSVol?=
 =?us-ascii?Q?n6dd4TQ0QBIC/qYFmrWGFkLjliD+QsIFiK1Fm+p41oA1PACvvuIubN6Gn4V7?=
 =?us-ascii?Q?P0QSECsaRkHIjGq2CI3xcC9ojfKm5dYjCHbBVMf8z5HMhTO0ZU9PZEOkO/ke?=
 =?us-ascii?Q?kbjtEgFlEU9c71a3sEMBXKHlxAqYXBxGLt2TSfh53Wb3BYrRSFRGFF6E3CHJ?=
 =?us-ascii?Q?Rbq8/wtPxsSvRoD1eFTIPZrXRV49xcMqPGSsUlZyRid7JRbHqsAfQ3k5aaOz?=
 =?us-ascii?Q?eSUQUUJVFErbCBRUyib7FKvK6118thbjunYTjDMN+X7unnX2VRTZh3nJLfvZ?=
 =?us-ascii?Q?cnV9gDXJNVol7D6fgNE6/UnAn6WzOkmhCScYno1yY2MAwOb4HvSbQ+KP/Jev?=
 =?us-ascii?Q?dhjQW+OSXAWLnYpZEOTnFGwO4l8b9mhH3MAt3W3+uq+IZuDKS+zIibePHqMx?=
 =?us-ascii?Q?i/R12S4IB3eBZ9rsbvtq/g4GPzncaB0Oo7dgszXrDUwAeJZgkchdVHKoDLoH?=
 =?us-ascii?Q?SBpqtY6Hc8=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /m0tcBWc6DQk0qhRUdxs6cvmIjsBLnKg74bLGD4B58melGGFqdoc2EmHGfhaFUgIvOUZIseBLEDLMyjAKPDFaPvTt5k0xpEvSnT29bDHi8++obPlwPPuUPc7PZlzmKix9uYTmMGmib5uvnRSFriDi+N5nfRZN8D/BC92Bz8CKjjNM8kw2nd+sLkTsBnHnDqkwGftlOO7cWfiZXA53EBTzULXGHQX0fLjxyuNjBG/Z5KRWJdWQxLUePo1YLmnIkwFlPr4f5gwsBa+xkHl8kCJyG/Aw/8U9fMtHnRjgymXhEfWsD8hptniYIEy/A3+A0WgP6yHbsKzANDmMqGSHB5Gmky0Sdc9etfY1bvrf5bg4G4HuiXLD+BwVBh9AloavsKOAt4ntLp/B3f9QScUG7yMJtL88MjzTONfriK5a9p1gQQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:JeZjt2sKHQT5S50X3x/vlWvOKMPj8tM+mko0Q0vH4998VRbGpE0NIycA2i9C7CuvxLKEsgI5WP7xNlI2DGiJZTCa22C0H2YIeQhrQJQtm+wRKVQ3LiMKs187bcFujyr1EEvdemRhQGi2Ga/8N33SYOyVE9WKqTyud8mrTk/fxqLYF6HovdC+uIObg1wrPDe/0R/JTTybw6jGmN67IfHE924JtAXjbtD/FdVwplj6LsSmGnk+RUG+mjCvOhJ9hu9Nq/DteVccAFlKgH+y4awbMW3TPAVe3lTG0gjAd7OgIK+Ep0kL/y/yjGAUnTmsZkIalm1oSZuQf6tKOQV+xmTPGt/iZuE2efsNDrB+hpkBzyXRn9EX11m2cD4q7EKkT59cKiP7R4LPb1wzTW4sNdziLBGz3jR3JKu5NyxJleKPvPgUrETikPyR6A+ivRweFd2sxpk8/Vtit16Ugg4w0juvTw==;5:f5/CXzUukteTyg8ZNnukMmn8VWDjd+eK/5OArTTfMGag/DwXTJo07SLCgJ9QfCn33wtGk5ySaSBX6w1oCroprgAwbuO39P2mso8EUYbOBvsPAjZhbYJU50q24CMPHKF5MpAHrCbdYsfLB7dgi5eIkaApImyWjYy0xd+08QrtEKy3TdOHYAe49CXUgIffKBlEuDmldIDJzAR4miqcPwMYNA==;7:AFpE0EH/RuTUIL0sbbfBq8gDYM64+8wK5ugI+u7Ei0/t7U5C2NKlvRNCUx+KYIkqHYd56WI4hnCjmSLUtYRmgLHJ3ZDIyyoNFxgcMAy1Qai8b9jOVaGd2EykyMxsDqTQ8z57+kX45FhbCXDRpE4hWw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:40:24.2860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f9e4db-a339-4460-0302-08d67efe5bc1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Removed PCAP as a child node to the FW and Created
		an independent node since PCAP driver is a consumer
		not a provider. 

 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
new file mode 100644
index 000000000000..1f6f58872311
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
@@ -0,0 +1,13 @@
+Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
+using ZynqMP SoC firmware interface
+For Bitstream configuration on ZynqMp Soc uses processor configuration
+port(PCAP) to configure the programmable logic(PL) through PS by using
+FW interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
+
+Example:
+	zynqmp_pcap: pcap {
+		compatible = "xlnx,zynqmp-pcap-fpga";
+	};
-- 
2.18.0

