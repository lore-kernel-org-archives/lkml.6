Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF188218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xbG9snC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfADV5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:57:04 -0500
Received: from mail-eopbgr820044.outbound.protection.outlook.com ([40.107.82.44]:18880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfADV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E1jB93KUl3Byz42AGE9TOxoYv3uKicN664DgU/M8RE=;
 b=xbG9snC6Toy0iYnUIT03L9S8qY/IP45QyLL8FMVJMzBe0YQ5mkatUBBi1Ddpkhs0Ej0cM7wZIVeKtrLJtiJrXTCm1uBUTyQ6NpK5lpOMhnpQS7GdEz25PsPEKKDQ/7hpL/tmA4aMoYJCExiLT7zco9BXLuzY/NRIn1RWEYMTctk=
Received: from MWHPR02CA0058.namprd02.prod.outlook.com (2603:10b6:301:60::47)
 by SN1PR0201MB1903.namprd02.prod.outlook.com (2a01:111:e400:5223::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Fri, 4 Jan
 2019 21:56:52 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR02CA0058.outlook.office365.com
 (2603:10b6:301:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Fri, 4 Jan 2019 21:56:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Fri, 4 Jan 2019 21:56:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSS-0005Y0-5G; Fri, 04 Jan 2019 13:56:48 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gfXSN-0005nC-1F; Fri, 04 Jan 2019 13:56:43 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x04LuWCu018361;
        Fri, 4 Jan 2019 13:56:32 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gfXSC-0005iq-2t; Fri, 04 Jan 2019 13:56:32 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 2/4] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Fri, 4 Jan 2019 13:56:20 -0800
Message-ID: <1546638982-12954-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(2980300002)(189003)(199004)(9786002)(426003)(36756003)(478600001)(81156014)(4326008)(6666004)(336012)(72206003)(81166006)(50226002)(54906003)(16586007)(2616005)(36386004)(356004)(110136005)(316002)(106002)(305945005)(14444005)(476003)(446003)(2906002)(11346002)(50466002)(47776003)(8936002)(126002)(48376002)(5660300001)(106466001)(186003)(26005)(77096007)(63266004)(107886003)(7696005)(51416003)(44832011)(76176011)(8676002)(486006)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1903;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT053;1:cHd5KId1rJc+lJ0No1IdVbHkacAAZcvBK2PLKLwggyQtxSuqj79QAeQQG/pnNvQEkViEjswOzNmmkaBWLzB34gTScjF9gxbQnSw2rdPhgclTm7V60U2w90rZrLgg8uZy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcaecacd-f6c4-40dc-4956-08d6728f8828
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN1PR0201MB1903;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;3:wEn+/MoxF5/YUlDEhRPG5Ox1vZXVPmsp7H0Xja+PX7AXVQG4Hem968U1iZMyPtPSi1mjyVMwelyVaqKGDwcWhJTwhkhaE/vysor3HZNNPAPSVg99e0FBQyAb133kZx8aXVIGWQjgjav9ZV4KaO0EOASDkbpjoyljodZYt/ujaWAp8Au28W3nFj4bGLm37g42WdUrL3A3OLVRwrJQrhjniPE+EPwRWCm26uKjHl2KDytFHQHv2QkNHXH3p6GtggmGJRrk6XQxptrCqNjmD4VYSMjnJbMg+mO4jaAOVxNK/ODAIkjH8AkdUPbV2LBMmTu2iVAQIUcerMk1d1Nj3EK/V5Dw1HaRaVpHFT+NG4oPPIaZM0Cn98U+p3dliKrF1/FQ;25:iZXJyQClHuJzpsPusR7sNMBE8+5ly8SIeCx1ftToDKDHhqZEoQHPpanfpPPaCxcjhKsyT503mj6jSOkcGTM7Vlrw4K6YvaNd+7PAvJv4QdWzYh/UakrXXLYvY0XBAPUeqsAnxSYM/7Z81XgwrP1NPfwth4ZBSPkWhro4FSIMbfa8ubd59mXiXSJEYdF2JrQ2naDi3/OMLr7jQ5BeK7qjU6f2jtFoFaBreUohWJgYQdohxIEZAO7L8/275BFhKHThVHUyvh28z4iY83hjzSIwIcg6s19ktocXuGNeoQ409E0Y8HLTODkjkfFPOZawvXZ9MQzYgriV1EjA1wTHlnLOtA==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1903:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;31:AwfSjRtaLZr6ZECeF3hoiAEZz75IdSHSKCyxcIYABamdMQK86qTkSunf6mjd+rP5l2F6juFDBl2SZ0xlBlIt8XD2tvAqH2XHjdnkpaaf8qWKgq5BbJjzRhHfbei65NXzfszptdax/opJX8flexv9rICFyCP3qcdf2Cvy269VBF4DSfeKv2gg0gYRe7Q5EzhATxKwBp3rPvwW5lmeki6r0DuzKBPEg0abG6UjzK4yj/E=;20:/ieH+ZrKhhw/dP2RC+dlHahzsj/xR3nHpkaIWdrJ/Rm4NbPG1Xl6jWp75MBZ6UEOT8ffVWJv+9JeXg5qTTZ+oOFbdHy3xG7c12j/scw3pWiay7pZ7CIcknPimih+fI1bT7toZ0SoxkGnTyIhv8L2fiMAVvEfwfJT3BR8x5eI9nmMUb/XqXWWmzIh54Jou0OZQtRMod8b1M4vJZDoziRatWNrpT5dKsAF6liHEXe/r8s6K+BJ4PEXIL+VBrtqoP8uonmaC09OOm3t+uyw8doO5JLO+Hd5DMRtOsEQzFS9nnVjaEtsDDxRxNrRs1+t5jOLJfjwqvb+9Gmg/kTJikFPeF/jxDxjrsnaFOngzJHpr6GdYVU2eGttdCWvzsXQ5AXUnh6ckvk6r8lsDSi2r7JUxR13/h+2SlhwLo01k/162bseLO3an0+Rr4ntyK1cJOlh+kb2PLRr86Ce9hdNW7jF6PLzB84KrgtnP9QpjFXKscXabaxkH/1Rerkwul8pFmrl
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB190318CAC9EE7432AF0F62BFB88E0@SN1PR0201MB1903.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93004095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN1PR0201MB1903;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1903;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;4:YqLblurn7rG9hsYkIWfCRVttiPqJQ7we2BffJpR+jm5hLN9VCt+d2IhbTpkLTqfmHi7tppbtKJmM1ySQFaj1Zs3ZrXWJ2OvvTQpUBuq7dIjMFTaM+eDzp15y6yqq8ZryFKzKFdSyHDSxsOvNXhCoSKslraaxUG4/LMdu05NRGfEulPsoNr0ShjLPdrxqTgKI43nAF0mfZEgmouxwaCm6z7sXlAhsiV8MwvmKiZBsFe+RS8LuCHgW3IM0jvQXukQbLj1pLczCJpcLRB3yNVTe1PLU3oBUFR9ylHC4uH3K3BwvMyfvwk6FZ5yonVVN9tPk
X-Forefront-PRVS: 0907F58A24
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1903;23:Rv4uuj1mufSVOZtmdBLEdB8zKXBcoYtL77YwNPv?=
 =?us-ascii?Q?pMdLEC6njZ4bE9vOb/236AzhAhhMIEHnTDd84DnOSflPyZ+w5Hp59RDFOLbF?=
 =?us-ascii?Q?nxAXS3NVSKref2AZPfpKHLrHrl9qYLMKlywQKBcwImYdBuku18CsIyg7k5v1?=
 =?us-ascii?Q?zZvOFF+D3jFwhVxeO91FMgJ+V/N5We5mK7vXuDgeXOl71CB5WRSrauRwT2Ku?=
 =?us-ascii?Q?MdXYo/WK5AyPZuWaiE1cEdTwoJs/mCJfO4xkUDYpmKJptr/DAO2GB/mghWNl?=
 =?us-ascii?Q?jl4ZGMumaBfM53p3nJB3jjI6k3UkU40J0nKMnYvT5ByIFSfMLTeAOPZgI0/0?=
 =?us-ascii?Q?5i08NBRFkg4vQytuMGWO3BqXNMB3u8tncKr6gyuRqbBccA07gqPbQHfbZsOV?=
 =?us-ascii?Q?DxqlSEsexTbvCK2ePH2MgKI+ewMJOWB2K0w0Vo8Jz6SBuEEh5fnBiaYYNaUO?=
 =?us-ascii?Q?b5ATBslJBSwos8+wCagvVz9zMjuPCruRQanoODdrJjgPoSmbgr2cifO0bldq?=
 =?us-ascii?Q?mnpxFB4y9CoTcdKdIV9emAgEDcSnrnxCEvkxSxdw566+ON+ZkSWauFS5AiAh?=
 =?us-ascii?Q?D9sjMzqCIAmoYbZtiLpGVwEKN7UBTjOfMRzmmU+ziOL3A6Y5DVRRwRkf2v0V?=
 =?us-ascii?Q?7x7LDuGf+6o6eE8914qdtkE04MIH/zim7fQZoffIOAVt+SwZiNe0nUHJckq1?=
 =?us-ascii?Q?xZbPCfLA41jeeBvRCoZyOuNbEPbpRUtRQMfVy5ARiQVXYKaXlAKqExFxhyDv?=
 =?us-ascii?Q?nXImAA6SftnAlaFlHP7G5ujp8ZwWccqIxCxTamcxy3ZPq3dkDAWMuPifLWvK?=
 =?us-ascii?Q?ZGfVEY0IoXuTY5FHOK5od/zpGl4ROaMwXI/P1OzbyMtxMs2nHLb7oOY6cxks?=
 =?us-ascii?Q?1vNiFpz9qSqn6AylfOVl9irPQ4nOXJgQYCihhsMdwdtt9Om3iJCM4VkqEMuT?=
 =?us-ascii?Q?7O5JL3fq4ze0xavNJOW0Sh3MoUiG6J4UoU6/rFk/4qeofZA85aN5/cBqX3c2?=
 =?us-ascii?Q?koIgHlEy6Lq8dwaHd2/9cX/EnhRE+BRMlX18Qdx8VeDdDkpuh42xhzJxi0x+?=
 =?us-ascii?Q?dJ4iL0oTVov+lEr+0EQpam9FofzYOQ0OW+jWyeEU6H2wuwGuDwB39MPd4LwE?=
 =?us-ascii?Q?krfB3Zn/A++kMZuKWDdxuxQDKk3mu8kbW?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LlSQxGaha5KG1JwNulEA/vCxdSQOX9LfUJbAIRu2WJczoManx3CEM0qQNErXH2/lAOsx3K3RpyLZxwFPXElzBi8zfsC+qVQEp5Sk1+vs1sQT7aiBMs+B3f0tjybB3Eqrba7yKVLB2iKckHWce+ToMZklfYEwCB6XD9zna9278Ar/roa4aOj/kmyJ7jdv0IXJ5t28G7MI+5aWergllDiqLR+yXfjK5/DtHG5kYDziFbjpjhem65blltrj//4RNytencQNTsDMJo2GSW11YifDo4dZ9SexLKQfsdU0AYBppPUUYJgclH5N7RfjcUm5Fy3u
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1903;6:ZuLF6JZ/HyNFRKjr0B8xazhVhq5cUDEMiiYeDA+SKlX5IVcS27oO55I6mjCFdzsfJ9+ZkIZEcaQ2Gup/3nk0/3xPwkm6nutT0yb8FbDhUUf/d+yy3jXxHrVon8eER9WDHgob90fcmS7py3x4YCNIyxxlr3MNUPDwzsSzkBHF1IYUETQV+I0K+mNveidQbIAPAgHt4ddf5k4CFULWZeZsJWjnUZnkO9SmueuF/QsqyvhqkOtpvL4AC2xkWKSy+Rrqdu65POIUdgaGwDkwbgXphXUVJPmfunqQBjxt4VsvCsrLqO4jz81HiplKOkVjZWo0hpS+cUgOg3TQ8xQR0M8m+6tXZrTZxvuKjY/9jb0wwZ4svuJLzg94gXnMm24alO4tnMeKXu2tFCqt6AhOBUePwlcKhrnvBGl+RZ9v1b1jTHto30UbDvT2W+ACCWB86VTDrp5lvqsagK5iXgHweo+vPw==;5:HSDlZKb+Ph8FPo7CREoNYKW1GeomP8fUqjMW0lmzMwXgPui1Ipy2vDERY3Xaak4hdLxR0qW9m2Yywe7LGefbP3jDlG/oPiTM2ItEnAKZxqVlB9feImP3GJbTSQgveHuyFkmAh+/NRC/R/tAM43QLrTKD4/ijmDVd60rCs0bDMWwRkn797QSdDpRQWhHM23CTjw5WJFYwfvA1WDB7yZcX0g==;7:ZjGJe/y4YBLlL+pPBMihceTczm8v/wajh926/qmzYde51bQG1vu0yxte/RHXVNE96CDMeuEXrdhAyE7Q+k8TB/gSzbkh5uocbFK/a+tcZMRoakiPZ62LWJ+gDkvallHjP981kSHSayo1DyZZhWShnA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2019 21:56:48.8947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaecacd-f6c4-40dc-4956-08d6728f8828
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/power/reset/xlnx,zynqmp-power.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 0000000..d366f1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,25 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.7.4

