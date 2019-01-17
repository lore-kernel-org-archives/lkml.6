Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D47DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FF720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uMzdtGcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfAQHCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:02:51 -0500
Received: from mail-eopbgr820052.outbound.protection.outlook.com ([40.107.82.52]:49856
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729597AbfAQHCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkuSW2sh0WdxnATrGUtgv0ni8XnJJWcmetfngirinfY=;
 b=uMzdtGcdzLZ4vAdxqBV5EUTMC1vdxmAgqmZbJntOGG5sdZebdC6HbHclxL9zheNsS1br4uAo0YoWYNbe5ao3gVbCuujGrRHy4u2L8ekOjdZkmyP1ycsR8suaXHvYgtGmHLSxNVbAhRsUwu9mjL2y/jIVDwJbh4h5UBa9UM7VcrU=
Received: from MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.19; Thu, 17 Jan
 2019 07:02:41 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR02CA0014.outlook.office365.com
 (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.25 via Frontend
 Transport; Thu, 17 Jan 2019 07:02:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 17 Jan 2019 07:02:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42114 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hI-0006rj-Mi; Wed, 16 Jan 2019 23:02:40 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hD-0007Rm-IN; Wed, 16 Jan 2019 23:02:35 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0H72QPt022400;
        Wed, 16 Jan 2019 23:02:27 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1gk1h4-0007N7-9P; Wed, 16 Jan 2019 23:02:26 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 6B9E3800EE; Thu, 17 Jan 2019 12:32:24 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 5/5] crypto: Add Xilinx AES driver
Date:   Thu, 17 Jan 2019 12:32:21 +0530
Message-ID: <1547708541-23730-6-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(199004)(189003)(90966002)(48376002)(316002)(305945005)(36756003)(36386004)(103686004)(4326008)(356004)(42186006)(6666004)(2906002)(6266002)(107886003)(110136005)(54906003)(2201001)(106002)(16586007)(52956003)(47776003)(26005)(63266004)(6346003)(217873002)(126002)(476003)(106466001)(426003)(5660300001)(186003)(336012)(50466002)(8936002)(11346002)(446003)(81156014)(8676002)(81166006)(76176011)(2616005)(50226002)(14444005)(44832011)(51416003)(478600001)(486006)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:zONl3tZy+JxTjQUMdBVdDKcWR5ZaReL+lHt85NAHkdWrbolVg+Egd2scf70/8R2m8/2ZPTM4NvPQURs1W2612dxPI+Q7xN+AydVkQKUu6XoyhLM/Ua9dfUioPvAz2/gE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f447d72-cb63-4734-2032-08d67c49c5e8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:uy8KVaDMLfXfX4i5YxJMyjSGiyC3vIOCUuH687zIueS0AjjbEpCn6jxbfp88waRXF4mVxRETY0EH9gIa2EuNsFTli8XRZSAC16F4SPrQ75Gwfin5fJbwW4pQXuKdn/pQ+5ulGPEBUOEHvwB81DSd3v5BgIaiL36X1g+72GwC7TRzLYBKgRgORzDzG4bqxL7P+ymKWuo9RVEMkSxTRa06D2/uceB1MaTnNKgdGcMjf+pMX6tisbLtueUyD/lS3IRzNY1HRypEaWfUCCAfpXieRDpm333/MCo/1D33PY1jK9SINQTm3VHgfmp+PsguN+xJXQvtCFsm3oYFtcuvz18+I3aU2YbHzLO50uxD43Svna3Um65fvaCzrpLsrwAW7uVl;25:ZSe5/Y5UB0/M+8Bp/n1x24ToDVS2q4YHEfq7JW0kAbWVN+mGLaSXBs38uxcO/077WJOw278m+E59qaiH5SDpQvpY+zrt/mmkxDd1GbiVV1msdzrUvOtwBtzauVRPbVAvjpOGkyzL4ttB3e2+S8fWWG14X3Qh9SDw8/Twt0MgjeHj/xAuoKjfSkVsrTOL4vHEtSxOw0T8LQ25+QYiWi7XnHtpKkMZxxtnXocnjrRfdQowDXLNVlBTMK8Kv1Fb8KJjliZ24BuH4ErGvKFvuaEqWFSVVFS+x5/KyDLEPQuZWjP9FlJyT7lNvgPwJ9Ix9xPJMdSbTqf7meRC8kfKRuazpw==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:dCZgbX/qkYzlzl3LqM6gSS5XhT3bhdFP4f4jmEseUlHfVzXviIus5AVi3nQwhF8XMBZP1oIp7BOHr3CtD+VdKOOWMS9O7TkF98MrczPNtNPxN9RblPiJpOkBXuwTZT64TSF5xwKoCLJ7xNOiHyOF/z2YtznOB84aP3TrcPoKnN4+cHy8vqnWav19cfpmoP+xsIzBo3IXTX14HuAqIERiYvRwO5r/bTcbcQErY+L68Fs=;20:E7NXL55JxWUTWQ1jX+SydjlI4vf3zHY5vt56yw0uuREElWr1UWEXENBgytZUv9gwjNPMHVVbqyk1Ayj9fjQ8uq8mw/4K3Q7lqtTmLew7wvJGWoUczlpLvu6FA2OIp3/wQDNmVql8Ww8WM4Dw7IGQK4VxeKKthOJntvxTWlgQQj5IAU2DOJmXy61F7Hi2ffLMERTd398ozLO9wx/lC9XCn9kn9VOi++effsrDPRJF7sv1a18Wc/mzhrrXOwz8/6xxOKyvfxXpfEH9/3i4krILWHHnhn2tyeUOrfGeiGBPajMj7cGSuKvcsM5aT2ap/iQtYeGMK2eP6fE29YzP9oqpYipC9Dq1BWM9gu1G1eUQcJ1gypIEOp3XfNY3QcThSL2DrWj8io/BJTHgcyebTW9aazq2C+VY1wgB/e6P0ga1bv8Qc+Y0kc2Gg47X8uyBfT0XWwht6O2FBA5LoLHLJ0snwg/hVAAuuP8pfSmeyC9aFOkW5rObaKt2c3Mf8trNGlfN
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3510684DD89ADFFCD06E8BF3AF830@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:BXbX7co2eYjMlwPC9NMcTrC+PbBae5FiWrkq+DFeKBtPypwj6NsmpKsbCU8zAjC4tVkz7cL+VCU0cB31s6XBMo5Hr3aY2Nuv/ZGIqGXrQBeZ0EQYHSKjtx/Z6eCh51y4yG4smg7FbZ68ABP/uiSNSkOqn3IIFBsIATBjzCFnY78ILscPm8xRSiAJN32Or+fLCNtwJZ/XEJ2c0f148hAMhPZLfKM2obHP1VwmrFt19t1PY1JSt8t1VTK1fVwLsX0UkjgYRH4bv/gfjrGB0UJSqWTWWLOM07WsJBFDzfD52HckhwSn+2Tl6td8cQGxOaIa
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:jCCKt2RUkmFleTUQguOWzossh+F5JQfuw7HdcZr?=
 =?us-ascii?Q?HRDNyYnv+zbuqQu5WcO42kHwIlArEN7528ngifOOm7ttaPqfKkaz9I6AwpXU?=
 =?us-ascii?Q?OBpFF5qmXKPfwmj7ZzMnCdChbZKs+63B5HIebSv4l+AiSU7Jpr4Vv4jH5ox+?=
 =?us-ascii?Q?hFlFewcsZ16a3ZOrt/mfZJFepTBosp588iPM48wC4aEEA0R2pJi8NQeyHmTj?=
 =?us-ascii?Q?Chyh04LM8E8TxmhV+G8wnxUZrDiTGuo7GAfDrvI6LvSn/pizfWwioSrQOf8v?=
 =?us-ascii?Q?hJaelyX25kxulPtVqfurp4ht6jydoyarMkZKWl6pTfTtKbyzH7U2COcFlobu?=
 =?us-ascii?Q?gVCZyvltqnEt8kt6lOF8t/Rl6ZtBpmmPu1k4RV0fLudqW54b6ko7TpRKRj42?=
 =?us-ascii?Q?SnTwT/b2GnZQM6eUfpCUjgBycw1w6R3dDjW1ya+wgAGdBT/AJ7p42yE98GOl?=
 =?us-ascii?Q?rZ4gngs0bCjMDXwjDZeTLoKVPppM+/p4cV8ZjVU2cKVJ6TUq6DkqRhFaDmH/?=
 =?us-ascii?Q?SkEBmWko94JK5M+kGPRPUW2D3iQ/dLL8MHl/tsNTxbQf2PV2GQlmF2uQO1CJ?=
 =?us-ascii?Q?Lyen4f7jMqxy969PYoEUwHXir7PXBn8P+NcXcYLOQA/FlbS+ZXeqSEOuqLns?=
 =?us-ascii?Q?v5MCUeiA5M6Mrp34sXSD5z5KYBdt9YL1tgyt2HP3yM9CLTv1nCt9r6yPVKvv?=
 =?us-ascii?Q?fvId/DlWBPLUaduvdjJHU4V60oVfHmfsNw6YzDS1aa/NK+lXWMT5aE324zxY?=
 =?us-ascii?Q?HDspuDSgI9WNbiS74I3fg45RyoEekoVOuCJIVQ5olN7iMekimHVQw4W50Nff?=
 =?us-ascii?Q?0v8O2arAfuLPJhcblTAzAw25+ShtjI5zw8tJIdvaL5qSSP2rI4upHNbNL7U5?=
 =?us-ascii?Q?mCcE64qkyjjiBth6Bk3Jx74hkUyAkxm9BwLvNKUCIVS146AUaBpWko+FKjQO?=
 =?us-ascii?Q?taULfj8GzKDPzyG6QCmrXPWdwhJv5b7BZkUeai9192V+uwZhpZ6Yz6+Fox/b?=
 =?us-ascii?Q?Z5qad3MxXFBbBqOUz/X6e+O7ZCiqvLE2QrC9bYwEWfsi+go220MwVMxP5w2q?=
 =?us-ascii?Q?afyKri9sYvgoGh2sn/zrrl0RTlyaR2S6AEIjMc8/SEXWnHwW+DCHESZpIan6?=
 =?us-ascii?Q?uzwFStRTne77aeaz/gpithsZoPDBHDX2/hAp0pKyR8+ATJkPqB4baVmFQDbz?=
 =?us-ascii?Q?IDYg+UTa6O/akZiH874udgFDqEaXEm7r280vu3V0r3tc+9Gomq6aDyZJXrdM?=
 =?us-ascii?Q?+AffG9es0hRNLFvIm6mArYTfrJ4f8Tga7LIux2j8b?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: utrZFv48zzdvtzImdN8ywmS9iaGrX99WuaWmOPTuxXQYtDEoB3KTjPOe2gdbERVwyDGA4s8Ws0Rivx55g+yjpWcBpAzmYyHQBtnbOnkJiC8Slw3FCzXgapVWV0MtLB30MffrXPbrQQ6XfE7iFM083J1jllW3jSNOn9xEXYjcQhFZVH+uTY/gqYsqrbGkBqZ/ogkSr7nnleKwihMi0GKhYXhud84mLaJJ9glLvmapjOXL9rdy6fo04ouIgqoYTx2FdgxQ9saLBaXfFyOYRIQTzg7DWe5V+XcvG7z03fhJ/RAgjIiJHSQGIVvfRPrnbOwk7VoNOvcsROShEESgIjlhyCx5lDaQo2qf+8psvKFUpKyV7H9tS7wvfy/v40UsP7Xn6ZYVYanvRY4ALO8XBLV4B4fCj9qUe02cjh/ehNn0A14=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:tVuK+kY2+GdPLT3FEKDQaZ1qzlzK82GRVLjBvpqf4cfhFSgLzn1W7EfZJNaAv0osZgLkTX8YUSFZH2mIZEqCrRry3ObCk1uaMqVhoBEH2uEgpYIDXgKliRdWG0qHldMrFenBuralO6Eggtqrq7S8XKkYHR7a+1jn2qcS3iXYHXPjwx9nxoKU/0Qr7OTazNna++zHnVAULmNSLJzH6h8qPSeZwSxMDAdyzqxmvM8tBj35D2OeT7qPa0tTvAeODE5DvvzjWf6qCNFK4J+GkKvOtgzWuUBMOioeERb9/Sd4aK6Z2dOJ7J01vHJ/r9c6Ox4/iqnu9kHUDgeQuutbNtnjMVNhJJYjiCBwc19S4bZNVnQYemH4SRq85gUScPtWqy6UMGNC3Nff+vEk/Z9ZitrDS6FbLIYRMQg/tO2E6kML4tYdv7b2XcaOvRkQVGurDce2F169avj7bK95PXm6oJpDgg==;5:MJC6s3CuMXeGZC/ZN0llp/lEyHMc8vLXJH8nUFc3A7pJCaXuZMaBarUXb+rhIGPDFEzJkN2Zj/vhMPT96ThShlQjAeN2kdliytfT9uhGgiTdpKypK7sOzugu7u2XOR0iDoTiTR+wFrzrK98uwCyPcBGZI0rkXzHbSvrT08gZ7NF3wvZFYbpkonaq6Z2UoXWp9yUr+5EOk3vZqeLyIIlm/w==;7:PRuzKCKuihP5+59aQwGaHUpY9//1rMql7YbfrQkigxtqXcEb97EmyfGznMaVyzhUlS57R27M0FeaHzz8FHr2On/twJTRgGs/bgQDuhF80AyPFwimBn+6Cy7VcGp5gqut+Eu2OSwDEsNIb23n+K6OmQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2019 07:02:41.1003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f447d72-cb63-4734-2032-08d67c49c5e8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AES driver support for the Xilinx
ZynqMP SoC.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 drivers/crypto/Kconfig      |  11 ++
 drivers/crypto/Makefile     |   1 +
 drivers/crypto/zynqmp-aes.c | 331 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/crypto/zynqmp-aes.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 5a90075..66d9faa 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -667,6 +667,17 @@ config CRYPTO_DEV_ROCKCHIP
 	  This driver interfaces with the hardware crypto accelerator.
 	  Supporting cbc/ecb chainmode, and aes/des/des3_ede cipher mode.
 
+config CRYPTO_DEV_ZYNQMP_AES
+	tristate "Support for Xilinx ZynqMP AES hw accelerator"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select CRYPTO_AES
+	select CRYPTO_BLKCIPHER
+	help
+	  Xilinx ZynqMP has AES-GCM engine used for symmetric key
+	  encryption and decryption. This driver interfaces with AES hw
+	  accelerator. Select this if you want to use the ZynqMP module
+	  for AES algorithms.
+
 config CRYPTO_DEV_MEDIATEK
 	tristate "MediaTek's EIP97 Cryptographic Engine driver"
 	depends on (ARM && ARCH_MEDIATEK) || COMPILE_TEST
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 8e7e225..991b343 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-$(CONFIG_CRYPTO_DEV_SAFEXCEL) += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += hisilicon/
+obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += zynqmp-aes.o
diff --git a/drivers/crypto/zynqmp-aes.c b/drivers/crypto/zynqmp-aes.c
new file mode 100644
index 0000000..3a38d2d
--- /dev/null
+++ b/drivers/crypto/zynqmp-aes.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ZynqMP AES Driver.
+ * Copyright (c) 2018 Xilinx Inc.
+ */
+
+#include <crypto/aes.h>
+#include <crypto/scatterwalk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define ZYNQMP_AES_QUEUE_LENGTH			1
+#define ZYNQMP_AES_IV_SIZE			12
+#define ZYNQMP_AES_GCM_SIZE			16
+#define ZYNQMP_AES_KEY_SIZE			32
+
+#define ZYNQMP_AES_DECRYPT			0
+#define ZYNQMP_AES_ENCRYPT			1
+
+#define ZYNQMP_AES_KUP_KEY			0
+
+#define ZYNQMP_AES_GCM_TAG_MISMATCH_ERR		0x01
+#define ZYNQMP_AES_SIZE_ERR			0x06
+#define ZYNQMP_AES_WRONG_KEY_SRC_ERR		0x13
+#define ZYNQMP_AES_PUF_NOT_PROGRAMMED		0xE300
+
+#define ZYNQMP_AES_BLOCKSIZE			0x04
+
+struct zynqmp_aes_dev {
+	struct list_head list;
+	struct device *dev;
+	/* the lock protects queue and dev list */
+	spinlock_t lock;
+	struct crypto_queue queue;
+};
+
+struct zynqmp_aes_op {
+	struct zynqmp_aes_dev *dd;
+	void *src;
+	void *dst;
+	int len;
+	u8 key[ZYNQMP_AES_KEY_SIZE];
+	u8 *iv;
+	u32 keylen;
+	u32 keytype;
+};
+
+struct zynqmp_aes_data {
+	u64 src;
+	u64 iv;
+	u64 key;
+	u64 dst;
+	u64 size;
+	u64 optype;
+	u64 keysrc;
+};
+
+struct zynqmp_aes_drv {
+	struct list_head dev_list;
+	/* the lock protects dev list */
+	spinlock_t lock;
+};
+
+static struct zynqmp_aes_drv zynqmp_aes = {
+	.dev_list = LIST_HEAD_INIT(zynqmp_aes.dev_list),
+	.lock = __SPIN_LOCK_UNLOCKED(zynqmp_aes.lock),
+};
+
+static struct zynqmp_aes_dev *zynqmp_aes_find_dev(struct zynqmp_aes_op *ctx)
+{
+	struct zynqmp_aes_dev *aes_dd = NULL;
+	struct zynqmp_aes_dev *tmp;
+
+	spin_lock_bh(&zynqmp_aes.lock);
+	if (!ctx->dd) {
+		list_for_each_entry(tmp, &zynqmp_aes.dev_list, list) {
+			aes_dd = tmp;
+			break;
+		}
+		ctx->dd = aes_dd;
+	} else {
+		aes_dd = ctx->dd;
+	}
+	spin_unlock_bh(&zynqmp_aes.lock);
+
+	return aes_dd;
+}
+
+static int zynqmp_setkey_blk(struct crypto_tfm *tfm, const u8 *key,
+			     unsigned int len)
+{
+	struct zynqmp_aes_op *op = crypto_tfm_ctx(tfm);
+
+	op->keylen = len;
+	memcpy(op->key, key, len);
+
+	return 0;
+}
+
+static int zynqmp_setkeytype(struct crypto_tfm *tfm, const u8 *keytype,
+			     unsigned int len)
+{
+	struct zynqmp_aes_op *op = crypto_tfm_ctx(tfm);
+
+	op->keytype = (u32)(*keytype);
+
+	return 0;
+}
+
+static int zynqmp_aes_xcrypt(struct blkcipher_desc *desc,
+			     struct scatterlist *dst,
+			     struct scatterlist *src,
+			     unsigned int nbytes,
+			     unsigned int flags)
+{
+	struct zynqmp_aes_op *op = crypto_blkcipher_ctx(desc->tfm);
+	struct zynqmp_aes_dev *dd = zynqmp_aes_find_dev(op);
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	int err, ret, copy_bytes, src_data = 0, dst_data = 0;
+	dma_addr_t dma_addr, dma_addr_buf;
+	struct zynqmp_aes_data *abuf;
+	struct blkcipher_walk walk;
+	unsigned int data_size;
+	size_t dma_size;
+	char *kbuf;
+
+	if (!eemi_ops || !eemi_ops->aes)
+		return -ENOTSUPP;
+
+	if (op->keytype == ZYNQMP_AES_KUP_KEY)
+		dma_size = nbytes + ZYNQMP_AES_KEY_SIZE
+			+ ZYNQMP_AES_IV_SIZE;
+	else
+		dma_size = nbytes + ZYNQMP_AES_IV_SIZE;
+
+	kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	abuf = dma_alloc_coherent(dd->dev, sizeof(struct zynqmp_aes_data),
+				  &dma_addr_buf, GFP_KERNEL);
+	if (!abuf) {
+		dma_free_coherent(dd->dev, dma_size, kbuf, dma_addr);
+		return -ENOMEM;
+	}
+
+	data_size = nbytes;
+	blkcipher_walk_init(&walk, dst, src, data_size);
+	err = blkcipher_walk_virt(desc, &walk);
+	op->iv = walk.iv;
+
+	while ((nbytes = walk.nbytes)) {
+		op->src = walk.src.virt.addr;
+		memcpy(kbuf + src_data, op->src, nbytes);
+		src_data = src_data + nbytes;
+		nbytes &= (ZYNQMP_AES_BLOCKSIZE - 1);
+		err = blkcipher_walk_done(desc, &walk, nbytes);
+	}
+	memcpy(kbuf + data_size, op->iv, ZYNQMP_AES_IV_SIZE);
+	abuf->src = dma_addr;
+	abuf->dst = dma_addr;
+	abuf->iv = abuf->src + data_size;
+	abuf->size = data_size - ZYNQMP_AES_GCM_SIZE;
+	abuf->optype = flags;
+	abuf->keysrc = op->keytype;
+
+	if (op->keytype == ZYNQMP_AES_KUP_KEY) {
+		memcpy(kbuf + data_size + ZYNQMP_AES_IV_SIZE,
+		       op->key, ZYNQMP_AES_KEY_SIZE);
+
+		abuf->key = abuf->src + data_size + ZYNQMP_AES_IV_SIZE;
+	} else {
+		abuf->key = 0;
+	}
+	eemi_ops->aes(dma_addr_buf, &ret);
+
+	if (ret != 0) {
+		switch (ret) {
+		case ZYNQMP_AES_GCM_TAG_MISMATCH_ERR:
+			dev_err(dd->dev, "ERROR: Gcm Tag mismatch\n\r");
+			break;
+		case ZYNQMP_AES_SIZE_ERR:
+			dev_err(dd->dev, "ERROR : Non word aligned data\n\r");
+			break;
+		case ZYNQMP_AES_WRONG_KEY_SRC_ERR:
+			dev_err(dd->dev, "ERROR: Wrong KeySrc, enable secure mode\n\r");
+			break;
+		case ZYNQMP_AES_PUF_NOT_PROGRAMMED:
+			dev_err(dd->dev, "ERROR: PUF is not registered\r\n");
+			break;
+		default:
+			dev_err(dd->dev, "ERROR: Invalid");
+			break;
+		}
+		goto END;
+	}
+	if (flags)
+		copy_bytes = data_size;
+	else
+		copy_bytes = data_size - ZYNQMP_AES_GCM_SIZE;
+
+	blkcipher_walk_init(&walk, dst, src, copy_bytes);
+	err = blkcipher_walk_virt(desc, &walk);
+
+	while ((nbytes = walk.nbytes)) {
+		memcpy(walk.dst.virt.addr, kbuf + dst_data, nbytes);
+		dst_data = dst_data + nbytes;
+		nbytes &= (ZYNQMP_AES_BLOCKSIZE - 1);
+		err = blkcipher_walk_done(desc, &walk, nbytes);
+	}
+END:
+	dma_free_coherent(dd->dev, dma_size, kbuf, dma_addr);
+	dma_free_coherent(dd->dev, sizeof(struct zynqmp_aes_data),
+			  abuf, dma_addr_buf);
+	return err;
+}
+
+static int zynqmp_aes_decrypt(struct blkcipher_desc *desc,
+			      struct scatterlist *dst,
+			      struct scatterlist *src,
+			      unsigned int nbytes)
+{
+	return zynqmp_aes_xcrypt(desc, dst, src, nbytes, ZYNQMP_AES_DECRYPT);
+}
+
+static int zynqmp_aes_encrypt(struct blkcipher_desc *desc,
+			      struct scatterlist *dst,
+			      struct scatterlist *src,
+			      unsigned int nbytes)
+{
+	return zynqmp_aes_xcrypt(desc, dst, src, nbytes, ZYNQMP_AES_ENCRYPT);
+}
+
+static struct crypto_alg zynqmp_alg = {
+	.cra_name		=	"xilinx-zynqmp-aes",
+	.cra_driver_name	=	"zynqmp-aes",
+	.cra_priority		=	400,
+	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER |
+					CRYPTO_ALG_KERN_DRIVER_ONLY,
+	.cra_blocksize		=	ZYNQMP_AES_BLOCKSIZE,
+	.cra_ctxsize		=	sizeof(struct zynqmp_aes_op),
+	.cra_alignmask		=	15,
+	.cra_type		=	&crypto_blkcipher_type,
+	.cra_module		=	THIS_MODULE,
+	.cra_u			=	{
+	.blkcipher	=	{
+			.min_keysize	=	0,
+			.max_keysize	=	ZYNQMP_AES_KEY_SIZE,
+			.setkey		=	zynqmp_setkey_blk,
+			.setkeytype	=	zynqmp_setkeytype,
+			.encrypt	=	zynqmp_aes_encrypt,
+			.decrypt	=	zynqmp_aes_decrypt,
+			.ivsize		=	ZYNQMP_AES_IV_SIZE,
+		}
+	}
+};
+
+static const struct of_device_id zynqmp_aes_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-aes" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, zynqmp_aes_dt_ids);
+
+static int zynqmp_aes_probe(struct platform_device *pdev)
+{
+	struct zynqmp_aes_dev *aes_dd;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	aes_dd = devm_kzalloc(dev, sizeof(*aes_dd), GFP_KERNEL);
+	if (!aes_dd)
+		return -ENOMEM;
+
+	aes_dd->dev = dev;
+	platform_set_drvdata(pdev, aes_dd);
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(44));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration");
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&aes_dd->list);
+	crypto_init_queue(&aes_dd->queue, ZYNQMP_AES_QUEUE_LENGTH);
+	list_add_tail(&aes_dd->list, &zynqmp_aes.dev_list);
+
+	ret = crypto_register_alg(&zynqmp_alg);
+	if (ret)
+		goto err_algs;
+
+	dev_info(dev, "AES Successfully Registered\n\r");
+	return 0;
+
+err_algs:
+	list_del(&aes_dd->list);
+	dev_err(dev, "initialization failed.\n");
+
+	return ret;
+}
+
+static int zynqmp_aes_remove(struct platform_device *pdev)
+{
+	struct zynqmp_aes_dev *aes_dd;
+
+	aes_dd = platform_get_drvdata(pdev);
+	if (!aes_dd)
+		return -ENODEV;
+	list_del(&aes_dd->list);
+	crypto_unregister_alg(&zynqmp_alg);
+	return 0;
+}
+
+static struct platform_driver xilinx_aes_driver = {
+	.probe = zynqmp_aes_probe,
+	.remove = zynqmp_aes_remove,
+	.driver = {
+		.name = "zynqmp_aes",
+		.of_match_table = of_match_ptr(zynqmp_aes_dt_ids),
+	},
+};
+
+module_platform_driver(xilinx_aes_driver);
+
+MODULE_DESCRIPTION("Xilinx ZynqMP AES hw acceleration support.");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_AUTHOR("Kalyani Akula <kalyani.akula@xilinx.com>");
-- 
1.9.5

