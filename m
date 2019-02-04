Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607022083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Tw3Sp1Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfBCHJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:09:54 -0500
Received: from mail-eopbgr680066.outbound.protection.outlook.com ([40.107.68.66]:53024
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfBCHJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHPz3zW5Jxw6+PIJQnlv046XfEGtTL70GF97xXGrY5g=;
 b=Tw3Sp1UczgIYj2A4qaMS5vVW/D3z50TOeLvZ6+fvtCIFylFjX6Y4bR8cEGuKBZfIyqZBj52PdVMaNKPhoWlO45wcigwFJewWmPTt4dg+ZDydICZaSf3hin16Bib2m/ZEoT/CFB7VLwUI00Sw0mqHloQ7PMyiN3MYgWUwXoSDX4s=
Received: from BN7PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:20::32)
 by CY4PR02MB2645.namprd02.prod.outlook.com (2603:10b6:903:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.22; Sun, 3 Feb
 2019 07:09:48 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN7PR02CA0019.outlook.office365.com
 (2603:10b6:408:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.20 via Frontend
 Transport; Sun, 3 Feb 2019 07:09:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 3 Feb 2019 07:09:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuV-0002C7-0E; Sat, 02 Feb 2019 23:09:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuP-0002Qk-SU; Sat, 02 Feb 2019 23:09:41 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1379aSP026910;
        Sat, 2 Feb 2019 23:09:36 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuJ-0002P8-H8; Sat, 02 Feb 2019 23:09:36 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
Date:   Mon, 4 Feb 2019 12:39:51 +0530
Message-ID: <20190204070951.6933-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204070951.6933-1-nava.manne@xilinx.com>
References: <20190204070951.6933-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39850400004)(346002)(2980300002)(199004)(189003)(1076003)(2201001)(186003)(478600001)(6666004)(356004)(63266004)(7696005)(9786002)(26005)(14444005)(51416003)(77096007)(36756003)(36386004)(76176011)(106466001)(2906002)(50226002)(336012)(8936002)(486006)(316002)(426003)(48376002)(305945005)(50466002)(47776003)(110136005)(446003)(11346002)(2616005)(16586007)(81166006)(8676002)(476003)(106002)(126002)(81156014)(921003)(107986001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2645;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT026;1:ILBbP5uSfKqhemItR0xQs1gxK2WMrUzyhkMla45rAEMxaBSDkyVesUTBCQ3ZcVnAhrlxhRcSahj/HueWiiwI+LjCuVvGtkvrZ1DLIOzGinnatA7TsGMG+Z0wM+emGRxLLdMaHVcX0mAVxGzE6U1CUg==
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d2566c-9ce4-4d2e-e4af-08d689a69505
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY4PR02MB2645;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;3:M/k8/9ybvPpDFkKRs82mb8RbAPGRhi9RjIvSKL8XpcliI1AvG4ziy6Ajbb3ckAUeIihzMr/d2E1Rnj4aiGz/Tvb3l9NRBOZu0u+hIZ3a/H1b3JKsBJLgoGmQTpfYgRgQPb+b/nHjG0PQUNJCfhdu18/2ON7sANx6jgtY1YszKvYnXycQRaTTyFCieIV5uFzhEvbjaYRPEKDRAS1PVPXkoLPLHvFj53y2Nls4oVW8a5YdYyfdi2UwkRpr+p21QySVoowE221bWlwd+gNMPhje8H1g63kUtbIauy5XCPumAmlC7Fif+7OX3n3GyF6SU+CqckyruYufjE53oad5wfo328g7zcCCiqfNgW3NVd4cLsrOW1wlxsO/4+nOFOSOuwBt;25:yaX/DCY3cBCcBeFJpR6QkTq+AoL4j9B6+7JTvuiWPVcGoZEOeW1HTejFc8T57dJqoG3EL4HKNC9wZExr0aPjO8jPl7Qz8jjTTxZqHR/LSGnRcq672trpxTQpuxFM2G3hBzSLkY+EpcQpEFYiEyRg7F3g6ryP+DkXSy+NtqwPlEMP9nrA1oN8DJl96FuxMYh1g9S+shRky9PGE1wQi1aGVVDTcqvQw/5GjCQN2//8tjt4jwSmDxf9GgDUgw+geZbiIUgoXFdpak7ln082m0j3lQkVj4/NC0VA5b5aEPEYMte6nTJtooRUHXOW0Rnq2BJgkBb1Abvxq4rIaWUkTj/hAg==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2645:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;31:qra52x2n//frsH2aLNPhBpxwIbOinx0yDEi1MpIVpU/65UUJCOaF1qCVT6hmZmqUQ2B0hxO0JBw3o8kHFnhzW6sMz23SF/gwyZc+iZWdBsoqg8WM8m0Q6ZAaPt5VKTenE0+W9elAdYD4Sr3CvHHzKHa/AvhdYV5S0g0YGPWwsKWWe7PmikLlW2wnm2MzuqTIRVSqZgbbZ6wzosm0RLE2YDY5XJHACyvmXapfO5Q8vZw=;20:F94KOFtmInY1a1E7zl+oCZF4MA+WntI6DVlcwVMSo4+L8zwcTRWvHHUtiq08JpfvVkN+RnV5VLj8l1+RURslk2SWHyY4SdRqFUNncT6bK4CcZQF13OFUbTsXjtzpZSXr5tFmYGShzveipDYaqP06aghx8zM1/GucO2fuvH0Fo7hrW2NcxShQOLeWfswqcozPhgDAmktEgWaKV4lDk6ozsAfbMp/SeabYr18tHdF/S7oTQneLyWRqHpKdK7S1GbCHf3GeSJJfGH49OfPVjRjS9o6bfmpEsGsI31sgUujkcV3Affr7Y2yslMY2BouXzpCcY6PqQ780ssOBWquqc+cmF/QbFHj8opWu2Ty03Ais6+RFAAzL+J0OqcI7Qgr+/1KOfq5oEiE8Ez6Qu1zqR3ql3TbQuXnf/ltNO5fNnKlYgH/DqTxKqxCRsC3QQNt8QwFlG7+dSwXOljgX5wARemCzTqQtPD5hOzKnzMtL8UBmj+aXzbP6k29g+PU2KvJtLaGQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB264549EE7509D7471A633004C26C0@CY4PR02MB2645.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;4:8Pg7h/W/q8odlEzillorFWGvAp8fs/eKEmBGzb+3pSRedOfhMI+xajDCCYyN6Iq9o0HMYOujfggXdrhcEVQl4Ztcf9oCY3Z/vy+Qv6qAGS7j+Kj63x8cfSgSdvxCKYY1BsI83kathPJuvEbN2ZK8ZorT2dtOIPz3RLf2fhutDloLTUodCmrCCPJ9fzm042WruGT2VfvAuTqW8NQofa40ANOWvRffl74dr6amePvHCJGHTmbYWbFRm2b0+cuij6bnK3zG9IoQEJ7228f6t5oaelddlrTvX3xYRPEbVHzNIuFB97xAcEHuTUPtDQgjexJh
X-Forefront-PRVS: 0937FB07C5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2645;23:ql+g8LlZ108rVrpLmMpH27lsH96NPsS4IVwU0H4gX?=
 =?us-ascii?Q?bkm+/ra91tX97uS7UK8QG4MS6BZfWfBI5U0HLyyR19hVSaGNRCowem/4W5Fu?=
 =?us-ascii?Q?hYrrmiDIH4aNFaRkHT/FxXsEkE2ZsllJEtqFvJV6HNQYe9d+gODMYdItnQyS?=
 =?us-ascii?Q?HKhSlaLmib1nMwcQ8JbC86jJOvkJva78VRt59pbfq3gWes9lOb3a/FPo0fru?=
 =?us-ascii?Q?q8QMB9I7YROV5xLG5CSDlOdbP3G0gHu54R8I1tE+dwLlenuxXDU2xpXKE6Uq?=
 =?us-ascii?Q?RbQ4p987p2b69IyxzesUkGOldmNOLnwf7/l+YNrCGJd+O83u8RX6FbGh9HO2?=
 =?us-ascii?Q?Bq8Eh8WHY8Kx+m6YTT3SuZuZ01zrpEJif7ig46JRvqz5GVByiO0weVAtDHYO?=
 =?us-ascii?Q?YQCIU+SBqZwv8Q33/GlFInS292F38aaXomEQ9M+qO4972oszwoj2Xb1WXqWq?=
 =?us-ascii?Q?6REM80/Djzbhf3SWzsCsoyqiVt+P1omRg+fd2Xbg3EZwe2xXwDHwgNJWjSfR?=
 =?us-ascii?Q?HdCzWY9pV/ctjidgVLcPpYnTI6Y7DlGFT1+1Z5LyGuJaNFiW914ZzMxPpfDm?=
 =?us-ascii?Q?qr67YGMLmb5+aGTOP4DPwKfYRZl91xci296Inn/s08PPlJAEbQud1cWUQbRl?=
 =?us-ascii?Q?2kpptH5Lj6gXapTwPwc47md4ZKijFuwa+oe0gQpnRpy7x/cncRolfCT+Av71?=
 =?us-ascii?Q?7rbmDo9p8K5NND/Ecrw2piDibBWXU1bzB6OnROPItWdVaPXzmwbUmWTjDzVt?=
 =?us-ascii?Q?DyxGSUA0XupkH2Y65BDxhOjAO+z2ywigZQ7czTVvxRspvQL/jHL2FhWApyo0?=
 =?us-ascii?Q?t35ndev9M/JYqFBjP9GzH3rnK4n8Pt3vkutuGMq5D2FptYtMMqlnEyfdLpWU?=
 =?us-ascii?Q?/3swk5w6sRlayvpKqgo7EUr2RjRABlEBEF4wsfaBPFGJovZrNlK9Q9nnLSaF?=
 =?us-ascii?Q?d66i/0j1+xsGM9oPva7f+xFSOcM15vdUJTd9rfpeSLs+XPiHEXRavp9O5/vM?=
 =?us-ascii?Q?V2tpuGx0hLLvUME7QDju1uZpL/Sw+ULfobeDcap06bv9YmPHiuvKyPPF1uUW?=
 =?us-ascii?Q?P/23oDaD4hsWH/fmWE9m/9uQlH2sNsafKugSJQEUETmkYQHwET3qTuX2cbuc?=
 =?us-ascii?Q?bwLDP5krbYd1o9DG0J3viQ/TLyCMD1B?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: U9K6WvI+4ikMkxhyPzIriDdnzSeRWE+BEO1Ns+DG55EgTbOO/2s23F50DOAHI7K1ZIUTbLig2sYwjNKAjYa2GFHxoqpaMVfUUkzfvn4oFUULW/EP4Tp0WlSijM7zVt3fwRGaE5V0QQ8z4I44nDNVo5YAVAsTOJMZtcMzl4iqu+j/vAKIBDO4FU6/avXFJ5KqsC9Xp5jpgiNhXo8YoWuJKyxNsoD4gcHoGQHrizAFgsC93Cf8Nj+oi9m9mN8jBMtl43HDyZfm5q1dFBa3BkrZ3KSpoZyQjuRibZEcwDQwA1jOdMVlpjW3Lcd6h4JFAKWJIaEDBExPOASuH55ztj2pVKY99S/8/DK5nYenQ6WjgHyMw773uttXK4PlweHN75R9gOMd0GgFfj4CmDumcbAt0FdOknUOxT33bJurYcYyxww=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;6:0AxPm60hc4772fNWg618eOUuTD0nO8n0b5sqbpJ2XvR35Stfgj7rz9qrjmj6izvO6aV04b+cGpnoTdB07bUW4LxN/ZsB6VGMBoVCIVnXSk3OMp9roIHlJkfEfUMvc3SDPbgNGNRNJILTZx0+lT1HF3FQ2hCAENZVEw9l0SPb41IVr6OB9q9yfLojZMh5pEbNUHp96g5MHZLbGH75+dCXYrYtiZ0lAM25/VyjRU2Wmf/pc3M8Q008XOlK3DgV2mEyIlX3tCAWfw4z+CDgMjwzPG9s6a7mVnOItYLx4KoD5VZOsumU5+Zk6jPyDS6e6VFzQLhUfB8s4dI02YFPLVIE4RA36Tjo0zqkTfr1IGPWDglUruE2Tj6/4grcomhoolF/P97mCNkpJFkh7m3uAYTEqnlCnW3iDXsNBp46DmsB9b/Sf+3qfUp6J9xT9TIJb3T3xIiU3Mz+Pm6ibrteCDD9dw==;5:oEP784h3iahiqJ+8X8G6RYn/VjbJeZWzCJBmS20pYgoZyamoZBMWTEpS1ePf9YaxYLqqM6WaCExq5AV0O98+8a2TbTcZBNjN7XvxDOqYqld5l+nbllOUCxyYkK5ZzPsvSlhLH8GvG4GVAestOfg/TuqEsncIt0/yONatZ+cMrUO1UCv8BgizVkhN5KUU7WitPrFIu7lJeCj1RQSLYQRZjw==;7:l5dGNaccNxYgS9XBwTwaZ31bhMfs+2i8Wx3kPGS9+4QmbL1JIM1NF+B34KqbYLsgM+H40BSlLaH6BgaQveU0EfmvAfzkWZfv7+GVoka4CslmroZVkLKSJ8yADZIUxFQikmmUxs4UIbj325Kygb34fg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2019 07:09:47.4059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d2566c-9ce4-4d2e-e4af-08d689a69505
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.
Changes for v1:
                -None.

Changes for RFC-V3:
                -Changed nvmem_register() to devm_nvmem_register()
                 and pr_debug() to dev_dbg() as suggested by srinivas.

Changes for RFC-V2:
                -None.

 drivers/nvmem/Kconfig        | 15 +++----
 drivers/nvmem/Makefile       |  5 ++-
 drivers/nvmem/zynqmp_nvmem.c | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 10 deletions(-)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470ee859..2edb1428ef6d 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -181,15 +181,14 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
-config SC27XX_EFUSE
-	tristate "Spreadtrum SC27XX eFuse Support"
-	depends on MFD_SC27XX_PMIC || COMPILE_TEST
-	depends on HAS_IOMEM
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
 	help
-	  This is a simple driver to dump specified values of Spreadtrum
-	  SC27XX PMICs from eFuse.
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-sc27xx-efuse.
+	  If sure, say yes. If unsure, say no.
 
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4e8c61628f1a..0b3abd7f5d02 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -39,5 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
 obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
-obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
-nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
+obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
+
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 000000000000..b910864e91b7
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
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

