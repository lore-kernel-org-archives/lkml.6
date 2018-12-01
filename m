Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45FC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E7F20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MxJU7Qev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E7F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeLAW0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:18 -0500
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:43268
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbeLAW0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+NAHDBLXK0FSRCiZpNIgw+xddPQL9tBl5zBnkSWvjQ=;
 b=MxJU7Qevkt+yjC7ZwTYwhuOiUUB1RzMcSL23MgYWWgKktCsxCIkyy9BSVssmsbszOAFjfRWWixHw/NAJJmRf6IUbbcI64rtI1w1L071xiJ3CcXB7oJj8atgKK5oo/NfDRmngCeKZWH+2YalDVjT6Zm14YElC4RsTStM2T6J4+88=
Received: from BN7PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:20::49)
 by DM6PR02MB4460.namprd02.prod.outlook.com (2603:10b6:5:29::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Sat, 1 Dec
 2018 11:13:51 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN7PR02CA0036.outlook.office365.com
 (2603:10b6:408:20::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46471 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DT-0005oF-Vn; Sat, 01 Dec 2018 03:13:43 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DO-0001kp-SK; Sat, 01 Dec 2018 03:13:38 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDYCn015257;
        Sat, 1 Dec 2018 03:13:34 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DK-0001jo-7g; Sat, 01 Dec 2018 03:13:34 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 67D246050B; Sat,  1 Dec 2018 16:43:33 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 04/10] usb: dwc3: update stream id in depcmd
Date:   Sat, 1 Dec 2018 16:43:25 +0530
Message-ID: <1543662811-5194-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(189003)(199004)(186003)(16586007)(39060400002)(48376002)(6266002)(2171002)(50466002)(36386004)(36756003)(107886003)(52956003)(47776003)(2906002)(63266004)(478600001)(106466001)(103686004)(426003)(446003)(476003)(90966002)(106002)(110136005)(486006)(2616005)(14444005)(126002)(51416003)(305945005)(11346002)(54906003)(336012)(4326008)(8936002)(81156014)(26005)(15650500001)(81166006)(5660300001)(6666004)(76176011)(356004)(8676002)(7416002)(316002)(50226002)(42186006)(921003)(107986001)(2101003)(83996005)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4460;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT060;1:C0rT9JOl4kyQjRYkfW2ex3iiLSn0fZl7ZtsKveR6oS9dZJk2Sfa3tG5mUUUi9GLj6BW8ipxvr/DfRKd0N3SQwIzwGGXW+JaEAWQJITKyj5o0WrZYHylzQky0RQALdyxg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38be51fd-6654-4a64-4ac8-08d6577e0f5a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;3:YuyVEnoKF2r1jMcl/Cxg76Zc/JlIkruYF1WzGs2O8mRNjyFkAJH8xK1t/M4aivVH1vn+eiIkBG7BmJe7H/dkc7PNwfN3pqy1se/W8/pX3HF2JsneDd8TQKa9HEVIrL5LcjWMI3knlO//uuoMPutza1g6a41eDZDMjXf98q4ebfPAWmUfz0cMsYGZbFK7anOM/3SzE8qTQu/0fPPw4hkQfZLf61CBuZoGetzJqQX5p6H7t3Iqmr1+oiV5hCcxqVka3ZKEX2azP7uSJD7fcdz2sJUSzj7nTYJwewq4PnXBAW15IWAxqvhCBFGb22YRk/2HhZ11ecJio3k3Z4AC8k2XOnkCUHFONJUr07fU73ne/us=;25:3WKA3GwVr9fr/p1VmHwyVKjpFPJ/X1SXods6khcSTxI2fskYQq4XJFVtNgGeDdTF3pnoJg9QDsJaSCq4xIXp1dDEV7QDkX3V/EtQcAMfLtvIKFE1YXuOV39+CEXaOx563+LRwxZwTzzy0s3AK5/29gkAK+CrlF9kuPjmzNYHlECxybygP9SZy2jXQB7vV6/LQOgVi+SQ9VHAwK8zkrr6i6EoTydgLF4+6GnTFQBAA4n7z/BWwzgNfC/6zSw0tgQyrzPuv92SpDNMGyfijI0WuX6G7FlnN8i9EjCeXAg8GlNP+sVXWWYC7vYJXH5tEQfEOyHsIznyvOR+VpjKNFb8dw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4460:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;31:6yuXbSoBgAzNn+pLSP2bPVueSh/BNbC5mGkn/D3zQBJpDSII/8GALuhdsD0Q2mkwmS0bIkCSNW4c406+QrpywSXYHzM2sNl6Pox/GLc1UeLFOIga/ML61fctapFyEbYTNAWVD5Y5gdlvPiIJzxjVPtyoZbEtwUx0hy16RfsHDBfPZwF28gu7PO3EswSnb1GKSIFVf36di3BMtOpZjd/6ooMXhAHwMcvhrIgpYOURXKw=;20:eSLYV/yWPVOtCwtjS9drmHiF03AQ4/obhHFCjZHbNC2a+9P6mXjxeaa46PjsOrkjrl+ebe+N2gfBKboMPiZMdOT8Y+1jhKQIJmfRfOmU+U361QsAYUsdt0ZMMCtrgzsAAW4bZIKmSN5oDvCsCaPCxmRjwX3ew/+py43eQvWqyr1OZcqFaRerQ4FwFL4xO5ma5VxzDhdKsy89ijx5r639EaZGrt0InBE72pXD8v2x1z3JCGyG/MYTYjoCVMPj7ALsG3ZfH8V/x7aQeIw+b90CBPbMJwV8cJmgkd3EMXxeNq/17PD776D9xXQhbL1c3wqkLhZ/WSRnqodZlkQPoMHbDFoe0I5MCIuEyhaZHVvglWjgVRDeNujZaK5VM3ugS6FhH41jCdaItvKWokZQeTaMYzK85C70PmkXuP2RGXRfw0CZn8g9rditU4696PPc+cTDZewY3u0rk+AV0wmFpcwqTjVGDSzjo6oF3tUv4ux88+1m1nAjkoeLhACDhs609SKT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4460E0B89450FB549869191EA7AC0@DM6PR02MB4460.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231454)(999002)(944501475)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4460;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;4:nuzFPJDu2L3Kq18P3jYCitmGSbjjf4A1VFO0huyp/rqMwv+jRfZJ9TUFLcDIEIp3hqfqcVYRJiWDT/mjnGQdUTzBOZeiFwyZoVSgf9zChG9He+TyHx0xLF1RIe0NRSlFfMGsZ6iejegSjfssEUThLYAU7VvjgAfZowPyl4CRCAumHRcEv3sAIwwmrouJX2FHxfHHd4Rk8CPkpjbgc46LT2co1EW/R66qydUV8BkJJcoRF+WjHcbNnapbfMly/Z+BxojAGqEC4l0JOQS0cE7HhA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4460;23:U60V6l4ZlQqCIuDfJhdPTiWcYVrWz+UGBp1Tq3+Aq?=
 =?us-ascii?Q?a4H57idzTGnrsmJUkKWG18YdytgrbmQFuNOSeg+DEH7h/fcP1Xm05hORipwN?=
 =?us-ascii?Q?lNI7FDd1N1JSO/nfDR9lIKsBm/col/WhFX/ronwMMZTM5tdwQATOyOTsZWIq?=
 =?us-ascii?Q?y2zC5haiyjbJctH7ot2JSdn/w0TCd67/qzlAGhld/DTnh3pDn05u9632uYm/?=
 =?us-ascii?Q?mqamiCAOXcaYGMTFLFCHbEp/AWsuRZR7fE9uW/bNOX1DoTTXcuVZKG0ZUxx4?=
 =?us-ascii?Q?x8NHpw7UAHeL+PaJG/1x4RDiZfVz4z/bgfiNSbIWibqpe1/iR4cYUegjwj7U?=
 =?us-ascii?Q?vNFyUZBHXAmior5SWnA/Eveft1hfyyDcOvj/ZJdJz08C02rqfvxxphzBq6W0?=
 =?us-ascii?Q?jd5szw4UduVj8kT9d6O2NA613jBzQn8QriHetF9m5pXWEtgqOCYiBU5mKMPe?=
 =?us-ascii?Q?TTdvd9GAXqkIOG/jPxgX7W8DeKWx5+0d4nKerscupC1CJBj0haFjJKCu4Wjc?=
 =?us-ascii?Q?N8xZA+0+FUGBR3RMaXXHjw1J2DtYOjG7/rxpAyvio547CB1XVJJb6ijP9ve1?=
 =?us-ascii?Q?fsRCw2PPvUJjlAQIAc5cdQrQaob08BNvDIVgbFYcPpn2SsMIosxYc02oQGYt?=
 =?us-ascii?Q?JUQl/5w6y4wXChYKN2s57+1W+w3Wr8GVfszXSgWG62gBorluFuoMtuK6NHX0?=
 =?us-ascii?Q?kqC3XubmKgrBoqebDVOwrRKJysw9VZeAmEetc4JQ19ki6e1FQfQfMjJuedgL?=
 =?us-ascii?Q?EufFSTkB1HteaUQjuaXHSbuocybo2NcAVf7MHAihmP/qtyt6tykgRD05g9oR?=
 =?us-ascii?Q?TsNE9uxaS1bkPh+W1BoWjZkAgD2HBBx7A89SlgsBK/t2rx4L5c4Tj0V1EkuG?=
 =?us-ascii?Q?en3buivlpQYpVVcTAyiulHVTPgYUTSv7aG9h/SB2YJ3bXZahfSGgy2Nwiawy?=
 =?us-ascii?Q?7iunYfW2r7Tgvbb8UAJH2tYeyo9ljUf5kamhv4wrrDghUPkBOGMQKTeInpeh?=
 =?us-ascii?Q?WaxtrCr4ygl99aD17LqxdmKMNZj9mmGK4W4rM4eK5/8a3MlXIWTRjORWYANF?=
 =?us-ascii?Q?1nL78kntyb10dhPS0ZurgySQmPzM8xvep9xrhjvFz5e1c9RJZlbza8ALOdDH?=
 =?us-ascii?Q?iz+um1kfgU0is/tjVSFM4g5l1bUf1yuDWycDTRwAAir0X+dfCr3aDzhjq6Lj?=
 =?us-ascii?Q?M5YdgLfZwI+YyyMG+8eRDoduig7f6rpqgubU//CQZF04Wg4GlunD4uXRcxoX?=
 =?us-ascii?Q?I/QdlETZdKSu7ka/+WREF9wG+XZK25qGMRbzTtLdmakSzY5fMn6k+64HWw56?=
 =?us-ascii?Q?QfyNG9ckAX+REMe+4Ae3ngG3O70VTaXYrq2HFTMILEmPgl/tlKG/IwkId2vl?=
 =?us-ascii?Q?pRhA2YBLYRP/9CjX2kbHjg3LC0=3D?=
X-Microsoft-Antispam-Message-Info: 2njG+0NypZ30iyMFdBgwmAYjahGqdqC9OF7y0mdmTip9wN6c9J/hZ/T9Bv27do4Pc73qxPraV2WRZVIY9cyPYh5JUUbCAXWh5fRdwWirquLFEbUaHkgE+/vvsWq+INKcAtCHfmor3p+0CIg2l5xxkJDOW2KghGIaDTJNnlNJxuEZ10hP68BxV5z9kK2ka/sUXWlC9+IxqENlv2miLo4pu0Egj6R727nYe93QzEFSU0iZ/xHU9dNi6N+Kv6vI8fOgdiAO+uMDgHh0ec/Stgziesoj8OgDAITAZ1z1ZIrfTp21T9Zwhmff9xRlq+q2Q1V605kT+y++xfPlXTbfcSpbTznd50zeLWyaSRRgfH6baI8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;6:CzoGMI+GNwUxCa4swc0ag60s8gH+PokxXhU78P540keQjvFKNqe135AiA5UFU4uwt9TvEDX8FgS+X+lOibmWsQ+db5H1jZboH9KmboSqlNceh/ZuFRDXTjgJ9asEhDT4IGWZxyrjssIzASGaJEzeHQ1SC7RM8xMrCdUPg8OlDNRxgXxOBt2nFKXxhZrraiBAGS8p1wbak4t3zubCgvaE8LBk1QV8Jlx/dfRFSfR46mOAtbNvHrrPu+qiWwdJPy86/MRWPmjYsOdW0a38Sfxfu5ZXZnaeTY7NDNiD+RXtqVIESsddsuG0XhlZDhVr5KF/JQ4gUDdPizgnYMPsRwa7/rlh49oTUWNwH5Qy5smg6iDbihFWLyDBPa130ac8nmC5rdjftVB4vT/jWiqYcobKusrpmmn30eRymf3Esqo//zZIfJeTzv+eZGuhp4BMMiGVDDNgvkyxAt42n/cE8jJOXw==;5:MikV4VWVs8uwCV3eHEFHldHaW+6dPgW/ye6wrK7tBwiEyfSOYvsnelJbQPK01e103fOM3rD4mkR6wkm23S9x8JZdUPUzg+0RpZ6f3rnCetS7ClUlYYSFGmWTwAonqwZncH2qR434E2uN89ILhjk7L51X/0tEv/bspmf1JMEmU4U=;7:qhB4QMQ/jGWxJdx8KKAoUD6WI/xWl+1IuqKkmaHhI3YMwHKhxdJWfifZpBDv6pi7OwlfwRIDsdEAie7gyfY3CgIsig6Mqm8t/xNZ95Y5C8Wc5s6v+1R0conLB2u85ta26nEeIclabnZSTXYJbdDI2w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:44.4418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38be51fd-6654-4a64-4ac8-08d6577e0f5a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, stream id related information
needs to be updated into DEPCMD while issuing START TRANSFER.
This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v7:
	1. Reverted to dep->stream_capable from dep->endpoint.stream_capable

 Changes in v6:
	1. Used dep->endpoint.stream_capable instead of dep->stream_capable
	   flag

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 319a3ed..3171c24 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1232,6 +1232,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		params.param1 = lower_32_bits(req->trb_dma);
 		cmd = DWC3_DEPCMD_STARTTRANSFER;
 
+		if (dep->stream_capable)
+			cmd |= DWC3_DEPCMD_PARAM(req->request.stream_id);
+
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
-- 
2.1.1

