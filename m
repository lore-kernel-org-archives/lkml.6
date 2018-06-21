Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D08C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022A620883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xR6IVIuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022A620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFUGnT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:43:19 -0400
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:43648
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932805AbeFUGnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixl11wQCFXGL9DSGysMHism1Vw0d0FOJnaYsYln1Q8Y=;
 b=xR6IVIuy/P9xo2KZ4CIL6UW0QiabkivhqUnZkkVP+t3vn99iVSKTwXBCEGOtrv9MBeLqaaFOLLT1JAbI1Lf/ayqlq1kVhMnWOrVlPUt2JV5lKNWEeEQpkHw2buEoffe3cdcQEV5xVlE4knaa+f5EyqO+LchM6r4EKpbYbheF4aA=
Received: from SN4PR0201CA0066.namprd02.prod.outlook.com
 (2603:10b6:803:20::28) by SN1PR02MB2160.namprd02.prod.outlook.com
 (2a01:111:e400:7a48::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Thu, 21 Jun
 2018 06:43:08 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN4PR0201CA0066.outlook.office365.com
 (2603:10b6:803:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.17 via Frontend
 Transport; Thu, 21 Jun 2018 06:43:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Thu, 21 Jun 2018 06:43:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtJD-0006ng-BO; Wed, 20 Jun 2018 23:43:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtJ8-00060U-7h; Wed, 20 Jun 2018 23:43:02 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fVtIz-0005oY-0p; Wed, 20 Jun 2018 23:42:53 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [[LINUX PATCH v10] 3/4] Documentation: nand: pl353: Add documentation for controller and driver
Date:   Thu, 21 Jun 2018 12:12:30 +0530
Message-ID: <1529563351-2241-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39860400002)(2980300002)(438002)(199004)(189003)(9786002)(4326008)(476003)(11346002)(39060400002)(2201001)(356003)(316002)(446003)(305945005)(110136005)(2616005)(106002)(107886003)(336012)(2906002)(8676002)(16586007)(5660300001)(426003)(486006)(54906003)(48376002)(126002)(63266004)(47776003)(50466002)(6666003)(186003)(6306002)(81166006)(26005)(106466001)(36756003)(7416002)(59450400001)(50226002)(478600001)(76176011)(7696005)(51416003)(81156014)(36386004)(77096007)(8936002)(921003)(107986001)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2160;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT007;1:IgeiTx9cTHwR+stFekvuJl4wBRK2qiK73vvX27i8btQIRgG0LoK73/DnFqwS7M7+RcPaCGR8Xj2Z3L3OzroZdCFLR7MFvxmoeIZk2VXVGpew/WgUo31adnM4tt6mUenm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 552f377b-8324-4138-7541-08d5d7423fdd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:SN1PR02MB2160;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2160;3:RvzyrojskgFUCO5+Z+P5P5dAexm517oUtgpSxJ7iRwIyl8UjZPa2jHep1laBFAmMlVnhoPuHKHQC3BjIcj9B9Nm4ooN4h+AcplnoIYiM6LEL33b0FkbtsAx8oO2O3hccrd1kZn0r1uEli4slFNJ4QApxrZj6RA/MYbOPCge4V5VG21MJqTxvTYUyL95uCwBy+2pErGOhqQuGSIrZ4A0EothBnMOIbUEYpAITOBmWBYwYGMjUNGaHJT7aBKmASYIeLp7huNFrZrU6AdzU367ozZ341AjL9NGEZRbgABQ3KxaHxQEgvUjfWs5JiCVnfvWd0SdhWuMz5BxIycw6Pg/hG0ndSSoAdKK1nUqpsuS8ukE=;25:7vT69vzGpwKoZip/L8YRxRAUOg9sw3wxtEUEf19J4fhYKUFHc3vFY6JT5YzW9+uy1LszZqQBnaUzRxJM5GFsKwxwLNJjf4Mn1SAabyrdsRYKIXIm63vHDBmEukUJMh331/6rm+ifa+8k+Nx7+xh3d802ImIkHOPqbwJ0p2S7C/E9RLJlZy2jZ3hFKpcT/8jET6XOczzUQ/IZpngzs0WOG4zV2NXmXZkCh+tW+EqEozMMGTOqvPqAbu/oq0QetG/9HgpObtRXeO4q/x3g283yHQbMWckhD7Qv89EkuIJ5hgGk1iIVEHTu2V60Tu6tgmwnG9L7qyN3Sesm6FYslqm/Kw==
X-MS-TrafficTypeDiagnostic: SN1PR02MB2160:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2160;31:kB+FFzLJTHO5Qec7JOitettnDyIc5k/DwsBGU32YTIPZa7b8NcIRPvGp75u8b/bd7Nvvq3hb7zVpJYg1KKmTl5aaILEsrBM3Caf1/HJYm7r8Goaf5x1g9zPN15iSMhcyIG7AQkuQVzhQexEil4Vj7ZD5LaHSsPFzZshuUOqiP2w/7CmnatuyaRxfWYv9INq5r0jxQg+TuHkzO6+p1UofNK8m9uT0Yda2GKJ1PWty3e4=;20:Pvz7+w/3yC5Y6CTzYV1foddEOgCVtOfCt6QrcgMCytrxTzVNPK5TUM8ifaQjm10vSa5aFcRITt+VOFk6xo0jdeijVIfEQ1NFU3tih5j65TkeefU9huPzEtLvudjPMXlbPqVRR64PY39ScgWejIBRsKXTsv0CLfbhiwM1jVEJvm4RuPYr0sNNhaJdcQObIJ2usn4rORTUT3RvlH9lK9L09u9xguTnM8IHz7Ux7Surr4/NXUJrJUmRNGMFBxVTNv56Ak79PGOJRzh5m+QKX61OHIlPvDYZraikV4gCh++PVBH3xarpsNIl2WEK/oB4OCB7k7B9q6fj9tBGWz4tSYAmrFEqv1qfMJpteLcl4KiklZ8DufnVfBgz9urYEuKw9RnziF/964ouN8GI57rNgPSZ0CxH3gUfdJLFXk7+bK/fRBhNWTIjyBRdlE3shFwKiRyCEWP9Gkq22FylbUYAIrEPTO3Bj+pu87Z5eXVtm8y5Vi+nb6+Y3j7gPyBfH+tL0iL6
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB2160927BDA5F4D43ACFD28B6AF760@SN1PR02MB2160.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB2160;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB2160;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2160;4:Q7pdyC83CQZhj/YJxRMpgEJbrGzS9xgpRJ+ZjFO7VGli3DFF84s4LtEXd3l+LXFChwF56GXLjfZ6Gu08hMIh7EsIAUHzsBu9+MY1fCLoX1JCuCClb2cZu1Bt16v8XvF3K4SFVnfJbSCp+kCOTbte7B7ESiUk2b/rr4BVZQ7fW95fbjKUopBUwa2jWuk/tT+0M7xgtvcbVGnYFkSh9eGRiFvaed1d70wf0W/u6txsSNNZXjfwAMUD6jwwLRqKMx3hZgyxI2v53D4AqmS5zoGfrkKQ7Cicz4uHI1SUyySAhnahByWmlc5wh1pOkrr9YBln6PlvdG5daLWPQUGbkXKjG6yd6TL8/q86rk3eOI6bCFI=
X-Forefront-PRVS: 07106EF9B9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB2160;23:42WCz0As6RG1Q9DbwgoajaSv7/TgcjnM0FkVWXym7?=
 =?us-ascii?Q?XDsmlxcOWUS5X2AYhpTwqKpcDHAL/ansGFv92fSwEdhduublZPyiLTKiATuc?=
 =?us-ascii?Q?dnT5Y7MXCyesEDFMLPmEctTnaCTwQF/zwhSpyTFF5jMbKHWdGB9w9QMFR3Xf?=
 =?us-ascii?Q?d6UHWSvmD7yP2Fs8S7K+qGwzTxb4y/2wVpP7g0MeWvSK/3mkGUFX0cYN0Euf?=
 =?us-ascii?Q?zxyNafOvpxuDfGaGvR5yNIs6RWSUFu4ySBFrh3CPPfMGlZPusVLvkKcynZmQ?=
 =?us-ascii?Q?LsZB5uHMnTJgoye6MSssw4dKtPVtlBmQkSB015JyVuQi1Ti2tymeAOwmLOpc?=
 =?us-ascii?Q?p2JL4x73EjlyrOGbr1bLnmavcFLAjHB7xUxPGyuOX53NMdSDWdm4q1tkdL4I?=
 =?us-ascii?Q?EjhN5h5mFRtCwZzEPc5X1Z9T6xHpHGU5wHAzRNjoxPTfizaIM7B7b1Wo5sGO?=
 =?us-ascii?Q?KxXZmbh5knE5cgooEpfbYUV6PTgJKH4K+XQCaPgjKUL8CuocNnWScG1M6LcL?=
 =?us-ascii?Q?jwxPOIjdg6M9l9vGI6yW9gWWl0sAdSdeRGz5auTLRJwBTgD3NloGLq43GVum?=
 =?us-ascii?Q?IqqLFPz7j+o/a6I1Jxqmya4uMXPjvETqtYvHM7cjaAoLsznxpuPfYfE8HZeE?=
 =?us-ascii?Q?OPGJAfMnKOO90QZsQGyBVSoR5eg97n7WO8lGtrbkqyUgkfwTHEEhbRBjbTq9?=
 =?us-ascii?Q?7iMGO6AzIviMRoDqpVbF5L5b3/SHS6DdagrgE34X/XTmXbr2YnuJQIlpnKEV?=
 =?us-ascii?Q?a2NXrUUWCnfsxvFUtduLKkIIcvxWtIKrT40gPdrn+40AUaOeZAUlsdw3NHjw?=
 =?us-ascii?Q?w6/PAXMeM1Wid4xw3lhOdo1F/H3KQo9EqWZWDG4xLoDQMPPuEsEmy1Z7t6/z?=
 =?us-ascii?Q?rCUNKS8P5J+aY3E/phjkQdsQ1fQRuWTA33+DlabNzTsDUk8pSyCnPyfDGm8M?=
 =?us-ascii?Q?qiJhHFlkyy9wgkJqwJakbzpuxdXhGpW9udBEf+8PWR719Wgdry8HvCaEeieY?=
 =?us-ascii?Q?QPhuyXP+Y6Ks9TQS3LP6LGcEE7FSakL7fZRcWitsl/dFfXI/7j5RQVokz5Yc?=
 =?us-ascii?Q?mfXNV7ZTVey7eXZgOKF5rcgNOR2WL8Xfvn7nJlBvApANR1dmX4UF6aatDA3m?=
 =?us-ascii?Q?00ZOFHM9UZG+OZd7GwGEVGJKWow5uLcr1q5aFOCfxYzaN2R4Fmxu9hDoPEOZ?=
 =?us-ascii?Q?Nzo3pj/b88LRn+AAgXayNuqtSH11/McT6cQ302tbJ83lAfGBykl5QC+eBYQB?=
 =?us-ascii?Q?uflU3IyTS030gEjhX8vo9eA5ZKlNCSk7LRO4ar4DuQQ5q5EGkbE+G8aEJVgV?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: dwdbHs/4Z3SpsrTlsaYt02qyNTLsfHk+3aZwniduL2jD2vOiXQbrVKgLArDP1wDkDsBcPkAm49713xoDS6eGECr2PS7fDsecwHbF/iLKwh1epzHvuDxQB9Pn0FILHEmcoeHKsbBaqPReh6ND+NHdKJYT4G0I7wEsNxGOBCPYoaQ1GeLdFgP3FiWuE33NrUeZTFrXqsNMaGLJth78mHRdcYj9xB9Ia6N8ZhIjHGoyqrGL5IpTCntTyN8tQpeK3KzOE4fzawI0qk6jX2ZvHk8G3p0/lgLG46nSaOBZGwQ3x2Q2SXdhcvTfI4P8YZMrI8k5
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2160;6:DEyf4OiUDpo6pSeIZ1dWnYFJHv7XPLXZ1t4Cnk6O4W+pC+2OWuhfXbDQWWdEVDanycF7iiBek5wjsftqidQZJcUUmQU+EwWVhWYak3c8N5+zHtIb2Lsci8q2TQsKqXhtC2WclSKHNaFEbUxh0fATVN5t11tzUTDqsbkDt7kyi2vF4csFLS5wg7pnh5sbZ392Okth4ama9PEwGYi8cddkMT/MbHsbqkeTD+W9Q0angOrELvwfsEZc8qgD6cDGkSQC+3f+yNZ1kL7LYizACEQcnljjVIHtN0yyfV8Flv10VmHs0w1zfK3tcfsL+y3RbD4esttCal2OJWd07IXZyecT6otr0K0KvIvFfjF1MqH1vEKkX3meBM/ekNfNbnsTdngNVoRKAMlmSeTX1AUl4uNaFyNyohl51DaciRKL1aqd1FJwOs2ulm6r9XV6bR/FcDMuQbICS8sJOeBSxMV6pcbcrw==;5:ShRvZdlO8CKBH9DEy9poe3qh1VEFYfZf9bxS+ZL45gTxdJWCaTBUwg9FCLJjdIsEisOX1cffedVS0pmpUKfZnGXdIMrJJbtk7+7aFVfNKMXZ4EsX19dNU0V+DnFy2DDWT6hQCw1+v76uK9JkzjCJ9ON2+uN2FNJpPnbzZZlkBdI=;24:4/8h3i+pNwzR+ZnCRSPqWMomU3Pvh3abnHKG4Ig+/nov968VGyJL0GnGJVpW0yB7dAhXJLb3Krfnv/LBgl7JVMIXT1PT1MJBD7qGSNSF0w4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2160;7:o5ihmT1f/g9rUnrCU8864uS5tV2dVbJ2Qz5WNsgjX87HxlndI2WRy6NEyKFCREFMW8iYwUWg2xX80I2qpNce5GswfjKUyrhjA/QfdMlVsT+S7Wpy9oHJFWo3o6rEiBzUBCqTc1en1P7SZbN3tkVjcJGjOgQ7HeRynQahur9JSjayAOm67Z+SmOqmXUubesVCGpK48wcJhMGAkvw8LGl4GqhRh5imKfjqD9mXsG2/U7PH63r3OrmDYdlRDPP1/l8L
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:43:07.9584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552f377b-8324-4138-7541-08d5d7423fdd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added notes about the controller and driver.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v10:
 - None
Changes in v9:
 - Addressed the comments given by Miquel and Randy
Changes in v8
 - None
Changes in v7:
- None
Changes in v6:
- None
Changes in v5:
- Fixed the review comments
Changes in v4:
- None
---
 Documentation/mtd/nand/pl353-nand.txt | 99 +++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/mtd/nand/pl353-nand.txt

diff --git a/Documentation/mtd/nand/pl353-nand.txt b/Documentation/mtd/nand/pl353-nand.txt
new file mode 100644
index 0000000..c352c87
--- /dev/null
+++ b/Documentation/mtd/nand/pl353-nand.txt
@@ -0,0 +1,99 @@
+This document provides some notes about the ARM pl353 SMC controller used in
+Zynq SOC and confined to NAND specific details.
+
+Overview of the controller
+==========================
+	The SMC (PL353) supports two memory interfaces:
+	Interface 0 type SRAM.
+	Interface 1 type NAND.
+	This configuration supports the following configurable options:
+	   . 32-bit or 64-bit AXI data width
+	   . 8-bit, 16-bit, or 32-bit memory data width for interface 0
+	   . 8-bit, or 16-bit memory data width for interface 1
+	   . 1-4 chip selects on each interface
+	   . SLC ECC block for interface 1
+
+For more information, refer the below link for TRM
+http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf
+
+NAND memory accesses
+====================
+	. Two phase NAND accesses
+	. NAND command phase transfers
+	. NAND data phase transfers
+
+Two phase NAND accesses
+	The SMC defines two phases of commands when transferring data to or from
+NAND flash.
+
+Command phase
+	Commands and optional address information are written to the NAND flash.
+The command and address can be associated with either a data phase operation to
+write to or read from the array, or a status/ID register transfer.
+
+Data phase
+ Data is either written to or read from the NAND flash. This data can be either
+data transferred to or from the array, or status/ID register information.
+
+NAND AXI address setup
+       AXI address      Command phase      Data phase
+	[31:24]         Chip address       Chip address
+	[23]            NoOfAddCycles_2    Reserved
+	[22]            NoOfAddCycles_1    Reserved
+	[21]            NoOfAddCycles_0    ClearCS
+	[20]            End command valid  End command valid
+	[19]            0                  1
+	[18:11]         End command        End command
+	[10:3]          Start command      [10] ECC Last
+					   [9:3] Reserved
+	[2:0]           Reserved           Reserved
+
+ECC
+===
+    It operates on a number of 512 byte blocks of NAND memory and can be
+programmed to store the ECC codes after the data in memory. For writes,
+the ECC is written to the spare area of the page. For reads, the result of
+a block ECC check are made available to the device driver.
+
+------------------------------------------------------------------------
+|               n * 512 blocks                  | extra  | ecc    |     |
+|                                               | block  | codes  |     |
+------------------------------------------------------------------------
+
+The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
+detection. It starts when a valid read or write command with a 512 byte aligned
+address is detected on the memory interface.
+
+Driver details
+==============
+	The NAND driver has dependency with the pl353_smc memory controller
+driver for initializing the NAND timing parameters, bus width, ECC modes,
+control and status information.
+
+Since the controller expects that the chip select bit would be cleared for the
+last data transfer i.e last 4 data bytes, the existing nand page
+read/write routines for soft ECC and ECC none modes will not work. So, in order
+to make this driver work, it always updates the ECC mode as HW ECC and
+implements the page read/write functions for supporting the SW ECC.
+i.e. There is a limitation in SMC controller, that we must set ECC LAST on
+last data phase access, to tell ECC block not to expect any data further.
+Ex:  When number of ECC STEPS are 4, then till 3 we will write to flash
+using SMC with HW ECC enabled. And for the last ECC STEP, we will subtract
+4bytes from page size, and will initiate a transfer. And the remaining 4 as
+one more transfer with ECC_LAST bit set in NAND data phase register to notify
+ECC block not to expect any more data. The last block should be align with end
+of 512 byte block. Because of this limitation, we are not using core routines.
+
+HW ECC mode:
+	Up to 2K page size is supported and beyond that it returns
+-ENOTSUPPORT error. If the flash has on-die ECC controller then the
+priority is given to the on-die ECC controller. Also the current
+implementation has support for up to 64 bytes of OOB data.
+
+SW ECC mode:
+	It supports all the page sizes. But since, Zynq SOC bootrom uses
+HW ECC for the devices that have page <= 2K. so, When the kernel is not
+aware of the ECC mode, it uses HW ECC by default.
+
+For devicetree binding information please refer to the below dt binding file
+Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.
-- 
2.7.4

