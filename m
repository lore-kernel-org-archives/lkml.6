Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62939C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F078620664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tLyBakSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F078620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeKZSBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:01:47 -0500
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:51775
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeKZSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwnDi3f+XU9OqJ11pVvLvJ/u3+w+zmv7DpWzEs4v03g=;
 b=tLyBakSfHM/k981Mr2t2ZbaxZCE+94r5IupQBR8gfGDLWkltTfnK8evM89OooOdMhuOmCgaXLHvpXm0JiQxsCf7asJZ1UJn5TmQK7g/B4kBYQjCfsPd9xlNt99IldZahrPlPaErmc+lYs5ePIUkPgrHYKbp4H17xaHXwsE/C0gk=
Received: from SN6PR02CA0001.namprd02.prod.outlook.com (2603:10b6:805:a2::14)
 by BYAPR02MB4453.namprd02.prod.outlook.com (2603:10b6:a03:57::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.18; Mon, 26 Nov
 2018 07:08:25 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN6PR02CA0001.outlook.office365.com
 (2603:10b6:805:a2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1361.14 via Frontend
 Transport; Mon, 26 Nov 2018 07:08:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Mon, 26 Nov 2018 07:08:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46781 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB0K-0002jl-CD; Sun, 25 Nov 2018 23:08:24 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB0F-0007Iz-9r; Sun, 25 Nov 2018 23:08:19 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAQ78CvO028141;
        Sun, 25 Nov 2018 23:08:12 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB08-000758-7e; Sun, 25 Nov 2018 23:08:12 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>
Subject: [PATCH v2 4/4] net: macb: Add support for suspend/resume with full power down
Date:   Mon, 26 Nov 2018 12:37:52 +0530
Message-ID: <1543216072-9623-5-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(36386004)(76176011)(316002)(107886003)(110136005)(54906003)(106466001)(486006)(16586007)(36756003)(126002)(47776003)(106002)(15650500001)(39060400002)(81156014)(8676002)(7696005)(81166006)(305945005)(50226002)(51416003)(8936002)(9786002)(48376002)(14444005)(5024004)(50466002)(5660300001)(11346002)(446003)(77096007)(2906002)(2201001)(26005)(2616005)(186003)(6666004)(356004)(336012)(4326008)(426003)(63266004)(476003)(478600001)(44832011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4453;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT026;1:SMJxqBFitgMcd85epAw0HXkIZzLO2dgJ7yjjTt6eRILjrbhWE14QNvUnAqIUdSvHOmVgSstLqdsFB4cJgcrYcTIYiN5vh7zpAL0T4OnXlwCkHICFmZKClQeF6BSwtJJe
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1118fb0-8930-4aed-80c2-08d6536df554
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;3:U7jiI0H1Rd+INN+LwTk6DlA4R7+mZioUKKFgQrNclHxB72xLweze/RrIe/WOKPyFbJoN22OZKJF7C9a3qHDEqv/eoxTuq74FaeOh77r7BNzAqLEGZEcBy6g/rF1thQgfb4twQINUYHh5zW7gvLPpp2GNHFRVVeZt2z/4Haeg7qEn/UxkDISlw8/gIzSrXI6m71sRFjT2A8oUh6yEGcNYfeG1H0aYfbb2XDuCOu38LZyh8TooEakdZa6hELvr9XXdN19r+mfck+vMIIqaePTSMA7TJiL30je+7SKMVdfc83AnzmOxKCOR4W4JYdsK5OIsho4UW5D/XdLpiPB3kbfZupEr78EvvnzNnQhRFj4UByw=;25:ZBR43m1nPa7O4ymbAIWxNy9bFzceu9PZbK2fN+KiwdmrHTUwaGJSCUgnNGLJksJOO5AsjO0N9YEh1UFcqisdztkERsnSXptuiqpgRyrCY2e77XvtTFe7RXAUXobdaAjAH97DuEwQ6vlN+Iv0xtGH0/gYC7w1LE9x0CR3BDlhK03+spSpH0E86/VIa4xojPWVDFLqUw2DVJE/bTpXmoR2RCUSnbeQFwt/dyiUUSQf2ChAMH/FUq38lZ2KO3Hs3+tqyXQ2L8sNF1MFogwOWelw/2ndwh4kVItoAOJujg0a8yQyI5WZK8CetfQKlUy4rRdSc9W9diskjNUUD/LkDO2KHQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4453:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;31:dlJfMoLo5x5LVnkERfxzAMVDO3//C9FYHAMWDEHE6BGHCEY8N6tPVABNAWxJe1pMAmjzLs4xXZ7qKFH3QUscSuEWxoqUDa4ay2vFrrhsJ/hNAKkSje/XqTUrmC7RJqUqGwi6GW8NtkrtYOyzYT3U494fbqMmN+ahJcUOwgUgyeG1LZ0vT8wIAApFCw85VSFK9IN3zWRCQbFmmD6E6AAvgKcwzNu8J1NxqGVqnRATUVs=;20:P8kCnwwVwElMB47A1/+X/4ZL3ZumI+WBtZOeDDkBPIHRg2Fx4L3M4gF+NCYXFkOFOyCrXBjkIdkpG1+h+o8q41dnp+nVJ68hKWHwdXMFzKC6X2EjPMv2fArS51tST+NDXKKJ/gtgkx6DxhzSooCn40KSZwXpP/nGhzWz10T4n0DZO50dZwgYM0P8BQK5m2gGPhp/sB4yb3VU8v1IYPdFXfoLOupKpGa26DmDDeew22fnYlyiSRuKBJqf6618izAihRNK0oC2D3PN70cRFG2+8UuS8+Dr0jjIPtNzzKo6IQqaWVPfALWe9tfk+4OZrpzShr1TsMbT81/yKnS3ZpnKnegf87hHo0vUZJE2XYu+iNfwDQogAZNIikZrxmBXbmRQoa2b6GnwFmXiL9CEtKkSf2wr81Lx2dsZm4YqbFMcOrsm6MBwfvmQtbckfD4Oh5KXVt/jfSC/yKUAIjHRuegtjmU/0isSKHhqxLW1oociuP3Mv+wx21sGTxQnSqq5ZunH
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4453246153F5D1FD74B400B2C9D70@BYAPR02MB4453.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231443)(944501410)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4453;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;4:+JooShXzGZaLZ4UFY0fXLWolFf1/MeUiTvyppfzyxgdfskfp+esQqogN9DZWzEqa045Z30dNZ6r193N9adTed5S6ThyRdgxRk4BvAV8P9PPk6NKTsI2aafp317F23cjW9unF1KrrtEMlDg5Ta5khwhiIkCH6YTr75IriAOBO/9hiL0+mk5F3wllAXbsvUJPAvPNvk04kQzWLS0iZAcCQAGWN7hHr2ysge+SbCFeS3UhV95oz85g94zvkV2w/sdfDO+d5y3qOaykVSqiKmCZFxw==
X-Forefront-PRVS: 086831DFB4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4453;23:ik/bLVDRwKSCBizISDzZdebemdBspk13+kyCoKhsm?=
 =?us-ascii?Q?BQhKgsTwTVrDfSS/jm8ov6V4AQv+PQB+eFLKRlYVPM+nQtKzVmfMY97UT+hF?=
 =?us-ascii?Q?WgKv82zRyz5nyoQIkU+iunlCw5sZvU5ZZ8W+6hlrotgN4v+SLgCahDL9UZvY?=
 =?us-ascii?Q?GaCsarOqOUG0BIVWzTaBrXFmxCE4e48/OSX9B4z99UgJGnySTzkRo0UbvMpq?=
 =?us-ascii?Q?obbsjwgwa37zMSnxQN06TeWM6kxu4JC7IZbGewLVNReNqTRJhazsd6FJntw5?=
 =?us-ascii?Q?A/HaneW57RNeu+8x4/6rNpdOvfMRa15XFAqMn89+K1OKyouw4Hz5vHNrda4n?=
 =?us-ascii?Q?ZL6Gxy7r3QgFiU7QBzeWUrMeJZOjXvjymmm8NUO0LAX7Hx3+ZNAnuGR3NBiv?=
 =?us-ascii?Q?LuGGCeNPA5dC6NjiAcg4rwTWWT1/0RIifz/atve2skKq3crP2zgBt0VpN+6O?=
 =?us-ascii?Q?Nm3KDiy/ewrv7Bi+MUh/3lx2UVqhYi+OaOLMp1T4D9QkTyW/NbA2cH2lE6sp?=
 =?us-ascii?Q?un25rP7m1Qq4pJsWL6l1G5xpDuGT/FLqldoVB5YA0wn5FXzGooVziX88qyKE?=
 =?us-ascii?Q?3XYd913je6Xo0+Pf9Vm0fZi0HYOX0QoYfnMkmDB9pEnQTT8PSpwOpbhuUUgq?=
 =?us-ascii?Q?LWIE9ip/YtVdUFLQQYLU+a/+EUW1HwGYOMLszoMo4Lj5sJNwtToKaFIrFR4C?=
 =?us-ascii?Q?rC+jEVu3JwbbBeY6vSJvV1kHkaxl0jEW3r2j3eTmLjRtE5DVFaAJ4+MKXKw+?=
 =?us-ascii?Q?EUF+UjzdBxVrzgLaYyb9krkh8lQ+Z3BjCvtk0j8twfoICMiah6NUcTNVq0t8?=
 =?us-ascii?Q?sS+RapfzEKVVOgkWR2FY0PoRXjiOTMuwfz8qRY2mAFKdMYnvmTEKs5x95eTU?=
 =?us-ascii?Q?RyYukF+pDjFSjeTaUc1f1QaVc5ieph6/DwOb9A841q4Ikoy5933YDqKbZggO?=
 =?us-ascii?Q?TVgdv3PTOgC4jfbVGI5emGnCy8KrOv8CuSonjMo+yYmdLpowL+4Jtw2MK8is?=
 =?us-ascii?Q?cWLVjXUU1uV4j7InnperBKcmz6SXWCHlWjlbCJRy2HxaZXZbI1CiJz3wZZhl?=
 =?us-ascii?Q?UqOxUWyZ/KC73jSl2f4gjpw/2qsAS5pDcwjOA0gd3PHl195oVxkcwQWIiPnR?=
 =?us-ascii?Q?sP1SN6JIr2XOjWogbPir0DhPVHdopNCURlNdgd734yOANMuN+7oC0W6oqhum?=
 =?us-ascii?Q?uVjvMRwNd1u0e2izkH8u/dhfbOacm8VtZxpHZPep9bp/1rx+5N/R5+IiujFq?=
 =?us-ascii?Q?mIwqkzoxgNlnDgEfxTAd+OsvAcgK4C53wiOKMyI?=
X-Microsoft-Antispam-Message-Info: xd66ZyV8aXSTpAkPdqI2Ej474NCTurX29/ERT/G1JCmO/FGxJeWknx89yMdqSMVlXsnJj+stoTbuwUbDRYZaJbEu28SLVyOd+/hwhJaoHSGTa03+KHP7udpmALmH5HidiIYrA+44v9iVbRFoj5AvD5RSYiQgPf2f8d4Qfoi88V07nJ8DUGDyVg3A3dwg+WPIr7ABBM6pe6XwIaa1N7krpgbPD9nzchfYsP9KNerHF9B07GHizvF+RTDUwi0Ko9OcGttziqiN6E74vUuXSJfqp0zhwP8ipcnj4gyB8GSa6FeepZG9bxHFICD3tTzPgOgrjrGu+Aez6iT4gcLc7CHS9V8eHKPwGIIO4uCW8qFoV98=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;6:H6BUXKY6FNcwWFPl5LM8X52NPb/CDBMXL5nTvhFpux8wFi8QkOsqWd/H1lwYW3BoMzfOez3M1p3K2fTEzw1GFk0L2S0vyEP44Q0tmLvmcmos6r0r6vjgXnXrBBedZiFloLBJJ2DKwo48QTEnSu64OAWZnMTSlx+eqvNZevkiyJAbyuzMacW5Zv5jeWV+IJtWGE0lasAqR0G0OrNL0YuyZwPht/F72bnrEZ7ZuJ9JIcPHICBXjc2YjS90y5TVZso/H95M5V3z6CjVuLiUNXD8FeWyB9vPkwwDrTGW3xbVp4mhLfW+m50+iyBLIh1WAWHCDrn4G/nq98+lg3JeLFlLZj3A+sF9Q/blNRYZI2OYfyYiLPM3xtAzRBlA8EhArhYshmfGAeh6RkgH5bmqpLTcAMdHUpfJsreWJkrdLepRFPMZa/hK+27YeNMwm3OPGy3/At1HpXrF4LAY3omPkqcGXg==;5:nfhkHhUsclxtUTaqPgoC9NeL9VVjgGj86EIki9PLweDm1//s5/ki15+iqXWtXEXxqhZTNdC2FXvMSJAZpOTZJgmDu5eponVmgIKW4z7qhteGd+dFn+NE5bgtx2XS9GOjyevFR6JOmlj4+gwy0g1ohvc/4j40ZQEbH0LlOXBI94Y=;7:JnlVqUOPwrCIQnESNGI4PWn9SgV9wuDvIPj5JdEKMlRBaZzQQoJV27/lHD0sxm6cqCaJYv9O3fDo8sn7cwgWBYjMdzL/gIxtfvzOM8lPLheOWATffKY2yXJ3Zwuyh9cD7dUWeZ9tZZmsmOO2ecs/uA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2018 07:08:24.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1118fb0-8930-4aed-80c2-08d6536df554
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When macb device is suspended and system is powered down, the clocks
are removed and hence macb should be closed gracefully and restored
upon resume. This patch does the same by switching off the net device,
suspending phy and performing necessary cleanup of interrupts and BDs.
Upon resume, all these are reinitialized again.

Reset of macb device is done only when GEM is not a wake device.
Even when gem is a wake device, tx queues can be stopped and ptp device
can be closed (tsu clock will be disabled in pm_runtime_suspend) as
wake event detection has no dependency on this.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
v2 changes:
Fixed parameter passed to phy calls.

 drivers/net/ethernet/cadence/macb_main.c | 38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4b85ad7..dcb0194 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4249,16 +4249,33 @@ static int __maybe_unused macb_suspend(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned long flags;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
-	netif_carrier_off(netdev);
-	netif_device_detach(netdev);
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
+		netif_device_detach(netdev);
+	} else {
+		netif_device_detach(netdev);
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_disable(&queue->napi);
+		phy_stop(netdev->phydev);
+		phy_suspend(netdev->phydev);
+		spin_lock_irqsave(&bp->lock, flags);
+		macb_reset_hw(bp);
+		spin_unlock_irqrestore(&bp->lock, flags);
 	}
 
+	netif_carrier_off(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_remove(netdev);
 	pm_runtime_force_suspend(dev);
 
 	return 0;
@@ -4268,6 +4285,11 @@ static int __maybe_unused macb_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
 	pm_runtime_force_resume(dev);
 
@@ -4275,9 +4297,21 @@ static int __maybe_unused macb_resume(struct device *dev)
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
+	} else {
+		macb_writel(bp, NCR, MACB_BIT(MPE));
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+			napi_enable(&queue->napi);
+		phy_resume(netdev->phydev);
+		phy_init_hw(netdev->phydev);
+		phy_start(netdev->phydev);
 	}
 
+	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_hw(bp);
+	macb_set_rx_mode(netdev);
 	netif_device_attach(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_init(netdev);
 
 	return 0;
 }
-- 
2.7.4

