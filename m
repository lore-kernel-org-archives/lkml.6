Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE1C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97074214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WOSheXtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfAIJ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:26:59 -0500
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:8155
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729686AbfAIJ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al1+5ZDCmqYuUgMFkT9gF+ZHEX75an7ZSf9ba8tJY+8=;
 b=WOSheXtO80fzcXgEFxUHRTLQflmbGpZ3nOObZd4tpON/SEzqt/lIz9hX6M+z50k4LIhq20Kx/qIcaYbhASTmKlKbXQfeuUadHw7dnWr2To+5ow9TAV2Su6OVulSYA9C7lyKGF6ZChSHaDASJTz1pYtJeMRmgWKr59MjvAppOEuw=
Received: from SN4PR0201CA0054.namprd02.prod.outlook.com
 (2603:10b6:803:20::16) by MWHPR0201MB3516.namprd02.prod.outlook.com
 (2603:10b6:301:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Wed, 9 Jan
 2019 09:26:38 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0054.outlook.office365.com
 (2603:10b6:803:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.14 via Frontend
 Transport; Wed, 9 Jan 2019 09:26:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Wed, 9 Jan 2019 09:26:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51891 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA8B-0000WZ-3m; Wed, 09 Jan 2019 01:26:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ghA86-0000jl-0O; Wed, 09 Jan 2019 01:26:30 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x099QSPA028521;
        Wed, 9 Jan 2019 01:26:28 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ghA84-0000iv-8A; Wed, 09 Jan 2019 01:26:28 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 606C5800EB; Wed,  9 Jan 2019 14:56:27 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH V2 2/4] firmware: xilinx: Add ZynqMP sha_hash API for SHA3 functionality
Date:   Wed, 9 Jan 2019 14:56:23 +0530
Message-ID: <1547025985-7228-3-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547025985-7228-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(305945005)(486006)(63266004)(4326008)(50466002)(44832011)(316002)(47776003)(106466001)(5660300001)(42186006)(356004)(6666004)(14444005)(126002)(217873002)(11346002)(51416003)(76176011)(2201001)(26005)(52956003)(336012)(186003)(446003)(426003)(2616005)(106002)(81166006)(48376002)(50226002)(8936002)(476003)(2906002)(478600001)(110136005)(16586007)(54906003)(36386004)(81156014)(6266002)(103686004)(36756003)(107886003)(90966002)(8676002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3516;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT049;1:cjvH/JWlpHdT+3pFuRINBkAk8SCUZm9Uyx78c1H3o/PmZ/P7Ks0DZw+yqJ4XICgGWPwXMlpGYz4mCn3KPQ+JhmUYB8wHj1/0AFKcyP2OYNrD9al00LVp29M0ZW2GIwOV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8934132-f26d-4e58-fb44-08d676148e32
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;3:JDDSUa2TN/6vOdRa7NLOGbo4l3pjOcBoFA3MRHLX0X7VuJCpNGS8cJnF02lQooTdVFQqptEzSK366y4nrj5yh9Qdp/drf6TmRz+bAg1iIQ/XV2x7qK4iJuOSBS4/xGGip5P+etE2JQD1XE0A8i9ePzDdVOYoBe3Q0V2KBoBfaPzNXlIkx3BM/i+IS5i82dk9myHNSSGLXHhZey11G7JecVkKkoTUowj8cae6czuDvrDwiW1khcKtl6Sg9J0fwxCrlKdiy3L0s4k0R6saDgHw8eYp8Ueoa/8NLW8YwkqnyoNYrs8D0QAeSQcAoW+/qyjpEFKnqlnoITbD8gJ3fFIUDmL8WHFkBHEfHNHq5gMFso5z6E00ZWB4zKnBpZ7YWogO;25:ndaGYPr213PtSmel8tShQ6Kk5HdmmvX4L6Nmc07XqXrxoD21zY6lp7MbzMS8X4PsifFZluvwbiZ1+pNSMLInraWoXCMbpOND/pUrsITEJdnoYQGUZnU3ibHTGsemGDYq3RfacRidVZG3Yw0wVq8taveWEsHTVkk4pWNnNX7GiTvMq/r9qM7VF0Kq7sGOCfFktXnaO03PlaM737r1a8Ffi/F+NIJsdFuUpNebZq+nq/FDzsq1p9pMhq0tpx7nlcCBc8MACIu6fVYRGWzbzj8AtlQSAK37F3EHX9vGy1ZGLFG2JQY/iMHP31LLerLvv4EQzPDNfBKxbmhUkvRWC1yXUQ==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3516:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;31:URhtZicDhEMefuDXFq0/q8L9x79uHecZQFvwwV7mvpS1Ua1xXOM3YnzkulIOySmH51uod/0XvE17luaenq6z1Nx1sDqBfRoXyVslGyEVRCVOR/1+5OQmZFfXqIX8ScVY0wHfg0CejTV0gGxRU7G+m2ide1fibHefhkUa4UFe4vdcqe4D5DNQQsK8AUNE4PrA2N8hBnxdCOTjnZUhJpaw2Do4zGUagVL8wGEebel8hvE=;20:3CBOzyMp0j+9fdnTU7GiXfPZh2Fz8xJUeP0wg6q/wQXsUglyicBfGOc69LlVJGhSXWTHRTvs4BV4qoV07oT4hlVG6W16xmEwiUBz0U4HSkcEnLEyl8zJhdJki7bGFp9FBeCAEOHK1/7yKYsjn7NaPOehIDFSk0GZy3tsHfXpXzQ+i2d3wH7u0wY0qOKMROQIT61RJNgJ/QEQXL7TqOAx8L/jxp13oWGrzuKHQkJSh8YECXGTNdIPDu6IG3SZ+M8HXtVrjINWy8XKmYf6M2KpsJ2Ft0yBPYn9wklRyMqjTZwKCN8hPF/UUPKsDxwauCDL67iuljk9j1gT0+KlkATuAi39lqWI0UkSMFofMwxZ7vgBaav0RBZjb/oVaZQmJT37Ez0fTqylcit+eCVZgsCuXb//7pAFBAGMw4CD9pNlGz17ekxGRKQLxQVR6jXFVRNdb6ElcyzcMoSIsl6lggGAOaVFS7YzkSjZrl4Q4YZe9/gpN4O6nluJGoPhZ3Ma2pP/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB351658332DA1EE85506FA9BAAF8B0@MWHPR0201MB3516.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;4:aRP4+5qlK3vdi9Tui+6WZSLE+r2Ju/L3a+3sbHr6MQJ7Gkt/YW8ck76Z6WyHX60T9lykTBiq7NicxkMKMq48zQaH+B0OiNTsusTbXuvef/dOzISJE+DF30NKNFDbaz2p2Wpa2KDbwcPLYdB7V3JtOZOH/ZS8qeq4cTT4fg0QiXa/WB4Nyeg81OT2OD8xsS0O1mvp3oVGqRUSl8lhp3BJ41T7pXQdxMBPWK71YjtVyj47S71gNWIE6sUZrgmLy993qUhywkXiPuF3JftipVsoJoz2KAmWO90vAP+tVcLUvI5J07mDo9oelgO9v2G2dPD1
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3516;23:RU9ufDKI4u6Ujr5oR2ESbov/Aqk8amz6D8BkENr?=
 =?us-ascii?Q?o1nidS6CSAwPGNWcQWTdNYlKEAd6rj482lxAIYdRgdvQTm41MN5AkDCtAPAR?=
 =?us-ascii?Q?vZ7U+3WTWrwHZ+hQSJT9a964LfpM5GSf8R+IOtIMZ+yZPIhAmujIXxhFQcax?=
 =?us-ascii?Q?Tzxf74DtzxoszM105YeHeENVA4Ya/CAhI/HIO/fl9DxCt/HJDROmfZR73FCe?=
 =?us-ascii?Q?XnXlfpjhYyXMjdbX7HlRePpy75VxZRj4wwm75q3eaS6zB5pMdzeHhqyhS+Ea?=
 =?us-ascii?Q?uyLz4gUeHqU6b57yeCNlqlQONnkp9DD4IcbfV9mLHWykB5P7YIOug6ldqlN+?=
 =?us-ascii?Q?pRZ37QzYJtJmoiZZL/M0MLWEvJvz1LeHexevNjy3jy8DQqPstWfRTLDCGSTt?=
 =?us-ascii?Q?MaTKNK6wKwrPTO66PhRLpgR1w7I6bH6KQlNuETM1o+SSd5Ivv5kz2cMXclYq?=
 =?us-ascii?Q?XnE6xrCcEH01waP8FJgvrRPVClTCTFx76aQQ6F3h/FCgFmFBGb7S187GQyoe?=
 =?us-ascii?Q?dl1cgwYt41sBCF0/TiTNCuoESB7J/71qnKWpWpPKdOra/WQn1XWwJXZmER+k?=
 =?us-ascii?Q?HmS/adnLNjk+m0aKSQrBulG2kL9j6BN7xvCuZzCWWinNz6Qo2R0T6gXbgtH4?=
 =?us-ascii?Q?EX2GyJ7VyTlIqcQ/SKdvAcD5PCQmk0j1js2WwFQNhig7IERPGBIe/LrxbuxD?=
 =?us-ascii?Q?w9HXmX8VsAEUNDoM94/SQ+3njLIgQXiHnqJJfVhljSPq3LkEZB3lX7NO9QaE?=
 =?us-ascii?Q?XoG1u0YJhIiUK0oZ+CKd3UgBfPM9yxa07CBD3WmWdDDrrXwaTdVxTra0kWkk?=
 =?us-ascii?Q?NSYp4f67TWvBiwBH3kNjFMftV5VT0Bz4hPDxUgw2f0bN8pisYamhgbrBPcYM?=
 =?us-ascii?Q?5Pg/WHH0YizXZpUhuMv/SlFM84TSpQeU6q51s1lLRv3UtPsVAb3feFWpzg+h?=
 =?us-ascii?Q?6Kwtbms/yw0/nueaTEQw1DlQycpY0YyBfckD89BLOwgg6xhhXpOiYJZwVFh3?=
 =?us-ascii?Q?2o6RDe5kYEZ2nPanFH/WlzFJpRB4nJiEegefuKNyDnVHYPMxfTcHiMYKBRJv?=
 =?us-ascii?Q?RiV7kBdYxsco9AGv8+xlhAmNFDqXyNc70u6H54PuYJ5ojIXagY17d4sYDxm5?=
 =?us-ascii?Q?tubB7+d0ULJXP9b8xa0cX1llyguKWns/Rcb6Wgt2G/GUDRA+25siX0rOMPAx?=
 =?us-ascii?Q?G1Mg99RHNq43sQG7AKbaISiv/KXccxwy3i3E7410Nneeq8oX6CHtJ3Lo+hUO?=
 =?us-ascii?Q?JqwkHn2EFIOrkfx1ngUU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lc6qTu7QlPsbWHRItoxTTuzp9Jpfa67BeaYtid8Fs2XnYWR+YJRbkBWJR+plFJ9LQULPCM7fDhVGexJY1Y/6bOlJtnT7UtSckskH4H2kTGP5BUtrhTbsXZAkvBMjBAVXm9mf1AuW3JGy2+eYLNsiZgNUXTvweZTrR1JWd4wC9nyi64vBbKHbu2DqC/BsrVJSIYyFjXW2ERR1uRML6bYEcrjgBJpsyaEgvOichWnDeAJ90lk22UoraWwOBT4YMLBi46/oALs/fM/JxGuZ2JlP7XXTlg0zrswRMmJ5NkTwTvSL2x4MYl7Mi2/C6Sd/o7cd
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;6:I661GmTsRmaFJIoPMtrmE+zMEEUUJUgQOOnrpKfp5A58RXJa5lo+oSZrRa1jP+cUFoP3s6kUzOYZR4Eie5O9aeR39UJCxNBL2zg7tT6DbBzHpgPUT2Y9JjPIowqT/yFUGhRo5rsGisX6YPC+vANk9jAP25Nlzts31edKpHgwReJebKKdccp2Ama9PZGW7u3YWeYu0OhzqbIGT2XXlscgriCbRU4Hss1e3DOYxBIZ5YYRVt2kUlmPlCj0RvNcyQV3An19Ays3EAkZ1RSPyPa+Z2k+migy8bYcErHXayNTRVTn7YbSSwXzmrRESSS7Cel4ZGpkB7N0FmuRQQ+K5AxWXyH8mZdZ2ZJjPAQXJ6VLgO+I32PABUNiCLY4ycfieMzBJmGBrPve+xqyfZEVva0qg38WexlkcC7saphFoNwUuyo9rMsEMfUZi2Z0zupJSUM3WtcDHMBtNWk/3gcV5DXprw==;5:7DxhMR5w7Spje/7N/uqbMSqv5aTkwaBSgmTiMt6Qo1n8gCHDqcti/rZAWffpbuIvH/gcf+emL0JMqlEtu0ieEJe4uMP1OJHf8jGphmhkuIJjs84ZltCFxXzUp4j0m7zBWI+5CS8aDsMABGAYNfwH2Aj6y8q+TdO5QnHw3EK/rIymyLzFVkuCUkMKNlu0mEv9e8vU4DS3Gho5VUbsiaL29g==;7:ypUm0vNmgfZnWeJ+/o8tyFpHPXEWC7Y/po/1O60XPvqfGqYaF1WodkW1CGbihW56R43gNDcuVdbrm7NLNl7OfG1yT3GsuME+XPZzNK3v85bpZ37mO0wZ3fJzr50UuWnrmn6AAQXzqgeJy6sFXSnK0Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 09:26:36.0226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8934132-f26d-4e58-fb44-08d676148e32
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware SHA_HASH API to compute SHA3 hash of given data.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     |   27 +++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |    2 ++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a..c51ecce 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,8 +469,35 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
+ * @address:	Address of the data/ Address of output buffer where
+ *		hash should be stored.
+ * @size:	Size of the data.
+ * @flags:
+ *	BIT(0) - for initializing csudma driver and SHA3(Here address
+ *		 and size inputs can be NULL).
+ *	BIT(1) - to call Sha3_Update API which can be called multiple
+ *		 times when data is not contiguous.
+ *	BIT(2) - to get final hash of the whole updated data.
+ *		 Hash will be overwritten at provided address with
+ *		 48 bytes.
+ *
+ * Return:	Returns status, either success or error code.
+ */
+static int zynqmp_pm_sha_hash(const u64 address, const u32 size,
+			      const u32 flags)
+{
+	u32 lower_32_bits = (u32)address;
+	u32 upper_32_bits = (u32)(address >> 32);
+
+	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_32_bits, lower_32_bits,
+				   size, flags, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.sha_hash = zynqmp_pm_sha_hash,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28e..72ffe09 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_SECURE_SHA = 26,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -102,6 +103,7 @@ struct zynqmp_eemi_ops {
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*sha_hash)(const u64 address, const u32 size, const u32 flags);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
1.7.1

