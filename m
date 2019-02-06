Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F471C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5649A2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LxBYF+Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfBELHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:07:30 -0500
Received: from mail-eopbgr680070.outbound.protection.outlook.com ([40.107.68.70]:30592
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbfBELH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COrnE5xi4CCyXVCZhXUtNGk0R/8hEzdA+9L2otHquWQ=;
 b=LxBYF+UmgCglRrJXJMY4h4JwJBL+k/22zzN+Q11awcd4OjKmc+y9+hSoPOmRsc/bo2w45SJxayw36BuILrV1UQzyrTq75T8y6Yv4S9tp0sNmiqhOgi1/E7/13QAesevyffnRb09A0rtu/gi/EHDWuNvRqZKlwvGOPhPP/OSJyQU=
Received: from SN4PR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:803:20::27) by BN7PR02MB5012.namprd02.prod.outlook.com
 (2603:10b6:408:21::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Tue, 5 Feb
 2019 11:07:24 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by SN4PR0201CA0065.outlook.office365.com
 (2603:10b6:803:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Tue, 5 Feb 2019 11:07:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 5 Feb 2019 11:07:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZW-0001Rz-Tn; Tue, 05 Feb 2019 03:07:22 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZR-0001Pz-Pm; Tue, 05 Feb 2019 03:07:17 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x15B77F7025958;
        Tue, 5 Feb 2019 03:07:07 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZH-0001EM-4N; Tue, 05 Feb 2019 03:07:07 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
Date:   Wed, 6 Feb 2019 16:37:21 +0530
Message-ID: <20190206110721.27765-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206110721.27765-1-nava.manne@xilinx.com>
References: <20190206110721.27765-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(486006)(2201001)(76176011)(106002)(106466001)(51416003)(7696005)(48376002)(81166006)(81156014)(8676002)(14444005)(47776003)(186003)(316002)(478600001)(16586007)(110136005)(50466002)(26005)(77096007)(126002)(426003)(11346002)(446003)(336012)(356004)(36386004)(6666004)(2616005)(63266004)(476003)(305945005)(9786002)(2906002)(1076003)(50226002)(8936002)(36756003)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5012;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT052;1:Y+kU+x7rg0WELHQ3o5xF6fmLCrVj1zDsBGzwqm5n1ZD5h8f8hR0DkYgfn4EXa3djnashTyo9ntnba8wB/lcAOr8mp+4lclC0O5pY5ljnhAIATG/ey8/tHJkJ7wCNQySeiccyxGgedVeob9QGK+AgjbmcI+KD6ct/YnSH4YksEB8=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab3db416-ea21-4517-ef29-08d68b5a1b2a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN7PR02MB5012;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5012;3:E7/PIxJvjIDzZugd+nr045WVb230uNUt2pYyAaKzcRJZNqVZuuEHzy6cyuqcYCnCLjIc4DZiDJYdHh4qwBEm0oURC+FGDhRzWVEA+TWD9jxdGAYGDDkMmaPeoCPxVOC1NHUphUDMXntU2a6K+0VSpHesm85zqGFVRWC5i58qfmJ1rPZFLOQ4CuaNnDCWXLUU78j7tplWaVMSP1f0an85JVgIwLPCUdJLrdL+SeEbdv5kdgZOcAjAaET+TwxsimluyOLUolBFWdSXSD8obTcYJPt9LcaCfmk3JeoAyvBALq7uemzLcfRPco2VM9t4WkqPLHkbB6a6ttaSJB/PeDKk5YSfRIbXABhW4dofT7HdOgBDlEJ0N/OsR2T5UnLUKg+/;25:flUuyoHH3JR6RxXSPE+Q9lIp78sg1nYZBxjJbumlcSDDUs6kbt4alqvdds/mS7xKwyZK4npOgu6HwlAxUWtc7qBri1hPmvGXdXMmgoj0YFWL8+YtS27kzg3DhWx5skLFhGomD+XvkmOodXdSQW/A8qUXLXeHtcMw3tSL+eu+CTirtKFJvUe6YXa5AF8hphfliHewctlUw3vC7MZZTG2gMxhBQyfmDFABdqe3TciFG85ZaLf6VX+b1JoCndcsOxi76G50z4fctDpcXwt4zo2KXIjy7qzAjKJ/80D3ucpBDH5lMOzHzjCTMi2X0IO4010crps5rXjfUGWsf+n3DJlYEA==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5012:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5012;31:oJoHObg6uR5jz5aOeKbd02f/TEOuqJWqm65M0weJANkT4FckLGjrpcsUFIhMeDWqGm1ICEYItmNgdfVhiqDF1JTW+/nBFkPwLd+B0oj0tTq2B0OCXF7tmzpFbuA8gRAdJzUWaJkhxU2SNNxFb8JFTtBs/ge6n+z3ldruhV63mjWtQVO1vvLyccy9ltOAvodPMlEInG8BwwknMCfKiet3KzS3gglkn4U2X7rATu7gw/Q=;20:EWM6pb6eGqCxdu5MKckZlZSr+VMu0r38VfmgiG9kWAzVAP24YKj7oxwYykDWbf03J/FElOfuddKtdwoVVXDHqcTn/yxCucU0pH0jJCTZT25HYb0Ox++jSr1DIxrNFOKXQNvkmkqo6Xs1iMLCszUXD2u1l65w1KoXezVfzqQAxKUsd3SIxywAFCL5RwHW9v/672gF/5x2a3VCTpP1/Vu4Ps30Apni7u+FQJrDajBbRExthvjngZqm4Xu+uQLv6sit6ZoCqqbKO7DnAphzVxyOhj20YKmJdGSnkNyYzo48dAU1qMW8OM/p5mIKWwOj6rPHqYuDSSNmIHgnrHUS3kAEH/GFZjxKWJ9t4NgCMrT/4JHcLxyuuiwu6lnBJl/1QBbrLMYen+F7VUNhKdLcSRbeg17FrttMDLFJN7yf54RPHgHHF1PVDnceZvza5BA1Sdf6MTKdyoBeJYDfsxouF/CH7dpysTX+LlHHCWjdZBVxTx1Trt6QmPlPKqMMBQUbY07h
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5012322268C6A85D1FB96F7BC26E0@BN7PR02MB5012.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5012;4:BblY6gSwH9RnKri0gmWFIfz2hhxI6ZpXyzkel5VV/XVHBKiKZOmvXLHPJTW5GVGR1X1hyFHMz8BfdRbu8N87WBupnOZ8Y8W+17QhJyETOpEA47PqSeMyIYLC6LaLN+miuKuz763DpX6lUAOLXdovXRNiW1e52P1f401ql+RGh+VrGtpRyxKLiIaYHAUdDGQzp8I7vt24pN6Ope0sTJLoAvsCCN2W7v5jGhbb8qm/YK6pMmylsoPX73+0/wK4m2jOKdK/TwsuzN0PMMw90VhaI+ayl6PejoZIujFnzz0TckWQ/R+ESBHqwxZ1MAB+dSy0
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5012;23:Ch32ER2diJ32iPibD/KI6bLCevhnENzWJb8defMIO?=
 =?us-ascii?Q?+4V+eNSImSGMmlDZEes+2DHRVJISKg9XRXt19fwN4YgJ80rgNhBt/KUenQSc?=
 =?us-ascii?Q?qf2pc8pCGyZC7knlwfqB8Byp1uaV93pSyz+gHAcqK04UkqSN8dY33wiwDzZm?=
 =?us-ascii?Q?64UwxE5Fm5FvS9GqPafP/l81kzvnW2RZ+P1QjKGydYKBNdRJTHHc51rpzWRy?=
 =?us-ascii?Q?Eqd4p9G2PKkvDEZtLKxVqHep4hos7NMV9F3YgO5meVDtjVHN0mZC572c4Y1/?=
 =?us-ascii?Q?/uVNsSsESOFveiF1+4zCc95OWUm6Mmx+YF25vDCuw3w/aIEVOtxEUfTOiSDZ?=
 =?us-ascii?Q?StKahCjXpofcKxNoNE5MNbG3l7LBg6rHrprayB7Nay3BrKl0ieqWmjpUiJrh?=
 =?us-ascii?Q?1C4YTwei0cIANXQgfGZ9OyoTIDt+CWvhPVcRGIIs9ejnCrDvMqZzu3l6kVzF?=
 =?us-ascii?Q?DDZDfOxg1T+i6nSSGCd0GquZQxh5YQM5yqyAVldLbrcJBY0h0MCUbY0bIa94?=
 =?us-ascii?Q?5xrdw9sSgs5WpEtccPl9yEoxcjB9VkOOVCeqXM8EogIojgPtGdP/PSdimOtm?=
 =?us-ascii?Q?OBZHS76xPhuH1z3CQJQIrfNNGycBAbZQBO2GJButc2Y6aERSxaPoZYaypFp3?=
 =?us-ascii?Q?ssAMZCPI9UBx/1Tn7B89V1a9SWt+CZuRLus3OAv5zSO0JIwBYSXKiS7fXk1+?=
 =?us-ascii?Q?uR7G7VdOAUPdm7lSMKneEXzR42/aKOa2AMW3/jJmlQvUB9q+xfVISECy5G8H?=
 =?us-ascii?Q?8Z2NefSVulC9CVOwaefTLSxoqHie6H759VzqcaX/eiibeiCazD9AbWt6sUTt?=
 =?us-ascii?Q?eu0oTFmouWOceoim31Vdn9AZoE0ZwnYQeSEw0hbyrC+AtHG30001bNmmMe7t?=
 =?us-ascii?Q?9PvrjIw9FCwwvXE8eE+sP2is67u5facqkim9NG1xnot/uiPAUfWH6Nk1yy52?=
 =?us-ascii?Q?riYg4G8PqHmBAboq/8Ob21Z6j3XRXRzdfMNTRSgYtxU/OT0X/zkTUbt3KN6q?=
 =?us-ascii?Q?BrtdJC7J7za4di/KlaDDBNf62DDghNpZX9EZVkdKfEk5RQoqdaHfk/+lYmee?=
 =?us-ascii?Q?d9j33xFTNR5HAKmwmFub3yqNLpQeftx9BDJ5cR66TfbQvzz4K6MgbhCfrpUo?=
 =?us-ascii?Q?TAT/dZtM09xXlQWiiEkPS2Z5pImEHiO?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xM0YYLVX+2e6Rq8X+JJ8yDzfmpvRkz2LSCFwLrcDfe8iLH/NNr1q/3J3kI01d2Kqhuq0cy7nXbcRyyctSpbUab2V4jXABgRFszIIdXdBq3vB8sSYp5KnYxTQ/f9u31IOir+Gj/CKyStfG2BovJXAHcisEyCOvBl4IdgNgOSd4Xln5adEB80rnMRi7Ypr1OzWaQQ7t4Q+2QQhKwI3M39mmdhTB0mXTf3nov/QUfHjVKpHVts8zYsWRHtBsOB81eK95P2TCJ6zFa+O0OvwrfHblB9F53BvwU0QCwgYiUwAcp+C+6XXuMW+miolvEy/I+ebjxh0QFRvXsMl5JtdjZrA+NoQEs/qzOaB1m6/RjerYZ2JKeXi4WKyUGA0C9vrZsuc0QjGz4qpQzYFWmGqU9awPrhBlFNmxM8y7B7tDyghOCY=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5012;6:TcHVmk1VO9WiAGuqgY79bf2sBkHXvNvqJ4Bfq6TUUCjy0IJ9BsypP+JJ+9PmuqbbpKGQNhI4mgTG31e430O16C7XRFnjt6Y85Ift/fedFOJfngk6knzfs93lmGFtL/YHn054W3y9ap86XhuolR34BpP/BwEB/5YTxjv03f2wFnaZDsxjkBBgzwtBuQQtAkfqyiJE7a6t/3wBxJNatqZfsXYqVq35ghFCdeM/nSeHsSY87facwKo2Qp377T+BxEYNMFubjl8Cse3XVSe2kVlIipn+KRPDwQX1Xtco2CnwDDOAuedHBlfeTIuUp9a2lXvhn/qhe4EQ/1NZ2vAPWi7GPbuuIsGuXbANrCMFfOXbIy+nt7VSv4KdETslIxhKZaR+h0mhuHv5yjcWVDFl3CAGK95ReVc8j/+8hejc31HD2J1awWcAuW+FWKH7hzknVFQ5vGOQpb5iNr9lZf7bxcWSLQ==;5:qern2LeWxCv7Xut2q5vCOD99jZ9HtEJPOXPHFsex32EEUrVoT8iXLE8Fj0guXQWhJogNpIF6hqGzrs9UsdP/GdwjrjUl1+e+Vbx81w7s43ggyA0Kde5Ch6bGU5fJTI5WnrwE7XyTIzTK1cMZ9aqcMlMPCfBeBQEcPiWv1XfvYWPq3676VvPFDEo8NdHoIziw4Fz2P3sOkFR8PMOl6k5E6w==;7:dNVp4XuRnPPHmAxxxQ81coSnOvU6ENQoBV8ja9Ok23kI9PvOfXyA3uQ+KYyl3WQxY3JPHcmFNOM/fbUDjLt0v6GrXWDAc6woo/JkR71Q+pYS97nczMQr5hj8NNyFi2dzUEBHK3ELs0Z4jNtNkWiCxw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 11:07:23.3736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3db416-ea21-4517-ef29-08d68b5a1b2a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
                -Removed irrelevant changes from Kconfig and
                 Make files.
Changes for v2:
                -None.
Changes for v1:
                -None.

Changes for RFC-V3:
                -Changed nvmem_register() to devm_nvmem_register()
                 and pr_debug() to dev_dbg() as suggested by srinivas.

Changes for RFC-V2:
                -None.

 drivers/nvmem/Kconfig        | 10 +++++
 drivers/nvmem/Makefile       |  2 +
 drivers/nvmem/zynqmp_nvmem.c | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470ee859..4ad846ceac7c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -192,4 +192,14 @@ config SC27XX_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sc27xx-efuse.
 
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
+	help
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
+
+	  If sure, say yes. If unsure, say no.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4e8c61628f1a..2ece8ffffdda 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -41,3 +41,5 @@ obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
 obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
 nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
+obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 000000000000..490c8fcaec80
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Xilinx, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define SILICON_REVISION_MASK 0xF
+
+struct zynqmp_nvmem_data {
+	struct device *dev;
+	struct nvmem_device *nvmem;
+};
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	int ret;
+	int idcode, version;
+	struct zynqmp_nvmem_data *priv = context;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_chipid)
+		return -ENXIO;
+
+	ret = eemi_ops->get_chipid(&idcode, &version);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
+	*(int *)val = version & SILICON_REVISION_MASK;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "zynqmp-nvmem",
+	.owner = THIS_MODULE,
+	.word_size = 1,
+	.size = 1,
+	.read_only = true,
+};
+
+static const struct of_device_id zynqmp_nvmem_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
+
+static int zynqmp_nvmem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_nvmem_data *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	econfig.dev = dev;
+	econfig.reg_read = zynqmp_nvmem_read;
+	econfig.priv = priv;
+
+	priv->nvmem = devm_nvmem_register(dev, &econfig);
+
+	return PTR_ERR_OR_ZERO(priv->nvmem);
+}
+
+static struct platform_driver zynqmp_nvmem_driver = {
+	.probe = zynqmp_nvmem_probe,
+	.driver = {
+		.name = "zynqmp-nvmem",
+		.of_match_table = zynqmp_nvmem_match,
+	},
+};
+
+module_platform_driver(zynqmp_nvmem_driver);
+
+MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("ZynqMP NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0

